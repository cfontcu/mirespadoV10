# MOdulo   : VDIMPRESPOOLPDRE.FRM
# Función  : Spool de impresiones pdtes
#
# Creación : 20-05-2007
# Autor    : FGS
###########################################
# HistOrico de cambios:
BEGINBLOQUE=VDIMPRESPOOL.PAN
  PREREGISTRO=PRESEHIJO
  ORDERBY= SEQIMPRE DESC;
  PQUERY
  REGPAG=40
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDIMPRESPOOLDET.PAN
  PADRE=VDIMPRESPOOL.PAN
  PREQUERY=QUERYHIJO
  POSY=45
  POSX=1
ENDBLOQUE 
