###########################################
# MOdulo   : METINVENT.PAN
# Función  : Pantalla de cabecera de inventarios resumen para operario
#
# Creación : 06-03-2023
# Autor    : ICC
###########################################
# HistOrico de cambios:
CABECERA DE INVENTARIOS
Inventario                                  Tipo      Pr. Estado               Total cubetas
#L############# _100_______________________ _20______ @L@ #####   ___________  @@@@@@@@@@
                                                                                             |

TABLA=VDINVENCAB
WHERE=STATUS BETWEEN 100 AND 250;
ORDERBY=STATUS,CODINVEN DESC;

WLONX=990

PQUERY
POSX=1
POSY=1

NOINSERT
NOUPDATE

CAMPO=CODINVEN,NOUPDATE,TOOLTIP("Código de inventario obtenido del secuencia VDSECINVEN"),TITULO("Inventario")
CAMPO=DESINVEN,TOOLTIP("Descripción de inventario"),TITULO("Descripción"),WLONX=15
CAMPO=TIPOINVEN,TOOLTIP("Tipo de inventario"),TITULO("Tipo"),WLONX=10
CAMPO=PRIOINVEN,TOOLTIP("Prioridad"),TITULO("Pr.")
CAMPO=STATUS,NOUPDATE("IMPLANTADOR"),TITULO("Estado"),WLONX=15,TOOLTIP("Estado de las líneas del inventario. Posibles valores: 100 creado\n 200 en curso\n 300 Fin"),
             POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"),TITULO("Estado")
CAMPO=DESSTATUS, NOENTER,NOUPDATE,AUXILIAR,TITULO(""),WLONX=15
CAMPO=TOTCUBETAS,AUXILIAR,NOUPDATE,POSTCHANGE=FDESIGNACION("+CSELTOTALCUB",""),TITULO("Total Cubetas")
CAMPO=NUMSEPARACIONES,AUXILIAR,OCULTO,"@"
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

CURSOR=CSELTOTALCUB SELECT COUNT(STK.CODMAT) TOTCUBETAS 
                      FROM VDSTOCK STK, VDINVENCONTEO INV
                     WHERE STK.CODART=INV.CODARTREAL
                       AND STK.CODMAT=INV.CODMAT
                       AND INV.CODINVEN=:CODINVEN;

CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INC'
                        AND STATUS = :STATUS;
                        
CURSOR=CSELDATOS SELECT INC.STATUS,STA.DESSTATUS 
                   FROM VDINVENCAB INC,VDSTATUS STA 
				  WHERE CODINVEN=:CODINVEN AND INC.STATUS=STA.STATUS AND STA.TIPOSTATUS='INC';                        
                 

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


CURSOR=CNEXTBIN DECLARE
                  AUXNUM NUMBER(9);
                  CODDEMOV NUMBER(9);
				  MITASKID VARCHAR2(20);
				  MIBINID VARCHAR2(20);
				  MIPUERTO NUMBER(1);
				  MITSKGRP NUMBER(9);
				  MIXML XMLTYPE;
				BEGIN
#                  :CANTIDENTR:=:CANTIDENTR+:CANTIDREAL;
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
                                          <td style="width:75px;height:200px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:200px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT2||'</td>
                                        </tr>
                                      </table>
                                    </div>';
                       ELSIF :NUMSEPARACIONES=4 THEN
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT2||'</td>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT4||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:100px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT3||'</td>
                                       </tr>
                                      </table>
                                    </div>';
                       ELSE
                         :V10HTML:='<div style="position:absolute;top:15PX;left:500PX;border-style:solid;border-color:darkgrey;border-width:thick;border-radius:5px">
                                      <table>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV4||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT4||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV8||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT8||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV3||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT3||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV7||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT7||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV2||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT2||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV6||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT6||'</td>
                                        </tr>
                                        <tr>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV1||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT1||'</td>
                                          <td style="width:75px;height:50px;color:white;'||:AUXDIV5||';text-align:center;font-family:arial;font-size:500px;color:grey">'||:CANT5||'</td>
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

#se necesita añadir apartado de inventario al GENTSKGRP                
#se abre puerto y se abre taskgroup segun las lineas de VDINVENCONTEO del articulo de esta pantalla.
#TECLA=AF8,FEJECUTA("CABREPUERTO","Error abriendo puerto",
#                   "CNEXTBIN","Error pidiendo cubeta")


ONLINE= {F1} Ayuda    {F2} Consulta    {May-F2} Validar inventario {May-F4} Lanza {May-F5} Cierra  {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;
BOTON=B1,1000,90,75,75,"P",validar2.png,AF8,"Pedir Cubetas",INCLUDECSS="background-color:transparent;border-width:0px"