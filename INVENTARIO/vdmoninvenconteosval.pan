#*****************************************************************
#M�dulo: VDMONINVENCONTEOSVAL.PAN
#Funcionalidad : Muestra todos los conteos de los inventarios.
#Autor: ICC      
#Fecha: 04-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
INVENTARIOS VALIDADOS
 Ubicacion Matricula          Art�culo                                        Lote            D Rotas Cant. ajustada Operario
 _20______ _18_______________ _40______________ _100_________________________ _40____________ _ ##### ######### _10_ _20______
                                                                                                                               |

TABLA=VDINVENCONTEO
WHERE=STATUS IN (VDST.FINOFINALIZADO, VDST.FINOVALIDADO);

ORDERBY=CODUBI,CODMAT;

NODELETE
NOINSERT

POSTQUERY=FEJECUTA(FIF("-CCALDATOS",FEJECUTA("CINICIALIZA","")),"")

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),NOUPDATE,TITULO("Ubicaci�n")
CAMPO=CODMAT,NOUPDATE,TITULO("Matr�cula")
CAMPO=CODARTREAL,NOENTER,TOOLTIP("C�digo de art�culo antes de inventariar"), POSTCHANGE=FDESIGNACION("+CSELDESART",""),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER
CAMPO=CODLOTREAL,NOENTER,TOOLTIP("C�digo de lote antes de inventaria"),TITULO("Lote")
CAMPO=DISTINTOARTLOT,AUXILIAR,NOENTER,TITULO("D")
CAMPO=CANTROTAS,NOENTER,TITULO("Rotas"),WLONX=20
CAMPO=AJUINV,AUXILIAR,NOENTER,TITULO("Cant. ajustada"),WLONX=30
CAMPO=UNIDADESHOST,AUXILIAR,NOENTER
CAMPO=CODOPE,NOENTER,TITULO("Operario")
CAMPO=CODARTTEORICO,OCULTO,"_40______________"
CAMPO=CODLOTTEORICO,OCULTO,"_40______________"


CURSOR=CSELDESART SELECT DESART, UNIDADESHOST
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;

CURSOR=CCALDATOS SELECT CASE WHEN :CODARTREAL != :CODARTTEORICO OR :CODLOTREAL != :CODLOTTEORICO THEN
                                  'S'
                             ELSE 'N' END DISTINTOARTLOT, SUM(DECODE(CODCONCE,'AJUINV-', (-1)*CANTIDAD, CANTIDAD)) AJUINV
                   FROM VDMOVIM
                  WHERE CODDOCUMENTO = :CODINVEN
                    AND CODCONCE    IN ('AJUINV-','AJUINV+')
                    AND (CODMATORI = :CODMAT OR CODMATDEST = :CODMAT)
                    AND STATUS       < VDST.FMOVANULADO;
                        
CURSOR=CINICIALIZA SELECT 0 AJUINV FROM DUAL;


ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;


