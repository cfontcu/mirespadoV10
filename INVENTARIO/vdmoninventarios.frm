# MOdulo   : VDMONINVENTARIOS.FRM
# Función  : MONITOR DE INVENTARIOS
#
# Creación : 04-02-2010
# Autor    : ICC
###########################################
# HistOrico de cambios:
#
BEGINBLOQUE=VDMONINVENCAB.PAN
  PREREGISTRO=PRESEHIJO
	REGPAG=4
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDMONINVENCABDATOS.PAN
  PADRE=VDMONINVENCAB.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=9
ENDBLOQUE
BEGINBLOQUE=VDMONINVENCONTEOSVAL.PAN
  PADRE=VDMONINVENCAB.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=25
	WREGPAG=24
  POSX=1
  POSY=15
ENDBLOQUE
BEGINBLOQUE=VDMONINVENCONTEOSANUL.PAN
  PADRE=VDMONINVENCAB.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=10
	WREGPAG=8
  POSX=1
  POSY=42
ENDBLOQUE