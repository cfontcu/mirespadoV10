#M�dulo: VDRECURSOXFLUJO.PAN
#Funci�n: Recursos por flujo
#
# Creaci�n : 13-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
Recursos
Cod.recurso
__________ 
|                                  


SOLOQUERY
SELECT=SELECT CODRECURSO FROM VDTRAMOSRECURSO WHERE CODAREADEST=:CODAREADEST AND CODAREAORI=:CODAREAORI; 

CAMPO=CODAREAORI,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODAREADEST,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODRECURSO,NOENTER

