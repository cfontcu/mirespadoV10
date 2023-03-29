# M�dulo   : VDCALIF.PAN
# Funci�n  : Mantenimiento de calificaciones de stock
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CALIFICACIONES DE STOCK
I. Designaci�n                    Privilegios cambio           Extra                            Coment.  Ultima modificaci�n
@L _40___________________________ _1024_______________________ _255____________________________ @L@@@@@@ _32________ �D-MM-Y.YY  ________
|
TABLA=VDCALIF

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=INDICADOR,TOOLTIP("Posici�n del indicador"),NOUPDATE,TITULO("I")
CAMPO=DESINDICADOR,TOOLTIP("Designaci�n del indicador"),TITULO("Designaci�n")
CAMPO=PRIVCALIF,TOOLTIP("Privilegios necesarios para cambiar el indicador"),TITULO("Priv. cambio")
CAMPO=VDEXTRA,TOOLTIP("Campo extra para el implantador"),TITULO("Extra")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario del contenedor"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




