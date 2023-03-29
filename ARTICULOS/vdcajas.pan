# M�dulo   : VDCAJAS.PAN
# Funci�n  : Mantenimiento de cajas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CAJAS
Tipo                             T.Embalaje  Lar.  Anch  Alto  Peso    Rell  Marg Max Min Pic Max. peso D A Coment.   Ultima modificaci�n     
__________ _40__________________ _10_______  @L,@@ @L,@@ @L,@@ @L,@@@@ @L,@@ #L.# @L@ @L@ @L@ @L,@@@@@@ _ _ @L@@@@@@@ _32________ �D-MM-Y.YY  ________
|

TABLA=VDCAJAS
ORDERBY=LARGOCAJA*ANCHOCAJA*ALTOCAJA;

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=TIPOVOL,VIRTUAL,OCULTO
CAMPO=TIPOCAJA,NOUPDATE,TOOLTIP("Tipo de caja"),TITULO("Tipo")
CAMPO=DESCAJA,TOOLTIP("Designaci�n de la caja"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n de la caja"),TITULO("Nombre")
CAMPO=TIPOEMBA,TOOLTIP("Tipo de Embalaje"),CONTEXTUAL=FEJECUTAFORM("VDTIPOEMBA","N","","","TIPOEMBA=:TIPOEMBA","","S"),TITULO("T. Embalaje"),WLONX=40,
               COMBOX("CLISTAEMBA")
CAMPO=LARGOCAJA,TOOLTIP("Largo de la caja en mm."),TITULO("Largo")
CAMPO=ANCHOCAJA,TOOLTIP("Ancho de la caja en mm."),TITULO("Ancho")
CAMPO=ALTOCAJA,TOOLTIP("Alto de la caja en mm."),TITULO("Alto")
CAMPO=PESOCAJA,TOOLTIP("Peso de la caja vacia en gramos"),TITULO("Peso")


CAMPO=PESORELLENO,TOOLTIP("Peso del relleno en gramos por litro"),TITULO("Rell.")
CAMPO=MARGENPESO,TOOLTIP("Margen de error admisible en b�scula"),POSTCHANGE=FENRANGO("0-99.9","Debe introducir un numero entre 0 y 100"),TITULO("Marg."),WLONX=25
CAMPO=MAXLLENADO,TOOLTIP("Porcentaje de llenado de una caja a partir\ndel cual se considera que la caja est� llena"),POSTCHANGE=FENRANGO("1-100","Debe introducir un numero entre 1 y 100"),TITULO("Max%"),WLONX=15
CAMPO=MINLLENADO,TOOLTIP("Porcentaje a partir del cual se considera una\ncaja suficientemente llena conteniendo un �nico art�culo.\nNo se intenta introducir otros art�culos"),POSTCHANGE=FENRANGO("1-100","Debe introducir un numero entre 1 y 100"),TITULO("Min%"),WLONX=15
CAMPO=MAXPICOS,TOOLTIP("M�ximo numero de articulos diferentes a poner en la caja"),TITULO("Picos"),WLONX=15
CAMPO=MAXPESO,TOOLTIP("M�ximo peso de la caja rellena en gramos"),TITULO("Max. Peso"),WLONX=55
CAMPO=VOLDINAMICA,TOOLTIP("Indica si tiene volumetria din�mica para picking inverso"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)"),TITULO("D")
CAMPO=SWTACTIVO,TOOLTIP("Indica si la caja esta activa o no, para la volumetr�a"),TITULO("A")
CAMPO=CODCOMEN,NOUPDATE,TOOLTIP("Comentario"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")




CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


CURSOR=CLISTAEMBA SELECT TIPOEMBA, DESTIPOEMBA FROM VDTIPOEMBA ORDER BY TIPOEMBA;
