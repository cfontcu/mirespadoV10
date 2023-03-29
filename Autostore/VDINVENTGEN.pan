#*****************************************************************************************
#Modulo: VDINVENTGEN.PAN
#Funcionalidad : Inventario general de articulos
#Autor: JOTA      
#Fecha: 22-02-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INVENTARIO GLOBAL DE ARTICULOS
 Cod.Articulo  Descripcion        Cod.Lote  Fabricante  Cubeta  Separación  Total cubetas  Cantidad
 ____________  __250_____________ ________  __________  ______  __________   @@@@@@@@@@    @@@@@@@@
                                                                                                    |

SOLOQUERY

SELECT=SELECT ART.CODART,ART.DESART,STK.CODLOT,STK.MARCASTK,STK.CODMAT,STK.CODAGRUP||'/'||CON.VDEXTRA SEPARACION,
              (SELECT COUNT(CODMAT) FROM VDSTOCK WHERE CODART=ART.CODART)TOTCUBET
              ,STK.CANTIDAD
		 FROM VDARTIC ART, VDSTOCK STK, VDCONTE CON
		WHERE ART.CODART=STK.CODART
		  AND STK.CODMAT=CON.CODMAT;
		  
ORDERBY=ART.CODART,STK.MARCASTK;
		
CAMPO=CODART,TITULO("Codigo Articulo"),TOOLTIP("Código del articulo inventariado"),PREFIJO=ART  
CAMPO=DESART,TITULO("Descripcion"),TOOLTIP("Descripción del articulo inventariado"),MIXED,PREFIJO=ART  
CAMPO=CODLOT,TITULO("Cod.Lote"),TOOLTIP("Código del Lote del articulo"),PREFIJO=STK  
CAMPO=MARCASTK,TITULO("Fabricante"),TOOLTIP("Fabricante"),PREFIJO=STK  
CAMPO=CODMAT,TITULO("Cubeta"),TOOLTIP("Número de Cubeta"),PREFIJO=STK 
CAMPO=SEPARACION,TITULO("Separación"),NOENTER,TOOLTIP("Separación del stock") 
CAMPO=TOTCUBET,TITULO("Total Cubetas"),NOENTER,TOOLTIP("Cantidad total de cubetas donde se encuentra el árticulo")
CAMPO=CANTIDAD,TITULO("Cantidad"),NOENTER,TOOLTIP("Cantidad por separacion") 


ONLINE=       {F5} Borra pantalla    {F11} Exportar a Excel      {Esc} Salir;
BOTON=B1,750,5,50,50,"P",search1.png,F2,"Buscar",INCLUDECSS="background-color:transparent;border-width:0px"
BOTON=B2,750,65,50,50,"P",excel02.png,F11,"Exportar a Excel",INCLUDECSS="background-color:transparent;border-width:0px"
BOTON=B3,750,125,50,50,"P",refresh.png,F5,"Limpiar resultados",INCLUDECSS="background-color:transparent;border-width:0px"