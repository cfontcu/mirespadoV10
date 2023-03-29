###################################################################
#M�dulo: VDPEDIDOSSERIE.PAN
#Funcionalidad : Presenta los pedidos incluidos en la serie
#Autor: FPD      
#Fecha: 18-04-2008
###################################################################
# Hist�rico de cambios:
PEDIDOS ASOCIADOS A LA SERIE
                                                                                ���  BULTOS  ���      ������  L�neas ������
Pedido          Div. A�o  Sec. Cliente       Fecha Serv. Est. Poblaci�n       B  Pal. Caj. Uni.  Resto Total Faltas NoServ. Incl. Completo
_20____________ _20_ @@@@ @@@  _40__________ �D-MM-Y.YY  _____ _40____________ _ @@@@ @@@@ @@@@  @L@@@  @@@@  @@@@   @@@@    _      _
|

TABLA=VDPEDIDOCAB
WHERE = CODSERIEPREP > 0  AND (CODAGE=:CODAGE OR :CODAGE IS NULL);

POSTQUERY=FEJECUTA("CSELINCLUIDO","Error al obtener como incluido, el pedido en la serie",
                   "CSELCOMPLETO","Error al marcar como incluido el pedido en la serie",
                   "+CSELVOL","","+CSELDATOS","","+CSELLINEAS","")


PREUPDATE=FEJECUTA("CSACAPELINSERIE","Error al sacar las l�neas del pedido :CODPED de la serie",
                   "CSACAPEDSERIE","Error al sacar el pedido :CODPED de la serie",
                   "CREVISASERIE","Error al revisar estado de la serie de Preparaci�n")
WFRAME(572,-2,129,0,"Bultos","")                   
WFRAME(750,-2,148,0,"L�neas","")


CAMPO=CODSERIEPREP,VIRTUAL,OCULTO
CAMPO=CODAGE,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODPED,NOUPDATE,TOOLTIP("C�digo del pedido"),TITULO("Cod. Pedido")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("Division o compa�ia del pedido"),TITULO("Div.")
CAMPO=ANOPED,NOUPDATE,TOOLTIP("A�o del pedido"),TITULO("A�o"),WLONX=15
CAMPO=SEQPED,NOUPDATE,TOOLTIP("Versi�n del pedido"),TITULO("Sec."),WLONX=15
CAMPO=DESCLIENTE,NOUPDATE,TOOLTIP("Cliente al que se sirve el pedido\n :DESCLI "),TITULO("Cliente")
CAMPO=FECSERVICIO,NOUPDATE,TOOLTIP("Fecha prevista de servicio del pedido."),TITULO("Fecha Serv."),WLONX=24
CAMPO=CODPROV,NOUPDATE,TOOLTIP("Estado al que se env�a el pedido"),TITULO("Est."),WLONX=18
CAMPO=POBLACION,NOUPDATE,TOOLTIP("Poblaci�n a la que se env�a el pedido.\n :POBLACION"),TITULO("Poblaci�n")
CAMPO=BACKORDER,NOUPDATE,TOOLTIP("Backorder del Pedido, (T)otal o (P)arcial"),TITULO("B")
CAMPO=PALETS,AUXILIAR,NOENTER,TOOLTIP("N�mero de palets aproximados del pedido"),TITULO("Pal."),WLONX=15
CAMPO=CAJAS,AUXILIAR,NOENTER,TOOLTIP("N�mero de cajas aproximadas del pedido"),TITULO("Caj."),WLONX=15
CAMPO=BULTOSUNI,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades aproximados del pedido"),TITULO("Uni."),WLONX=15
CAMPO=PICOS,AUXILIAR,NOENTER,TOOLTIP("N�mero de picos del pedido"),TITULO("Picos"),WLONX=17
CAMPO=LINEAS,AUXILIAR,NOENTER,TOOLTIP("N�mero de l�neas del pedido"),TITULO("Total"),WLONX=17
CAMPO=FALTAS,AUXILIAR,NOENTER,TOOLTIP("L�neas con Faltas en el Pedido"),TITULO("Faltas"),WLONX=20
CAMPO=ANULADAS,AUXILIAR,NOENTER,TOOLTIP("L�neas a no servir en el Pedido"),TITULO("NoServ."),WLONX=21
CAMPO=INCLUIR,AUXILIAR,UPPER,TOOLTIP("Indica si este pedido se incluye en la serie"),TITULO("Incl."),WLONX=12,CHECKBOX("N","S")
CAMPO=COMPLETO,AUXILIAR,NOENTER,UPPER,TOOLTIP("Indica si se puede reservar competo, es decir, se puede reservar todo el stock que pide."),TITULO("Completo"),WLONX=50
CAMPO=MAXVOLCAJA,AUXILIAR,OCULTO,"#L##############"

 
CURSOR=CSELINCLUIDO SELECT 'S' INCLUIR FROM DUAL;
 
CURSOR=CSELCOMPLETO SELECT DECODE(SUM(PEL.CANTPEDIDA),SUM(PEL.CANTASERVIR),'S','N') COMPLETO 
                      FROM VDPEDIDOCAB PEC,VDPEDIDOLIN PEL
                     WHERE PEL.CODDIV=PEC.CODDIV AND PEL.ANOPED=PEC.ANOPED AND 
                           PEL.CODPED=PEC.CODPED AND PEL.SEQPED=PEC.SEQPED AND  
                           PEC.CODDIV=:CODDIV AND PEC.ANOPED=:ANOPED AND
                           PEC.CODPED=:CODPED AND PEC.SEQPED=:SEQPED; 

CURSOR=CSELVOL SELECT MAX(LARGOCAJA*ANCHOCAJA*ALTOCAJA) MAXVOLCAJA
                  FROM VDCAJAS 
                  WHERE  TIPOVOL IN (SELECT DISTINCT TIPOVOL 
                                      FROM VDARTIC ART,VDPEDIDOLIN PEL  
					                                     WHERE PEL.CODDIV=:CODDIV AND PEL.ANOPED=:ANOPED AND 
                                           PEL.CODPED=:CODPED AND PEL.SEQPED=:SEQPED AND
                                           PEL.STATUS+0=VDST.FPELASERVIR AND 
                                           PEL.CODART||''=ART.CODART);

CURSOR=CSELLINEAS SELECT COUNT(*) LINEAS,
                         SUM(DECODE(STATUS,VDST.FPELANULADADIS,1,0)) FALTAS,
                         SUM(DECODE(STATUS,VDST.FPELNOSERVIR,1,0)) ANULADAS
                      FROM VDPEDIDOLIN PEL
                      WHERE PEL.CODDIV=:CODDIV AND PEL.ANOPED=:ANOPED AND 
                            PEL.CODPED=:CODPED AND PEL.SEQPED=:SEQPED;
                       
                         
                         
CURSOR=CSELDATOS SELECT SUM(DECODE(ART.EMBCONT,0,0,FLOOR(FLOOR(CANTPEDIDA/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))/ART.EMBCONT))) PALETS,
                        ABS(SUM(DECODE(ART.EMBCONT, 0,0,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)*FLOOR(FLOOR(CANTPEDIDA/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))/ART.EMBCONT))) - 
                            SUM(FLOOR(CANTPEDIDA/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))) CAJAS,
                        CEIL(SUM(MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)) * LARGOUNI*ANCHOUNI*ALTOUNI) / :MAXVOLCAJA) BULTOSUNI,
                        SUM(MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))) PICOS
                   FROM VDPEDIDOLIN PEL,VDARTIC ART
                  WHERE PEL.CODDIV=:CODDIV AND PEL.ANOPED=:ANOPED AND 
                        PEL.CODPED=:CODPED AND PEL.SEQPED=:SEQPED AND
                        PEL.STATUS+0=VDST.FPELASERVIR AND 
                        PEL.CODART||''=ART.CODART;


#DESHACE LAS RESERVAS DE LAS LINES MARCADAS COMO INCLUIR NO
CURSOR=CSACAPELINSERIE UPDATE VDPEDIDOLIN
                          SET CANTASERVIR=0 , STATUS=VDST.FPELASERVIR
                        WHERE CODDIV=:CODDIV AND ANOPED=:ANOPED AND
			                        CODPED=:CODPED AND SEQPED=:SEQPED AND 
			                        STATUS+0 IN (VDST.FPELASERVIR,VDST.FPELANULADADIS) AND :INCLUIR='N'; 
			                        
#SACA EL PEDIDO MARCADO COMO INCLUIR NO DE LA SERIE
CURSOR=CSACAPEDSERIE UPDATE VDPEDIDOCAB
                        SET CODSERIEPREP=0,STATUS=VDST.FPECPDTESERIE,
                        CODOPEMODIF='DISPONIBILIDAD',FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS  
                      WHERE CODDIV=:CODDIV AND ANOPED=:ANOPED AND
			                      CODPED=:CODPED AND SEQPED=:SEQPED AND 
			                      :INCLUIR='N'; 

CURSOR=CREVISASERIE UPDATE VDSERIEPREP SPR SET STATUS=VDST.FSPRCREADA,CODOPEMODIF='DISPONIBILIDAD',FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS 
                        WHERE 
                         CODSERIEPREP=:CODSERIEPREP AND SPR.STATUS+0 BETWEEN VDST.FSPRCREADA+1 AND VDST.FSPRLANZADA-1 AND
                         NOT EXISTS (SELECT 1 FROM VDPEDIDOCAB PEC WHERE PEC.CODSERIEPREP=SPR.CODSERIEPREP AND PEC.STATUS+0=VDST.FPECPDTELANZAR);    
                  

TECLA=SF9,FEJECUTAFORM("VDFALTASPEDIDO","A","CODDIV=:CODDIV AND ANOPED=:ANOPED AND CODPED=:CODPED AND SEQPED=:SEQPED","","","FALTAS DEL PEDIDO :CODDIV :ANOPED :CODPED :SEQPED")






