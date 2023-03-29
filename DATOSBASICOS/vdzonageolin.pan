# M�dulo   : VDZONAGEOLIN.PAN
# Funci�n  : Mantenimiento de l�neas de zonas geogr�ficas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
DEFINICION DE ZONAS GEOGRAFICAS
Cod.Pa�s  Designaci�n             Desde DP   Hasta DP   Extra                             Ultima modificaci�n
_5______ _40____________________ __________ __________ _255_____________________________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDZONAGEOLIN


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODZONAGEO,VIRTUAL,OCULTO
CAMPO=CODPAIS,POSTCHANGE=FDESIGNACION("CSELPAIS","No existe pa�s"),TOOLTIP("C�digo del pais"),TITULO("Cod.Pa�s"),COMBOX("CLISTAPAIS")
CAMPO=DESPAIS,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del pais"),TITULO("Pa�s")
CAMPO=DPDESDE,TOOLTIP("Distrito postal desde el que empieza la zona"),TITULO("Desde DP Hasta DP")
CAMPO=DPHASTA,TOOLTIP("Distrito postal hasta el que llega la zona")
CAMPO=VDEXTRA,TOOLTIP("Campo extra libre para el implantador"),TITULO("Extra")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPAIS SELECT CODPAIS,DESPAIS FROM VDPAIS ORDER BY CODPAIS;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELPAIS SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:CODPAIS;


