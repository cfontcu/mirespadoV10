# M�dulo   : VDORAERR.PAN
# Funci�n  : MANEJO DE ERRORES ORACLE
#
# Creaci�n : 19-11-2009
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:
ASIGNACION DE MANEJADORES DE ERRRES ORACLE
ORD RANGOEXE               RANGOERROR             NIVEL            DESCERROR             
@L@ _1024_________________ _1024_________________ @L@@ _50________ _256_____________________________________________________________________________
|

TABLA=VDORAERR
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
ORDERBY=ORDEN;
REGPAG=20

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=ORDEN,TITULO("ORDEN"),TOOLTIP("Orden �nico de la asignaci�n de tartamiento de errores")
CAMPO=RANGOEXE,TITULO("RANGO PROGRAMAS"),TOOLTIP(" Rango de programas a tratar los errores (si .exe)")
CAMPO=RANGOERROR,TITULO("RANGO ERRORES"),TOOLTIP("Rango de errores a tratar")
CAMPO=NIVELERR,TITULO("Nivel"),TOOLTIP("'Nivel de Error; 0 Salirse, 1 Debug, 2 Warning"),COMBOX("CNIVEL"),POSTCHANGE=FDESIGNACION("CDESNIVEL","EEEE")
CAMPO=DESNIVEL,AUXILIAR,NOENTER
CAMPO=DESCERROR,TITULO("DESCRIPCION"),TOOLTIP("Descripci�n de la asignaci�n de errores")
CAMPO=CODOPEMODIF,OCULTO," _32___________________",TITULO("ULT. MODIFICACION"),TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,OCULTO,"�D-MM-Y.YY",TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos de los status. Es utilizado para depuraci�n y control de los registros en las tablas.")
CAMPO=HORAMODIF,OCULTO,"________",TOOLTIP("Es la  hora en que se efectu� alguna modificaci�n a los datos de los status. Es utilizado para depuraci�n y control de los registros en las tablas.")
CAMPO=CODCOMEN,OCULTO,"@L"


# PARTE PERSONALIZADA DE LA PANTALLA 
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


CURSOR=CNIVEL SELECT '0', 'FATAL','SALIR DEL PROGRAMA' FROM DUAL UNION
              SELECT '1', 'DEBUG','DEBUG ORACLE' FROM DUAL UNION
              SELECT '2', 'WARNING','MENSAJE DE LOG Y CONTINUA' FROM DUAL;
              
CURSOR=CDESNIVEL SELECT DECODE(:NIVELERR,0,'FATAL',1,'DEBUG',2,'WARNING') DESNIVEL FROM DUAL;              
