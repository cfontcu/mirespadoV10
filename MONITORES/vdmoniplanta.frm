# MOdulo   : VDMONIPLANTA.FRM
# Función  : Monitor de planta
#
# Creación : 30-07-2008
# Autor    : JMM
###########################################
# HistOrico de cambios:
#
CAMPO=RANALM,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANDIV,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANAGE,AUXILIAR,OCULTO,"_1024_"
BEGINBLOQUE=VDFILTROALMA.PAN
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  PREREGISTRO=PRESEBLOQUE("VDMONIPLANTA1.PAN")
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=9
ENDBLOQUE
BEGINBLOQUE=VDFILTRODIV.PAN
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  PREREGISTRO=PRESEBLOQUE("VDMONIPLANTA1.PAN")
  POSX=40
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=9
ENDBLOQUE
BEGINBLOQUE=VDFILTROAGE.PAN
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  PREREGISTRO=PRESEBLOQUE("VDMONIPLANTA1.PAN")  
  POSX=80
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=9
ENDBLOQUE
BEGINBLOQUE=VDMONIPLANTA1.PAN
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  TIMEOUT=QUERYAUTOM, 6000
  PREREGISTRO=PRESEHIJO
  POSY=15
ENDBLOQUE