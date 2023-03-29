# M�dulo   : VDARTLOTTRZ.PAN
# Funci�n  : Trazabilidad por art�culo - lote
#
# Creaci�n : 14-08-2008
# Autor    : MGM
###########################################
TABLA DE LOTES
 Cod.�rt.                                               C�d.Lote    Lote prov.  Caducidad Retest   Bloq.Lote  Potencia       �ltima Modificaci�n
 _40_________ _40______________________________________ _20________ _20________ _8______  _8______ _10_______ @L@@@@@@@,@@@  _10________ �D-MM-Y.YY  ________
| 

TABLA=IPLOTES

ORDERBY=CODART,CODLOT,FECMODIF,HORAMODIF;


POSTUPDATE=FEJECUTA("CSELMODIF","NO PUEDO MODIFICAR LA FECHA")
PREINSERT=FEJECUTA("CSELMODIF","NO PUEDO MODIFICAR LA FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","NO PUEDO MODIFICAR LA FECHA")
POSTQUERY=FEJECUTA("CSELDESART","ERROR COGIENDO LA DESCRIPCION DEL ARTICULO")

CAMPO=CODART,NOUPDATE,TOOLTIP("C�digo del art�culo\n:DESART"),
      POSTCHANGE=FVALNOCERO("EL CAMPO CODIGO DE ARTICULO\nNO PUEDE ESTAR VAC�O")
CAMPO=DESART,AUXILIAR,NOENTER
CAMPO=CODLOT,TOOLTIP("Lote"),
      POSTCHANGE=FVALNOCERO("EL CAMPO CODIGO DE LOTE\nNO PUEDE ESTAR VAC�O")                 
CAMPO=CODLOTPROV,TOOLTIP("Lote del proveedor")
CAMPO=CADUCI,TOOLTIP("Caducidad del lote")
CAMPO=RETEST,TOOLTIP("Fecha en la que se bloquea el lote")
CAMPO=BLOQLOTE,NOENTER,TOOLTIP("CALIFICACION LOTE\n :DESBLOQUEOS "),
    POSTCHANGE=FEJECUTA("+CSELDESBLOQUEOS","")
CAMPO=POTENCIA,TOOLTIP("Potencia del lote")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CAMPO=DESBLOQUEOS,AUXILIAR,OCULTO,"_256_"

CURSOR=CSELDESBLOQUEOS SELECT INFOBLOQUEOS(:BLOQLOTE) DESBLOQUEOS FROM DUAL;
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF
			FROM DUAL;
CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;




