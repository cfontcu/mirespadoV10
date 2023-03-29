#*****************************************************************
#M�dulo: VDRECSTKORI.PAN
#Funci�n : Selecciona el stock tal y como se recepcion� en recepci�n.
#          Los movimientos negativos que se realicen en la pantalla de validaci�n tendr�n el mismo concepto de entrada, pero acabado en '-', y
#          Los movimientos de muestras acabar�n en 'M'.
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
STOCK COMO SE RECEPCIONO
Matr�cula          Art�culo          Lote             Cantidad Muestra    
_18_______________ _40______________ _40_____________ ######## _1_____    
|
SOLOQUERY
SELECT=SELECT CASE WHEN  UBIO.STOCK='N' THEN CODMATDEST ELSE CODMATORI END CODMAT, MOV.CODART, CODLOT, DECODE(SUBSTR(CODCONCE,LENGTH(CODCONCE),1), 'M','S','N') MUESTRA,
              SUM(CASE WHEN UBIO.STOCK='N' THEN CANTIDAD ELSE -CANTIDAD END) CANTIDAD
         FROM VDMOVIM MOV,VDUBICA UBIO
        WHERE CODRECEP = :CODRECEP AND MOV.CODUBIORI=UBIO.CODUBI AND (UBIO.STOCK='N' OR CODUBIDEST IN (SELECT CODUBI FROM VDUBICA WHERE STOCK='N'))
          AND TAREA = VD.GETPROP('TAREARECEP') 
          AND STATUS < VDST.FMOVANULADO
          AND (CODCONCE IN (SELECT CODCONCE||'M'
                             FROM VDTIPORDRECCAB
                            WHERE TIPORDREC = :TIPORDREC
                          UNION
                           SELECT CODCONCE 
                             FROM VDTIPORDRECCAB
                            WHERE TIPORDREC = :TIPORDREC
                          UNION
                           SELECT CODCONCE||'-'
                             FROM VDTIPORDRECCAB
                            WHERE TIPORDREC = :TIPORDREC)
            OR CODCONCE IN (VD.GETPROP('REGULARIZA-'),VD.GETPROP('REGULARIZA+')));

GROUPBY=CASE WHEN  UBIO.STOCK='N' THEN CODMATDEST ELSE CODMATORI END, MOV.CODART, CODLOT, DECODE(SUBSTR(CODCONCE,LENGTH(CODCONCE),1), 'M','S','N');
ORDERBY=CODMAT;

TABLA=MOV


CAMPO=CODMAT,TOOLTIP("C�digo de matr�cula"),TITULO("Matr�cula")
CAMPO=CODART,TOOLTIP("C�digo de art�culo"),TITULO("Art�culo")
CAMPO=CODLOT,TOOLTIP("C�digo del Lote"),TITULO("Lote")
CAMPO=CANTIDAD,TOOLTIP("Cantidad recepcionada"),TITULO("Cantidad")
CAMPO=MUESTRA,TOOLTIP("Indicador de si es una muestra o no"),TITULO("Muestra")
CAMPO=CODRECEP,VIRTUAL,AUXILIAR,OCULTO
CAMPO=TIPORDREC,VIRTUAL,AUXILIAR,OCULTO

CONTEXTUAL=FEJECUTAFORM("VDCONTE","S","CODMAT=:CODMAT")
