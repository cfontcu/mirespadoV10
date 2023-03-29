# M�dulo   : VDCALIFVALOR.PAN
# Funci�n  : Mantenimiento de calificaciones de stock
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CALIFICACIONES DE STOCK
V Designaci�n                    Ultima modificaci�n
_ _40___________________________ _32________ �D-MM-Y.YY  ________
|
TABLA=VDCALIFVALOR

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=INDICADOR,VIRTUAL,OCULTO
CAMPO=VALORCALIF,TOOLTIP("Posici�n del indicador"),NOUPDATE,TITULO("V")
CAMPO=DESVALOR,TOOLTIP("Designaci�n del indicador"),TITULO("Designaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




