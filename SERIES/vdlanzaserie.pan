###################################################################
#M�dulo: VDLANZASERIE.PAN
#Funcionalidad : Lanzamiento de series de preparaci�n
#Autor: FPD      
#Fecha: 18-04-2008
###################################################################
# Hist�rico de cambios:
LANZAMIENTO DE SERIES DE PREPARACION
            �PICKING�                                                            ��� PEDIDOS ����
C�digo Prio �Inv Agr� P Estado              Desc                 ZonasPickInv. L  Tot  Lanz. Err  Operario Creaci�n            Ultima modificaci�n 
            ���������
@@@@@@ @@@    _   _    _ @L@@@ _30_________ _100________________ _1000________ _  @L@@ @L@@  @L@@ _32_____ �D-MM-Y.YY ________ _32_________ �D-MM-Y.YY ________  
                                                                                                                                         |

TABLA=VDSERIEPREP
ORDERBY=PRIORIDAD;
WFRAME(100,10,61,0,"Picking","")
WFRAME(581,10,115,0,"Pedidos","")

PRECOMMIT=FEJECUTA( "CHECKSTATUS","SERIE :CODSERIEPREP SIN DISPONIBILIDAD",
                    "CSACAPELINSERIE","Error al sacar las l�neas de pedidos sin disponibilidad de la serie",
                    "CSACAPEDSERIE","Error al sacar pedidos sin disponibilidad de la serie")


PREUPDATE=FEJECUTA("CHECKSTATUS","SERIE :CODSERIEPREP SIN DISPONIBILIDAD",
                   "-CCHECKPICKINV","NO SE PUEDE LANZAR SERIE AL HABER MOVTOS EN PDTEPEDIDO",
                   FIF("CSELLANZAR",
                       FEJECUTA("@CSELCODAGE","NO SE PUEDE OBTENER AGENCIA",
                                FWHILE(FERRORCURSOR("CSELCODAGE"),
                                       FEJECUTA("CSELSERIEEXP","NO SE PUEDE OBTENER SECUENCIAL DE SERIE DE EXPEDICION",
                                                "CINSSEXP","NO SE PUEDEN INSERTAR LAS SERIES DE EXPEDICION",
					                                      "CUPDSERPREP","NO SE PUEDE ACTUALIZAR LA SERIE DE PREPARACION",
					                                      "CUPDPEDIDOS","NO SE PUEDEN ACTUALIZAR LAS CABECERAS DE PEDIDO",
					                                      "CSELMODIF","ERROR OBTENIENDO OPERARIO Y FECHA DE MODIFICACION",
					                                      +FFETCHCURSOR("CSELCODAGE"),"ERROR EN FETCH")),"ERROR EN FWHILE",
					                      +FPULSATECLAS("CF2","F2"),"")),"ERROR AL EJECUTAR EL FIF")

POSTQUERY=FEJECUTA("CSELSTATUS","ERROR AL RECUPERAR EL ESTADO DE LA SERIE",
                   "CNUMPED","ERROR CALCULANDO PEDIDOS")

CAMPO=CODSERIEPREP,NOENTER,TOOLTIP("C�digo de la serie de preparaci�n"),TITULO("C�digo"),WLONX=20
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de la serie de preparaci�n. La heredan todas las series de expedici�n generadas a partir de esta serie de preparaci�n"),TITULO("Prio"),WLONX=17
CAMPO=SWTPICKINGINV,UPPER,TOOLTIP("Indica si se quiere hacer Picking Inverso para esta serie. Valores S o blanco."),
                    POSTCHANGE=FVERIFICA(" NS","Valores posibles S o blanco"),TITULO("Inv"),WLONX=15
CAMPO=SWTPICKINGAGR,UPPER,TOOLTIP("Indica si se quiere hacer Picking Agrupado para esta serie. Valores S o blanco."),
                    POSTCHANGE=FVERIFICA(" NS","Valores posibles S o blanco"), TITULO("Agr"),WLONX=15
CAMPO=TIPOPUERTO,UPPER,TOOLTIP("Indica si el puerto de salida utilizado es el asignado por defecto o es uno alternativo"),
                 POSTCHANGE=FVERIFICA("DA ","Los posibles valores de puerto son D(efecto) o A(lternativo)."),TITULO("P")
CAMPO=STATUS,NOENTER,TOOLTIP("Estado en que se encuentra la serie de preparaci�n\n :DESSTATUS"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado en el que se encuentra la serie")
CAMPO=DESSERIE,TOOLTIP("Descripci�n de la serie"),TITULO("Descripci�n")
CAMPO=RANGOZONASPICKINV,TOOLTIP("Rango de zonas donde preparar la serie si es de picking inverso"),TITULO("Zonas PickInv"),WLONX=40
CAMPO=LANZAR,CHECKBOX("N","S"),UPPER,AUXILIAR,TOOLTIP("Indica si vamos a lanzar la serie de preparaci�n."),TITULO("L")
CAMPO=NUMPED,AUXILIAR,NOENTER,TOOLTIP("Pedidos incluidos en la serie"),TITULO("Total"),WLONX=18
CAMPO=NUMPEDLANZABLES,AUXILIAR,NOENTER,TOOLTIP("Pedidos incluidos en la serie que han pasado disponibilidad"),TITULO("Lanz."),WLONX=18
CAMPO=NUMPEDNOLANZABLES,AUXILIAR,NOENTER,TOOLTIP("Pedidos incluidos en la serie que NO han pasado disponibilidad"),TITULO("Err.")
CAMPO=CODOPECREADA,NOENTER,TOOLTIP("Operario que cre� la serie"),TITULO("Operario"),WLONX=20
CAMPO=FECCREADA,NOENTER,TOOLTIP("Fecha de creaci�n de la serie de preparaci�n"),TITULO("Creaci�n")
CAMPO=HORACREADA,NOENTER,TOOLTIP("Hora de creaci�n de la serie de preparaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=CODAGEAUX,AUXILIAR,OCULTO,"_10_"
CAMPO=CODSERIEEXPAUX,AUXILIAR,OCULTO,"@@@@@@"
CAMPO=CODAREAEXPEDAUX,AUXILIAR,OCULTO,"_20__________"
CURSOR=CCHECKPICKINV SELECT :LANZAR FROM VDMOVIM WHERE STATUS=VDST.FMOVPDTEPEDIDO;

CURSOR=CSELSTATUS SELECT DESSTATUS,'N' LANZAR 
                    FROM VDSTATUS 
                   WHERE TIPOSTATUS='SPR' AND STATUS=:STATUS ; 

CURSOR=CNUMPED SELECT COUNT(*) NUMPED, 
                      SUM(DECODE(STATUS,VDST.FPECPDTESERIE,1,0)) NUMPEDNOLANZABLES,  
                      SUM(DECODE(STATUS,VDST.FPECPDTELANZAR,1,0)) NUMPEDLANZABLES
                 FROM VDPEDIDOCAB 
                WHERE CODSERIEPREP=:CODSERIEPREP;

CURSOR=CHECKSTATUS SELECT  :CODSERIEPREP FROM DUAL WHERE :STATUS=VDST.FSPRCONDISPONI;

CURSOR=CSACAPELINSERIE UPDATE VDPEDIDOLIN 
                          SET CANTASERVIR=0 , STATUS=VDST.FPELASERVIR
                        WHERE (CODDIV,ANOPED,CODPED,SEQPED) IN (SELECT CODDIV,ANOPED,CODPED,SEQPED FROM VDPEDIDOCAB 
                                                                  WHERE CODSERIEPREP=:CODSERIEPREP AND STATUS+0<VDST.FPECPDTELANZAR)
			                        AND STATUS+0 IN (VDST.FPELASERVIR,VDST.FPELANULADADIS); 
			                        
CURSOR=CSACAPEDSERIE UPDATE VDPEDIDOCAB
                        SET CODSERIEPREP=0,STATUS=VDST.FPECPDTESERIE,
                        CODOPEMODIF='LANZAR SERIES',FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS  
                      WHERE CODSERIEPREP=:CODSERIEPREP AND STATUS+0<VDST.FPECPDTELANZAR;


CURSOR=CSELLANZAR SELECT :LANZAR 
                    FROM DUAL 
                   WHERE :LANZAR='S';

CURSOR=CSELCODAGE SELECT CODAGE CODAGEAUX, CODAREAEXPED CODAREAEXPEDAUX
                    FROM VDPEDIDOCAB
                   WHERE CODSERIEPREP=:CODSERIEPREP
                  GROUP BY CODAGE,CODAREAEXPED;
                   
CURSOR=CSELSERIEEXP SELECT VDSECSERIEEXP.NEXTVAL CODSERIEEXPAUX
                      FROM DUAL;

CURSOR=CINSSEXP INSERT INTO VDSERIEEXP (CODSERIEEXP,CODSERIEPREP,DESSERIE,ANOBOLETA,CODBOLETA,CODAGE,
                                        PUERTO,PRIORIDAD,CODOPELANZA,FECLANZA,HORALANZA,FECTERMIN,
                                        HORATERMIN,FECEXPIDE,HORAEXPIDE,STATUS,CODCOMEN,VDEXTRA,
                                        CODOPEMODIF,FECMODIF,HORAMODIF)   
                                       (SELECT :CODSERIEEXPAUX,:CODSERIEPREP,DESSERIE,0,0,AGE.CODAGE,
                                               AGE.PUERTO,SPR.PRIORIDAD,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS,
                                               0,NULL,0,NULL,VDST.FSEXLANZADA,0,NULL,
                                               VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS
                                          FROM VDAGENCIA AGE,VDSERIEPREP SPR
                                           WHERE SPR.CODSERIEPREP=:CODSERIEPREP AND AGE.CODAGE=:CODAGEAUX);

CURSOR=CUPDSERPREP UPDATE VDSERIEPREP 
                      SET STATUS=VDST.FSPRLANZADA,
                          CODOPELANZA=VDUSER.GETUSER,
                          FECLANZA=VD.FECHASYS,
                          HORALANZA=VD.HORASYS,
                          CODOPEMODIF=VDUSER.GETUSER,
                          FECMODIF=VD.FECHASYS,
                          HORAMODIF=VD.HORASYS 
                    WHERE CODSERIEPREP=:CODSERIEPREP; 

CURSOR=CUPDPEDIDOS UPDATE VDPEDIDOCAB 
                      SET STATUS=VDST.FPECLANZADO,
                          CODSERIEEXP=:CODSERIEEXPAUX
                    WHERE CODSERIEPREP=:CODSERIEPREP AND STATUS+0=VDST.FPECPDTELANZAR AND
                          CODAGE=:CODAGEAUX AND CODAREAEXPED=:CODAREAEXPEDAUX; 

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF 
			             FROM DUAL; 

