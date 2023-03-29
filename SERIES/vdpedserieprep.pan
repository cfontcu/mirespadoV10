###################################################################
#M�dulo: VDPEDSERIEPREP.PAN
#Funcionalidad : Presenta los pedidos de una serie de preparaci�n
#Autor: FPD      
#Fecha: 18-04-2008
###################################################################
# Hist�rico de cambios:
PEDIDOS DE LA SERIE
Pedido          Cliente           Tipo   Estado                      
_20____________ _40______________ _10___ @L@@@ ____________________
|

TABLA=VDPEDIDOCAB
WHERE=CODSERIEPREP>0;
ORDERBY=PEDIDOHOST,CODPED;



CAMPO=CODSERIEPREP,VIRTUAL,OCULTO
CAMPO=CODPED,NOUPDATE,TOOLTIP("Pedido"),TITULO("Pedido")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("Division o compa�ia del pedido"),TITULO("Div."),OCULTO,"_20___"
CAMPO=ANOPED,NOUPDATE,TOOLTIP("A�o del pedido"),TITULO("A�o"),OCULTO,"@L@@"
CAMPO=SEQPED,NOUPDATE,TOOLTIP("Versi�n del pedido"),TITULO("Sec."),WLONX=19,OCULTO,"@L@"
CAMPO=PEDIDOHOST,NOUPDATE,TITULO("Ped.Host")
CAMPO=TIPOPEDIDO,NOUPDATE,TOOLTIP("Tipo"),TITULO("Tipo")
CAMPO=STATUS,NOUPDATE,TOOLTIP("Estado del pedido"),POSTCHANGE=FDESIGNACION("CSELSTATUS","Error obteniendo estado"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado en el que se encuentra el pedido")

CURSOR=CSELDESAGE SELECT DESAGE 
                    FROM VDAGENCIA
                   WHERE CODAGE=:CODAGE;

CURSOR=CSELSTATUS SELECT DESSTATUS
                    FROM VDSTATUS
                   WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';
				   
                    






