# M�dulo   : VDMODULOS.PAN
# Funci�n  : Mantenimiento de modulos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE MODULOS
Cod. Designaci�n                       Abreviada   Ultima modificaci�n
@L@@ _40______________________________ ___________ _32_________ �D-MM-Y.YY _8________
|

TABLA=VDMODULOS


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=MODULO,NOUPDATE,TOOLTIP("C�digo del m�dulo"),TITULO("Cod.")
CAMPO=DESMODULO,TOOLTIP("Designaci�n del m�dulo"),TITULO("Designaci�n")
CAMPO=ABREVIADA,TOOLTIP("Abreviatura del modulo para generaci�n de mensajes"),TITULO("Abreviada")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


