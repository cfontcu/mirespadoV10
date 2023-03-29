#*****************************************************************
#M�dulo: VDINVENLIN.PAN
#Funcionalidad : 
#Autor: ICC      
#Fecha: 03-02-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
LINEAS DEL INVENTARIO
Ubicaci�n    Matr�cula          Estado                    Ultima modificaci�n            
_20_________ _18_______________ ###### _40_______________ _32_______ �D-MM-Y.YYY _8______
                                                                                           |

TABLA=VDINVENLIN
ORDERBY=CODUBI,CODMAT;

AQUERY
NOINSERT
NODELETE
NOUPDATE

POSX=1
POSY=1
REGPAG=25

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),OCULTO,VIRTUAL
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),TITULO("Ubicaci�n")
CAMPO=CODMAT,TOOLTIP("C�digo de matr�cula a inventariar"),TITULO("Matr�cula")
CAMPO=STATUS,NOENTER,TOOLTIP("Estado de las l�neas del inventario. Posibles valores: 100 creado\n 200 en curso\n 300 Fin"),
             POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","No existe status"),TITULO("Estado")
CAMPO=DESSTATUS, NOENTER,AUXILIAR
CAMPO=CODOPEMODIF,NOUPDATE,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOUPDATE,TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOUPDATE,TOOLTIP("Hora  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=CODMATINVL,OCULTO,AUXILIAR,"_18____________"


CURSOR=CSELDESSTATUS SELECT DESSTATUS, :CODMAT CODMATINVL
                       FROM VDSTATUS
                      WHERE TIPOSTATUS = 'INL'
                        AND STATUS = :STATUS;



ONLINE= {F1} Ayuda    {F2} Consulta    {F4} Confirmar cambios    {Esc} Cerrar Pantalla    
        {May-F7} Documentaci�n {May+F8} Imprimir  {F9} Borrar un registro    {F5} Borrar Pantalla    ;
