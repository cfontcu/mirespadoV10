# MOdulo   : VDTIPORDREC.FRM
# Función  : Mantenimiento de tipos de Ordenes de recepción
#
# Creación : 12-02-2007
# Autor    : ICC
###########################################
# HistOrico de cambios:
BEGINBLOQUE=VDTIPORDRECCAB.PAN
  PREREGISTRO=PRESEHIJO
	REGPAG=16
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDTIPORDRECLIN.PAN
  PADRE=VDTIPORDRECCAB.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=30
  POSX=1
  POSY=22
ENDBLOQUE
