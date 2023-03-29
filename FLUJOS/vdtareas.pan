#M�dulo: VDTAREAS.PAN
#Funci�n: Mantenimiento de tipos de flujos
#
# Creaci�n : 13-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TAREAS
 Tarea                           Descripci�n                    Clasificaci�n     Ultima modificaci�n 
 _32___________________________  _40___________________________ _15______________ _32_________ �D-MM-Y.YY ________ 
|

TABLA=VDTAREAS
ORDERBY=TAREA;


PREINSERT=FEJECUTA("CMODIF","")
PREUPDATE=FEJECUTA("CMODIF","")


CAMPO=TAREA,TOOLTIP("Tarea que trata el flujo\n:DESTAREA"),TITULO("Tarea")
CAMPO=DESTAREA,TOOLTIP("Descripci�n del flujo"),POSTCHANGE=FVALNOCERO("LA DESCRIPCION DE LA TAREA \nES OBLIGATORIA"),TITULO("Descripci�n")
CAMPO=CODCLASIF,COMBOX("CSELCLASE"),TOOLTIP("Clasificaci�n de art�culos a utilizar por el flujo"),POSTCHANGE=FDESIGNACION("CSELCLASIF","ERROR, NO EXISTE LA CLASIFICACION :CODCLASIF"),TITULO("Clasificaci�n")
CAMPO=CODOPEMODIF, NOENTER, TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF, NOENTER, TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=HORAMODIF, NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=DUMMY,AUXILIAR,OCULTO, "@"

CURSOR=CMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF 
                  FROM DUAL;

CURSOR=CSELCLASE SELECT CODCLASIF FROM VDCLASIFICACIONES;
 
CURSOR=CSELCLASIF SELECT 1 DUMMY FROM VDCLASIFICACIONES WHERE CODCLASIF = :CODCLASIF;

#CONTEXTUAL=FLEEMENU("IPFLUJOSPMA.ZOO")


