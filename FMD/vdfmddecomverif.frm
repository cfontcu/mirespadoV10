#CAMPO=CODBULTO,AUXILIAR,OCULTO,"_40_"

BEGINBLOQUE=VDLEERBULTO.PAN
  PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=1

ENDBLOQUE

BEGINBLOQUE=VDFMDDECOMVERIF.PAN
  PADRE=VDLEERBULTO.PAN  
  PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=6 
  WLONX=840  
ENDBLOQUE

BEGINBLOQUE=VDFMDDECOMVERIF2.PAN
  PREREGISTRO=PRESEHIJO
  PADRE=VDFMDDECOMVERIF.PAN
  POSX=1
  POSY=11
  AQUERY
  WLONX=840
ENDBLOQUE

BEGINBLOQUE=VDFMDDECOMVERIF3.PAN  
  PADRE=VDFMDDECOMVERIF2.PAN
  POSX=82
  POSY=1
  AQUERY
ENDBLOQUE
