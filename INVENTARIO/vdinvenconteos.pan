#*****************************************************************
#M�dulo: VDINVENCONTEOS.PAN
#Funcionalidad : Muestra todos los conteos de los inventarios.
#Autor: ICC      
#Fecha: 03-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
INVENTARIOS REALIZADOS
       Matricula: _18_______________ Estado ###### _40_____________________   Ultima modif.: _32_____ �D-MM-Y.YYY _8______ 
          Art�culo                             Lote      Cantidad Rotas Operario Fecha inicio         Fecha fin           
 Te�rico: _40_________ _100___________________ _40______ ######## 
 Real   : _40_________ _100___________________ _40______ ######## ##### _32_____ �D-MM-Y.YYY _8______ �D-MM-Y.YYY _8______

|

TABLA=VDINVENCONTEO
WHERE=NVL(:CODMATINVL, CODMAT)=CODMAT;
ORDERBY=CODMAT,FECINI DESC, HORAINI DESC;

NODELETE
NOINSERT

CAMPO=CODMAT,NOUPDATE
CAMPO=STATUS,NOENTER,POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,TOOLTIP("Hora  en que se efectu� alguna modificaci�n a los datos del registro")

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),VIRTUAL, OCULTO
CAMPO=CODMATINVL,TOOLTIP("C�digo de matr�cula a inventariar"),VIRTUAL,AUXILIAR, OCULTO
#CAMPO=SEQINVEN,OCULTO,"##"
CAMPO=CODARTTEORICO,NOENTER,TOOLTIP("C�digo de art�culo antes de inventariar"), POSTCHANGE=FDESIGNACION("+CSELDESARTT","")
CAMPO=DESARTT,AUXILIAR,NOENTER
CAMPO=CODLOTTEORICO,NOENTER,TOOLTIP("C�digo de lote antes de inventaria")
CAMPO=CANTTEORICO,NOENTER,TOOLTIP("Cantidad antes de inventaria")
CAMPO=CODARTREAL,NOENTER,TOOLTIP("C�digo de art�culo despu�s de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR","")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER
CAMPO=CODLOTREAL,NOENTER,TOOLTIP("C�digo de lote despu�s de inventaria")
CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total despu�s de inventariar, incluidas las rotas")
CAMPO=CANTROTAS,NOENTER,TOOLTIP("Cantidad de unidades rotas")
CAMPO=CODOPE,NOENTER,TOOLTIP("C�digo de operario que realiza el inventario")
CAMPO=FECINI,NOENTER,TOOLTIP("Fecha en juliano en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula")
CAMPO=HORAINI,NOENTER,TOOLTIP("Hora en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula")
CAMPO=FECFIN,NOENTER,TOOLTIP("Fecha en juliano en que se se finaliza el recuento de la matr�cula")
CAMPO=HORAFIN,NOENTER,TOOLTIP("Hora en que se se finaliza el recuento de la matr�cula")

CURSOR=CSELDESARTT SELECT DESART DESARTT
                     FROM VDARTIC
                    WHERE CODART = :CODARTTEORICO;

CURSOR=CSELDESARTR SELECT DESART DESARTR
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;

CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INO'
                        AND STATUS = :STATUS;


ONLINE= {F1} Ayuda    {F2} Consulta    {F4} Confirmar cambios    {Esc} Cerrar Pantalla    
        {May-F7} Documentaci�n {May+F8} Imprimir  {F9} Borrar un registro    {F5} Borrar Pantalla    ;


