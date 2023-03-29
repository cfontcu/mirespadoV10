# M�dulo   : VDUBIBAJOURG3.PAN
# Funci�n  : Consulta de ubicaciones bajo urgente.
#
# Creaci�n : 11-07-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
UBICACIONES CON STOCK BAJO URGENTE SIN STOCK DISPONIBLE PARA RECARGAS
Ubicaci�n    Art�culo                                       M�nimo Urgente U.C. Stock U.C. Unids.              
_20_________ _40____________ _100__________________________ @L@@@@ @L@@@@  _    #L15#####  #L15######## _10__ 
|

TABLA=VDUBICA

WHERE=VDUBICA.CODART IS NOT NULL AND VDUBICA.CODART != '--------------------' AND VDUBICA.STOCK = 'S'
          AND VDUBICA.STKURG >= VDSTK.UBISTOCK(VDUBICA.CODUBI,VDUBICA.UNICAPAC) AND VDUBICA.RECARGAR IS NULL 
          AND NOT EXISTS (SELECT 1 FROM VDSTOCK STK, VDCONTE CNT, VDUBICA UBI2, VDFLUJOPARAM FLP
                           WHERE STK.CODART = VDUBICA.CODART AND VDCOMP.STK2UBI(STK.CODMAT,VDUBICA.CODUBI) = 0 AND 
                                 STK.CODMAT = CNT.CODMAT AND CNT.CODUBI = UBI2.CODUBI AND
                                 UBI2.CODAREA = FLP.CODAREAORI AND FLP.CODAREADEST = VDUBICA.CODAREA AND
                                 FLP.TAREA = 'RECARGAR')
        ORDER BY VDUBICA.CODUBI;

POSTQUERY=FEJECUTA("CSELSTKUBIUNICAPAC","ERROR OBTENIENDO STOCK DE LA UBICACION EN UNIDADES DE AGRUPACION",
                   "CSELSTKUBI","ERROR OBTENIENDO STOCK TOTAL DE LA UBICACION")

CAMPO=CODAREA,VIRTUAL,OCULTO
CAMPO=CODUBI,NOUPDATE,TOOLTIP("C�digo de ubicaci�n"),TITULO("Ubicaci�n")
CAMPO=CODART,NOUPDATE,TOOLTIP("Art�culo para el que esta preasiganada la ubicaci�n"),POSTCHANGE=FDESIGNACION("+CSELDESART",""),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n completa del art�culo")
CAMPO=STKMIN,NOENTER,TOOLTIP("Umbral m�nimo de stock en unidades de agrupaci�n"),TITULO("M�nimo"),WLONX=20
CAMPO=STKURG,NOENTER,TOOLTIP("Umbral urgente de stock en unidades de agrupaci�n"),TITULO("Urgente"),WLONX=20
CAMPO=UNICAPAC,NOENTER,TOOLTIP("Unidades de agrupaci�n en las que se mide el stock"),TITULO("U.C."),WLONX=16
CAMPO=STOCKUBIUNICAPAC,AUXILIAR,NOENTER,TOOLTIP("Stock actual m�s ordenado de la agrupaci�n en unidades de agrupaci�n"),TITULO("Stock U.C."),WLONX=25
CAMPO=STOCKUBIUNI,AUXILIAR,NOENTER,TOOLTIP("Stock actual m�s ordenado de la agrupaci�n en unidades"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),TITULO("Unidades")
CAMPO=UNIDADESHOST,AUXILIAR,NOENTER,TOOLTIP("Unidad de medida del stock")

CURSOR=CSELDESART SELECT DESART,UNIDADESHOST FROM VDARTIC WHERE CODART = :CODART;

CURSOR=CSELSTKUBIUNICAPAC SELECT  VDSTK.UBISTOCK(:CODUBI,:UNICAPAC) + VDUBI.UBIORDENADO(:CODUBI,:UNICAPAC) STOCKUBIUNICAPAC FROM DUAL;

CURSOR=CSELSTKUBI SELECT  VDSTK.UBISTOCK(:CODUBI,'U') + VDUBI.UBIORDENADO(:CODUBI,'U') STOCKUBIUNI FROM DUAL;

CONTEXTUAL=FEJECUTAFORM("VDUBICA","S","CODUBI=:CODUBI")
