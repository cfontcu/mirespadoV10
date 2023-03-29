#*****************************************************************
#MOdulo: METINVENT3.PAN
#Funcionalidad : Pantalla para conteos
#Autor: ICC      
#Fecha: 06-03-2023
#*****************************************************************
#* HistOrico de cambios
#* ====================
#
 CONTEOS
 Matricula         Cantidad Real
 _20__________     #L############


                                     |

TABLA=DUAL
NOQUERY
NOCOMMIT

#CAMPO=CODINVEN,VIRTUAL,AUXILIAR,POSTCHANGE=FEJECUTA("CSELART",""),OCULTO
#CAMPO=CODARTREAL,AUXILIAR,OCULTO,"_20_"
CAMPO=CODMATR,AUXILIAR,NOENTER,TITULO("Matricula"),INCLUDECSS="HEIGHT:46px;font-size:22pt;"
CAMPO=CANTINTREAL,AUXILIAR,TOOLTIP("Cantidad total después de inventariar, incluidas las rotas"),
               POSTCHANGE=FEJECUTA("CINSCONT",""),TITULO("Cantidad Real"),WLONX=15,INCLUDECSS="HEIGHT:46px;font-size:26pt;"

CURSOR=CINSCONT INSERT INTO VDINVENCONTEO (CANTREAL)
                   VALUES(:CANTINTREAL) WHERE CODMAT=:CODMATR AND CODARTREAL=:CODARTREAL;

CURSOR=CSELART SELECT :CODARTREAL FROM VDINVENCONTEO WHERE CODINVEN=:CODINVEN;


AJAX(BIN,"","C","","CSELLECTURA","CODMATR",50)
CURSOR=CSELLECTURA DECLARE
                     MITEXTO VARCHAR2(1024);
					 MIPUERTO NUMBER(1);
                   BEGIN
				     :V10EVAJAX:=0;
				     IF (VDUSER.GETHOSTNAME='W10-13826' OR VDUSER.GETHOSTNAME='ESC-95695')  THEN
                       MIPUERTO:=1;
                     ELSIF VDUSER.GETHOSTNAME='W10-13827' THEN
                       MIPUERTO:=2;
                     ELSIF VDUSER.GETHOSTNAME='W10-13828' THEN
                       MIPUERTO:=3;
			         ELSE MIPUERTO:=1;
                     END IF;

                     SELECT BINID INTO MITEXTO FROM ASTRESPONSE WHERE PUERTO=MIPUERTO AND ESTADO='O';

                     IF MITEXTO IS NOT NULL THEN
					   :V10EVAJAX:=3000;
					   :CODMATR:=MITEXTO;
                     ELSE
				       :V10EVAJAX:=0;
                     END IF;
                   END;@