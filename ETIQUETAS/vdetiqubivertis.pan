# M�dulo   : VDETIQUBIVERTIS.PAN
# Funci�n  : Impresi�n de etiquetas de ubicaci�n en VERTIS
#
# Creaci�n : 30-03-2011
# Autor    : FPD 
###########################################
# Hist�rico de cambios:
SELECCION DE UBICACIONES PARA IMPRESION DE ETIQUETAS

  �������������������������������������������������������  
  �                                                     � 
  �                      Desde            Hasta         � 
  � Ubicaci�n            _20_________     _20_________  � 
  � Pasillo              @L@@             @L@@          � 
  � Columna              @L@@             @L@@          � 
  � Altura               @L@@             @L@@          � 
  �                                                     � 
  ������������������������������������������������������� 
                                                            
  N�mero de etiquetas que queremos imprimir @L@
      
|


TABLA=DUAL

CAMPO=CODUBIDESDE, AUXILIAR, TOOLTIP("Ubicaci�n desde la cual \nqueremos hacer la impresi�n de etiquetas")
CAMPO=CODUBIHASTA, AUXILIAR, TOOLTIP("Ubicaci�n hasta la cual \nqueremos hacer la impresi�n de etiquetas")
CAMPO=PASILLODESDE, AUXILIAR, TOOLTIP("Ubicaciones cuyo pasillo se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=PASILLOHASTA, AUXILIAR, TOOLTIP("Ubicaciones cuyo pasillo se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=COLUMNADESDE, AUXILIAR, TOOLTIP("Ubicaciones cuya columna se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=COLUMNAHASTA, AUXILIAR, TOOLTIP("Ubicaciones cuya columna se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=ALTURADESDE, AUXILIAR, TOOLTIP("Ubicaciones cuya altura se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=ALTURAHASTA, AUXILIAR, TOOLTIP("Ubicaciones cuya altura se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=NUMETIQAIMPRIMIR, AUXILIAR, TOOLTIP("N�mero de etiquetas que vamos a querer imprimir")

TECLA=SF6,FPULSATECLAS("F6","F2")
                         
BOTON=BUSCAR,250,260,120,120,"Buscar ubicaciones",vertis\confprotolin.png,SF6,"Buscar ubicaciones",INCLUDECSS="border-style:outset;background-color:transparent"
