# M�dulo   : VDCAMBIOUBI2.PAN
# Funci�n  : Cambios de Ubicaci�n Parciales
#
# Creaci�n : 29-02-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CAMBIO DE UBICACION PARCIAL
 ���������������� L�nea de Stock  ���������������
 �                                              �
 �  Orden de Stock: @L@@                        �
 �  Art�culo: _40_____________________________  � 
 �  _100______________________________________  �      Mover #L15#####.### 
 �  Lote:     _40__________________             �    
 �  Bulto:    _____________________             �      Ubicaci�n: _20________________ a Matr�cula _18_________  _10_______  
 �  Cantidad: #L15##.### _10__                  �                                            Area _20_________  _40___________________________             
 �  Bloqueos: __________                        �                      
 �  U/Emb:    #L15##.##                         �      
 �  E/C:      @L@@@                             �      Ejecuci�n: _ (P)apel o (T)erminal 
 �  Marca Stock _60_________________________    �
 ������������������������������������������������
 

|
  
SOLOQUERY
NOQUERY

CURSOR=CSELPRIMMAT SELECT CODMAT CODMATDEST FROM VDCONTE WHERE CODUBI=:CODUBIDEST AND CODMAT=NVL(:CODMATDEST,CODMAT);
CURSOR=CSELTODMAT SELECT CODMAT CODMATDEST FROM VDCONTE WHERE CODUBI=:CODUBIDEST;

CAMPO=CODMAT,VIRTUAL,AUXILIAR,OCULTO
CAMPO=ORDENSTK,VIRTUAL,AUXILIAR,NOENTER
CAMPO=CODART,VIRTUAL,AUXILIAR,NOENTER,TOOLTIP(":DESART")
CAMPO=DESART,VIRTUAL,AUXILIAR,NOENTER
CAMPO=CANTAMOVER,AUXILIAR,TOOLTIP("Cantidad a mover de la l�nea de stock"),
                          CONVIERTE=FCONVIERTEARTFROMDB(":CODART");
                          FCONVIERTEART2DB(":CODART"),AUXILIAR,TOOLTIP("Es la cantidad que se desear cambiar de ubicaci�n")
CAMPO=CODLOT,VIRTUAL,AUXILIAR,NOENTER
CAMPO=BULTO,VIRTUAL,AUXILIAR,NOENTER
CAMPO=CODUBIDEST,AUXILIAR,TOOLTIP("C�digo de la ubicaci�n destino del movimiento parcial"),POSTCHANGE=FDESIGNACION("CSELPRIMMAT","UBICACION SIN MATRICULAS")
CAMPO=CODMATDEST,AUXILIAR,CONTEXTUAL=FEJECUTAFORM,POSTCHANGE=FDESIGNACION("CSELCONTE","No existe matr�cula origen",                                             
                                                                          "-CMOVTOPEDTES","Matr�cula Destino est� desplaz�ndose en un movimiento no finalizado",
                                                                          FIF("CCHECKCOMP",
                                                                            FUBICOMPATIBLE(":CODMAT",":CODUBIDEST",":CODART",":CODLOT",":UNIEMB",":BLOQUEOS","-1"),
                                                                            FSUCCESS),"NO SE PUEDE EJECUTAR EL MOVIMIENTO\nNO ES COMPATIBLE CON EL PRODUCTO"),
                          TOOLTIP("Introduzca la matricula destino del movimiento parcial\nMay-F10 Buscar contenedores\nMay-F9  Buscar por stock"),
                          CONTEXTUAL=FEJECUTAFORM("VDCONTE","N","","","CODMATDEST=:CODMAT","SELECCION DE MATRICULA DESTINO DE MOVTO PARCIAL","S"),
                          COMBOX("CSELTODMAT")
CAMPO=TIPOCONTE,NOENTER 
                          
 
CAMPO=CANTIDAD,VIRTUAL,AUXILIAR,NOENTER,TOOLTIP("Cantidad Existente en la L�nea de Stock"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=UNIDADESHOST,VIRTUAL,AUXILIAR,NOENTER,TOOLTIP("Unidades en que mide el stock el host")
CAMPO=CODAREADEST,AUXILIAR,NOENTER,TOOLTIP("Area en la que se que se encuentra la ubicaci�n destino")
CAMPO=DESAREADEST,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del �rea en el que se encuentra la ubicaci�n destino")
                     
CAMPO=BLOQUEOS,VIRTUAL,AUXILIAR,NOENTER,TOOLTIP("CALIFICACION DEL STOCK\n :DESBLOQUEOS ")
         
CAMPO=DESBLOQUEOS,AUXILIAR,OCULTO,"_400_"
CAMPO=UNIEMB,VIRTUAL,AUXILIAR,NOENTER,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=EMBCONT,VIRTUAL,AUXILIAR,NOENTER
CAMPO=TIPOEJECUCION,AUXILIAR,POSTCHANGE=FEJECUTA(FVERIFICA(" PT"),"Modo de ejecuci�n incorrecto"),
                             TOOLTIP(" P. Ejecuci�n Mediante Papel\n T o Blanco. Ejecuci�n mediante Terminal")       

CAMPO=MARCASTK,VIRTUAL,AUXILIAR,NOENTER
CAMPO=CODCONCE,AUXILIAR,VIRTUAL,OCULTO
CAMPO=PRIOMOV,AUXILIAR,VIRTUAL,OCULTO
CAMPO=STATUS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODMOV,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TAREA,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CHEQUEAFLUJOS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CHEQUEACOMPATIBILIDAD,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODRECURSO,AUXILIAR,VIRTUAL,OCULTO


#################################### CURSORES ################################


CURSOR=CCHEQUEACODFLUJO SELECT :CHEQUEAFLUJOS 
                              FROM DUAL 
                              WHERE 
                                  :CHEQUEAFLUJOS='S' OR
                                  (:CODCONCE IS NOT NULL AND 
                                  (NVL(:PRIOMOV,0)>0));

CURSOR=CSELCONTE SELECT UBI.CODUBI CODUBIDEST,ARE.CODAREA CODAREADEST, ARE.DESAREA DESAREADEST,TCO.TIPOCONTE
                    FROM VDUBICA UBI, VDCONTE CNT, VDAREA ARE, VDTIPOCONTE TCO 
                    WHERE CNT.CODMAT=:CODMATDEST AND
                          CNT.CODUBI=UBI.CODUBI AND
                          CNT.TIPOCONTE=TCO.TIPOCONTE AND
                          UBI.CODAREA=ARE.CODAREA;
                          
CURSOR=CMOVTOPEDTES SELECT :CODMATDEST FROM VDMOVIM WHERE CODMATORI=:CODMATDEST AND STATUS< VDST.FMOVACTUALIZA AND CODMATORI=CODMATDEST;

                          
CURSOR=CSELCODUBIDEST SELECT ARE.CODAREA CODAREADEST,ARE.DESAREA DESAREADEST  
                            FROM VDAREA ARE,VDUBICA UBI
                            WHERE UBI.CODUBI=:CODUBIDEST AND
                                  ARE.CODAREA=UBI.CODAREA;
                                  
CURSOR=CCHECKCOMP SELECT :CHEQUEACOMPATIBILIDAD FROM DUAL WHERE :CHEQUEACOMPATIBILIDAD='S';
                           
CURSOR=CCHECKCANTIDAD SELECT :CANTIDAD FROM DUAL WHERE :CANTAMOVER BETWEEN 0 AND :CANTIDAD;

CURSOR=CSELTIPOEJECUCION SELECT NVL(:TIPOEJECUCION,'P') TIPOEJECUCION FROM DUAL WHERE NVL(:TIPOEJECUCION,'P') IN ('T','P');

CURSOR=CSELPAPEL SELECT :TIPOEJECUCION FROM DUAL WHERE :TIPOEJECUCION='P';

CURSOR=CVERIFARTICENPU SELECT CODUBI CODUBIDEST 
                         FROM VDUBICA UBI 
                        WHERE UBI.CODUBI=:CODUBIDEST 
                          AND (UBI.CODAREA<>'PU' 
                               OR (UBI.CODAREA='PU' AND UBI.CODART=:CODART )  
                               OR (UBI.CODAREA='PU' AND NVL(UBI.CODART,'-')<>:CODART 
                                   AND  NVL((SELECT DISTINCT(STK.CODART) 
                                              FROM VDUBICA UBI2, VDSTOCK STK,VDCONTE CNT 
                                             WHERE UBI2.CODUBI=:CODUBIDEST AND UBI2.CODUBI=CNT.CODUBI  AND CNT.CODMAT=STK.CODMAT  AND ROWNUM=1),:CODART)=:CODART ) );
                                             
CURSOR=CCREAMOV BEGIN
                 VDUBI.CAMBIOUBISTK(:CODMAT,:CODUBIDEST,:CODMATDEST,:TAREA,:CODART,:CODLOT,:UNIEMB,:BLOQUEOS,:CANTAMOVER,:CODMOV,:CHEQUEAFLUJOS,
                                    :CHEQUEACOMPATIBILIDAD,:CODCONCE,:PRIOMOV,:STATUS,:CODRECURSO,:MARCASTK);
                END;@

################################### TECLAS #######################################

CURSOR=CCHECKDP SELECT :CODUBIDEST FROM VDUBICA
                 WHERE CODUBI=:CODUBIDEST AND (CODAREA!='DP' OR MOD(:CANTAMOVER,:UNIEMB)=0);

TECLA=F4,FEJECUTA("CSELTIPOEJECUCION","TIPO DE EJECUCION INCORRECTO",
                  "CVERIFARTICENPU","Verifique que la ubicaci�n de Area PU no contiene otro art�culo",
                  "CCHECKCANTIDAD","CANTIDAD DE DEBE ESTAR ENTRE 0 Y :CANTIDAD",
                  "CCHECKDP","NO SE PUEDEN MANDAR PICOS A DP",             
                  FIF("CCHECKCOMP",
                     FUBICOMPATIBLE(":CODMAT",":CODUBIDEST",":CODART",":CODLOT",":UNIEMB",":BLOQUEOS","-1"),
                     FSUCCESS),"NO SE PUEDE EJECUTAR EL MOVIMIENTO\nNO ES COMPATIBLE CON EL PRODUCTO",        
                  "CCHEQUEACODFLUJO","\n SI NO SE CHEQUEA EL FLUJO\n\n EL CONCEPTO ES OBLIGATORIO Y\n\n LA PRIORIDAD DEL MOVTO MAYOR DE 0",
                  "CCREAMOV","ERROR AL CREAR EL MOVIMIENTO",
                  FIF("CSELPAPEL",FEJECUTA(FEJECUTAMOVSYNC("ACTSTKORIGEN","ACTSTKDESTINO",":CODMOV",":CODRECURSO"),"",
                                           FCOMMIT,"",
                                           FIMPRIME("INFORME","$(VDMOVIMIENTO)","CODMOV=:CODMOV",""),"ERROR IMPRIMIENDO LISTADO DE MOVIMIENTO :V10ERROR")),"",                                               
#                  %FFAILURE,"GENERADO MOVTO :CODMOV",
                  FCOMMIT,"",
                  +FBORRAFORM,"")





