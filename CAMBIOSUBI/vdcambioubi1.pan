# M�dulo   : VDCAMBIOUBI1.PAN
# Funci�n  : Selecci�n de Conetenedores
#
# Creaci�n : 27-02-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
SELECCION DE CONTENEDOR
                        
    Ubicaci�n: _20______________   Matr�cula _18_______________ _10________    
                                            Area _20___________ _40________________________________ 
    
    Tarea: _32_______
    Controles:  Flujo _  _20________________      Compatibilidad: _  _30___________________________
    
    Concepto Forzado:  __________ _40________________________________________
    Terminal:  __________ _40_________________________________
    Prioridad: @L@@@@@@
    
|

SOLOQUERY
NOQUERY

CURSOR=CSELPRIMMAT SELECT CODMAT FROM VDCONTE WHERE CODUBI=:CODUBIORI AND CODMAT=NVL(:CODMAT,CODMAT);
CURSOR=CSELTODMAT SELECT CODMAT FROM VDCONTE WHERE CODUBI=:CODUBIORI ;

##################################### CAMPOS #########################################

CAMPO=CODUBIORI,AUXILIAR,TOOLTIP("Ubicaci�n en la que se encuentra la matr�cula"),POSTCHANGE=FDESIGNACION("CSELPRIMMAT","UBICACION VACIA")
CAMPO=CODMAT,AUXILIAR,POSTCHANGE=FDESIGNACION("CSELCONTE","No existe matr�cula origen",                                             
                                              "+CMOVTOPEDTES","Matr�cula origen est� desplaz�ndose en un movimiento no finalizado",
                                              "CCARGADATOSDEF","",
                                              PRESEHIJO,""),                                              
                      TOOLTIP("Introduzca la matricula de contenedor a cambiar de ubicaci�n\nMay-F10 Buscar contenedores\nMay-F9  Buscar por stock"),
                      CONTEXTUAL=FEJECUTAFORM("VDCONTE","N","","","CODMAT=:CODMAT","SELECCION DE CONTENEDOR A CAMBIAR","S"),
                      COMBOX("CSELTODMAT")
CAMPO=TIPOCONTE,AUXILIAR,NOENTER    
CAMPO=CODAREAORI,AUXILIAR,NOENTER,TOOLTIP("Area en la que se encuentra la matricula")   
CAMPO=DESAREAORI,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del �rea en la que se encuentra la matricula")

CAMPO=TAREA,AUXILIAR,NOENTER,TOOLTIP("Tarea por la que se realiza el cambio de ubicaci�n")
CAMPO=CHEQUEAFLUJOS,AUXILIAR, TOOLTIP("Si vale (S)i, se chequea que haya flujo para el cambio de ubicaci�n, para la tarea seleccionada"),PROTECT("DIOS")
CAMPO=DESCHEQUEAFLUJOS,NOENTER,AUXILIAR
CAMPO=CHEQUEACOMPATIBILIDAD,AUXILIAR, TOOLTIP("Si vale (S)i, se chequea que haya compatibilidad entre la matricula y la ubicaci�n destino")
CAMPO=DESCHEQUEACOMPATIBILIDAD,NOENTER,AUXILIAR
CAMPO=CODCONCE,AUXILIAR,POSTCHANGE=FDESIGNACION("CSELDESCONCE","No existe el concepto :CODCONCE"),
                TOOLTIP("Concepto Forzado por el que se realiza el cambio de ubicaci�n\n"
                        "May-F10 B�squeda de conceptos"),
                CONTEXTUAL=FEJECUTAFORM("VDCONCEPTO","S","","","CODCONCE=:CODCONCE","SELECCION DE CONCEPTOS","S"),
                COMBOX("CLISTACONCE")
CAMPO=DESCONCE,AUXILIAR,NOENTER, TOOLTIP("Descripci�n del concepto FORZADO por el que se realiza el cambio de ubicaci�n")
CAMPO=CODRECURSO,AUXILIAR,POSTCHANGE=FEJECUTA("CVERIFTERMINAL","TERMINAL NO EXISTE O DESACTIVADO"),
                          TOOLTIP("Terminal que ejecutar� el cambio, es por Radio"),
                          CONTEXTUAL=FEJECUTAFORM("VDRECURSO","N","","ACTIVO='S'","CODRECURSO=:CODRECURSO","SELECCION DE TERMINALES","S"),
                          COMBOX("CLISTARECURSO")
CAMPO=DESRECURSO,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del Terminal")
CAMPO=PRIOMOV,AUXILIAR,TOOLTIP("Prioridad forzada al movto de cambio de ubicaci�n")
CAMPO=STATUS,AUXILIAR,OCULTO,"@L@@@@",TOOLTIP("Estado forzado con el que se crea el movto")
CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=MOVIBLE,AUXILIAR,OCULTO,"_"
CAMPO=CODUBIDEST,AUXILIAR,OCULTO,"_20__________"

#################################### CURSORES ################################

CURSOR=CLISTARECURSO SELECT CODRECURSO,DESRECURSO FROM VDRECURSO WHERE ACTIVO='S' ORDER BY CODRECURSO;

CURSOR=CLISTACONCE SELECT CODCONCE, DESCONCE,TIPOCONCE FROM VDCONCEPTO ORDER BY DECODE(CODCONCE,'CU',0,1),CODCONCE;

# estos par�metros se deben coger de CONFGIRACION
CURSOR=CCARGADATOSDEF SELECT 'S' CHEQUEAFLUJOS,'S' CHEQUEACOMPATIBILIDAD, 'REUBICAR' TAREA,
                             'CHEQUEAR FLUJO' DESCHEQUEAFLUJOS,
                             'CHEQUEAR COMPATIBILIDAD' DESCHEQUEACOMPATIBILIDAD,
                             VDST.FMOVPDTERECOGE STATUS,
                             100 PRIOMOV,
                             'CU' CODCONCE
                         FROM DUAL;

						 
CURSOR=CSELCONTE SELECT UBI.CODUBI CODUBIORI,TCO.TIPOCONTE,UBI.CODAREA CODAREAORI,ARE.DESAREA DESAREAORI, TCO.MOVIBLE
                    FROM VDUBICA UBI, VDCONTE CNT, VDAREA ARE, VDTIPOCONTE TCO 
                    WHERE CNT.CODMAT=:CODMAT AND
                          CNT.CODUBI=UBI.CODUBI AND
                          CNT.TIPOCONTE=TCO.TIPOCONTE AND
                          UBI.CODAREA=ARE.CODAREA;
                         


CURSOR=CMOVTOPEDTES SELECT :CODMAT FROM VDMOVIM WHERE CODMATORI=:CODMAT AND STATUS< VDST.FMOVACTUALIZA;

CURSOR=CVERIFTERMINAL SELECT DECODE(:CODRECURSO,NULL,NULL,DESRECURSO) DESRECURSO FROM VDRECURSO WHERE (CODRECURSO=:CODRECURSO AND ACTIVO='S') OR :CODRECURSO IS NULL;

CURSOR=CSELDESCONCE SELECT DECODE(:CODCONCE,NULL,NULL,DESCONCE) DESCONCE FROM VDCONCEPTO WHERE CODCONCE=:CODCONCE OR :CODCONCE IS NULL;

CURSOR=CCHEQUEACODFLUJO SELECT :CHEQUEAFLUJOS 
                              FROM DUAL 
                              WHERE 
                                  :CHEQUEAFLUJOS='S' OR
                                  (:CODCONCE IS NOT NULL AND 
                                  (NVL(:PRIOMOV,0)>0));

