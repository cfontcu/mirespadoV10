ZONAS
Zona  PdteEtiq  PdeServir PdteRec.
@L@   @L,@@@@@  @L,@@@@@@ @L,@@@                  
|

SOLOQUERY

SELECT=SELECT TO_CHAR(IDI.CODZONA) CODZONA,COUNT(DISTINCT DECODE(BUC.STATUS,VDST.FBUCPDTEETIQ, BUC.CODBULTO,NULL)) PDTEETIQ,
             COUNT(DISTINCT DECODE(BUC.STATUS,VDST.FBUCPDTESERVIR, BUC.CODBULTO,NULL)) PDTESERVIR,
             COUNT(DISTINCT (CASE WHEN MOV.STATUS IN (VDST.FMOVPDTERUTA,VDST.FMOVESPERARUTA,VDST.FMOVPDTESTOCK,VDST.FMOVSINSTOCK) THEN BUC.CODBULTO ELSE NULL END)) NOLISTOS
    FROM VDBULTOCAB BUC,VDBULTOLIN BUL,
         VDINFODISP IDI,VDMOVIM MOV
   WHERE BUC.STATUS IN (VDST.FBUCPDTEETIQ,VDST.FBUCPDTESERVIR) AND BUC.TIPOBULTO='U' AND
         BUC.CODBULTO=BUL.CODBULTO AND BUL.CODMOV=MOV.CODMOV AND
         MOV.STATUS+0 IN (VDST.FMOVPDTERUTA,VDST.FMOVESPERARUTA,VDST.FMOVPDTERECOGE,VDST.FMOVASIGNADO,VDST.FMOVPDTESTOCK,VDST.FMOVSINSTOCK)  AND 
         BUC.IDINFOPICK=IDI.IDINFOPICK AND BUC.NUMDISP=IDI.NUMDISP
  GROUP BY IDI.CODZONA
  ORDER BY IDI.CODZONA;
  
CAMPO=CODZONA,TITULO("Zona"),WLONX=15
CAMPO=PDTEETIQ,TITULO("Pdte. Etiq"),WLONX=35
CAMPO=PDTESERVIR,TITULO("Pdte. Servir"),WLONX=55
CAMPO=NOLISTOS ,TITULO("Pdte. Recep."),WLONX=55