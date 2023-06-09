# M�dulo   : VDASIUSUPRI.PAN
# Funci�n  : Asignaci�n de privilegios a un usuario
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
ASIGNACION PRIVILEGIOS A USUARIO
Privilegio           Ultima modificaci�n
____________________ _32_______ �D-MM-Y.YY _8________
|

TABLA=VDPRIVOPE


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODOPE,VIRTUAL,OCULTO
CAMPO=PRIVILEGIO,POSTCHANGE=FDESIGNACION("CSELPRI","No existe privilegio"),TOOLTIP("Privilegio del usuario"),
              CONTEXTUAL=FEJECUTAFORM("VDLISTAPRIV","N","","","PRIVILEGIO=:PRIVILEGIO","LISTA DE PRIVILEGIOS","S"),
              TITULO("Privilegio"),COMBOX("CLISTAPRIV")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CSELPRI SELECT :PRIVILEGIO FROM VDPRIVILEGIO WHERE PRIVILEGIO=:PRIVILEGIO;


