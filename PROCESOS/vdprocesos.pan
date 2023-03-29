######
# VDPROCESOS.PAN - Sistema de ventanas de configuraci�n de algoritmos.
#
# Prop�sito: Ventana para dar crear/modificar/borrar procesos.
#
#
# Autor	   : Jos� Carlos Santos
# Fecha    : 05-11-2007
####
# Modificaciones:
####
MANTENIMIENTO DE PROCESOS
                                                                  Max.
Proceso        Grupo     Funci�n          Librer�a         Interv. Ej.  Sem�foro   A Or Fec. Modif Hora modif. Usuario
_32___________ _20______ _32_____________ _32_____________ #L##### #L## _20_______ _ @@ �D-MM-Y.YY _32________ ________
                                                                                       |

TABLA=VDPROCESOS
ORDERBY=GRUPOPROC,ORDENACION;

PREINSERT=FEJECUTA("CSELMODIF","No se puede insertar fecha de modificaci�n.")
PREUPDATE=FEJECUTA("CSELMODIF","No se puede actualizar fecha de modificaci�n.")

CAMPO=PROCESO,UPPER,NOUPDATE, TOOLTIP("Nombre del proceso"),TITULO("Proceso")
CAMPO=GRUPOPROC,TITULO("Grupo")
CAMPO=FUNCIONPROC,MIXED, TOOLTIP("Nombre de la funci�n"),TITULO("Funci�n")
CAMPO=LIBPROCESO,UPPER, TOOLTIP("Librer�a en la que est� implementada la funci�n"),TITULO("Librer�a")
CAMPO=PERIODO,TOOLTIP("Tiempo en cent�simas de segundo entre ejecuci�n consecutivas, -1 sin periodo"),TITULO("Interv.")
CAMPO=EJECUCIONES,TOOLTIP("N�mero m�ximo de ejecuciones del proceso. 0 Inlimitadas"),TITULO("MaxEj"),WLONX=20
CAMPO=CODSEMAFORO,TOOLTIP("Sem�foro asociado al proceso"),TITULO("Sem�foro")
CAMPO=ACTIVO,TOOLTIP("Indica si el proceso esta activo"),TITULO("Act"),CHECKBOX("N","S"),WLONX=10
CAMPO=ORDENACION,UPPER, TOOLTIP ("Orden de aparici�n en la pantalla"),TITULO("Orden"),WLONX=25
CAMPO=PARAM,UPPER, OCULTO, "_256_"
CAMPO=FECMODIF, NOENTER,TITULO("Ultima modificaci�n")
CAMPO=HORAMODIF, NOENTER
CAMPO=CODOPEMODIF,UPPER, NOENTER

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CEJECUTAINMEDIATO UPDATE VDPROCESOS SET EJECUTAINMEDIATO='X' WHERE PROCESO=:PROCESO;

TECLA=SF2, FEJECUTA ("CEJECUTAINMEDIATO", "NO PUEDO LANZAR EL PROCESO",
                     FCOMMIT, "")




