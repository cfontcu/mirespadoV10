# M�dulo   : VDETIQCNT.PAN
# Funci�n  : Impresi�n de etiquetas de contenedor. Elecci�n del n�mero de etiquetas de contenedor NUEVO.
#
# Creaci�n : 13-08-2008
# Autor    : JCSR
###########################################
# Hist�rico de cambios:
NUMERO DE ETIQUETAS PICKING A IMPRIMIR.

  Seleccione el n�mero de matr�culas @L@

  Seleccione el n�mero de etiquetas por matr�cula @L 
|

TABLA=DUAL


CURSOR=CIMPRIME BEGIN
                  VDIMPRIME.IMPRIME('ETIQ', 'VDCODMAT.ZPL;VDETIQUETAS.VSQ;MATRICULA', 'CODMAT='||:CODMAT||'',1,'', '', :V10ERROR); 
                  COMMIT;				  
                 END;@

TECLA=F4,FEJECUTA("CSELETIQ","El n�mero de etiquetas a imprimir debe ser mayor que 0",
                   FWHILE(FERRORCURSOR("CSELETIQ"),
                   FEJECUTA("CSELCODMAT", "No puedo sacar el C�digo de matr�cula", 
                            "CIMPRIME", "No puedo insertar los datos de las matr�culas.",
                            FCOMMIT,"",
                            +FFETCHCURSOR("CSELETIQ"),"ERROR EN FETCH")), "ERROR EN WHILE",
                   FCOMMIT, "")


CAMPO=NUMCNT, AUXILIAR
CAMPO=NUMETIQ, AUXILIAR
CAMPO=CODMAT, AUXILIAR, OCULTO, "_18_"

CURSOR=CSELETIQ SELECT :NUMETIQ NUMETIQ FROM ALL_TABLES  WHERE ROWNUM<=:NUMCNT;                                

CURSOR=CSELCODMAT SELECT VDSECPICK.NEXTVAL CODMAT FROM DUAL;

# POSCONTE A 1
# STATUS A 0
# FECHA ENTRADA, HORAENTRADA => EN VDCONTE FECCREADO Y HORACREADO
# TIPOCONTE A DUMMY


                                                 
