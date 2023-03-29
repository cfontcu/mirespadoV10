# M�dulo   : vdinterpendhost.pan
# Funci�n  : 
#
# Creaci�n : 26-03-2021
###########################################
# Hist�rico de cambios:
COMUNICACION DE INTERFACES
CLAVE                                          STATUS                           CODOPECREA             FECCREA    HORACREA CODOPEINTER            FECINTER   HORAINTER CODOPEMODIF            FECMODIF   HORAMODI  FICHERO
_255_________________________________________  @L@@@ _40_______________________ _32___________________ �D-MM-Y.YY ________ _32___________________ �D-MM-Y.YY ________  _32___________________ �D-MM-Y.YY ________  _255_________________________________________ 
|

TABLA=VDINTERPENDHOST
ORDERBY=FECCREA DESC,HORACREA DESC;
REGPAG=20
WLONX=1150

PREINSERT=FEJECUTA("CSELINS","ERROR EN CSELINS","CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")

#CAMPOS
CAMPO=CLAVEINTER,TITULO("Clave"),TOOLTIP("Clave �nica asociada al registro de interface")
CAMPO=STATUS,TITULO("Estado"),TOOLTIP("Estado del registro"),POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe el estado"),WLONX=20
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TITULO("Descripci�n")
CAMPO=CODOPECREA,TITULO("Creaci�n"),TOOLTIP("Operario que insert� el registro")
CAMPO=FECCREA,TITULO("Fecha"),TOOLTIP("Fecha de inserci�n del registro")
CAMPO=HORACREA,TITULO("Hora"),TOOLTIP("Hora de inserci�n del registro")
CAMPO=CODOPEINTER,TITULO("Procesa Interfaz"),TOOLTIP("Operario que procesa el interfaz")
CAMPO=FECINTER,TITULO("Fecha"),TOOLTIP("Fecha de proceso")
CAMPO=HORAINTER,TITULO("Hora"),TOOLTIP("Hora de proceso")
CAMPO=CODOPEMODIF,TITULO("Modificaci�n"),TOOLTIP("Operario que realiza la modificaci�n")
CAMPO=FECMODIF,TITULO("Fecha"),TOOLTIP("Fecha de la �ltima modificaci�n")
CAMPO=HORAMODIF,TITULO("Hora"),TOOLTIP("Hora de la �ltima modificacion")
CAMPO=NOMBREFICHINTER,TITULO("Nombre fichero"),TOOLTIP("Nombre del fichero de interface generado")

#CURSORES
CURSOR=CSELINS SELECT VDUSER.GETUSER CODOPECREA,VD.FECHASYS FECCREA,VD.HORASYS HORACREA FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='IHO' AND STATUS=:STATUS;


CONTEXTUAL=FEJECUTAFORM("VDPEDIDOS","S","CODPED=:CODPED AND ANOPED=:ANOPED AND SEQPED=:SEQPED AND CODDIV=:CODDIV")