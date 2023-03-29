#ASIGNACION DE UBIACIONES DE PICKING
UBICACIONES DE PU
 Ubicación  Area  Max.     Urg.     Stock     Res.   Ord.   Z.  B
 _20_______ _20__ @,L@@@@@ @L,@@@@@ @L,@@@@@@ @L,@@@ @L,@@@ @L@ _
|
TABLA=VDUBICA
NOORAINS
NODELETE
SELECT=VDUBI.UBIRESERVADO(CODUBI,'U',NULL,NULL,1) RESERVA,VDUBI.UBIORDENADO(CODUBI,'U',1) ORDENADA;
WHERE=CODAREA LIKE 'PU%' AND CODUBI IN ((SELECT CODUBI FROM VDSTOCK STK,VDCONTE CNT WHERE STK.CODMAT=CNT.CODMAT AND STK.CODART=:CODARTSTK)
                                                UNION
                                             (SELECT CODUBIDEST FROM VDMOVIM WHERE CODART=:CODARTSTK AND STATUS<VDST.FMOVACTUALIZA)
                                                UNION
                                              (SELECT CODUBI FROM VDUBICA WHERE CODART=:CODARTSTK)) AND
      STOCK='S';
POSTQUERY=FDESIGNACION("CSELSTOCK","No puedo calcular el stock")
PREINSERT=FEJECUTA("CVERNOUSADA","Ubicacion con articulo",
                   "CVERPU","Ubicacion no es de picking","CSELUNICAJ","",
                   "CUPDAUBI","No puedo actualizar la ubicacion",
                   "CSELROWID","No existe rowid",FPULSATECLAS("F3","F2"),"")

PREUPDATE=FEJECUTA("CSELUNICAJ","")

CURSOR=CSELUNICAJ SELECT UNIEMB FROM VDARTIC WHERE CODART=:CODART;


CAMPO=CODARTSTK,AUXILIAR,VIRTUAL("CODART"),OCULTO
CAMPO=CODUBI,NOUPDATE,
             TECLA=SF10,FEJECUTA(FEJECUTAFORM("VDLISTAUBI","N","CODAREA LIKE 'PU%' AND CODART IS NULL",
                                              "","CODUBI=:CODUBI CODAREA=:CODAREA CODZONA=:CODZONA BLOQUEOSE=:BLOQUEOSE"),""),
             TITULO("Ubicación")
#             TECLA=SF10,FEJECUTA(FEJECUTAFORM("VDLISTAUBI","N","CODAREA LIKE 'PU%' AND CODART IS NULL AND NOT EXISTS (SELECT STK.CODMAT FROM VDCONTE CNT,VDSTOCK STK WHERE STK.CODMAT=CNT.CODMAT AND CNT.CODUBI=VDUBICA.CODUBI)",
#                                              "","CODUBI=:CODUBI CODAREA=:CODAREA CODZONA=:CODZONA BLOQUEOSE=:BLOQUEOSE"),"",
#                                 "CSELSTKMAX",""),
#             TITULO("Ubicación")
CAMPO=CODAREA,NOUPDATE,TITULO("Area"),WLONX=5
CAMPO=STKMAX,TITULO("Max")
CAMPO=STKMIN,OCULTO,"@L@@@"
CAMPO=STKURG,TITULO("Min")
CAMPO=TOTAL,AUXILIAR,NOENTER,TITULO("Stock")
CAMPO=RESERVA,NOENTER,AUXILIAR,TITULO("Res.")
CAMPO=ORDENADA,NOENTER,AUXILIAR,TITULO("Rep.")
CAMPO=CODZONA,NOUPDATE,TITULO("Zona")
CAMPO=BLOQUEOSE,UPPER,POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),TITULO("B"),CHECKBOX("N","S")
CAMPO=UNIEMB,AUXILIAR,OCULTO,NOUPDATE,"@L@@@"


CURSOR=CSELROWID SELECT ROWID MIROWID FROM VDUBICA WHERE CODUBI=:CODUBI;

CURSOR=CSELSTOCK SELECT SUM(CANTIDAD) TOTAL FROM VDSTOCK WHERE CODMAT IN (SELECT CODMAT FROM VDCONTE WHERE CODUBI=:CODUBI);

CURSOR=CSELSTKMAX SELECT DECODE(:STKMAX,0,ROUND(STKMAX*ART.UNIEMB),:STKMAX) STKMAX,DECODE(:STKURG,0,ROUND(STKURG*ART.UNIEMB),:STKURG) STKURG
                   FROM SMUBICAPAC CPC,VDARTIC ART
                   WHERE ART.CODART=:CODART AND (ART.CODART=CPC.CODART OR ART.TIPOCAJC=CPC.CODART) AND 
                    CLASEUBI IN (SELECT CODCLASE FROM VDCLASEUBI WHERE CODUBI=:CODUBI AND CODCLASIF='CLASEUBI')  
				   ORDER BY DECODE(ART.CODART,CPC.CODART,0,1);

CURSOR=CVERNOUSADA SELECT CODUBI FROM VDUBICA UBI WHERE NVL(CODART,'-')='-' AND CODUBI=:CODUBI AND NOT EXISTS(SELECT CODART FROM VDSTOCK STK,VDCONTE CNT WHERE CNT.CODMAT=STK.CODMAT AND CNT.CODUBI=UBI.CODUBI);

CURSOR=CVERPU SELECT CODUBI FROM VDUBICA WHERE CODUBI=:CODUBI AND CODAREA LIKE 'PU%';

CURSOR=CUPDAUBI UPDATE VDUBICA SET CODART=:CODART,RECARGAR='S',BLOQUEOSE=NVL(:BLOQUEOSE,'N'),STKMAX=:STKMAX,STKURG=:STKURG
                 WHERE CODUBI=:CODUBI;

TECLA=SF10,FEJECUTA(FEJECUTAFORM("VDUBICA","S","CODUBI=:CODUBI"),"",FRELOADREG,"")

ONLINE=             {May-F10} Consulta ubicaciones libres                        {Esc} Salir;