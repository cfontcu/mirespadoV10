#CERRAR PRECINTOS
LISTA DE UBICACIONES SIN PRECINTO
  Ubicaci�n    Pas Col Alt
  _20_________ @L  @L  @L	  
 
                      
|
SOLOQUERY
NOUPDATE
SELECT = SELECT CODUBI CODUBIAUX,PASILLO,COLUMNA,ALTURA  FROM VDDEVOLUBICA UBI WHERE NOT EXISTS (SELECT 1 FROM VDPRECINTO PR WHERE PR.CODUBI = UBI.CODUBI);
INCLUDEFICHEROCSS="vertis.css"
INCLUDEFICHEROHTML="botoneratactil.html"

INCLUDEHTML="<SCRIPT> var eventoforzado=1; window.document.getElementById('tactil').style.top=550+'px'; window.document.getElementById('tactil').style.left=970+'px'; </SCRIPT>"

CAMPO=CODUBI,NOENTER,VIRTUAL,OCULTO,AUXILIAR,TITULO("Ubicaci�n")
CAMPO=CODUBIAUX,TITULO("Ubicaci�n")
CAMPO=PASILLO,TITULO("Pas"),WLONX=16
CAMPO=COLUMNA,TITULO("Col"),WLONX=16
CAMPO=ALTURA,TITULO("Alt"),WLONX=16

TECLA=10001,FEJECUTA("CPONCODUBI","")

TECLA=F4,FPULSATECLAS("CF6","F4")


CURSOR=CPONCODUBI SELECT :CODUBIAUX CODUBI FROM DUAL;

BOTON=PONPRECINTO,1050,400,120,120,"Pon Ubicaci�n",vertis\vertisponubi.png,10001,"Establece esa ubicaci�n" ,INCLUDECSS="border-style:outset;background-color:transparent"
BOTON=VALIDAR,1050,260,120,120,"Confirmar",vertis\vertisok.png,F4,"Confirmar cambios" ,INCLUDECSS="border-style:outset;background-color:transparent"
