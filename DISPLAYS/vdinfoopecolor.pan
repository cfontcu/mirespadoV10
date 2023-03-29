# M�dulo   : VDINFOOPECOLOR.PAN
# Funci�n  : Mantenimiento de menus de picking
#
# Creaci�n : 21-05-2008
# Autor    : Maite Gonz�lez
###########################################
COLORES DE LOS OPERARIOS DE PICKING
Codope     Prioridad Color       Ultima modificaci�n
_10_______    @L@    _10________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDINFOOPECOLOR
ORDERBY=CODOPE,PRIORIDAD;

PROTECT("SUPERVISOR")

PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

CAMPO=CODOPE,NOUPDATE,TOOLTIP("Operario de picking"),TITULO("Operario")
CAMPO=PRIORIDAD,TOOLTIP("Prioridad del color"),TITULO("Prio")
CAMPO=COLOROPE,TOOLTIP("Color del operario"),TITULO("Color"),COMBOX("ROJO","VERDE","AMARILLO","AZUL","MORADO","CYAN","BLANCO")
CAMPO=CODOPEMODIF,NOENTER, TOOLTIP("Usuario que ha realizado la ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER, TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

