#*****************************************************************
#M�dulo: VDORDRECCABFIN.PAN
#Funci�n : Finalizaci�n manual de las Ordenes de recepci�n y de sus l�neas.
#          Muestra las Ordenes que no est�n finalizadas o anuladas, y que no tienen una recepci�n pendientes de validaci�n.
#          En caso de querer finalizar una orden de recepci�n que no han finalizado todas sus l�neas, muestra un mensaje de aviso.
#
#Autor: ICC      
#Fecha: 14-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
FINALIZACION O ANULACION DE ORDENES DE RECEPCION
Orden de recepci�n   Divisi�n Tipo orden  Proveedor                              F. orden   F. creaci�n         F/A Estado                        Clave ext.       Ultima modificaci�n             
_20_________________   _20__   _10_______  _20______________ _60________________ �D-MM-Y.YYY �D-MM-Y.YYY _8______ _  ##### _30____________________ _50_____________ _32_______ �D-MM-Y.YYY _8______
|

TABLA=VDORDRECCAB
WHERE=STATUS NOT IN (VDST.FRCCFINALIZADA,VDST.FRCCANULADA)
  AND (CODORDREC, CODDIV) NOT IN (SELECT CODORDREC, CODDIV
                                    FROM VDRECEPCAB
                                   WHERE STATUS    = VDST.FRCCACTIVA);



PREUPDATE=FEJECUTA(FIF("CFANUL", FEJECUTA("!-CVALFANUL","HAY LINEAS QUE NO SE HAN RECEPCIONADO POR COMPLETO\n�DESEA CONTINUAR?", 
                                          "CUPDORDENLIN","ERROR AL MODIFICAR LAS LINEAS DE LA ORDEN :CODORDREC",
                                          "CUPDORDENCAB","ERROR AL MODIFICAR LA CABECERA DE LA ORDEN :CODORDREC",
                                          FCOMMIT,"")),"")

CAMPO=CODORDREC,NOUPDATE, TOOLTIP("C�digo de la orden de recepci�n"),TITULO("Orden de Recepci�n")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("C�digo de la divisi�n/compa��a.Divisi�n ':DESDIV'"),TITULO("Divisi�n"),WLONX=27
CAMPO=TIPORDREC,NOUPDATE,TOOLTIP("Es el tipo de orden de recepci�n. Existir� en la tabla VDTIPORDREC"),TITULO("Tipo Orden"),WLONX=24
CAMPO=CODPROVE,NOUPDATE,TOOLTIP("Es el C�digo del proveedor "),TITULO("Proveedor")
CAMPO=DESPROVE,NOUPDATE,TOOLTIP("Es la denominaci�n del proveedor ")
CAMPO=FECORDREC,NOUPDATE,TOOLTIP("Fecha original de la orden de recepci�n. Vendr� en la interfase"),TITULO("F. Orden")
CAMPO=FECCREADO,NOUPDATE,TOOLTIP("Es la fecha de creaci�n de la orden en el sistema "),TITULO("F. creaci�n")
CAMPO=HORACREADO,NOUPDATE,TOOLTIP("Es la hora de creaci�n de la orden en el sistema ")
CAMPO=FANUL,AUXILIAR,UPPER,TOOLTIP("Indicador de si se quiere finalizar o anular una orden de recepci�n, F(in), A(nular) o blanco, no se hace nada"),
            POSTCHANGE=FVERIFICA("FA ","EL CAMPO DEBE SER  F(in), A(nular) O Blanco"),TITULO("F/A"),WLONX=12
CAMPO=STATUS,NOUPDATE,TOOLTIP("Es el estado en el que se encuentra la orden de recepci�n"),
             POSTCHANGE=FEJECUTA("CDESSTATUS","ERROR, NO EXISTE EL ESTADO :STATUS"),TITULO("Estado")
CAMPO=DESSTATUS,NOENTER,AUXILIAR
CAMPO=CLAVEEXT,NOUPDATE,TOOLTIP("Clave externa que permite relacionar con otros sistemas no definidos"),TITULO("Clave Externa")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la Ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=VDEXTRA,OCULTO,"_255_",TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente")
CAMPO=CODCOMEN,OCULTO,"#########",TOOLTIP("")
CAMPO=DUMMY,AUXILIAR,OCULTO,"#"

CURSOR=CDESSTATUS SELECT DESSTATUS
                    FROM VDSTATUS
                   WHERE STATUS     = :STATUS
                     AND TIPOSTATUS = 'ORC';

CURSOR=CFANUL SELECT 1 DUMMY
                FROM DUAL
               WHERE :FANUL IN ('F','A');

CURSOR=CVALFANUL SELECT 1 DUMMY
                   FROM VDORDRECLIN
                  WHERE CODORDREC = :CODORDREC
                    AND CODDIV    = :CODDIV
                    AND STATUS    = VDST.FORLACTIVA
                    AND :FANUL    = 'F'
                    AND CANTIDAD-VDRECEP.CANTPDTE(:CODORDREC, CODART, :CODDIV, CODLOT, SECLINORD, 'N') > 0;

CURSOR=CUPDORDENLIN UPDATE VDORDRECLIN
                       SET STATUS = DECODE(:FANUL, 'A', VDST.FORLANULADA, 'F',VDST.FORLFINALIZADA),
                           CODOPEMODIF =VDUSER.GETUSER, FECMODIF = VD.FECHASYS, HORAMODIF = VD.HORASYS
                     WHERE CODORDREC = :CODORDREC
                       AND CODDIV    = :CODDIV
                       AND STATUS NOT IN (VDST.FORLANULADA, VDST.FORLFINALIZADA);

CURSOR=CUPDORDENCAB UPDATE VDORDRECCAB
                       SET STATUS = DECODE(:FANUL, 'A', VDST.FORCANULADA, 'F',VDST.FORCFINALIZADA),
                           CODOPEMODIF =VDUSER.GETUSER, FECMODIF = VD.FECHASYS, HORAMODIF = VD.HORASYS
                     WHERE CODORDREC = :CODORDREC
                       AND CODDIV    = :CODDIV;


