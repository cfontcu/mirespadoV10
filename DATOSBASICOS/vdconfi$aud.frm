CAMPO=MITABLA,AUXILIAR,OCULTO,"_40"
CAMPO=ROWIDHIST,AUXILIAR,OCULTO,"_40"
BEGINBLOQUE=VDGEN$AUD.PAN
  PQUERY
  CAMPO=MITABLA,AUXILIAR,VIRTUAL,OCULTO
  PREREGISTRO=PRESEHIJO
ENDBLOQUE
BEGINBLOQUE=VDDIFAUD.PAN
  CAMPO=ROWIDAUX,AUXILIAR,VIRTUAL("MIROWID"),OCULTO
  PREQUERY=QUERYHIJO("CSELTABLA","")
  CURSOR=CSELTABLA SELECT 'VDCONFI' MITABLA FROM DUAL;
  PADRE=VDGEN$AUD.PAN
  WHERE=MIROWID=:ROWIDAUX;
  POSY=30
  REGPAG=20
ENDBLOQUE