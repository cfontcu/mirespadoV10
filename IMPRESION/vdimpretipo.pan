# M�dulo   : VDIMPRETIPO.PAN
# Funci�n  : Mantenimiento de Tipos de Impresoras
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TIPOS DE IMPRESORAS
Tipo          Descripci�n                                                   Activo  Tipo            Ult. Modificaci�n            
____________  ____________________________________________________________    _      _ _20__________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDIMPRETIPO

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=TIPOIMPRE,TOOLTIP("Tipo de Impresi�n"),TITULO("Tipo")
CAMPO=DESTIPOIMPRE,TOOLTIP("Descripci�n del Tipo de Impresi�n"),TITULO("Descripci�n")
CAMPO=ACTIVO,TOOLTIP("Si est� activo el tipo de impresi�n"),POSTCHANGE=FEJECUTA(FVERIFICA("NS"),"CAMPO ACTIVO DEBE SER 'S' O 'N'"),TITULO("Act"),WLONX=15
CAMPO=TIPODOC,TOOLTIP("Tipo de Documento a Imprimir. (E)tiqueta o (I)nforme (P)rn"),POSTCHANGE=FEJECUTA(FVERIFICA("EIPA"),"CAMPO TIPO DE DOCUMENTO DEBE SER 'E' O 'I' 'A' o 'P'",
                                                                                                  "+CDESTIPODOC",""),TITULO("Tipo Doc.")
CAMPO=DESTIPODOC,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

#CURSORES
CURSOR=CDESTIPODOC SELECT DECODE(:TIPODOC,'E','ETIQUETAS','INFORME') DESTIPODOC FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


