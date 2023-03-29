#*****************************************************************
#M�dulo: VDRECCAB.PAN
#Funcionalidad : Mantenimiento de la cabecera de recepci�n
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
CABECERA DE RECEPCION

Codrecep     Tipo      Cod. Orden             Div.     Multi  Tipo conte Num  Fecha recepci�n      Estado           Alb. trans. Alb. prov. Clave ext Observaciones               Ultima modificaci�n             
_20_________ _10______ _20______ _20_________ _20_____ @L@@@@ _20_______ @L@@ �D-MM-Y.YYY _8______ ##### _30_______ _20________ _20_______ _50______ _60__________ _60__________ _32_________ �D-MM-Y.YY ________
|
TABLA=VDRECEPCAB
ORDERBY=TO_NUMBER(CODRECEP) DESC, CODDIV;


PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODRECEP,TOOLTIP("N�mero �nico y clave de recepci�n.Utiliza la secuencia VDSECRECEP"),NOUPDATE,TITULO("Cod. Recepci�n"),POSTCHANGE=FDESIGNACION("+CSELORDENCLI","")
CAMPO=TIPORDREC,NOUPDATE,TOOLTIP("Tipo de orden de recepci�n que debe existir en la tabla VDTIPORDREC "),TITULO("Tipo")
CAMPO=CODORDREC,NOUPDATE,TOOLTIP("C�digo de la orden de recepci�n. Si est� informado debe existir en VDCABORDREC"),TITULO("Cod. Orden")
CAMPO=ORDENCLI,AUXILIAR,NOUPDATE,TOOLTIP("C�digo de la orden de recepci�n. Si est� informado debe existir en VDCABORDREC"),TITULO("Cod. Orden")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("C�digo de la divisi�n/compa��a.Para permitir duplicidad de Ordenes en distintas divisiones = interfases"),TITULO("Actividad"),WLONX=25
CAMPO=NUMPALMULTI,TOOLTIP("Numero de palets multireferencia"),TITULO("Multi")
CAMPO=TIPOCONTENEDOR,TOOLTIP("Numero de palets multireferencia"),TITULO("Tipo conte")
CAMPO=NUMCONTE,TOOLTIP("Numero de contenedores"),TITULO("N.Conte")
CAMPO=FECRECEP,NOENTER,TOOLTIP("Fecha de la recepci�n"), NOUPDATE,TITULO("Fecha recepci�n")
CAMPO=HORARECEP,NOENTER,TOOLTIP("Hora de la recepci�n"), NOENTER
CAMPO=STATUS,NOUPDATE("IMPLANTADOR"),TOOLTIP("Es el estado en el que se encuentra la recepci�n"), POSTCHANGE=FEJECUTA("CSELDESSTATUS", "NO EXISTE EL ESTADO :STATUS"),TITULO("Estado"),WLONX=10
CAMPO=DESSTATUS,NOENTER,AUXILIAR,TITULO("")
CAMPO=CODALBTRAN,TOOLTIP("C�digo del albar�n del transportista"),TITULO("Albaran Tran."),WLONX=5
CAMPO=CODALBPROVE,TOOLTIP("Albar�n del proveedor"),TITULO("Albar�n Prov."),WLONX=20
CAMPO=VDEXTRA,AUXILIAR,TOOLTIP("Clave externa que permite relacionar con otros sistemas no definidos"),TITULO("Referencia"),WLONX=20
CAMPO=OBSERVACION1,TOOLTIP("Observaciones a la cabecera de recepci�n"),TITULO("Observaciones")
CAMPO=OBSERVACION2,TOOLTIP("M�s observaciones a la cabecera de recepci�n")
CAMPO=CODCOMEN,OCULTO,"#########",TOOLTIP("C�digo de comentario")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la Ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESSTATUS SELECT DESSTATUS
                       FROM VDSTATUS 
                      WHERE STATUS     = :STATUS
                        AND TIPOSTATUS = 'RCC';
                        
CURSOR=CSELORDENCLI SELECT CLAVEEXT ORDENCLI FROM VDORDRECCAB WHERE CODORDREC=:CODORDREC AND CODDIV=:CODDIV;                        
                        
TECLA=CF1,FEJECUTA(FIMPRIME("INFORME","$(VDRECEPDATOS)","CODDIV=:CODDIV;CODRECEP=:CODRECEP",""),":V10ERROR",FCOMMIT,"")
BOTON=B2,1050,80,50,50,"B2",fileprint.png,CF1,"Imprimir",INCLUDECSS="background-color: transparent;border-width:0px"
#fileprint.png
#miimprimir.png