CAMPO=CODART,AUXILIAR,OCULTO,"_20_________"
CAMPO=CODLOT,AUXILIAR,OCULTO,"_20_________"
CAMPO=MENSAJE,AUXILIAR,OCULTO,"_1024__________________________"
CAMPO=VALIDA,AUXILIAR,OCULTO,"_"
BEGINBLOQUE=VDESTADOUNLOTE.PAN
    POSX=30
    PREREGISTRO=PRESEHIJO
   CAMPO=MENSAJE,AUXILIAR,VIRTUAL,OCULTO
   TITULO=LIBERACION DE UN LOTE
   BOTON=INFORME,950,60,100,100,"Tratar Lote",vertis\cajaaprecinto.png,F4,"Tratar Lote",INCLUDECSS="border-style:outset;background-color:transparent" 
ENDBLOQUE

BEGINBLOQUE=VDESTADOCONTES.PAN 
  PADRE=VDESTADOUNLOTE.PAN
  PREQUERY=QUERYHIJO
  POSY=22
  POSX=40
  REGPAG=30
  TITULO=LISTA DE CONTENEDORES PENDIENTES DE CALIDAD A LIBERAR
  BOTON=INFORME,850,380,100,100,"Tratar Matricula",vertis\cajaaprecinto.png,F4,"Tratar Lote",INCLUDECSS="border-style:outset;background-color:transparent" 
ENDBLOQUE       