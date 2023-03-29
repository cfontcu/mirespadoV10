# M�dulo   : VDVOLUMETRIA.PAN
# Funci�n  : Mantenimiento de volumetrias
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE VOLUMETRIAS
Tipo                                          M�x Peso   Pi. LLe Ultima modificaci�n              
__________ _40_______________________________ #L,####### @L@ @L@ _32________ �D-MM-Y.YY  ________
|

TABLA=VDVOLUMETRIA

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")




CAMPO=TIPOVOL,NOUPDATE,TOOLTIP("Tipo del contenedor"),TITULO("Tipo")
CAMPO=DESVOL,TOOLTIP("Designaci�n del tipo de contenedor"),POSTCHANGE=FVALNOCERO("No puede dejar designaci�n en blanco")
CAMPO=MAXPESO,TOOLTIP("M�ximo peso de una caja de la volumetria"),TITULO("M�x Peso")
CAMPO=MAXPICOS,TOOLTIP("M�ximo n�mero de art�culos diferentes en una caja"),TITULO("Picos"),WLONX=15
CAMPO=MAXLLENADO,TOOLTIP("M�ximo coeficiente de llenado"),POSTCHANGE=FENRANGO("0-100","Debe estar en rango 0-100"),TITULO("Max%"),WLONX=15
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


