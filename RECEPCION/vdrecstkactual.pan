#*****************************************************************
#M�dulo: VDRECSTKORI.PAN
#Funcionalidad : 
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
STOCK ACTUAL DE LA RECEPCION
Matr�cula          Art�culo          Lote              Cantidad          
_18_______________ _40______________ _40______________ ############       
|
SOLOQUERY
SELECT=SELECT CODMAT, CODART, CODLOT, SUM(CANTIDAD) CANTIDAD
         FROM VDSTOCK;
GROUPBY=CODMAT, CODART, CODLOT, BLOQUEOS;


CAMPO=CODRECEP,VIRTUAL,OCULTO
CAMPO=CODMAT,TOOLTIP("N�mero de recepci�n dentro de la misma orden de recepci�n"),TITULO("Matr�cula")
CAMPO=CODART,TOOLTIP("C�digo de art�culo"),TITULO("Art�culo")
CAMPO=CODLOT,TOOLTIP("C�digo del Lote"),TITULO("Lote")
CAMPO=CANTIDAD,TOOLTIP("Cantidad recepcionada"),TITULO("Cantidad")



CONTEXTUAL=FEJECUTAFORM("VDCONTE","S","CODMAT=:CODMAT")

