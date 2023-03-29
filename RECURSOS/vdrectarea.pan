# M�dulo   : VDRECTAREA.PAN
# Funci�n  : Mantenimiento de tareas de terminal de radio
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
ASIGNACION DE TAREAS A RECURSOS
Perfil              Designaci�n                              P.  A  Coment.   Ultima modificaci�n
___________________ _40_____________________________________ @L  _  @L@@@@@@@ _32_________ �D-MM-Y.YY _8________
|

TABLA=VDRECTAREA
PREQUERY=FEJECUTA("PATATA","")
ORDERBY=DECODE(ACTIVA,'S',0,1),PRIOTAREA;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODRECURSO,VIRTUAL,OCULTO
CAMPO=CODPERFIL,NOUPDATE,POSTCHANGE=FDESIGNACION("CSELPERFIL","No existe perfil"),COMBOX("CLISTATAREAS"),TITULO("Perfil")
CAMPO=DESPERFIL,AUXILIAR,NOENTER,TOOLTIP("Nombre del perfil")
CAMPO=PRIOTAREA,TOOLTIP("Prioridad de ejecucion de la tarea"),TITULO("P."),WLONX=10
CAMPO=ACTIVA,TOOLTIP("Indica si la tarea esta activa"),POSTCHANGE=FVERIFICA("SN","Debe introcucir S(i) o N(o)"),TITULO("A")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario"),TITULO("Codcomen"), WLONX=40
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTATAREAS SELECT CODPERFIL,DESPERFIL FROM VDPERFILTAREA ORDER BY CODPERFIL;
CURSOR=CSELPERFIL SELECT DESPERFIL FROM VDPERFILTAREA WHERE CODPERFIL=:CODPERFIL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=PATATA SELECT 'N' ACTIVA FROM DUAL;

CONTEXTUAL=FLEEMENU("VDRECTAREA.ZOO")



