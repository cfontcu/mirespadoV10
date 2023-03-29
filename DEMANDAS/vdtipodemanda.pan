# M�dulo   : VDTIPODEMANDA.PAN
# Funci�n  : Mantenimiento de tipo de Demandas
#
# Creaci�n : 25-03-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TIPO DE DEMANDAS
 Tipo                                          Ult. Modificaci�n   
 __________ _40_______________________________ _32________ �D-MM-Y.YY  ________
|


TABLA=VDDEMANDATIPO

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=TIPODEMANDA,NOUPDATE,TOOLTIP("Tipo de Cabacera de Demanda"),TITULO("Tipo")
CAMPO=DESTIPO,TOOLTIP("Descripci�n del Tipo de Cabacera de Demanda")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




