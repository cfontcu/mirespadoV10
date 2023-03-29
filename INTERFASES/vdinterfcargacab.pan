#*****************************************************************
#Módulo: VDINTERFCARGACAB.PAN
#Funcionalidad : 
#Autor: ICC      
#Fecha: 29-04-2008
#*****************************************************************
#* Histórico de cambios
#* ====================
CABECERA DE LAS INTERFASES

Código    Estado Interfaz            Tipo Ultima modificación             Inf. extra    Contenido             
######### #####  _20_________________ _   _32_______ ¿D-MM-Y.YYY _8______ _255_______   _20000_______________________________________________________
|
TABLA=VDINTERFCARGACAB
ORDERBY=CODINTERFASE DESC;
REGPAG=20

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODINTERFASE,TOOLTIP("Código de la interfase"),TITULO("Código")
CAMPO=STATUS,UPDATE,TOOLTIP("Estado en que se encuentra"),TITULO("Estado"),WLONX=20
CAMPO=TIPOINTERFASE,TOOLTIP("Nombre de la interfaz"),TITULO("Interfaz")
CAMPO=TIPOFICHERO,UPDATE,TOOLTIP("Tipo de interfase"),TITULO("Tipo"),WLONX=20
CAMPO=CODOPEMODIF,TOOLTIP("Usuario que ha realizado la ultima modificación.Es utilizado para depuración y control de los registros en las tablas"),TITULO("Ultima modificación")
CAMPO=FECMODIF,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")
CAMPO=HORAMODIF,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y útiles para el cliente"),TITULO("Inf. Extra")
CAMPO=FICH_XML,TITULO("Contenido")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

