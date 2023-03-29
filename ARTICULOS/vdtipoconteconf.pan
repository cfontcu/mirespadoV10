# M�dulo   : VDTIPOCONTECONF.PAN
# Funci�n  : Configuraci�n del comportamiento de tipos de contenedores
#
# Creaci�n : 20-05-2009
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CONFIGURACION COMPORTAMIENTO DE TIPOS DE CONTENEDOR
Rango Tipos               Rango Almacenes          Rango Areas              Acc Pool         CodComen  Ultima modificaci�n    
_1000___________________  _1000___________________ _1000___________________  _  _20_________ @@@@@@@@@ _32________ �D-MM-Y.YY  ________
|

TABLA=VDTIPOCONTECONF

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=RANGOTIPOCONTE,TITULO("Rango Tipos")
CAMPO=RANGOALMA,TITULO("Rango Almacenes")
CAMPO=RANGOAREA,TITULO("Rango Areas")
CAMPO=ACCION,POSTCHANGE=FVERIFICA("BMN","Debe introducir (B)orrar, (M)over o (N)ada"),TOOLTIP("Qu� se hace con el contenedor al vaciarse ?\n (B)orrarse, (M)overse al Pool o (N)ada"),TITULO("Acc"),WLONX=15
CAMPO=CODUBI,TOOLTIP("Ubicaci�n a la que se mueve en caso de Acci�n = (M)over"),TITULO("Pool")
CAMPO=CODCOMEN,NOENTER,TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


