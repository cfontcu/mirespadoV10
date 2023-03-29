###################################################################
#M�dulo: VDFALTAS.PAN
#Funcionalidad : Presenta las faltas de stock de l�neas de pedido al pasar la disponibilidad
#Autor: FGS      
#Fecha: 28-04-2008
###################################################################
# Hist�rico de cambios:
FALTAS DE PEDIDOS
                                                                                      
Pedido                         L�nea Art�culo   Lote       Marca Sock   Numero Serie Stk Disponible   Prereservado    Cant. Falta      
_20____________ _20___ @@@@ @@@  @@@@  _40_______ _40_______ _60_________ _60_________ ###,###,###.### ###,###,###.### ###,###,###.### _10_
|


TABLA=VDFALTAS
REGPAG=20
POSTQUERY=FEJECUTA("CSELDATOS","")


CAMPO=CODPED,NOENTER,TITULO("Pedido")
CAMPO=CODDIV,NOENTER,TITULO("Divisi�n")
CAMPO=ANOPED,NOENTER,TITULO("A�o")
CAMPO=SEQPED,NOENTER,TITULO("Secuencia")
CAMPO=SEQLINEA,NOENTER,TITULO("Linea")
CAMPO=CODART,NOENTER,AUXILIAR,TITULO("Art�culo")
CAMPO=CODLOT,NOENTER,AUXILIAR,TITULO("Lote")
CAMPO=MARCASTK,NOENTER,AUXILIAR,TITULO("MarcaStk")
CAMPO=NUMEROSERIE,NOENTER,AUXILIAR,TITULO("N�mero Serie")
CAMPO=DISPONIBLE,NOENTER,TITULO("Disponible")
CAMPO=DESCONTADO,OCULTO,"#L#######"
CAMPO=PRERESERVADO,OCULTO,"#L#######"
CAMPO=TOTALPRERESERVA,AUXILIAR,NOENTER
CAMPO=CANTFALTA,NOENTER
CAMPO=UNIDADESHOST,AUXILIAR,NOENTER

CURSOR=CSELDATOS SELECT :DESCONTADO+:PRERESERVADO TOTALPRERESERVA,PEL.CODART,CODLOT,MARCASTK,NUMEROSERIE,ART.UNIDADESHOST
                   FROM VDPEDIDOLIN PEL, VDARTIC ART 
                   WHERE PEL.CODDIV=:CODDIV AND
                         PEL.ANOPED=:ANOPED AND
                         PEL.CODPED=:CODPED AND
                         PEL.SEQPED=:SEQPED AND
                         PEL.SEQLINEA=:SEQLINEA AND
                         PEL.CODART = ART.CODART;


