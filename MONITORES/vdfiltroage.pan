# M�dulo   : VDSELAGE.PAN
# Funci�n  : Seleccion multiple de agencias
#
# Creaci�n : 05-08-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
#
SELECCION DE AGENCIA
COd.        Designaci�n                 Sel 
_10________ _30________________________  _

|

TABLA=VDAGENCIA

ORDERBY=CODAGE;


CAMPO=CODAGE,UPPER,TITULO("COd.")
CAMPO=DESAGE,UPPER,TITULO("Designaci�n")
CAMPO=SEL,AUXILIAR,UPPER,TOOLTIP(":RANAGE"),POSTCHANGE=FDESIGNACION("CCHECKVALUES","Debe introducir S(i) o N(o)",
                                                                    FIF("CSELINCLUDE",FIF("-CCHECKRANAGE","CAPENDAGE"),
                                                                                      FIF("CCHECKRANAGE","CELIMINAAGE")),
                                                                        "ERROR MODIFICANDO VARIABLE RANDIV"),TITULO("Sel"),WLONX=10

CURSOR=CCHECKVALUES SELECT :SEL FROM DUAL WHERE :SEL IS NULL OR :SEL IN ('S','N');

CURSOR=CSELINCLUDE SELECT :SEL FROM DUAL WHERE :SEL = 'S';

CURSOR=CCHECKRANAGE SELECT :CODAGE FROM DUAL WHERE VD.CONTIENECAD(:RANAGE,:CODAGE) = 1 AND :RANAGE IS NOT NULL;

CURSOR=CAPENDAGE SELECT DECODE(:RANAGE,NULL,:CODAGE,:RANAGE||','||:CODAGE) RANAGE FROM DUAL;

CURSOR=CELIMINAAGE SELECT VD.ELIMINAPIEZA(:RANAGE,:CODAGE) RANAGE FROM DUAL;

