CAMPO=ROWIDTABLA,OCULTO,"_30"

BEGINBLOQUE=VDHISTORICO.PAN
  SELECT=SELECT CODOPE,TO_CHAR(FECOPERA,'DD-MM-YYYY HH24:MI:SS') FECOPERA,OPERACION,NCAMPO,ANTVALOR,NUEVALOR
          FROM TABLE(VDTRAZA.ARTIC(:ROWIDTABLA));
ENDBLOQUE