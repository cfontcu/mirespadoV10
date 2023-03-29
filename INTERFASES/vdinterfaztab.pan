#*****************************************************************
# Módulo: VDINTERFAZTAB.PAN
#Funcionalidad : Mantenimiento de las tablas a mantener por la interfaz 
#Autor: Carmen Fontcuberta      
#Fecha: 15-11-2022
#*****************************************************************
#* Histórico de cambios
#* ====================
#
#*****************************************************************
TABLAS A MANTENER POR INTERFAZ 
 Codigo de la tabla    Ord Nombre Tabla       Tabla Madre          Inf. extra                    Operario   Fecha de Creacion    Usuario    Ultima modificación
 _128_________________ @@@ _60_______________ _60________________  _255_________________________ _32______  ¿D-MM-Y.YYY _8______ _32_______ ¿D-MM-Y.YYY _8______
|

REGPAG=25
WLONY=300
WLONX=1600

AQUERY

TABLA=VDINTERFAZTAB

ORDERBY=ORDEN ASC,CODTABLA ASC;

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
#                   "CSEINSERT","ERROR AL INSERTAR",
#                   "-CEXISTTABLA","Ya existe el codigo de la tabla")
                   
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODTABLA,TOOLTIP("Codigo Tabla desde el punto de vista de\nla funcionalidad de las interfases"), TITULO("Código")
#      ,POSTCHANGE=FVALNOCERO("El código de la tabla no puede estar vacío")
CAMPO=ORDEN,TOOLTIP("Precedencia respecto a otras tablas\n(por ejemplo cabeceras antes que sus lineas)"),TITULO("Ord")
CAMPO=NOMBRE,TOOLTIP("Nombre real de la tabla"),TITULO("Nombre Tabla")
#      ,POSTCHANGE=FVALNOCERO("El Nombre no puede estar vacío")
CAMPO=CODTABLAMADRE,TOOLTIP("Codigo de la tabla Madre"),TITULO("Tabla Madre")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y útiles para el cliente"),TITULO("Inf. Extra"),WLONX=25
CAMPO=CODOPECREADO,NOENTER,TOOLTIP("Codigo del operario que crea la fila"),TITULO("Operario")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha de creacion de la fila"),TITULO("Fecha Creacion")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora de Creacion")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificación.\nEs utilizado para depuración y control de los registros en las tablas"),TITULO("Usuario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas"),TITULO("Ultima modificación")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPECREADO, VD.FECHASYS FECCREADO, VD.HORASYS HORACREADO,
                        VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF                                                        
                   FROM DUAL;

CURSOR=CSEINSERT SELECT VDUSER.GETUSER CODOPECREADO,VD.FECHASYS FECCREADO,VD.HORASYS HORACREADO FROM DUAL;

CURSOR=CEXISTTABLA SELECT CODTABLA AS CODTABLA FROM VDINTERFAZTAB WHERE UPPER(CODTABLA) = UPPER(:CODTABLA);

CURSOR=CEXISTORDEN SELECT ORDEN AS ORDEN FROM VDINTERFAZTAB WHERE ORDEN =:ORDEN;

ONLINE= {F1} Ayuda   (F2) Consulta    (F4) Grabar Tabla de Interfaz
	(Esc) Cerrar pantalla  (F9) Borrar Tabla de Interfaz (Mayus+F10) Menú contextual;