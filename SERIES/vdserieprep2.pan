###################################################################
#M�dulo: VDSERIEPREP2.PAN
#Funcionalidad : Mantenimiento de series de preparaci�n
#Autor: FGS
#Fecha: 03-09-2008
###################################################################
# Hist�rico de cambios:
SERIE PREPARACION

 Zonas:
 _1000_____________________________________
 Creada:      _32_____ �D-MM-Y.YY ________
 Prevista              �D-MM-Y.YY
 Iniciada:    _32_____ �D-MM-Y.YY ________
 Cerrada:     _32_____ �D-MM-Y.YY ________
 Terminada:            �D-MM-Y.YY ________
 
 Ultima modificaci�n.: _32_____ �D-MM-Y.YY ________

|

TABLA=VDSERIEPREP

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")


CAMPO=CODSERIEPREP,VIRTUAL,OCULTO
CAMPO=RANGOZONASPICKINV,TOOLTIP("Rango de Zonas de Pciking Inverso donde se prepara, si es de picking inverso")
CAMPO=CODOPECREADA,NOENTER,TOOLTIP("Operario que cre� la serie")
CAMPO=FECCREADA,NOENTER,TOOLTIP("Fecha de creaci�n de la serie de preparaci�n")
CAMPO=HORACREADA,NOENTER,TOOLTIP("Hora de creaci�n de la serie de preparaci�n")
CAMPO=FECPREVISTA
CAMPO=CODOPELANZA,NOENTER,TOOLTIP("Operario que lanz� la serie")
CAMPO=FECLANZA,NOENTER,TOOLTIP("Fecha de lanzamiento de la serie de preparaci�n")
CAMPO=HORALANZA,NOENTER,TOOLTIP("Hora de lanzamiento de la serie de preparaci�n")
CAMPO=CODOPECIERRE,NOENTER
CAMPO=FECCIERRE,NOENTER,TOOLTIP("Fecha de lanzamiento de la serie de preparaci�n")
CAMPO=HORACIERRE,NOENTER,TOOLTIP("Hora de lanzamiento de la serie de preparaci�n")
CAMPO=FECTERMIN,NOENTER,TOOLTIP("Fecha de finalizaci�n de la serie de preparaci�n")
CAMPO=HORATERMIN,NOENTER,TOOLTIP("Hora de finalizaci�n de la serie de preparaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro.")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='SPR';

