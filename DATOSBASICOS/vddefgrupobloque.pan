# M�dulo   : VDDEFGRUPOBLOQUE.PAN
# Funci�n  : Mantenimiento de grupo de propiedades por defecto de bloques
#
# Creaci�n : 22-12-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
GRUPO DE PANTALLAS

_32___________________________
|


SOLOQUERY
SELECT=SELECT GRUPOBLOQUE FROM 
           (SELECT DISTINCT GRUPOBLOQUE FROM VDDEFBLOQUE 
             UNION 
            SELECT '%' GRUPOBLOQUE FROM VDDEFBLOQUE);
ORDERBY=DECODE(GRUPOBLOQUE,'%',0,1);

CAMPO=GRUPOBLOQUE,TITULO("Grupo")



