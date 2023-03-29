# MOdulo   : VDINTERFAZCARGA.FRM
# Función  : Mantenimiento de tipos de interfases
# INTERFACES CARGA DE INTERFAZ
# Creación : 11-11-2022
# Autor    : Carmen Fontcuberta
###########################################
# Historico de cambios:
#* ==================== TO_CHAR(SYSDATE,'YYYYMMDD')
##########################################
BEGINBLOQUE=VDINTERFAZCARGA.PAN
  PREREGISTRO=PRESEHIJO
	REGPAG=25
  POSX=1
  POSY=1
  WLONY=500
  WLONX=1600
ENDBLOQUE
BEGINBLOQUE=VDBLOB.PAN
  PADRE=VDINTERFAZCARGA.PAN
	PREQUERY=QUERYHIJO
	PREREGISTRO=PRESEHIJO
	REGPAG=30
  POSX=1
  POSY=26
  WREGPAG=25
  WLONY=500
  WLONX=1600
  ENDBLOQUE
  


