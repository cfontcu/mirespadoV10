# M�dulo   : VDGRAFICAPIE.PAN
# Funci�n  : DEFINICION DE COLORES DE LOS SECTORES DE GRAFICAS DE PASTEL
#
# Creaci�n : 27-01-2010
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:
COLORES SECTORES
N  COLORPIE      
   @L _32________ 
|

TABLA=VDGRAFICAPIE
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=NOMBREGRAF,VIRTUAL,TOOLTIP("Nombre de la gr�fica"),OCULTO
CAMPO=NUMCOLOR,TITULO("N"),TOOLTIP("N�mero de color en la gr�fica"),NOUPDATE
CAMPO=COLORPIE,TITULO("COLOR"),TOOLTIP("Color de la gr�fica "),COMBOX("COLOR")
CAMPO=VDEXTRA,TITULO("INF. ADICCIONAL"),TOOLTIP("Campo reservado para informaci�n adiccional"),OCULTO,"_255___"
CAMPO=CODOPEMODIF,TITULO("ULT. MODIFICACION"),TOOLTIP("Operario que realiz� la �ltima modificaci�n"),OCULTO,"_32___"
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n"),OCULTO,"�D-MM-Y.YY"
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n"),OCULTO,"________"

# PARTE PERSONALIZADA DE LA PANTALLA 