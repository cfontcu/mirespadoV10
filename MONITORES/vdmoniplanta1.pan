# Módulo   : VDMONIPLANTA1.pan
# Función  : Monitor de planta
#
# Creación : 30-07-2008
# Autor    : JMM
###########################################
# Histórico de cambios:
#
ESTADO DE LA PLANTA
                                              ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË
                                              ³ FECHA : ¿D-MM-YY.Y ³
                                              ³ HORA  : ________   ³
                                              ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË
 ³                       SERIES                        ³ ³                        BULTOS                         ³
 ³      PREPARACION             EXPEDICION             ³ ³                          Uni.   Com.   Pal.           ³
 ³  Creadas      @L@,@@@    En curso     @L@,@@@       ³ ³          Sin Lanzar     @L,@@@ @L,@@@ @L,@@@          ³
 ³  En curso     @L@,@@@    Terminadas   @L@,@@@       ³ ³          Pend. stk.:    @L,@@@ @L,@@@ @L,@@@          ³
 ³  Terminadas   @L@,@@@    Expedidas    @L@,@@@       ³ ³          Pend etiq.:    @L,@@@ @L,@@@ @L,@@@          ³
 ³ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³ ³          En curso:      @L,@@@ @L,@@@ @L,@@@          ³
 ³          PEDIDOS                      LINEAS        ³ ³          Por verificar: @L,@@@ @L,@@@ @L,@@@          ³
 ³ Recibidos HOST      @L@,@@@    Pendientes:  @L@,@@@ ³ ³          A cerradora:   @L,@@@ @L,@@@ @L,@@@          ³
 ³ Erróneos            @L@,@@@    En curso  :  @L@,@@@ ³ ³          Termin.:       @L,@@@ @L,@@@ @L,@@@          ³
 ³ Pendientes          @L@,@@@    Terminadas:  @L@,@@@ ³ ³ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
 ³  Pdte. serie        @L@,@@@                         ³ ³             ZONAS DE PICKING                          ³
 ³  En serie           @L@,@@@      UNIDADES           ³ ³             Z.1    Z.2    Z.3    Z.4    Z.5    Z.6    ³
 ³  Pdte. Lanzar       @L@,@@@    Pendientes:  @L@,@@@ ³ ³ Pend.Etiq.: @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ ³ 
 ³  En curso           @L@,@@@    En curso  :  @L@,@@@ ³ ³ En curso:   @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ ³ 
 ³    Esperando stock  @L@,@@@    Terminadas:  @L@,@@@ ³ ³ Pend.Verif: @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ ³ 
 ³    Preparandose     @L@,@@@                         ³ ³ Verificado: @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ @L,@@@ ³ 
 ³ Terminados          @L@,@@@                         ³ ³                                                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
|

SOLOQUERY
NOCOMMIT
WFRAME(14,67,382,78,"","border-style:ridge;border-width:1px")
WFRAME(14,148,208,163,"","border-style:ridge;border-width:1px")
WFRAME(224,148,172,163,"","border-style:ridge;border-width:1px")
WFRAME(414,67,392,136,"","border-style:ridge;border-width:1px")
WFRAME(414,207,392,106,"","border-style:ridge;border-width:1px")



SELECT=SELECT COUNT(PEC.CODPED) PRECIBIDO,
              VD.FECHASYS FECHA,
              VD.HORASYS HORA
         FROM VDPEDIDOCAB PEC, VDAREA ARE
        WHERE PEC.CODAREAEXPED = ARE.CODAREA AND
              VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
              VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
              VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1 AND
              FECRECEP=VD.FECHASYS;

POSTQUERY=FDESIGNACION("CSPRCREADA","",
                       "CSPRTERMINADA","",
                       "CSEXPENCURSO","",
                       "CSEXPTERMINADA","",
                       "CSEXPEXPEDIDA","",
                       "CPECERRONEO","",
                       "CPECPENDIENTE","",
                       "CPECTERMINADO","",
                       "CPELPDTES","",
                       "CPELLANZADAS","",
                       "CPELTERMIN","",
                       "CBUCSLZ","",
                       "CBUCPENDETIQ","",
                       "CBUCPENDETIQPORZONA","",
                       "CBUCENCURSO","",
                       "CBUCENCURSOPORZONA","",
                       "CBUCPORVERIF","",
                       "CBUCPORVERIFPORZONA","",
                       "CBUCACERRAR","",
                       "CBUCTERMINADO","",
                       "CBUCTERMINADOPORZONA","")

CAMPO=FECHA,AUXILIAR,NOENTER
CAMPO=HORA,AUXILIAR,NOENTER
CAMPO=SPREPCREADA,AUXILIAR,NOENTER, TOOLTIP (" Número de series de preparacion creadas . ")
CAMPO=SEXPENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Número de series de expedicion en curso (lanzadas). ")
CAMPO=TBULUNISLZ,AUXILIAR,NOENTER,NOUPDATE,TOOLTIP("Bultos de unidades de pedidos sin lanzar")
CAMPO=TBULCOMPSLZ,AUXILIAR,NOENTER,NOUPDATE,TOOLTIP("Bultos de caja completa de pedidos sin lanzar")
CAMPO=TBULPALSLZ,AUXILIAR,NOENTER,NOUPDATE,TOOLTIP("Bultos de palet de pedidos sin lanzar")
CAMPO=SPREPENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Número de series de preparacion en curso (lanzadas). ")
CAMPO=SEXPFINALIZADA,AUXILIAR,NOENTER, TOOLTIP (" Número de series de expedicion finalizadas. ")
CAMPO=BUNIESPSTK,AUXILIAR,NOENTER,NOUPDATE, TOOLTIP (" Bultos de unidades pendientes de stock. ")
CAMPO=BCOMPESPSTK,AUXILIAR,NOENTER,NOUPDATE, TOOLTIP (" Bultos de caja completa (embalajes) de stock. ")
CAMPO=BPALESPSTK,AUXILIAR,NOENTER,NOUPDATE, TOOLTIP (" Bultos de palet (contenedores) de stock. ")
CAMPO=SPREPTERMINADA,AUXILIAR,NOENTER, TOOLTIP (" Número de series terminadas en la fecha de hoy. ")
CAMPO=SEXPEXPEDIDA,AUXILIAR,NOENTER, TOOLTIP (" Número de series de expedicion impresas y expedidas en la fecha de hoy. ")
CAMPO=BUNIPENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades pendientes de etiquetar. ")
CAMPO=BCOMPPENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de caja completa (embalajes) pendientes de etiquetar. ")
CAMPO=BPALPENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de palet (contenedores) pendientes de etiquetar. ")
CAMPO=BUNIENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades en curso. ")
CAMPO=BCOMPENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de caja completa (embalajes) en curso. ")
CAMPO=BPALENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de palet (contenedores) en curso. ")
CAMPO=BUNIPORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades pendientes de ser verificado. ")
CAMPO=BCOMPPORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de caja completa (embalajes) pendientes de ser verificado. ")
CAMPO=BPALPORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de palet (contenedores) pendientes de ser verificado. ")
CAMPO=PRECIBIDO,AUXILIAR,NOENTER, TOOLTIP (" Pedidos decibidos en la fecha de hoy. ")
CAMPO=LPENDIENTES,AUXILIAR,NOENTER, TOOLTIP(" Lineas de pedido pendientes de lanzar")
CAMPO=BUNIACERRAR,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades enviados a cerradora")
CAMPO=BCOMPACERRAR,AUXILIAR,NOENTER, TOOLTIP (" Bultos de caja completa (embalajes) enviados a cerradora. ")
CAMPO=BPALACERRAR,AUXILIAR,NOENTER, TOOLTIP (" Bultos de palet (contenedores) pendientes rnviados a cerradora. ")
CAMPO=PERRONEO,AUXILIAR,NOENTER, TOOLTIP (" Pedidos en estado erroneo. ")
CAMPO=LLANZADAS,AUXILIAR,NOENTER, TOOLTIP(" Lineas de pedido lanzadas")
CAMPO=BUNITERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades terminados (hoy). ")
CAMPO=BCOMPTERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de caja completa (embalajes) terminados (hoy).  ")
CAMPO=BMANTERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de palet (contenedores) terminados (hoy). ")
CAMPO=PPENDIENTE,AUXILIAR,NOENTER, TOOLTIP (" Cantidad de pedidos que están sin terminar. (En general, los \n que están pendientes de servir y los que están en curso.")
CAMPO=LTERMIN,AUXILIAR,NOENTER, TOOLTIP(" Lineas de pedido terminadas en el día")
CAMPO=PPDTESERIE,AUXILIAR,NOENTER, TOOLTIP (" Pedidos pendientes de hacer previsión de stock. ")
CAMPO=PENSERIE,AUXILIAR,NOENTER, TOOLTIP (" Pedidos en serie pero no en curso. ")
CAMPO=PPDTELANZAR,AUXILIAR,NOENTER, TOOLTIP (" Pedidos en serie con prevision de stock. ")
CAMPO=UPENDIENTES,AUXILIAR,NOENTER, TOOLTIP("Unidades pendientes de lanzar")
CAMPO=BZ1PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 1 pendientes de imprimir etiqueta. ")
CAMPO=BZ2PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 2 pendientes de imprimir etiqueta. ")
CAMPO=BZ3PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 3 pendientes de imprimir etiqueta. ")
CAMPO=BZ4PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 4 pendientes de imprimir etiqueta. ")
CAMPO=BZ5PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 5 pendientes de imprimir etiqueta. ")
CAMPO=BZ6PENDETIQ,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 6 pendientes de imprimir etiqueta. ")
CAMPO=PENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Pedidos en curso. (En general, la suma de los que están\n esperando stock y los que están siendo preparados.) ")
CAMPO=ULANZADAS,AUXILIAR,NOENTER, TOOLTIP("Unidades lanzadas")
CAMPO=BZ1ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 1 en curso. ")
CAMPO=BZ2ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 2 en curso. ")
CAMPO=BZ3ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 3 en curso. ")
CAMPO=BZ4ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 4 en curso. ")
CAMPO=BZ5ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 5 en curso. ")
CAMPO=BZ6ENCURSO,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 6 en curso. ")
CAMPO=PESPERASTOC,AUXILIAR,NOENTER, TOOLTIP (" Pedidos pendientes por falta de stock. ")
CAMPO=UTERMIN,AUXILIAR,NOENTER, TOOLTIP("Unidades terminadas")
CAMPO=BZ1PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 1 por verificar. ")
CAMPO=BZ2PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 2 por verificar. ")
CAMPO=BZ3PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 3 por verificar. ")
CAMPO=BZ4PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 4 por verificar. ")
CAMPO=BZ5PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 5 por verificar. ")
CAMPO=BZ6PORVERIF,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 6 por verificar. ")
CAMPO=PPROCESANDO,AUXILIAR,NOENTER, TOOLTIP (" Pedidos preparándose. ")
CAMPO=BZ1TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 1 terminados. ")
CAMPO=BZ2TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 2 terminados. ")
CAMPO=BZ3TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 3 terminados. ")
CAMPO=BZ4TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 4 terminados. ")
CAMPO=BZ5TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 5 terminados. ")
CAMPO=BZ6TERM,AUXILIAR,NOENTER, TOOLTIP (" Bultos de unidades de la zona 6 terminados. ")
CAMPO=PTERMINADO,AUXILIAR,NOENTER, TOOLTIP (" Pedidos finalizados (en la fecha de hoy). ")

CURSOR=CSPRCREADA SELECT COUNT(DISTINCT (CASE WHEN SPR.STATUS=VDST.FSPRCREADA THEN SPR.CODSERIEPREP ELSE NULL END)) SPREPCREADA,
                         COUNT(DISTINCT (CASE WHEN SPR.STATUS=VDST.FSPRLANZADA THEN SPR.CODSERIEPREP ELSE NULL END)) SPREPENCURSO
                    FROM VDSERIEPREP SPR, VDPEDIDOCAB PEC, VDAREA ARE
                   WHERE SPR.STATUS IN (VDST.FSPRCREADA,VDST.FSPRLANZADA) AND
                         PEC.CODSERIEPREP = SPR.CODSERIEPREP AND
                         PEC.CODAREAEXPED = ARE.CODAREA AND
                         VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                         VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                         VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CSPRTERMINADA SELECT COUNT(DISTINCT SPR.CODSERIEPREP) SPREPTERMINADA
                       FROM VDSERIEPREP SPR, VDPEDIDOCAB PEC, VDAREA ARE
                      WHERE SPR.STATUS=VDST.FSPRFINALIZADA AND
                            SPR.FECTERMIN=VD.FECHASYS AND
                            PEC.CODSERIEPREP = SPR.CODSERIEPREP AND
                            PEC.CODAREAEXPED = ARE.CODAREA AND
                            VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                            VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                            VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CSEXPENCURSO SELECT COUNT(DISTINCT SEX.CODSERIEEXP) SEXPENCURSO
                      FROM VDSERIEEXP SEX, VDPEDIDOCAB PEC, VDAREA ARE 
                     WHERE SEX.STATUS <=VDST.FSEXPREPARANDO AND
                           PEC.CODSERIEEXP = SEX.CODSERIEEXP AND
                           PEC.CODAREAEXPED = ARE.CODAREA AND
                           VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                           VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                           VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CSEXPTERMINADA SELECT COUNT(DISTINCT SEX.CODSERIEEXP) SEXPFINALIZADA
                        FROM VDSERIEEXP SEX, VDPEDIDOCAB PEC, VDAREA ARE 
                       WHERE SEX.STATUS = VDST.FSEXFINALIZADA AND
                             PEC.CODSERIEEXP = SEX.CODSERIEEXP AND
                             PEC.CODAREAEXPED = ARE.CODAREA AND
                             VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                             VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                             VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CSEXPEXPEDIDA SELECT COUNT(DISTINCT SEX.CODSERIEEXP) SEXPEXPEDIDA
                       FROM VDSERIEEXP SEX, VDPEDIDOCAB PEC, VDAREA ARE 
                      WHERE SEX.STATUS >= VDST.FSEXIMPRESA AND
                            SEX.FECTERMIN = VD.FECHASYS AND
                            PEC.CODSERIEEXP = SEX.CODSERIEEXP AND
                            PEC.CODAREAEXPED = ARE.CODAREA AND
                            VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                            VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                            VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CPECERRONEO SELECT COUNT(PEC.CODPED) PERRONEO
                     FROM VDPEDIDOCAB PEC, VDAREA ARE 
                    WHERE STATUS<0 AND
                          PEC.CODAREAEXPED = ARE.CODAREA AND
                          VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                          VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                          VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CPECPENDIENTE SELECT COUNT(PEC.CODPED) PPENDIENTE,
                            SUM((CASE WHEN PEC.STATUS<VDST.FPECENSERIE THEN 1 ELSE 0 END))  PPDTESERIE,
                            SUM((CASE WHEN PEC.STATUS=VDST.FPECENSERIE THEN 1 ELSE 0 END))  PENSERIE,
                            SUM((CASE WHEN PEC.STATUS=VDST.FPECPDTELANZAR THEN 1 ELSE 0 END))  PPDTELANZAR,
                            SUM((CASE WHEN PEC.STATUS>VDST.FPECPDTELANZAR AND PEC.STATUS<VDST.FPECFINALIZADO THEN 1 ELSE 0 END))  PENCURSO,
                            SUM((CASE WHEN PEC.STATUS=VDST.FPECPDTESTOCK THEN 1 ELSE 0 END))  PESPERASTOC,
                            SUM((CASE WHEN  STATUS>=VDST.FPECPREPARANDO AND STATUS<VDST.FPECFINALIZADO THEN 1 ELSE 0 END))  PPROCESANDO
                       FROM VDPEDIDOCAB PEC, VDAREA ARE
                      WHERE STATUS BETWEEN 0 AND VDST.FPECFINALIZADO-1 AND
                            PEC.CODAREAEXPED = ARE.CODAREA AND
                            VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                            VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                            VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;



CURSOR=CPECTERMINADO SELECT COUNT(PEC.CODPED) PTERMINADO
                       FROM VDPEDIDOCAB PEC, VDAREA ARE
                      WHERE FECTERMIN=VD.FECHASYS AND
                            STATUS+0>=VDST.FPECFINALIZADO AND
                            PEC.CODAREAEXPED = ARE.CODAREA AND
                            VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                            VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                            VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CBUCENCURSO SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BUNIENCURSO,
                          SUM(DECODE(TIPOBULTO,'E',1,0)) BCOMPENCURSO,
                          SUM(DECODE(TIPOBULTO,'C',1,0)) BPALENCURSO
                     FROM VDBULTOCAB BUC, VDPEDIDOCAB PEC, VDAREA ARE
                    WHERE BUC.STATUS BETWEEN VDST.FBUCETIQUNI AND VDST.FBUCPREPARADO AND
                          BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                          BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                          PEC.CODAREAEXPED = ARE.CODAREA AND
                          VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                          VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                          VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CBUCENCURSOPORZONA SELECT SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,1,1,0),0)) BZ1ENCURSO,
                                 SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,2,1,0),0)) BZ2ENCURSO,
                                 SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,3,1,0),0)) BZ3ENCURSO,
                                 SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,4,1,0),0)) BZ4ENCURSO,
                                 SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,5,1,0),0)) BZ5ENCURSO,
                                 SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,6,1,0),0)) BZ6ENCURSO
                            FROM (SELECT DISTINCT BUC.CODBULTO, BUC.TIPOBULTO, UBI.CODZONA, BUC.STATUS 
                                    FROM VDBULTOCAB BUC, VDBULTOLIN BUL, VDMOVIM MOV, VDUBICA UBI, VDPEDIDOCAB PEC, VDAREA ARE
                                   WHERE BUC.CODBULTO = BUL.CODBULTO AND BUL.CODMOV = MOV.CODMOV AND 
                                         MOV.CODUBIORI = UBI.CODUBI AND BUC.STATUS BETWEEN VDST.FBUCETIQUNI AND VDST.FBUCPREPARADO AND
                                         BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                                         BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                                         PEC.CODAREAEXPED = ARE.CODAREA AND
                                         VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                                         VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                                         VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1) BULTO;

CURSOR=CBUCPENDETIQ SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BUNIPENDETIQ,
                           SUM(DECODE(TIPOBULTO,'E',1,0)) BCOMPPENDETIQ,
                           SUM(DECODE(TIPOBULTO,'C',1,0)) BPALPENDETIQ
                      FROM VDBULTOCAB BUC, VDPEDIDOCAB PEC, VDAREA ARE
                     WHERE BUC.STATUS IN (VDST.FBUCPDTEETIQ,VDST.FBUCBULABAN,VDST.FBUCCC) AND
                           BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                           BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                           PEC.CODAREAEXPED = ARE.CODAREA AND
                           VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                           VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                           VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CBUCPENDETIQPORZONA SELECT SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,1,1,0),0)) BZ1PENDETIQ,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,2,1,0),0)) BZ2PENDETIQ,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,3,1,0),0)) BZ3PENDETIQ,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,4,1,0),0)) BZ4PENDETIQ,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,5,1,0),0)) BZ5PENDETIQ,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,6,1,0),0)) BZ6PENDETIQ
                             FROM (SELECT DISTINCT BUC.CODBULTO, BUC.TIPOBULTO, UBI.CODZONA, BUC.STATUS 
                                     FROM VDBULTOCAB BUC,VDBULTOLIN BUL,VDMOVIM MOV, VDUBICA UBI, VDPEDIDOCAB PEC, VDAREA ARE
                                    WHERE BUC.CODBULTO = BUL.CODBULTO AND BUL.CODMOV = MOV.CODMOV AND 
                                          MOV.CODUBIORI = UBI.CODUBI AND BUC.STATUS=VDST.FBUCPDTEETIQ AND
                                          BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                                          BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                                          PEC.CODAREAEXPED = ARE.CODAREA AND
                                          VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                                          VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                                          VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1) BULTO;                  

CURSOR=CBUCPORVERIF SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BUNIPORVERIF,
                           SUM(DECODE(TIPOBULTO,'E',1,0)) BCOMPPORVERIF,
                           SUM(DECODE(TIPOBULTO,'C',1,0)) BPALPORVERIF
                      FROM VDBULTOCAB BUC, VDPEDIDOCAB PEC, VDAREA ARE
                     WHERE BUC.STATUS=VDST.FBUCAVERIF AND
                           BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                           BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                           PEC.CODAREAEXPED = ARE.CODAREA AND
                           VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                           VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                           VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;
                  
CURSOR=CBUCPORVERIFPORZONA SELECT SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,1,1,0),0)) BZ1PORVERIF,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,2,1,0),0)) BZ2PORVERIF,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,3,1,0),0)) BZ3PORVERIF,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,4,1,0),0)) BZ4PORVERIF,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,5,1,0),0)) BZ5PORVERIF,
                                  SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,6,1,0),0)) BZ6PORVERIF
                             FROM (SELECT DISTINCT BUC.CODBULTO, BUC.TIPOBULTO, UBI.CODZONA, BUC.STATUS 
                                     FROM VDBULTOCAB BUC, VDBULTOLIN BUL, VDMOVIM MOV, VDUBICA UBI, VDPEDIDOCAB PEC, VDAREA ARE
                                    WHERE BUC.CODBULTO = BUL.CODBULTO AND BUL.CODMOV = MOV.CODMOV AND 
                                          MOV.CODUBIORI = UBI.CODUBI AND BUC.STATUS = VDST.FBUCAVERIF AND
                                          BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                                          BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                                          PEC.CODAREAEXPED = ARE.CODAREA AND
                                          VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                                          VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                                          VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1) BULTO;                  

CURSOR=CBUCACERRAR SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BUNIACERRAR,
                         SUM(DECODE(TIPOBULTO,'E',1,0)) BCOMPACERRAR,
                         SUM(DECODE(TIPOBULTO,'C',1,0)) BPALACERRAR
                    FROM VDBULTOCAB BUC, VDPEDIDOCAB PEC, VDAREA ARE
                   WHERE BUC.STATUS=VDST.FBUCACERRAR AND
                         BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                         BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                         PEC.CODAREAEXPED = ARE.CODAREA AND
                         VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                         VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                         VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CBUCTERMINADO SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) BUNITERM,
                            SUM(DECODE(TIPOBULTO,'E',1,0)) BCOMPTERM,
                            SUM(DECODE(TIPOBULTO,'C',1,0)) BMANTERM
                       FROM VDBULTOCAB BUC, VDPEDIDOCAB PEC, VDAREA ARE
                      WHERE BUC.STATUS+0>=VDST.FBUCAEXPED AND
                            BUC.FECFINALIZA=VD.FECHASYS AND
                            BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                            BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                            PEC.CODAREAEXPED = ARE.CODAREA AND
                            VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                            VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                            VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CBUCTERMINADOPORZONA SELECT SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,1,1,0),0)) BZ1TERM,
                                   SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,2,1,0),0)) BZ2TERM,
                                   SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,3,1,0),0)) BZ3TERM,
                                   SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,4,1,0),0)) BZ4TERM,
                                   SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,5,1,0),0)) BZ5TERM,
                                   SUM(DECODE(BULTO.TIPOBULTO,'U',DECODE(BULTO.CODZONA,6,1,0),0)) BZ6TERM
                              FROM (SELECT DISTINCT BUC.CODBULTO, BUC.TIPOBULTO, UBI.CODZONA, BUC.STATUS 
                                      FROM VDBULTOCAB BUC, VDBULTOLIN BUL, VDMOVIM MOV, VDUBICA UBI, VDPEDIDOCAB PEC, VDAREA ARE
                                     WHERE BUC.CODBULTO = BUL.CODBULTO AND BUL.CODMOV = MOV.CODMOV AND MOV.CODUBIORI = UBI.CODUBI AND
                                           BUC.STATUS+0>=VDST.FBUCAEXPED AND BUC.FECFINALIZA=VD.FECHASYS AND
                                           BUC.CODPED = PEC.CODPED AND BUC.CODDIV = PEC.CODDIV AND
                                           BUC.ANOPED = PEC.ANOPED AND BUC.SEQPED = PEC.SEQPED AND
                                           PEC.CODAREAEXPED = ARE.CODAREA AND
                                           VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                                           VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                                           VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1) BULTO;

CURSOR=CBUCSLZ SELECT SUM(SUM(DECODE(ART.EMBCONT,0,0,MOD((CANTPEDIDA-MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB),ART.EMBCONT)))) TBULCOMPSLZ,
                      SUM(SUM(DECODE(ART.EMBCONT,0,0,(VDART.VD2HOST(CANTPEDIDA,ART.CODART)-MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))-(MOD((CANTPEDIDA-MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB),ART.EMBCONT)*DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/(ART.EMBCONT*DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))))) TBULPALSLZ,
                      SUM(B.BULPICOS) TBULUNISLZ
                 FROM VDARTIC ART,VDPEDIDOLIN PEL,VDPEDIDOCAB PEC,                    
                      (SELECT PEC.CODPED,PEC.ANOPED,PEC.SEQPED,PEC.CODDIV,CEIL(SUM(MOD(CANTPEDIDA,DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)) * LARGOUNI*ANCHOUNI*ALTOUNI) / A.AVGVOLCAJP) BULPICOS
                         FROM VDARTIC ART,VDPEDIDOLIN PEL,VDPEDIDOCAB PEC,VDAREA ARE,
                              (SELECT PEC1.CODPED,PEC1.ANOPED,PEC1.SEQPED,PEC1.CODDIV,FLOOR(MAX( LARGOCAJA*ANCHOCAJA*ALTOCAJA)) AVGVOLCAJP 
                                 FROM VDCAJAS CAJ,VDPEDIDOCAB PEC1,VDPEDIDOLIN PEL,VDARTIC ART
                                WHERE NVL(VOLDINAMICA,'N')='N' AND PEC1.STATUS BETWEEN VDST.FPECRECIBIDO AND VDST.FPECPDTELANZAR AND
                                            PEL.CODPED=PEC1.CODPED AND PEL.CODDIV=PEC1.CODDIV AND PEL.SEQPED=PEC1.SEQPED AND 
                                            PEL.ANOPED=PEC1.ANOPED AND PEL.STATUS+0=VDST.FPELASERVIR AND PEL.CODART ||''=ART.CODART AND
                                            CAJ.TIPOVOL=ART.TIPOVOL
                                GROUP BY PEC1.CODPED,PEC1.ANOPED,PEC1.SEQPED,PEC1.CODDIV) A 
                        WHERE PEL.CODPED=PEC.CODPED AND PEL.CODDIV=PEC.CODDIV AND PEL.SEQPED=PEC.SEQPED AND PEL.ANOPED=PEC.ANOPED 
                          AND PEL.CODART||''=ART.CODART AND PEL.STATUS+0=VDST.FPELASERVIR  
                          AND A.CODPED=PEC.CODPED AND A.CODDIV=PEC.CODDIV AND A.SEQPED=PEC.SEQPED AND A.ANOPED=PEC.ANOPED
                          AND PEC.STATUS BETWEEN VDST.FPECRECIBIDO AND VDST.FPECPDTELANZAR 
                          AND PEC.CODAREAEXPED = ARE.CODAREA
                          AND VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 
                          AND VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 
                          AND VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1
                        GROUP BY PEC.CODPED,PEC.ANOPED,PEC.SEQPED,PEC.CODDIV,A.AVGVOLCAJP) B                          
                WHERE PEL.CODPED=PEC.CODPED AND PEL.CODDIV=PEC.CODDIV AND PEL.SEQPED=PEC.SEQPED AND PEL.ANOPED=PEC.ANOPED 
                  AND PEL.CODART||''=ART.CODART AND PEL.STATUS+0=VDST.FPELASERVIR  
                  AND B.CODPED=PEC.CODPED AND B.CODDIV=PEC.CODDIV AND B.SEQPED=PEC.SEQPED AND B.ANOPED=PEC.ANOPED
                GROUP BY PEC.CODPED,BULPICOS;

CURSOR=CBUCPDTESTK SELECT SUM(SUM(DECODE(ART.EMBCONT,0,0,MOD((VDART.VD2HOST(CANTPEDIDA,ART.CODART)-MOD(VDART.VD2HOST(CANTPEDIDA,ART.CODART),DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB),ART.EMBCONT)))) BCOMPESPSTK,
                          SUM(SUM(DECODE(ART.EMBCONT,0,0,(VDART.VD2HOST(CANTPEDIDA,ART.CODART)-MOD(VDART.VD2HOST(CANTPEDIDA,ART.CODART),DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))-(MOD((VDART.VD2HOST(CANTPEDIDA,ART.CODART)-MOD(VDART.VD2HOST(CANTPEDIDA,ART.CODART),DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB),ART.EMBCONT)*DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB)))/(ART.EMBCONT*DECODE(NVL(ART.UNIEMB,1),0,1,ART.UNIEMB))))) BPALESPSTK,
                          SUM(B.BULPICOS) BUNIESPSTK
                     FROM VDARTIC ART,VDPEDIDOLIN PEL,VDPEDIDOCAB PEC, VDAREA ARE,
                          (SELECT PEC.CODPED,PEC.ANOPED,PEC.SEQPED,PEC.CODDIV,CEIL(SUM(MOD(VDART.VD2HOST(CANTPEDIDA,ART.CODART),DECODE(NVL(ART.UNIEMB,1),0,1,VDART.VD2HOST(ART.UNIEMB,ART.CODART))) * LARGOUNI*ANCHOUNI*ALTOUNI) / A.AVGVOLCAJP) BULPICOS
                             FROM VDARTIC ART,VDPEDIDOLIN PEL,VDPEDIDOCAB PEC,
                                  (SELECT PEC1.CODPED,PEC1.ANOPED,PEC1.SEQPED,PEC1.CODDIV,FLOOR(AVG( LARGOCAJA*ANCHOCAJA*ALTOCAJA)) AVGVOLCAJP 
                                     FROM VDCAJAS CAJ,VDPEDIDOCAB PEC1 
                                    WHERE NVL(VOLDINAMICA,'N')='N' AND
                                          TIPOVOL IN (SELECT DISTINCT TIPOVOL FROM VDARTIC ART,VDPEDIDOLIN PEL 
                                                       WHERE PEL.CODPED=PEC1.CODPED AND PEL.CODDIV=PEC1.CODDIV AND PEL.SEQPED=PEC1.SEQPED AND 
                                                             PEL.ANOPED=PEC1.ANOPED AND PEL.STATUS+0=VDST.FPELASERVIR AND PEL.CODART ||''=ART.CODART)
                                                       GROUP BY CODPED,ANOPED,SEQPED,CODDIV) A 
                            WHERE PEL.CODPED=PEC.CODPED AND PEL.CODDIV=PEC.CODDIV AND PEL.SEQPED=PEC.SEQPED AND PEL.ANOPED=PEC.ANOPED 
                              AND PEL.CODART||''=ART.CODART AND PEL.STATUS+0=VDST.FPELASERVIR  
                              AND A.CODPED=PEC.CODPED AND A.CODDIV=PEC.CODDIV AND A.SEQPED=PEC.SEQPED AND A.ANOPED=PEC.ANOPED
                              AND PEC.STATUS = VDST.FPECPDTESTOCK
                              AND PEC.CODAREAEXPED = ARE.CODAREA
                              AND VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 
                              AND VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 
                              AND VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1
                            GROUP BY PEC.CODPED,PEC.ANOPED,PEC.SEQPED,PEC.CODDIV,A.AVGVOLCAJP) B                          
                    WHERE PEL.CODPED=PEC.CODPED AND PEL.CODDIV=PEC.CODDIV AND PEL.SEQPED=PEC.SEQPED AND PEL.ANOPED=PEC.ANOPED 
                      AND PEL.CODART||''=ART.CODART AND PEL.STATUS+0=VDST.FPELASERVIR  
                      AND B.CODPED=PEC.CODPED AND B.CODDIV=PEC.CODDIV AND B.SEQPED=PEC.SEQPED AND B.ANOPED=PEC.ANOPED
                    GROUP BY PEC.CODPED,BULPICOS;

CURSOR=CPELPDTES SELECT COUNT(*) LPENDIENTES,
                        SUM(PEL.CANTPEDIDA) UPENDIENTES
                   FROM VDPEDIDOCAB PEC, VDPEDIDOLIN PEL, VDAREA ARE 
                  WHERE PEC.CODDIV=PEL.CODDIV AND PEC.ANOPED=PEL.ANOPED AND
                        PEC.CODPED=PEL.CODPED AND PEC.SEQPED=PEL.SEQPED AND
                        PEC.STATUS<=VDST.FPECPDTELANZAR AND
                        PEC.CODAREAEXPED = ARE.CODAREA AND
                        VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                        VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                        VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CPELLANZADAS SELECT COUNT(*) LLANZADAS,
                           SUM(PEL.CANTPEDIDA) ULANZADAS
                      FROM VDPEDIDOCAB PEC, VDPEDIDOLIN PEL, VDAREA ARE
                     WHERE PEC.CODDIV=PEL.CODDIV AND PEC.ANOPED=PEL.ANOPED AND
                           PEC.CODPED=PEL.CODPED AND PEC.SEQPED=PEL.SEQPED AND
                           PEC.STATUS BETWEEN VDST.FPECLANZADO AND VDST.FPECFINALIZADO-1 AND
                           PEC.CODAREAEXPED = ARE.CODAREA AND
                           VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                           VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                           VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

CURSOR=CPELTERMIN SELECT COUNT(*) LTERMIN,
                         SUM(PEL.CANTPEDIDA) UTERMIN
                    FROM VDPEDIDOCAB PEC, VDPEDIDOLIN PEL, VDAREA ARE
                   WHERE PEC.CODDIV=PEL.CODDIV AND PEC.ANOPED=PEL.ANOPED AND
                         PEC.CODPED=PEL.CODPED AND PEC.SEQPED=PEL.SEQPED AND
                         PEC.FECTERMIN=VD.FECHASYS AND
                         PEC.STATUS+0>=VDST.FPECFINALIZADO AND
                         PEC.CODAREAEXPED = ARE.CODAREA AND
                         VD.CONTIENECAD(:RANDIV,PEC.CODDIV) = 1 AND
                         VD.CONTIENECAD(:RANAGE,PEC.CODAGE) = 1 AND
                         VD.CONTIENECAD(:RANALM,ARE.CODALM) = 1;

