# M�dulo   : VDSEMAFORO.PAN
# Funci�n  : Mantenimiento de semaforos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO SEMAFOROS
C�digo         Designaci�n                       T E Sid       Serial    Programa                 Ordenador             Terminal               Ultima Modificaci�n
_20___________ _40______________________________ _ @ @L@@@@@@@ @L@@@@@@@ _64_____________________ _64__________________ _64___________________ _32________ �D-MM-Y.YY  ________
|
TABLA=VDSEMAFORO

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODSEMAFORO,NOUPDATE,TOOLTIP("C�digo del sem�foro"),TITULO("C�digo")
CAMPO=DESSEMAFORO,TOOLTIP("Designaci�n"),TITULO("Designaci�n")
CAMPO=TIPOSEMAFORO,TOOLTIP("Tipo del sem�foro puede ser a nivel (S)esi�n o a nivel (G)lobal"),POSTCHANGE=FENRANGO("S,G","Debe introducir S(esion) o G(lobal)"),TITULO("T")
CAMPO=ESTADO,TOOLTIP("Estado del sem�foro puede ser 0 libre o 1 ocupado"),TITULO("E")
CAMPO=SID,TOOLTIP("Sid de la sesion que ha tomado el semaforo"),TITULO("SID")
CAMPO=SERIAL,TOOLTIP("Serial de la sesion que ha tomado el semaforo"),TITULO("Serial")
CAMPO=PROGRAM,TOOLTIP("Programa que ha tomado el sem�foro"),TITULO("Programa")
CAMPO=MACHINE,TOOLTIP("Ordenador en el que se ejecuta el programa"),TITULO("Ordenador")
CAMPO=TERMINAL,TOOLTIP("Terminal desde el que se ejecuta el programa"),TITULO("Terminal")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




