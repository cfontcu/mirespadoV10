# M�dulo   : VDSELAREA.PAN
# Funci�n  : Selecci�n de areas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
Selecci�n de area
C�digo       Designacion                    Almacen    Designaci�n.
_20_________ _40___________________________ __________ _40__________________________________________
|

TABLA=VDAREA



CAMPO=CODAREA,TOOLTIP("C�digo del �rea")
CAMPO=DESAREA,TOOLTIP("Designaci�n del �rea")
CAMPO=CODALM,TOOLTIP("Almac�n"),POSTCHANGE=FDESIGNACION("CSELALM","No exsiste almac�n")
CAMPO=DESALM,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del almac�n")

CURSOR=CSELALM SELECT DESALM FROM VDALMA WHERE CODALM=:CODALM;



