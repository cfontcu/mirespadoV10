# M�dulo   : VDORAERR.PAN
# Funci�n  : MANEJO DE ERRORES ORACLE
#
# Creaci�n : 19-11-2009
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:
ASIGNACION DE MANEJADORES DE ERRRES ORACLE
 
 Lib. Funcion: _256_________________  Funcion: _32_________________         
 
 Param: _256__________________________________________________________________________________________________________________________
 
 Tiempo Espera en seg. @L@@@                      Ult. Modificacion: _32___________________ �D-MM-Y.YY ________ 
 
|

TABLA=VDORAERR
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
ORDERBY=ORDEN;
REGPAG=20
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=ORDEN,VIRTUAL,OCULTO
CAMPO=RANGOEXE,VIRTUAL,OCULTO,TITULO("RANGO PROGRAMAS"),TOOLTIP(" Rango de programas a tratar los errores (si .exe)")
CAMPO=RANGOERROR,VIRTUAL,OCULTO,TITULO("RANGO ERRORES"),TOOLTIP("Rango de errores a tratar")
CAMPO=NIVELERR,VIRTUAL,OCULTO,TITULO("Nivel"),TOOLTIP("'Nivel de Error; 0 Salirse, 1 Debug, 2 Warning, 3 Reiniciar programa")
CAMPO=DESCERROR,VIRTUAL,OCULTO,TITULO("DESCRIPCION"),TOOLTIP("Descripci�n de la asignaci�n de errores")
CAMPO=LIBALGORITMO,TITULO("Librer�a del la funcion de manejo de error. SYSTEM para llamadas al sistema operativo (system(...))"),TOOLTIP("Librer�a donde se encuentra la funci�n que trata los errores")
CAMPO=FUNCIONALG,TITULO("Algoritmo"),TOOLTIP("Funci�n de la librer�a que trata los errores"),MIXED
CAMPO=PARAM,TITULO("Parametro del Algoritmo")
CAMPO=TIEMPOESPERA,TITULO("Tiempo Esp."),TOOLTIP("Tiempo en segundos antes de retornar de la funci�n de tratamiento de error"),WLONX=50
CAMPO=CODOPEMODIF,TITULO("ULT. MODIFICACION"),TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos de los status. Es utilizado para depuraci�n y control de los registros en las tablas.")
CAMPO=HORAMODIF,TOOLTIP("Es la  hora en que se efectu� alguna modificaci�n a los datos de los status. Es utilizado para depuraci�n y control de los registros en las tablas.")

# PARTE PERSONALIZADA DE LA PANTALLA 