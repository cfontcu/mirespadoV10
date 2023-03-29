#*****************************************************************************************
#Módulo: VDPEDIDOSPEND.PAN
#Funcionalidad : Pantalla de Salidas SIN PICKING de AutoStore
#Autor: Fermín       
#Fecha: Marzo-2023
#*******************************************************************************************
#* Histórico de cambios
#* ====================
#*
#*
 SALIDAS SIN PICKING  PENDIENTES
 ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË 
 ³                                                                    ³
 ³ Pedido sin picking: _20_________                                   ³
 ³                                                                    ³
 ³ Fecha/Hora              Pr.   Num.Cub.                             ³
 ³ _____________________   ___   @@@@@@@@                             ³
 ³                                                                    ³
 ³ Lect. Scan   ____________________                                  ³
 ³                                                                    ³
 ³ Cubeta   ____________________                                      ³
 ³                                                                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
                                                                      |

TABLA=DUAL
NOQUERY

CAMPO=CODGRTASK,AUXILIAR,POSTCHANGE=FEJECUTA("CDATOSOLA","Error obteniendo los datos de esta ola"),
											 TOOLTIP("Selector de olas de pedidos a servir."),
											 COMBOX("CLISTAPEDORD")
CAMPO=REQTIME,AUXILIAR,NOENTER,TOOLTIP("Fecha y hora del pedido seleccionado.")
CAMPO=PRIORIDAD,AUXILIAR,NOENTER,TOOLTIP("Prioridad del pedido seleccionado.")
CAMPO=NUMCUBETAS,AUXILIAR,NOENTER,TOOLTIP("Número de líneas del pedido seleccionado.")
CAMPO=LECTSCAN,AUXILIAR,POSTCHANGE=FEJECUTA("COMPLENGTH","",
                                            "CCOMPPEDIDO","El bulto leído no corresponde a esta ola")
CAMPO=CUBETA,AUXILIAR,TOOLTIP("Pedir una cubeta concreta.")

#CAMPOS AUXILIARES OCULTOS
CAMPO=MENSAJE,AUXILIAR,OCULTO,"@L@"
CAMPO=CODIGOAGRUP,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=CODART,AUXILIAR,OCULTO,"_20_"
CAMPO=PUERTOTG,AUXILIAR,OCULTO,"@@"

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
					 
                     SELECT xmlroot(
                                     xmlelement("methodcall",
                                       xmlelement("name", 'openport'),
                                       xmlelement("params",
                                         xmlelement("port_id", MIPUERTO),
					                     xmlelement("select",
										   xmlelement( "category" ,'4') 
										 ),
									     xmlelement("port_mode",'OPEN')
                                       )
                                     ),
                                     VERSION '1.0'
                                    ) INTO MIXML FROM DUAL;
                     MET_REST_UTILS.REST_XMLPOST(MIXML,'87.216.113.196');
                     UPDATE ASTRESPONSE SET ESTPUERTO='A' WHERE PUERTO=MIPUERTO;
                     COMMIT;					 
				   END;@

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
							MET_REST_UTILS.REST_XMLPOST(MIXML,'87.216.113.196');
							UPDATE ASTRESPONSE SET ESTPUERTO='C' WHERE PUERTO=MIPUERTO;
							COMMIT;
					 END; @
                     
CURSOR=CLISTAPEDORD SELECT CODGRTASK,PRIORIDAD FROM ASTGRTASKCAB WHERE VDEXTRA='SINPICKING' AND STATUS<200 ORDER BY PRIORIDAD;
CURSOR=CDATOSOLA SELECT REQTIME,PRIORIDAD,SECLINORD INTO :REQTIME,:PRIORIDAD,:CODIGOAGRUP FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;			 
CURSOR=COMPLENGTH SELECT :MENSAJE FROM DUAL WHERE LENGTH(:LECTSCAN)>4;
CURSOR=CCOMPPEDIDO SELECT CODART FROM ASTAGRUPLIN WHERE CODBULTO=:LECTSCAN AND CODAGRP=:CODIGOAGRUP; 
				   
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

					   :PUERTOTG:=MIPUERTO;
                       UPDATE ASTGRTASKCAB SET STATUS=110,ENPUERTO=MIPUERTO WHERE CODGRTASK=:CODGRTASK AND STATUS=100;
                       COMMIT;
                     END;@

CURSOR=COLAYACOGIDA SELECT PRIORIDAD FROM ASTGRTASKCAB WHERE STATUS=110 AND ENPUERTO=:PUERTOTG;					 
				   
TECLA=AF8,FEJECUTA(FIF(FEJECUTA("CGENBULT","Error generando los bultos de esta ola"),
   					   FEJECUTA("CGENERAETIQS","Error generando la etiqueta del bulto","CESTGRTASKCAB","Error asignando esta ola al puerto","COLAYACOGIDA","Este pedido ya está en otro puerto")))

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
BOTON=B1,400,30,100,100,"P",validar2.png,AF8,"Confirmar Datos",INCLUDECSS="background-color:transparent;border-width:0px"

