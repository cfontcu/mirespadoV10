# M�dulo   : VDEANID.PAN
# Funci�n  : Mantenimiento identificadores EAN
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE IDENTIFICADORES EAN
Cod. L V Lon. Descripci�n                      Ultima modificaci�n
____ @ @ @L@@ _255____________________________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDEANID
ORDERBY=CODIDEAN;


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODIDEAN,NOUPDATE,TOOLTIP("Identificador EAN"),TITULO("Cod.")
CAMPO=LCODIDEAN,TOOLTIP("Longitud del identificador EAN"),TITULO("L")
CAMPO=VARIABLE,TOOLTIP("Indica si el campo es de longitud variable 0 Fijo 1 Variable 2 Siguiente digito indica longitud"),TITULO("V")
CAMPO=LONGITUD,TOOLTIP("Longitud del campo si es fija o longitud maxima si variable"),TITULO("Lon.")
CAMPO=OBSERV,TOOLTIP("Descripci�n del identificador EAN"),TITULO("Descripci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


