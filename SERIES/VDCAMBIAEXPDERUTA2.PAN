###################################################################
#M�dulo: VDPEDSERIEEXP.PAN
#Funcionalidad : Presenta los pedidos de una serie de expedici�n
#Autor: RFD      
#Fecha: 22-10-2008
###################################################################
# Hist�rico de cambios:
PEDIDOS DE LA SERIE DE EXPEDICION
I Pedido          Div. A�o  Sec. Estado                     Cliente       Prov. Poblaci�n       Agencia Original        Pais  Direcci�n                     Peso            Volumen          Uni. Caj. Pal.
_ _20____________ ____ @@@@ @@@  @L@@@ ____________________ _40__________ _____ _40____________ _10___ _30_____________ _5___ _40__________________________ ############### ###############  @@@@ @@@@ @@@@
|

TABLA=VDPEDIDOCAB
WHERE = CODSERIEEXP =:CODSERIEANTERIOR;
SELECT= 'N' INCLUIR;

PREQUERY=FEJECUTA("CSELASIGCODSERIEANTERIOR","Error en CSELASIGCODSERIEANTERIOR")

POSTUPDATE=FEJECUTA("CCHECKNUEVANULO","La serie destino no puede ser 0",
                    "CCHECKANTERIORNULO","La serie origen no puede ser 0",
                    "@CCHECK","Error en cursor CCHECK",
                    "+CSELAGENUEVASERIE","",
                    "CUPDACPSERIE","Error al actualizar la ruta de la expedicion :ANOALB :CODALB ")

POSTCOMMIT=FEJECUTA(FIF("-CFLAGNUEVARUTA",
                       FEJECUTA("CINSRUTA","No puedo insertar nueva ruta")),"ERROR INSERTANDO RUTA",
                    +FIF("CFLAGANULARRUTA",
                       FEJECUTA("CTERMINAANT","No puedo anular ruta ORIGEN",
                                %FFAILURE,"\n RUTA :CODSERIEANTERIOR SE QUEDA SIN EXPEDICIONES, \n PASA A ESTADO 7000 ANULADA. \n"),
                       FEJECUTA(%FFAILURE,"\n Expediciones seleccionadas, asignadas a la ruta :CODSERIENUEVA ")),"",
                    FPULSATECLAS("F5","ESC"),"")
                    
CAMPO=INCLUIR,AUXILIAR,UPPER,POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),TITULO("Inc."),WLONX=15
CAMPO=CODSERIEEXP,VIRTUAL,OCULTO
CAMPO=CODSERIEPREP,OCULTO,"@@@@"
CAMPO=ANOALB,OCULTO,"@@@@"
CAMPO=CODALB,OCULTO,"_20_"
CAMPO=CODPED,NOUPDATE,TOOLTIP("C�digo del pedido"),POSTCHANGE=FDESIGNACION("CSELDESAGE","ERROR OBTENIENDO AGENCIA Y DESCRIPCION",
                                                                           "CSELNUMBULTOS","ERROR OBTENIENDO NUMERO DE BULTOS DEL PEDIDO" ),TITULO("Pedido")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("Division o compa�ia del pedido"),TITULO("Div.")
CAMPO=ANOPED,NOUPDATE,TOOLTIP("A�o del pedido"),TITULO("A�o")
CAMPO=SEQPED,NOUPDATE,TOOLTIP("Versi�n del pedido"),TITULO("Sec."),WLONX=10
CAMPO=STATUS,NOUPDATE,TOOLTIP("Estado del pedido"),POSTCHANGE=FDESIGNACION("CSELSTATUS","Error obteniendo estado"),TITULO("Estado"),WLONX=15
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado en el que se encuentra el pedido"),TITULO("")
CAMPO=DESCLIENTE,NOUPDATE,TOOLTIP("Cliente al que se sirve el pedido\n :DESCLIENTE "),TITULO("Cliente")
CAMPO=CODPROV,NOUPDATE,TOOLTIP("Provincia a la que se env�a el pedido"),TITULO("Prov.")
CAMPO=POBLACION,NOUPDATE,TOOLTIP("Poblaci�n a la que se env�a el pedido.\n :POBLACION"),TITULO("Poblaci�n")
CAMPO=CODAGE,AUXILIAR,NOUPDATE,TOOLTIP("C�digo de agencia de transporte"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia\n :DESAGE")
CAMPO=CODPAIS,NOUPDATE,TOOLTIP("Pa�s"),TITULO("Pais")
CAMPO=DIRECCION,NOUPDATE,TOOLTIP("Direcci�n"),TITULO("Direcci�n")
CAMPO=PESOPEDIDO,NOUPDATE,TOOLTIP("Peso del pedido"),TITULO("Peso")
CAMPO=VOLUMENPEDIDO,NOUPDATE,TOOLTIP("Vol�men"),TITULO("Volumen")
CAMPO=NUMBULUNI,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades del pedido"),TITULO("Uni.")
CAMPO=NUMBULEMBA,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de caja completa del pedido"),TITULO("Caj.")
CAMPO=NUMBULPAL,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de contenedor completo del pedido"),TITULO("Pal.")
CAMPO=TRACKINGAGE,OCULTO,"_20_"
CAMPO=DUMMY,AUXILIAR,OCULTO,"@L"
CAMPO=CODSERIENUEVA,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODSERIEANTERIOR,AUXILIAR,VIRTUAL,OCULTO
CAMPO=FLAGCREARUTA,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODAGEANTERIOR,AUXILIAR,VIRTUAL,OCULTO

CURSOR=CSELASIGCODSERIEANTERIOR SELECT :CODSERIEANTERIOR CODSERIE FROM DUAL;

CURSOR=CCHECKNUEVANULO SELECT 1 DUMMY FROM DUAL WHERE :CODSERIENUEVA<>0;

CURSOR=CCHECKANTERIORNULO SELECT 1 DUMMY FROM DUAL WHERE :CODSERIEANTERIOR<>0;

CURSOR=CCHECK SELECT :INCLUIR FROM DUAL WHERE :INCLUIR='S';

CURSOR=CUPDACPSERIE UPDATE VDPEDIDOCAB SET CODSERIEEXP=:CODSERIENUEVA,CODAGE=:CODAGE
                    WHERE CODPED=:CODPED AND ANOPED=:ANOPED AND SEQPED=:SEQPED AND CODDIV=:CODDIV;

CURSOR=CFLAGNUEVARUTA SELECT 1 DUMMY FROM DUAL WHERE EXISTS (SELECT CODSERIEEXP FROM VDSERIEEXP WHERE CODSERIEEXP=:CODSERIENUEVA);

CURSOR=CINSRUTA INSERT INTO VDSERIEEXP ( CODSERIEEXP, CODSERIEPREP, ANOBOLETA,  CODBOLETA, CODAGE, PUERTO, 
                                                  PRIORIDAD, CODOPELANZA, FECLANZA, HORALANZA, FECTERMIN, HORATERMIN, 
                                                  FECEXPIDE, HORAEXPIDE, STATUS,  CODCOMEN, VDEXTRA, CODOPEMODIF, FECMODIF, HORAMODIF) 
                                         VALUES (:CODSERIENUEVA ,:CODSERIEPREP ,0 ,0,:CODAGEANTERIOR ,0,
                                                 50,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS,0,NULL,
                                                 0,NULL,VDST.FSEXFINALIZADA,0,NULL,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS );

CURSOR=CFLAGANULARRUTA SELECT 1 DUMMY FROM DUAL WHERE (SELECT COUNT(*) FROM VDPEDIDOCAB WHERE CODSERIEEXP=:CODSERIEANTERIOR)=0;

CURSOR=CTERMINAANT UPDATE VDSERIEEXP SET STATUS=7000 WHERE CODSERIEEXP=:CODSERIEANTERIOR;

CURSOR=CSELDESAGE SELECT PEOC.CODAGE,AGE.DESAGE 
                    FROM VDPEDIDOCAB PEOC,VDAGENCIA AGE
                   WHERE  PEOC.CODPED=:CODPED
                   AND PEOC.ANOPED=:ANOPED
                   AND PEOC.CODDIV=:CODDIV
                   AND PEOC.SEQPED=:SEQPED 
                   AND PEOC.CODAGE=AGE.CODAGE;

CURSOR=CSELSTATUS SELECT DESSTATUS
                    FROM VDSTATUS
                   WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';

CURSOR=CSELNUMBULTOS SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) NUMBULUNI,
                            SUM(DECODE(TIPOBULTO,'E',1,0)) NUMBULEMBA,
                            SUM(DECODE(TIPOBULTO,'C',1,0)) NUMBULPAL
                       FROM VDBULTOCAB
                      WHERE CODPED = :CODPED AND CODDIV = :CODDIV AND
                            SEQPED = :SEQPED AND ANOPED = :ANOPED;
 
 
CURSOR=CINSXVDSEX INSERT INTO XVDSERIEEXP VALUES (:CODSERIENUEVA,0,:CODAGEANTERIOR,NULL,0,NULL,NULL,NULL,NULL,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);

CURSOR=CSELAGENUEVASERIE SELECT CODAGE FROM VDSERIEEXP WHERE CODSERIEEXP=:CODSERIENUEVA;

CONTEXTUAL=FLEEMENU("VDRUTAS.ZOO")

