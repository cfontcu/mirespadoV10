#*****************************************************************
#MOdulo: VDINVENCONTEOS.PAN
#Funcionalidad : Muestra todos los conteos de los inventarios.
#Autor: ICC      
#Fecha: 03-02-2010
#*****************************************************************
#* HistOrico de cambios
#* ====================
#
LINEAS DE INVENTARIO
Inven.   Lin  Ubic.       Matricula Art�culo                              Teorico  Real    Term.     Operario Fecha inicio         Fecha fin            Estado                         Anr.  Re Tipo        Mov.    
@L,@@@@@ @L@@ _20________ _20______ _20______ _40________________________ #L###### #L##### _20______ _32_____ �D-MM-Y.YYY _8______ �D-MM-Y.YYY _8______ ###### _40____________________ @L@@@ @L ___________ @L@@@@@@@
|

TABLA=VDINVENCONTEO
ORDERBY=STATUS DESC,CODUBI,FECINI DESC, HORAINI DESC;
INCLUDECSS="inventario.css"
WLONX=1200

#NODELETE
NOINSERT,PROTECT("V10")
REGPAG=40


CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),TITULO("Inven.")
CAMPO=SEQINVEN,NOUPDATE,TITULO("Lin.")
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),TITULO("Ubicacion"),WLONX=20
CAMPO=CODMAT,TITULO("Matricula")
CAMPO=CODARTREAL,NOUPDATE("V10"),TOOLTIP("C�digo de art�culo despu�s de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR",""),TITULO("Art�culo")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER,TITULO("Descripci�n")
CAMPO=CANTTEORICO,NOENTER,TITULO("Te�rico"),WLONX=15
CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total despu�s de inventariar, incluidas las rotas"),TITULO("Real"),WLONX=15
CAMPO=CODRECURSO,NOUPDATE("V10"),TITULO("Term.")
CAMPO=CODOPE,NOENTER,TOOLTIP("C�digo de operario que realiza el inventario"),TITULO("Operario"),WLONX=20
CAMPO=FECINI,NOENTER,TOOLTIP("Fecha en juliano en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula"),TITULO("Fecha inicio")
CAMPO=HORAINI,NOENTER,TOOLTIP("Hora en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula")
CAMPO=FECFIN,NOENTER,TOOLTIP("Fecha en juliano en que se se finaliza el recuento de la matr�cula"),TITULO("Fecha fin")
CAMPO=HORAFIN,NOENTER,TOOLTIP("Hora en que se se finaliza el recuento de la matr�cula")
CAMPO=STATUS,NOUPDATE("SUPERVISOR"),POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"),TITULO(""),WLONX=5
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TITULO("Estado"),WLONX=60
CAMPO=ANTSEQINVEN
CAMPO=RECONTEO
CAMPO=TIPOINVEN
CAMPO=CODMOV,NOUPDATE("V10")


CURSOR=CSELDESARTR SELECT DESART DESARTR
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;

CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INO'
                        AND STATUS = :STATUS;
                        
CONTEXTUAL=FEJECUTAFORM("VDUBICA","S","CODUBI=:CODUBI")


ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;


CONTEXTUAL=FLEEMENU("VDINVENCONTEO.ZOO")