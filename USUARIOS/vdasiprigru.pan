# M�dulo   : VDASIPRIGRU.PAN
# Funci�n  : Asignaci�n de un privilegio a grupos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
ASIGNACION DE PRIVILEGIO A GRUPOS
Grupo                Ultima modificaci�n
____________________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDPRIVGRU


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=PRIVILEGIO,VIRTUAL,OCULTO
CAMPO=CODGRUPO,POSTCHANGE=FDESIGNACION("CSELGRU","No existe grupo"),TOOLTIP("Grupo con el privilegio"),
              COMBOX("CLISTAGRUPO"),TITULO("Grupo")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAGRUPO SELECT CODGRUPO,DESGRUPO FROM VDGRUPO ORDER BY CODGRUPO;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CSELGRU SELECT :CODGRUPO FROM VDGRUPO WHERE CODGRUPO=:CODGRUPO;


