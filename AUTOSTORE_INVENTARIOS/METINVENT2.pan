#*****************************************************************
#MOdulo: METINVENT2.PAN
#Funcionalidad : Pantalla de operario para inventarios.
#Autor: ICC      
#Fecha: 06-03-2023
#*****************************************************************
#* HistOrico de cambios
#* ====================
#
INVENTARIOS PENDIENTES
Linea Ubicacion   Artículo                       Estado              Rec.   
@L@@  _20_______  _20_______ _40________________ ###### _40_________ @L@
|

TABLA=VDINVENCONTEO
WHERE=STATUS NOT IN (500,400);
ORDERBY=SEQINVEN,CODUBI;
WLONX=1000

NOINSERT

CAMPO=CODINVEN,TOOLTIP("Código de inventario"),VIRTUAL,OCULTO
CAMPO=SEQINVEN,NOUPDATE,TITULO("Linea")
CAMPO=CODUBI,NOUPDATE("SUPERVISOR"),TOOLTIP("Código de ubicación a inventariar"),TITULO("Ubicacion"),WLONX=20
CAMPO=CODARTREAL,NOUPDATE,TOOLTIP("Código de artículo después de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR",""),TITULO("Artículo")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER,TITULO("Descripción")
#CAMPO=CANTTEORICO,NOENTER,TITULO("Teórico"),WLONX=15
#CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total después de inventariar, incluidas las rotas"),TITULO("Real"),WLONX=15
CAMPO=STATUS,NOUPDATE("SUPERVISOR"),POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TITULO("Desc.")
CAMPO=RECONTEO,NOUPDATE,TITULO("Conteos"),WLONX=18


CURSOR=CSELDESARTR SELECT DESART DESARTR
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;
					
CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INO'
                        AND STATUS = :STATUS;
