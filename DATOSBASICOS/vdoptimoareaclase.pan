MINIMOS POR CLASE
Clasificacion
_20________ _40_______________ _ @L@@@@ @L@@@@ @L@@@@ _32_________ �D-MM-Y.YY ________
                                                                                        |
TABLA=VDOPTIMOAREACLASE

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=CODAREA,VIRTUAL,OCULTO
CAMPO=CODCLASIF,TITULO("Clasificacion")
CAMPO=CODCLASE,TITULO("Clase")
CAMPO=UNIRECARGA,TITULO("Uni.Rec."),WLONX=30
CAMPO=STKMAX,TITULO("Max")
CAMPO=STKMIN,TITULO("Min")
CAMPO=STKURG,TITULO("Urg")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modif.")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
