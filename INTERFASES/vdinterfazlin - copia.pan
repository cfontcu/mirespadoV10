#*****************************************************************
#Módulo: VDINTERFAZLIN.PAN
#Funcionalidad : Mantenimiento de los campos de una interfase.
#       IMPORTANTE, los campos que formen la clave primaria, no podrán tener asociada una función que calcule su valor.
#        Validaciones principales:
#            - El campo debe existir en la tabla indicada
#            - No se puede incluir el mismo campo y tabla en distinta posición.
#            - No se puede informar el campo defecto y función, se usa uno u otro.
#
#Autor: CFM     
#Fecha: 11-11-2022
#*****************************************************************
#* Histórico de cambios
#* ====================
MANTENIMIENTO DE LAS LINEAS METRO

Ord  Seccion       Nombre Campo     Campo Origen     Campo Destino     Namespace          Ruta         Descripcion   Codigo Tabla  Habilita Repite Autoriza Tipo Campo  Long   Dec Defecto            Funcion       Operario   Fecha de Creacion     Usuario   Ultima modificación     Inf. Extra
### _60__________ _60____________ _60______________ _60______________  _500______________ _255_______  _255_______   _60__________     _       _       _     _10______   ###    #  _512___________  _255________    _32_______ ¿D-MM-Y.YYY _8______  _32_____  ¿D-MM-Y.YYY _8______    _255________ 
|
TABLA=VDINTERFAZLIN
ORDERBY=ORDEN,CODTABLA;


#PROTECT("IMPLANTADOR")

POSTQUERY=FEJECUTA("CSELINI","NO PUEDO CALCULAR OFFSET DE INICIO")

CURSOR=CSELINI SELECT NVL(SUM(LONGITUD)+1,1) INICIO FROM VDINTERFAZLIN WHERE ORDEN<:ORDEN AND  TIPOINTERFAZ:TIPOINTERFAZ AND SECCION: SECCION;

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "-VALFORMATEO","EN INTERFASES DE SALIDA DEBE INDICAR EL FORMATEO DEL CAMPO",
                   "CVALCAMPOTABLA", "ERROR, NO EXISTE LA TABLA O EL CAMPO EN ESA TABLA",
                   "-CVALREPETIR", "ERROR, CAMPO REPETIDO PARA LA MISMA TABLA",
                   "-CINCOHERENCIA", "ERROR, SOLO DEBE INFORMAR CAMPO POR DEFECTO O FUNCION,\nAMBAS SON INCOMPATIBLES",
                   "-CINCOHERENCIA2", "INFORME EL NOMBRE DE LA LIBRERIA DE LA FUNCION")

PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "-VALFORMATEO","EN INTERFASES DE SALIDA DEBE INDICAR EL FORMATEO DEL CAMPO",
                   "CVALCAMPOTABLA", "ERROR, NO EXISTE LA TABLA O EL CAMPO EN ESA TABLA",
                   "-CINCOHERENCIA", "ERROR, SOLO DEBE INFORMAR CAMPO POR DEFECTO O FUNCION,\nAMBAS SON INCOMPATIBLES",
                   "-CINCOHERENCIA2", "INFORME EL NOMBRE DE LA LIBRERIA DE LA FUNCION",
                   "-CINCOHERENCIA3", "ES OBLIGATORIO INFORMAR LA FUNCION, SI SE INDICA EN TABLA FUNCION")

CAMPO=CODINTERFAZ,VIRTUAL,OCULTO
CAMPO=SECCION,UPPER,TOOLTIP("Subcodigo de identificacion (en salidas corresponde al segmento/bloque del documento a construir)"),WLONX=25
CAMPO=CAMPO,UPPER,TOOLTIP("Nombre del campo"),WLONX=25   
CAMPO=CAMPORI,TOOLTIP("Nombre del campo en origen"),TITULO("Campo Origen"),WLONX=25  
CAMPO=CAMPODEST,TOOLTIP("Nombre del campo destino"),TITULO("Campo Destino"),WLONX=25  
CAMPO=NS,TOOLTIP("Namespace de la seccion"),TITULO("Namespace"),WLONX=100
CAMPO=RUTA,UPPER,TOOLTIP("Ruta para acceder al campo origen (usado solo en entradas en documentos clave-valor"),TITULO("Ruta"),WLONX=20
CAMPO=DESCAMPO,UPPER,TOOLTIP("Descripcion breve del campo"),TITULO("Descripcion"),WLONX=50
CAMPO=ORDEN,UPPER,TOOLTIP("Precedencia respecto a otros campos de la misma interfaz, seccion y tabla a la hora de parsear y construir documentos"),TITULO("Ord")
CAMPO=CODTABLA,UPPER,TOOLTIP("Tabla para insertar el campo destino en entradas y para leer el campo origen en salidas"),TITULO("Codigo Tabla"),WLONX=20
CAMPO=SWTACTIV,TOOLTIP("Habilita o deshabilita el campo,Default =S"),TITULO("Habilita")
CAMPO=SWTID,TOOLTIP("Indica si se trata o no de un campo identificativo de un segmento/bloque que se repite, default = 'N'"),TITULO("Repite")
CAMPO=SWTACTUALIZA,TOOLTIP("Autoriza o no la posibillidad de actualizar el campo (usado solo en entradas"),TITULO("Autoriza")
CAMPO=TIPOCAMPO,TOOLTIP("Naturaleza del campo (CHAR, NUM, BLOB)DEFAULT = ´CHAR´"),TITULO("Tipo Campo")
CAMPO=LONGITUD,TOOLTIP("Longitud del campo dentro del fichero"),TITULO("Long"),WLONX=15
CAMPO=DECIMALES,TOOLTIP("Numero de decimales caso de tratarse de un campo numerico (usado solo con documentos posicionales)"),TITULO("Dec"),WLONX=12
CAMPO=VALDEFECTO,TOOLTIP("Valor por defecto del campo destino en caso de que su origen se encuentre vacio (usado solo en entrada"),TITULO("Defecto")
CAMPO=FUNCION,TOOLTIP("Funcion para generar o transformar el campo origen en el campo destino (usado solo en entradas)"),TITULO("Función"),WLONX=25
CAMPO=VDEXTRA,TOOLTIP("Informacion extra"),TITULO("Inf. Extra")             
CAMPO=CODOPECREADO,TOOLTIP("Codigo del operario que creo la fila"),TITULO("Operario")
CAMPO=FECCREADO,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,TOOLTIP("Hora de Creacion"),TITULO("Hora")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificación.Es utilizado para depuración y control de los registros en las tablas"),TITULO("Ultima modificación")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")



CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


#En interfases de salida el formateo del campo no puede ser blanco
CURSOR=VALFORMATEO SELECT :DEFECTO
                     FROM DUAL
                    WHERE TRIM(:FORMATEO) IS NULL
                      AND :TIPOFICHERO ='S';

#Si es una interfase de entrada, no se puede incluir el mismo campo y tabla en distinta posición.
CURSOR=CVALREPETIR SELECT :DEFECTO
                     FROM VDINTERFASELIN
                    WHERE TIPOINTERFASE = :TIPOINTERFASE
                      AND FORMATO       = :FORMATO
                      AND CAMPO         = :CAMPO
                      AND TABLA         = :TABLA
                      AND ORDEN        != :ORDEN
                      AND :TIPOFICHERO  = 'E';

#El campo debe existir en la tabla indicada
CURSOR=CVALCAMPOTABLA SELECT :DEFECTO
                        FROM USER_TAB_COLUMNS
                       WHERE (TABLE_NAME IN (:TABLA,SUBSTR(:TABLA,1, LENGTH(:TABLA)-1))
                         AND COLUMN_NAME = :CAMPO)
                         OR :TABLA IN ('DUMMY', 'FUNCION')
                     UNION
                       SELECT :DEFECTO FROM DUAL WHERE :TABLA IS NULL;

#No se puede informar el campo defecto y función, se usa uno u otro.
CURSOR=CINCOHERENCIA SELECT :DEFECTO
                       FROM DUAL
                      WHERE :DEFECTO IS NOT NULL AND :FUNCION IS NOT NULL;


#Se debe informar la librería si se informa la función.
CURSOR=CINCOHERENCIA2 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NOT NULL AND :LIBRERIA IS NULL;
                      
#Se debe informar la función si se el nombre de tabla es FUNCION.
CURSOR=CINCOHERENCIA3 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NULL 
                        AND :TABLA = 'FUNCION';
                      
#Se debe informar la función si se el nombre de tabla es FUNCION.
CURSOR=CINCOHERENCIA4 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NULL 
                        AND :TABLA = 'FUNCION';
