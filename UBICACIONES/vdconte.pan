# M�dulo   : VDCONTE.PAN
# Funci�n  : Mantenimiento de contenedores
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CONTENEDORES
Matr�cula          Tipo        SSCC          Res.  Ubicaci�n        Area      Pos.  Peso   Altura Stat. Designaci�n    Entrada             Sc  Extra       Coment.   Ultima modificaci�n
_18_______________ _10________ _20__________ @L,@@ _20_____________ _20______ @L@@@ @L@@@@ @L9@@@ @L@@@ _40___________ �D-MM-Y.YY ________ @L@ _255_______ @L@@@@@@@ _32________ �D-MM-Y.YY  ________
|
TABLA=VDCONTE
SELECT=VDSTK.CNTRESERVADO(CODMAT,'U') RESERVADO;
ORDERBY=CODMAT;
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CURSOR=CSELAREA SELECT CODAREA FROM VDUBICA WHERE CODUBI=:CODUBI;

CAMPO=CODMAT,NOUPDATE,TOOLTIP("Matricula del contenedor"),TITULO("Matr�cula")
CAMPO=TIPOCONTE,TOOLTIP("Tipo de contenedor"),POSTCHANGE=FDESIGNACION("CVERTIPO","No existe el tipo de contenedor"),
                TITULO("Tipo"),UPDATE("SUPERVISOR"),COMBOX("CSELCONTE")
CAMPO=CNTSSCC,TOOLTIP("C�digo seriado del contenedor"),TITULO("C�digo Seriado")
CAMPO=RESERVADO,AUXILIAR,NOENTER
CAMPO=CODUBI,TOOLTIP("Ubicaci�n donde est� el contenedor"),POSTCHANGE=FDESIGNACION("CVERUBI","No existe ubicaci�n"),TITULO("Ubicaci�n"),POSTCHANGE=FEJECUTA("+CSELAREA","")
CAMPO=CODAREA,AUXILIAR,NOUPDATE,WHERE=CODUBI IN (SELECT CODUBI FROM VDUBICA WHERE CODAREA=:CODAREA);
CAMPO=POSCONTE,TOOLTIP("Posici�n del contenedor en la ubicaci�n"),TITULO("Pos.")
CAMPO=PESOCONTE,TOOLTIP("Peso del contenedor"),TITULO("Peso")
CAMPO=ALTURACONTE,TOOLTIP("Altura del contenedor"),TITULO("Altura")
CAMPO=STATUS,TOOLTIP("Estado del contenedor"),POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado"),
                CONTEXTUAL=FEJECUTAFORM("VDSTATUS","N","TIPOSTATUS='CNT'","","STATUS=:STATUS","Selecci�n de status","S"),
                TITULO("Stat")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del estado del contenedor"),TITULO("Designaci�n")
CAMPO=FECENTRADA,TOOLTIP("Fecha de entrada del contenedor en el sistema"),TITULO("Entrada")
CAMPO=HORAENTRADA,TOOLTIP("Hora de entrada del contenedor en el sistema")
CAMPO=ULTSCAN
CAMPO=VDEXTRA,TOOLTIP("Informaci�n extra disponible para el implantador"),TITULO("Extra")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario del contenedor"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CVERTIPO SELECT :TIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE;

CURSOR=CVERUBI SELECT :CODUBI FROM VDUBICA WHERE CODUBI=:CODUBI OR :CODUBI IS NULL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='CNT' AND STATUS=:STATUS;

CURSOR=CSELCONTE SELECT TIPOCONTE FROM VDTIPOCONTE ORDER BY TIPOCONTE;

#IMPRIME MATRICULA
CURSOR=CIMPRIME BEGIN
                  VDIMPRIME.IMPRIME('ETIQ', 'VDCODMAT.ZPL;VDETIQUETAS.VSQ;MATRICULA', 'CODMAT='||:CODMAT||'',1,'', '', :V10ERROR); 
                  COMMIT;				  
                 END;@ 
                 
TECLA=CF1,FEJECUTA("CIMPRIME","NO PUEDO IMPRIMIR")
CURSOR=CHECKERROR SELECT :V10ERROR FROM DUAL WHERE :V10ERROR IS NULL; 

CONTEXTUAL=FLEEMENU("VDCONTE.ZOO")

