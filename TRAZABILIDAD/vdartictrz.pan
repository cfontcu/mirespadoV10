# M�dulo   : VDARTIC.PAN
# Funci�n  : Mantenimiento de art�culos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ARTICULOS
 C�digo   _40________________________________ ________________________________________
                Descripci�n alt.  ________________________________________ 

 Divisi�n ____ _40_____________________ Art.para Divisi�n _40_________________         
 C�digo Nacional    _____________  Ean ______________ 
 ������������������������������������ Propiedades ��������������������������������
 � Unidades       __________     Anulado  _           Stock _     Traza bulto _  �
 � Unidades Host  __________     Gen�rico _    Orden salida _        Etiqueta _  �
 � Decimales:     @                                              Agrupa stock _  �   
 ��������������������������������������������������������������������������������� 






 Activo _ Comentario @L,@@@@@@@  Ultima modificaci�n _32_____ �D-MM-Y.YY  ________       
|


TABLA=VDARTIC



CAMPO=CODART,NOUPDATE,TOOLTIP("C�digo interno del art�culo")
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo")
CAMPO=DESARTALT,TOOLTIP("Designaci�n alternativa del art�culo")
CAMPO=CODDIV,TOOLTIP("Divisi�n a la que pertenece el art�culo"),POSTCHANGE=FDESIGNACION("CSELDIVIS","No existe divisi�n"),
                CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S")
CAMPO=DESDIV,AUXILIAR,NOUPDATE,TITULO("Descripci�n") ,CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S"),WHERE=CODDIV IN (SELECT CODDIV FROM VDDIVIS WHERE DESDIV LIKE '%'||:DESDIV||'%');
CAMPO=CODARTDIV,TOOLTIP("C�digo del art�culo para la divisi�n")
CAMPO=CODNAC,TOOLTIP("C�digo nacional")
CAMPO=CODEAN,TOOLTIP("C�digo EAN DUN14")
CAMPO=UNIDADES,TOOLTIP("Unidades en las que se mide el art�culo en V10"),POSTCHANGE=FDESIGNACION("CSELUNIDADES","No existen las unidades V10"),
               CONTEXTUAL=FEJECUTAFORM("VDUNIDADES","N","","","UNIDADES=:UNIDAD","Selecci�n de unidades","S")
CAMPO=SWTANULADO,TOOLTIP("Indica si el producto tiene preanulado el precio"),POSTCHANGE=FENRANGO("S,N,I","Debe introducir S(i) o N(o)o I(ndiferente)")
CAMPO=SWTSTOCK,TOOLTIP("Indica si el producto controla stock"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)")
CAMPO=TRAZABULTO,TOOLTIP("Indica si el art�culo precisa trazabilidad de bulto"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=UNIDADESHOST,TOOLTIP("Unidades en las que mide el art�culo el Host"),POSTCHANGE=FDESIGNACION("CSELUNIDADESHOST","No existen las unidades Host"),
               CONTEXTUAL=FEJECUTAFORM("VDUNIDADES","N","","","UNIDADESHOST=:UNIDAD","Selecci�n de unidades","S")
CAMPO=SWTGENERICO,TOOLTIP("Indica si el producto debe tomar designacion de comentarios en albaranes"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)")
CAMPO=ORDENSAL,TOOLTIP("Orden de salida del articulo C(aducidad) F(ifo) R(etest) L(ote)"),POSTCHANGE=FVERIFICA("CFRL","Debe introducir C(aducidad) F(ifo) R(etest) L(ote)")
CAMPO=SWTETIQ,TOOLTIP("Indica si se puede leer la etiqueta del producto"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=DECIMALES,TOOLTIP("Numero de decimales en la representaci�n de cantidades")
CAMPO=AGRUPALIN,TOOLTIP("Indica si la ubicaci�n ha de agrupar las lineas con las mismas caracteristicas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=SWTACTIVO,TOOLTIP("Indica si el producto esta activo"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario asociado al producto")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELDIVIS SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;

CURSOR=CSELUNIDADES SELECT UNIDAD UNIDADES FROM VDUNIDADES WHERE UNIDAD=:UNIDADES;
CURSOR=CSELUNIDADESHOST SELECT UNIDAD UNIDADESHOST FROM VDUNIDADES WHERE UNIDAD=:UNIDADESHOST;



