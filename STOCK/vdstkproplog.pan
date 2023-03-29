# MOdulo   : VDSTKPROPLOG.PAN
# Funcion  : PROPIEDADES LOGISTICAS
#
# Creacion : 08-03-2022   
###########################################
# Historico de cambios:
PROPIEDADES LOGISTICOS DEL STOCK

 Codigo matricula: _18____________
 Orden stock:      @L@@@@@@@
 
 одддддддддддддддддддддддддд  DATOS LOGISTICOS  дддддддддддддддддддддддддк 
 Ё Largo unidad :#L####.#  Ancho unidad :#L####.#  Alto unidad :#L####.# Ё
 Ё Largo caja:     @L@@@@  Ancho caja:    @L@@@@@  Alto caja:    @L@@@@@ Ё   
 Ё                                                                       Ё
 Ё Embalaje por piso:  @L@@@                                             Ё
 юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
 
 Ultima modificacion:_32_________________________ ©D-MM-Y.YY ________

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
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizцЁ la ц╨ltima modificaciцЁn")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
