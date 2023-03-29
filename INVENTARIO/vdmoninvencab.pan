###########################################
# M�dulo   : VDMONINVENCAB.PAN
# Funci�n  : Monitor de inventarios
#
# Creaci�n : 04-02-2010
# Autor    : ICC
###########################################
# Hist�rico de cambios:
CABECERA DE INVENTARIOS
Inventario                                    Clave HOST                  Estado                 Creaci�n
########  _100_______________________________ _40________________________ ##### ________________ _32_______ �D-MM-Y.YYY  _8______
                                                                                                                                 |
TABLA=VDINVENCAB
ORDERBY=STATUS,CODINVEN DESC;

PQUERY
POSX=1
POSY=1

NODELETE
NOINSERT
NOUPDATE

CAMPO=CODINVEN,NOUPDATE,TOOLTIP("C�digo de inventario obtenido del secuencia VDSECINVEN"),TITULO("Inventario")
CAMPO=DESINVEN,TOOLTIP("Descripci�n de inventario")
CAMPO=DATOSHOST,NOENTER,TOOLTIP("C�digo enviado por el host al que este hace referencia"),TITULO("Clave Host")
CAMPO=STATUS,NOENTER,TOOLTIP("Estado de las l�neas del inventario. Posibles valores: 100 creado\n 200 en curso\n 300 Fin\n 400 Inventario sin l�neas"),
             POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"), TITULO("Estado")
CAMPO=DESSTATUS, NOENTER,AUXILIAR
CAMPO=CODOPEINS,NOUPDATE,TOOLTIP("C�digo de operario se solicita el inventario"),TITULO("Creaci�n")
CAMPO=FECINS,NOUPDATE,TOOLTIP("Fecha en juliano de cuando se solicit� el inventario")
CAMPO=HORAINS,NOUPDATE,TOOLTIP("Hora en que se solicit� el inventario")


CURSOR=CSELDESSTATUS SELECT DESSTATUS 
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INC'
                        AND STATUS = :STATUS;


TECLA=SF8,FEJECUTA(FIMPRIME("INFORME","VDINVENTARIO.RPT","CODINVEN=:CODINVEN",""),":V10ERROR")

ONLINE= {F1} Ayuda    {F2} Consulta    {May-F8} Imprimir    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;
