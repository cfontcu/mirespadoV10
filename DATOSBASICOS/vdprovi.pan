# M�dulo   : VDPROVI.PAN
# Funci�n  : Mantenimiento de provincias
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE PROVINCIAS
Provincia                                      Ultima modificaci�n
_____ _40_____________________________________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDPROVI

#SELECT=DECODE(MOD(CODPROV,3),0,18,1,19,2,20,-1) CODOPEMODIF__COLOR,DECODE(MOD(CODPROV,2),0,1,0) FECMODIF__INVISIBLE;



PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODPAIS,NOUPDATE,VIRTUAL,OCULTO
CAMPO=CODPROV,NOUPDATE,TOOLTIP("C�digo de la provincia"),TITULO("Provincia")
CAMPO=DESPROV,TOOLTIP("Designaci�n de la provincia")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


