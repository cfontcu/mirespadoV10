# MOdulo   : FINALIZAORDEREC.FRM
# Funci�n  : Finaliza Ordenes de recepci�n o l�neas de Ordenes de recepci�n
#
# Creaci�n : 13-02-2007
# Autor    : ICC
###########################################
# HistOrico de cambios:
#
BEGINBLOQUE=VDINVENCAB.PAN
  PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDINVENLIN.PAN
  PADRE=VDINVENCAB.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=25
  POSX=1
  POSY=24
ENDBLOQUE
