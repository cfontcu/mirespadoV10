# M�dulo   : VDASISPAN2.PAN
# Funci�n  : Selecci�n de la tabla
#
# Creaci�n : 31-08-2009
# Autor    : FGS
###########################################
# Hist�rico de cambios:
SELECCION DE TABLA
 TABLA 
 _32________________ _4000________________________________________________________________________________________________________________________
|


REGPAG=46
SOLOQUERY
SELECT=SELECT TAB.TABLE_NAME,COM.COMMENTS FROM USER_TABLES TAB, USER_TAB_COMMENTS COM WHERE COM.TABLE_NAME(+)=TAB.TABLE_NAME;
ORDERBY=TAB.TABLE_NAME;

CAMPO=TABLE_NAME,TITULO("Tabla")
CAMPO=COMMENTS,TITULO("Comentario")

TECLA=F10,FPULSATECLAS("F3","F2")
