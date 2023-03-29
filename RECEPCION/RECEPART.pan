#*****************************************************************************************
#Modulo: RECEPART.PAN
#Funcionalidad : LISTA DE ARTICULOS RECEPCIONADOS CON ESTADO 50  SIN SEPARACIONES
#Autor: Carmen Fontcuberta     
#Fecha: 18-01-2023
#*******************************************************************************************
#* Historico de cambios
# ==================== 
#*******************************************************************************************

LISTA ARTICULOS SIN SEPARACIONES 
 Articulo        Descripcion           Largo Ancho Alto 
 _40____________ _100_________________ @@@@@ @@@@@ @@@@@ 
|

SOLOQUERY


SELECT=SELECT ART.CODART, ART.DESART, ART.LARGOUNI, ART.ANCHOUNI, ART.ALTOUNI
         FROM VDARTIC ART, VDORDRECLIN REC
        WHERE ART.CODART=REC.CODART AND REC.STATUS=25;
		
#GROUPBY=ART.CODART
		
	

CAMPO=CODART,NOUPDATE,TOOLTIP("Codigo Articulo"),TITULO("Articulo"),PREFIJO=ART
CAMPO=DESART,NOUPDATE,TOOLTIP("Descripcion Articulo"),TITULO("Descripcion"),PREFIJO=ART
CAMPO=LARGOUNI,TOOLTIP("Largo Articulo"),NOENTER,TITULO("Largo") 
CAMPO=ANCHOUNI,TOOLTIP("Ancho Articulo"),NOENTER,TITULO("Ancho")
CAMPO=ALTOUNI,TOOLTIP("Alto Articulo"),NOENTER,TITULO("Alto")

ONLINE=       {F5} Borra pantalla    {F11} Exportar a Excel      {Esc} Salir;





