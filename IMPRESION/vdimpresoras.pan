# M�dulo   : VDIMPRESORAS.PAN
# Funci�n  : Mantenimiento de Impresoras
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE IMPRESORAS
                                                                                               ���������������� Conexi�n �����������������
Ac Impresora       Descripci�n                   Spl Driver Fichero                        Tipo IP              Pto    Baud    Bts Par Stop  Ult. Modificaci�n            
 _ _______________ _60_________________________  _1_ _32___ _256__________________________ @@@@ _64____________ @L@@@  @L@@@@@ @@@ @@@ @@@@  _32_________ �D-MM-Y.YY _8________
|

TABLA=VDIMPRESORAS

ORDERBY=CODIMPRE;

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

WFRAME(600,0,342,0,"Tipo de Conexion","")
CAMPO=GRUPOIMPRE,VIRTUAL,OCULTO
CAMPO=ACTIVO,TOOLTIP("Si la impresora est� activa"),POSTCHANGE=FEJECUTA(FVERIFICA("NS"),"CAMPO ACTIVO DEBE SER 'S' O 'N'"),TITULO("Act"),WLONX=5
CAMPO=CODIMPRE,TOOLTIP("C�digo V10 de la impresora"),TITULO("Impresora")
CAMPO=DESIMPRE,TOOLTIP("Descripci�n de la Impresora"),TITULO("Descripci�n")
CAMPO=SPOOL,TOOLTIP("Imprimir en la impresora por servicio de Spool V10"),TITULO("Spool"),WLONX=10
CAMPO=DRIVER,TOOLTIP("Driver de las impresoras que no se imprime por Window. P.e. ZPL, SAT,. ..."),TITULO("Driver")
CAMPO=FICHERO,TOOLTIP("Fichero al que se env�a datos de impresiones de la impresora"),TITULO("Fichero"),MIXED
CAMPO=TIPOCONEX,TOOLTIP("Tipo de Conexi�n por la que se comunica con la impresora\n 0. sin conex\n 1. TCP cerrando socket\n 2. RS232\n 3. TCP manteniendo socket"),TITULO("Con"),WLONX=10
CAMPO=DIRIP,TOOLTIP("Direcci�n IP de la impresora para comunicaciones TCP"),TITULO("IP")
CAMPO=PUERTOCONEX,TOOLTIP("Puero TCP o 232 por el que se comunica con la impresora/etiquetadora"),TITULO("Pto")
CAMPO=BAUDIOS,TOOLTIP("Baudios en la comunic. 232"),TITULO("Baudios")
CAMPO=BITS,TOOLTIP("Bits por caracter enviado por 232"),TITULO("Bits")
CAMPO=PARIDAD,TOOLTIP("Paridad Par / Impar en  232"),TITULO("Par")
CAMPO=BITSTOP,TOOLTIP("N�mero de Bits de parada por car�cter en 232"),TITULO("Stop")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



