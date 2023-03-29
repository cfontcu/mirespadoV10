# M�dulo   : VDENTSALARTXFEC.PAN
# Funci�n  : Entradas y salidas de un art�culo por fechas
#
# Creaci�n : 18-08-2008
# Autor    : MGM
###########################################
ENTRADAS Y SALIDAS DE UN ARTICULO
   Fecha   E/S Stk Concepto  Lote        N�mero Serie         Ped.      Cliente                                 Recep.     Cantidad       
�D-MM-Y.YYY _   _  _10______ _20________ _60_________________ _20______ _20______ _60__________________________ _20______ ###,###.###
|

TABLA=MOV
SOLOQUERY

SELECT=SELECT * FROM (
        SELECT MOV.CODART, MOV.FECFINMOV, MOV.HORAFINMOV, 
               DECODE(UBIO.STOCK,'N','E',DECODE(UBID.STOCK,'N','S','I')) TIPOOPE,
               DECODE(UBIO.STOCK,'N','S',DECODE(UBID.STOCK,'N','S','N')) TRAZASTOCK,
               MOV.CODCONCE,
               MOV.CODLOT, MOV.CODRECEP,
               PEC.CODPED, PEC.CODDIV, PEC.ANOPED, PEC.SEQPED, PEC.CODCLIENTE, PEC.DESCLIENTE,
               SUM(MOV.CANTIDAD) CANTIDAD, SUM(MOV.CODMOV) CODMOV,MOV.NUMEROSERIE
        FROM VDMOVIM MOV, VDUBICA UBIO, VDUBICA UBID, VDCONCEPTO COC, VDBULTOLIN BUL, VDBULTOCAB BUC, VDPEDIDOCAB PEC
        WHERE MOV.CODUBIORI = UBIO.CODUBI AND
              MOV.CODUBIDEST = UBID.CODUBI AND
              MOV.CODCONCE = COC.CODCONCE AND 
              (UBIO.STOCK = 'N' OR UBID.STOCK = 'N' OR COC.SWTTRAZA = 'S') AND
              MOV.CODMOV = BUL.CODMOVEXP(+) AND
              BUL.CODBULTO = BUC.CODBULTO(+) AND
              BUC.CODPED = PEC.CODPED(+) AND
              BUC.CODDIV = PEC.CODDIV(+) AND
              BUC.ANOPED = PEC.ANOPED(+) AND
              BUC.SEQPED = PEC.SEQPED(+) AND
              MOV.CODART = :CODART AND
              MOV.FECFINMOV <= :FECHASTA AND
              MOV.FECFINMOV >= :FECDESDE
        GROUP BY MOV.CODART, MOV.FECFINMOV, MOV.HORAFINMOV, DECODE(UBIO.STOCK,'N','E',DECODE(UBID.STOCK,'N','S','I')), 
              DECODE(UBIO.STOCK,'N','S',DECODE(UBID.STOCK,'N','S','N')), MOV.CODCONCE, MOV.CODLOT, MOV.CODRECEP,MOV.NUMEROSERIE,
              PEC.CODPED, PEC.CODDIV, PEC.ANOPED, PEC.SEQPED, PEC.CODCLIENTE, PEC.DESCLIENTE)
       WHERE 1=1;              
ORDERBY=FECFINMOV, HORAFINMOV, CODMOV;
TABLA=MOV       

CAMPO=FECDESDE,VIRTUAL,AUXILIAR,OCULTO
CAMPO=FECHASTA,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODART,VIRTUAL,AUXILIAR,OCULTO

CAMPO=FECFINMOV,NOPREF,TOOLTIP("Fecha final del movimiento"),TITULO("Fecha")
CAMPO=HORAFINMOV,NOPREF,OCULTO,"_8______"
CAMPO=TIPOOPE,NOPREF,TOOLTIP("Tipo de Operaci�n: E - Entrada, S - Salida, I - Interna"),TITULO("E/S"),WLONX=20
CAMPO=TRAZASTOCK,NOPREF,TOOLTIP("S - Movimiento que varia la cantidad de stock, N - Movimiento que no varia la cantidad de stock"),TITULO("Stk"),WLONX=15
CAMPO=CODCONCE,NOPREF,TOOLTIP("Concepto del movimiento"),TITULO("Concepto")
CAMPO=CODLOT,NOPREF,TOOLTIP("Codigo del lote"),TITULO("Lote")
CAMPO=NUMEROSERIE,TOOLTIP("N�mero de serie"),TITULO("N�m.Serie")
CAMPO=CODPED,NOPREF,TOOLTIP("C�digo del pedido"),TITULO("Pedido")
CAMPO=CODDIV,OCULTO,"____"
CAMPO=ANOPED,OCULTO,"@@@@"
CAMPO=SEQPED,OCULTO,"@@@"
CAMPO=CODCLIENTE,NOPREF,TOOLTIP("Cliente al que va dirigido el pedido"),TITULO("Cliente")
CAMPO=DESCLIENTE,NOPREF,TOOLTIP("Descripcion del cliente"),TITULO("Nombre Cliente")
CAMPO=CODRECEP,NOPREF,TOOLTIP("C�digo de recepci�n de la mercanc�a"),TITULO("Recep.")
CAMPO=CANTIDAD,NOPREF,TOOLTIP("Cantidad"),TITULO("Cantidad")
CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"
		  	          



