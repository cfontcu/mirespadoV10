###################################################################
#MOdulo: VDPEDIDOSERR.FRM
#Funcionalidad : Listado de pedidos en error, junto con los procesos y algoritmos asociados al estado de error del pedido.
#Autor: JCSR      
#Fecha: 28-08-2008
###################################################################
# HistOrico de cambios:
#BEGINBLOQUE=VDSTERRYPROC.PAN
#  PREREGISTRO=PRESEHIJO
#  POSX=35
#  POSY=1
#  NOINSERT
#  NODELETE
#  NOUPDATE
#  NOCOMMIT
#  AQUERY
#  REGPAG=8
#AYUDA=CONSULTA DE PEDIDOS CON ERROR
#ENDBLOQUE
#BEGINBLOQUE=VDALGPEDIDOSERR.PAN
#  PADRE=VDSTERRYPROC.PAN
#  PREQUERY=QUERYHIJO
#	NOENTER
#  POSX=1
#  POSY=13
#  REGPAG=4
#AYUDA=CONSULTA DE PEDIDOS CON ERROR
#ENDBLOQUE
BEGINBLOQUE=VDLISTAPEDIDOSERR.PAN
#  PADRE=VDSTERRYPROC.PAN
  PREQUERY=QUERYHIJO  
  PREREGISTRO=PRESEHIJO
  POSX=1
  POSY=5
  NOINSERT
  NODELETE
  REGPAG=22
AYUDA=CONSULTA DE PEDIDOS CON ERROR
ENDBLOQUE
BEGINBLOQUE=VDPEDLINERR.PAN
  PADRE=VDLISTAPEDIDOSERR.PAN
  PREQUERY=QUERYHIJO
  POSX=1
  POSY=30
  NOINSERT
  NODELETE
  NOUPDATE
  NOCOMMIT
  REGPAG=11
AYUDA=CONSULTA DE PEDIDOS CON ERROR
  ONLINE=     {F1} Ayuda   {F2} Consulta  {F5} Borrar pantalla 
          {May-F7} Documentaci�n   {May-F10} Men�   {Esc} Salir;
ENDBLOQUE  