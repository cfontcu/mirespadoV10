# M�dulo   : VDSCANLECT.PAN
# Funci�n  : Mantenimiento de lecturas de scanner
#
# Creaci�n : 21-05-2008
# Autor    : Maite Gonz�lez
###########################################
MANTENIMIENTO DE LECTURAS DE SCANNER
Texto                    Red   Scanner Secuencia Status  Ultima modificaci�n
_256____________________ @L@   @L@@@@@ @L,@@@@@@ @L@@    _32________ �D-MM-Y.YY ________
|

TABLA=VDSCANLECT

PROTECT("SUPERVISOR")

PREINSERT=FEJECUTA("CSELSEC","No encuentro secuencial",
                   "CSELMODIF","No puedo poner fecha/hora modificacion")
PREUPDATE=FEJECUTA("CSELMODIF","No puedo poner fecha/hora modificacion")

CAMPO=TEXTO,TOOLTIP("Texto le�do por el esc�ner"),TITULO("Texto")
CAMPO=REDSCAN,TOOLTIP("Red de esc�neres que realiza la lectura"),TITULO("Red"), WLONX=15
CAMPO=SCANNER,TOOLTIP("Esc�ner que realiza la lectura"),TITULO("Escaner"), WLONX=30
CAMPO=SEQACCION,NOUPDATE,TOOLTIP("Secuencial de la acci�n"),TITULO("Secuencia"), WLONX=35
CAMPO=STATUS,TOOLTIP("Estado de la lectura"),TITULO("Estado"), WLONX=20
CAMPO=CODOPEMODIF,NOENTER, TOOLTIP("Usuario que ha realizado la ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER, TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSEC SELECT VDSECSCANLECT.NEXTVAL SEQACCION,100 STATUS, DECODE(:REDSCAN,0,1,:REDSCAN) REDSCAN FROM DUAL;


