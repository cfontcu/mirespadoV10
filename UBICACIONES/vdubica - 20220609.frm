BEGINBLOQUE=VDUBICA.PAN
  PREREGISTRO=PRESEHIJO
#CURSOR=CSELSTOCK SELECT VDSTK.UBISTOCK(:CODUBI, 'U',NULL, NULL,0, NULL,1) STOCKUNI,
#                        VDSTK.UBISTOCK(:CODUBI, 'E') STOCKEMBA,
#                        VDSTK.UBISTOCK(:CODUBI, 'C') STOCKCONTE,
#                        VDUBI.UBIORDENADO(:CODUBI,'U',1) ORDENUNI,
#                        VDUBI.UBIORDENADO(:CODUBI,'E') ORDENEMBA,
#                        VDUBI.UBIORDENADO(:CODUBI,'C') ORDENCONTE,
#                        VDUBI.UBIRESERVADO(:CODUBI,'U',NULL,NULL,1) RESUNI,
#                        VDUBI.UBIRESERVADO(:CODUBI,'E') RESEMBA,
#                        VDUBI.UBIRESERVADO(:CODUBI,'C') RESCONTE FROM DUAL;
ENDBLOQUE  
BEGINBLOQUE=VDUBICLAS.PAN
  PADRE=VDUBICA.PAN
  POSX=99
  REGPAG=16
ENDBLOQUE  
BEGINBLOQUE=VDCONTEUBI.PAN
  PADRE=VDUBICA.PAN
  PREREGISTRO=PRESEHIJO
  PREQUERY=QUERYHIJO
  POSY=21
  REGPAG=10
ENDBLOQUE
BEGINBLOQUE=VDSTOCK.PAN
  PREQUERY=QUERYHIJO
  PADRE=VDCONTEUBI.PAN
  POSY=35
  REGPAG=18
ENDBLOQUE  