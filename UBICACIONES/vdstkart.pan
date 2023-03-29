# M�dulo   : VDSTKART.PAN
# Funci�n  : Selecci�n de art�culo a consultar stock
#
# Creaci�n : 01-04-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
SELECCION DE ARTICULO
Codart       
_40_______________ _100______________________________
                                                    |

TABLA=VDARTIC

WHERE=EXISTS (SELECT 1 FROM VDSTOCK STK WHERE STK.CODART=VDARTIC.CODART);


CAMPO=CODART,TOOLTIP("C�digo del art�culo"),CONTEXTUAL=FEJECUTA(FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","SELECCION DE ARTICULOS","S"),"",
                                                                           FPULSATECLAS("F2")),TITULO("Art�culo")
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo"),TITULO("Designaci�n")

                        
TECLA=SF9,FEJECUTAFORM("VDSTKCALIFLOT.FRM","N","LOT.CODART=:CODART","","","DESGLOSE DE STOCK POR CALIFICACION DE ARTICULO :CODART","S")                        


