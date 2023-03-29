# M�dulo   : VDIMPRESPOOLDET.PAN
# Funci�n  : Mantenimiento de Spool de Impresi�n V10. Detallado
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
DETALLES DE SPOOL DE IMPRESION V10

 Secuencia:  #L#######     Ordenador: _32___________   Tipo Imp.:  ____________   Impresora:  _______________
 
  Fichero: _256________________________________________  Documento: _256______________________________________________
 
 Par�metros: _1024_____________________________________________________________________________________________________
 
 Estado: @L@@@@ _30_________________   N�mero de Copias: #L###      Comentario: #L#######

 Inserci�n:  __32_________ �D-MM-Y.YY ________    Planificado: �D-MM-Y.YY ________ Vdextra: _255___________                 
 
 Ult. Modificaci�n: __32_________ �D-MM-Y.YY ________    Impreso:     �D-MM-Y.YY ________  
|

TABLA=VDIMPRESPOOL
ORDERBY=SEQIMPRE DESC;
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=SEQIMPRE,VIRTUAL,NOENTER,TOOLTIP("N�mero de Secuencia de la Impresi�n")
CAMPO=ORDENADOR,TOOLTIP("Ordenador desde el que se insert� en el spool")
CAMPO=TIPOIMPRE,TOOLTIP("Tipo de impresi�n")
CAMPO=CODIMPRE,TOOLTIP("Impresora V10 en la que se imprime")
CAMPO=FICHERO,TOOLTIP("Fichero al que se exporta la impresi�n")
CAMPO=DOCUMENTO,TOOLTIP("Documento que se imprime")
CAMPO=PARAMS,TOOLTIP("Par�metros de la impresi�n; valores a bidear, where, .... ")
CAMPO=STATUS,TOOLTIP("Estado de la impresi�n en la cola"),POSTCHANGE=FDESIGNACION("+CDESSTATUS","")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=NUMCOPIAS,TOOLTIP("N�mero de Copias a Imprimir")
CAMPO=CODCOMEN,NOENTER,TOOLTIP("C�digo del comentario asociado a la impresi�n spool")
CAMPO=CODOPEINS,NOENTER,TOOLTIP("Usuario que insert� la impresi�n en el spool")
CAMPO=FECINS,NOENTER,TOOLTIP("Fecha de insercci�n de la impresi�n en el spool")
CAMPO=HORAINS,NOENTER,TOOLTIP("Hora de insercci�n de la impresi�n en el spool")
CAMPO=FECPLANIF,TOOLTIP("Fecha prevista de impresi�n")
CAMPO=HORAPLANIF,TOOLTIP("Hora prevista de impresi�n")
CAMPO=VDEXTRA
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")
CAMPO=FECIMP,NOENTER,TOOLTIP("Fecha en la que fue impreso correctamente")
CAMPO=HORAIMP,NOENTER,TOOLTIP("Hora en la que fue impreso correctamente")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='ISP' AND STATUS=:STATUS;


