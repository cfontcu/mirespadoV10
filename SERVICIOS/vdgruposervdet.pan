# M�dulo   : VDGRUPOSERVDET.PAN
# Funci�n  : Mantenimiento de detalle de gupos de servicios
#
# Creaci�n : 25-08-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DETALLADO DE GRUPOS DE SERVICIOS
Grupo                    Designaci�n                              Ordenador                   Arranque 
_32_____________________ _40_____________________________________ _32________________________   _ 
Entorno: _512_____________________________________________________________________________________________________                        
Path V10: _512_____________________________________________________________________________________________________                           
Path:     _512_____________________________________________________________________________________________________                           
Par�metros: _512_____________________________________________________________________________________________________                
Ultima modificaci�n: _32_________ �D-MM-Y.YY _8________
|


TABLA=VDGRUPOSERV
#WPLEGADO

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPOSERV,VIRTUAL,NOENTER,TOOLTIP("C�digo del grupo de servicios")
CAMPO=DESGRUPOSERV,TOOLTIP("Designaci�n del grupo de servicios"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del grupo de servicios")
CAMPO=ORDENADOR,TOOLTIP("Ordenador en el que se ejecuta el grupom de servicios")
CAMPO=ARRANQUE,TOOLTIP("Tipo de arranque del grupo de servicios puede ser A(utomatico), M(anual) o P(lanificado)"),POSTCHANGE=FVERIFICA("AMP","Debe introducir A(utom�tico),M(anual) o P(lanificado)")
CAMPO=ENVGRUPO,MIXED,TOOLTIP("Variables de entorno globales del grupo separadas por \n")
CAMPO=PATHV10GRUPO,TOOLTIP("Path V10 gen�rico de todos los servicios del grupo")
CAMPO=PATHGRUPO,TOOLTIP("Path gen�rico de todos los servicios del grupo")
CAMPO=PARAMGRUPO,TOOLTIP("Par�metros gen�rico de todos los servicios del grupo"),MIXED
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;





