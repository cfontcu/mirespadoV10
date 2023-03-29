# M�dulo   : VDMENSAJES.PAN
# Funci�n  : Mantenimiento de mensajes
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE MENSAJES
Cod.   T Abreviada   Designaci�n                 Ultima modificaci�n
@L,@@@ _ ___________ _255_______________________ _32_________ �D-MM-Y.YY _8________
|

TABLA=VDMENSAJES



PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=MODULO,NOUPDATE,VIRTUAL,OCULTO
CAMPO=CODERROR,NOUPDATE,TOOLTIP("C�digo del error"),TITULO("Cod.")
CAMPO=TIPOERROR,TOOLTIP("Tipo de error I(nfo) W(arning) E(rror)"),TITULO("T")
CAMPO=ABREVIADA,TOOLTIP("Abreviatura del error"),TITULO("Abreviada")
CAMPO=MENSAJE,MIXED,TOOLTIP("Mensaje de error"),TITULO("Designaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


