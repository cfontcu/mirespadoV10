###################################################################
#M�dulo: VDIMPRIMEALBTRANS2.PAN
#Funcionalidad : Relaci�n de series pendientes de imprimir el
#                albar�n de transporte
#Autor: FPD      
#Fecha: 23-04-2008
###################################################################
# Hist�rico de cambios:
IMPRIMIR ALBARAN DE TRANSPORTE PARA SERIES DE EXPEDICION FINALIZADAS 

 �������   SERIES  �������                               �����������    BULTOS     �����������
  Expedici�n  Preparaci�n                      Pedidos    Palets  Cajas   Unidades  TOTAL      Imprimir
  @L@@@@@     @L@@@@@      ___________________ @L@@@@@    @L@@@@  @L@@@@  @L@@@@    @L@@@@@       _
|   


TABLA=VDSERIEEXP
SELECT='N' IMPRIMIR;
WHERE=STATUS=VDST.FSEXFINALIZADA;
ORDERBY=CODSERIEEXP;

WFRAME(15,12,164,0,"Series","")
WFRAME(380,12,188,0,"Bultos","")

POSTQUERY=FDESIGNACION("CCALCULAPEDIDOS","ERROR CALCULANDO NUMERO DE PEDIDOS",
					             "CCALCULABULTOS","ERROR CALCULNADO NUMERO DE BULTOS")

PRECOMMIT=FEJECUTA("CGENCODBOLETA","ERROR NUMERANDO ALBARAN DE TRANSPORTE")

PREUPDATE=FEJECUTA("@CCHECKIMPRIMIR","",
                   "+CPONDATOS","",
                   "-CVERIFBLOQSTOCK","Pedido con stock bloqueado\n"
                                     "Divisi�n: :CODDIV - A�o: :ANOPED - Pedido: :CODPED - Secuencial: :SEQPED\n"
                                     "\n"
                                     "Bulto: :CODBULTO\n"
                                     "\n"
                                     "Art�culo: :CODART - Lote: :CODLOT\n"
                                     "\n"
                                     "Debe extraer el pedido de la serie :CODSERIEEXP",
                   "CUPDAPEDIDOS","No puedo actualizar el pedido",
		               "@CSELALBAPROF","",
		               "CSELPEDIDOS","ERROR SELECCIONANDO PEDIDOS",
                   FWHILE(FERRORCURSOR("CSELPEDIDOS"),
                          FEJECUTA(FIF("CSELNUMALBA",
                                       FEJECUTA("+CSELNOMBREALB","",
                                       FIMPRIME("INFORME",":NOMBREALB","CODDIV=:CODDIV;ANOPED=:ANOPED;CODPED=:CODPED;SEQPED=:SEQPED","",":NUMALBA"),":V10ERROR")
                                      ),"ERROR EN FIF CSELNUMALBA",
                                    FIF("CSELPROFORMA",
                                        FIF("CSELSWTPROFORMA",
                                             FEJECUTA(FIMPRIME("INFORME","VDFACTURAPROFORMA.RPT","CODDIV=:CODDIV;ANOPED=:ANOPED;CODPED=:CODPED;SEQPED=:SEQPED","",":NUMFAC"),":V10ERROR")
                                            )
                                       ),"ERROR EN FIF CSELPROFORMA",
                                   +FFETCHCURSOR("CSELPEDIDOS"),"ERROR EN FETCH")),"ERROR EN WHILE")
                                   

                
POSTCOMMIT=FEJECUTA(FCOMMIT,"",
                    "+CSELNUMBOL","",
                     FIMPRIME("INFORME","$(VDBOLETA)","CODBOLETA=:CODBOLETAAUX;ANOBOLETA=:ANOBOLETAAUX;","",":NUMBOL"),":V10ERROR",
                    +FBORRAFORM,"")

CAMPO=CODAGE,VIRTUAL,OCULTO
CAMPO=CODSERIEEXP,NOENTER,TOOLTIP("C�digo de la serie de expedici�n"),TITULO("Expedici�n"),WLONX=30
CAMPO=CODSERIEPREP,NOENTER,TOOLTIP("C�digo de la serie de preparaci�n"),TITULO("Preparaci�n"),WLONX=35
CAMPO=DESSERIE,NOENTER,TITULO("Descripci�n")
CAMPO=NUMPEDIDOS,AUXILIAR,NOENTER,TOOLTIP("N�mero de pedidos de las series finalizadas"),TITULO("Pedidos"),WLONX=20
CAMPO=BULTOSPAL,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de palet de las series finalizadas"),TITULO("Palets"),WLONX=20
CAMPO=BULTOSCAJ,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de caja completa de las series finalizadas"),TITULO("Cajas"),WLONX=19
CAMPO=BULTOSUNI,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades de las series finalizadas"),TITULO("Unidades"),WLONX=20
CAMPO=TOTALBULTOS,AUXILIAR,NOENTER,TOOLTIP("N�mero total de bultos de las series finalizadas"),TITULO("TOTAL"),WLONX=20
CAMPO=IMPRIMIR,UPPER,AUXILIAR,TOOLTIP("Indica si se imprime el albar�n de transporte o no"),
               POSTCHANGE=FVERIFICA("SN ","Valores posibles\n(S)� (N)o o blanco"),TITULO("I"),CHECKBOX("N","S"),WLONX=10
CAMPO=CODBOLETA,OCULTO,"@L@@@@"
CAMPO=ANOBOLETA,OCULTO,"@@@@"
CAMPO=STATUS,OCULTO,"@L@@@"
CAMPO=CODOPEMODIF,OCULTO,"_32_"
CAMPO=FECMODIF,OCULTO,"@L@@@@@"
CAMPO=HORAMODIF,OCULTO,"_8_"
CAMPO=FECEXPIDE,OCULTO,"@L@@@@@"
CAMPO=HORAEXPIDE,OCULTO,"_8_"
CAMPO=NUMBOL,AUXILIAR,OCULTO,"@@@@@"
CAMPO=NUMALBA,AUXILIAR,OCULTO,"@@@@@"    
CAMPO=NUMFAC,AUXILIAR,OCULTO,"@@@@@"
CAMPO=CODDIV,AUXILIAR,OCULTO,"_20_"
CAMPO=ANOPED,AUXILIAR,OCULTO,"@@@@@"
CAMPO=CODPED,AUXILIAR,OCULTO,"_20_"
CAMPO=SEQPED,AUXILIAR,OCULTO,"@@@@@"
CAMPO=NOMBREALB,AUXILIAR,OCULTO,"_256_"
CAMPO=SWTPROFORMA,AUXILIAR,OCULTO,"__"
CAMPO=CODART,AUXILIAR,OCULTO,"_40_"
CAMPO=CODLOT,AUXILIAR,OCULTO,"_40_"
CAMPO=CODBULTO,AUXILIAR,OCULTO,"_20_"
CAMPO=MSGERROR,OCULTO,"_256_",AUXILIAR


CURSOR=CCALCULAPEDIDOS SELECT COUNT(*) NUMPEDIDOS 
                         FROM VDPEDIDOCAB
					              WHERE CODSERIEEXP=:CODSERIEEXP;

CURSOR=CCALCULABULTOS SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BULTOSUNI,
							               SUM(DECODE(TIPOBULTO,'E',1,0)) BULTOSCAJ,
							               SUM(DECODE(TIPOBULTO,'C',1,0)) BULTOSPAL,
							               COUNT(*) TOTALBULTOS
					              FROM VDBULTOCAB
					             WHERE (CODDIV,ANOPED,CODPED,SEQPED) IN
					                   (SELECT CODDIV,ANOPED,CODPED,SEQPED 
					                      FROM VDPEDIDOCAB
							                 WHERE CODSERIEEXP=:CODSERIEEXP);

CURSOR=CGENCODBOLETA SELECT VDSECCODBOLETA.NEXTVAL CODBOLETAAUX,
                            TO_CHAR(SYSDATE,'YYYY') ANOBOLETAAUX 
                       FROM DUAL;

CURSOR=CCHECKIMPRIMIR SELECT :IMPRIMIR 
                        FROM DUAL 
                       WHERE :IMPRIMIR='S';

CURSOR=CPONDATOS SELECT :CODBOLETAAUX CODBOLETA,:ANOBOLETAAUX ANOBOLETA,
                        VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,
                        VD.HORASYS HORAMODIF,VDST.FSEXEXPEDIDA STATUS,VD.FECHASYS FECEXPIDE,VD.HORASYS HORAEXPIDE
                   FROM DUAL;

# STOCK QUE ESTA EN EXPEDICION Y PERTENECE A PEDIDOS DE LA SERIE QUE ESTAN BLOQUEADOS
CURSOR=CVERIFBLOQSTOCK SELECT DISTINCT BUC.CODDIV,BUC.ANOPED,BUC.CODPED,BUC.SEQPED,
                                       BUC.CODBULTO,STK.CODART,STK.CODLOT
                         FROM VDBULTOCAB BUC,VDBULTOLIN BUL,VDPEDIDOCAB PEC,VDSTOCK STK,VDMOVIM MOV
                        WHERE BUC.CODDIV=PEC.CODDIV AND BUC.ANOPED=PEC.ANOPED AND
                              BUC.CODPED=PEC.CODPED AND BUC.SEQPED=PEC.SEQPED AND
                              BUL.CODBULTO=BUC.CODBULTO AND 
                              PEC.CODSERIEEXP=:CODSERIEEXP  AND
                              BUL.CODART=STK.CODART AND BUL.CODLOT=STK.CODLOT AND MOV.CODMOV=BUL.CODMOV AND
                              MOV.CODMATDEST=STK.CODMAT AND
                              (SELECT MAX(VDSTK.ESTADOCOMPATIBLE(STK.BLOQUEOS,PATRONESTADO)) 
                                 FROM (SELECT DISTINCT PATRONESTADO 
                                         FROM VDFLUJOPARAM 
                                        WHERE VD.CONTIENECAD(VD.GETPROP('FLUJOSIMPRESIONALBTRANS'),TAREA)=1))<0;

CURSOR=CSELALBAPROF SELECT NUMALBA 
                      FROM VDAGENCIA 
                     WHERE CODAGE=:CODAGE AND NUMALBA>0 OR NUMFAC>0;

CURSOR=CSELPEDIDOS SELECT CODDIV,ANOPED,CODPED,SEQPED 
                     FROM VDPEDIDOCAB
		                WHERE CODSERIEEXP=:CODSERIEEXP;

CURSOR=CSELNUMALBA SELECT NUMALBA 
                     FROM VDAGENCIA
                    WHERE CODAGE=:CODAGE AND NUMALBA>0;

CURSOR=CSELNOMBREALB SELECT 'VDALBARAN'||DECODE(SWTVALORADO,'S','V','')||'.RPT' NOMBREALB 
                       FROM VDPEDIDOCAB
                      WHERE CODDIV=:CODDIV AND ANOPED=:ANOPED AND 
                            CODPED=:CODPED AND SEQPED=:SEQPED;

CURSOR=CSELPROFORMA SELECT NUMFAC 
                      FROM VDAGENCIA 
                     WHERE CODAGE=:CODAGE AND NUMFAC>0;

CURSOR=CSELSWTPROFORMA SELECT SWTPROFORMA 
                         FROM VDPEDIDOCAB
                        WHERE CODDIV=:CODDIV AND ANOPED=:ANOPED AND 
                              CODPED=:CODPED AND SEQPED=:SEQPED AND 
                              SWTPROFORMA='S';

CURSOR=CSELNUMBOL SELECT NUMBOL 
                    FROM VDAGENCIA 
                   WHERE CODAGE=:CODAGE AND NUMBOL>0;
                   
CURSOR=CUPDAPEDIDOS UPDATE VDPEDIDOCAB SET STATUS=VDST.FPECEXPEDIDO
                     WHERE CODSERIEEXP=:CODSERIEEXP;
                                                 


TECLA=SF8,FEJECUTA("+CSELNUMBOL","",
                     FIMPRIME("INFORME","$(VDBOLETA)","CODBOLETA=:CODBOLETAAUX;ANOBOLETA=:ANOBOLETAAUX;",""),":V10ERROR",
                    +FBORRAFORM,"")





