# MOdulo   : VDTRADC�digo.PAN
# Funci�n  : Mantenimiento de traducciones de C�digos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# HistOrico de cambios:
CODIGOS DE ARTICULO ALTERNATIVOS
 Art�culo             Designaci�n               Alternativo              Formato  A Coment    Ultima modificaci�n
 _40_________________ _100_____________________ _40_____________________ _4_____  _ @L@@@@@@@ _32________ �D-MM-Y.YY  ________
|

POSX=6
POSY=5
REGPAG=30

TABLA=VDTRADCODIGO



PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")




CAMPO=CODART,NOUPDATE,TOOLTIP("C�digo del art�culo"),POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),
                CONTEXTUAL=FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","Selecci�n de art�culos","N"),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo"),TITULO("Designaci�n")
CAMPO=CODARTALT,TOOLTIP("C�digo alternativo para el producto"),TITULO("Alternativo")
CAMPO=FORMATO,TOOLTIP("Formato al que corresponde el c�digo de barras alternativo:\nDE1: Unidad\nDE2: Blister\nIB: Inner Box (caja completa)\nCO: Outer Box\nPA: Pallet"),
              POSTCHANGE=FDESIGNACION("+CSELFORMATO","ERROR: Campo formato s�lo puede ser 'DE1', 'DE2', 'IB', 'CO' o 'PA'"),TITULO("Formato")
CAMPO=SWTACTIVO,TOOLTIP("Indica si el C�digo alternativo esta activo"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)"),TITULO("A"),CHECKBOX("N","S")
CAMPO=CODCOMEN,NOUPDATE,TOOLTIP("C�digo de comentario asociado al producto"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizO la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELFORMATO SELECT :FORMATO FORMATO 
                     FROM DUAL
					WHERE :FORMATO='DE1' 
                          OR :FORMATO='DE2'
						  OR :FORMATO='IB'
						  OR :FORMATO='CO'
						  OR :FORMATO='PA';

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;


ONLINE=     {F4} Enregistrer          {F9} Effacer {CF5} Menu;



