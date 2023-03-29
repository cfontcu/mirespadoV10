#*****************************************************************************************
#Modulo: VDINVENTART.PAN
#Funcionalidad : Inventario global por articulos
#Autor: JOTA      
#Fecha: 23-02-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INVENTARIO GLOBAL POR ARTICULOS
 Cod.Articulo  Descripcion                 Cantidad Global  Total cubetas
 ____________  __250_____________________  @@@@@@@@@@@@@@@   @@@@@@@@@@
                                                                          |

SOLOQUERY

SELECT=SELECT ART.CODART,ART.DESART,SUM(STK.CANTIDAD)CANTIDAD, (SELECT COUNT(CODMAT) FROM VDSTOCK WHERE CODART=ART.CODART)TOTCUBET
         FROM VDARTIC ART, VDSTOCK STK
        WHERE ART.CODART=STK.CODART;

GROUPBY=ART.CODART,ART.DESART;
		
CAMPO=CODART,TITULO("Codigo Articulo"),TOOLTIP("Código del articulo inventariado"),PREFIJO=ART 
CAMPO=DESART,TITULO("Descripcion"),TOOLTIP("Descripción del articulo inventariado"),MIXED,PREFIJO=ART  
CAMPO=CANTIDAD,TITULO("Cantidad Global"),NOENTER,TOOLTIP("Cantidad global el Autostore") 
CAMPO=TOTCUBET,TITULO("Total Cubetas"),NOENTER,TOOLTIP("Cantidad total de cubetas donde se encuentra el árticulo")


ONLINE=       {F5} Borra pantalla    {F11} Exportar a Excel      {Esc} Salir;
BOTON=B1,560,5,50,50,"P",search1.png,F2,"Buscar",INCLUDECSS="background-color:transparent;border-width:0px"
BOTON=B2,560,65,50,50,"P",excel02.png,F11,"Exportar a Excel",INCLUDECSS="background-color:transparent;border-width:0px"
BOTON=B3,560,125,50,50,"P",refresh.png,F5,"Limpiar resultados",INCLUDECSS="background-color:transparent;border-width:0px"