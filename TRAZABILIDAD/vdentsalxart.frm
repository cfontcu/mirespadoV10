# M�dulo   : VDENTSALXART.FRM
# Funci�n  : Trazabilidad por art�culo
#
# Creaci�n : 14-08-2008
# Autor    : MGM
###########################################
BEGINBLOQUE=VDARTICTRZ.PAN
  PREREGISTRO=PRESEHIJO
  NOINSERT
  NODELETE
  NOUPDATE
  NOCOMMIT
  POSY=1
  WLONX=630
 CAMPO=TOTALENTRADAS,AUXILIAR,OCULTO,"###############"
 CAMPO=TOTALSALIDAS,AUXILIAR,OCULTO,"###############"
 CAMPO=TOTALSALDO,AUXILIAR,OCULTO,"###############"
 CAMPO=SALDOPARCIAL,AUXILIAR,OCULTO,"###############"
 CAMPO=STOCKACTUAL,AUXILIAR,OCULTO,"###############"
 CAMPO=MIQUERY,AUXILIAR,OCULTO,"_4096_"
 CAMPO=DUMMY,AUXILIAR,OCULTO,"@"
 
  TECLA=SF8,FEJECUTA("CSELBINDNONULO","INFORME ARTICULO",
                     FIMPRIME("INFORME","VDTRAZABILIDAD_STD.rpt","CODART=:CODART;CODLOT=NULL;CODCONCE=NULL;FECDESDE='01-01-01';FECHASTA='01-01-90'",""),":V10ERROR",
					 FCOMMIT,"")
  TECLA=SF9,FEJECUTA("CSELBINDNONULO","INFORME ARTICULO",
                     FIMPRIME("INFORME","VDTRAZABILIDAD_STD.rpt","CODART=:CODART;CODLOT=NULL;CODCONCE='PEDEXPED';FECDESDE='01-01-01';FECHASTA='01-01-90'",""),":V10ERROR",
					 FCOMMIT,"")
# ATENCION!! Se crea un cursor para definir la query y pasarla como par�metro al FSQL2EXCEL por que este trigger no trata bien los parametros de tipo cadena.
  TECLA=SF11,FEJECUTA("CSELBINDNONULO","INFORME ARTICULO",
                     "CDAMESELECT","",
                     FSQL2EXCEL(":MIQUERY","","0","1",""),"")    

  BOTON=B1,640,45,65,65,"EXPORTAEXCEL",EXCEL02.png,SF11,"Exportar a Excel",INCLUDECSS="background-color:transparent;border-width:0px"
  
  BOTON=B2,640,145,65,65,"EXPORTAPDF1",pdffiles01.png,SF8,"Informe Trazabilidad Completo",INCLUDECSS="background-color:transparent;border-width:0px"

#BOTON=B3,900,95,80,80,"EXPORTAPDF2",pdf-files02.png,SF9,"Informe Trazabilidad Pedidos",INCLUDECSS="background-color:transparent;border-width:0px"

  
 CURSOR=CSELBINDNONULO SELECT 1 DUMMY FROM DUAL WHERE :CODART IS NOT NULL; 
 
 CURSOR=CDAMESELECT SELECT 'SELECT ART.CODDIV DIVISION, '||'
                                         TO_CHAR (TO_DATE (MOV.FECFINMOV, ''J''), ''DD-MM-YYYY'')  FECHA, MOV.HORAFINMOV HORA, '||'
                                         MOV.CODART ARTICULO, ART.DESART DESCRIPCION, MOV.CODLOT LOTE, '||'
                                         CASE WHEN UBIO.STOCK = ''N'' THEN ''E'' '||'
                                              WHEN UBID.STOCK = ''N'' THEN ''S'' '||'
                                         ELSE ''I'' END TIPOOPE, SUM(MOV.CANTIDAD) CANTIDAD, '||'
                                         MOV.CODCONCE CONCEPTO, COC.DESCONCE DESCRIPCION, COC.SWTTRAZA TRAZA, '||'
                                         PEC.CODCLIENTE DESTINATARIO, '||'
                                         DECODE(MOV.CODCONCE,''PEDEXPED'',PEC.DESCLIENTE,NVL(MOV.CODOPEEJEMOV,CODOPEINS)) NOMBRE,   '||'
                                         ART.CODARTDIV ART_CODARTDIV, ART.CODEAN ART_CODEAN, ART.CODNAC ART_CODNAC, ART.UNIDADES ART_UNIDADES, ART.UNIEMB ART_UNIXEMB, ART.EMBCONT ART_EMBXCONT, ART.EMBPISO ART_EMBXPISO, ART.SWTACTIVO ART_SWTACTIVO,    '||'
                                         MOV.BLOQUEOSORI MOV_BLOQUEOSORI, MOV.BLOQUEOSDEST MOV_BLOQUEOS_DEST, MOV.CODRECEP MOV_RECEPCION,  '||'
                                         BUC.SEQPED BUC_SEQPED,  '||'
                                         PEC.CODPED PEC_CODPED, PEC.CODDIV PEC_CODDIV, PEC.ANOPED PEC_ANOPED, PEC.DP PEC_DP, PEC.POBLACION PEC_POBLACION, '||'
                                         TRIM (PEC.DIRECCION)|| '' ''|| TRIM (PEC.DIRECCION1)|| '' ''|| TRIM (PEC.DIRECCION2)|| '' ''|| TRIM (PEC.DIRECCION3) PEC_DIRECCION '||'
                                      FROM VDMOVIM MOV, VDBULTOLIN BUL, VDUBICA UBIO, VDUBICA UBID, VDARTIC ART,  '||'
                                           VDCONCEPTO COC, VDBULTOCAB BUC,  VDPEDIDOCAB PEC '||'
                                     WHERE MOV.CODMOV     = BUL.CODMOVEXP(+) '||'
                                       AND MOV.CODUBIORI  = UBIO.CODUBI '||'
                                       AND MOV.CODUBIDEST = UBID.CODUBI '||'
                                       AND MOV.CODART     = ART.CODART '||'
                                       AND MOV.CODCONCE   = COC.CODCONCE '||'
                                       AND MOV.CODCONCE = MOV.CODCONCE '||'
                                       AND MOV.CODART='''||:CODART||''' 
                                       AND MOV.CODLOT= MOV.CODLOT '||'
                                       AND BUL.CODBULTO   = BUC.CODBULTO(+) '||'
                                       AND BUC.CODDIV     = PEC.CODDIV(+) '||'
                                       AND BUC.ANOPED     = PEC.ANOPED(+) '||'
                                       AND BUC.CODPED     = PEC.CODPED(+) '||'
                                       AND BUC.SEQPED     = PEC.SEQPED(+) '||'
                                       AND MOV.CODUBIORI  = UBIO.CODUBI '||'
                                       AND MOV.CODUBIDEST = UBID.CODUBI '||'
                                       AND (UBIO.STOCK    = ''N'' '||'
                                         OR UBID.STOCK    = ''N'' '||'
                                         OR COC.SWTTRAZA   = ''S'') '||'
                                      AND TO_DATE(MOV.FECMODIF, ''J'') BETWEEN TO_DATE( ''01-01-01'', ''DD-MM-YY'') AND TO_DATE( ''01-01-90'', ''DD-MM-YY'') '||'
                                    GROUP BY MOV.CODART, ART.DESART, ART.CODDIV,   '||'
                                         ART.CODARTDIV, ART.CODEAN, ART.CODNAC, ART.UNIDADES, ART.UNIEMB, ART.EMBCONT,  '||'
                                         ART.EMBPISO, ART.SWTACTIVO, '||'
                                         MOV.HORAFINMOV, MOV.CODLOT, MOV.CODCONCE, MOV.BLOQUEOSORI,  '||'
                                         MOV.BLOQUEOSDEST, MOV.CODRECEP, COC.DESCONCE, '||'
                                         COC.SWTTRAZA, BUC.SEQPED, PEC.CODCLIENTE , '||'
                                         DECODE(MOV.CODCONCE,''PEDEXPED'',PEC.DESCLIENTE,NVL(MOV.CODOPEEJEMOV,CODOPEINS)), '||'
                                         PEC.CODPED, PEC.CODDIV, PEC.ANOPED, PEC.DP, PEC.POBLACION, '||'
                                         MOV.FECFINMOV, ART.FECMODIF, '||'
                                         TRIM (PEC.DIRECCION)|| '' ''|| TRIM (PEC.DIRECCION1)|| '' ''|| TRIM (PEC.DIRECCION2)|| '' ''|| TRIM (PEC.DIRECCION3) , '||'
                                         CASE WHEN UBIO.STOCK = ''N'' THEN ''E'' '||'
                                              WHEN UBID.STOCK = ''N'' THEN ''S'' '||'
                                         ELSE ''I'' END '||'
								ORDER BY MOV.CODLOT, MOV.FECFINMOV ' MIQUERY FROM DUAL;
 AYUDA=TRAZABILIDAD
ENDBLOQUE     

BEGINBLOQUE=VDENTSALXART.PAN
  PADRE=VDARTICTRZ.PAN
  PREREGISTRO=PRESEHIJO
  PREQUERY=QUERYHIJO
#  WGRAFICA=TRAZA,600,33,400,210,0

  POSY=21
  REGPAG=17
  WPOSY=315
  NOINSERT
  NODELETE
  NOUPDATE
  NOCOMMIT
  WLONX=950
  WLONY=280
  PREQUERY=FEJECUTA("+CINICIALIZA","",+QUERYHIJO,"",
                    "+CCALCSTOCK","")

  POSTQUERY=FEJECUTA("+CACUMULA","ERROR ACUMULANDO",
                     "+CDAMESALDOPARCIAL","ERROR CALCULANDO EL SALDO PARCIAL",
                     "+CSELBULTO","")
  
  CURSOR=CINICIALIZA SELECT 0 TOTALENTRADAS,0 TOTALSALIDAS,0 TOTALSALDO,0 SALDOPARCIAL FROM DUAL;
  CURSOR=CCALCSTOCK  SELECT NVL(SUM(CANTIDAD),0) STOCKACTUAL FROM VDSTOCK WHERE CODART=:CODART ; 
  CURSOR=CACUMULA Select :TOTALENTRADAS + DECODE(:TRAZASTOCK,'N',0,DECODE(:TIPOOPE,'E',:CANTIDAD,0)) TOTALENTRADAS,
                         :TOTALSALIDAS  + DECODE(:TRAZASTOCK,'N',0,DECODE(:TIPOOPE,'S',:CANTIDAD,0)) TOTALSALIDAS ,
                         :SALDOPARCIAL  + DECODE(:TRAZASTOCK,'N',0,:CANTIDAD) SALDOPARCIAL,
                         :TOTALSALDO  + DECODE(:TRAZASTOCK,'N',0,:CANTIDAD)   TOTALSALDO                          
                  FROM DUAL;
 CURSOR=CDAMESALDOPARCIAL Select :SALDOPARCIAL SALDOPARCIALAUX FROM DUAL;
 
 TECLA=SF8,FEJECUTA(FIMPRIME("INFORME","VDTRAZABILIDAD.rpt","CODART=:CODART;CODLOT='';CODCONCE='';FECDESDE='01-01-01';FECHASTA='31-12-50'",""),":V10ERROR")
 TECLA=SF9,FEJECUTA(FIMPRIME("INFORME","VDTRAZABILIDAD.rpt","CODART=:CODART;CODLOT='';CODCONCE='''PEDEXPED';FECDESDE='01-01-01';FECHASTA='31-12-50'",""),":V10ERROR")
 

CAMPO=CODART,VIRTUAL,OCULTO
CAMPO=TOTALENTRADAS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TOTALSALIDAS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TOTALSALDO,AUXILIAR,VIRTUAL,OCULTO
CAMPO=SALDOPARCIAL,AUXILIAR,VIRTUAL,OCULTO
CAMPO=STOCKACTUAL,AUXILIAR,VIRTUAL,OCULTO
ENDBLOQUE

BEGINBLOQUE=VDENTSALXARTXPED.PAN
  PADRE=VDENTSALXART.PAN
  PREQUERY=QUERYHIJO
  REGPAG=15
  POSX=1
  POSY=42
  WPOSY=600
  WLONX=950
ENDBLOQUE

BEGINBLOQUE=VDENTSALXARTTOT.PAN
  PADRE=VDENTSALXART.PAN
  WPOSY=210
  WPOSX=50
  NOENTER
  POSY=15
#REGPAG=1
  REGPAG=2
  NOINSERT
  NODELETE
  NOUPDATE
#  WMARCOFRAME
ENDBLOQUE

