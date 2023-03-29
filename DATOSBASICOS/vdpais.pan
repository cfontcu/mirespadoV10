# M�dulo   : VDPAIS.PAN
# Funci�n  : Mantenimiento de paises
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE PAISES
Cod.Pa�s Pa�s                          C2  C3  UE   Extra         Ultima modificaci�n
________ _____________________________ _2_ _3__ _1_  _256_________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDPAIS
ORDERBY=DESPAIS;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODPAIS,NOUPDATE,TOOLTIP("C�digo ISO del pa�s"),TITULO("Cod.Pa�s")
CAMPO=DESPAIS,MIXED,TOOLTIP("Designaci�n del pais"),POSTCHANGE=FVALNOCERO("Debe introducir designaci�n del pais"), TITULO("Pa�s")
CAMPO=CODPAIS2,TITULO("C2"),TOOLTIP("Codigo iso 2 del pais")
CAMPO=CODPAIS3,TITULO("C3"),TOOLTIP("Codigo iso3 del pais")
CAMPO=UE,TITULO("UE"),TOOLTIP("Indica si pertenece a la UE")
CAMPO=VDEXTRA,TITULO("Extra"),TOOLTIP("Campo extra")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


