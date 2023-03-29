# M�dulo   : VDASIGRUUSU.PAN
# Funci�n  : Asignaci�n de un privilegio a usuarios
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
ASIGNACION USUARIOS A UN GRUPO
Usuario                          Ultima modificaci�n
__________ _40__________________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDGRUPOOPE



PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPO,VIRTUAL,OCULTO
CAMPO=CODOPE,POSTCHANGE=FDESIGNACION("CSELOPE","No existe usuario"),TOOLTIP("Usuario en el grupo"),
              COMBOX("CLISTAUSU"),TITULO("Usuario")
CAMPO=NOMBRE,AUXILIAR,NOENTER,TITULO("Nombre")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAUSU SELECT CODOPE, NOMBRE||' '||APELLIDO1||' '||APELLIDO2 FROM VDUSUARIO ORDER BY CODOPE;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CSELOPE SELECT :CODOPE, NOMBRE||' '||APELLIDO1 NOMBRE FROM VDUSUARIO WHERE CODOPE=:CODOPE;

