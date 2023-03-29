# M�dulo   : VDUNIDADES.PAN
# Funci�n  : Mantenimiento de unidades de medida
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE UNIDADES
Unidad                                       Ultima modificaci�n
_________ _40_______________________________ _32________ �D-MM-Y.YY ________
|

TABLA=VDUNIDADES

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")




CAMPO=UNIDAD,NOUPDATE,TOOLTIP("Unidad de medida"),TITULO("Unidad")
CAMPO=DESUNIDAD,TOOLTIP("Designaci�n de la unidad de medida"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n de la unidad"),TITULO("Designaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


