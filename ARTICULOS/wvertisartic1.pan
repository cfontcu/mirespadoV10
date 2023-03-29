# M�dulo   : VDARTIC.PAN
# Funci�n  : Mantenimiento de art�culos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
CONSULTA DE ARTICULOS
 C�digo                                             Div   C�digo Nacional Ean     
 _40___________ _100_______________________________ _20__ _13____________  ______________
|


TABLA=VDARTIC
NOINSERT
NODELETE
NOUPDATE
WLONX=700


CURSOR=CIMAGEN SELECT DECODE(:CODEAN,NULL,NULL,'ART/'||:CODEAN||'.jpg') IMAGEN FROM DUAL;
 
CAMPO=IMAGEN,OCULTO,AUXILIAR,"_255_____",NOUPDATE
CAMPO=CODART,NOUPDATE,TOOLTIP("C�digo del art�culo"),INCLUDECSS="border-style:ridge;background-color:#F7BE81;",TITULO("Art�culo")
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo")
CAMPO=CODDIV,TOOLTIP("Divisi�n a la que pertenece el art�culo"),TITULO("Div"),WLONX=16
CAMPO=CODNAC,TOOLTIP("C�digo nacional"),TITULO("C�digo Nacional"),WLONX=26
CAMPO=CODEAN,TOOLTIP("C�digo EAN DUN14"),TITULO("Ean")

BOTON=PRUEBA,800,50,300,300,"Limpiar",NO,SF1,"Limpia la pantalla",INCLUDECSS="visibility:hidden;",BOTONDISABLED=1
#BOTON=KK,800,250,70,30,"DEMO",NO,SF1,"Limpia la pantalla"

