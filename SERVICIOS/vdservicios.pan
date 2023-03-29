# M�dulo   : VDERVICIOS.PAN
# Funci�n  : Mantenimiento de servicios
#
# Creaci�n : 12-07-2008
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE SERVICIOS
Servicio         Designaci�n               A Estado                  PID       SID       SERIAL    Ejecutable                  Entorno                        Path  V10                      Path                      Par�metros                Ultima modificaci�n
_32_____________ _32______________________ _ @L@@@ _40______________ @L@@@@@@@ @L@@@@@@@ @L@@@@@@@ _512_______________________ _512__________________________ _512__________________________ _512_____________________ _512_____________________ _32_________ �D-MM-Y.YY _8________
|


TABLA=VDSERVICIOS


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPOSERV,NOUPDATE,VIRTUAL,OCULTO
CAMPO=CODSERVICIO,NOUPDATE,TOOLTIP("C�digo del servicio"),TITULO("Servicio")
CAMPO=DESSERVICIO,TOOLTIP("Designaci�n del servicio"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del servicio"),TITULO("Designaci�n")
CAMPO=ACTIVO,TOOLTIP("Indica si el servicio se puede ejecutar"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),TITULO("Act."),WLONX=15
CAMPO=STATUS,TOOLTIP("Estado del servicio"),POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe el estado"),TITULO("Estado"),WLONX=20
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del estado del servicio"),TITULO("Descripci�n")
CAMPO=PID,TOOLTIP("El PID del programa"),TITULO("PID")
CAMPO=SID,TOOLTIP("SID de la conexion ORACLE"),TITULO("SID")
CAMPO=SERIAL,TOOLTIP("SERIAL de la conexi�n ORACLE"),TITULO("Serial")
CAMPO=EJECUTABLE,TOOLTIP("Ejecutable que implementa el servicio"),TITULO("Ejecutable"),MIXED
CAMPO=ENVSERVICIO,MIXED,TOOLTIP("Variables de entorno del servicio separadas por \n"),TITULO("Entorno"),MIXED
CAMPO=PATHV10SERVICIO,TOOLTIP("Path V10 particular del servicio, se a�ade al path gen�rico del grupo"),TITULO("Path V10")
CAMPO=PATHSERVICIO,TOOLTIP("Path particular del servicio, se a�ade al path gen�rico del grupo"),TITULO("Path")
CAMPO=PARAMSERVICIO,TOOLTIP("Par�metros particulares del servicio, se a�ade a los par�metros gen�ricos del grupo"),TITULO("Par�metros")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='SER' AND STATUS=:STATUS;




