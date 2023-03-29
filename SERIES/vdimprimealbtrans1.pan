###################################################################
#M�dulo: VDIMPRIMEALBTRANS1.PAN
#Funcionalidad : Relaci�n de agencias pendientes de imprimir el
#                albar�n de transporte
#Autor: FPD      
#Fecha: 23-04-2008
###################################################################
# Hist�rico de cambios:
AGENCIAS CON ALBARAN DE TRANSPORTE PENDIENTE DE IMPRESION 
 Agencia    Descripci�n                    Series  Pedidos   Palets  Cajas   Unidades  TOTAL    
 __________ ______________________________ @L@@@@  @L@@@@@   @L@@@@  @L@@@@  @L@@@@    @L@@@@@   
|   

SOLOQUERY
SELECT=SELECT CODAGE,COUNT(*) SERIES
         FROM VDSERIEEXP
	      WHERE STATUS=VDST.FSEXFINALIZADA;
GROUPBY=CODAGE;
ORDERBY=LPAD(CODAGE,10);

WFRAME(423,12,185,0,"Bultos","")
POSTQUERY=FDESIGNACION("CCALCULAPEDIDOS","ERROR CALCULANDO NUMERO DE PEDIDOS",
					             "CCALCULABULTOS","ERROR CALCULNADO NUMERO DE BULTOS")

CAMPO=CODAGE,NOENTER,TOOLTIP("C�digo de la agencia de transporte"),POSTCHANGE=FDESIGNACION("CSELDESAGE","ERROR RECUPERANDO AGENCIA :CODAGE"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia de transporte"),TITULO("Descripci�n")
CAMPO=SERIES,AUXILIAR,NOENTER,TOOLTIP("N�mero de series finalizadas para la agencia"),TITULO("Series"),WLONX=20
CAMPO=NUMPEDIDOS,AUXILIAR,NOENTER,TOOLTIP("N�mero de pedidos de las series finalizadas"),TITULO("Pedidos"),WLONX=20
CAMPO=BULTOSPAL,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de palet de las series finalizadas"),TITULO("Palets"),WLONX=20
CAMPO=BULTOSCAJ,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de caja completa de las series finalizadas"),TITULO("Cajas"),WLONX=18
CAMPO=BULTOSUNI,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades de las series finalizadas"),TITULO("Unidades"),WLONX=21
CAMPO=TOTALBULTOS,AUXILIAR,NOENTER,TOOLTIP("N�mero total de bultos de las series finalizadas"),TITULO("TOTAL"),WLONX=20


CURSOR=CSELDESAGE SELECT DESAGE 
                    FROM VDAGENCIA 
                   WHERE CODAGE=:CODAGE;
                   
CURSOR=CCALCULAPEDIDOS SELECT COUNT(*) NUMPEDIDOS 
                         FROM VDPEDIDOCAB 
					              WHERE CODSERIEEXP IN (SELECT DISTINCT CODSERIEEXP 
					                                      FROM VDSERIEEXP
										                           WHERE STATUS=VDST.FSEXFINALIZADA AND CODAGE=:CODAGE);

CURSOR=CCALCULABULTOS SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BULTOSUNI,
							               SUM(DECODE(TIPOBULTO,'E',1,0)) BULTOSCAJ,
							               SUM(DECODE(TIPOBULTO,'C',1,0)) BULTOSPAL,
							               COUNT(*) TOTALBULTOS
					              FROM VDBULTOCAB 
					             WHERE (CODDIV,ANOPED,CODPED,SEQPED) IN
					                   (SELECT CODDIV,ANOPED,CODPED,SEQPED 
					                      FROM VDPEDIDOCAB
							                 WHERE CODSERIEEXP IN (SELECT DISTINCT CODSERIEEXP 
							                                         FROM VDSERIEEXP
												                              WHERE STATUS=VDST.FSEXFINALIZADA AND CODAGE=:CODAGE));




