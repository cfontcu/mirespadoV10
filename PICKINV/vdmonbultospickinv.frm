###################################################################
#MOdulo: VDMONBULTOSPICKINV.FRM
#Funcionalidad : Monitor de bultos de picking inverso
#Autor: FGS
#Fecha: 24-09-2008
###################################################################
# HistOrico de cambios:
CAMPO=RANSERIE,OCULTO,"_1000__"
BEGINBLOQUE=VDMONSERIEPICKINV1.PAN
  PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=1
  REGPAG=8
  AQUERY
  TIMEOUT=QUERYAUTOM,3000
ENDBLOQUE
BEGINBLOQUE=VDMONBULTOSPICKINV2.PAN
   PREREGISTRO=PRESEHIJO
   PADRE=VDMONSERIEPICKINV1.PAN
   NOENTER
   POSX=1
   REGPAG=8
   POSY=15
   TIMEOUT=QUERYAUTOM,3000
   AQUERY
ENDBLOQUE

BEGINBLOQUE=VDMONBULTOSPICKINV3.PAN
  PADRE=VDMONBULTOSPICKINV2.PAN
  PREREGISTRO=PRESEHIJO
  PREQUERY=QUERYHIJO
  POSX=1
  POSY=27
  REGPAG=7
ENDBLOQUE
BEGINBLOQUE=VDMONSERIEPICKINV3.PAN
  PADRE=VDMONSERIEPICKINV1.PAN
  PREREGISTRO=PRESEHIJO
  PREQUERY=QUERYHIJO
  POSX=55
  POSY=15
  REGPAG=7
  AQUERY
  TIMEOUT=QUERYAUTOM,3000
ENDBLOQUE
BEGINBLOQUE=VDMONBULTOSPICKINV4.PAN
  PADRE=VDMONBULTOSPICKINV3.PAN
  PREQUERY=QUERYHIJO
  POSX=1
  POSY=39
  REGPAG=5
ENDBLOQUE
#BEGINBLOQUE=VDESCADA.PAN
#  PADRE=VDMONBULTOSPICKINV3.PAN
#  PREQUERY=QUERYHIJO
#  POSX=1
#  POSY=48
#  REGPAG=1
#ENDBLOQUE

