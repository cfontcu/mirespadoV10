# M�dulo   : VDSELDIVIS.PAN
# Funci�n  : Selecci�n de divisiones
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
Selecci�n de divisi�n
Div. Designacion                    Emp Designaci�n.
_20_ _40___________________________ ___ _40__________________________________________
|

TABLA=VDDIVIS



CAMPO=CODDIV,TOOLTIP("C�digo de la divisi�n")
CAMPO=DESDIV,TOOLTIP("Designaci�n de la divisi�n")
CAMPO=CODEMP,TOOLTIP("Empresa"),POSTCHANGE=FDESIGNACION("CSELEMP","No existe empresa")
CAMPO=DESEMP,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la empresa")

CURSOR=CSELEMP SELECT DESEMP FROM VDEMPRE WHERE CODEMP=:CODEMP;



