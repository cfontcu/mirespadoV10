#*****************************************************************************************
#Modulo: ASTARTI.PAN
#Funcionalidad : Lista de articulos 
#Autor: JOTA      
#Fecha: 27-12-2022
#*******************************************************************************************
#* Historico de cambios
#* ====================
LISTA ARTICULOS
 Articulo        Descripcion           Largo Ancho Alto 
 _40____________ _100_________________ @@@@@ @@@@@ @@@@@ 
|

TABLA=VDARTIC

CAMPO=CODART,NOUPDATE,TOOLTIP("Codigo Articulo"),TITULO("Cod.Articulo")
CAMPO=DESART,NOUPDATE,TOOLTIP("Descripcion Articulo"),TITULO("Descripcion")
CAMPO=LARGOUNI,TOOLTIP("Largo Articulo"),NOENTER,TITULO("Largo") 
CAMPO=ANCHOUNI,TOOLTIP("Ancho Articulo"),NOENTER,TITULO("Ancho")
CAMPO=ALTOUNI,TOOLTIP("Alto Articulo"),NOENTER,TITULO("Alto")

