###################################################################
#MOdulo: VDBULTOSPINVMA.PAN
#Funcionalidad : Mantenimiento de bultos
#Autor: Maite Gonz�lez      
#Fecha: 03-06-2008
###################################################################
# HistOrico de cambios:
BEGINBLOQUE=VDBULCABPINV.PAN
PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDBULCABPINV2.PAN
PREREGISTRO=PRESEHIJO
  PADRE=VDBULCABPINV.PAN
  POSX=82
  POSY=1
ENDBLOQUE
BEGINBLOQUE=VDBULLINPINV.PAN
  PADRE=VDBULCABPINV.PAN
  PREQUERY=QUERYHIJO
  POSX=1
  POSY=17
  REGPAG=20
ENDBLOQUE
#BEGINBLOQUE=VDESCADA.PAN
#  PADRE=VDBULCABPINV.PAN
#  PREQUERY=QUERYHIJO
#  POSX=1
#  POSY=41
#  REGPAG=1
#ENDBLOQUE
