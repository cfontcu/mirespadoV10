#*****************************************************************
#M�dulo: VDORDRECCAB.PAN
#Funci�n : Mantenimiento y consulta de las Ordenes de recepci�n
#Autor: ICC      
#Fecha: 13-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
ALTA DE ORDENES DE RECEPCION

 Division:  _20___    _40______________________________________
 Orden:     _20______________ C�digo de Ord. Cliente:_60_______
 Tipo:      _10_________  _40__________________________________
 Proveedor: _20_________  _60__________________________________
 Descargar: _20_________  _100_________________________________
 Fecha:     �D-MM-Y.YYY
 Creacion:  �D-MM-Y.YYY ________
 Estado:    @L@@@@ _40___________________________________
 Utima modificacion: _32__________ �D-MM-Y.YY ________

|
TABLA=VDORDRECCAB
WLONX=475
WHERE=STATUS<VDST.FORCACTIVA;
#PROTECT("IMPLANTADOR")

#NOINSERT,PROTECT("ORDENESRECEP")
#NODELETE,PROTECT("ORDENESRECEP")
#NOUPDATE,PROTECT("ORDENESRECEP")


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSELINSERT","ERROR AL OBTENER LOS DATOS DE INSERCION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")


CAMPO=CODDIV,TOOLTIP("C�digo de la divisi�n/compa��a.Divisi�n ':DESDIV'"),TITULO("Divisi�n"),WLONX=27,COMBOX("CSELDIV"),POSTCHANGE=FEJECUTA("+CSELDESDIV","")
CAMPO=DESDIV,AUXILIAR,NOENTER             
CAMPO=CODORDREC,TOOLTIP("C�digo de la orden de recepci�n"),TITULO("Orden de Recepci�n"),NOENTER  
CAMPO=CLAVEEXT,TOOLTIP("C�digo de Orden del cliente")
CAMPO=TIPORDREC,TOOLTIP("Es el tipo de orden de recepci�n. Existir� en la tabla VDTIPORDREC"),TITULO("Tipo orden"),WLONX=20,COMBOX("CSELTIPOREC"),POSTCHANGE=FEJECUTA("+CSELDESTIPO","")
CAMPO=DESORDREC,AUXILIAR,NOENTER
CAMPO=CODPROVE,TOOLTIP("Es el C�digo del proveedor "),TITULO("Proveedor"),COMBOX("CLISTAPROVE"),POSTCHANGE=FEJECUTA("CSELDESPROV","NO EXISTE PROVEEDOR")
CAMPO=DESPROVE,TOOLTIP("Es la denominaci�n del proveedor "),TITULO(""),NOENTER
CAMPO=CODAREARECEP,TOOLTIP("�rea donde se debe recepcionar la mercanc�a"),COMBOX("CSELAREA"), POSTCHANGE=FEJECUTA("CVERAREA","No existe el area seleccionado")
CAMPO=DESAREA,AUXILIAR,NOENTER
#CAMPO=SWTLICENCIA,TOOLTIP("Indica si la orden necesita licencia de exportacion"),CHECKBOX("N","S")
#CAMPO=LICENCIA,TOOLTIP("Codigo de la licencia de exportacion")
#CAMPO=REFCODPED,TOOLTIP("Indica el pedido al que corresponde si procede de un error"),POSTCHANGE=FDESIGNACION("CSELREFPED","Pedido no existe")
#CAMPO=DESCLIREF,TOOLTIP("Destinatario del pedido"),AUXILIAR,NOENTER
CAMPO=FECORDREC,TOOLTIP("Fecha original de la orden de recepci�n. Vendr� informado en la interfase"),TITULO("F.orden"),COMBOX("CALENDARIO")
CAMPO=FECCREADO,TOOLTIP("Es la fecha de creaci�n de la orden en el sistema "),TITULO("F. creaci�n")
CAMPO=HORACREADO,TOOLTIP("Es la hora de creaci�n de la orden en el sistema ")
CAMPO=STATUS,PROTECT("IMPLANTADOR"),TOOLTIP("Es el estado en el que se encuentra la orden de recepci�n"),TITULO("Estado"),POSTCHANGE=FDESIGNACION("+CSELSTATUS","No existe estado"),NOENTER
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,TOOLTIP("Usuario que ha realizado la Ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")

CURSOR=CSELDIV SELECT CODDIV, DESDIV FROM VDDIVIS;
CURSOR=CSELDESDIV SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;
CURSOR=CSELTIPOREC SELECT TIPORDREC, DESORDREC FROM VDTIPORDRECCAB;
CURSOR=CSELDESTIPO SELECT DESORDREC FROM VDTIPORDRECCAB WHERE  TIPORDREC=:TIPORDREC;
CURSOR=CSELREFPED SELECT DESCLIENTE DESCLIREF
                   FROM VDPEDIDOCAB
                   WHERE CODPED=:REFCODPED
                  UNION
                   SELECT '' FROM DUAL WHERE :REFCODPED IS NULL;						 
                               
CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='ORC';                         

CURSOR=CLISTAPROVE SELECT CODPROVE, DESPROVE, NIF FROM VDPROVEEDOR WHERE ROWNUM<2000 ORDER BY DESPROVE;                  

CURSOR=CSELDESPROV SELECT DESPROVE FROM VDPROVEEDOR WHERE CODPROVE=:CODPROVE;                   

CURSOR=CSELINSERT SELECT VDST.FORCPENRECEP STATUS, VD.FECHASYS FECCREADO, VD.HORASYS HORACREADO,
                         DECODE(:FECORDREC, 0, VD.FECHASYS,:FECORDREC) FECORDREC,
                         NVL(:CODORDREC,VDSECORDREC.NEXTVAL) CODORDREC
                    FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESSTATUS SELECT DESSTATUS
                       FROM VDSTATUS 
                      WHERE STATUS     = :STATUS
                        AND TIPOSTATUS = 'ORC';                        

CURSOR=CIMPREETIQ DECLARE
                   RET NUMBER;
                   MICODIMPRE VARCHAR2(100);
                  BEGIN
                    VDIMPRIME.IMPRIME('ETIQ','VDORDRECEP.ZPL;VDETIQUETAS.VSQ;CSELORDEN','CODORDREC='||:CODORDREC,1,MICODIMPRE,'',RET);    
                    COMMIT;
                  END;@                       
CURSOR=CSELAREA SELECT CODAREA, DESAREA FROM VDAREA WHERE CODAREA LIKE 'RECEP%';
CURSOR=CVERAREA SELECT DESAREA FROM VDAREA WHERE CODAREA=:CODAREARECEP;
TECLA=CF1,FEJECUTA(FIMPRIME("INFORME","VDRECEPCION.RPT","CODDIV=:CODDIV;CODORDREC=:CODORDREC",""),":V10ERROR",FCOMMIT,"")

TECLA=SF1,FEJECUTA("CIMPREETIQ",":V10ERROR")

BOTON=B3,490,45,50,50,"P",apply.png,SF3,"Genera PDF Albaran",INCLUDECSS="background-color: transparent;border-width:0px"

