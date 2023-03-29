# M�dulo   : VDCAMBIOUBI1.PAN
# Funci�n  : Cambios de Ubicaci�n de Contenedores Completos
#
# Creaci�n : 27-02-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CAMBIO DE UBICACION DE CONTENEDORES COMPLETOS
                        
    Matr�cula _18_______________ _10_________  a Ubicaci�n _20___________     
                                                 Area _20___________  _40_________________________  
                                                    
    Tipo Ejecuci�n : _ ( (T)erminal o (P)apel )
              
|

SOLOQUERY
NOQUERY

##################################### CAMPOS #########################################

CAMPO=CODMAT,VIRTUAL,AUXILIAR,NOENTER,TOOLTIP("Introduzca la matricula de contenedor a cambiar de ubicaci�n\nMay-F10 Buscar contenedores\nMay-F9  Buscar por stock")
CAMPO=TIPOCONTE,VIRTUAL,AUXILIAR,NOENTER       
CAMPO=CODUBIDEST,AUXILIAR,POSTCHANGE=FDESIGNACION("CSELCODUBIDEST","No existe ubicaci�n destino",
                                              FIF("CCHECKCOMP",
                                                  FUBICOMPATIBLE(":CODMAT",":CODUBIDEST"),
                                                  FSUCCESS),"UBICACION DESTINO INCORRECTA\nNO ES COMPATIBLE CON EL CONTENEDOR :CODMAT"),
                          TOOLTIP("C�digo de la ubicaci�n destino del contenedor\nMay-F10 B�squeda de ubicaciones"),
                          CONTEXTUAL=FEJECUTAFORM("VDUBICA","N","UNIAGRUPAE='C'","","CODUBIDEST=:CODUBI","SELECCION DE UBICACION DESTINO","S")
CAMPO=CODAREADEST,AUXILIAR,NOENTER,TOOLTIP("Area en la que se que se encuentra la ubicaci�n destino")
CAMPO=DESAREADEST,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del �rea en el que se encuentra la ubicaci�n destino")
CAMPO=TIPOEJECUCION,AUXILIAR,POSTCHANGE=FEJECUTA(FVERIFICA(" PT"),"Modo de ejecuci�n incorrecto"),
                             TOOLTIP(" P. Ejecuci�n Mediante Papel\n T o Blanco. Ejecuci�n mediante Terminal")                             




CAMPO=MOVIBLE,VIRTUAL,OCULTO
CAMPO=CODCONCE,AUXILIAR,VIRTUAL,OCULTO
CAMPO=PRIOMOV,AUXILIAR,VIRTUAL,OCULTO
CAMPO=STATUS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODMOV,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TAREA,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CHEQUEAFLUJOS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CHEQUEACOMPATIBILIDAD,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODRECURSO,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODART,AUXILIAR,OCULTO,"_40_"


#################################### CURSORES ################################

CURSOR=CSELCODUBIDEST SELECT ARE.CODAREA CODAREADEST,ARE.DESAREA DESAREADEST  
                            FROM VDAREA ARE,VDUBICA UBI
                            WHERE UBI.CODUBI=:CODUBIDEST AND
                                  ARE.CODAREA=UBI.CODAREA;
                                  
CURSOR=CCHECKCOMP SELECT :CHEQUEACOMPATIBILIDAD FROM DUAL WHERE :CHEQUEACOMPATIBILIDAD='S';


CURSOR=CCHEQUEACODFLUJO SELECT :CHEQUEAFLUJOS 
                              FROM DUAL 
                              WHERE 
                                  :CHEQUEAFLUJOS='S' OR
                                  (:CODCONCE IS NOT NULL AND 
                                  (NVL(:PRIOMOV,0)>0));
                                  
CURSOR=CSELTIPOCONTE SELECT :MOVIBLE FROM DUAL WHERE :MOVIBLE='S';     

CURSOR=CSELTIPOEJECUCION SELECT NVL(:TIPOEJECUCION,'P') TIPOEJECUCION FROM DUAL WHERE NVL(:TIPOEJECUCION,'P') IN ('T','P');

CURSOR=CSELPAPEL SELECT :TIPOEJECUCION FROM DUAL WHERE :TIPOEJECUCION='P';

CURSOR=CSELART SELECT CODART FROM VDSTOCK WHERE CODMAT=:CODMAT AND ROWNUM=1;

CURSOR=CVERIFARTICENPU SELECT CODUBI CODUBIDEST 
                         FROM VDUBICA UBI 
                        WHERE UBI.CODUBI=:CODUBIDEST 
                          AND (UBI.CODAREA<>'PU' 
                               OR (UBI.CODAREA='PU' AND UBI.CODART=:CODART )  
                               OR (UBI.CODAREA='PU' AND NVL(UBI.CODART,'-')<>:CODART 
                                   AND  NVL((SELECT DISTINCT(STK.CODART) 
                                              FROM VDUBICA UBI2, VDSTOCK STK,VDCONTE CNT 
                                             WHERE UBI2.CODUBI=:CODUBIDEST AND UBI2.CODUBI=CNT.CODUBI  AND CNT.CODMAT=STK.CODMAT  AND ROWNUM=1),:CODART)=:CODART ) );
                                             
CURSOR=CCHECKDP SELECT :CODUBIDEST FROM VDUBICA
                 WHERE CODUBI=:CODUBIDEST AND (CODAREA!='DP' OR 0=(SELECT SUM(MOD(CANTIDAD,UNIEMB)) FROM VDSTOCK STK,VDCONTE CNT WHERE CNT.CODMAT=STK.CODMAT AND CNT.CODMAT=:CODMAT));
                                                              

################################### TECLAS #######################################

TECLA=F4,FEJECUTA("CSELTIPOEJECUCION","TIPO DE EJECUCION INCORRECTO",
                  "CSELART","La ubicaci�n origen no tiene stock",
                  "CVERIFARTICENPU","Verifique que la ubicaci�n de Area PU no contiene otro art�culo",
                  "CCHECKDP","NO SE PUEDEN MANDAR PICOS A DP",  
                  "CSELTIPOCONTE","Contenedor de tipo :TIPOCONTE no es movible",
                  "CCHEQUEACODFLUJO","\n SI NO SE CHEQUEA EL FLUJO\n\n EL CONCEPTO ES OBLIGATORIO Y\n\n LA PRIORIDAD DEL MOVTO MAYOR DE 0",
                  FCAMBIOUBICONTE(":CODMAT",":CODUBIDEST",":TAREA","CODMOV",":CHEQUEAFLUJOS",":CHEQUEACOMPATIBILIDAD",
                                ":CODCONCE",":PRIOMOV",":STATUS",":CODRECURSO"),"NO SE PUEDE EJECUTAR EL MOVIMIENTO\nNO ES COMPATIBLE CON EL FLUJO",
                  FIF("CSELPAPEL",FEJECUTA(FEJECUTAMOVSYNC("ACTSTKORIGEN","ACTSTKDESTINO",":CODMOV",":CODRECURSO"),"",
                                           FCOMMIT,"",
                                           FIMPRIME("INFORME","$(VDMOVIMIENTO)","CODMOV=:CODMOV",""),"ERROR IMPRIMIENDO LISTADO DE MOVIMIENTO :V10ERROR"),FSUCCESS),"ERROR MODO EJECUCION",
#                  %FFAILURE,"GENERADO MOVTO :CODMOV",
                  FCOMMIT,"",
                  +FBORRAFORM,"")

