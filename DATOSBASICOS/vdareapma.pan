# M�dulo   : VDAREA.PAN
# Funci�n  : Mantenimiento de �reas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE AREAS
Alm. C�digo            Designaci�n                    Orden  M.Lib Area de Ref.     Ultima modificaci�n
____ _20______________ _40___________________________ @L@@@  @L@@@ _20_____________ _32_________ �D-MM-Y.YY ________

|
TABLA=VDAREA
ORDERBY=CODAREA;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")



CAMPO=CODALM,NOUPDATE,TITULO("Alm")
CAMPO=CODAREA,NOUPDATE,TOOLTIP("C�digo del �rea"),TITULO("C�digo")
CAMPO=DESAREA,TOOLTIP("Designaci�n del �rea"),TITULO("Designaci�n")
CAMPO=ORDENAREA,TOOLTIP("Orden del �rea para calculo de distancias"),TITULO("Orden")
CAMPO=MINLIBRE,TOOLTIP("Minimo de ubicaciones libres por pasillo")
CAMPO=CODAREAREF,TOOLTIP("Area de Preferencia para calcular distancia entre ubic. candidatas y preasignadas con el art�culo en dicha �rea al ubicar"),TITULO("Area de Ref.")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CONTEXTUAL=FEJECUTAFORM("VDUBICA","S","CODAREA=:CODAREA")



