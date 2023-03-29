# M�dulo   : VDCONTEUBI.PAN
# Funci�n  : Mantenimiento de contenedores en ubicaci�n
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CONTENEDORES
Matr�cula          Tipo        C�digo seriado       Pos.   Altura Stat.  Designaci�n    Entrada             Extra       Coment.   Ultima modificaci�n          
__________________ _10________ _20_________________ @L9@@@ @L9@@@ @L@@@@ _40___________ �D-MM-Y.YY ________ _255_______ @L@@@@@@@ _32________ �D-MM-Y.YY  ________
|
TABLA=VDCONTE
ORDERBY=DECODE(TIPOCONTE,'VIRTUAL',0), POSCONTE;

PREINSERT=FEJECUTA("CSELCREACODMAT","ERROR, creando matr�cula",
                   "+CDAMEPOSCONTE","",
                   "CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODUBI,VIRTUAL,OCULTO
CAMPO=CODMAT,NOUPDATE,TOOLTIP("Matricula del contenedor"),TITULO("Matr�cula")
CAMPO=TIPOCONTE,TOOLTIP("Tipo de contenedor"),POSTCHANGE=FDESIGNACION("CVERTIPO","No existe el tipo de contenedor"),
                TITULO("Tipo")
CAMPO=CNTSSCC,TOOLTIP("C�digo seriado del contenedor"),TITULO("C�digo Seriado")
CAMPO=POSCONTE,TOOLTIP("Posici�n del contenedor en la ubicaci�n"),TITULO("Pos.")
CAMPO=ALTURACONTE,TOOLTIP("Altura del contenedor"),TITULO("Altura")
CAMPO=STATUS,TOOLTIP("Estado del contenedor"),POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado"),
                CONTEXTUAL=FEJECUTAFORM("VDSTATUS","N","TIPOSTATUS='CNT'","","STATUS=:STATUS","Selecci�n de status","S"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del estado del contenedor"),TITULO("")
CAMPO=FECENTRADA,TOOLTIP("Fecha de entrada del contenedor en el sistema"),TITULO("Entrada")
CAMPO=HORAENTRADA,TOOLTIP("Hora de entrada del contenedor en el sistema")
CAMPO=VDEXTRA,TOOLTIP("Informaci�n extra disponible para el implantador"),TITULO("Extra")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario del contenedor"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CVERTIPO SELECT :TIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='CNT' AND STATUS=:STATUS;

CURSOR=CSELCREACODMAT SELECT NVL(:CODMAT,VDSECCNT.NEXTVAL) CODMAT,VD.FECHASYS FECENTRADA, VD.HORASYS HORAENTRADA FROM DUAL;

CURSOR=CDAMEPOSCONTE SELECT DECODE(:POSCONTE,0,NVL(MAX(POSCONTE),0)+1,:POSCONTE) POSCONTE FROM VDCONTE WHERE CODUBI=:CODUBI;

CURSOR=CIMPREETIQ DECLARE
                  FICHERO VARCHAR2(100);
                  MIUNIEMB NUMBER;
                  MICODIMPRE VARCHAR2(100);
                  MINUMALBA VARCHAR2(20);
                  MICODLOT VARCHAR2(20);
                  MICODART VARCHAR2(20);
                BEGIN
                  SELECT CODART, CODLOT INTO MICODART, MICODLOT FROM VDSTOCK STK, VDCONTE CO WHERE CO.CODMAT=STK.CODMAT AND CO.CODMAT=:CODMAT AND ROWNUM=1;
                  SELECT UNIEMB INTO MIUNIEMB FROM VDARTIC WHERE CODART=MICODART;
                  FICHERO:='VDPRODUCTOMAT.ZPL;VDETIQUETAS.VSQ;PRODUCTOMAT';
                  VDIMPRIME.IMPRIME('ETIQ',FICHERO,'CODART='||MICODART||';CODLOT='||MICODLOT||';CODMAT='||:CODMAT||';NUMALBARAN='||MINUMALBA||';UNIEMBHOST='||MIUNIEMB||';TIPOEMBA=''CAJA'';ESCOPIA=''S''',1,MICODIMPRE,'',:V10ERROR);    
                  COMMIT;
                END;@

              
CURSOR=CHECKERROR SELECT :V10ERROR FROM DUAL WHERE :V10ERROR IS NULL; 


CURSOR=CIMPRIME BEGIN
                  VDIMPRIME.IMPRIME('ETIQ', 'VDCODMAT.ZPL;VDETIQUETAS.VSQ;MATRICULA', 'CODMAT='||:CODMAT||'',1,'', '', :V10ERROR); 
                  COMMIT;				  
                 END;@ 
                 
TECLA=CF1,FEJECUTA("CIMPRIME","NO PUEDO IMPRIMIR")
