#Form de monitorización de bloqueos
BEGINBLOQUE=VDORABLOQUEOS1.PAN
  PREREGISTRO=PRESEHIJO
  NOUPDATE
  NOINSERT
  NODELETE
  POSX=1
  POSY=1
  REGPAG=22
  AQUERY
  TIMEOUT=QUERYAUTOM,3000
ENDBLOQUE
BEGINBLOQUE=VDORABLOQUEOS3.PAN
  PADRE=VDORABLOQUEOS1.PAN
  REGPAG=1
  POSX=1
  POSY=28
ENDBLOQUE
BEGINBLOQUE=VDORABLOQUEOS2.PAN
  PADRE=VDORABLOQUEOS1.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  NOUPDATE
  NOINSERT
  NODELETE
  POSX=1
  POSY=32
  REGPAG=10
ENDBLOQUE
BEGINBLOQUE=VDORABLOQUEOS4.PAN
  PADRE=VDORABLOQUEOS2.PAN
  REGPAG=1
  POSX=1
  POSY=46
ENDBLOQUE