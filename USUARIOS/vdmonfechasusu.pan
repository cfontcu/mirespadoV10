# Módulo   : VDMONFECHASUSU.PAN           
# Función  : Entrada de fechas 
#                                          
# Creación : 08-06-2022                    
###########################################
DETERMINAR FECHAS
 Usuario: _40__________   Correcto? _

 Desde: ¿D-MM-Y.YYY    Hasta: ¿D-MM-Y.YYY 

                                           |

NOQUERY

CAMPO=CODOPE,AUXILIAR,TOOLTIP("Codigo del usuario")
CAMPO=CORRECTO,AUXILIAR,TOOLTIP("Indica si el intento de login fue correcto")
CAMPO=FECDESDE,AUXILIAR,COMBOX("CALENDARIO")
CAMPO=FECHASTA,AUXILIAR,COMBOX("CALENDARIO")

TECLA=F2,FPULSATECLAS("F6","F2")
