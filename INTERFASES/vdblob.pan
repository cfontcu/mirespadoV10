#*****************************************************************
#Módulo: VDBLOB.PAN
#Funcionalidad : Visualizar el contenido de BLOB
#Autor: Carmen Fontcuberta
#Fecha: 24-11-2022
#*****************************************************************
#* Histórico de cambios
#* ====================  TO_CHAR(SYSDATE,'YYYYMMDD')
#*****************************************************************
CARGA DATOS DE LAS INTERFAZ BLOB
Tipo de objeto   Tipo de dtos   Inf. Extra        Cod. Comentario Contenido                                                                                             Operario Fecha Creacion       Usuario  Ultima modificacion  
_20_________     _20_________   _255____________     #########    _4000________________________________________________________________________________________________ _32_____ ¿D-MM-Y.YYY _8______ _32_____ ¿D-MM-Y.YYY _8______  
|
TABLA=VDBLOB
ORDERBY= CODOBJ DESC;
REGPAG=25

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR AL INSERTAR REGISTRO PROBLEMAS CON FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODOBJ,VIRTUAL("CODITFCARGA"),OCULTO,
      POSTCHANGE=FDESIGNACION("CONVERTIR","ERROR AL RECUPERAR BLOB")
CAMPO=TIPOOBJ,TOOLTIP("Tipo de objeto (PEDIDO, ARTIC, MOVIM, etc.)"),TITULO("Tipo de objeto")
CAMPO=TIPOBLOB,TOOLTIP("Tipo de datos.)"),TITULO("Tipo de dtos")
CAMPO=VDEXTRA,TOOLTIP("Información extra"),TITULO("Inf. Extra"),WLONX=40
CAMPO=CODCOMEN,TOOLTIP("Código del comentario asociado"),TITULO("Cod. Comentario"),WLONX=40
CAMPO=CONTENIDO,AUXILIAR,TOOLTIP("Informacion contenida en el BLOB"),TITULO("Contenido")
CAMPO=CODOPECREADO,NOENTER,TOOLTIP("Usuario que ha creado la fila"),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de creacion de la fila")
CAMPO=CODOPEMODIF,TOOLTIP("Codigo del operario que modifico por ultima vez la fila"),TITULO("Usuario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la ultima modificacion de la fila"),TITULO("Ultima modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la ultima modificacion de la fila")


# Definicion de los Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

CURSOR=CONVERTIR DECLARE       
           MY_VAR LONG;
           CONTENIDO VARCHAR2(4000);
        BEGIN 
            FOR X IN  ( SELECT BYTES FROM  VDBLOB WHERE CODOBJ = :CODOBJ)
            loop
                MY_VAR := dbms_lob.substr( x.bytes, 32000, 1 );
                MY_VAR := utl_raw.cast_to_varchar2(MY_VAR);
            END LOOP;
            :CONTENIDO := MY_VAR;
        END;@
         


ONLINE= {F1} Ayuda   {F2} Consulta    {F4} Grabar Tabla de Interfaz
	{Esc} Cerrar pantalla  {F9} Borrar Tabla de Interfaz (Mayus+F10) Menú contextual;