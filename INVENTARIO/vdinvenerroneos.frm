# MOdulo   : FINALIZAORDEREC.FRM
# Funci�n  : Finaliza Ordenes de recepci�n o l�neas de Ordenes de recepci�n
#
# Creaci�n : 13-02-2007
# Autor    : ICC
###########################################
# HistOrico de cambios:
#
BEGINBLOQUE=VDINVENERRONEOS.PAN
  PREREGISTRO=PRESEHIJO
	REGPAG=20
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDINVENERRONEOSLIN.PAN
  PADRE=VDINVENERRONEOS.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=20
  POSX=1
  POSY=26
ENDBLOQUE
