# M�dulo   : VDUBIBAJOMIN.PAN
# Funci�n  : Consulta de ubicaciones bajo m�nimo. Listado de �reas
#
# Creaci�n : 11-07-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
AREA
_20_______ _40_____________________________________
|



SOLOQUERY
SELECT=SELECT DISTINCT CODAREADEST 
         FROM VDFLUJOPARAM FLP
        WHERE FLP.TAREA = 'RECARGAR';
ORDERBY=CODAREADEST;
        
CAMPO=CODAREADEST,NOENTER,TOOLTIP("C�digo de area"),POSTCHANGE=FDESIGNACION("+CSELDESAREA","")
CAMPO=DESAREA,AUXILIAR,NOENTER,TOOLTIP("Nombre completo del area")

CURSOR=CSELDESAREA SELECT DESAREA FROM VDAREA WHERE CODAREA = :CODAREADEST;

