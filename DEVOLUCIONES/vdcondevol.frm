#INCLUDEFICHEROCSS="vertissimple.css"
BEGINBLOQUE=VDCONCDEVOL.PAN
  PREREGISTRO=PRESEHIJO
  POSY=2
  WLONY=760
  WLONX=1020
  BOTON=SALIR,880,30,100,100,"Salir",vertis\vertissalir.png,27,"Salir de la pantalla",INCLUDECSS="border-style:outset;background-color:transparent" 
  BOTON=PROTO,760,30,100,100,"Confirmar Protocolo",vertis\vertislistado.png,SF5,"Valida devolución e imprime informe",INCLUDECSS="border-style:outset;background-color:transparent"
ENDBLOQUE
BEGINBLOQUE=VDCONLDEVOL.PAN
  PADRE=VDCONCDEVOL.PAN
  PREQUERY=QUERYHIJO
  PREREGISTRO=PRESEHIJO
  POSY=14
  POSX=3
  WLONX=970
  REGPAG=14  
  WMARCOFRAME  
  BOTON=SALIR,880,30,100,100,"Salir",vertis\vertissalir.png,27,"Salir de la pantalla",INCLUDECSS="border-style:outset;background-color:transparent" 
  BOTON=VALIDAR,760,30,100,100,"Confirmar",vertis\confprotolin.png,F4,"Confirmar Cambios",INCLUDECSS="border-style:outset;background-color:transparent"  
ENDBLOQUE  
BEGINBLOQUE=VDCONLDEVOLEXT.PAN
  PADRE=VDCONLDEVOL.PAN
  PREQUERY=QUERYHIJO
  POSX=3
  POSY=32
  WSINMARCO
  REGPAG=1  
  BOTON=SALIR,940,30,50,50,"Salir",vertis\vertissalir.png,27,"Salir de la pantalla",INCLUDECSS="border-style:outset;background-color:transparent" 
  BOTON=VALIDAR,880,30,50,50,"Confirmar",vertis\confprotolin.png,F4,"Confirmar Cambios",INCLUDECSS="border-style:outset;background-color:transparent"  
ENDBLOQUE  