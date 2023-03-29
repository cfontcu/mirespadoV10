# M�dulo   : VDSECUEN.PAN
# Funci�n  : Mantenimiento de secuenciales
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE SECUENCIALES
Nombre               Valor     Inicio    M�ximo    Ultima modificaci�n
____________________ @L@@@@@@@ @L@@@@@@@ @L@@@@@@@ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDSECUEN


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=NOMBRESECUEN,NOUPDATE,TOOLTIP("Nombre del secuencial")
CAMPO=SECUENCIAL,TOOLTIP("Valor actual del secuencial")
CAMPO=PRIMSECUEN,TOOLTIP("Inicio de la secuencia")
CAMPO=MAXSECUEN,TOOLTIP("M�ximo valor de la secuencia")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


