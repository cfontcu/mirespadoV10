#*****************************************************************************************
#Módulo: VDARTCANTIDCUBE.PAN
#Funcionalidad : Pantalla de Entrada de Autostore
#Autor: Lily       
#Fecha: 26-07-2022
#*******************************************************************************************
#* Histórico de cambios
#* ====================
#* Jota: se pasa a PL codigo procedimental 19/10/22
#* Jota: Se añaden Botones. se mejoran mensajes de error y se realizan mejoras generales 18/01/2023
 ENTRADA ARTICULOS EN CUBETAS
 ÏÄÄÄÄÄÄÄÄÄÄ INFORMACIÓN ARTICULO ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË 
 ³   Articulo:          _40___________                     ³
 ³   Descripcion:       _100______________________________ ³
 ³   O.T.:              _60_______________________________ ³
 ³   Lote(Prop.):       _60_______________________________ ³
 ³   F.P.C:             ____________                       ³
 ³   Centro:            ____________                       ³
 ³                                                         ³
 ³   Cantidad Total:    @L@@@@@@@@                         ³
 ³   Cantidad Ent:      @L@@@@@@@@                         ³
 ³                                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
 ÏÄÄÄÄÄÄÄÄÄÄ INFORMACIÓN CUBETA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË
 ³   Cubeta :           _18_________________               ³
 ³   N.Separaciones :   @@@                                ³
 ³   Separacion :       @@@                                ³
 ³   Cantidad cubeta :  @L@@@@@@@@                         ³ 
 ³   Cantidad real :    @L@@@@@@@@                         ³
 ³                                                         ³
 ³                                                         ³
 ³                                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
                                                            |

TABLA=DUAL
NOQUERY

CAMPO=CODARTTEC,AUXILIAR,POSTCHANGE=FDESIGNACION("CDESCRART","EL ARTICULO NO EXISTE",
                                                 "CERROR","ESTE ARTÍCULO NO APARECE EN NINGUNA ORDEN DE RECEPCIÓN PENDIENTE",
                                                 "-CPRESERROR",":MENSAJE",
                                                 "CCANTIDAD","PRODUCTO SIN ORDEN DE RECEPCION :CODORDREC LINEA :LINEA",
                                                 "CANULACONF","Error anulando el confirmador",
                                                 %FIF("-CLISPROP",FEJECUTA("CTASKGROUP","ERROR ENVIANDO A AUTOSTORE :CODORDREC :LINEA"),FEJECUTA("-PROPNOINVIS","")),"POR FAVOR ELIJA PROPIETARIO",
												 "CABREPUERTO","Error abriendo el puerto de AutoStore",
                                                 "CTASKGROUP","ERROR ENVIANDO A AUTOSTORE :CODORDREC LINEA :LINEA"
                                                 ),
                                                 TOOLTIP("ARTÍCULO")
                                               
CAMPO=DESART,NOENTER,AUXILIAR,TOOLTIP("DESCRIPCION DEL ARTICULO")
CAMPO=CODORDREC,NOENTER,AUXILIAR,TOOLTIP("Orden de transporte de SAP de esta recepción.")
CAMPO=MARCASTK,
     AUXILIAR,
     TOOLTIP("Propietario del artículo"),
     POSTCHANGE=FEJECUTA("CDESCRART","EL ARTICULO NO EXISTE",
                         "CERRORCMSTK","ESTE ARTÍCULO NO APARECE EN NINGUNA ORDEN DE RECEPCIÓN PENDIENTE",
                         "-CPRESERROR",":MENSAJE",
                         "CCANTIDAD","PRODUCTO SIN ORDEN DE RECEPCION :CODORDREC LINEA :LINEA",
                         "CANULACONF","Error anulando el confirmador",
                         "CCIERRAPUERTO","ERROR CERRANDO PUERTO AL CAMBIAR DE PROPIETARIO",
                         "CABREPUERTO","ERROR ABRIENDO PUERTO AL CAMBIAR DE PROPIETARIO",
                         "CTASKGROUP","ERROR ENVIANDO PROPIETARIO A TASKGROUP :CODORDREC LINEA :LINEA"
                        ),
     COMBOX("CLISPROP")
	 
CAMPO=CADUCI,NOENTER,AUXILIAR,TOOLTIP("Fecha preferente de consumo.")
CAMPO=CENTRO,NOENTER,AUXILIAR,TOOLTIP("Centro para el que se hace esta entrada de producto.")
CAMPO=CANTIDAD,NOENTER,AUXILIAR,TOOLTIP("CANTIDAD TOTAL DE LA ORDEN DE RECEPCION PARA ESTE ARTICULO")
CAMPO=CANTIDENTR,NOENTER,AUXILIAR,TOOLTIP("CANTIDAD DE ENTRADA, SUMA DE LAS CANTIDADES QUE SE VAN METIENDO EN LAS DISTINTAS CUBETAS DE AUTOSTORE")

CAMPO=MATCUBETATEC,AUXILIAR,NOENTER,POSTCHANGE=FEJECUTA("+CCUBETAEXISTENTE"," ",
                                                "+CREVISAMATCUBSTK","\n\n EL NUMERO DE LA CUBETA NO EXISTE EN LA BBDD.\n\n  DAR DE ALTA CUBETA",
												 FSUCCESS),TOOLTIP("Matricula de la cubeta")										 
CAMPO=NUMSEPARACIONES,AUXILIAR,NOENTER
CAMPO=SEPARACION,AUXILIAR,NOENTER														   
CAMPO=CANTIDTEO,AUXILIAR,NOENTER,TOOLTIP("CANTIDAD TEORICA QUE PERMITE INTRODUCIR LA SEPARACION DE LA CUBETA")
CAMPO=CANTIDREAL,AUXILIAR,POSTCHANGE=FEJECUTA("CCOMPAR","LA CANTIDAD INFORMADA ES MAYOR DE LA PERMITIDA"),TOOLTIP("CANTIDAD REAL QUE SE INTRODUCE EN LA SEPARACION DE LA CUBETA"),INCLUDECSS="height:46px;font-size:28pt;"

#CAMPOS AUXILIARES PARA LOS CURSORES 	
CAMPO=MENSMATCUBETASTK,AUXILIAR,OCULTO,"@L@"
CAMPO=MENSAGERESULT,AUXILIAR,OCULTO,"@L@"
CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=CODCONCE,AUXILIAR,OCULTO,"_10_"
CAMPO=PULMON, AUXILIAR, OCULTO,"_15_"
CAMPO=CODLOT,AUXILIAR,OCULTO,"_20_"
CAMPO=LINEA,AUXILIAR,OCULTO,"_10_"
CAMPO=CODDIV,AUXILIAR,OCULTO,"____"
CAMPO=MIUNIEMB,AUXILIAR,OCULTO,"@L@@@"
CAMPO=MIEMBCONT,AUXILIAR,OCULTO,"@L@@@"
CAMPO=PRECIOUNI,AUXILIAR,OCULTO,"#L######.###"
CAMPO=RESULTADO,AUXILIAR,OCULTO,"@@"
CAMPO=MENSAJE,AUXILIAR,OCULTO,"_255_"
CAMPO=CODGRTASK,AUXILIAR,OCULTO,"@@@@@@@@@@"
CAMPO=V10HTML,AUXILIAR,OCULTO,"_2048_"
CAMPO=AUXDIV1,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV2,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV3,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV4,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV5,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV6,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV7,AUXILIAR,OCULTO,"_32_"
CAMPO=AUXDIV8,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT1,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT2,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT3,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT4,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT5,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT6,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT7,AUXILIAR,OCULTO,"_32_"
CAMPO=CANT8,AUXILIAR,OCULTO,"_32_"

#CURSORES
CURSOR=CANULACONF DECLARE
                    MIPUERTO NUMBER(1);
                  BEGIN
                    IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                      MIPUERTO:=1;
                    ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                      MIPUERTO:=2;
                    ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                      MIPUERTO:=3;
					ELSE MIPUERTO:=1;
                    END IF;
                    UPDATE ASTRESPONSE SET ESTADO='SINBIN' WHERE PUERTO=MIPUERTO;
					COMMIT;
				  END;@
				  
CURSOR=CCOMPRUEBATICK DECLARE
                        MIPUERTO NUMBER(1);
						AUXNUM NUMBER(9);
                      BEGIN
                        IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                          MIPUERTO:=1;
                        ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                          MIPUERTO:=2;
                        ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                          MIPUERTO:=3;
					    ELSE MIPUERTO:=1;
                        END IF;
                        SELECT TASKID INTO AUXNUM FROM ASTRESPONSE WHERE PUERTO=MIPUERTO AND ESTADO='O';
				      END;@
					 
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
										   xmlelement( "category" ,'3') 
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

CURSOR=PROPINVIS SELECT 1 MARCASTK__INVISIBLE FROM DUAL;
CURSOR=PROPNOINVIS SELECT 0 MARCASTK__INVISIBLE FROM DUAL; 
CURSOR=CLISPROP SELECT DISTINCT MARCASTK FROM VDORDRECLIN WHERE CODART=:CODARTTEC AND STATUS=100 AND MARCASTK<>'SM' AND MARCASTK IS NOT NULL AND (SELECT COUNT(*) FROM VDORDRECLIN WHERE CODART=:CODARTTEC AND STATUS=100 AND MARCASTK<>'SM' AND MARCASTK IS NOT NULL)>1;  

CURSOR=CCUBETAEXISTENTE SELECT MET_PKG_CLI.EXISTECUBETA(:MATCUBETATEC) MENSMATCUBETASTK FROM DUAL;
CURSOR=CREVISAMATCUBSTK SELECT :MENSMATCUBETASTK FROM DUAL WHERE :MENSMATCUBETASTK<>1;
CURSOR=CCOMPAR SELECT 1 MENSAGERESULT FROM DUAL WHERE :CANTIDTEO>=:CANTIDREAL;

CURSOR=CCODLOTE SELECT ORL.CODLOT CODLOT 
                  FROM VDORDRECCAB ORC, VDORDRECLIN ORL
				 WHERE ORL.CODORDREC=ORC.CODORDREC 
				   AND ORL.CODDIV=ORC.CODDIV
                   AND ORL.CODART=:CODARTTEC 
                   AND ORL.STATUS=100 
				   AND ORL.SECLINORD=:LINEA;

CURSOR=CCODUBICA BEGIN MET_PKG_CLI.CREAUBICA(:MATCUBETATEC); END;@

CURSOR=CCONCEPTO  SELECT TOC.CODCONCE CODCONCE
                    FROM VDORDRECCAB ORC, VDTIPORDRECCAB TOC
                   WHERE ORC.TIPORDREC=TOC.TIPORDREC;
				   

CURSOR=CCOMPROBACIONENTRADA SELECT :CODMOV FROM DUAL WHERE :CODMOV<>0;
						
CURSOR=CCREAMOVAS BEGIN
                    :CODMOV:=0;                                                            
                    VDMOV.CREAMOV(:CODMOV, 'ENTRADAAS','PEDRECEP', VDST.FMOVRECOGIDO,'PULMONREC', 
                                  :MATCUBETATEC,:MATCUBETATEC,:CODARTTEC,:CODLOT,:LINEA,'',:CANTIDREAL, 0, 0,'PUERTOAS');
                    IF :CODMOV > 0 THEN
                      VDMOV.VDACTMOVIM (:CODMOV, :PRECIOUNI,'0000000000', '0000000000', :MIEMBCONT, 'CAJA', '', :CODORDREC, :SEPARACION, :MARCASTK);
                    END IF;
                  END;@ 

CURSOR=CEJECUTAMOV BEGIN
                     :RESULTADO:=VDACTSTOCK.EJECUTAMOV(:CODMOV,:MENSAJE,0,0,0,0);
                     COMMIT;
                   END;@

CURSOR=CFINTG SELECT CODGRTASK FROM ASTGRTASKCAB WHERE CODORDREC=:CODORDREC AND SECLINORD=:LINEA AND STATUS=100;

TECLA=AF8,FEJECUTA( "CARTNUL","EL CAMPO ARTICULO DEBE SER INFORMADO",
                    "CCREVISAORDARTIC","DEBE EXISTIR LINEA ACTIVA PARA ARTICULO",
				    "CDESCRART","DEBE EXISTIR DESCRIPCION DEL ARTICULO",
				    "CCANTIDAD","DEBE INTRODUCIRSE CANTIDAD PARA ESTE ARTICULO",
				    "CCOMPAR","LA CANTIDAD INFORMADA ES MAYOR DE LA PERMITIDA",
					"CCODLOTE","NO EXISTE LOTE PARA ESTOS DATOS", 
					"CCODUBICA","ERROR INSERTANTO UBICACION CON CODIGO DE MATRICULA",
				    "CCONCEPTO","ERROR CONCEPTO",
                    "CCOMPRUEBATICK","AUN NO HAY CUBETA ABIERTA, NO SE PUEDE CONFIRMAR LA CUBETA",
					"CANULACONF","ERROR ANULANDO EL BOTÓN DE CONFIRMACIÓN",
					"CCREAMOVAS","ERROR CREANDO MOVIMIENTO DE ENTRADA A AUTOSTORE",
					"CCOMPROBACIONENTRADA","ERROR EN COMPROBACION -AS- :CODMOV CERO",
                    "CEJECUTAMOV","ERROR EJECUTANDO MOVIMIENTO DE ENTRADA A STOCK",
					"CESTADO","ERROR ACTUALIZANDO ESTADO MOVIMIENTO",
                    "CNEXTBIN","Error pidiendo próxima cubeta",
#					"CENVRESP","ERROR ENVIANDO RESPUESTA A SAP",
					PRESEBLOQUE("VDORDENESPEND.PAN","SELECT CODART,CANTIDAD,MARCASTK,CODORDREC,CADUCI,VDEXTRA FROM VDORDRECLIN WHERE STATUS=100 ORDER BY CODORDREC"),"",
					FCOMMIT,"",
					FIF("CFINTG",FEJECUTA(%FFAILURE,"ESPERE SIGUIENTE CUBETA"),FEJECUTA(%FFAILURE,"Finalizada la recepción del artículo :CODARTTEC. Se han almacenado :CANTIDENTR unidades.",FPULSATECLAS("F3"),"","CCIERRAPUERTO","Error cerrando el puerto de AutoStore")),"")			
					
CURSOR=CARTNUL SELECT :CODARTTEC FROM DUAL WHERE :CODARTTEC IS NOT NULL;

CURSOR=CCREVISAORDARTIC  SELECT ORC.CODORDREC CODORDREC,ORL.SECLINORD LINEA,ORL.CODART CODARTTEC
                           FROM VDORDRECLIN ORL,VDORDRECCAB ORC 
                          WHERE ORL.CODORDREC=ORC.CODORDREC 
						    AND ORL.CODDIV=ORC.CODDIV
						    AND ORC.CODORDREC=:CODORDREC
						    AND ORL.SECLINORD=:LINEA
						    AND ORL.CODART=:CODARTTEC 
                            AND ORC.STATUS=100   
						    AND ORL.STATUS=100;				   
					   
CURSOR=CDESCRART SELECT DESART, UNIEMB MIUNIEMB, EMBCONT  MIEMBCONT, PVPVIGENTE PRECIOUNI
                   FROM VDARTIC
				  WHERE CODART=UPPER(:CODARTTEC);

CURSOR=CERROR    SELECT CASE WHEN ORL.STATUS=50 THEN 'ESTE PRODUCTO NO TIENE DATOS DE VOLUMETRIA'  
                             WHEN ORL.STATUS=60 THEN 'ESTE PRODUCTO TIENE ERRORES EN LOS DATOS DE VOLUMETRIA'  
							 WHEN ORL.STATUS=75 THEN 'ERROR ENVIO DE ORDEN DE RECEPCION A AUTOSTORE' 
							 WHEN ORL.STATUS=90 THEN 'NO HAY CUBETA DISPONIBLE'  
							 END MENSAJE,
					    ORC.CODORDREC,
						ORC.CODDIV,
						ORL.MARCASTK,
						CASE
							when to_date(orl.caduci,'yyyymmdd')<add_months(sysdate,120) then substr(orl.caduci,7,2)||'-'||substr(orl.caduci,5,2)||'-'||substr(orl.caduci,0,4)
							when to_date(orl.caduci,'yyyymmdd')>add_months(sysdate,120) then 'SIN F.P.C.'
							end caduci,
						ORL.VDEXTRA CENTRO,
						ORL.SECLINORD LINEA
                   FROM VDORDRECLIN ORL,VDORDRECCAB ORC, ASTGRTASKCAB GRC  
                  WHERE ORL.CODORDREC=ORC.CODORDREC      
                    AND ORL.CODDIV=ORC.CODDIV
					AND GRC.CODORDREC=ORC.CODORDREC
				    AND ORL.CODART=:CODARTTEC 
					AND ORC.STATUS=100
					AND ORL.STATUS=100
					AND ROWNUM=1;
					
#substr(orl.caduci,7,2)||'-'||substr(orl.caduci,5,2)||'-'||substr(orl.caduci,0,4) caduci,

CURSOR=CERRORCMSTK  SELECT
					    ORC.CODORDREC,
						ORC.CODDIV,
						ORL.SECLINORD LINEA
                   FROM VDORDRECLIN ORL,VDORDRECCAB ORC, ASTGRTASKCAB GRC  
                  WHERE ORL.CODORDREC=ORC.CODORDREC      
                    AND ORL.CODDIV=ORC.CODDIV
					AND GRC.CODORDREC=ORC.CODORDREC
				    AND ORL.CODART=:CODARTTEC 
					AND ORL.STATUS=100
					AND ORC.STATUS=100
                    AND ORL.MARCASTK=:MARCASTK
					AND ROWNUM=1;
					
CURSOR=CPRESERROR SELECT :MENSAJE FROM DUAL WHERE :MENSAJE IS NOT NULL;					

				   
CURSOR=CCANTIDAD SELECT ORL.CANTIDAD CANTIDAD
                   FROM VDORDRECLIN ORL,VDORDRECCAB ORC 
                  WHERE ORL.CODORDREC=ORC.CODORDREC 
                    AND ORC.CODORDREC=:CODORDREC				  
                    AND ORL.CODDIV=ORC.CODDIV
					AND ORC.CODDIV=:CODDIV
					AND ORL.CODART=:CODARTTEC
					AND ORL.SECLINORD=:LINEA
                    AND ORL.STATUS=100 
                    AND ORC.STATUS=100;
					
					
#SELECT ORC.CODORDREC,
#						    ORC.CODDIV,
#						    ORL.SECLINORD
#                     INTO :CODORDREC,
#                          :CODDIV, 
#                          :LINEA
#                     FROM VDORDRECLIN ORL,VDORDRECCAB ORC, ASTGRTASKCAB GRC  
#                    WHERE ORL.MARCASTK=:MARCASTK 
#                      AND ORL.CODORDREC=ORC.CODORDREC      
#                      AND ORL.CODDIV=ORC.CODDIV
#					  AND GRC.CODORDREC=ORC.CODORDREC
#				      AND ORL.CODART=:CODARTTEC 
#					  AND ORC.STATUS=100
#					  AND ROWNUM=1;

#SELECT CODGRTASK INTO CODIGOTSKGRP FROM ASTGRTASKCAB WHERE CODORDREC=:CODORDREC AND SECLINORD=:LINEA AND CODDIV=:CODDIV AND STATUS=100;
					
CURSOR=CTASKGROUP  DECLARE
                     AUXNUM NUMBER(9);
                     CODIGOORREC VARCHAR2(20);
                     SECDELINEA NUMBER(8,0);
                     CODIGOTSKGRP NUMBER(9,0);
                     MIPUERTO NUMBER(1);
                     MIXML XMLTYPE;
                   BEGIN

                     SELECT CODGRTASK INTO CODIGOTSKGRP FROM ASTGRTASKCAB WHERE CODORDREC=:CODORDREC AND SECLINORD=:LINEA AND CODDIV=:CODDIV AND STATUS=100;
                     IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
					 ELSE MIPUERTO:=1;
                     END IF;
                     BEGIN
                       SELECT xmlroot(
                                        xmlelement("methodcall",
                                          xmlelement("name", 'openbin'),
                                          xmlelement("params",
                                            xmlelement("port_id", MIPUERTO),
                                            xmlelement("taskgroup_id", CODIGOTSKGRP)
                                          )
                                        ),
                                        VERSION '1.0'
                                     ) INTO MIXML FROM DUAL; 
                       MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
                       SELECT CANTIDAD, CODMAT, VDEXTRA INTO :CANTIDTEO, :MATCUBETATEC, :SEPARACION FROM ASTGRTASKLIN WHERE TASKID=(SELECT TASKID FROM ASTRESPONSE WHERE PUERTO=MIPUERTO AND ROWNUM=1);
                       :CANTIDREAL:=:CANTIDTEO;
                       AUXNUM:=0;
                       FOR CALCANT IN (SELECT CANTENTR FROM ASTGRTASKLIN WHERE CODGRTASK=CODIGOTSKGRP) LOOP
                         AUXNUM:=AUXNUM+CALCANT.CANTENTR;
                       END LOOP;
                       :CANTIDENTR:=AUXNUM;
  					   :AUXDIV1:='background-color:white;';
                       :AUXDIV2:='background-color:white;';
                       :AUXDIV3:='background-color:white;';
                       :AUXDIV4:='background-color:white;';
                       :AUXDIV5:='background-color:white;';
                       :AUXDIV6:='background-color:white;';
                       :AUXDIV7:='background-color:white;';
                       :AUXDIV8:='background-color:white;';
                       :CANT1:='';
                       :CANT2:='';
                       :CANT3:='';
                       :CANT4:='';
                       :CANT5:='';
                       :CANT6:='';
                       :CANT7:='';
                       :CANT8:='';
                       IF :SEPARACION='1' THEN
                         :AUXDIV1:='background-color:orange;';
                         :CANT1:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='2' THEN
                         :AUXDIV2:='background-color:orange;';
                         :CANT2:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='3' THEN
                         :AUXDIV3:='background-color:orange;';
                         :CANT3:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='4' THEN
                         :AUXDIV4:='background-color:orange;';
                         :CANT4:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='5' THEN
                         :AUXDIV5:='background-color:orange;';
                         :CANT5:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='6' THEN
                         :AUXDIV6:='background-color:orange;';
                         :CANT6:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='7' THEN
                         :AUXDIV7:='background-color:orange;';
                         :CANT7:=TO_CHAR(:CANTIDREAL);
                       ELSIF :SEPARACION='8' THEN
                         :AUXDIV8:='background-color:orange;';
                         :CANT8:=TO_CHAR(:CANTIDREAL);
                       END IF;
                       SELECT VDEXTRA INTO :NUMSEPARACIONES FROM VDCONTE WHERE CODMAT=:MATCUBETATEC;
					   IF MIPUERTO=3 THEN
                         IF :NUMSEPARACIONES=1 THEN
                           :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                        <table>
                                          <tr>
                                            <td style="width:150px;height:200px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:100px;color:grey">'||:CANT1||'</td>
                                          </tr>
                                        </table>
                                      </div>';
                         ELSIF :NUMSEPARACIONES=2 THEN
                           :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                        <table>
                                          <tr>
                                            <td style="width:75px;height:200px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                            <td style="width:75px;height:200px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                          </tr>
                                        </table>
                                      </div>';
                         ELSIF :NUMSEPARACIONES=4 THEN
                           :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                        <table>
                                          <tr>
                                            <td style="width:75px;height:100px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                            <td style="width:75px;height:100px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                          </tr>
                                          <tr>
                                            <td style="width:75px;height:100px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                            <td style="width:75px;height:100px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                         </tr>
                                        </table>
                                      </div>';
                         ELSE
                           :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                        <table>
                                          <tr>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV8||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT8||'</td>
                                          </tr>
                                          <tr>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV7||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT7||'</td>
                                          </tr>
                                          <tr>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV6||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT6||'</td>
                                          </tr>
                                          <tr>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                            <td style="width:75px;height:50px;color:white;'||:AUXDIV5||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT5||'</td>
                                          </tr>
                                      </div>';
                        END IF;
					  ELSE
					    IF :NUMSEPARACIONES=1 THEN
                          :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                       <table>
                                         <tr>
                                           <td style="width:200px;height:150px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:100px;color:grey">'||:CANT1||'</td>
                                         </tr>
                                       </table>
                                     </div>';
                        ELSIF :NUMSEPARACIONES=2 THEN
                          :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                       <table>
                                         <tr>
                                           <td style="width:200px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
										 </tr>
										 <tr>
                                           <td style="width:200px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                         </tr>
                                       </table>
                                     </div>';
                        ELSIF :NUMSEPARACIONES=4 THEN
                          :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                       <table>
                                         <tr>
                                           <td style="width:100px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                           <td style="width:100px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                         </tr>
                                         <tr>
                                           <td style="width:100px;height:75px;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                           <td style="width:100px;height:75px;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                        </tr>
                                       </table>
                                     </div>';
                        ELSE
                          :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                       <table>
                                         <tr>
                                           <td style="width:50px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                           <td style="width:50px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
										   <td style="width:50px;height:75px;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                           <td style="width:50px;height:75px;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                         </tr>
                                         <tr>
                                           <td style="width:50px;height:75px;'||:AUXDIV5||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT5||'</td>
                                           <td style="width:50px;height:75px;'||:AUXDIV6||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT6||'</td>
										   <td style="width:50px;height:75px;'||:AUXDIV7||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT7||'</td>
                                           <td style="width:50px;height:75px;'||:AUXDIV8||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT8||'</td>
                                     </div>';
					    END IF;
                      END IF;				
                     END;
                   END;@

CURSOR=CNEXTBIN DECLARE
                  AUXNUM NUMBER(9);
                  CODDEMOV NUMBER(9);
				  MITASKID VARCHAR2(20);
				  MIBINID VARCHAR2(20);
				  MIPUERTO NUMBER(1);
				  MITSKGRP NUMBER(9);
				  MIXML XMLTYPE;
				BEGIN
                  :CANTIDENTR:=:CANTIDENTR+:CANTIDREAL;
				  IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                    MIPUERTO:=1;
                  ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                    MIPUERTO:=2;
                  ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                    MIPUERTO:=3;
			      ELSE MIPUERTO:=1;
                  END IF;

				  SELECT TASKID, BINID INTO MITASKID, MIBINID FROM ASTRESPONSE WHERE PUERTO=MIPUERTO;				 
				  
				  SELECT xmlroot(
                                   xmlelement("methodcall",
                                     xmlelement("name", 'closebin'),
                                     xmlelement("params",
                                       xmlelement("port_id", MIPUERTO),
                                       xmlelement("bin_id", MIBINID),
                                       xmlelement("task_id", MITASKID)
                                     )
                                   ),
                                   VERSION '1.0'
                                ) INTO MIXML FROM DUAL; 
                  MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
				  
				  UPDATE ASTGRTASKLIN SET STATUS=200, CANTENTR=:CANTIDREAL WHERE TASKID=TO_NUMBER(MITASKID) AND STATUS=100;
                  COMMIT;

				  SELECT CODGRTASK INTO MITSKGRP FROM ASTGRTASKLIN WHERE TASKID=TO_NUMBER(MITASKID);
				  SELECT COUNT(*) INTO AUXNUM FROM ASTGRTASKLIN WHERE CODGRTASK=MITSKGRP AND STATUS=100;
				  IF AUXNUM=0 THEN
				    UPDATE ASTGRTASKCAB SET STATUS=200 WHERE CODGRTASK=MITSKGRP;
					UPDATE VDORDRECLIN SET STATUS=200 WHERE CODORDREC=:CODORDREC AND CODART=:CODARTTEC AND STATUS=100 AND SECLINORD=:LINEA;
					SELECT COUNT(*) INTO AUXNUM FROM VDORDRECLIN WHERE CODORDREC=:CODORDREC AND STATUS=100;
					IF AUXNUM=0 THEN
					  UPDATE VDORDRECCAB SET STATUS=200 WHERE CODORDREC=:CODORDREC AND STATUS=100;
					END IF;
                    COMMIT;                    
				  ELSE
				    SELECT xmlroot(
                                     xmlelement("methodcall",
                                       xmlelement("name", 'openbin'),
                                       xmlelement("params",
                                         xmlelement("port_id", MIPUERTO)
                                       )
                                     ),
                                     VERSION '1.0'
                                  ) INTO MIXML FROM DUAL; 
                    MET_REST_UTILS.REST_XMLPOST(MIXML,'10.8.72.26');
					SELECT CANTIDAD, CODMAT, VDEXTRA INTO :CANTIDTEO, :MATCUBETATEC, :SEPARACION FROM ASTGRTASKLIN WHERE TASKID=(SELECT TASKID FROM ASTRESPONSE WHERE PUERTO=MIPUERTO AND ROWNUM=1);
                    :CANTIDREAL:=:CANTIDTEO;
					:AUXDIV1:='background-color:white;';
                    :AUXDIV2:='background-color:white;';
                    :AUXDIV3:='background-color:white;';
                    :AUXDIV4:='background-color:white;';
                    :AUXDIV5:='background-color:white;';
                    :AUXDIV6:='background-color:white;';
                    :AUXDIV7:='background-color:white;';
                    :AUXDIV8:='background-color:white;';
                    :CANT1:='';
                    :CANT2:='';
                    :CANT3:='';
                    :CANT4:='';
                    :CANT5:='';
                    :CANT6:='';
                    :CANT7:='';
                    :CANT8:='';
                    IF :SEPARACION='1' THEN
                      :AUXDIV1:='background-color:orange;';
                      :CANT1:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='2' THEN
                      :AUXDIV2:='background-color:orange;';
                      :CANT2:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='3' THEN
                      :AUXDIV3:='background-color:orange;';
                      :CANT3:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='4' THEN
                      :AUXDIV4:='background-color:orange;';
                      :CANT4:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='5' THEN
                      :AUXDIV5:='background-color:orange;';
                      :CANT5:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='6' THEN
                      :AUXDIV6:='background-color:orange;';
                      :CANT6:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='7' THEN
                      :AUXDIV7:='background-color:orange;';
                      :CANT7:=TO_CHAR(:CANTIDREAL);
                    ELSIF :SEPARACION='8' THEN
                      :AUXDIV8:='background-color:orange;';
                      :CANT8:=TO_CHAR(:CANTIDREAL);
                    END IF;
                    SELECT VDEXTRA INTO :NUMSEPARACIONES FROM VDCONTE WHERE CODMAT=:MATCUBETATEC;
					IF MIPUERTO=3 THEN
                       IF :NUMSEPARACIONES=1 THEN
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:150px;height:200px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:100px;color:grey">'||:CANT1||'</td>
                                        </tr>
                                      </table>
                                    </div>';
                       ELSIF :NUMSEPARACIONES=2 THEN
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:75px;height:200px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:200px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                        </tr>
                                      </table>
                                    </div>';
                       ELSIF :NUMSEPARACIONES=4 THEN
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                       </tr>
                                      </table>
                                    </div>';
                       ELSE
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV8||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT8||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV7||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT7||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV6||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT6||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV5||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT5||'</td>
                                        </tr>
                                    </div>';
                      END IF;
					ELSE
					  IF :NUMSEPARACIONES=1 THEN
                        :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                     <table>
                                       <tr>
                                         <td style="width:200px;height:150px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:100px;color:grey">'||:CANT1||'</td>
                                       </tr>
                                     </table>
                                   </div>';
                      ELSIF :NUMSEPARACIONES=2 THEN
                        :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                     <table>
                                       <tr>
                                         <td style="width:200px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
								 </tr>
								 <tr>
                                         <td style="width:200px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                       </tr>
                                     </table>
                                   </div>';
                      ELSIF :NUMSEPARACIONES=4 THEN
                        :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                     <table>
                                       <tr>
                                         <td style="width:100px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                         <td style="width:100px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
                                       </tr>
                                       <tr>
                                         <td style="width:100px;height:75px;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                         <td style="width:100px;height:75px;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                      </tr>
                                     </table>
                                   </div>';
                      ELSE
                        :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                     <table>
                                       <tr>
                                         <td style="width:50px;height:75px;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT1||'</td>
                                         <td style="width:50px;height:75px;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT2||'</td>
								   <td style="width:50px;height:75px;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT3||'</td>
                                         <td style="width:50px;height:75px;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT4||'</td>
                                       </tr>
                                       <tr>
                                         <td style="width:50px;height:75px;'||:AUXDIV5||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT5||'</td>
                                         <td style="width:50px;height:75px;'||:AUXDIV6||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT6||'</td>
								   <td style="width:50px;height:75px;'||:AUXDIV7||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT7||'</td>
                                         <td style="width:50px;height:75px;'||:AUXDIV8||';text-align:center;font-family:arial;font-size:50px;color:grey">'||:CANT8||'</td>
                                   </div>';
					  END IF;
                    END IF;
                  END IF;
                END;@
				
CURSOR=CESTADO UPDATE VDMOVIM
                  SET STATUS=5200
                WHERE CODMOV=:CODMOV;

#CURSOR=CENVRESP BEGIN 
#                   MET_ITFSAPSAL.ENV_RESP_SAP(:CODORDREC, :MATCUBETATEC);
#                END;@				
				   
#CURSOR=CINSSTK  INSERT INTO VDSTOCK(CODMAT,ORDENSTK,CODART,CODLOT,CANTIDAD,TIPOEMBA,UNIEMB,EMBCONT,
#                                    PRECIOUNI,BLOQUEOS,CODOPEMODIF,FECMODIF,HORAMODIF )
#                             VALUES(:MATCUBETATEC,:SEPARACION,:CODARTTEC,:CODLOT,:CANTIDTEO,'CAJA',
#						            :MIUNIEMB ,:MIEMBCONT,:PRECIOUNI,'0000000000',VDUSER.GETUSER,
#									TO_CHAR(SYSDATE,'J'),TO_CHAR(SYSDATE,'HH24:MI:SS'));		   
				   
				   
CURSOR=CINSCUBETA  INSERT INTO VDCONTE(CODMAT,TIPOCONTE,CNTSSCC,CODUBI,POSCONTE,ALTURACONTE,STATUS,FECENTRADA,HORAENTRADA,FECCREADO,VDEXTRA,
                                       CLAVEEXT,CODCOMEN,CODOPEMODIF,FECMODIF,HORAMODIF,PESOCONTE,LARGOCONTE,ANCHOCONTE,ULTSCAN,FECULTSCAN,
									   HORAULTSCAN,CODBAREXT,CODMATEXT)
                                VALUES(:MATCUBETATEC,'NORMAL',NULL,'FUENTEREC',(SELECT NVL(MAX(POSCONTE),0)+1 FROM VDCONTE WHERE CODUBI='FUENTEREC'),
									   0,0,TO_CHAR(SYSDATE,'J'),TO_CHAR(SYSDATE,'HH24:MI:SS'), TO_CHAR(SYSDATE,'J'),TO_CHAR(:NUMSEPARACIONES),'',0,
									   VDUSER.GETUSER,TO_CHAR(SYSDATE,'J'),TO_CHAR(SYSDATE,'HH24:MI:SS'),0,0,0,0,0,'','','');  		
	
#LECTURAS PISTOLAS
AJAX(SCANNER,"","C","","CSELLECTURA","CODARTTEC",50)
CURSOR=CSELLECTURA DECLARE
                     AUXINT NUMBER;
                     MITEXTO VARCHAR2(1024);
                     MIROWID VARCHAR2(1024);
					 MIPUERTO NUMBER(1);
                   BEGIN
				     IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
			         ELSE MIPUERTO:=1;
                     END IF;

                     SELECT NVL(TEXTO,'0'), ROWID INTO MITEXTO, MIROWID
                       FROM VDSCANLECT
                       WHERE REDSCAN=MIPUERTO AND SCANNER=1 AND ROWNUM=1;
                     IF MITEXTO IS NOT NULL THEN
                       DELETE VDSCANLECT WHERE ROWID=MIROWID;
					   :V10EVAJAX:=3000;
					   :CODARTTEC:=MITEXTO;
					   COMMIT;
                     ELSE
				       :V10EVAJAX:=0;
                     END IF;
                   END;@

ONLINE=  {Alt-F8} CONFIRMA LOS DATOS  {May-F10} CONSULTAR MOVIMIENTOS    {Esc} Salir;
BOTON=B1,350,190,75,75,"P",validar2.png,AF8,"Confirmar Datos",INCLUDECSS="background-color:transparent;border-width:0px"

#					   SELECT
#					     ORL.CODART,
#					     ORL.CODORDREC,
#						 ORL.CODDIV,
#						 ORL.MARCASTK,
#						 ORL.CADUCI,
#						 ORL.VDEXTRA,
#						 ORL.SECLINORD
#					   INTO
#					     :CODARTTEC,
#						 :CODORDREC,
#						 :CODDIV,
#						 :MARCASTK,
#						 :CADUCI,
#						 :CENTRO,
#						 :LINEA
#                       FROM VDORDRECLIN ORL, ASTRESPONSE ASR
#					   WHERE ORL.ROWNUM=ASR.LINORDREC
#					     AND ASR.PUERTO=MIPUERTO;

