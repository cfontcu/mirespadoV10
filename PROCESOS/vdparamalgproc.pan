######
# VDPARAMALGPROC.PAN - Sistema de ventanas para configurar los par�metros que se le pasan a los diferentes procedimientos y algoritmos
#
# Prop�sito: Ventana para configurar los par�metros que se le pasan a los diferentes procedimientos y algoritmos
#
#
# Autor	   : Jos� Carlos Santos
# Fecha    : 26-12-2007
####
# Modificaciones:
####

Pos. Tipo Inf.  Nombre           Descripci�n
@L@  _     _    _32____________  _255__________________________________________________________
|

TABLA=VDPARAMALGPROC

ORDERBY=POSICION;


CAMPO=FUNCION, VIRTUAL,OCULTO
CAMPO=TIPOPROC,VIRTUAL,OCULTO
CAMPO=POSICION,UPPER,TOOLTIP("Posici�n del parametro"),TITULO("Pos")
CAMPO=TIPO,UPPER,TOOLTIP("Tipo del parametro puede ser C(adena) o N(umerico)"),POSTCHANGE=FVERIFICA("CN","Debe introducir C(adena) o N(umerico)"),TITULO("Tipo"),WLONX=15
CAMPO=INFORMAR,UPPER,TOOLTIP("Indica si es obligatorio o no informar este campo"),TITULO("Inf."),WLONX=15
CAMPO=NOMBREPARAM,UPPER,TITULO("Nombre")
CAMPO=DESCRIPCION,UPPER,TITULO("Descripci�n")
