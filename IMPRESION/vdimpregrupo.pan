# M�dulo   : VDIMPREGRUPO.PAN
# Funci�n  : Mantenimiento de Grupos de Impresoras
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE GRUPOS DE IMPRESORAS
Grupo            Descripci�n                                                   Activo  Ult. Modificaci�n            
_______________  ____________________________________________________________    _     _32_________ �D-MM-Y.YY ________
|

TABLA=VDIMPREGRUPO
ORDERBY=GRUPOIMPRE;

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=GRUPOIMPRE,TOOLTIP("Nombre del Grupo de Impresoras"),TITULO("Grupo")
CAMPO=DESGRUPOIMPRE,TOOLTIP("Descripci�n del Grupo de Impresoras"),TITULO("Descripci�n")
CAMPO=ACTIVO,TOOLTIP("Si est� activo el grupo de impresoras"),POSTCHANGE=FEJECUTA(FVERIFICA("NS"),"CAMPO ACTIVO DEBE SER 'S' O 'N'"),TITULO("Activo"),WLONX=30,CHECKBOX("N","S")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



