# Módulo   : VDLISTADOARTICULOS.PAN
# Función  : Listado de articulos REDUR
#
# Creación : 28-03-2020
# Autor    : infanahe
###########################################
# Histórico de cambios:
#
LISTADO DE ARTICULOS
 CODDIV CODART DESART             CLASEREDUR TIPOABC CODUBI     Libre    Bloqueado Reservado  Cont. UNIEMB EMBPISO EMBCONT ALTOUNI ANCHOUNI LARGOUNI PESOUNI ALTOCAJC ANCHOCAJC LARGOCAJC PESOCAJC   
 _3_    _40__  _100______________ _15_______ _5___   _10_______ #L,##### #L,###### #L,######  @L@@@ @L@@@@ @L@@@@@ @L@@@@@ #L##### #L#####  #L#####  #L##### #L#####  #L#####   #L#####   #L#####   
 |


SOLOQUERY
TABLA=ART
SELECT=SELECT * FROM (select A.CODDIV, A.CODART, A.DESART, CLASEREDUR.CODCLASE CLASEREDUR,
              TIPOABC.CODCLASE TIPOABC, U.CODUBI, A.UNIEMB, A.EMBPISO, A.EMBCONT, A.ALTOUNI,
              A.ANCHOUNI, A.LARGOUNI, A.PESOUNI, A.ALTOCAJC, A.ANCHOCAJC, A.LARGOCAJC,
              A.PESOCAJC, CANTIDAD.LIBRE, CANTIDAD.BLOQUEADO, CANTIDAD.CONTENEDORES,
              CANTIDAD.RESERVADO
         from VDARTIC A,
              (select *
                 from VDCLASEARTIC
                where CODCLASIF = 'REDUR') CLASEREDUR,
              (select *
                from VDCLASEARTIC
               where CODCLASIF = 'TIPOABC') TIPOABC, VDUBICA U,
               (select ART.CODART,
                       VDART.VD2HOST(sum(DECODE(STK.BLOQUEOS, '0000000000', CANTIDAD, 0)),
                          STK.CODART) LIBRE,
                       VDART.VD2HOST(sum(DECODE(STK.BLOQUEOS, '0000000000', 0, CANTIDAD)),
                          STK.CODART) BLOQUEADO,
                       count(distinct STK.CODMAT) CONTENEDORES,
                       VDART.VD2HOST(VDUBI.ALMARESERVADO(ALM.CODALM,'U',ART.CODART),STK.CODART) RESERVADO 
                  from VDALMA ALM, VDAREA ARE, VDUBICA UBI, VDCONTE CNT, VDSTOCK STK,
                       VDARTIC ART
                 where ALM.CODALM = ARE.CODALM
                   and ARE.CODAREA = UBI.CODAREA
                   and UBI.CODUBI = CNT.CODUBI
                   and STK.CODMAT = CNT.CODMAT
                   and STK.CODART = ART.CODART
                 group by ALM.CODALM, ALM.DESALM, STK.CODART, CANTIDAD) CANTIDAD
        WHERE A.CODART = CLASEREDUR.CODART(+) and A.CODART = TIPOABC.CODART(+) and A.CODART = U.CODART(+) and A.CODART like 'BEL%'
              AND CANTIDAD.CODART(+) = A.CODART) ART
        WHERE 1=1;   
WHERE = 1=1;
ORDERBY=ART.CODART;
        
WLONX=1400

CAMPO=CODDIV,TOOLTIP("Cliente"),TITULO("Div"),WLONX=6
CAMPO=CODART,TOOLTIP("Código del artículo"),TITULO("Codigo"),WLONX=20
CAMPO=DESART,TOOLTIP("Designación del artículo"),TITULO("Descripción"),WLONX=70
CAMPO=CLASEREDUR,TOOLTIP("Clase REDUR"),TITULO("Familia"),WLONX=24
#,COMBOX("CCLASEREDUR")
CAMPO=TIPOABC,TOOLTIP("ABC"),TITULO("ABC"),WLONX=3
#,COMBOX("CTIPOABC")
CAMPO=CODUBI,TOOLTIP("Ubicación de Picking asignada"),TITULO("Picking"),WLONX=20
CAMPO=LIBRE,TOOLTIP("Stock libre"),TITULO("Libre"), WLONX=18
CAMPO=BLOQUEADO,TOOLTIP("Stock bloqueado"),TITULO("Bloqueado"), WLONX=20
CAMPO=RESERVADO,TOOLTIP("Cantidad Reservada del Artículo en el Almacén"),TITULO("Reservado"), WLONX=20
CAMPO=CONTENEDORES,TOOLTIP("Número de contenedores"),TITULO("Conte."), WLONX=18
CAMPO=UNIEMB,TOOLTIP("Unidades por caja"), TITULO("Uxcaja"),WLONX=12
CAMPO=EMBPISO,TOOLTIP("Cajas por piso de paletización"), TITULO("CajaxPiso"),WLONX=18
CAMPO=EMBCONT,TOOLTIP("Embalajes por contenedor"), TITULO("CajxPal"),WLONX=12
CAMPO=PESOUNI,TOOLTIP("Peso de la unidad en gramos"), TITULO("Peso un"),WLONX=14
CAMPO=LARGOUNI,TOOLTIP("Largo de la unidad en mm."), TITULO("Largo un"),WLONX=17
CAMPO=ANCHOUNI,TOOLTIP("Ancho de la unidad en mm."), TITULO("Ancho un"),WLONX=17
CAMPO=ALTOUNI,TOOLTIP("Alto de la unidad en mm."), TITULO("Alto un"),WLONX=14
CAMPO=PESOCAJC,TOOLTIP("Peso de la caja en gramos"), TITULO("Peso caj"),WLONX=14
CAMPO=LARGOCAJC,TOOLTIP("Longitud de la caja completa en mm."), TITULO("Largo caj"),WLONX=17
CAMPO=ANCHOCAJC,TOOLTIP("Ancho de la caja completa en mm."), TITULO("Ancho caj"),WLONX=17
CAMPO=ALTOCAJC,TOOLTIP("Alto de la caja completa en mm."), TITULO("Alto caj"),WLONX=14

###CURSORES

CURSOR=CCLASEREDUR select codclase from vdclases WHERE CODCLASIF = 'REDUR';

CURSOR=CTIPOABC select codclase, desclase from vdclases WHERE CODCLASIF = 'TIPOABC';

###TECLAS
TECLA=SF10,FLEEMENU("VDLISTADOARTICULOS.ZOO")




