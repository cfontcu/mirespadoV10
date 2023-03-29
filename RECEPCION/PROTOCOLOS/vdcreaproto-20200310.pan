CREACI�N DE PROTOCOLOS DE RECEPCION

 Protocolo Recepci�n  @L@@@@@@@  Tipo ______________                  ����������������������� Ord. Recepci�n ��������������������������
                                                                      �                                                               �
 Divisi�n: _20_____ _40_________________________________________      � C�digo: _20_____________        Tipo : ____________________   �
                                                                      �����������������������������������������������������������������
 Matr�cula:_10_______ Centro Recep:_20__________   Muelle:_10___     
 Contenedores:  @L@@@
 ������������������������� Proveedor  ����������������������������    ����� Recibido ��������������������������������������������������
 � C�digo _20_______  Tipo ____________ Albaran Prov. _10______  �    � Albar�n Trans: _20_____________ Transporte: _40_____________  � 
 �                                                               �    �                                                               �
 � Descripci�n_60__________________________________________      �    �                                                               �
 � Contacto   _40__________________________________________      �    � Palets:        @L@@   Cajas:     @L@@  Bultos:        @L@@    �
 � Direcci�n  _40__________________________________________      �    �                                                               �
 �            _40__________________________________________      �    �                       Kilos: @@@L,@@@  �Imp. Etiquetas  ����  � 
 �            _40__________________________________________      �    �                                        �                   �  �
 �            _40__________________________________________      �    �                                        �           @L@@@@@ �  �
 �                                                               �    �                                        �                   �  �
 � Poblacion  _40__________________________________________      �    �                                        �                   �  �
 � Pais       _____ _40_________________                         �    �                                        ���������������������  � 
 � Provincia  _____ _40____________________________________      �    �                                                               �
 � Tel�fono   ____________                                       �    � Observaciones : _255________________________________________  �
 �                                                               �    �                                                               �
 �����������������������������������������������������������������    �                                                               �
 ��������������������������� Seguimiento  ������������������������    �                                                               �
 �                                                               �    �                                                               �
 � Creaci�n         _32______________ �D-MM-Y.YY ________        �    �                                                               �
 � Inicio Descarga  _32______________ �D-MM-Y.YY ________        �    �����������������������������������������������������������������
 � Fin Descarga     _32______________ �D-MM-Y.YY ________        �  
 � Finalizaci�n     _32______________ �D-MM-Y.YY ________        �  
 �                                                               �  
 � Estado     @L@@@ _40__________________________________________�  
 � Ult.Modificaci�n _32______________ �D-MM-Y.YY ________        �  
 �                                                               �  
 �����������������������������������������������������������������  
    
|

TABLA=VDPROTOCOLO
NOQUERY
NOUPDATE

PREBLOQUE=FEJECUTA("+CPONDEFECTO","",FPOSICIONACAMPO(FSUCCESS,"TIPOPROTO"),"")

PREINSERT=FDESIGNACION("CVERITIPOPROTOENTRADA","INFORME EL TIPO DE PROTOCOLO",
                       "-CDIVNULL","DEBE ELEGIR LA DIVISI�N DE LA DEVOLUCI�N",
                       "CVERIFREFDOCUMENTO","DEBE INFORMAR EL C�DIGO DE LA RECEPCI�N",
                       "CVERIFDESPROVE","DEBE INFORMAR LA DESCRIPCI�N DEL PROVEEDOR",
                       "CVERIFTRANSPORTE","DEBE INFORMAR EL TRANSPORTE",                       
                       "CSELDESPROV","NO EXISTE LA PROVINCIA DEL PAIS INDICADO",                       
                       "CSELOPEINS","ERROR AL CALCULAR CODPROTO",
#DFL 02/07/2019 - DE MOMENTO NO ACTUALIZAMOS LA ORDEN, PORQUE LA RECEPCION BUSCA ESTADOS PENDIENTE
#					   "CUPDORDEN","ERROR ACTUALIZANDO ORDEN DE RECEPCION",
                       FPULSATECLAS("SF2"),"")


CAMPO=CODPROTO,NOENTER,TOOLTIP("C�digo del protocolo")
CAMPO=TIPOPROTO,COMBOX("ENTRADA","DEVOLUCIONES","NO ESPERADO")
CAMPO=CODDIV,COMBOX("CLISTADIVIS"),POSTCHANGE=FEJECUTA("+CSELDIVIS",""),COMBOXREGPAG=10
CAMPO=DESDIV,AUXILIAR,NOENTER
CAMPO=CODORDREC,TOOLTIP("C�digo de la Orden de Recepci�n asociada"),
                COMBOX("CSELORD"),
                POSTCHANGE=FEJECUTA("CSELRECEP","\nLa orden no existe o no est� pendiente de recibir",
                                    "-CSELPROTOSINCERRAR","\nExiste otro protocolo abierto \npara la orden de recepci�n",
									"+CSELDATOSORC","","+CSELDATOSPROVE","",
									FPOSICIONACAMPO(FSUCCESS,"MATRITRANS"),""),WPOSY=-2,WLONX=48
CAMPO=TIPORDREC,AUXILIAR,NOENTER
CAMPO=MATRITRANS,TOOLTIP("Matr�cula del veh�culo que descarga")
CAMPO=CODAREARECEP,TOOLTIP("Centro de descarga"),COMBOX("CSELAREA"),POSTCHANGE=FEJECUTA("CACTORDRECEP","Error al actualizar la orden :CODORDREC")
CAMPO=CODMUELLE,TOOLTIP("Muelle asignado para la descarga"),COMBOX("CSELMUELLE")
CAMPO=NUMCONTETRANS,TOOLTIP("N�mero de contenedores mar�timos")
CAMPO=CODPROVE,COMBOX("CLISTAPROVE"),UPPER,POSTCHANGE=FEJECUTA("+CSELDATOSPROVE",""),NOENTER
CAMPO=TIPOPROVE,AUXILIAR,NOENTER
CAMPO=CODALBPROVE,TOOLTIP("C�digo de albar�n del proveedor")
CAMPO=CODALBTRAN,TOOLTIP("C�digo de albar�n de Transporte")
CAMPO=CODAGE,COMBOX("CLISTAAGENCIAS")
CAMPO=DESPROVE,UPPER,NOENTER,WPOSY=-2,AUXILIAR
CAMPO=CONTACTO,NOENTER,AUXILIAR
CAMPO=PALETS,POSTCHANGE=FDESIGNACION("CRECALNBULTOS","Error calculando numero total de bultos.","+CINIETIQ",""),INCLUDECSS="height:26px;COLOR:DARKBLUE;font-style:bold;font-size:14pt;border-style:ridge;background-color:#F7BE81;",WPOSY=-2,WLONX=6
CAMPO=CAJAS,POSTCHANGE=FDESIGNACION("CRECALNBULTOS","Error calculando numero total de bultos.","+CINIETIQ",""),INCLUDECSS="height:26px;COLOR:DARKBLUE;font-style:bold;font-size:14pt;border-style:ridge;background-color:#F7BE81;",WPOSY=-2,WLONX=6
CAMPO=NUMBULTOS, NOENTER, AUXILIAR,INCLUDECSS="height:26px;COLOR:DARKBLUE;font-style:bold;font-size:14pt;border-style:ridge;background-color:#F7BE81;",WPOSY=-2,WLONX=6
CAMPO=DIRECCION,NOENTER,AUXILIAR
CAMPO=DIRECCION1,NOENTER,AUXILIAR
CAMPO=KILOS,INCLUDECSS="height:26px;COLOR:DARKBLUE;font-style:bold;font-size:14pt;border-style:ridge;background-color:#F7BE81;",WPOSY=-2,WLONX=6
CAMPO=DIRECCION2,NOENTER,AUXILIAR
CAMPO=DIRECCION3,NOENTER,AUXILIAR

CAMPO=NUMETIQUETAS,VIRTUAL,AUXILIAR,TOOLTIP("Numero de etiquetas de protocolo de entrada a imprimir"),INCLUDECSS="height:46px;COLOR:DARKBLUE;font-style:bold;font-size:24pt;border-style:ridge;background-color:#F7BE81;",WPOSY=-2,WLONX=8,
      POSTCHANGE=FEJECUTA("CVALNUMETIQ","N�mero de etiquetas no puede ser mayor \nque n�mero de bultos m�s una para el albar�n")

CAMPO=POBLACION,NOENTER,AUXILIAR
CAMPO=CODPAIS,NOENTER,AUXILIAR
CAMPO=DESPAIS,AUXILIAR,NOENTER
CAMPO=CODPROV,NOENTER,AUXILIAR
CAMPO=DESPROV,AUXILIAR,NOENTER
CAMPO=TELEFONO,NOENTER,AUXILIAR

CAMPO=OBSERV,REGPAG=4,INCLUDECSS="border-style:inset;border-width:2px;background-color:#FBE9C0"
CAMPO=CODOPECREA,NOENTER
CAMPO=FECCREA,COMBOX("CALENDARIO")
CAMPO=HORACREA,POSTCHANGE=FDESIGNACION("CSELHORACRE","FORMATO DE HORA INCORRECTO")
CAMPO=CODOPEDESCARGA,NOENTER
CAMPO=FECDESCARGA,NOENTER
CAMPO=HORADESCARGA,NOENTER
CAMPO=CODOPEFINDESCARGA,NOENTER
CAMPO=FECFINDESCARGA,NOENTER
CAMPO=HORAFINDESCARGA,NOENTER
CAMPO=CODOPEFIN,NOENTER
CAMPO=FECFIN,NOENTER
CAMPO=HORAFIN,NOENTER
CAMPO=STATUS,NOENTER,POSTCHANGE=FDESIGNACION("+CSELSTATUS","No existe estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,NOENTER
CAMPO=FECMODIF,NOENTER
CAMPO=HORAMODIF,NOENTER
CAMPO=NBULTO,AUXILIAR,NOUPDATE,OCULTO,"@L@"
CAMPO=DUMMY,AUXILIAR,OCULTO,"@"
CAMPO=AUX,AUXILIAR,NOUPDATE,OCULTO,"_____"
CAMPO=RECANOPED,AUXILIAR,OCULTO,"@@@@" 
CAMPO=RECCODDIV,AUXILIAR,OCULTO,"____" 
CAMPO=RECCODPED,AUXILIAR,OCULTO,"_20_" 
CAMPO=RECSEQPED,AUXILIAR,OCULTO,"@@@"


#CURSORES
CURSOR=CINIETIQ SELECT :NUMBULTOS+1 NUMETIQUETAS FROM DUAL; 

CURSOR=CSELFECHASYS SELECT VD.FECHASYS FECCREA, VD.HORASYS HORACREA FROM DUAL;

CURSOR=CVALNUMETIQ SELECT :NUMETIQUETAS FROM DUAL WHERE :NUMETIQUETAS<=:NUMBULTOS+1;

CURSOR=CLISTAPROVE SELECT CODPROVE "Cod.",DESPROVE "Proveedores", TIPOPROVE "Tipo.Proveedor" FROM VDPROVEEDOR ORDER BY DESPROVE;

CURSOR=CSELRECEP SELECT :CODORDREC FROM VDORDRECCAB WHERE CODORDREC=:CODORDREC AND CODDIV = NVL(:CODDIV,CODDIV) AND STATUS IN (VDST.FORCPENRECEP,VDST.FORCPENREPASO); 

CURSOR=CVERIFREFDOCUMENTO SELECT :CODORDREC CODORDREC FROM DUAL WHERE :CODORDREC IS NOT NULL;

CURSOR=CVERIFNBULTOS SELECT :NUMBULTOS FROM DUAL WHERE NVL(:NUMBULTOS,0)>0;

CURSOR=CVERIFTRANSPORTE SELECT :CODAGE FROM DUAL WHERE :CODAGE IS NOT NULL;

CURSOR=CSELNUMETIQUETAS SELECT :NUMETIQUETAS NUMETIQUETAS FROM DUAL WHERE :NUMETIQUETAS > 0;

CURSOR=CVERITIPOPROTOENTRADA SELECT 1 DUMMY FROM DUAL WHERE  :TIPOPROTO IS NOT NULL;

CURSOR=CRECALNBULTOS SELECT :PALETS+:CAJAS NUMBULTOS FROM DUAL;

CURSOR=CPONDEFECTO SELECT 1 NUMETIQUETAS FROM DUAL;                

CURSOR=CDIVNULL SELECT :CODDIV FROM DUAL WHERE :CODDIV IS NULL;

CURSOR=CLISTADIVIS SELECT CODDIV "Cod.", DESDIV "Divisi�n" FROM VDDIVIS ORDER BY DECODE(CODDIV,NULL,1,0),CODDIV;

CURSOR=CSELDIVIS SELECT DESDIV FROM VDDIVIS WHERE NVL(CODDIV,'-') = NVL(:CODDIV,'-');

CURSOR=CSELCOMBPAIS SELECT CODPAIS,DESPAIS FROM VDPAIS ORDER BY DESPAIS;

CURSOR=CSELCOMBPROV SELECT DISTINCT CODPROV,DESPROV,PROV.CODPAIS,DESPAIS FROM VDPROVI PROV, VDPAIS PA 
                             WHERE PA.CODPAIS = :CODPAIS AND PROV.CODPAIS=PA.CODPAIS AND PA.CODPAIS=NVL(:CODPAIS,'%') ORDER BY DECODE(CODPAIS,:CODPAIS,0,1),CODPROV;

CURSOR=CSELPAIS SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:CODPAIS AND :CODPAIS IS NOT NULL
                UNION SELECT ' ' FROM DUAL WHERE :CODPAIS IS NULL;

CURSOR=CSELDESPROV SELECT DESPROV DESPROV FROM VDPROVI PROV, VDPAIS PA 
                          WHERE PROV.CODPAIS=PA.CODPAIS AND CODPROV=:CODPROV AND PROV.CODPAIS=:CODPAIS
                          UNION SELECT ' ' DESPROV FROM DUAL WHERE :CODPROV IS NULL;



CURSOR=CVERIFDESPROVE SELECT :DESPROVE DESPROVE FROM DUAL WHERE :DESPROVE IS NOT NULL;

#CURSOR=CSELDESCCLI SELECT :DESCLIENTE FROM VDPEDIDOCAB PEC,VDCLIENTES CLI WHERE PEC.CODCLIENTE=CLI.CODCLIENTE(+) AND PEC.CODCLIENTE=:CODCLIENTE AND  CLI.TIPOCLI(+)!='BAJA' AND ROWNUM=1 
#                  UNION
#                  SELECT :DESCLIENTE FROM VDCLIENTES WHERE CODCLIENTE=:CODCLIENTE AND TIPOCLI!='BAJA' AND ROWNUM=1;

CURSOR=CSELSTATUS SELECT TO_NUMBER(:STATUS) STATUS, DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='PRT';
                  
				  
CURSOR=CSELOPEINS SELECT TO_CHAR(SYSDATE,'YYMMDD')|| LPAD(VDPROTOCOLOS.DAMESEQPROTOCOLO,3,'0') CODPROTO,                          
                         VDUSER.GETUSER CODOPECREA,VD.FECHASYS FECCREA, VD.HORASYS HORACREA,
                         VDST.FPRTCREADO STATUS,
                         VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF
                    FROM DUAL;


                    
CURSOR=CBORRABULTO SELECT 0 NBULTO FROM DUAL;

CURSOR=CSELNBULTO SELECT TO_NUMBER(:NBULTO)+1 NBULTO FROM DUAL
                    WHERE :NBULTO+1<:NUMETIQUETAS;
                    

CURSOR=CSELDATOSPROVE SELECT 
                      NVL(:DESPROVE,DESPROVE)     DESPROVE,
					  NVL(:TIPOPROVE,TIPOPROVE)   TIPOPROVE,
                      NVL(:CONTACTO,CONTACTO)     CONTACTO,
					  NVL(:DIRECCION,DIRECCION)   DIRECCION,
                      NVL(:DIRECCION1,DIRECCION1) DIRECCION1,
					  NVL(:DIRECCION2,DIRECCION2) DIRECCION2,
					  NVL(:DIRECCION3,DIRECCION3) DIRECCION3,
                      NVL(:POBLACION,POBLACION)   POBLACION,
					  NVL(:TELEFONO,TELEFONO)     TELEFONO,
                      NVL(:CODPAIS,PAI.CODPAIS)   CODPAIS,
					  NVL(:DESPAIS,PAI.DESPAIS)   DESPAIS,
					  NVL(:CODPROV,PRO.CODPROV)   CODPROV,
					  NVL(:DESPROV,PRO.DESPROV)   DESPROV
				FROM VDPROVEEDOR PROVE
				LEFT OUTER JOIN VDPAIS PAI ON
                     PROVE.CODPAIS = PAI.CODPAIS
                LEFT OUTER JOIN VDPROVI PRO ON
                     PROVE.CODPROV = PRO.CODPROV AND
                     PROVE.CODPAIS=PRO.CODPAIS   
				WHERE CODPROVE = :CODPROVE;

CURSOR=CSELST SELECT :CODPROTO FROM DUAL
               WHERE :CODALBAST IS NULL OR (:CODALBAST IS NOT NULL AND :SWTPERITAJE IS NOT NULL);			   

CURSOR=CLISTAAGENCIAS  SELECT CODAGE ||'-'||DESAGE NOMBREAGE
                         FROM VDAGENCIA  
                      ORDER BY DESAGE;  

CURSOR=CSELHORACRE SELECT TO_CHAR(TO_DATE(:HORACREA,'HH24:MI:SS'),'HH24:MI:SS') HORACREA FROM DUAL;

CURSOR=CSELPROTOSINCERRAR SELECT :TIPOPROTO FROM VDPROTOCOLO WHERE CODORDREC=:CODORDREC AND STATUS<VDST.FPRTCERRADO;                        
						 
CURSOR=CUPDORDEN UPDATE VDORDRECCAB SET STATUS=VDST.FORCPENREPASO WHERE CODORDREC=:CODORDREC;

CURSOR=CSELDATOSORC SELECT TIPORDREC,CODPROVE, CODAREARECEP, CODDIV FROM VDORDRECCAB WHERE CODORDREC=:CODORDREC;

CURSOR=CSELORD SELECT ORC.CODORDREC "Orden", ORC.CLAVEEXT "Ord.Cliente",DIV.DESDIV "Division",ORC.DESPROVE Proveedor 
                 FROM VDORDRECCAB ORC, VDDIVIS DIV 
				 WHERE ORC.CODDIV = DIV.CODDIV AND ORC.CODDIV = NVL(:CODDIV,ORC.CODDIV) AND ORC.STATUS IN (VDST.FORCPENRECEP,VDST.FORCPENREPASO);

CURSOR=CLISTALMACEN SELECT CODALM, DESALM FROM VDALMA ORDER BY 1; 

CURSOR=CSELMUELLE SELECT CODMUELLE, DESMUELLE FROM VDMUELLES WHERE CODAREA = :CODAREARECEP AND STATUS = VDST.FMUELIBRE;

CURSOR=CSELAREA SELECT CODAREA, DESAREA FROM VDAREA WHERE CODAREA LIKE 'RECEP%';

CURSOR=CACTORDRECEP UPDATE VDORDRECCAB SET CODAREARECEP = :CODAREARECEP, CODOPEMODIF=VDUSER.GETUSER, FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS 
                    WHERE CODORDREC = :CODORDREC AND :CODORDREC IS NOT NULL;					
                    
TECLA=SF2,FEJECUTA("CBORRABULTO","",
#                    FWHILE("CSELNBULTO",
#                           FIMPRIME("ETIQ","VDPROTOCOLO.GEN;VDPROTOCOLO.VSQ;CSELPROTO","CODPROTO=:CODPROTO;NBULTO=:NBULTO;NUMETIQUETAS=:NUMETIQUETAS",""),":V10ERROR"),":V10ERROR",
#                   FIMPRIME("ETIQ","VDPROTOCOLO.GEN;VDPROTOCOLO.VSQ;CSELPROTO","CODPROTO=:CODPROTO;NBULTO=:NBULTO;NUMETIQUETAS=:NUMETIQUETAS",""),":V10ERROR",
#				    FCOMMIT,"",
					%FFAILURE,"CREADO PROTOCOLO N� :CODPROTO",
                    FIMPRIME("INFORME","VDPROTOCOLO.RPT","CODPROTO=:CODPROTO",""),":V10ERROR",
					FCOMMIT,"",
					FPULSATECLAS("F3"),"")



					
ONLINE= {F4} Confirmar {Esc} Salir {SF10} Men�;                