#*****************************************************************************************
#Módulo: VDPEDIDOSPEND.PAN
#Funcionalidad : Pantalla de Salidas de AutoStore
#Autor: Fermín       
#Fecha: Enero-2023
#*******************************************************************************************
#* Histórico de cambios
#* ====================
#*
#*
 OLAS DE SALIDAS PENDIENTES
 ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË 
 ³                                                                    ³
 ³ Tarea _20_________   Puerto: ##                                    ³
 ³                                                                    ³
 ³ Fecha/Hora              Pr.   Num.Cub.                             ³
 ³ _____________________   ___   @@@@@@@@                             ³
 ³                                                                    ³
 ³ Lect. Scan   ____________________                                  ³
 ³                                                                    ³
 ³ Bul. Disp. 1 ____________________                                  ³
 ³ Bul. Disp. 2 ____________________                                  ³
 ³ Bul. Disp. 3 ____________________                                  ³
 ³ Bul. Disp. 4 ____________________                                  ³
 ³                                                                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
                                                                      |

TABLA=DUAL
NOQUERY

CAMPO=CODGRTASK,AUXILIAR,POSTCHANGE=FEJECUTA("CASIGNAPUERTO","ERROR RECONOCIENDO PUERTO AS",
                                             "CARROBA","Error asignando @",
                                             "CDATOSOLA","Error obteniendo los datos de esta ola"),
											 TOOLTIP("Selector de olas de pedidos a servir."),
											 COMBOX("CLISTAPEDIDOS")
CAMPO=PUERTOTG,AUXILIAR,TOOLTIP("Puerto de AutoStore sobre el que trabaja este puesto")
CAMPO=REQTIME,AUXILIAR,NOENTER,TOOLTIP("Fecha y hora del pedido seleccionado.")
CAMPO=PRIORIDAD,AUXILIAR,NOENTER,TOOLTIP("Prioridad del pedido seleccionado.")
CAMPO=NUMCUBETAS,AUXILIAR,NOENTER,TOOLTIP("Número de líneas del pedido seleccionado.")
CAMPO=LECTSCAN,AUXILIAR,POSTCHANGE=FEJECUTA("COMPLENGTH","",
                                            "CCOMPPEDIDO","El bulto leído no corresponde a esta ola",
				 				            "CCOMOLACOMP","Ya están asignados todos los bultos de esta ola",
                                            "CASIGNADISP","Error asignando bulto a display",
                                            "-CMENSAJE","Asignando bulto :LECTSCAN a display :DISPENCURSO")										
CAMPO=PEDDISP1,AUXILIAR,NOENTER,TOOLTIP("Código de pedido asignado al display 1.")
CAMPO=PEDDISP2,AUXILIAR,NOENTER,TOOLTIP("Código de pedido asignado al display 2.")
CAMPO=PEDDISP3,AUXILIAR,NOENTER,TOOLTIP("Código de pedido asignado al display 3.")
CAMPO=PEDDISP4,AUXILIAR,NOENTER,TOOLTIP("Código de pedido asignado al display 4.")

#CAMPOS AUXILIARES OCULTOS
CAMPO=ARROBA,AUXILIAR,OCULTO,"_"
CAMPO=DISPENCURSO,AUXILIAR,OCULTO,"@@"
CAMPO=MENSAJE,AUXILIAR,OCULTO,"@L@"
CAMPO=CODIGOAGRUP,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=CODART,AUXILIAR,OCULTO,"_20_"

#CURSORES						
CURSOR=CABREPUERTO DECLARE
                     MIPUERTO NUMBER(2);
                     MIXML XMLTYPE;
				   BEGIN
				     IF VDUSER.GETHOSTNAME='W10-13826' THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
					 ELSE MIPUERTO:=1;
                     END IF;
					 
					 :PUERTOTG:=MIPUERTO;
					 
                     SELECT xmlroot(
                                     xmlelement("methodcall",
                                       xmlelement("name", 'openport'),
                                       xmlelement("params",
                                         xmlelement("port_id", MIPUERTO),
					                     xmlelement("select",
										   xmlelement( "category" ,'1') 
										 ),
									     xmlelement("port_mode",'OPEN')
                                       )
                                     ),
                                     VERSION '1.0'
                                    ) INTO MIXML FROM DUAL;
                     MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
                     UPDATE ASTRESPONSE SET ESTPUERTO='A' WHERE PUERTO=MIPUERTO;
					 COMMIT;					 
				   END;@

CURSOR=CCIERRAPUERTO DECLARE
						MIXML XMLTYPE;
						MIPUERTO NUMBER(1);
						MICODAGRP NUMBER(9);

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
								 ,VERSION '1.0')INTO MIXML FROM DUAL;
							MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
							UPDATE ASTRESPONSE SET ESTPUERTO='C' WHERE PUERTO=MIPUERTO;
							FOR CODDETG IN (SELECT CODGRTASK FROM ASTGRTASKCAB WHERE ENPUERTO=MIPUERTO) LOOP
								UPDATE ASTGRTASKCAB SET STATUS=100,ENPUERTO=0 WHERE CODGRTASK=CODDETG.CODGRTASK AND STATUS<200;
								UPDATE ASTAGRUPLIN SET STATUS=100 WHERE CODAGRP=CODDETG.CODGRTASK AND STATUS<200;
							END LOOP;
							COMMIT;
					 END; @
					 
CURSOR=CARROBA SELECT '@' ARROBA FROM DUAL;
CURSOR=CLISTAPEDIDOS SELECT CODGRTASK,PRIORIDAD FROM ASTGRTASKCAB WHERE VDEXTRA IS NOT NULL AND VDEXTRA<>'SINPICKING' AND STATUS<200 ORDER BY PRIORIDAD;
CURSOR=CDATOSOLA DECLARE
                  CONTADOR NUMBER(6);
                 BEGIN
				   SELECT REQTIME,PRIORIDAD,SECLINORD INTO :REQTIME,:PRIORIDAD,:CODIGOAGRUP FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;
				   
				   IF(VDUSER.GETHOSTNAME='W10-13826') THEN
                     UPDATE ASTRESPONSE SET ESTPICKING='IDLE',CODAGRP=:CODIGOAGRUP WHERE PUERTO=1;
                   ELSIF (VDUSER.GETHOSTNAME='W10-13827') THEN
                     UPDATE ASTRESPONSE SET ESTPICKING='IDLE',CODAGRP=:CODIGOAGRUP WHERE PUERTO=2;
                   END IF;
				   
				   UPDATE ASTAGRUPLIN SET STATUS=100 WHERE CODAGRP=:CODIGOAGRUP;
				   
                   SELECT COUNT(*) INTO CONTADOR FROM ASTGRTASKLIN WHERE CODGRTASK=:CODGRTASK;
                   :NUMCUBETAS:=CONTADOR;
				   :PEDDISP1:='';
                   :PEDDISP2:='';
                   :PEDDISP3:='';
                   :PEDDISP4:='';
				   IF(VDUSER.GETHOSTNAME='W10-13826') THEN
				     UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=1001;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=1002;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=1003;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=1004;
					 UPDATE VDINFOHARDDISP SET TEXTO='A', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=101001;
					 COMMIT;
                   ELSIF (VDUSER.GETHOSTNAME='W10-13827') THEN
                     UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=2001;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=2002;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=2003;
					 UPDATE VDINFOHARDDISP SET TEXTO='', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=2004;
					 UPDATE VDINFOHARDDISP SET TEXTO='A', LUCES='0,1,0,0,0,0,0,0', TECLAS='', VDEXTRA='IDLE', STATUS=200 WHERE NUMDISP=201001;
					 COMMIT;
                   END IF;
				   UPDATE ASTAGRUPLIN SET STATUS=100 WHERE CODAGRP=:CODIGOAGRUP AND STATUS=110; 
				   COMMIT;
				   :DISPENCURSO:=0;
                 END;@
				 
CURSOR=COMPLENGTH SELECT :MENSAJE FROM DUAL WHERE LENGTH(:LECTSCAN)>4;
CURSOR=CCOMPPEDIDO SELECT CODART FROM ASTAGRUPLIN WHERE CODBULTO=:LECTSCAN AND CODAGRP=:CODIGOAGRUP; 
CURSOR=CCOMOLACOMP SELECT CODART FROM ASTAGRUPLIN WHERE CODAGRP=:CODIGOAGRUP AND STATUS=100 AND ROWNUM=1; 

CURSOR=CASIGNADISP DECLARE
                     AUXINT NUMBER;
                     MIPUERTO NUMBER(2);
					 MILINDISP NUMBER(4);
					 MIESTADO VARCHAR2(16);
					 TESTIGO BOOLEAN;
					 MICODAGRP NUMBER;
                   BEGIN
                     IF(VDUSER.GETHOSTNAME='W10-13826') THEN
                       MIPUERTO:=1;
					   MILINDISP:=1000;
                     ELSIF (VDUSER.GETHOSTNAME='W10-13827') THEN
                       MIPUERTO:=2;
					   MILINDISP:=2000;
					 ELSE
					   MIPUERTO:=0;
					   MILINDISP:=0;
                     END IF;
					 
					 IF LENGTH(:LECTSCAN)>4 THEN
                       IF :DISPENCURSO<4 THEN
					     TESTIGO:=FALSE;
					     SELECT VDEXTRA INTO MIESTADO FROM VDINFOHARDDISP WHERE NUMDISP=MILINDISP+1;
					     IF MIESTADO='IDLE' THEN
					       :PEDDISP1:=:LECTSCAN;
						   :DISPENCURSO:=1;
						   UPDATE VDINFOHARDDISP SET TEXTO=:ARROBA||'Pedido:'||:PEDDISP1||',1,1,1', LUCES='0,1,0,0,0,2,0,0', TECLAS='', VDEXTRA='ASIGNADO', STATUS=200 WHERE NUMDISP=MILINDISP+1;
						   UPDATE ASTAGRUPLIN SET NUMDISP=MILINDISP+1, STATUS=110 WHERE CODBULTO=:LECTSCAN;
						   TESTIGO:=TRUE;
					     END IF;
					     IF TESTIGO=FALSE THEN
					       SELECT VDEXTRA INTO MIESTADO FROM VDINFOHARDDISP WHERE NUMDISP=MILINDISP+2;
						   IF MIESTADO='IDLE' THEN
						     :PEDDISP2:=:LECTSCAN;
						     :DISPENCURSO:=2;
						     UPDATE VDINFOHARDDISP SET TEXTO=:ARROBA||'Pedido:'||:PEDDISP2||',1,1,1', LUCES='0,1,0,0,0,2,0,0', TECLAS='', VDEXTRA='ASIGNADO', STATUS=200 WHERE NUMDISP=MILINDISP+2;
							 UPDATE ASTAGRUPLIN SET NUMDISP=MILINDISP+2, STATUS=110 WHERE CODBULTO=:LECTSCAN;
						     TESTIGO:=TRUE;
					       END IF;
					     END IF;
					     IF TESTIGO=FALSE THEN
					       SELECT VDEXTRA INTO MIESTADO FROM VDINFOHARDDISP WHERE NUMDISP=MILINDISP+3;
						   IF MIESTADO='IDLE' THEN
						     :PEDDISP3:=:LECTSCAN;
						     :DISPENCURSO:=3;
						     UPDATE VDINFOHARDDISP SET TEXTO=:ARROBA||'Pedido:'||:PEDDISP3||',1,1,1', LUCES='0,1,0,0,0,2,0,0', TECLAS='', VDEXTRA='ASIGNADO', STATUS=200 WHERE NUMDISP=MILINDISP+3;
							 UPDATE ASTAGRUPLIN SET NUMDISP=MILINDISP+3, STATUS=110 WHERE CODBULTO=:LECTSCAN;
						     TESTIGO:=TRUE;
						   END IF;
					     END IF;
					     IF TESTIGO=FALSE THEN
					       SELECT VDEXTRA INTO MIESTADO FROM VDINFOHARDDISP WHERE NUMDISP=MILINDISP+4;
						   IF MIESTADO='IDLE' THEN
						     :PEDDISP4:=:LECTSCAN;
						     :DISPENCURSO:=4;
						     UPDATE VDINFOHARDDISP SET TEXTO=:ARROBA||'Pedido:'||:PEDDISP4||',1,1,1', LUCES='0,1,0,0,0,2,0,0', TECLAS='', VDEXTRA='ASIGNADO', STATUS=200 WHERE NUMDISP=MILINDISP+4;
							 UPDATE ASTAGRUPLIN SET NUMDISP=MILINDISP+4, STATUS=110 WHERE CODBULTO=:LECTSCAN;
						     TESTIGO:=TRUE;
						   END IF;
					     END IF;
					     IF TESTIGO=TRUE THEN
						   COMMIT;
					     END IF;
					   END IF;
					 END IF;
					 SELECT ' ' INTO :LECTSCAN FROM DUAL;
					 :LECTSCAN:=' ';
					 COMMIT;
				   END;@
				   
CURSOR=CGENBULT DECLARE
                     MIANOBULTO NUMBER;
					 MIAGRUP NUMBER;
					 MIESTADO NUMBER;
                   BEGIN
				     SELECT STATUS INTO MIESTADO FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;
                     IF MIESTADO=100 THEN					 
				       SELECT SECLINORD INTO MIAGRUP FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;
                       FOR BULTO IN (SELECT DISTINCT CODBULTO FROM ASTAGRUPLIN WHERE CODAGRP=MIAGRUP AND STATUS=100) LOOP
                         SELECT ANOBULTO INTO MIANOBULTO FROM MET_BULTOCAB WHERE CODBULTO=BULTO.CODBULTO;
                         INSERT INTO VDBULTOCAB (CODBULTO,CODDIV,ANOPED,CODPED,SEQPED,NBULTO,TIPOBULTO,PESOTEORICO,PESOREAL,VOLUMEN,STATUS)
                                         VALUES (VDSECCODBULTO.NEXTVAL,'MET',MIANOBULTO,BULTO.CODBULTO,0,1,'C',0,0,0,100);
                         COMMIT;
                       END LOOP;
					 END IF;
                   END;@
				   
CURSOR=CGENERAETIQS DECLARE
                      MIMSGERROR VARCHAR2(255);
                      QUEIMPRE VARCHAR2(16);
                      MIANOBULTO NUMBER;
					  MIAGRUP NUMBER;
					  MIESTADO NUMBER;
					  MIPUERTO NUMBER;
					  MIENPUERTO NUMBER;
                    BEGIN
                      IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                        QUEIMPRE:='MET_PUERTO1';
						MIPUERTO:=1;
                      ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                        QUEIMPRE:='MET_PUERTO2';
						MIPUERTO:=2;
                      ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                        QUEIMPRE:='MET_PUERTO3';
						MIPUERTO:=3;
					  ELSE
					    QUEIMPRE:='MET_PUERTO1';
						MIPUERTO:=1;
                      END IF;
					  
					  SELECT ENPUERTO,SECLINORD,STATUS INTO MIENPUERTO,MIAGRUP,MIESTADO FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;
                      IF (MIESTADO=100 OR (MIESTADO=110 AND MIENPUERTO=MIPUERTO)) THEN
                        FOR BULTO IN (SELECT DISTINCT CODBULTO FROM ASTAGRUPLIN WHERE CODAGRP=MIAGRUP) LOOP
                          SELECT ANOBULTO INTO MIANOBULTO FROM MET_BULTOCAB WHERE CODBULTO=BULTO.CODBULTO;
                          VDIMPRIME.IMPRIME(MITIPOIMPRE => 'ETIQ',
                                            MIDOCUMENTO => 'METRO_ETIQBULTOS.GEN;METRO_ETIQBULTOS.VSQ;CDAMEBULTO',
                                            MIPARAMS => 'CODDIV=MET;ANOPED='||MIANOBULTO||';CODPED='||BULTO.CODBULTO||';SEQPED=0',
                                            MICOPIAS => 1,
                                            MICODIMPRE => QUEIMPRE,
                                            MIFICHERO => '',
                                            MSGERROR => MIMSGERROR,
                                            MISTATUS => 100);
                          COMMIT;
                        END LOOP;
					  END IF; 
                    END;@
					
CURSOR=CESTGRTASKCAB DECLARE
                       MIPUERTO NUMBER(2);
                     BEGIN
                       IF(VDUSER.GETHOSTNAME='W10-13826') THEN
                         MIPUERTO:=1;
					   ELSIF (VDUSER.GETHOSTNAME='W10-13827') THEN
                         MIPUERTO:=2;
					   ELSIF (VDUSER.GETHOSTNAME='W10-13828') THEN
					     MIPUERTO:=3;
					   ELSE
						 MIPUERTO:=1;
					   END IF;

                       UPDATE ASTGRTASKCAB SET STATUS=110,ENPUERTO=MIPUERTO WHERE CODGRTASK=:CODGRTASK AND STATUS=100;
                       COMMIT;
                     END;@

CURSOR=CASIGNAPUERTO SELECT CASE
                              WHEN VDUSER.GETHOSTNAME='W10-13826' THEN 1
							  WHEN VDUSER.GETHOSTNAME='W10-13827' THEN 2 
							  WHEN VDUSER.GETHOSTNAME='W10-13828' THEN 3
                              ELSE 1							  
							END PUERTOTG
					 FROM DUAL;
CURSOR=COLAYACOGIDA SELECT PRIORIDAD FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK AND ENPUERTO=0;
CURSOR=CREIMPRIME SELECT PRIORIDAD FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK AND STATUS=110 AND ENPUERTO=:PUERTOTG; 					 
				   
TECLA=AF8,FEJECUTA(FIF(FEJECUTA("CREIMPRIME",""),
                       FEJECUTA("CGENBULT","Error generando los bultos de esta ola","CGENERAETIQS","Error generando las etiquetas de los bultos"),
                       FEJECUTA("COLAYACOGIDA","Esta ola ya está en otro puerto :PUERTOTG",
				                FIF(FEJECUTA("CGENBULT","Error generando los bultos de esta ola"),
								    FEJECUTA("CGENERAETIQS","Error generando las etiquetas de los bultos","CESTGRTASKCAB","Error asignando esta ola al puerto")))),"Elija otra tarea")

#LECTURAS PISTOLAS
AJAX(SCANNER,"","C","","CSELDISPLAY","LECTSCAN",50)
CURSOR=CSELDISPLAY DECLARE
                     MITEXTO VARCHAR2(1024);
                     MIROWID VARCHAR2(1024);
					 MIPUERTO NUMBER(1);
					 MISTATUS NUMBER(6);
                   BEGIN
				     IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
			         ELSE MIPUERTO:=1;
                     END IF;

					 MITEXTO:=' ';
                     SELECT NVL(TEXTO,'0'), ROWID INTO MITEXTO, MIROWID
                       FROM VDSCANLECT
                       WHERE REDSCAN=MIPUERTO AND SCANNER=1 AND ROWNUM=1;
                     IF LENGTH(MITEXTO)>4 THEN
					   :V10EVAJAX:=3000;
					   :LECTSCAN:=MITEXTO;
                     ELSE
				       :V10EVAJAX:=0;
                     END IF;
					 DELETE VDSCANLECT WHERE ROWID=MIROWID;
					 COMMIT;
                   END;@
				   
CURSOR=CMENSAJE SELECT :MENSAJE FROM DUAL WHERE :MENSAJE<>1;
				   
ONLINE={Alt-F8} CONFIRMA LOS DATOS {May-F10} CONSULTAR MOVIMIENTOS {Esc} Salir;
BOTON=B1,400,40,100,100,"P",validar2.png,AF8,"Confirmar Datos",INCLUDECSS="background-color:transparent;border-width:0px"

