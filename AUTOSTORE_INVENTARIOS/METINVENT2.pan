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
Linea Ubicacion   Art�culo                       Estado              Rec.   
@L@@  _20_______  _20_______ _40________________ ###### _40_________ @L@
|

TABLA=VDINVENCONTEO
WHERE=STATUS NOT IN (500,400);
ORDERBY=SEQINVEN,CODUBI;
WLONX=1000

NOINSERT

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL,OCULTO
CAMPO=SEQINVEN,NOUPDATE,TITULO("Linea")
CAMPO=CODUBI,NOUPDATE("SUPERVISOR"),TOOLTIP("C�digo de ubicaci�n a inventariar"),TITULO("Ubicacion"),WLONX=20
CAMPO=CODARTREAL,NOUPDATE,TOOLTIP("C�digo de art�culo despu�s de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR",""),TITULO("Art�culo")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER,TITULO("Descripci�n")
#CAMPO=CANTTEORICO,NOENTER,TITULO("Te�rico"),WLONX=15
#CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total despu�s de inventariar, incluidas las rotas"),TITULO("Real"),WLONX=15
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
