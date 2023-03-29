###################################################################
#M�dulo: VDPEDSERIEEXP.PAN
#Funcionalidad : Presenta los pedidos de una serie de expedici�n
#Autor: FPD      
#Fecha: 22-04-2008
###################################################################
# Hist�rico de cambios:
PEDIDOS DE LA SERIE DE EXPEDICION
Pedido          Div. A�o  Sec. Cliente          Tipo   Fecha Serv. Prov. Poblaci�n             Agencia        Estado                      
_20____________ _20_ @@@@ @@@  _40_____________ _10___ �D-MM-Y.YY  _____ _40__________________ _30___________ @L@@@ ____________________
|

TABLA=VDPEDIDOCAB
WHERE = CODSERIEEXP > 0 ;


CAMPO=CODSERIEEXP,VIRTUAL,OCULTO
CAMPO=CODPED,NOUPDATE,TOOLTIP("C�digo del pedido"),TITULO("Cod. del Pedido")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("Division o compa�ia del pedido"),TITULO("Div.")
CAMPO=ANOPED,NOUPDATE,TOOLTIP("A�o del pedido"),TITULO("A�o")
CAMPO=SEQPED,NOUPDATE,TOOLTIP("Versi�n del pedido"),TITULO("Sec."), WLONX=20
CAMPO=DESCLIENTE,NOUPDATE,TOOLTIP("Cliente al que se sirve el pedido\n :DESCLIENTE "),TITULO("Cliente")
CAMPO=TIPOPEDIDO,NOUPDATE,TOOLTIP("Tipo del pedido"),TITULO("Tipo")
CAMPO=FECSERVICIO,NOUPDATE,TOOLTIP("Fecha prevista de servicio del pedido."),TITULO("Fecha Serv."), WLONX=30
CAMPO=CODPROV,NOUPDATE,TOOLTIP("Provincia a la que se env�a el pedido"),TITULO("Prov.")
CAMPO=POBLACION,NOUPDATE,TOOLTIP("Poblaci�n a la que se env�a el pedido.\n :POBLACION"),TITULO("Poblaci�n")
CAMPO=CODAGE,OCULTO,"_10_",POSTCHANGE=FDESIGNACION("CSELDESAGE","Error obteniendo agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia\n :DESAGE"),TITULO("Agencia")
CAMPO=STATUS,NOUPDATE,TOOLTIP("Estado del pedido"),POSTCHANGE=FDESIGNACION("CSELSTATUS","Error obteniendo estado"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado en el que se encuentra el pedido")
CAMPO=NEWCODSERIEEXP,AUXILIAR,OCULTO,"@L@@@@"

CURSOR=CSELDESAGE SELECT DESAGE 
                    FROM VDAGENCIA
                   WHERE CODAGE=:CODAGE;

CURSOR=CSELSTATUS SELECT DESSTATUS
                    FROM VDSTATUS
                   WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';

CURSOR=CSELNOIMPRESA SELECT CODSERIEEXP FROM VDSERIEEXP 
                      WHERE CODSERIEEXP=:CODSERIEEXP AND STATUS < VDST.FSEXIMPRESA;

CURSOR=CSELNEWCODEXP SELECT VDSECSERIEEXP.NEXTVAL NEWCODSERIEEXP FROM DUAL; 

CURSOR=CINSNEWSEREXP INSERT INTO VDSERIEEXP (CODSERIEEXP, CODSERIEPREP, ANOBOLETA, CODBOLETA, 
                                             CODAGE, PUERTO, PRIORIDAD, CODOPELANZA, FECLANZA, 
                                             HORALANZA, FECTERMIN, HORATERMIN, FECEXPIDE, HORAEXPIDE, 
                                             STATUS, CODOPEMODIF, FECMODIF, HORAMODIF)   
                                            (SELECT :NEWCODSERIEEXP,CODSERIEPREP,ANOBOLETA,CODBOLETA,
                                                    CODAGE,PUERTO,PRIORIDAD,VDUSER.GETUSER,FECLANZA,
                                                    HORALANZA,0,NULL,0,NULL,
                                                    STATUS,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS
                                               FROM VDSERIEEXP
                                              WHERE CODSERIEEXP = :CODSERIEEXP);

#CURSOR=CUPDCABPESEX UPDATE VDPEDIDOCAB 
#                       SET CODSERIEEXP=:NEWCODSERIEEXP,
#                           CODSERIEPREP=(SELECT CODSERIEPREP FROM VDSERIEEXP WHERE CODSERIEEXP=:NEWCODSERIEEXP) 
#                     WHERE CODSERIEEXP=:CODSERIEEXP AND STATUS < VDST.FPECFINALIZADO;

CURSOR=CUPDCABPESEX UPDATE VDPEDIDOCAB 
                       SET CODSERIEEXP=:NEWCODSERIEEXP,
                           CODSERIEPREP=(SELECT CODSERIEPREP FROM VDSERIEEXP WHERE CODSERIEEXP=:NEWCODSERIEEXP) 
                     WHERE CODSERIEEXP=:CODSERIEEXP AND STATUS =2100;

CURSOR=CPONENEXPED UPDATE VDPEDIDOCAB
                      SET STATUS=VDST.FPECENEXPED
                    WHERE CODSERIEEXP=:CODSERIEEXP AND
                          STATUS=VDST.FPECFINALIZADO AND ROWNUM=1;

CURSOR=CUPDCABPEDEXP UPDATE VDPEDIDOCAB 
                        SET CODSERIEEXP=:NEWCODSERIEEXP,
                            CODSERIEPREP=(SELECT CODSERIEPREP FROM VDSERIEEXP WHERE CODSERIEEXP=:NEWCODSERIEEXP) 
                            WHERE CODDIV=:CODDIV
                              AND ANOPED=:ANOPED
                              AND CODPED=:CODPED
                              AND SEQPED=:SEQPED;
                              
CURSOR=CSELPEDNOF SELECT CODPED FROM VDPEDIDOCAB
                  WHERE CODSERIEEXP=:CODSERIEEXP
                  AND   STATUS<VDST.FPECFINALIZADO;

TECLA=F8,FEJECUTA("CSELNOIMPRESA","NO SE PUEDE CAMBIAR LA SERIE, YA SE HA IMPRESO LA BOLETA",
                  "CSELNEWCODEXP","NO SE PUEDE OBTENER SECUENCIAL PARA UNA NUEVA EXPEDICION",
                  "CINSNEWSEREXP","NO SE PUEDE INSERTAR UNA NUEVA EXPEDICION",
                  "CUPDCABPESEX","NO SE PUEDE ACTUALIZAR EL C�digo DE EXPEDICION EN EL PEDIDO",
                  "CPONENEXPED","ERROR PONIENDO EN PUERTO",
                  %-FCOMMIT,"EXTRAIDOS DE LA SERIE LOS PEDIDOS NO FINALIZADOS\n A NUEVA SERIE :NEWCODSERIEEXP",
                  FPULSATECLAS("CF2","F2"),"NO HA FUNCIONADO EL CAMBIO DE TECLAS")
                    


TECLA=SF8,FEJECUTA("CSELNOIMPRESA","NO SE PUEDE CAMBIAR LA SERIE, YA SE HA IMPRESO LA BOLETA",
                  "CSELNEWCODEXP","NO SE PUEDE OBTENER SECUENCIAL PARA UNA NUEVA EXPEDICION",
                  "CINSNEWSEREXP","NO SE PUEDE INSERTAR UNA NUEVA EXPEDICION",
                  "CUPDCABPEDEXP","NO SE PUEDE ACTUALIZAR EL C�digo DE EXPEDICION EN EL PEDIDO",
                  FIF("CSELPEDNOF",FSUCCESS,"CPONENEXPED"),"ERROR EN FIF EN PUERTO",
                  %-FCOMMIT,"EXTRAIDO DE LA SERIE EL PEDIDO :CODPED :CODDIV :SEQPED :ANOPED",
                  FPULSATECLAS("CF2","F2"),"NO HA FUNCIONADO EL CAMBIO DE TECLAS")
 
ONLINE={F8} Extraer pedidos no finalizados de la serie {May+F8} Extraer un pedido de la serie;