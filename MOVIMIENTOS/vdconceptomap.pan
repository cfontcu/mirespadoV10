# M�dulo   : VDCONCEPTOMAP.PAN
# Funci�n  : Mantenimiento de mapeos de movimientos para interfase
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE MAPEO DE CONCEPTOS
Sec.    Div.           Alm. origen Alm. destino Bloq orig.           Bloq dest.           H A Interface          S Ultima modificaci�n
@L@@@@@ _1024_________ _1024______ _1024_______ ____________________ ____________________ _ _ _20_______________ _ _32________ �D-MM-Y.YY ________
|
TABLA=VDCONCEPTOMAP
ORDERBY=SEQCONCEPTOMAP;

PREINSERT=FEJECUTA("CSELSEC","No puedo calcular el secuencial","CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=SEQCONCEPTOMAP,NOUPDATE,TITULO("Sec.")
CAMPO=CODCONCE,VIRTUAL,OCULTO
CAMPO=RANCODDIV,TOOLTIP("Divisi�n"),TITULO("Divisi�n"),COMBOXMULTIPLE("CLISTADIV"),
                CONTEXTUAL=FSELMULTIPLE("RANCODDIV","CODDIV","SELECT CODDIV,DESDIV FROM VDDIVIS ORDER BY CODDIV","Seleccion de division","Div.")
CAMPO=RANCODALMORI,TOOLTIP("Almac�n origen"),TITULO("Almac�n Origen"),COMBOXMULTIPLE("CLISTAALMA"),WLONX=20
                CONTEXTUAL=FSELMULTIPLE("RANCODALMORI","CODALM","SELECT CODALM,DESALM FROM VDALMA ORDER BY CODALM","Seleccion de almacen","Almacen Designacion")
CAMPO=RANCODALMDEST,TOOLTIP("Almac�n destino"),TITULO("Almac�n Destino"),COMBOXMULTIPLE("CLISTAALMA"),WLONX=20,
                CONTEXTUAL=FSELMULTIPLE("RANCODALMDEST","CODALM","SELECT CODALM,DESALM FROM VDALMA ORDER BY CODALM","Seleccion de almacen","Almacen")
CAMPO=PATRONORI,TOOLTIP("Bloqueos origen del movimiento"),TITULO("Bloqueos Origen")
CAMPO=PATRONDEST,TOOLTIP("Bloqueos de destino del movimiento"),TITULO("Bloqueos Destino")
CAMPO=SWTHOST,TOOLTIP("Indica si el movimiento se ha de transmitir al host"),POSTCHANGE=FVERIFICA("SNIR","Debe introducir S(i) N(o) R(evisar) o I(mmediato)"),TITULO("Host"),WLONX=20
CAMPO=SWTACUM,TOOLTIP("Indica si el movimiento se puede acumular con otros similares"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) N(o)"),TITULO("Acumular"),WLONX=60
CAMPO=CONCEPTOINTER,TOOLTIP("Concepto de interfase al que se mapea"),POSTCHANGE=FDESIGNACION("CSELCONCEPTOINTER","No existe concepto de interfase"),TITULO("Interface"),
                COMBOXMULTIPLE("CLISTACONCE"),COMBOXREGPAG=8,
                CONTEXTUAL=FSELSIMPLE("CONCEPTOINTER","SELECT CONCEPTOINTER,DESCONCEPTOINTER FROM VDCONCEPTOINTER","Selecci�n de concepto de interfase","Concepto"),WLONX=50
CAMPO=SIGNO,TOOLTIP("Signo del movimiento para interfase"),POSTCHANGE=FVERIFICA("PN","Debe introducir P(ositivo) o N(egativo)"),TITULO("Signo"),WLONX=20
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTADIV SELECT CODDIV,DESDIV FROM VDDIVIS ORDER BY CODDIV;

CURSOR=CLISTAALMA SELECT CODALM,DESALM FROM  VDALMA ORDER BY CODALM;

CURSOR=CLISTACONCE SELECT CONCEPTOINTER,DESCONCEPTOINTER FROM VDCONCEPTOINTER ORDER BY CONCEPTOINTER;

CURSOR=CSELSEC SELECT VDSECCONCEPTOMAP.NEXTVAL SEQCONCEPTOMAP FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDIVIS SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV 
                    UNION
                 SELECT '' DESDIV FROM DUAL WHERE :CODDIV IS NULL;
                 
CURSOR=CSELALMORI SELECT DESALM DESALMORI FROM VDALMA WHERE CODALM=:CODALMORI 
                    UNION
                 SELECT '' DESALMORI FROM DUAL WHERE :CODALMORI IS NULL;
                 
CURSOR=CSELALMDEST SELECT DESALM DESALMDEST FROM VDALMA WHERE CODALM=:CODALMDEST 
                    UNION
                 SELECT '' DESALMDEST FROM DUAL WHERE :CODALMDEST IS NULL;
                 
                 
CURSOR=CSELCONCEPTOINTER  SELECT :CONCEPTOINTER FROM VDCONCEPTOINTER WHERE CONCEPTOINTER=:CONCEPTOINTER 
                    UNION
                 SELECT '' CONCEPTOINTER FROM DUAL WHERE :CONCEPTOINTER IS NULL AND :SWTHOST='N';




