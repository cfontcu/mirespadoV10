# M�dulo   : VDGRUPOSERV.PAN
# Funci�n  : Mantenimiento de gupos de servicios
#
# Creaci�n : 12-07-2008
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE GRUPOS DE SERVICIOS
Grupo            Designaci�n               Ordenador       A Entorno                        Path V10                       Path                           Par�metros                Ultima modificaci�n
_32_____________ _40______________________ _32____________ _ _512__________________________ _512__________________________ _512__________________________ _512_____________________ _32_________ �D-MM-Y.YY _8________
|


TABLA=VDGRUPOSERV


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPOSERV,NOUPDATE,TOOLTIP("C�digo del grupo de servicios"),TITULO("Grupo")
CAMPO=DESGRUPOSERV,TOOLTIP("Designaci�n del grupo de servicios"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del grupo de servicios"),TITULO("Designaci�n")
CAMPO=ORDENADOR,TOOLTIP("Ordenador en el que se ejecuta el grupom de servicios"),TITULO("Ordenador")
CAMPO=ARRANQUE,TOOLTIP("Tipo de arranque del grupo de servicios puede ser A(utomatico),M(anual) o P(lanificado)"),POSTCHANGE=FVERIFICA("AMP","Debe introducir A(utom�tico) , M(anual) o P(lanificado)"),TITULO("Arranque"),WLONX=50
CAMPO=ENVGRUPO,MIXED,TOOLTIP("Variables de entorno globales del grupo separadas por \n"),TITULO("Entorno")
CAMPO=PATHV10GRUPO,TOOLTIP("Path V10 gen�rico de todos los servicios del grupo"),TITULO("Path V10")
CAMPO=PATHGRUPO,TOOLTIP("Path gen�rico de todos los servicios del grupo"),TITULO("Path")
CAMPO=PARAMGRUPO,TOOLTIP("Par�metros gen�rico de todos los servicios del grupo"),TITULO("Par�metros")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



