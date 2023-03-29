#*****************************************************************
#M�dulo: VDINTERFASELIN.PAN
#Funcionalidad : Mantenimiento de los campos de una interfase.
#       IMPORTANTE, los campos que formen la clave primaria, no podr�n tener asociada una funci�n que calcule su valor.
#        Validaciones principales:
#            - El campo debe existir en la tabla indicada
#            - No se puede incluir el mismo campo y tabla en distinta posici�n.
#            - No se puede informar el campo defecto y funci�n, se usa uno u otro.
#
#Autor: ICC      
#Fecha: 16-04-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
MANTENIMIENTO DE LAS LINEAS DEL FORMATO DE INTERFASE SELECCIONADO

Ord Campo Host     Campo            Tabla             Activo Acci�n Mod Tipo Long Ini   Dec F Defecto              Funcion            Par�metros    Libreria          EtiquetaXML       Filtro     CampoFiltro Ultima modificaci�n             Inf. extra Descripci�n
### _32___________ _32_____________ _32_______________   _     _     _   _   #### @,@@@  #  _ _512________________ _32_______________ _100_________ _256_____________ _256_____________ _32_______ _32_______ _32_______ �D-MM-Y.YYY _8______ _255______ _1024_____________________________________________________________________________________________________________________________________

|
TABLA=VDINTERFASELIN
ORDERBY=ORDEN,TABLA;


#PROTECT("IMPLANTADOR")

POSTQUERY=FEJECUTA("CSELINI","NO PUEDO CALCULAR OFFSET DE INICIO")

CURSOR=CSELINI SELECT NVL(SUM(LONGITUD)+1,1) INICIO FROM VDINTERFASELIN WHERE ORDEN<:ORDEN AND  TIPOINTERFASE=:TIPOINTERFASE AND FORMATO=:FORMATO;

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

CAMPO=TIPOFICHERO,VIRTUAL,OCULTO,AUXILIAR
CAMPO=TIPOINTERFASE,VIRTUAL,OCULTO,TOOLTIP("Tipo de interfase")
CAMPO=FORMATO,VIRTUAL,OCULTO,TOOLTIP("Tipo de formato para una interfase")
CAMPO=ORDEN,TOOLTIP("Orden del campo dentro del fichero"),TITULO("Ord"),WLONX=10
CAMPO=CAMPOHOST,UPPER,TOOLTIP("Nombre del campo de ERP del cliente"),TITULO("Campo Host"),MIXED
CAMPO=CAMPO,UPPER,TOOLTIP("Nombre del campo de 10"),TITULO("Campo"),MIXED
CAMPO=TABLA,UPPER,TOOLTIP("Nombre de la tabla de V10 desde donde se obtendr� o desde donde se insertar� o modificar�"),TITULO("Tabla")
CAMPO=SWTACTIVO,UPPER,TOOLTIP("Indicador de si el campo se encontrar� en la l�nea de la interfase o no.\n Posibles valores: S-Viene en fichero\n N-No viene en fichero"),
                POSTCHANGE=FVERIFICA("SN","Valores: S=Activo, N=No activo"),TITULO("Activo"),WLONX=27
CAMPO=ACCION,UPPER,TOOLTIP("Acci�n a realizar sobre el campo. Posibles valores: \nA-a�adir, el campo est� inactivo, pero se quiere guardar el valor por defecto, \nI-Ignorar, vendr� en el fichero pero no se tratar�, ni se guardar� su valor por defecto, \nD- En caso de venir vac�o se tomar� el valor por defecto"),
             POSTCHANGE=FVERIFICA("AID","Valores: A-a�adir, el campo est� inactivo, pero se quiere guardar el valor por defecto, \nI-Ignorar, vendr� en el fichero pero no se tratar�, ni se guardar� su valor por defecto, \nD- En caso de venir vac�o se tomar� el valor por defecto"),
             TITULO("Acci�n"),WLONX=27
CAMPO=SWTACTUALIZA,UPPER,TOOLTIP("Indicador de si se puede modificar o no el campo.\n Posibles valores: S o N"),
                   POSTCHANGE=FVERIFICA("SN","Valores: S=Se permite actualizar, N=No se permite actualizar"),
                   TITULO("Mod"),WLONX=15
CAMPO=TIPODATO,UPPER,TOOLTIP("Tipo de dato. Posibles valores: C-char o N-Num�rico"),TITULO("Tipo"),WLONX=17
CAMPO=LONGITUD,TOOLTIP("Longitud del campo dentro del fichero"),TITULO("Long"),WLONX=15
CAMPO=INICIO,AUXILIAR,NOENTER
CAMPO=DECIMALES,TOOLTIP("N� de decimales, en caso de ser n�merico"),TITULO("Dec"),WLONX=12
CAMPO=FORMATEO,TOOLTIP("Formateo del campo. \nPosibles valores: \nC-ceros a la izquierda, \nI-Blancos a la izquierda, \nD-Blancos a la derecha\nT-trim del campo\nN-Nulo si 0"),
               POSTCHANGE=FVERIFICA("CIDTN ", "Posibles valores: \nC-ceros a la izquierda, \nI-Blancos a la izquierda, \nD-Blancos a la derecha\nT-trim del campo\nN-Nulo si 0"),
               TITULO("F")
CAMPO=DEFECTO,TOOLTIP("Valor por defecto"),TITULO("Defecto")
CAMPO=FUNCION,TOOLTIP("Funci�n de c"),TITULO("Funci�n")
CAMPO=PARAMETROS,TOOLTIP("Par�metros de la funci�n"),TITULO("Par�metros")
CAMPO=LIBRERIA,TOOLTIP("Libreria de la funci�n de c"),TITULO("Librer�a")
CAMPO=ETIQUETA_XML,TOOLTIP("Etiqueta XML donde se encuentra el campo"),TITULO("Etiqueta XML")
CAMPO=FILTRO,TOOLTIP("Filtro utilizado para seleccionar la etiqueta XML en caso de que est� repetida"),TITULO("Filtro")
CAMPO=CAMPO_FILTRO,TOOLTIP("Campo utilizado para filtro XML en caso de etiqueta repetida"),TITULO("Campo filtro")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente"),TITULO("Inf. Extra")
CAMPO=DESCCAMPO,MIXED,TOOLTIP("Descripci�n del campo que se imprimir� en la documentaci�n de interfases"),TITULO("Descripci�n")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


#En interfases de salida el formateo del campo no puede ser blanco
CURSOR=VALFORMATEO SELECT :DEFECTO
                     FROM DUAL
                    WHERE TRIM(:FORMATEO) IS NULL
                      AND :TIPOFICHERO ='S';

#Si es una interfase de entrada, no se puede incluir el mismo campo y tabla en distinta posici�n.
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

#No se puede informar el campo defecto y funci�n, se usa uno u otro.
CURSOR=CINCOHERENCIA SELECT :DEFECTO
                       FROM DUAL
                      WHERE :DEFECTO IS NOT NULL AND :FUNCION IS NOT NULL;


#Se debe informar la librer�a si se informa la funci�n.
CURSOR=CINCOHERENCIA2 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NOT NULL AND :LIBRERIA IS NULL;
                      
#Se debe informar la funci�n si se el nombre de tabla es FUNCION.
CURSOR=CINCOHERENCIA3 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NULL 
                        AND :TABLA = 'FUNCION';
                      
#Se debe informar la funci�n si se el nombre de tabla es FUNCION.
CURSOR=CINCOHERENCIA4 SELECT :DEFECTO
                       FROM DUAL
                      WHERE :FUNCION IS NULL 
                        AND :TABLA = 'FUNCION';
