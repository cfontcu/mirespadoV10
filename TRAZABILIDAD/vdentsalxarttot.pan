# M�dulo   : VDENTSALXARTTOT.PAN
# Funci�n  : Entradas y salidas totales de un art�culo
#
# Creaci�n : 14-08-2008
# Autor    : MGM
###########################################
ENTRADAS Y SALIDAS TOTALES DEL ARTICULO
     Entradas           Salidas         Saldo         Stock actual   
  ###,###,###.###   ###,###,###.### ###,###,###.###  ###,###,###.### 
|

SOLOQUERY
TABLA=DUAL

NOQUERY

CAMPO=TOTALENTRADAS,AUXILIAR,VIRTUAL,NOENTER,TITULO("Entradas")
CAMPO=TOTALSALIDAS,AUXILIAR,VIRTUAL,NOENTER,TITULO("Salidas")
CAMPO=TOTALSALDO,AUXILIAR,VIRTUAL,NOENTER,TITULO("Saldo")
CAMPO=STOCKACTUAL,AUXILIAR,VIRTUAL,NOENTER,TITULO("Stock actual")




