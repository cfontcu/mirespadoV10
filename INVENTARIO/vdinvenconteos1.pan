#*****************************************************************
#M�dulo: VDINVENCONTEOS.PAN
#Funcionalidad : Muestra todos los conteos de los inventarios.
#Autor: ICC      
#Fecha: 03-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
INVENTARIOS REALIZADOS POR MATRICULA Y STOCK TEORICO
Matricula            Art�culo                                           Lote               Cantidad
_18_______________   _40______________ _100____________________________ _40_______________ ######## _10_
                                                                                                           |
SELECT=SELECT CODMAT,CODARTTEORICO,CODLOTTEORICO,CANTTEORICO
         FROM VDINVENCONTEO
        WHERE NVL(:CODMATINVL, CODMAT)=CODMAT;
ORDERBY=CODMAT;
GROUPBY=CODMAT,CODARTTEORICO,CODLOTTEORICO,CANTTEORICO;

SOLOQUERY
NODELETE
NOINSERT


CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),VIRTUAL, OCULTO
CAMPO=CODMATINVL,TOOLTIP("C�digo de matr�cula a inventariar"),VIRTUAL,AUXILIAR, OCULTO
CAMPO=CODMAT,NOUPDATE,TITULO("Matr�cula")
CAMPO=CODARTTEORICO,NOENTER,TOOLTIP("C�digo de art�culo antes de inventariar"), POSTCHANGE=FDESIGNACION("+CSELDESARTT",""),TITULO("Art�culo")
CAMPO=DESARTT,AUXILIAR,NOENTER
CAMPO=CODLOTTEORICO,NOENTER,TOOLTIP("C�digo de lote antes de inventaria"),TITULO("Lote")
CAMPO=CANTTEORICO,NOENTER,TOOLTIP("Cantidad antes de inventaria"),TITULO("Cantidad")
CAMPO=UNIDADESHOST,NOENTER,AUXILIAR

CURSOR=CSELDESARTT SELECT DESART DESARTT, UNIDADESHOST
                     FROM VDARTIC
                    WHERE CODART = :CODARTTEORICO;

ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;


