Descripci�n
 _1024_____________________________________________________________________________________________________________________________________
|
TABLA=VDINTERFAZLIN


PROTECT("IMPLANTADOR")

PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
WDESPLEGADO
POSTCOMMIT=FPULSATECLAS("CF6","CF2","F2")

CAMPO=CODINTERFAZ,VIRTUAL,OCULTO,TOOLTIP("Tipo de interfase")
CAMPO=SECCION,VIRTUAL,OCULTO,TOOLTIP("Tipo de formato para una interfase")
CAMPO=ORDEN,VIRTUAL,OCULTO,TOOLTIP("Orden del campo dentro del fichero"),TITULO("Ord")
CAMPO=CAMPO,VIRTUAL,OCULTO,UPPER,TOOLTIP("Nombre del campo de 10"),TITULO("Campo")
CAMPO=CAMPORI,VIRTUAL,OCULTO,UPPER,TOOLTIP("Nombre de la tabla de V10 desde donde se obtendr� o desde donde se insertar� o modificar�"),TITULO("Tabla")
CAMPO=DESCAMPO,MIXED,TOOLTIP("Descripci�n del campo que se imprimir� en la documentaci�n de interfases"),TITULO("Descripci�n"),REGPAG=5
CAMPO=CODOPEMODIF,OCULTO,"_32__________"
CAMPO=FECMODIF,OCULTO,"�D-MM-Y.YYY" 
CAMPO=HORAMODIF,OCULTO,"_8______"

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

