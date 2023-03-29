# M�dulo   : VDLOTES.PAN
# Funci�n  : Mantenimiento de lotes
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE LOTES
Art�culo            Designaci�n                               Lote               Caduci   
_40________________ _100_____________________________________ _40_______________ ________ 
|
TABLA=VDLOTES
NOUPDATE
NOINSERT
NODELETE
REGPAG=62
INCLUDEFICHEROCSS="vertissimple.css"
WLONX=700
WLONY=900

CAMPO=CODART,TOOLTIP("C�digo del art�culo"),INCLUDECSS="border-style:ridge;background-color:#F7BE81;",NOUPDATE,POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo")
CAMPO=CODLOT,POSTCHANGE=FVALNOCERO("Debe informar un lote"),NOUPDATE,TOOLTIP("Lote"),TITULO("Lote")
CAMPO=CADUCI,TOOLTIP("Caducidad en formato DDMMAAAA"),TITULO("Caducidad"),WLONX=50

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;
