# M�dulo   : VDZONAGEOCAB.PAN
# Funci�n  : Mantenimiento de cabeceras de zonas geogr�ficas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ZONAS GEOGRAFICAS
Cod.Zona    Desc.Zona                           Extra                             Ultima modificaci�n
_10________ _40________________________________ _255_____________________________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDZONAGEOCAB

ORDERBY=CODZONAGEO;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODZONAGEO,NOUPDATE,TOOLTIP("C�digo de zona geogr�fica"),TITULO("Cod.Zona")
CAMPO=DESZONAGEO,TOOLTIP("Designaci�n de la zona geogr�fica"),TITULO("Desc. Zona Geogr�fica")
CAMPO=VDEXTRA,TOOLTIP("Campo extra libre para el implantador"),TITULO("Extra")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


