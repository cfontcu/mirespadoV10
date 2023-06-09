###################################################################
#M�dulo: VDINCLUYEPEDSERIE.PAN
#Funcionalidad : Selecci�n de pedidos para la creaci�n de series de preparaci�n
#Autor: FPD      
#Fecha: 09-04-2008
###################################################################
# Hist�rico de cambios:
PEDIDOS PENDIENTES DE INCLUIR EN SERIE
 Pedido             P. Tipo F.Recibido F.entrega  DP       Consignatario                                            Agencia     \Lin\Uni.\Caj.\Pal.  Inc.
 _20__ _20_________ ## ____ �D-MM-Y.YY �D-MM-Y.YY _20_____ _12____ _40_______________ _40__________ _40____________ _30_______  @@@@ @@@@ @@@@ @L@@@  _ 
|

TABLA=VDPEDIDOCAB
ORDERBY=(CASE WHEN PRIORIDAD=1 THEN 0 END),
        (CASE WHEN CODSERIEPREP=:CODSERIEPREP THEN 0 WHEN NVL(CODSERIEPREP,0)=0 THEN 1 ELSE 2 END),
        FECSERVICIO,URGENCIA,PRIORIDAD,CODPED;

SELECT=:TODOS INCLUIR;
PQUERY
TQUERY
NOLOCK

PREBLOQUE=FPREGUNTAR("0")

PREUPDATE=FEJECUTA("CSELSIHAYSERIE","NO HA CREADO UNA SERIE DONDE INCLUIR LOS PEDIDOS",
                   "CSACAPELINSERIE","Error al sacar las l�neas del pedido :CODPED de la serie",                   
                   "CUPMETEPEDERIE","Error al registrar pedido :CODPED en  la serie :CODSERIEPREP ",
                   "CREVISASERIE","Error al revisar estado de la serie de Preparaci�n",
                   FCOMMIT,"")

CAMPO=CODSERIEPREP,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=FECHADESDE,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=FECHAHASTA,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=URGENCIAMIN,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=URGENCIAMAX,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=CODAGEAUX,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=CLIENTEAUX,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO
CAMPO=CODDIVAUX,VIRTUAL,AUXILIAR,NOUPDATE,OCULTO

CAMPO=CODDIV,NOUPDATE
CAMPO=CODPED,NOUPDATE,TOOLTIP("C�digo del pedido"),POSTCHANGE=FDESIGNACION("+CINCLUIR","NO PUEDO INCLUIR","CSELDATOS",""),TITULO("Entrega")
CAMPO=PRIORIDAD,NOUPDATE,TOOLTIP("Prioridad"),TITULO("P")
CAMPO=TIPOPEDIDO,NOUPDATE,TOOLTIP("Identifica el tipo del pedido seg�n criterio de la compa��a. Es recibido del Host y \ntal como se recibe se introduce en la Base de datos. Tiene utilidad para establecer \nrestricciones a la hora de crear series de pedidos."),TITULO("Tipo"),WLONX=5
CAMPO=FECRECEP,TITULO("Recibido"),WLONX=5
CAMPO=FECSERVICIO,NOUPDATE,TOOLTIP("Fecha prevista de servicio del pedido."),TITULO("Entrega"),WLONX=5
CAMPO=DP,NOUPDATE,TOOLTIP("Distrito postal"),TITULO("DP"),WLONX=8
CAMPO=ANOPED,OCULTO,"@@@@",NOUPDATE,TOOLTIP("A�o del pedido"),TITULO("A�o")
CAMPO=SEQPED,OCULTO,"@@@@",NOUPDATE,TOOLTIP("Versi�n del pedido"),TITULO("Sec"),WLONX=15
CAMPO=CODCLIENTE,NOUPDATE,TOOLTIP("Es el c�digo de cliente que realiza el pedido."),TITULO("Cliente"),WLONX=5
CAMPO=DESCLIENTE,NOUPDATE,TOOLTIP("Cliente al que se sirve el pedido\n :DESCLI "),TITULO("Descripci�n"),WLONX=50
CAMPO=DIRECCION,NOUPDATE,TITULO("Direccion")
CAMPO=POBLACION,NOUPDATE,TITULO("Poblacion")
#CAMPO=BACKORDER,NOUPDATE,TOOLTIP("Indicador de backorder recibido del host. Puede tomar los siguientes valores: T= Todas las l�neas del pedido deben servirse en su totalidad(estricto).L=Todas las l�neas deben servirse pero si una l�nea est� servida o no depende de la pol�tica de la l�nea. P=El pedido puede servirse parcialmente "),TITULO("B")
CAMPO=CODAGE,NOUPDATE,OCULTO,"_10_",TOOLTIP("Es el c�digo de la agencia de transporte para el pedido."),
             POSTCHANGE=FDESIGNACION("+CSELDESAGE","NO SE PUEDE OBTENER DESCRIPCI�N DE LA AGENCIA")
CAMPO=DESAGE,AUXILIAR,NOUPDATE,TOOLTIP("Es la descipci�n de la agencia dee transporte para el pedido."),TITULO("Agencia"),WLONX=25
CAMPO=PICOS,AUXILIAR,NOUPDATE,TOOLTIP("N�mero de restos del pedido"),TITULO("Lin.")
CAMPO=UNIDADES,AUXILIAR,NOUPDATE,OCULTO,"@L@@@@@"
CAMPO=BULTOSU,AUXILIAR,NOUPDATE,TOOLTIP("N�mero de restos del pedido"),TITULO("Uni.")
CAMPO=CAJAS,AUXILIAR,NOUPDATE,TOOLTIP("N�mero de cajas aproximadas del pedido"),TITULO("Caj.")
CAMPO=PALETS,AUXILIAR,NOUPDATE,TOOLTIP("N�mero de palets aproximados del pedido"),TITULO("Pal.")
CAMPO=INCLUIR,UPPER,AUXILIAR,TOOLTIP("Indica si este pedido se incluye en la serie"),
              POSTCHANGE=FEJECUTA("CBORRAACUM","CBORRAACUM",FVERMARCADOS("INCLUIR","CTOTALIZA"),"",FRECALCPADRE,""),TITULO("Inc."),WLONX=18,CHECKBOX("N","S")
CAMPO=MAXVOLCAJA,AUXILIAR,NOUPDATE,OCULTO,"#L##############"
CAMPO=TODOS,VIRTUAL,NOUPDATE,AUXILIAR,OCULTO
CAMPO=ESTADO,AUXILIAR,NOUPDATE,OCULTO,"#L#"


CURSOR=CSELDESDIV SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;


CURSOR=CBORRAACUM SELECT 0 TOTPED,0 TOTLIN,0 TOTUNI,0 TOTBU,0 TOTBC,0 TOTBP,0 TOTUNI FROM DUAL;

CURSOR=CTOTALIZA SELECT :TOTPED+1 TOTPED,:TOTLIN+:PICOS TOTLIN,:TOTBU+:BULTOSU TOTBU,:TOTBC+:CAJAS TOTBC,:TOTBP+:PALETS TOTBP,:TOTUNI+:UNIDADES TOTUNI FROM DUAL;

CURSOR=CINCLUIR SELECT DECODE(CODSERIEPREP,0,'N',:CODSERIEPREP,'S') INCLUIR
                  FROM VDPEDIDOCAB 
                 WHERE CODSERIEPREP=:CODSERIEPREP AND 
                       CODDIV=:CODDIV AND ANOPED=:ANOPED AND 
                       CODPED=:CODPED AND SEQPED=:SEQPED; 
                       
CURSOR=CSELDATOS SELECT UNIDADES,LINEASU PICOS,BULTOSU,BULTOSC CAJAS,BULTOSP PALETS
                   FROM TABLE(VDSERIESIMULA.CONSULTADATOS('CODPED='''||:CODPED||''''));

CURSOR=CSELDESAGE SELECT DESAGE
                    FROM VDAGENCIA
                   WHERE CODAGE=:CODAGE;

CURSOR=CSELSIHAYSERIE SELECT :CODSERIEPREP
                                  FROM DUAL 
                                 WHERE (:CODSERIEPREP <> 0 AND :INCLUIR IN ('S','N') ) OR :INCLUIR IS NULL;


#DESHACE LAS RESERVAS DE LAS LINES MARCADAS COMO INCLUIR NO
CURSOR=CSACAPELINSERIE UPDATE VDPEDIDOLIN
                          SET CANTASERVIR=0,STATUS=VDST.FPELASERVIR
                        WHERE CODDIV=:CODDIV AND ANOPED=:ANOPED AND
                                    CODPED=:CODPED AND SEQPED=:SEQPED AND 
                                    STATUS+0 IN (VDST.FPELASERVIR,VDST.FPELANULADADIS) AND :INCLUIR='N'; 
                                    

CURSOR=CUPMETEPEDERIE UPDATE VDPEDIDOCAB 
                         SET CODSERIEPREP=DECODE(:INCLUIR,'S',:CODSERIEPREP,0),
                             STATUS=DECODE(:INCLUIR,'S',VDST.FPECENSERIE,VDST.FPECPDTESERIE),
                             CODOPEMODIF='CREA SERIES',FECMODIF=VD.FECHASYS,HORAMODIF=VD.HORASYS
                       WHERE :INCLUIR IN ('N','S') AND
                             CODDIV=:CODDIV AND ANOPED=:ANOPED AND 
                             CODPED=:CODPED AND SEQPED=:SEQPED 
                             AND STATUS BETWEEN VDST.FPECPDTESERIE AND VDST.FPECPDTELANZAR; 

CURSOR=CREVISASERIE UPDATE VDSERIEPREP SPR SET STATUS=VDST.FSPRCREADA,CODOPEMODIF='CREA SERIES',FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS 
                        WHERE 
                         CODSERIEPREP=:CODSERIEPREP AND 
                         SPR.STATUS BETWEEN VDST.FSPRCREADA+1 AND VDST.FSPRLANZADA-1 AND 
                         (NOT EXISTS (SELECT 1 FROM VDPEDIDOCAB PEC WHERE PEC.CODSERIEPREP=SPR.CODSERIEPREP AND PEC.STATUS=VDST.FPECPDTELANZAR) OR :INCLUIR='S');    

CURSOR=CERRORSEMAFORO SELECT :ESTADO FROM DUAL WHERE :ESTADO=0;
 
CURSOR=CDAMESEMAFORO BEGIN 
                       :ESTADO:=0;                
                       :ESTADO:=VDSEM.DAMESEMAFORO('DISPONIBILIDAD','N');
                     END;@
                       
CURSOR=CLIBERASEMAFORO BEGIN
                         VDSEM.LIBERASEMAFORO('DISPONIBILIDAD');
                       END;@     

CURSOR=CRESETSERIES UPDATE VDSERIEPREP SET STATUS=VDST.FSPRCREADA,CODOPEMODIF='DISPONIBILIDAD',FECMODIF=VD.FECHASYS,HORAMODIF=VD.HORASYS 
                     WHERE STATUS IN (VDST.FSPRCREADA, VDST.FSPRCONDISPONI);
 
CURSOR=CSERIESCALCULADAS UPDATE VDSERIEPREP SPR SET STATUS=VDST.FSPRCONDISPONI,CODOPEMODIF='DISPONIBILIDAD',FECMODIF=VD.FECHASYS,HORAMODIF=VD.HORASYS 
                          WHERE EXISTS (SELECT 1 FROM VDPEDIDOCAB PEC WHERE PEC.CODSERIEPREP=SPR.CODSERIEPREP AND STATUS+0=VDST.FPECPDTELANZAR);
                             
                         
TECLA=SF9,FEJECUTA("CDAMESEMAFORO","ERROR EN PLSQL CDAMESEMAFORO",
                   "CERRORSEMAFORO","SEMAFORO 'DISPONIBILIDAD' OCUPADO",                  
                   FCOMMIT,"",   
                   FLANZATAREASSYNC("-TDISPONIBILIDAD","DISP.LOG -WVDISPONIBILIDAD","2","0"),":V10ERROR",
                   "CRESETSERIES","ERROR ACTUALIZANDO SERIES",
                   "CSERIESCALCULADAS","ERROR EN SERIES CALCULADAS",                    
                   "CLIBERASEMAFORO","ERROR AL LIBERAR SEMAFORO",
                   FCOMMIT,"",
                   +FEJECUTAFORM("VDDISPSERIE.FRM","S","","",""),"",
                   FCOMMIT,"",
                   +FPULSATECLAS("F5","F2"),"")

BOTON=B1,1200,30,120,120,"B1",vertis\confproto.png,SF9,"DISPONIBILIDAD",INCLUDECSS="background-color: transparent;border-width:0px"

