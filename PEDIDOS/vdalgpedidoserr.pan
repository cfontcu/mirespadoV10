###################################################################
#M�dulo: VDALGPEDIDOSERR.PAN
#Funcionalidad : Listado de algoritmos asociados a procesos de pedidos.
#Autor: JCSR
#Fecha: 28-08-2008
###################################################################
# Hist�rico de cambios:
ALGORITMOS ASOCIADOS A LOS PROCESOS QUE ACTUAN SOBRE LOS PEDIDOS
 Algoritmo         Descripci�n                                                    
 _40_____________  _256______________________________________________________________________________________________________ 
|


TABLA=VDALGORITMOS

CAMPO=NOMBREALG, NOENTER,TOOLTIP("Es el nombre del algoritmo"),TITULO("Algoritmo")
CAMPO=PROCESO, VIRTUAL, OCULTO
CAMPO=DESALG, NOENTER, TOOLTIP("Descripci�n del algoritmo"),TITULO("Descripci�n")
