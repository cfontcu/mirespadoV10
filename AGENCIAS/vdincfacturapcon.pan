# M�dulo   : VDINCFACTURAPCON.PAN
# Funci�n  : Consulta de tarifas por divisi�n
#
# Creaci�n : 01-10-2007
# Autor    : EAA
#############################################
CONDICIONES DE BUSQUEDA
 Division : ____    
 Tarifa   : _20_________________ 
 Agencia:   ___  
|
            
TABLA=DUAL
NOORAINS
NOQUERY
NOCOMMIT

REGPAG=1

CAMPO=BCODDIV,AUXILIAR
CAMPO=BCODTARIFA,AUXILIAR,TOOLTIP("C�digo de la tarifa")
CAMPO=BAGEN,AUXILIAR


TECLA=F2,FPULSATECLAS("F6","F2")


ONLINE=         {F2} Ejecutar Consulta                 {F5} Borrar pantalla                  {Esc} Salir;