# M�dulo   : VDARTIC.PAN
# Funci�n  : Mantenimiento de art�culos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
DETALLE DEL ARTICULO
 C�digo                 _40____________________ 
       _100____________________________________
 
 Divisi�n               _20___ 
                        _40______________________________   
 
 Art�culo para Divisi�n ____________________
 
 C�digo Nacional        _____________ 
 
 Ean                    ______________         
 
 Descripci�n alt.       _40____________________________  
 
 Unidades               __________     
 
 Unidades Host          __________     
 
 UniCaj:                @L@@
 
 PVD Vigente            #L,########.### 
 
 Activo _     
 
 Ult. modificaci�n �D-MM-Y.YY  ________
|


TABLA=VDARTIC
NOINSERT
NODELETE
NOUPDATE


CAMPO=IMAGEN,OCULTO,AUXILIAR,"_255_____",NOUPDATE
CAMPO=CODART,VIRTUAL,NOUPDATE,TOOLTIP("C�digo del art�culo"),INCLUDECSS="border-style:ridge;background-color:#F7BE81;"
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo")
CAMPO=CODDIV,TOOLTIP("Divisi�n a la que pertenece el art�culo"),POSTCHANGE=FDESIGNACION("CSELDIVIS","No existe divisi�n")
CAMPO=DESDIV,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la divisi�n")
CAMPO=CODARTDIV,TOOLTIP("C�digo del art�culo para la divisi�n")
CAMPO=CODNAC,TOOLTIP("C�digo nacional")
CAMPO=CODEAN,TOOLTIP("C�digo EAN DUN14")
#,INCLUDECSS="background-color:darkgreen;color:yellow;height:20px"
CAMPO=DESARTALT,TOOLTIP("Designaci�n alternativa del art�culo")
CAMPO=UNIDADES,TOOLTIP("Unidades en las que se mide el art�culo en V10"),
               CONTEXTUAL=FEJECUTAFORM("VDUNIDADES","N","","","UNIDADES=:UNIDAD","Selecci�n de unidades","S")
CAMPO=UNIDADESHOST,TOOLTIP("Unidades en las que mide el art�culo el Host"),
               CONTEXTUAL=FEJECUTAFORM("VDUNIDADES","N","","","UNIDADESHOST=:UNIDAD","Selecci�n de unidades","S")
CAMPO=UNIEMB,TOOLTIP("Unidades por embalaje"),CONVIERTE=FCONVIERTEFROMDB(":UNIDADES",":UNIDADESHOST");FCONVIERTE2DB(":UNIDADESHOST",":UNIDADES")
CAMPO=PVDVIGENTE,TOOLTIP("Precio de venta al distribuidor vigente")
CAMPO=SWTACTIVO,TOOLTIP("Indica si el producto esta activo"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CURSOR=CLISTATIPOVOL SELECT TIPOVOL,DESVOL FROM VDVOLUMETRIA ORDER BY TIPOVOL;


CURSOR=CSELDIVIS SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;

