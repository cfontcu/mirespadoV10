#*****************************************************************
#M�dulo: VDMONINVENCONTEOSANUL.PAN
#Funcionalidad : Muestra los conteos de los inventarios anulados
#Autor: ICC      
#Fecha: 04-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
INVENTARIOS ANULADOS
Ubicacion Matricula          Art�culo                                        Lote             D Rotas Cant. a ajustar Operario    
_20______ _18_______________ _40______________ _100_________________________ _40____________  _ ##### ######### _10_  _20_______    
                                                                                                                                |

TABLA=VDINVENCONTEO
WHERE=STATUS = VDST.FINOANULADO;

ORDERBY=CODUBI,CODMAT;

NODELETE
NOINSERT

POSTQUERY=FEJECUTA("+CCALDATOS","")

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),NOUPDATE,TITULO("Ubicaci�n"),WLONX=22
CAMPO=CODMAT,NOUPDATE,TITULO("Matr�cula")
CAMPO=CODARTREAL,NOENTER,TOOLTIP("C�digo de art�culo antes de inventariar"), POSTCHANGE=FDESIGNACION("+CSELDESART",""),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER
CAMPO=CODLOTREAL,NOENTER,TOOLTIP("C�digo de lote antes de inventaria"),TITULO("Lote")
CAMPO=DISTINTOARTLOT,AUXILIAR,NOENTER,TITULO("D"),WLONX=8
CAMPO=CANTROTAS,NOENTER,TITULO("Rotas"),WLONX=20
CAMPO=AJUINV,AUXILIAR,NOENTER,TITULO("Cant. a ajustar"),WLONX=40
CAMPO=UNIDADESHOST,AUXILIAR,NOENTER
CAMPO=CODOPE,NOENTER,TITULO("Operario")
CAMPO=CODARTTEORICO,OCULTO,"_40______________"
CAMPO=CODLOTTEORICO,OCULTO,"_40______________"
CAMPO=CANTREAL,OCULTO,"#######"
CAMPO=CANTTEORICO,OCULTO,"#######"


CURSOR=CSELDESART SELECT DESART, UNIDADESHOST
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;

CURSOR=CCALDATOS SELECT CASE WHEN :CODARTREAL != :CODARTTEORICO OR :CODLOTREAL != :CODLOTTEORICO THEN
                                  'S'
                             ELSE 'N' END DISTINTOARTLOT, :CANTREAL - :CANTTEORICO AJUINV
                   FROM DUAL;
                        




ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;


