# M�dulo   : VDGINSTPROP.PAN
# Funci�n  : Mantenimiento de instancias de propiedades
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
INSTANCIAS DE CONFIGURACION
Instancia               
_40____________________________
|

SOLOQUERY
SELECT=SELECT DISTINCT INSTANCIA FROM VDCONFI WHERE GRUPOPROP=:GRUPOPROP;

ORDERBY=INSTANCIA;

CAMPO=GRUPOPROP,VIRTUAL,OCULTO
CAMPO=INSTANCIA,TOOLTIP("Instancia\nTecla SF8 copia la instancia"),TITULO("Instancia")

TECLA=SF8,FEJECUTAFORM("VDCOPIAINST","S","","ORIGEN=:INSTANCIA GRUPOPROP=:GRUPOPROP")




