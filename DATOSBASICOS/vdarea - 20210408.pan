# M�dulo   : VDAREA.PAN
# Funci�n  : Mantenimiento de �reas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE AREAS
C�digo           Designaci�n                    Orden  M.Lib Area de Ref. Ultima modificaci�n
_20____________  _40___________________________ @L@@@  @L@@@ _20_________ _32_________ �D-MM-Y.YY ________

|
TABLA=VDAREA
ORDERBY=CODAREA;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")



CAMPO=CODALM,VIRTUAL,OCULTO
CAMPO=CODAREA,NOUPDATE,TOOLTIP("C�digo del �rea"),TITULO("C�digo")
CAMPO=DESAREA,TOOLTIP("Designaci�n del �rea"),TITULO("Designaci�n")
CAMPO=ORDENAREA,TOOLTIP("Orden del �rea para calculo de distancias"),TITULO("Orden"),WLONX=20
CAMPO=MINLIBRE,TOOLTIP("Minimo de ubicaciones libres por pasillo"),TITULO("Ubi.Lib.Pas."),WLONX=35
CAMPO=CODAREAREF,TOOLTIP("Area de referencia para calcular distancia entre ubicaciones candidatas y preasignadas con el art�culo en dicha �rea al ubicar"),TITULO("Area de Ref.")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



