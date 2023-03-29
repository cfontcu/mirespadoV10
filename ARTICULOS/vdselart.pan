# M�dulo   : VDSELART.PAN
# Funci�n  : Selecci�n de art�culos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
Selecci�n de art�culo
C�digo            Designacion           Nacional      Ean            Div.   Designacion           C�digo para div.
_40______________ _100_________________ _____________ ______________ _20___ _40__________________ _20______________
|

TABLA=VDARTIC



CAMPO=CODART,TOOLTIP("C�digo del art�culo"),TITULO("Referencia")
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo"),TITULO("Art�culo")
CAMPO=CODNAC,TOOLTIP("C�digo nacional"),TITULO("C�digo Nac.")
CAMPO=CODEAN,TOOLTIP("C�digo EAN"),TITULO("EAN")
CAMPO=CODDIV,TOOLTIP("Divisi�n"),POSTCHANGE=FDESIGNACION("CSELDIVIS","No exsiste divisi�n"),TITULO("Divisi�n"),WLONX=20
CAMPO=DESDIV,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la divisi�n"),TITULO("Des. Divisi�n")
CAMPO=CODARTDIV,TOOLTIP("C�digo del art�culo para la divisi�n"), TITULO("Art�culo-Divisi�n")

CURSOR=CSELDIVIS SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;



