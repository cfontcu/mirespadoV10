# MOdulo   : VDSTKPROPLOG.PAN
# Función  : PROPIEDADES LOGISTICAS
#
# Creación : 01-10-2007   
# Autor    : EAA
###########################################
# Historico de cambios:
PROPIEDADES LOGISTICOS

 Codigo matricula: _18____________
 Orden stock:      @L@@@@@@@
 
                              DATOS LOGISTICOS
							  
 Largo unidad :#L####.#  Ancho unidad :#L####.#  Alto unidad :#L####.#    
 Largo caja:   @L@@@@    Ancho caja:   @L@@@@@   Alto caja:   @L@@@@@    

 Embalaje por piso:  @L@@@ 
 
 Ultima modificacion:_32________¿D-MM-Y.YY ________
 


|
TABLA=VDSTOCK
WLONX=745

                   
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=CODMAT,NOENTER
CAMPO=ORDENSTK,NOENTER 
CAMPO=LARGOUNI,TOOLTIP("Largo de la unidad en mm.")
CAMPO=ANCHOUNI,TOOLTIP("Ancho de la unidad en mm.")
CAMPO=ALTOUNI,TOOLTIP("Alto de la unidad en mm.")
CAMPO=LARGOCAJC,TOOLTIP("Largo de la unidad en mm.")
CAMPO=ANCHOCAJC,TOOLTIP("Ancho de la unidad en mm.")
CAMPO=ALTOCAJC,TOOLTIP("Alto de la unidad en mm.")
CAMPO=EMBPISO,TOOLTIP("Embalaje por piso ")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizó la última modificación")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
