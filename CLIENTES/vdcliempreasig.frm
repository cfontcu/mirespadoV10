#M�dulo: VDCLIDIVASIG.FRM
#Funcionalidad : Asignacion rapida de clientes a divisiones
#Autor: JMM
#Fecha: 06-10-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
BEGINBLOQUE=VDCLIENTESRES.PAN
  PREREGISTRO=PRESEHIJO
ENDBLOQUE
BEGINBLOQUE=VDCLIEMPREASIG.PAN
  PADRE=VDCLIENTESRES.PAN
  PREQUERY=QUERYHIJO
  POSX=10
  POSY=26
  REGPAG=14
  NODELETE
  NOINSERT
ENDBLOQUE