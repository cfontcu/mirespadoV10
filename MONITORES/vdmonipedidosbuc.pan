# M�dulo   : VDMONIBULTOSST.PAN
# Funci�n  : Monitor de bultos pendientes. Desglose por estados
#
# Creaci�n : 04-08-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
#
RESUMEN BULTOS DEL PEDIDO
 Tipo Estado Descripci�n                    Total  
  _1  @L@@@@ _30___________________________ @L@@@@ 
|

SOLOQUERY
SELECT=SELECT BUC.TIPOBULTO,BUC.STATUS, STA.DESSTATUS, COUNT(DISTINCT BUC.CODBULTO) TOTAL
         FROM VDBULTOCAB BUC, VDSTATUS STA
        WHERE BUC.CODPED = :CODPED AND BUC.CODDIV = :CODDIV AND
              BUC.ANOPED = :ANOPED AND BUC.SEQPED = :SEQPED AND
              STA.STATUS = BUC.STATUS AND STA.TIPOSTATUS = 'BUC';

GROUPBY=BUC.TIPOBULTO,BUC.STATUS,STA.DESSTATUS;
ORDERBY=DECODE(BUC.TIPOBULTO,'U',0,'C',1,2),STATUS;


CAMPO=CODPED,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODDIV,AUXILIAR,VIRTUAL,OCULTO
CAMPO=ANOPED,AUXILIAR,VIRTUAL,OCULTO
CAMPO=SEQPED,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TIPOBULTO,NOENTER,TOOLTIP("Tipo de bulto"),TITULO("Tipo"),WLONX=15
CAMPO=STATUS,NOENTER,TOOLTIP("Estado del bulto"),TITULO("Estado")
CAMPO=DESSTATUS,NOENTER,TOOLTIP("Descripcion del estado del bulto"),TITULO("Descripci�n")
CAMPO=TOTAL,NOENTER,TOOLTIP("Numero total de bultos que estan en este estado"),TITULO("Total")



