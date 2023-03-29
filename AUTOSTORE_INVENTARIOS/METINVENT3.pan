#*****************************************************************
#MOdulo: METINVENT3.PAN
#Funcionalidad : Pantalla para conteos
#Autor: ICC      
#Fecha: 06-03-2023
#*****************************************************************
#* HistOrico de cambios
#* ====================
#
 CONTEOS
 Matricula         Cantidad Real
 _20__________     #L############


                                     |

TABLA=DUAL
NOQUERY


CAMPO=CODINVEN,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODARTREAL,AUXILIAR,OCULTO,"_20_"
CAMPO=CODMATR,AUXILIAR,NOENTER,TITULO("Matricula"),INCLUDECSS="HEIGHT:46px;font-size:22pt;"
CAMPO=CANTINTREAL,AUXILIAR,TOOLTIP("Cantidad total después de inventariar, incluidas las rotas"),TITULO("Cantidad Real"),WLONX=15,INCLUDECSS="HEIGHT:46px;font-size:26pt;"
CAMPO=CODLOTE,AUXILIAR,OCULTO,"_20_"
CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"
#FPULSATECLA(F3, F2) NOCOMMIT

CURSOR=CINSCONT UPDATE VDINVENCONTEO 
                   SET CANTREAL=:CANTINTREAL 
				 WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL;
				   
CURSOR=CACTSTOCK DECLARE 
                     AUXRECONT VDINVENCONTEO.RECONTEO%TYPE
                 BEGIN 
					 IF (SELECT MOD(CANTREAL,CANTTEORICO) FROM VDINVENCONTEO WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL)!=0 OR 
					    (SELECT MOD(CANTTEORICO,CANTREAL) FROM VDINVENCONTEO WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL)!=0 THEN 
					   SELECT RECONTEO FROM VDINVENCONTEO WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL;
					   UPDATE VDINVENCONTEO 
						  SET STATUS=400,
                              RECONTEO=AUXRECONT+1						  
						WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL;
					 ELSE
					   UPDATE VDSTOCK
						  SET CANTIDAD=:CANTINTREAL
						WHERE CODMAT=:CODMATR AND CODART=:CODARTREAL;
					   UPDATE VDINVENCONTEO 
						  SET STATUS=500 
						WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL;
					 END IF;
                 END;@
				 
#CURSOR=CSELART SELECT :CODARTREAL FROM VDINVENCONTEO WHERE CODINVEN=:CODINVEN;

CURSOR=CFINTG SELECT CODGRTASK FROM ASTGRTASKCAB WHERE CODORDREC=:CODORDREC AND SECLINORD=:LINEA AND STATUS=100;

CURSOR=CCIERRAPUERTO DECLARE
						MIXML XMLTYPE;
						MIPUERTO NUMBER(1);

					 BEGIN 
						  IF VDUSER.GETHOSTNAME='W10-13826' THEN
						    MIPUERTO:=1;
						  ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
						    MIPUERTO:=2;
						  ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
						    MIPUERTO:=3;
					      ELSE MIPUERTO:=1;
						  END IF;
						  
							select xmlroot(
								 xmlelement("methodcall",
									xmlelement("name", 'closeport'),
												xmlelement("params",
												xmlelement("port_id", MIPUERTO)
														  )
											 ) 
								 , VERSION '1.0')INTO MIXML FROM DUAL;
							MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
							UPDATE ASTRESPONSE SET ESTPUERTO='C' WHERE PUERTO=MIPUERTO;
							COMMIT;
					 END; @
					



TECLA=AF8,FEJECUTA("CINSCONT","Error registrando conteo",
                   "CGENSALIDA","ERROR CREANDO MOVIMIENTO DE ENTRADA A AUTOSTORE",
			       "CACTSTOCK","Error actualizando stock en Autostore",
#				   PRESEBLOQUE("METINVENT2.PAN","SELECT SEQINVEN,CODUBI,CODARTREAL,DESARTR,STATUS,DESSTATUS,RECONTEO FROM VDINVENCONTEO WHERE STATUS NOT IN (400,500) AND CODINVEN=:CODINVEN ORDER BY SEQINVEN,CODUBI"),"") 
                   PRESEBLOQUE("METINVENT2.PAN","SELECT SEQINVEN,CODUBI,CODARTREAL,DESARTR,STATUS,DESSTATUS,RECONTEO FROM VDINVENCONTEO WHERE STATUS NOT IN (400,500) ORDER BY SEQINVEN,CODUBI"),"",
				   FCOMMIT,"",
				   FIF("CFINTG",FEJECUTA(%FFAILURE,"ESPERE SIGUIENTE CUBETA"),FEJECUTA(%FFAILURE,"Finalizado inventario del articulo :CODARTREAL.",FPULSATECLAS("F3"),"","CCIERRAPUERTO","Error cerrando el puerto de AutoStore")),"") 


AJAX(BIN,"","C","","CSELLECTURA","CODMATR",50)
CURSOR=CSELLECTURA DECLARE
                     MITEXTO VARCHAR2(1024);
					 MIPUERTO NUMBER(1);
                   BEGIN
				     :V10EVAJAX:=0;
				     IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
			         ELSE MIPUERTO:=1;
                     END IF;

                     SELECT BINID INTO MITEXTO FROM ASTRESPONSE WHERE PUERTO=MIPUERTO AND ESTADO='O';

                     IF MITEXTO IS NOT NULL THEN
					   :V10EVAJAX:=3000;
					   :CODMATR:=MITEXTO;
                     ELSE
				       :V10EVAJAX:=0;
                     END IF;
                   END;@
				   
ONLINE= {F1} Ayuda    {F2} Consulta    {F8} Guarda Conteo    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;
BOTON=B1,515,520,75,75,"P",insert2.png,AF8,"Pedir Cubetas",INCLUDECSS="background-color:transparent;border-width:0px"				   