# M�dulo   : VDASIPRIUSU.PAN
# Funci�n  : Asignaci�n de un privilegio a usuarios
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
ASIGNACION DE PRIVILEGIO A USUARIOS
Usuario    Ultima modificaci�n
__________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDPRIVOPE



PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=PRIVILEGIO,VIRTUAL,OCULTO
CAMPO=CODOPE,POSTCHANGE=FDESIGNACION("CSELOPE","No existe usuario"),TOOLTIP("Usuario con el privilegio"),
              COMBOX("CLISTAUSU"),TITULO("Usuario")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ulima Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CSELOPE SELECT :CODOPE FROM VDUSUARIO WHERE CODOPE=:CODOPE;

CURSOR=CLISTAUSU SELECT CODOPE,NOMBRE||' ' ||APELLIDO1||' '||APELLIDO2 FROM VDUSUARIO ORDER BY CODOPE;

