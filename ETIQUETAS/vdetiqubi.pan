# M�dulo   : VDETIQUBI.PAN
# Funci�n  : Impresi�n de etiquetas de ubicaci�n. Selecci� de criterios
#
# Creaci�n : 05-08-2008
# Autor    : JCSR
###########################################
# Hist�rico de cambios:
SELECCI�N DE UBICACIONES PARA IMPRESI�N DE ETIQUETAS

  �������������������������������������������������������  
  �                                                     � 
  �                      Desde            Hasta         � 
  � Ubicaci�n            _20_________     _20_________  � 
  � Zona                 @L@              @L@           � 
  � Planta               @L@@             @L@@          � 
  � Pasillo              @L@@             @L@@          � 
  � Columna              @L@@             @L@@          � 
  � Altura               @L@@             @L@@          � 
  � Profundidad          @L@@             @L@@          � 
  � �rden de entrada     @L@@@@@@@        @L@@@@@@@     � 
  � �rden de salida      @L@@@@@@@        @L@@@@@@@     � 
  � �rden de movimiento  @L@@@@@@@        @L@@@@@@@     � 
  �                                                     � 
  ������������������������������������������������������� 
                                                            
  Art�culo _40___________________ 
           _100___________________________________ 

      �rea _20_______ 
           _40____________________________________ 
           
  N�mero de etiquetas que queremos imprimir @L@
      
|


TABLA=DUAL


CAMPO=CODUBIDESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaci�n desde la cual \nqueremos hacer la impresi�n de etiquetas")
CAMPO=CODUBIHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaci�n hasta la cual \nqueremos hacer la impresi�n de etiquetas")
CAMPO=ZONADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya zona se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")
CAMPO=ZONAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya zona se encuentra \nen un intervalo que termina \ncon el valor de este campo.")
CAMPO=PLANTADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya planta se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=PLANTAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya planta se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=PASILLODESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo pasillo se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=PASILLOHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo pasillo se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=COLUMNADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya columna se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=COLUMNAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya columna se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=ALTURADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya altura se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=ALTURAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya altura se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=PROFUNDIDADDESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya  profundidad se encuentra \nen un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=PROFUNDIDADHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuya profundidad se encuentra \nen un intervalo que termina \ncon el valor de este campo.")        
CAMPO=ORDENENTRADADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de entrada \nse encuentra en un intervalo que \ncomienza con el valor de este campo.")       
CAMPO=ORDENENTRADAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de entrada \nse encuentra en un intervalo que termina \ncon el valor de este campo.")        
CAMPO=ORDENSALIDADESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de salida \nse encuentra en un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=ORDENSALIDAHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de salida \nse encuentra en un intervalo que termina \ncon el valor de este campo.")        
CAMPO=ORDENMOVIMIENTODESDE,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de movimiento \nse encuentra en un intervalo que comienza \ncon el valor de este campo.")       
CAMPO=ORDENMOVIMIENTOHASTA,NOUPDATE, AUXILIAR, TOOLTIP("Ubicaciones cuyo �rden de movimiento \nse encuentra en un intervalo que termina \ncon el valor de este campo.")        
CAMPO=CODART,NOUPDATE, AUXILIAR,TOOLTIP("Art�culo asociado a la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELARTIC","No existe art�culo"),
                         CONTEXTUAL=FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","Selecci�n de art�culo","S")
CAMPO=DESART,NOUPDATE, AUXILIAR, TOOLTIP("")
CAMPO=CODAREAREQ,NOUPDATE, AUXILIAR,TOOLTIP("C�digo del �rea al que pertenece la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELAREA","No existe area"),
                         CONTEXTUAL=FEJECUTAFORM("VDSELAREA","N","","","CODAREA=:CODAREA","Selecci�n de area","S")
CAMPO=DESAREA,NOUPDATE, AUXILIAR, TOOLTIP("")
CAMPO=NUMETIQAIMPRIMIR,NOUPDATE, AUXILIAR, TOOLTIP("N�mero de etiquetas que vamos a querer imprimir")
                         

CURSOR=CSELAREA SELECT DESAREA FROM VDAREA WHERE CODAREA=:CODAREAREQ
                   UNION
                 SELECT '' DESAREA FROM DUAL WHERE :CODAREAREQ IS NULL;

CURSOR=CSELARTIC SELECT DESART FROM VDARTIC WHERE CODART=:CODART
                   UNION
                 SELECT '' DESART FROM DUAL WHERE :CODART IS NULL;



