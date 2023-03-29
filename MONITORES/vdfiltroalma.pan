# M�dulo   : VDSELALMA.PAN
# Funci�n  : Seleccion multiple de almacenes
#
# Creaci�n : 05-08-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
#
SELECCION DE ALMACEN
Cod. Designaci�n                 Sel 
_4__ _40________________________  _

|

TABLA=VDALMA

ORDERBY=CODALM;


CAMPO=CODALM,UPPER,TITULO("Cod.")
CAMPO=DESALM,UPPER,TITULO("Designaci�n")
CAMPO=SEL,AUXILIAR,UPPER,TOOLTIP(":RANALM"),POSTCHANGE=FDESIGNACION("CCHECKVALUES","Debe introducir S(i) o N(o)",
                                                                    FIF("CSELINCLUDE",FIF("-CCHECKRANALM","CAPENDALM"),
                                                                                      FIF("CCHECKRANALM","CELIMINAALM")),
                                                                        "ERROR MODIFICANDO VARIABLE RANALM"),TITULO("Sel"),WLONX=10

CURSOR=CCHECKVALUES SELECT :SEL FROM DUAL WHERE :SEL IS NULL OR :SEL IN ('S','N');

CURSOR=CSELINCLUDE SELECT :SEL FROM DUAL WHERE :SEL = 'S';

CURSOR=CCHECKRANALM SELECT :CODALM FROM DUAL WHERE VD.CONTIENECAD(:RANALM,:CODALM) = 1 AND :RANALM IS NOT NULL;

CURSOR=CAPENDALM SELECT DECODE(:RANALM,NULL,:CODALM,:RANALM||','||:CODALM) RANALM FROM DUAL;

CURSOR=CELIMINAALM SELECT VD.ELIMINAPIEZA(:RANALM,:CODALM) RANALM FROM DUAL;


