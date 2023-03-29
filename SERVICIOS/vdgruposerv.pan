# Modulo   : VDGRUPOSERV.PAN
# Función  : Mantenimiento de gupos de servicios
#
# Creación : 12-07-2008
# Autor    : EAA
###########################################
# Historico de cambios:
# (1) 26-08-2021 Añadir campos ORDENFORMS y ORDENVISU. Xavi
#
MANTENIMIENTO DE GRUPOS DE SERVICIOS
 Grupo                          Designación                    Ordenador            A OrF OrV Entorno                        Path V10                       Path                           Parámetros                Ultima modificación
 _32___________________________ _40___________________________ _32_________________ _ @@@ @@@ _512__________________________ _512__________________________ _512__________________________ _512_____________________ _32_________ ¿D-MM-Y.YY _8________
|

AQUERY

TABLA=VDGRUPOSERV

ORDERBY=ORDENFORMS ASC, CODGRUPOSERV;


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPOSERV,NOUPDATE,TOOLTIP("Código del grupo de servicios"),TITULO("Grupo")
CAMPO=DESGRUPOSERV,TOOLTIP("Designación del grupo de servicios"),POSTCHANGE=FVALNOCERO("Debe introducir la designación del grupo de servicios"),TITULO("Designación")
CAMPO=ORDENADOR,TOOLTIP("Ordenador en el que se ejecuta el grupom de servicios"),TITULO("Ordenador")
CAMPO=ARRANQUE,TOOLTIP("Tipo de arranque del grupo de servicios puede ser A(utomatico),M(anual) o P(lanificado)"),POSTCHANGE=FVERIFICA("AMP","Debe introducir A(utomático) , M(anual) o P(lanificado)"),TITULO("A")
CAMPO=ORDENFORMS,TOOLTIP("Orden en el que se visualizan los Grupos de Servicios en las pantalla del Forms"),TITULO("Orden F."),WLONX=40
CAMPO=ORDENVISU,TOOLTIP("Orden en el que se visualizan los Grupos de Servicios en el Visualizador de Servicios"),TITULO("Orden V."),WLONX=40
CAMPO=ENVGRUPO,MIXED,TOOLTIP("Variables de entorno globales del grupo separadas por \n"),TITULO("Entorno")
CAMPO=PATHV10GRUPO,TOOLTIP("Path V10 genérico de todos los servicios del grupo"),TITULO("Path V10")
CAMPO=PATHGRUPO,TOOLTIP("Path genérico de todos los servicios del grupo"),TITULO("Path")
CAMPO=PARAMGRUPO,TOOLTIP("Parámetros genérico de todos los servicios del grupo"),TITULO("Parámetros")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizO la última modificación"),TITULO("Ultima modificación")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



