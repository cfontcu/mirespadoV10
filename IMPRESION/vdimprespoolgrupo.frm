# MOdulo   : VDIMPRESPOOLGRUPO
# Función  : Spool de impresiones pdtes por grupos de impresoras
#
# Creación : 20-05-2008
# Autor    : FGS
###########################################
# HistOrico de cambios:
BEGINBLOQUE=VDIMPREGRUPO.PAN
  PREREGISTRO=PRESEHIJO
  AQUERY
  REGPAG=7
  POSX=1
  POSY=1
ENDBLOQUE    
BEGINBLOQUE=VDIMPRESPOOL.PAN
  PADRE=VDIMPREGRUPO.PAN
  CAMPO=GRUPOIMPRE,AUXILIAR,VIRTUAL,OCULTO  
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  WHERE=STATUS<1000 And CODIMPRE in (Select CODIMPRE FROM VDIMPRESORAS WHERE GRUPOIMPRE=:GRUPOIMPRE);
  POSY=12
  POSX=1
  REGPAG=29
  ORDERBY=PRIORIDAD,SEQIMPRE;
  PQUERY
#TIMEOUT=QUERYAUTOM,1000
ENDBLOQUE  
BEGINBLOQUE=VDIMPRESPOOLDET.PAN
  PADRE=VDIMPRESPOOL.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  POSY=44
  POSX=1
ENDBLOQUE 

