# M�dulo   : VDGRUPO.PAN
# Funci�n  : Mantenimiento de grupos de usuarios
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE GRUPOS DE USUARIOS
Grupo                                             D. M. m. L. Rep.  Cad.  A. Ultima modificaci�n
_20_______________ _40___________________________ @L @L @L @L @L@@@ @L@@@ @L _32________ �D-MM-Y.YY  ________
|

TABLA=VDGRUPO
ORDERBY=CODGRUPO;


PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODGRUPO,TOOLTIP("C�digo del grupo de usuarios"),TITULO("Grupo")
CAMPO=DESGRUPO,TOOLTIP("Designaci�n del grupo de usuarios"),TITULO("Descripcion")
CAMPO=MINDIG,TOOLTIP("M�nimo n�mero de digitos numericos en el password de los miembros del grupo"),TITULO("D")
CAMPO=MINMAY,TOOLTIP("M�nimo n�mero de mayusculas en el password de los miembros del grupo"),TITULO("M")
CAMPO=MINMIN,TOOLTIP("M�nimo n�mero de minusculas en el password de los miembros del grupo"),TITULO("m")
CAMPO=MINLON,TOOLTIP("M�nima longitud en el password de los miembros del grupo"),TITULO("L")
CAMPO=MINREP,TOOLTIP("M�nimo n�mero de d�as antes de repetir el password de los miembros del grupo"),TITULO("Rep")
CAMPO=CADUCA,TOOLTIP("N�mero de d�as antes de que tengan que cambiar el password los miembros del grupo"),TITULO("Cad")
CAMPO=AVISAR,TOOLTIP("N�mero de d�as para avisar antes de que el password de los miembros del grupo caduque"),TITULO("A")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")




CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


