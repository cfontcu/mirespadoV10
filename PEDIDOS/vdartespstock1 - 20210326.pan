###################################################################
#M�dulo: VDARTESPSTOCK1.PAN
#Funcionalidad : Consulta GLOBAL de COMENTARIOS de Reserva de Pedidos Esperando Stock
#Autor: FGS      
#Fecha: 01-04-2008
###################################################################
#Hist�rico de cambios:
FALTAS DE STOCK GLOBAL EN LA RESERVA
                        
Art�culo   Designaci�n                    Unid. Pedido       Reservado    Por Reservar Pedidos Stock    Bloqueado
_40_______ _100__________________________ _10__ #L#,###,#### #L#,###,#### #L#,###,#### #L###   #L,##### #L,#####
|


SOLOQUERY
TABLA=PEL
SELECT=
        SELECT PEL.CODART,ART.DESART,  ART.UNIDADESHOST,
               VDART.VD2HOST(SUM(TO_NUMBER(VD.PIECE(COMENTARIO,'#',2))),PEL.CODART) TOTALPEDIDO,
               VDART.VD2HOST(SUM(TO_NUMBER(VD.PIECE(COMENTARIO,'#',4))),PEL.CODART) TOTALRES,
               VDART.VD2HOST(SUM(TO_NUMBER(VD.PIECE(COMENTARIO,'#',2)))-SUM(TO_NUMBER(VD.PIECE(COMENTARIO,'#',4))),PEL.CODART) FALTAS,
               ART.DECIMALES TOTALPEDIDO__DECIMALES,
               ART.DECIMALES TOTALRES__DECIMALES,
               ART.DECIMALES FALTAS__DECIMALES,
               COUNT(DISTINCT PEC.CODDIV||' '||PEC.ANOPED||' '||PEC.CODPED||' '||PEC.SEQPED) NUMPED
          FROM VDPEDIDOCAB PEC, VDPEDIDOLIN PEL, VDCOMEN COM , VDARTIC ART
          WHERE COM.CODCOMEN=PEL.CODCOMEN AND
                PEC.CODDIV = PEL.CODDIV AND
                PEC.ANOPED = PEL.ANOPED AND
                PEC.CODPED = PEL.CODPED AND
                PEC.SEQPED = PEL.SEQPED AND
                PEC.STATUS = VDST.FPECPDTESTOCK AND
                PEL.CODART = ART.CODART AND
                COM.TIPOCOMEN='RESERVA';
GROUPBY=PEL.CODART,ART.DESART, ART.UNIDADESHOST, ART.DECIMALES;
ORDERBY=TOTALPEDIDO-TOTALRES DESC;

POSTQUERY=FDESIGNACION("CSELSTOCK","")


CAMPO=CODART,UPPER,TOOLTIP("Es el C�digo del art�culo a servir"),TITULO("Art�culo")
CAMPO=DESART
CAMPO=UNIDADESHOST,NOENTER,TITULO("Unid.")
CAMPO=TOTALPEDIDO,TITULO("Pedido")
CAMPO=TOTALRES,TITULO("Reservado")
CAMPO=FALTAS,TITULO("Por reservar"),WLONX=-25
CAMPO=CODLOT,AUXILIAR,OCULTO,"_40__________"
CAMPO=NUMPED,NOENTER,TOOLTIP("N�mero de Pedidos que esperan stock del art�culo"),TITULO("Num.Pedidos"),WLONX=70
CAMPO=STOCK,NOENTER
CAMPO=BLOQUEADO,NOENTER


CURSOR=CSELSTOCK SELECT SUM(CANTIDAD) STOCK,SUM((CASE WHEN BLOQUEOSS='S' OR BLOQUEOS!='0000000000' THEN CANTIDAD ELSE 0 END)) BLOQUEADO 
                  FROM VDSTOCK STK,VDCONTE CNT,VDUBICA UBI
                  WHERE STK.CODART=:CODART AND CNT.CODMAT=STK.CODMAT AND UBI.CODUBI!='EXP' AND UBI.CODUBI=CNT.CODUBI;




