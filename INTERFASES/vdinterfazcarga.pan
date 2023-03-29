#***************************************************************************
#Módulo: VDINTERFAZCARGA.PAN
#Funcionalidad : MANTENIMIENTO DE LA TABLA VDINTERFAZCARGA. VISUALIZACION
#Autor: Carmen Fontcuberta
#Fecha: 24-11-2022
#**************************************************************************
#* Histórico de cambios
#==================== TO_CHAR(SYSDATE,'YYYYMMDD')
#**************************************************************************
CARGA DE INTERFAZ

Código    Host        Interfaz             Seccion     Objeto     CodObjeto  CodHost    Sent. Estado Cod. comentario  Inf. extra                         Operario   Fecha de Creacion    Usuario      Ultima Modificacion
######### _20________ _20_________________ _60________ _20_______ _60_______ _20_______   _   #####  #########        _255______________________________ _32_______ ¿D-MM-Y.YYY _8______ _32_____     ¿D-MM-Y.YYY _8______
|
TABLA=VDINTERFAZCARGAS
ORDERBY=CODITFCARGA DESC;
REGPAG=25
AQUERY

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR AL INSERTAR REGISTRO PROBLEMAS CON FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODITFCARGA,UPPER,TOOLTIP("Codigo identificativo unico de la carga"),TITULO("Carga")
CAMPO=CODITFCARGAHOST,TOOLTIP("Codigo identificativo de la carga en el host"),TITULO("Host")
CAMPO=CODITF,UPPER,TOOLTIP("Codigo identificativo de la interfaz para parsear o construir los datos"),TITULO("Interfaz")
CAMPO=SECCIONITF,UPPER,TOOLTIP("Subcodigo identificativo de la interfaz para parsear o construir los datos"),TITULO("Seccion"),WLONX=20
CAMPO=TIPOOBJ,UPPER,TOOLTIP("Tipo de objeto (PEDIDO, ARTIC, MOVIM, etc."),TITULO("Objeto")
CAMPO=CODOBJ,UPPER,TOOLTIP("Codigo identificativo unico del objeto (por tipo)"),TITULO("CodObjeto"),WLONX=20
CAMPO=CODHOST,UPPER,TOOLTIP("Codigo del host de donde vino o hacia donde va la carga"),TITULO("CodHost")
CAMPO=SENTIDO,UPPER,TOOLTIP("Entrada o salida,default 'E'"),TITULO("Sent."),WLONX=12
CAMPO=STATUS,UPDATE,TOOLTIP("Estado de la carga"),TITULO("Estado"),WLONX=12
CAMPO=CODCOMEN,TOOLTIP("Código del comentario asociado"),TITULO("cod. comentario")
CAMPO=VDEXTRA,TOOLTIP("Informacion extra"),TITULO("Inf. Extra"),WLONX=25
CAMPO=CODOPECREADO,TOOLTIP("Usuario"),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de creacion de la fila"),TITULO("Hora")
CAMPO=CODOPEMODIF,TOOLTIP("Codigo del operario que modifico por ultima vez la fila"),TITULO("Usuario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la ultima modificacion de la fila"),TITULO("Ultima modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la ultima modificacion de la fila")


# Definicion de los Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

ONLINE= {F1} Ayuda   {F2} Consulta    {F4} Grabar Tabla de Interfaz
	{Esc} Cerrar pantalla  {F9} Borrar Tabla de Interfaz (Mayus+F10) Menú contextual;