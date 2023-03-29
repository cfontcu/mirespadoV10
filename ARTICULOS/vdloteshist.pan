# M�dulo   : VDLOTESHIST.PAN
# Funci�n  : Hist�rico de cambios de propiedades de lotes
#
# Creaci�n : 01-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
HISTORICO DE CAMBIOS DE CALIFICACIONES DE LOTES

Seq.      Art�culo   Designaci�n           Lote       Caducidad         Retest            Bloqueos               St   Ultima modificaci�n
#L####### _40_______ _100_________________ _40_______ ________ ________ ________ ________ __________ __________ #L### _32________ �D-MM-Y.YY  ________
|
TABLA=VDLOTESHIST
ORDERBY=SEQ;

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=SEQ,NOENTER,TITULO("Seq.")
CAMPO=CODART,TOOLTIP("C�digo del art�culo"),NOUPDATE,POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo"),TITULO("Designaci�n")
CAMPO=CODLOT,NOUPDATE,TOOLTIP("Lote"),TITULO("Lote")
CAMPO=CADUCIACTUAL,NOENTER,TOOLTIP("Caducidad Actual en formato AAAAMMDD"),TITULO("Caducidad")
CAMPO=CADUCINUEVO,TOOLTIP("Nueva Caducidad en formato AAAAMMDD")
CAMPO=RETESTACTUAL,NOENTER,TOOLTIP("Fecha Actual de retest del lote en formato AAAAMMDD"),TITULO("Retest")
CAMPO=RETESTNUEVO,TOOLTIP("Nueva Fecha de retest del lote en formato AAAAMMDD")
CAMPO=BLOQLOTEACTUAL,NOENTER,TOOLTIP("Bloqueos actuales del lote"),TITULO("Bloqueos")
CAMPO=BLOQLOTENUEVO,TOOLTIP("Nuevos Bloqueos del lote")
CAMPO=STATUS,TOOLTIP("Estado del cambio de propiedades del lote"),TITULO("St")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;



