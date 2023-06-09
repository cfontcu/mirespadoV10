###################################################################
#Módulo: VDREGULARIZASTK.PAN
#Funcionalidad :  Pantalla de Regularizaciones de cantidades de Stock
#Autor: FGS      
#Fecha: 18-06-2008
###################################################################
# Histórico de cambios:
																										 
REGULARIZACIONES DE STOCK DESDE PANTALLAS

   Ubicación: _20___________ __________   
   Matrícula: __________________    
   Orden Stk: @@@@@@@@@ 
                                                                              
   Artículo:  _40___________________  _40_______________________________________
   
   Lote:      _40_________________  BloqLote: _________  Caducidad:  _________            
   
   Bloqueos:  __________  
   
   UnixEmb:   #L15#.##      EmbxCont:  #L###### 
   
   Numero de Serie: _60__________________________________________
   Cantidad:   #L######.### _10__    
   Reservado:  #L######.###          
   
   Regulariza: #L######  Concepto: _10________   Motivo FMD: _20_________
   
   Clave Externa: _40_____________________________________   
   Observ: 
   _1024______________________________________________________________________________________
   _1024______________________________________________________________________________________
   _1024______________________________________________________________________________________
   _1024______________________________________________________________________________________
|

TABLA=VDSTOCK


POSTQUERY=FEJECUTA("CSELDATOS","ERROR EN CSELDATOS")

CAMPO=CODUBI,AUXILIAR,NOENTER
CAMPO=CODAREA,AUXILIAR,NOENTER
CAMPO=CODMAT,NOENTER
CAMPO=ORDENSTK,NOENTER
CAMPO=CODART,NOENTER
CAMPO=DESART,AUXILIAR,NOENTER
CAMPO=CODLOT,NOENTER
CAMPO=BLOQLOTE,AUXILIAR,NOENTER
CAMPO=CADUCI,AUXILIAR,NOENTER
CAMPO=BLOQUEOS,NOENTER
CAMPO=UNIEMB,NOENTER,TOOLTIP("Unidades por embalaje en unidades host"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=EMBCONT,NOENTER
CAMPO=NUMEROSERIE
CAMPO=CANTIDAD,NOENTER,TOOLTIP("Cantidad en unidades host"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=UNIDADESHOST,AUXILIAR,NOENTER
CAMPO=RESERVADO,AUXILIAR,NOENTER
CAMPO=DIFF,AUXILIAR,TOOLTIP("Cantidad a Regularizar"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
																																																																																											 
CAMPO=CODCONCE,AUXILIAR,COMBOX("CLISTACONCE"),COMBOXREADONLY,POSTCHANGE=FEJECUTA("CPROPCONCEPTO","","+CMOTIVOFMD",""),CONTEXTUAL=FEJECUTAFORM("VDSELCONCEPTOFORM2","N","","CODART=:CODART CAMPO='CANTIDAD'","CODCONCE=:CODCONCEENT UBICODCONCE=:FUENTE CANTMAX=:CANTMAX PVPMAX=:PVLMAX MOTIVOFMD=:MOTIVOFMD","SELECCIÓN DE CONCEPTOS PARA REGULARIZACIONES DE CANTIDAD","S")
CAMPO=MOTIVOFMD,AUXILIAR,NOENTER
CAMPO=DATOSHOST,AUXILIAR
CAMPO=UBICODCONCE,AUXILIAR,OCULTO,"_12_________"
# OBSERVACIONES
CAMPO=OBSERV1,AUXILIAR
CAMPO=OBSERV2,AUXILIAR
CAMPO=OBSERV3,AUXILIAR
CAMPO=OBSERV4,AUXILIAR
CAMPO=OBSERV,AUXILIAR,OCULTO,"_4096______"
CAMPO=CANTMAX,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=PVPMAX,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=PVPDIFF,AUXILIAR,OCULTO,"@L@@@@@@@@@@@@@@@"
CAMPO=CODMOVOUT,AUXILIAR,OCULTO,"#L#######"
CAMPO=PUEDEREG,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=MSJERROR,AUXILIAR,OCULTO,"_1024____________"
CAMPO=RET,AUXILIAR,OCULTO,"@L"
CAMPO=DUMMY,AUXILIAR,OCULTO,"_"
CAMPO=SECUEN,AUXILIAR,NOUPDATE,OCULTO,"@@@@@@@@@"
CAMPO=TOTALLEIDOS,AUXILIAR,NOUPDATE,OCULTO,"@@@@@@"


#CURSORES

CURSOR=CPROPCONCEPTO SELECT  FUENTE UBICODCONCE,CANTMAX,PVLMAX PVPMAX FROM VDCONCEPTOFORM WHERE TIPOPROP='CANTIDAD' AND CODCONCEENT=:CODCONCE;

CURSOR=CMOTIVOFMD SELECT MOTIVOFMD FROM VDCONCEPTO WHERE CODCONCE=:CODCONCE;
																												  
																		   


CURSOR=CLISTACONCE SELECT CODCONCEENT,DESTIPOPROP,FUENTE FROM VDCONCEPTOFORM CFRM
                            WHERE  TIPOPROP='CANTIDAD' AND
                                   ACTIVO='S' AND
                                   VDUSER.TENGOPRIVILEGIO(PRIVILEGIOS)=1 AND
                                   (CODCLASE IS NULL OR EXISTS (SELECT 1 FROM VDCLASEARTIC CLA WHERE CLA.CODCLASIF=CFRM.CODCLASIF AND CLA.CODCLASE=CFRM.CODCLASE AND CLA.CODART=:CODART)) AND
                                   (CFRM.RANGODIV IS NULL OR EXISTS (SELECT 1 FROM VDARTIC ART WHERE ART.CODART=:CODART AND VD.CONTIENECAD(CFRM.RANGODIV,ART.CODDIV)>0))
                                   ORDER BY ORDEN;


CURSOR=CSELDATOS SELECT LOT.BLOQLOTE, LOT.CADUCI, UBI.CODUBI, UBI.CODAREA,ART.DESART, ART.UNIDADESHOST,
                        VDART.VD2HOST(VDSTK.STKRESERVADO(:CODMAT,:ORDENSTK),:CODART) RESERVADO
                   FROM VDLOTES LOT, VDARTIC ART, VDCONTE CNT, VDUBICA UBI
                     WHERE ART.CODART = :CODART AND
                           LOT.CODART = :CODART AND
                           LOT.CODLOT = :CODLOT AND
                           CNT.CODMAT = :CODMAT AND
                           CNT.CODUBI = UBI.CODUBI;
 
CURSOR=CMOVTOSHUERFANOS SELECT :RESERVADO FROM DUAL WHERE :RESERVADO>0;

CURSOR=CDAMEOBSERV SELECT TRIM(:OBSERV1) || ' ' || TRIM(:OBSERV2) || ' ' || TRIM(:OBSERV3) || ' ' || TRIM(:OBSERV4) OBSERV FROM DUAL;

CURSOR=CDIFFESCERO SELECT :DIFF FROM DUAL WHERE :DIFF = 0;

CURSOR=CCODCONCENULO SELECT :CODCONCE FROM DUAL WHERE :CODCONCE IS NULL;

CURSOR=CSUPERACANTMAX SELECT :CANTMAX FROM DUAL WHERE :CANTMAX>0 AND ABS(:DIFF)>VDART.HOST2VD(:CANTMAX,:CODART);

CURSOR=CSUPERAPVPMAX SELECT (ART.PVDVIGENTE*ABS(:DIFF)) PVPDIFF FROM VDARTIC ART WHERE :PVPMAX>0 AND CODART=:CODART AND (ART.PVPVIGENTE*ABS(:DIFF)) > :PVPMAX;

CURSOR=CPUEDEREG SELECT 1 PUEDEREG FROM DUAL WHERE (:CANTIDAD+:DIFF)-:RESERVADO>=0; 


PRECOMMIT=FEJECUTA("+CSELDATOS","ERROR EN CSELDATOS",
#                   "CPUEDEREG","ERROR\n NO SE PUEDEN REGULARIZAR :DIFF\n STOCK RESERVADO :RESERVADO\n DISPONIBLE :CANTIDAD",
                   "!-CMOVTOSHUERFANOS","Hay movtos pdtes del stock transformado.\n ¿ Desea Confirmar la Tranformación ?",                   
                   "+CDAMEOBSERV","",
                   "-CDIFFESCERO","DEBE INFORMAR LA DIFERENCIA EN CANTIDAD",
                   "-CCODCONCENULO"," DEBE INFORMAR UN CONCEPTO ",
                   "-CMOTIVONULO"," DEBE INFORMAR UN MOTIVO FMD ",
                   "-CSUPERACANTMAX","LA CANTIDAD A REGULARIZAR NO PUEDE SUPERAR\n LA MÁXIMA PERMITIDA POR ESTE CONCEPTO (:CANTMAX :UNIDADESHOST)",
                   "-CSUPERAPVPMAX","EL PRECIO DE LA REGURALIZ. ES :PVPDIFF Y SUPERA\n EL MÁXIMO A REGULARIZAR (:PVPMAX), POR ESTE CONCEPTO",
#                   FREGULARIZASTK (":CODMAT",":ORDENSTK",":CODCONCE",":UBICODCONCE",":DIFF",":OBSERV","CODMOVOUT"),"\n ERROR EN TRIGER FREGULARIZASTK\n\n :V10ERROR",                  
				   FIF("CTIENEFMD",
				       FIF("CSELCONCEFMD",FEJECUTA("CSELSECUEN","ERROR OBTENIENDO SECUENCIAL \nPARA INSERTAR NUMEROS DE SERIE",
				                                   FEJECUTAFORM("VDLEESNREG","S","","CODART=:CODART DESART=:DESART CODLOT=:CODLOT CANTIDAD=:DIFF CODMAT=:CODMAT SECUEN=:SECUEN MOTIVOFMD=:MOTIVOFMD"),"ERROR CARGANDO PANTALLA DE ESCANEOS",
											       "+CSELLEIDOS","",
											       "CTODOSLEIDOS","NO SE HAN LEIDO TODOS LOS NÚMEROS DE SERIE\n Y NO SE REALIZA LA REGULARIZACIÓN"),FSUCCESS),FSUCCESS),"",
                   "CREGULARIZA","ERROR EN CREGULARIZA",
                   "-CMSJERROR",":MSJERROR",
                   "+CUPMOVIM","",
                   "CUPDCLAVEEXT","",
                   FIMPRIME("INFORME","$(VDMOVIMIENTO)","FORMCODMOV=:CODMOVOUT",""),":V10ERROR",
                   FCOMMIT,"",
                   %FFAILURE,"REGULARIZACIÓN DE STOCK REALIZADA",
                   +FPULSATECLAS("ESC"),"")
                                  
# REGULARZA EL STOCK, Y SI TIENE ESA MATRICULA BULTO DE PICKING INVERSO ASOCIADO,
# SINCRONIZA ESTE CON EL NUEVO STOCK DEL BULTO (INCLUSO PUEDE DEJAR MOVTOS EN PDTESTOCK)
CURSOR=CREGULARIZA BEGIN                    
					VDPICKINV.REGULARIZASTKPINV(:CODMAT,:ORDENSTK,:CODCONCE,:UBICODCONCE,:DIFF,:OBSERV,:CODMOVOUT,'EXP','RESERVA',:MSJERROR,:RET);
                   END;@

CURSOR=CMSJERROR SELECT :MSJERROR FROM DUAL WHERE :RET<>0;                   
   
CURSOR=CUPDCLAVEEXT UPDATE VDMOVIM SET DATOSHOST=:DATOSHOST WHERE CODMOV=:CODMOVOUT;

CURSOR=CTIENEFMD SELECT 1 DUMMY FROM DUAL WHERE VDFMD.TIENEFMD(:CODART,NULL,NULL,:CODLOT)='S';

CURSOR=CSELCONCEFMD SELECT 1 DUMMY FROM VDCONCEPTO WHERE CODCONCE=:CODCONCE AND SWTFMD='S' AND :MOTIVOFMD IS NOT NULL;
																												   

CURSOR=CSELSECUEN SELECT XVDTMPSCAN.NEXTVAL SECUEN FROM DUAL;

CURSOR=CSELLEIDOS SELECT COUNT(*) TOTALLEIDOS FROM XVDTMPSCANSN WHERE SECUEN=:SECUEN;

CURSOR=CTODOSLEIDOS SELECT :TOTALLEIDOS FROM DUAL WHERE ABS(:DIFF)=:TOTALLEIDOS;

CURSOR=CMOTIVONULO SELECT 1 DUMMY FROM VDCONCEPTO WHERE CODCONCE=:CODCONCE AND SWTFMD='S' AND :MOTIVOFMD IS NULL;

CURSOR=CUPMOVIM UPDATE VDNUMSERIESFMD SET CODMOV=:CODMOVOUT WHERE CODMOV=:SECUEN AND VDFMD.TIENEFMD(:CODART,NULL,NULL,:CODLOT)='S';



BOTON=B1,545,265,32,32,"P",miok.png,F4,"Confirmar regularización",INCLUDECSS="background-color: transparent;border-width:0px"
BOTON=B2,585,265,32,32,"P",minook.png,ESC,"Deshacer regularización",INCLUDECSS="background-color: transparent;border-width:0px"

#TECLA=F9,FEJECUTAFORM("VDSELCONCEPTOFORM2","N","","CODART=:CODART CAMPO='CANTIDAD'","CODCONCE=:CODCONCEENT UBICODCONCE=:FUENTE CANTMAX=:CANTMAX PVPMAX=:PVLMAX","SELECCIÓN DE CONCEPTOS PARA REGULARIZACIONES DE CANTIDAD","S")                           

