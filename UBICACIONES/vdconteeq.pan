#*****************************************************************
#M�dulo: VDCONTEEQ.PAN
#Funci�n  : Mantenimiento de equivalencia de capacidad entre palet.
#           Utilizado para calclar la altura del palet.
#Autor: ICC      
#Fecha: 27-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
MANTENIMIENTO DE LA EQUIVALENCIA ENTRE CONTENEDORES

Contenedor                               Contenedor a comparar                     Eq.  Ultima modificaci�n              
_10_______ _40__________________________ _10_______ _40__________________________  ###  _32_________ �D-MM-Y.YY ________
|
TABLA=VDCONTEEQ



PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=TIPOCONTE,POSTCHANGE=FDESIGNACION("CSELVDTIPOCONTEDESTIPOCONTE","ERROR AL EJECUTAR CURSOR CSELVDTIPOCONTEDESTIPOCONTE"),TOOLTIP("Tipo de contenedor a comparar"),TITULO("Contenedor")
CAMPO=DESTIPOCONTE,AUXILIAR,TOOLTIP("Descripci�n del tipo de contenedor")
CAMPO=TIPOCONTECOMP,POSTCHANGE=FDESIGNACION("CSELVDTIPOCONTEDESTIPOCONTECOMP","ERROR AL EJECUTAR CURSOR CSELVDTIPOCONTEDESTIPOCONTE"),TOOLTIP("Tipo de contenedor con el que se compara"),TITULO("Contenedor a comparar")
CAMPO=DESTIPOCONTECOMP,AUXILIAR,TOOLTIP("Descripci�n del tipo de contenedor")
CAMPO=PROPORCION,TOOLTIP("Porcentaje del tama�o que es mayor(+), o que es menor(-)"),TITULO("Eq.")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("usuario que realiz� la Ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELVDTIPOCONTEDESTIPOCONTE SELECT DESTIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE;
CURSOR=CSELVDTIPOCONTEDESTIPOCONTECOMP SELECT DESTIPOCONTE DESTIPOCONTECOMP FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTECOMP;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

