# M�dulo   : VDCRETIQUETAS.PAN
# Funci�n  : Cola de impresi�n de etiquetas a imprimir
#
# Creaci�n : 20-08-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
COLA DE IMPRESION DE ETIQUETAS A IMPRIMIR
Dato         Copia  Sid             Serial
_100________   _    ############### ############### 
|
TABLA=VDCRETIQUETAS

PREDELETE=FEJECUTA("CDELMATRICULA","ERROR EN CDELMATRICULA")

CURSOR=CDELMATRICULA DELETE VDCONTE WHERE CODMAT=:DATO AND TIPOCONTE='DUMMY' AND CODUBI IS NULL;

CAMPO=DATO,TOOLTIP("Dato que define la unidad que queremos imprimir (CODBULTO para bultos, CODUBI para ubicaciones...")
CAMPO=COPIA,TOOLTIP("Cantidad de etiquetas que queremos imprimir para ese dato.")
CAMPO=SID,TOOLTIP("Serial de la sesi�n que hace la inserci�n.")
CAMPO=SERIAL,TOOLTIP("")

