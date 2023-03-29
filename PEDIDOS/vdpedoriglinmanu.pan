###################################################################
#M�dulo: VDPEDIDORIGLINMANU.PAN
#Funcionalidad : Inserci�n manual de l�neas de pedido
#Autor: FPD
#Fecha: 05-12-2013
###################################################################
#Hist�rico de cambios:
LINEAS DE PEDIDO MANUAL
 Sec      Art�culo                                           Lote             Serie             Pedida    Precio        IVA    Recar. Dcto     Ultima modificaci�n
 @L@@@@@@ _40_________________ _100_________________________ _10_____________ _2000____________ #L15##### #L#,###,#.### #L#.## #L#.## #L#.##  _32_______ �D-MM-YY ________
|

TABLA=VDPEDIDORIGLIN
ORDERBY=SEQLINEA;


WLONX=1160

PREINSERT=FDESIGNACION("CCHECKCERO","LA CANTIDAD DEBE SER MAYOR QUE CERO","CNUMSERIE","LOS NUMEROS DE SERIE NO COINCIDEN CON LA CANTIDAD",
                       "CINITDATOS","ERROR INICIALIZANDO DATOS",
                       FIF("CCHECKCODCOMEN","CASIGNACODCOMEN"),"ERROR ASIGNANDO CODCOMEN",
                       "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                       "CUPDSTATUSPED","ERROR ACTUALIZANDO EL ESTADO DEL PEDIDO")
				   
POSTCOMMIT=FDESIGNACION("CACTNLIN","ERROR ACTUALIZANDO NUMERO DE LINEAS")
                   
PREUPDATE=FEJECUTA("CCHECKCERO","LA CANTIDAD DEBE SER MAYOR QUE CERO","CNUMSERIE","LOS NUMEROS DE SERIE NO COINCIDEN CON LA CANTIDAD",
                   "CINITDATOS","ERROR INICIALIZANDO DATOS",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
                  
CAMPO=CODDIV,VIRTUAL,OCULTO
CAMPO=CODPED,VIRTUAL,OCULTO
CAMPO=ANOPED,VIRTUAL,OCULTO
CAMPO=SEQPED,VIRTUAL,OCULTO
CAMPO=CODAREAEXPED,AUXILIAR,VIRTUAL,OCULTO

CAMPO=SEQLINEA,TOOLTIP("N�mero secuencial de linea"),TITULO("Sec.")
CAMPO=SEQLINORIG,OCULTO,"@L@@@@@@"
CAMPO=CODART,UPPER,TOOLTIP("Es el c�digo del art�culo a servir"),
        POSTCHANGE=FDESIGNACION("CDESART","Articulo no encontrado"),TITULO("Articulo"),WLONX=20,COMBOX("CLISTAART")
CAMPO=DESART,AUXILIAR,NOENTER,TITULO("Descripci�n")
CAMPO=CODLOT,UPPER,TOOLTIP("Es el lote del art�culo.\nSi viene informado se servir� dicho lote,\nen caso contrario el sistema decide el lote a servir."),TITULO("Lote"),COMBOX("CLISTALOTES")
CAMPO=NUMEROSERIE,TITULO("Serie"),COMBOXMULTIPLE("CLISTASERIE")
CAMPO=CANTPEDIDA,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),TOOLTIP("Cantidad pedida "),TITULO("Cantidad")
CAMPO=PRECIOUNI,TITULO("Precio")
CAMPO=IVA,TITULO("IVA")
CAMPO=RECARGO,TITULO("Recargo"),WLONX=15
CAMPO=DCTO,TITULO("Dcto")
CAMPO=UNIDADESPRECIO,OCULTO,"_10_"
CAMPO=OPCIONPRECIO,OCULTO,"_"
CAMPO=BACKORDER,OCULTO,"_"
CAMPO=TIPOREDONDEO,OCULTO,"_"
CAMPO=CODCOMEN,OCULTO,"@@@@@@@@@"
CAMPO=STATUS,OCULTO,"@@@@@@"
CAMPO=UNIDADESHOST,OCULTO,"_10_"
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiza la modificaci�n"),TITULO("�ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la �ltima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificacion")

CAMPO=PEDIDOHOST,OCULTO,"_60_"
CAMPO=SEQLINCAB,AUXILIAR,OCULTO,"@@@@@"

#CURSOR=CLISTAART SELECT ART.CODART CODIGO,ART.DESART DESIGNACION,SUM(STK.CANTIDAD) CANTIDAD
#                   FROM VDARTIC ART,VDSTOCK STK
#                   WHERE STK.CODART=ART.CODART AND BLOQUEOS='0000000000' 
#                   GROUP BY ART.CODART,ART.DESART
#                   ORDER BY ART.CODART;
				   
CURSOR=CLISTAART  SELECT ART.CODART CODIGO,
						 ART.DESART DESIGNACION,
						 SUM(STK.CANTIDAD) CANTIDAD, 
						 ALM.DESALM ALMACEN
					FROM VDARTIC ART,VDSTOCK STK,VDCONTE CNT,VDUBICA UBI,VDAREA ARE,VDALMA ALM
					WHERE STK.CODART=ART.CODART AND BLOQUEOS='0000000000' AND
						 STK.CODMAT = CNT.CODMAT AND CNT.CODUBI = UBI.CODUBI AND
						 UBI.CODAREA = ARE.CODAREA AND ARE.CODALM = ALM.CODALM AND 
						 ALM.CODALM = (SELECT ALM.CODALM  FROM VDAREA ARE, VDALMA ALM WHERE ARE.CODALM=ALM.CODALM AND ARE.CODAREA = :CODAREAEXPED)
                    GROUP BY ART.CODART,ART.DESART, ALM.DESALM
                    ORDER BY ART.CODART;
                   
CURSOR=CLISTALOTES SELECT STK.CODLOT Lote,LOT.CADUCI caducidad,SUM(CANTIDAD) cantidad, ALM.DESALM Almacen
                    FROM VDSTOCK STK,VDLOTES LOT,VDCONTE CNT,VDUBICA UBI,VDAREA ARE,VDALMA ALM
                    WHERE STK.CODART=:CODART AND STK.BLOQUEOS='0000000000' AND 
                          LOT.CODART=STK.CODART AND LOT.CODLOT=STK.CODLOT AND
						  STK.CODMAT = CNT.CODMAT AND CNT.CODUBI = UBI.CODUBI AND
						 UBI.CODAREA = ARE.CODAREA AND ARE.CODALM = ALM.CODALM AND 
						 ALM.CODALM = (SELECT ALM.CODALM  FROM VDAREA ARE, VDALMA ALM WHERE ARE.CODALM=ALM.CODALM AND ARE.CODAREA = :CODAREAEXPED)
                    GROUP BY STK.CODLOT,LOT.CADUCI, ALM.DESALM
                    ORDER BY STK.CODLOT;   
                    
CURSOR=CLISTASERIE SELECT A.NUMEROSERIE, A.CANTIDAD
                    FROM (SELECT NUMEROSERIE,SUM(STK.CANTIDAD) CANTIDAD
                            FROM VDSTOCK STK, VDCONTE CNT,VDUBICA UBI,VDAREA ARE,VDALMA ALM
                            WHERE STK.CODART=:CODART AND NVL(STK.CODLOT,' ')=NVL(:CODLOT,' ') AND STK.BLOQUEOS='0000000000' AND
							      STK.CODMAT = CNT.CODMAT AND CNT.CODUBI = UBI.CODUBI AND
						          UBI.CODAREA = ARE.CODAREA AND ARE.CODALM = ALM.CODALM AND 
						          ALM.CODALM = (SELECT ALM.CODALM  FROM VDAREA ARE, VDALMA ALM WHERE ARE.CODALM=ALM.CODALM AND ARE.CODAREA = :CODAREAEXPED)
                            GROUP BY NUMEROSERIE) A
                    WHERE ROWNUM <1000;                   
                  

CURSOR=CDESART SELECT DESART,DECODE(:PRECIOUNI,0,PVPVIGENTE,:PRECIOUNI) PRECIOUNI 
                     FROM VDARTIC ART
                     WHERE ART.CODART=:CODART;

CURSOR=CEXISTELIN SELECT CODART FROM VDPEDIDORIGLIN 
                   WHERE CODPED = :CODPED AND CODDIV = :CODDIV AND 
                         SEQLINEA = :SEQLINEA;
   

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCHECKCERO SELECT :CANTPEDIDA FROM DUAL WHERE :CANTPEDIDA > 0;

CURSOR=CNUMSERIE SELECT :CANTPEDIDA FROM DUAL WHERE :CANTPEDIDA = DECODE(VD.NUMPIECES(:NUMEROSERIE,','),0,:CANTPEDIDA,VD.NUMPIECES(:NUMEROSERIE,',')) ;

CURSOR=CCHECKDESART SELECT :DESART FROM DUAL WHERE :DESART!=(SELECT DESART FROM VDARTIC WHERE CODART=:CODART);

#CURSOR=CINITDATOS SELECT VDST.FPELASERVIR STATUS,:SEQLINEA SEQLINORIG, :SEQLINCAB+1 SEQLINCAB, :SEQLINCAB+1 SEQLINEA,
#                         'E' BACKORDER, 'N' TIPOREDONDEO, 'UN' UNIDADESHOST,
#                         'M' OPCIONPRECIO, 'UN' UNIDADESPRECIO
#                    FROM DUAL;

CURSOR=CINITDATOS SELECT VDST.FPELASERVIR STATUS,
                        (SELECT MAX(SEQLINEA)+1 FROM VDPEDIDORIGLIN WHERE CODPED = :CODPED) SEQLINORIG, 
                        (SELECT MAX(SEQLINEA)+1 FROM VDPEDIDORIGLIN WHERE CODPED = :CODPED) SEQLINCAB, 
                        (SELECT MAX(SEQLINEA)+1 FROM VDPEDIDORIGLIN WHERE CODPED = :CODPED) SEQLINEA,
                         'E' BACKORDER, 'N' TIPOREDONDEO, 'UN' UNIDADESHOST,
                         'M' OPCIONPRECIO, 'UN' UNIDADESPRECIO
                    FROM DUAL;
                    
CURSOR=CCHECKCODCOMEN SELECT :CODCOMEN FROM DUAL WHERE :CODCOMEN = 0;

CURSOR=CASIGNACODCOMEN SELECT VDSECCOMEN.NEXTVAL CODCOMEN FROM DUAL;

CURSOR=CACTNLIN UPDATE VDPEDIDORIGCAB 
                        SET NLINEAS = :SEQLINCAB
                      WHERE CODPED=:CODPED AND CODDIV=:CODDIV;

CURSOR=CUPDSTATUSPED UPDATE VDPEDIDORIGCAB 
                        SET STATUS = VDST.FPECPEDMAN, CODOPEMODIF=VDUSER.GETUSER , FECMODIF=VD.FECHASYS ,HORAMODIF=VD.HORASYS 
                      WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND STATUS=VDST.FPECRECIBIDO;

#FEJECUTAFORM("VDSELCABZONGEO","P","GRUPO='KPI'","","CODZONAGEO=:CODZONAGEO","","S")
CONTEXTUAL=FEJECUTA(FEJECUTAFORM("VDARTIC","N","CODART=:CODART"),"",
                    FPOSICIONACAMPO(FSUCCESS,"CANTPEDIDA"),"")

AYUDA=INSERCION MANUAL DE PEDIDOS
ONLINE=  {F1} Ayuda            {F2} Consulta    {F4} Grabar pedido         {F5} Borrar pantalla 
         {F9} Borrar registro  {Ctrl-F7} Copia  {May-F10} Men� Contextual  {Esc} Salir;
