#*****************************************************************
#Módulo: VDBLOBMETA.PAN
#Funcionalidad : 
#Autor: CFM      
#Fecha: 13-12-2022
#*****************************************************************
#* Histórico de cambios
#* ====================
CARGA DATOS INTERFAZ METRO META
Codigo objeto Tipo de objeto   Tipo Blob       Codif             Nombre      Inf. Extra         Operario     Fecha Creacion         Usuario      Ultima modificacion     
_60________   _20_________     _20_________   _100____________   _40_______  _255_____________  _32_____     ¿D-MM-Y.YYY _8______   _32_____     ¿D-MM-Y.YYY _8______    
|
TABLA=VDBLOBMETA
ORDERBY= CODOBJ DESC;
REGPAG=20

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSEINSERT","ERROR AL INSERTAR REGISTRO PROBLEMAS CON FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")


CAMPO=CODOBJ,TOOLTIP("CODIGO OBJETO"),TITULO("Codigo objeto")
CAMPO=TIPOBJ,TOOLTIP("Tipo de objeto (PEDIDO, ARTIC, MOVIM, etc.)"),TITULO("Tipo de objeto")
CAMPO=TIPOBLOB,TOOLTIP("Tipo de datos.)"),TITULO("Tipo de dtos")
CAMPO=CODIF,TOOLTIP("Codificación de los datos"),TITULO("Codif")
CAMPO=NOMFICH,TOOLTIP("Nombre en el sistema de ficheros del BLOB"),TITULO("Nombre")
CAMPO=VDEXTRA,TOOLTIP("Información extra"),TITULO("Inf. Extra"),WLONX=40
CAMPO=CODOPECREADO,TOOLTIP("Usuario que ha "),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de creacion de la fila")
CAMPO=CODOPEMODIF,TOOLTIP("Codigo del operario que modifico por ultima vez la fila"),TITULO("Usuario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la ultima modificacion de la fila"),TITULO("Ultima modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la ultima modificacion de la fila")
CAMPO=CONTENIDO,AUXILIAR,TOOLTIP("CONTENIDO"),TITULO("Contenido")

# Definicion de los Cursores

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

       


ONLINE= (F1) Ayuda   (F2) Consulta    (F4) Grabar Tabla de Interfaz
	(Esc) Cerrar pantalla  (F9) Borrar Tabla de Interfaz (Mayus+F10) Menú contextual;