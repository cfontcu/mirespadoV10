# M�dulo   : VDSELCONCEPTOFORM.PAN
# Funci�n  : Selecci�n de asignaciones de conceptos a transf./regularizaciones de stock desde pantalla
#
# Creaci�n : 05-06-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ASIGNACION DE CONCEPTOS DE MOVIMIENTOS A CAMPOS DEL STOCK

                                                        ������ ENTRADAS ������ ������ SALIDAS �������
Prop.      Or. Desc.                                     Concep     Fuente     Concep     Sumid.     
_32_______ @@  _256____________________________________ __________ _12_______ __________ _12_______ 

|

TABLA=VDCONCEPTOFORM CFRM
WHERE= TIPOPROP=:CAMPO AND
       ACTIVO='S' AND
      (CODCLASE IS NULL OR EXISTS (SELECT 1 FROM VDCLASEARTIC CLA WHERE CLA.CODCLASIF=CFRM.CODCLASIF AND CLA.CODCLASE=CFRM.CODCLASE AND CLA.CODART=:CODART)) AND
      (CFRM.RANGODIV IS NULL OR EXISTS (SELECT 1 FROM VDARTIC ART WHERE ART.CODART=:CODART AND VD.CONTIENECAD(CFRM.RANGODIV,ART.CODDIV)>0));

CAMPO=CAMPO,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODART,AUXILIAR,VIRTUAL,OCULTO
CAMPO=TIPOPROP,TOOLTIP("PROPIEDAD DEL STOCK")
CAMPO=ORDEN,TOOLTIP("ORDEN DE LA ASIGNACION DE CONCEPTOS A LA PROPIEDAD DEL STOCK")
CAMPO=DESTIPOPROP,TOOLTIP("DESCRIPCION DE LA ASIGNACION DE CONCEPTOS A LA PROPIEDAD DEL STOCK")
CAMPO=CODCONCEENT,TOOLTIP("CONCEPTO DE ENTRADA ASIGNADO"),CONTEXTUAL=FEJECUTAFORM("VDCONCEPTO","N","","","CODCONCEENT=:CODCONCE","SELECCION DE CONCEPTOS","S")
CAMPO=FUENTE,TOOLTIP("UBICACION FUENTE DE LAS ENTRADAS"),CONTEXTUAL=FEJECUTAFORM("VDUBICA","N","STOCK='N'","","FUENTE=:CODUBI","SELECCION DE UBICACIONES FUENTES","S")
CAMPO=CODCONCESAL,TOOLTIP("CONCEPTO DE SALIDA ASIGNADO"),CONTEXTUAL=FEJECUTAFORM("VDCONCEPTO","N","","","CODCONCESAL=:CODCONCE","SELECCION DE CONCEPTOS","S")
CAMPO=SUMIDERO,TOOLTIP("UBICACION SUMIDERO DE LAS SALIDAS"),CONTEXTUAL=FEJECUTAFORM("VDUBICA","N","STOCK='N'","","SUMIDERO=:CODUBI","SELECCION DE UBICACIONES SUMIDEROS","S")





