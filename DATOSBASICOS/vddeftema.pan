# M�dulo   : VDDEFTEMA.PAN
# Funci�n  : Mantenimiento de tema de colores
#
# Creaci�n : 05-11-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TEMAS 
 Tema                  Descripci�n                             Ultima modificaci�n                  
 _20_________________  _40____________________________________ _32____________ �D-MM-Y.YYY _8______ 
|
TABLA=VDDEFTEMA

#ORDERBY=TEMA;

ORDERBY = (SELECT  DECODE(VDDEFTEMA.TEMA,USU.TEMA,'A',VDDEFTEMA.TEMA) FROM VDUSUARIO USU WHERE CODOPE=VDUSER.GETUSER);

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=TEMA,TOOLTIP("Designacion del tema"),TITULO("Tema")
CAMPO=DESTEMA,TOOLTIP("Descripci�n del tema"),TITULO("Descripci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("C�digo del operador o proceso que realizar la operacion de modificacion"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la ultima modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la ultima modificacion")

TECLA=SF7,FEJECUTA(FCARGATEMA(":TEMA"),"",%FFAILURE," CAMBIO TEMA DEL FORM A :TEMA\n\n SALIR A MENU Y RECARGAR PANTALLA")
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

