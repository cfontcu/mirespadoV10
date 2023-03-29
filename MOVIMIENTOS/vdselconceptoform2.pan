# M�dulo   : VDSELCONCEPTOFORM.PAN
# Funci�n  : Selecci�n de asignaciones de conceptos a transf./regularizaciones de stock desde pantalla
#
# Creaci�n : 05-06-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ASIGNACION DE CONCEPTOS DE MOVIMIENTOS A CAMPOS DEL STOCK

                                                        
Prop.      Or. Desc.                                    Concepto   H C. Inter.  
_32_______ @@  _256____________________________________ __________ _ _20_______________

|

TABLA=VDCONCEPTOFORM CFRM
SOLOQUERY
SELECT=SELECT CFRM.TIPOPROP,CFRM.DESTIPOPROP,CFRM.ORDEN,CFRM.CODCONCEENT,CFRM.CANTMAX,CFRM.PVLMAX,CFRM.FUENTE
        FROM VDCONCEPTOFORM CFRM,VDCONCEPTO CON
        WHERE TIPOPROP=:CAMPO AND
               ACTIVO='S' AND
               VDUSER.TENGOPRIVILEGIO(CFRM.PRIVILEGIOS)=1 AND
               (CODCLASE IS NULL OR EXISTS (SELECT 1 FROM VDCLASEARTIC CLA WHERE CLA.CODCLASIF=CFRM.CODCLASIF AND CLA.CODCLASE=CFRM.CODCLASE AND CLA.CODART=:CODART)) AND
               (CFRM.RANGODIV IS NULL OR EXISTS (SELECT 1 FROM VDARTIC ART WHERE ART.CODART=:CODART AND VD.CONTIENECAD(CFRM.RANGODIV,ART.CODDIV)>0)) AND
               CON.CODCONCE=CFRM.CODCONCEENT AND ((CON.TIPOCONCE='E' AND :CANTIDAD>0) OR (CON.TIPOCONCE!='E' AND :CANTIDAD<0) OR :CANTIDAD=0)
      ;

ORDERBY=ORDEN;

POSTQUERY=FEJECUTA("+CSELCONCEPTOINTER","NO existe concepto de interfase")

REGPAG=20
CAMPO=CAMPO,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODART,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TIPOPROP,TOOLTIP("PROPIEDAD DEL STOCK"),TITULO("Tipos")
CAMPO=ORDEN,TOOLTIP("ORDEN DE LA ASIGNACION DE CONCEPTOS A LA PROPIEDAD DEL STOCK"),TITULO("Ord."),WLONX=10
CAMPO=DESTIPOPROP,TOOLTIP("DESCRIPCION DE LA ASIGNACION DE CONCEPTOS A LA PROPIEDAD DEL STOCK"),TITULO("Decripcion")
CAMPO=CODCONCEENT,TOOLTIP("CONCEPTO DE ENTRADA ASIGNADO"),TITULO("Concepto"),CONTEXTUAL=FEJECUTAFORM("VDCONCEPTO","N","","","CODCONCEENT=:CODCONCE","SELECCION DE CONCEPTOS","S")
CAMPO=CANTMAX,OCULTO,"@L@@@@@@@"
CAMPO=PVLMAX,OCULTO,"@L@@@@@@@"
CAMPO=FUENTE,OCULTO,"_12_______"
CAMPO=RANGODIV,OCULTO,"_100"
CAMPO=SWTHOST,AUXILIAR,NOENTER,TITULO("H"),WLONX=10
CAMPO=CONCEPTOINTER,AUXILIAR,NOENTER,TITULO("Conc. Int.")

CURSOR=CSELCONCEPTOINTER SELECT SWTHOST,CONCEPTOINTER
                          FROM VDCONCEPTOMAP CMP
                          WHERE CODCONCE=:CODCONCEENT AND 
                            (CMP.RANCODDIV IS NULL OR EXISTS (SELECT 1 FROM VDARTIC ART WHERE ART.CODART=:CODART AND VD.CONTIENECAD(CMP.RANCODDIV,ART.CODDIV)>0));



