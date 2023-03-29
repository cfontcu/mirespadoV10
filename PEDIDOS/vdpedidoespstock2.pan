###################################################################
#M�dulo: VDPEDIDOESPSTOCK2.PAN
#Funcionalidad : Consulta de COMENTARIOS de Reserva de L�neas de Pedido
#Autor: FGS      
#Fecha: 31-03-2008
###################################################################
#Hist�rico de cambios:
FALTAS DE STOCK EN LA RESERVA
                                                                     ���������� Unidades ������������  ������� Embalajes �������   ������� Contenedores �������
L�n    Art�culo                             Lote     unid.  Pedido     Reservado  L�m         Pedido     Reservado  L�mite Pedido     Reservado   Minpal   
@L@@@@ _40_________ _100___________________ _40_____ _10__  ##,###,### ##,###,### ##,###,###  ##,###,### ##,###,### @L@@   ##,###,### ##,###,###  @L@
|


SOLOQUERY
TABLA=PEL
 
# TO_NUMBER(VD.PIECE(COMENTARIO,'#',2)) TOTALPEDIDO,TO_NUMBER(VD.PIECE(COMENTARIO,'#',4)) TOTALRES,
             
SELECT=SELECT SEQLINEA, PEL.CODART, PEL.CODLOT, ART.UNIDADESHOST,ART.DESART,
  	          VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',2)),ART.CODART) TOTALPEDIDO,            
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',8)),ART.CODART)  CONTEPEDIDO,
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',10)),ART.CODART) CONTERES,
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',14)),ART.CODART) EMBAPEDIDO,
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',16)),ART.CODART) EMBARES,
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',20)),ART.CODART) UNIPEDIDO,
              VDART.VD2HOST(TO_NUMBER(VD.PIECE(COMENTARIO,'#',22)),ART.CODART) UNIRES,   
              ART.DECIMALES  MAXUNI__DECIMALES, 
              ART.DECIMALES  TOTALPEDIDO__DECIMALES,              
              ART.DECIMALES  CONTEPEDIDO__DECIMALES,
              ART.DECIMALES  CONTERES__DECIMALES,
              ART.DECIMALES  EMBAPEDIDO__DECIMALES,
              ART.DECIMALES  EMBARES__DECIMALES,
              ART.DECIMALES  UNIPEDIDO__DECIMALES,
              ART.DECIMALES  UNIRES__DECIMALES,              
              TO_NUMBER(vd.PIECE(COMENTARIO,'#',24)) MINPAL,           
              TO_NUMBER(vd.PIECE(COMENTARIO,'#',26)) MAXUNI,
              VDART.VD2HOST(TO_NUMBER(vd.PIECE(COMENTARIO,'#',28)),ART.CODART)  MAXCAJA
          FROM VDPEDIDOLIN PEL, VDCOMEN COM , VDARTIC ART
          WHERE COM.CODCOMEN=PEL.CODCOMEN AND
                PEL.CODART=ART.CODART AND
                COM.TIPOCOMEN='RESERVA';
ORDERBY=SEQLINEA;
WFRAME(380,-2,212,0,"Unidades","")
WFRAME(600,-2,160,0,"Embalajes","")
WFRAME(762,-2,195,0,"Contenedores","")

CAMPO=CODDIV,VIRTUAL,OCULTO
CAMPO=ANOPED,VIRTUAL,OCULTO
CAMPO=CODPED,VIRTUAL,OCULTO
CAMPO=SEQPED,VIRTUAL,OCULTO
CAMPO=SEQLINEA,TOOLTIP("N�mero secuencial de linea"),TITULO("L�n")
CAMPO=CODART,UPPER,TOOLTIP("Es el C�digo del art�culo a servir"),TITULO("Art�culo")
CAMPO=DESART,NOENTER
CAMPO=CODLOT,UPPER,TOOLTIP("Es el lote del art�culo.\nSi viene informado se servir� dicho lote,\nen caso contrario el sistema decide el lote a servir."),TITULO("Lote")
CAMPO=UNIDADESHOST,NOENTER,TITULO("Unid")
CAMPO=TOTALPEDIDO,TITULO("Total Pedido"),WLONX=40,OCULTO,"@@@@@@"
#CAMPO=TOTALRES
CAMPO=UNIPEDIDO,TITULO("Pedido")
CAMPO=UNIRES,TITULO("Reservado")
CAMPO=MAXUNI,TOOLTIP("L�mite a Servir en Unidades del Art�culo. (MAXUNI)"),TITULO("L�mite")
CAMPO=EMBAPEDIDO,TITULO("Pedido")
CAMPO=EMBARES,TITULO("Reservado")
CAMPO=MAXCAJA,TOOLTIP("N�mero de cajas l�mites a servir como cajas completas. (MAXCAJA)"),TITULO("Lim")
CAMPO=CONTEPEDIDO,TITULO("Pedido")
CAMPO=CONTERES,TITULO("Reservado")
CAMPO=MINPAL,TOOLTIP("M�nimo n�mero de cajas a reservar para servir un palet como bulto completo. (MINPAL)"),TITULO("Minpal"),WLONX=30

#zoom para consultar articulo
#zoon para consultar lote
#zoom para consultar stock del articulo
#zoom para consultar stock del articulo y lote
#movimientos del art�culo
 



