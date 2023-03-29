#*****************************************************************
#Módulo: VDINTERFAZCAB.PAN
#Funcionalidad : Mantenimiento de la Tabla VDINTERFAZCAB
#Autor: Carmen Fontcuberta 
#Fecha: 11-11-2022
#*****************************************************************
#* Histórico de cambios
# ==================== TO_CHAR(SYSDATE,'YYYYMMDD')
#*****************************************************************
MANTENIMIENTO DE INTERFASES
 Codigo de Interfaz Seccion        Seccion  Madre      Tipo      Sent Ord Namespace      Sep Act Par Lon Esc Array Accion    Normalizar              Funcion                    PreAcc               PostAcc     Preproc         Postproc         Inf. Extra   Operario Fecha Creacion       Usuario  Ultima modificacion
 _20_______________ _60___________ _60________________ _10______  _   ### _500__________  _   _   _   _   _    _   _20______ _255___________________ _255______________________ _255________________ _255_______ _255___________ _255____________ _255________ _32_____ ¿D-MM-Y.YYY _8______ _32_____ ¿D-MM-Y.YYY _8______ 
|

TABLA=VDINTERFAZCAB

ORDERBY=CODITF,SECCIONITF,ORDEN ASC;

AQUERY

PROTECT("IMPLANTADOR")

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR AL INSERTAR REGISTRO PROBLEMAS CON FECHA")
                   
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

PREDELETE=FEJECUTA("CDELLININTER","ERROR AL BORRAR LINEAS DE INTERFASE")



CAMPO=CODITF,TOOLTIP("Codigo de identificacion"),TITULO("Codigo de interfaz")
#         ,POSTCHANGE=FVALNOCERO("El código de la interfaz no puede estar vacío")
CAMPO=SECCIONITF,TOOLTIP("SubCodigo de identificacion (en salidas corresponde al segmento/bloque del documento a construir"),TITULO("Seccion"),WLONX=30
#          ,POSTCHANGE=FVALNOCERO("La seccion no puede estar vacío"),WLONX=25
CAMPO=SECCIONITFMADRE,TOOLTIP("Segmento/bloque padre (usado solo en salidas)"),TITULO("Seccion Madre"),WLONX=25
CAMPO=TIPOITF,UPPER,TOOLTIP("Tipo de interfaz (POS - Posicional, CSV - Valores separados por comas, CV - Clave/Valor, BLOB - Binarios)"),TITULO("Tipo")
         ,POSTCHANGE=FVALNOCERO("El tipo de interfaz no puede estar vacío")
CAMPO=SENTIDO,TOOLTIP("Entrada o Salida E/S"),TITULO("Sent")
    ,POSTCHANGE=FVALNOCERO("El Sentido no puede estar vacío"),WLONX=12
CAMPO=ORDEN,TOOLTIP("Precedencia respecto a otras interfaces con la misma seccion madre\n a la hora de construir los documentos (usado solo en salidas"),TITULO("Ord"),WLONX=12
CAMPO=NS,TOOLTIP("Namespace de la seccion"),TITULO("Namespace"),WLONX=50
CAMPO=SEP,TOOLTIP("Caracter utilizado como separador de campos (usado solo con documentos posicionales"),TITULO("Sep"),WLONX=12
CAMPO=SWTACTIVO,UPPER,TOOLTIP("Habilita o deshabilita la interfaz,\n S por defecto"),TITULO("Hab"),WLONX=12
      ,POSTCHANGE=FVALNOCERO("Habilita no puede estar vacío, S por defecto")
CAMPO=SWTPARCIAL,UPPER,TOOLTIP("Habilita o deshabilita la posibilidad de hacer una transaccion por segmento/bloque en el documento"),TITULO("Par."),WLONX=12
CAMPO=SWTLONGFIJA,TOOLTIP("Los campos son o no de longitud fija (usado solo con documentos posicionales"),TITULO("Lon"),WLONX=12
CAMPO=SWTSCALAR,TOOLTIP("El segmento/bloque del documento es un valor escalar\n y no un objeto"),TITULO("Esc"),WLONX=12
CAMPO=SWTARRAY,TOOLTIP("Representar los segmentos/bloques como arrays\n aunque sólo aparezcan una vez (usado sólo en salidas)"),TITULO("Array"),WLONX=12
CAMPO=ACCION,TOOLTIP("Acción a realizar (usado sólo en entradas)"),TITULO("Accion")
CAMPO=NORMPROC,TOOLTIP("Procedimiento a ejecutar para normalizar las cargas de esta interfaz (usado sólo en entradas)"),TITULO("Normalizar")
CAMPO=VALACCFUNC,TOOLTIP("Funcion a ejecutar despues de la hacer una carga con esta interfaz"),TITULO("Funcion"),WLONX=25
CAMPO=PREACCPROC,TOOLTIP("Funcion a ejecutar despues de la hacer una carga con esta interfaz"),TITULO("PreAcc"),WLONX=25
CAMPO=POSTACCPROC,TOOLTIP("Procedimiento a ejecutar después de hacer una acción de esta interfaz"),TITULO("PostAcc"),WLONX=25
CAMPO=PREPROC,TOOLTIP("Procedimiento a ejecutar después de hacer todas las acciones de esta interfaz"),TITULO("Preproc"),WLONX=25
CAMPO=POSTPROC,TOOLTIP("Procedimiento a ejecutar antes de hacer todas las acciones de esta interfaz"),TITULO("Postproc"),WLONX=25
CAMPO=VDEXTRA,TOOLTIP("Informacion extra"),TITULO("Inf. Extra"),WLONX=25
CAMPO=CODOPECREADO,NOENTER,TOOLTIP("Codigo del operario que creo la fila"),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de Creacion")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificación.Es utilizado para depuración y control de los registros en las tablas"),TITULO("Usuario")       
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas"),TITULO("Ultima modificación")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")

# Definicion de los Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

CURSOR=CDELLININTER DELETE VDINTERFAZLIN WHERE CODITF=:CODITF AND SECCIONITF=:SECCIONITF;

ONLINE={F1} Ayuda   {F2} Consulta    {F4} Grabar Tabla de Interfaz
	{Esc} Cerrar pantalla  {F9} Borrar Tabla de Interfaz {Mayus+F10} Menú contextual;