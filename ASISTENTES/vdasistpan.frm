###################################################################
#MOdulo: VDASISTPAN.FRM
#Funcionalidad : Asistente de generación de pantallas
#Autor: FGS
#Fecha: 31-08-2009
###################################################################
# HistOrico de cambios:
BEGINBLOQUE=VDASISTPAN1.PAN
 PREREGISTRO=PRESEHIJO
ENDBLOQUE
BEGINBLOQUE=VDASISTPAN3.PAN
 PADRE = VDASISTPAN1.PAN
 PREQUERY=QUERYHIJO
 PQUERY
 POSX=1
 POSY=33
 REGPAG=16
 TECLA=F10,FEJECUTAFORM("VDASISTPANGRANDE","S","","NBLOQUE=:NBLOQUE","","","S")
 TECLA=F7,FPULSATECLAS("CF6","F7")

 BOTON=P2,60,471,120,25,"Pantalla Completa",NO,F10,"Muestra la lista de campos en pantalla completa"
 BOTON=P1,190,471,100,25,"Limpiar Tabla",NO,F8,"Borra todos los campos actuales de la tabla"
 BOTON=P11,300,471,100,25,"Guardar Campos",NO,F4,"Guarda los cambios actuales"
 BOTON=P2,825,400,150,35,"Generar Fichero",NO,F7,"Genera el fichero e inserta en la tabla de propiedades de bloque por defecto"               
ENDBLOQUE
