# M�dulo   : VDTIPOEMBA.PAN
# Funci�n  : Mantenimiento de tipos de embalaje
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TIPOS DE EMBALAJE
Tipo                                         CodComen  Ultima modificaci�n              
_________ _40_______________________________ @@@@@@@@@ _32________ �D-MM-Y.YY  ________
|

TABLA=VDTIPOEMBA

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=TIPOEMBA,NOUPDATE,TOOLTIP("Tipo de embalaje"),TITULO("Tipo")
CAMPO=DESTIPOEMBA,TOOLTIP("Designaci�n del tipo de embalaje"),POSTCHANGE=FVALNOCERO("No puede dejar designaci�n en blanco"),TITULO("Designaci�n")
CAMPO=CODCOMEN,NOENTER,TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


