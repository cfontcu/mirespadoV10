#*****************************************************************
#M�dulo: VDINVENCONTEOS.PAN
#Funcionalidad : Muestra todos los conteos de los inventarios.
#Autor: ICC      
#Fecha: 03-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
STOCK INVENTARIADO
Art�culo                       Lote      Cantidad Defectuosas Operario Fecha inicio         Fecha fin            Estado  
_40_________ _100_____________ _40______ ######## ###### _10_ _32_____ �D-MM-Y.YYY _8______ �D-MM-Y.YYY _8______ ###### _40____________________
|

TABLA=VDINVENCONTEO
ORDERBY=FECINI DESC, HORAINI DESC;
INCLUDECSS="inventario.css"

NODELETE
NOINSERT


CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),VIRTUAL, OCULTO
CAMPO=CODMAT,VIRTUAL,OCULTO
CAMPO=CODARTREAL,NOENTER,TOOLTIP("C�digo de art�culo despu�s de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR",""),TITULO("Art�culo")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER
CAMPO=CODLOTREAL,NOENTER,TOOLTIP("C�digo de lote despu�s de inventaria"),TITULO("Lote")
CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total despu�s de inventariar, incluidas las rotas"),TITULO("Cantidad"),WLONX=20
CAMPO=CANTROTAS,NOENTER,TOOLTIP("Cantidad de unidades rotas"),TITULO("Defectuosas"),WLONX=25
CAMPO=UNIDADESHOST,NOENTER,AUXILIAR
CAMPO=CODOPE,NOENTER,TOOLTIP("C�digo de operario que realiza el inventario"),TITULO("Operario"),WLONX=20
CAMPO=FECINI,NOENTER,TOOLTIP("Fecha en juliano en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula"),TITULO("Fecha inicio")
CAMPO=HORAINI,NOENTER,TOOLTIP("Hora en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula")
CAMPO=FECFIN,NOENTER,TOOLTIP("Fecha en juliano en que se se finaliza el recuento de la matr�cula"),TITULO("Fecha fin")
CAMPO=HORAFIN,NOENTER,TOOLTIP("Hora en que se se finaliza el recuento de la matr�cula")
CAMPO=STATUS,NOENTER,POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER


CURSOR=CSELDESARTR SELECT DESART DESARTR, UNIDADESHOST
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;

CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INO'
                        AND STATUS = :STATUS;


ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;


