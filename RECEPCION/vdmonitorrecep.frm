# MOdulo   : VDMONITORRECEP.FRM 
# Función  : Monitor de recepciones
#
# Creación : 12-02-2007
# Autor    : ICC
###########################################
# HistOrico de cambios:
BEGINBLOQUE=VDRECCAB.PAN
  PREREGISTRO=PRESEHIJO
  NODELETE
  NOINSERT
  REGPAG=12
  POSX=1
  POSY=1
  WHERE=CODRECEP IN (SELECT CODRECEP FROM VDRECEPLIN);
ENDBLOQUE
BEGINBLOQUE=VDRECLIN.PAN
  PADRE=VDRECCAB.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  REGPAG=10
  POSX=1
  POSY=19
  CAMPO=CODRECEP,VIRTUAL,OCULTO  
ENDBLOQUE
BEGINBLOQUE=VDRECSTKORI.PAN
  PADRE=VDRECCAB.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  REGPAG=8
  POSX=1  
  POSY=33
 ENDBLOQUE
BEGINBLOQUE=VDRECSTKACTUAL.PAN
  PADRE=VDRECCAB.PAN 
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  REGPAG=8
  POSX=76
  POSY=33
ENDBLOQUE

  
  