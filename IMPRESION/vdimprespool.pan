# M�dulo   : VDIMPRESPOOL.PAN
# Funci�n  : Mantenimiento de Spool de Impresi�n V10
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
SPOOL DE IMPRESION V10
Secu.   Pr  Cop Ordenador      Tipo Imp.    Impresora      Fichero     Documento   Params                      Estado               Ult. Modificaci�n            
#L##### ##L @L@ _32___________ _ _12_______ _ _15_________ _256_______ _256_______ _1024______________________ @L@@@ _30___________ __32_____ �D-MM-Y.YY ________ 
|
#WLONX=1400
TABLA=VDIMPRESPOOL

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

POSTQUERY=FEJECUTA("CDAMETIPOIMPREACTIVO","ERROR EN CDAMETIPOIMPREACTIVO",
                   "CDAMECODIMPREACTIVO","ERROR EN CDAMECODIMPREACTIVO")



CAMPO=SEQIMPRE,TOOLTIP("N�mero de Secuencia de la Impresi�n"),TITULO("Secuencia"),WLONX=30
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de la impresi�n dentro de las de su grupo de impresoras"),TITULO("Pri"),WLONX=15
CAMPO=NUMCOPIAS,TITULO("Cop")
CAMPO=ORDENADOR,TOOLTIP("Ordenador desde el que se insert� en el spool"),TITULO("Ordenador")
CAMPO=TIPOIMPREACTIVO,AUXILIAR,NOENTER,TOOLTIP("Indica si el tipo de impresi�n est� activo"),TITULO("Tipo imp.")
CAMPO=TIPOIMPRE,TOOLTIP("Tipo de impresi�n")
CAMPO=CODIMPREACTIVO,AUXILIAR,NOENTER,TOOLTIP("Indica si la impresora est� activa"),TITULO("A")
CAMPO=CODIMPRE,TOOLTIP("Impresora V10 en la que se imprime"),TITULO("Impresora")
CAMPO=FICHERO,TOOLTIP("Fichero al que se exporta la impresi�n"),TITULO("Fichero"),MIXED
CAMPO=DOCUMENTO,TOOLTIP("Documento que se imprime"),TITULO("Documento"),MIXED
CAMPO=PARAMS,TOOLTIP("Valores de Bind pasados al documento"),TITULO("Params")
CAMPO=STATUS,TOOLTIP("Estado de la impresi�n en la cola"),POSTCHANGE=FDESIGNACION("+CDESSTATUS",""),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TITULO("")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")
CAMPO=NOMBREFORM,NOUPDATE,AUXILIAR,OCULTO,"_100"
CAMPO=PARAMFORM,NOUPDATE,AUXILIAR,OCULTO,"_1000"

CURSOR=CDAMETIPOIMPREACTIVO SELECT ACTIVO TIPOIMPREACTIVO FROM VDIMPRETIPO WHERE TIPOIMPRE=:TIPOIMPRE;

CURSOR=CDAMECODIMPREACTIVO SELECT ACTIVO CODIMPREACTIVO FROM VDIMPRESORAS WHERE CODIMPRE=:CODIMPRE;


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='ISP' AND STATUS=:STATUS;

CURSOR=CDAMENOMBREFORM DECLARE
                         NUMPIEZAS NUMBER;
                         PIEZA VARCHAR2(100);
                       BEGIN
                         CASE
                           WHEN INSTR(:PARAMS,'CODPED')>0 THEN
                            :NOMBREFORM:='VDPEDIDOS';
                            NUMPIEZAS:=VD.NUMPIECES(:PARAMS,';');
                            FOR I IN 1..NUMPIEZAS LOOP
                                PIEZA:=VD.PIECE(:PARAMS,';',I);
                                IF INSTR(PIEZA,'CODPED')=0 AND INSTR(PIEZA,'CODDIV')=0 AND INSTR(PIEZA,'ANOPED')=0 AND INSTR(PIEZA,'SEQPED')=0 THEN PIEZA:=NULL;
                                 END IF;
                                IF PIEZA IS NOT NULL THEN
                                   :PARAMFORM:=:PARAMFORM||CASE WHEN :PARAMFORM IS NULL THEN NULL ELSE ' AND ' END||PIEZA;
                                 END IF;
                             END LOOP;
                           WHEN INSTR(:PARAMS,'CODBULTO')>0 THEN
                            :NOMBREFORM:='VDBULTOSMA';
                            NUMPIEZAS:=VD.NUMPIECES(:PARAMS,';');
                            FOR I IN 1..NUMPIEZAS LOOP
                                PIEZA:=VD.PIECE(:PARAMS,';',I);
                                IF INSTR(PIEZA,'CODBULTO')=0 THEN PIEZA:=NULL;
                                 END IF;
                                IF PIEZA IS NOT NULL THEN
                                   :PARAMFORM:=:PARAMFORM||CASE WHEN :PARAMFORM IS NULL THEN NULL ELSE ' AND ' END||PIEZA;
                                 END IF;
                             END LOOP;
                           WHEN INSTR(:PARAMS,'CODBOLETA')>0 THEN
                            :NOMBREFORM:='VDSERIEEXP';
                            NUMPIEZAS:=VD.NUMPIECES(:PARAMS,';');
                            FOR I IN 1..NUMPIEZAS LOOP
                                PIEZA:=VD.PIECE(:PARAMS,';',I);
                                IF INSTR(PIEZA,'CODBOLETA')=0 AND INSTR(PIEZA,'ANOBOLETA')=0 THEN PIEZA:=NULL;
                                 END IF;
                                IF PIEZA IS NOT NULL THEN
                                   :PARAMFORM:=:PARAMFORM||CASE WHEN :PARAMFORM IS NULL THEN NULL ELSE ' AND ' END||PIEZA;
                                 END IF;
                             END LOOP;
                           WHEN INSTR(:PARAMS,'CODART')>0 THEN
                            IF INSTR(:PARAMS,'CODLOT')>0 THEN :NOMBREFORM:='VDLOTES';
                               ELSE :NOMBREFORM:='VDARTIC';
                             END IF;
                            NUMPIEZAS:=VD.NUMPIECES(:PARAMS,';');
                            FOR I IN 1..NUMPIEZAS LOOP
                                PIEZA:=VD.PIECE(:PARAMS,';',I);
                                IF INSTR(PIEZA,'CODART')=0 AND INSTR(PIEZA,'CODLOT')=0 THEN PIEZA:=NULL;
                                 ELSE PIEZA:=VD.PIECE(PIEZA,'=',1)||'='''||VD.PIECE(PIEZA,'=',2)||'''';
                                 END IF;
                                IF PIEZA IS NOT NULL THEN
                                   :PARAMFORM:=:PARAMFORM||CASE WHEN :PARAMFORM IS NULL THEN NULL ELSE ' AND ' END||PIEZA;
                                 END IF;
                             END LOOP;
                           WHEN INSTR(:PARAMS,'CODMOV')>0 THEN
                           :NOMBREFORM:='VDMOVIM';
                            NUMPIEZAS:=VD.NUMPIECES(:PARAMS,';');
                            FOR I IN 1..NUMPIEZAS LOOP
                                PIEZA:=VD.PIECE(:PARAMS,';',I);
                                IF INSTR(PIEZA,'CODMOV')=0 THEN PIEZA:=NULL;
                                 END IF;
                                IF PIEZA IS NOT NULL THEN
                                   :PARAMFORM:=:PARAMFORM||CASE WHEN :PARAMFORM IS NULL THEN NULL ELSE ' AND ' END||PIEZA;
                                 END IF;
                             END LOOP;
                           ELSE RAISE NO_DATA_FOUND;
                        END CASE;
                       END;@
                            
CONTEXTUAL=FEJECUTA("CDAMENOMBREFORM","",FEJECUTAFORM(":NOMBREFORM","S",":PARAMFORM"),"")