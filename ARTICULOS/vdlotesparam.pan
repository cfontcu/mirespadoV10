# M�dulo   : VDLOTESPARAM.PAN
# Funci�n  : Configuraci�n de cambios de bloqueos de lotes
#
# Creaci�n : 01-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CONFIGURACION DE CAMBIOS DE CALIFICACIONES DE STOCK DE LOTES

Ord Clase                           Rango Div.     Rango Areas    Bloqueos                                  Patr�n     Concepto   Ultima modificaci�n
@L@ _______________ _______________ _1024_________ _1024_________ ____________________ ____________________ __________ __________ _32________ �D-MM-Y.YY  ________
|

TABLA=VDLOTESPARAM
ORDERBY=ORDEN;

PREINSERT=FEJECUTA("-CCLASIF","SOLO PUEDE HABER UNA CLASIFICACION PARA LA CONFIGURACION",
                   "CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("-CCLASIF","SOLO PUEDE HABER UNA CLASIFICACION PARA LA CONFIGURACION",
                   "CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=ORDEN,TOOLTIP("Orden de preferencia de los patrones"),TITULO("Ord"), WLONX=15
CAMPO=CODCLASIF,TOOLTIP("Clasificaci�n de los art�culos"),TITULO("Clase")
CAMPO=CODCLASE,TOOLTIP("Clase de los art�culos")
CAMPO=RANGODIV,TOOLTIP("Rango de Divisiones de los art�culos"),TITULO("Rango Div.")
CAMPO=RANGOAREA,TOOLTIP("Rango de �reas donde se encuentra el stock de los lotes de los articulos"),TITULO("Rango Areas")
CAMPO=PATRONBLOQORI,TOOLTIP("Patr�n de los bloqueos or�gen del cambio de bloqueos, a cumplir"),TITULO("Bloqueos"),
                     POSTCHANGE=FEJECUTA("CCHECKORILONG20","La longitud del patr�n de bloqueos origen debe ser de 20")
CAMPO=PATRONBLOQDEST,TOOLTIP("Patr�n de los bloqueos destino del cambio de bloqueos, a cumplir"),
                     POSTCHANGE=FEJECUTA("CCHECKDESTLONG20","La longitud del patr�n de bloqueos destino debe ser de 20")
CAMPO=PATRONBLOQUEOS,MIXED,TOOLTIP("Patr�n de propagaci�n de los cambios de bloqueos.\n N: en esa posici�n no se propagan\n S: se propaga en la posici�n si el valor actual coincide con el del lote\n F: siempre se propaga para esa posici�n\nEn minusculas solo se propagan los cambios si el indicador se modifica"),
                     POSTCHANGE=FEJECUTA("CCHECKVALORES","LOS VALORES POSIBLES SON N,S o F"),TITULO("Patr�n")
CAMPO=CODCONCE,TOOLTIP("Concepto de los movtos en la transformaci�n de bloqueos del stock"),TITULO("Concepto")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CCHECKORILONG20 SELECT :PATRONBLOQORI FROM DUAL WHERE LENGTH(:PATRONBLOQORI)=20;

CURSOR=CCHECKDESTLONG20 SELECT :PATRONBLOQDEST FROM DUAL WHERE LENGTH(:PATRONBLOQDEST)=20;


CURSOR=CCHECKVALORES SELECT :PATRONBLOQUEOS FROM DUAL WHERE VDART.VERIFPATRONPROP(UPPER(:PATRONBLOQUEOS))=1;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCLASIF SELECT :CODCLASIF FROM VDLOTESPARAM WHERE CODCLASIF!=NVL(:CODCLASIF,'-');



