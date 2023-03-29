#*****************************************************************
#Módulo: VDINTERFAZLIN.PAN
#Funcionalidad : Mantenimiento de la Tabla VDINTERFAZLIN
# Autor: Carmen Fontcuberta   
#Fecha: 11-11-2022
#*****************************************************************
# Histórico de cambios
# ====================
#
#*****************************************************************
MANTENIMIENTO DE LAS LINEAS DEL FORMATO DE INTERFAZ SELECCIONADO
 Ord Nombre Campo    Descripcion                         Campo Origen Campo Destino Namespace Ruta                               Codigo Tabla        A Id.O Id.D Aut. T. Campo  Lon Dec FunDefecto                FuncionTrans Inf.         Extra        Operario   Fecha de Creacion    Usuario    Ultima modificación   
 ### _60____________ _255_______________________________ _60_________ _60__________ _255_____ _255______________________________ _60________________ _   _    _   _   _10______ ###  #   _255_____________________ _255_____________________ _255________ _32_______ ¿D-MM-Y.YYY _8______ _32_____   ¿D-MM-Y.YYY _8______ 
|

TABLA=VDINTERFAZLIN

ORDERBY=CODITF, SECCIONITF, ORDEN ASC;


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR CREACION",
                   "CEXISTCOD","COD TABLA NO EXISTE EN VDINTERFAZTAB Y ES FOREING KEY")
                   
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

               
CAMPO=CODITF,VIRTUAL,OCULTO
CAMPO=SECCIONITF,VIRTUAL,OCULTO,TOOLTIP("Subcodigo de identificacion\n(en salidas corresponde al segmento/ n/bloque del documento a construir)")
#UPPER,
#                 ,POSTCHANGE=FVALNOCERO("La Seccion no puede estar vacía"),TITULO("Seccion"),WLONX=25
CAMPO=ORDEN,TOOLTIP("Precedencia respecto a otros campos de la misma interfaz, seccion y tabla a la hora de parsear y construir documentos")
CAMPO=CAMPO,UPPER,TOOLTIP("Nombre del campo")
#                   ,POSTCHANGE=FVALNOCERO("CAMPO no puede estar vacía"),TITULO("Campo"),WLONX=25
CAMPO=DESCAMPO,MIXED,TOOLTIP("Descripcion breve del campo"),TITULO("Descripcion"),WLONX=25
CAMPO=CAMPOORI,TOOLTIP("Nombre del campo en origen"),TITULO("Campo Origen"),WLONX=25  
CAMPO=CAMPODEST,TOOLTIP("Nombre del campo destino"),TITULO("Campo Destino"),WLONX=25  
CAMPO=NS,TOOLTIP("Namespace de la seccion"),TITULO("Namespace"),WLONX=50
CAMPO=RUTAMADRE,UPPER,TOOLTIP("Ruta para acceder al campo origen (usado solo en entradas en documentos clave-valor"),TITULO("Ruta"),WLONX=20
CAMPO=ORDEN,TOOLTIP("Precedencia respecto a otros campos de la misma interfaz, seccion y tabla a la hora de parsear y construir documentos")
CAMPO=CODTABLA,UPPER,TOOLTIP("Tabla para insertar el campo destino en entradas y para leer el campo origen en salidas"),TITULO("Codigo Tabla"),WLONX=20
CAMPO=SWTACTIVO,TOOLTIP("Habilita o deshabilita el campo,Default =S")
                ,POSTCHANGE=FVERIFICA("SN","Valores: S=Activo, N=No activo"),TITULO("A"),WLONX=12
CAMPO=SWTIDORI,TOOLTIP("Indica si se trata o no de un campo identificativo de un segmento/bloque"),TITULO("Id.O "),WLONX=12
CAMPO=SWTIDDEST,TOOLTIP("Indica si se trata o no de un campo identificativo de un segmento/bloque"),TITULO("Id.D"),WLONX=12
CAMPO=SWTACTUALIZA,TOOLTIP("Autoriza o no la posibillidad de actualizar el campo (usado solo en entradas"),TITULO("Aut."),WLONX=12
CAMPO=TIPOCAMPO,TOOLTIP("Naturaleza del campo (CHAR, NUM, BLOB)DEFAULT = ´CHAR´"),TITULO("T. Campo")
CAMPO=LONGITUD,TOOLTIP("Longitud del campo dentro del fichero"),TITULO("Lon"),WLONX=15
CAMPO=NUMDECIMALES,TOOLTIP("Numero de decimales caso de tratarse de un campo numerico (usado solo con documentos posicionales)"),TITULO("Dec"),WLONX=12
CAMPO=FUNCDEF,TOOLTIP("Valor por defecto del campo destino en caso de que su origen se encuentre vacio (usado solo en entrada"),TITULO("FunDefecto"),WLONX=25 
CAMPO=FUNCTRANSF,TOOLTIP("Funcion para generar o transformar el campo origen en el campo destino (usado solo en entradas)"),TITULO("Función"),WLONX=25   
CAMPO=VDEXTRA,TOOLTIP("Informacion extra"),TITULO("Inf. Extra")    
CAMPO=CODOPECREADO,NOENTER,TOOLTIP("Codigo del operario que creo la fila"),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de Creacion"),TITULO("Hora")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificación.Es utilizado para depuración y control de los registros en las tablas"),TITULO("Ultima modificación")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")


# Definicion de Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

CURSOR=CEXISTCOD SELECT CODTABLA AS CODTABLA FROM VDINTERFAZTAB WHERE UPPER(CODTABLA) = UPPER(:CODTABLA);

ONLINE= {F1} Ayuda   {F2} Consulta    {F4} Grabar Registto
	{Esc} Cerrar pantalla  {F9} Borrar Registro {Mayus+F10} Menú contextual;