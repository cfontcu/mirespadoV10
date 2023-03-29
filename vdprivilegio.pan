# M�dulo   : VDPRIVILEGIO.PAN
# Funci�n  : Mantenimiento de privilegios
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE PRIVILEGIOS
Privilegio          Descripci�n                       Ultima modificaci�n
___________________ _255_____________________________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDPRIVILEGIO

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=PRIVILEGIO,NOUPDATE,TOOLTIP("Nombre del privilegio"),POSTCHANGE=FVALNOCERO("Debe introducir nombre del privilegio"),TITULO("Privilegio")
CAMPO=COMENTARIO,TOOLTIP("Descripci�n del privilegio"),POSTCHANGE=FVALNOCERO("Debe introducir descripci�n del privilegio"),TITULO("Descripci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


