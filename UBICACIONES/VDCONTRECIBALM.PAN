# Módulo   : VDCONTRECIBALM.PAN
# Función  : MANTENIMIENTO DE CONTENEDORES RECIBIDOS EN ALMACEN  
#
# Creación : 14-02-2022  
# Autor    : 
###########################################
# MANTENIMIENTO DE CONTENEDORES RECIBIDOS EN ALMACEN 
# Módulo   : VDCONTENINTFAZ.PAN
# Función  : MANTENIMIENTO DE CONTENEDORES RECIBIDOS POR INTERFAZ 
#
# Creación : 14-02-2022
# Autor    : 
###########################################   
#MANTENIMIENTO DE CONTENEDORES RECIBIDOS ALMACEN 
MANTENIMIENTO DE CONTENEDORES RECIBIDOS ALMACEN
Matrícula           T. contened. Status  Cod articulo       Lote               Cad.lote   Precaducidad Unidad   Emb.cont.  Emb. pisos Cant. teorica Largo cont.  Ancho cont. Altura cont. P.teorico P.real    Largo un. Ancho un. Alto un. Largo c.mm Ancho c.mm  Alto c.mm  Agrega                              
_18_______________  _10________  @L@@@   _20_______________ _20_______________ _8_____    _8_____      @L@@@@@@ @L@@@      @L@@       @L@@@@@@@     @L@@@@@@@    @L@@@@@@@   @L@@@@@@@    @L@@@@@@@ @L@@@@@@@ @L@@@@    @L@@@@@   @L@@@@@  @L@@@@     @L@@@@      @L@@@@     _20___   
|

TABLA=VDSGTCONTERECEP


PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=CODMAT,TOOLTIP("Matricula del contenedor"),TITULO("Matrícula")
CAMPO=TIPOCONTE,TOOLTIP("Tipo contenedor"),TITULO("Tipo contenedor")
CAMPO=STATUS,TOOLTIP("Status"),TITULO("Status")
CAMPO=CODART,TOOLTIP("Cod de artuiculo "),TITULO("Articulo")
CAMPO=CODLOT,TOOLTIP("Cod de lote"),TITULO("Lote")
CAMPO=CADUCI,TOOLTIP("Caducidad de lote"),TITULO("Cad.lote")
CAMPO=RETEST,TOOLTIP("Precacidad de lote"),TITULO("Precaducidad")
CAMPO=UNIEMB,TOOLTIP("Unidad por embalaje"),TITULO("Unidad")
CAMPO=EMBCONT,TOOLTIP("Embalaje por contenedor"),TITULO("Emb.cont.")
CAMPO=EMBPISO,TOOLTIP("Embalaje por pisos"),TITULO("Emb. pisos")
CAMPO=CANTIDAD,TOOLTIP("Candidad teorica"),TITULO("Cant. teorica")
CAMPO=LARGOCONTE,TOOLTIP("Largo contenedor "),TITULO("Largo cont.")
CAMPO=ANCHOCONTE,TOOLTIP("Ancho contenedor"),TITULO("Ancho cont.")
CAMPO=ALTURACONTE,TOOLTIP("Altura cont."),TITULO("Altura cont.")
CAMPO=PESOTEORICO,TOOLTIP("Peso teorico"),TITULO("P.teorico-gr.")
CAMPO=PESOREAL,TOOLTIP("Peso real"),TITULO("P.real-gr.")
CAMPO=LARGOUNI,TOOLTIP("Largo unidad "),TITULO("Largo un.")
CAMPO=ANCHOUNI,TOOLTIP("Ancho unidad "),TITULO("Ancho un.")
CAMPO=ALTOUNI,TOOLTIP("alto unidad"),TITULO("Alto un.")
CAMPO=LARGOCAJC,TOOLTIP("Largo caja completa mm"),TITULO("Largo c.mm")
CAMPO=ANCHOCAJC,TOOLTIP("Ancho caja completa mm"),TITULO("Ancho c.mm")
CAMPO=ALTOCAJC,TOOLTIP("Alto caja completa mm"),TITULO("Alto c.mm")
CAMPO=CODAGREGA,TOOLTIP("Cod. AGREGA "),TITULO("Agrega") 
CAMPO=CODOPEMODIF,TOOLTIP("Operador"),TITULO("Usuario") 
CAMPO=FECMODIF,TOOLTIP("Fecha de modif."),TITULO("Fec. Modif") 
CAMPO=HORAMODIF,TOOLTIP("Hora de modif."),TITULO("Hora modif.") 



CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

