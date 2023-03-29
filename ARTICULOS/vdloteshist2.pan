# M�dulo   : VDLOTESHIST2.PAN
# Funci�n  : Detalles del Hist�rico de cambios de propiedades de lotes
#
# Creaci�n : 01-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
DETALLES DEL HISTORICO DE CAMBIOS DE CALIFICACIONES DE LOTES
Art�culo: _40________________ _100___________________________
Lote:     _40________________          
                                                  C�digo Documento: #L#######
Caducidad de ________ a ________                  Insercci�n:       _32________ �D-MM-Y.YY  ________
Retest de    ________ a ________                  Mod/Acci�n Ins:   _32________________ _64___________________________
Bloqueos de  __________ a __________              Procesamiento:    �D-MM-Y.YY  ________
Estado       #L### _30_________________________   Mod/Acci�n Proc:  _32________________ _64___________________________

Extra: _255__________________________________________________  Ult. Modif: _32________ �D-MM-Y.YY  ________  
|

TABLA=VDLOTESHIST

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=SEQ,VIRTUAL,OCULTO
CAMPO=CODART,TOOLTIP("C�digo del art�culo"),NOUPDATE,POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo")
CAMPO=CODLOT,NOUPDATE,TOOLTIP("Lote")
CAMPO=CODDOCUMENTO,NOENTER,TOOLTIP("C�digo del documento que relacciona sus movtos")
CAMPO=CADUCIACTUAL,NOENTER,TOOLTIP("Caducidad Actual en formato AAAAMMDD")
CAMPO=CADUCINUEVO,TOOLTIP("Nueva Caducidad en formato AAAAMMDD")
CAMPO=CODOPEINS,NOENTER,TOOLTIP("Operario que insert� el registro")
CAMPO=FECINS,NOENTER,TOOLTIP("Fecha en la que se insert� el registro")
CAMPO=HORAINS,NOENTER,TOOLTIP("Hora en la que se insert� el registro")
CAMPO=RETESTACTUAL,NOENTER,TOOLTIP("Fecha Actual de retest del lote en formato AAAAMMDD")
CAMPO=RETESTNUEVO,TOOLTIP("Nueva Fecha de retest del lote en formato AAAAMMDD")
CAMPO=MODULOINS,NOENTER,TOOLTIP("M�dulo desde el que se insert� el registro")
CAMPO=ACCIONINS,NOENTER,TOOLTIP("Acci�n en la que se insert� el registro")
CAMPO=BLOQLOTEACTUAL,NOENTER,TOOLTIP("Bloqueos actuales del lote")
CAMPO=BLOQLOTENUEVO,TOOLTIP("Nuevos Bloqueos del lote")
CAMPO=FECFIN,NOENTER,TOOLTIP("Fecha en la que se proces� el registro")
CAMPO=HORAFIN,NOENTER,TOOLTIP("Hora en la que se proces� el registro")
CAMPO=STATUS,POSTCHANGE=FDESIGNACION("CSELSTATUS","ERROR EN CSELSTATUS"),TOOLTIP("Estado del cambio de propiedades del lote")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado")
CAMPO=MODULOFIN,NOENTER,TOOLTIP("M�dulo desde el que se proces� el registro")
CAMPO=ACCIONFIN,NOENTER,TOOLTIP("Acci�n desde la que se proces� el registro")
CAMPO=VDEXTRA,TOOLTIP("Informaci�n adiccional del usuario")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='LOH';



