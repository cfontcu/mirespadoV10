# MOdulo   : METINVENT.FRM
# Función  : Pantalla de inventarios para operario
#
# Creación : 06-03-2023
# Autor    : ICC
###########################################
# HistOrico de cambios:
#

POSTFORM=FEJECUTA("CCIERRAPUERTO","Error al cerrar puerto")

BEGINBLOQUE=METINVENT.PAN
  PREREGISTRO=PRESEHIJO
	REGPAG=10
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=METINVENT2.PAN
  PADRE=METINVENT.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  REGPAG=20
  POSX=1
  POSY=16
ENDBLOQUE
BEGINBLOQUE=METINVENT3.PAN
  PADRE=METINVENT.PAN
  PREREGISTRO=PRESEHIJO
  POSX=30
  POSY=40
ENDBLOQUE