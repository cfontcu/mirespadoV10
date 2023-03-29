#*****************************************************************
#Módulo: VDVDBLOB.PAN
#Funcionalidad : 
#Autor: CFM      
#Fecha: 24-11-2022
#*****************************************************************
#* Histórico de cambios
#* ====================
CARGA DE INTERFASES
Tipo Objeto    Tipo de objeto     Inf. Extra          Operario     Fecha Creacion         Usuario     Ultima modificacion    Contenido
_20_________   _20___________     _255____________    _32_____    ¿D-MM-Y.YYY _8______   _32_____    ¿D-MM-Y.YYY _8______    _2000_____________________________________________________________________________________      
|
TABLA=VDBLOB
ORDERBY= CODOBJ DESC;
REGPAG=20

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR AL INSERTAR REGISTRO PROBLEMAS CON FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

PREQUERY=FEJECUTA("CONVERTIR","error de dato")

CAMPO=CODOBJ,VIRTUAL,OCULTO
CAMPO=TIPOBJ,TOOLTIP("Tipo de objeto (PEDIDO, ARTIC, MOVIM, etc.)"),TITULO("Tipo de objeto"),WLONX=40
CAMPO=TIPOBLOB,TOOLTIP("Tipo de datos.)"),TITULO("Tipo de dtos"),WLONX=40
CAMPO=VDEXTRA,TOOLTIP("Información extra"),TITULO("Inf. Extra"),WLONX=40
CAMPO=CODOPECREADO,TOOLTIP("Usuario que ha "),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de creacion de la fila")
CAMPO=CODOPEMODIF,TOOLTIP("Codigo del operario que modifico por ultima vez la fila"),TITULO("Usuario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la ultima modificacion de la fila"),TITULO("Ultima modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la ultima modificacion de la fila")
CAMPO=:MY_VAR ,AUXILIAR,TOOLTIP("CONTENIDO"),TITULO("Contenido")

# Definicion de los Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

CURSOR=CONVERTIR DECLARE       
           MY_VAR LONG;
        BEGIN 
            FOR X IN  ( SELECT BYTES FROM  VDBLOB WHERE CODOBJ = :CODOBJ )
            loop
                MY_VAR := dbms_lob.substr( x.bytes, 4000, 1 );
                MY_VAR := utl_raw.cast_to_varchar2(MY_VAR);
            END LOOP;
        END;@
         


ONLINE= (F1) Ayuda   (F2) Consulta    (F4) Grabar Tabla de Interfaz
	(Esc) Cerrar pantalla  (F9) Borrar Tabla de Interfaz (Mayus+F10) Menú contextual;