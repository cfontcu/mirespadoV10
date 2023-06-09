CREACION DE INVENTARIOS

Designaci�n.   _40____________________________________________
Articulos(s).  _1024______________________________________________
Areas(s).      _1024______________________________________________
Ubiaciones(s). _1024______________________________________________
Alturas(s).    _1024______________________________________________
Matriculas(s). _1024______________________________________________
Sin movimientos _ Desde Fecha �D-MM-Y.YY
Porcentaje @L@ Prioridad @L@
|

NOORAINS
NOQUERY
NODELETE
NOUPDATE
TABLA=VDINVENCAB

PREINSERT=FEJECUTA("CPONDEFECTOS","",
                   "CINSINVEN","",
                   %FFAILURE,"INVENTARIO :CODINVEN CREADO")
                   
POSTCOMMIT=FEJECUTA("CBORRANULO","",FPULSATECLAS("F5"),"")                   

CAMPO=CODINVEN,OCULTO,"@L@@@@@@@"
CAMPO=DESINVEN
CAMPO=CODARTR,POSTCHANGE=PRESEHIJO
CAMPO=CODAREAR,POSTCHANGE=PRESEHIJO
CAMPO=CODUBIR,POSTCHANGE=PRESEHIJO
CAMPO=ALTURAR,POSTCHANGE=PRESEHIJO
CAMPO=CODMATR,POSTCHANGE=PRESEHIJO
CAMPO=SWTUBISINMOV
CAMPO=FECDESDEUBIINV
CAMPO=PUBIAINVEN
CAMPO=PRIOINVEN

CURSOR=CBORRANULO DELETE VDINVENCAB WHERE CODINVEN=:CODINVEN AND NOT EXISTS (SELECT CODINVEN FROM VDINVENCONTEO WHERE CODINVEN=:CODINVEN);

CURSOR=CPONDEFECTOS SELECT DECODE(:PUBIAINVEN,0,100,:PUBIAINVEN) PUBIAINVEN FROM DUAL;

CURSOR=CINSINVEN DECLARE
                   CURSOR C1 IS SELECT UBI.CODUBI
                                 FROM VDUBICA UBI,VDCONTE CNT,VDSTOCK STK,VDARTIC ART
                                 WHERE UBI.CODUBI=CNT.CODUBI(+) AND STK.CODMAT(+)=CNT.CODMAT AND ART.CODART(+)=STK.CODART AND 
                                       VD.CONTIENECAD(:CODARTR,STK.CODART)>0 AND VD.CONTIENECAD(:CODAREAR,UBI.CODAREA)>0 AND
                                       VD.CONTIENECAD(:CODUBIR,UBI.CODUBI)>0 AND VD.CONTIENECAD(:CODMATR,CNT.CODMAT)>0 AND
                                       VD.CONTIENENUM(:ALTURAR,UBI.ALTURA)>0 AND
                                       UBI.CODAREA NOT IN ('DEVOLUCION','DEFECTUOSO','RECEPCION','INTER','INTERDEV') AND UBI.TIPOUBI='R'
                                 GROUP BY UBI.CODUBI
                                 HAVING (SELECT COUNT( DISTINCT CODART) FROM VDSTOCK STK,VDCONTE CNT WHERE CNT.CODMAT=STK.CODMAT AND CNT.CODUBI=UBI.CODUBI)<200;
                   PROCESADAS NUMBER;
                   MISTATUSLIN NUMBER;
                   MISTATUSCAB NUMBER;
                 BEGIN
                    BEGIN
                       SELECT CODINVEN,STATUS INTO :CODINVEN,MISTATUSCAB FROM VDINVENCAB WHERE STATUS BETWEEN 50 AND 100 AND DESINVEN=:DESINVEN;
                       IF MISTATUSCAB=50 THEN MISTATUSLIN:=50;
                         ELSE MISTATUSLIN:=100;
                       END IF;
                       EXCEPTION WHEN NO_DATA_FOUND THEN
                          :CODINVEN:=VDSECINVEN.NEXTVAL;
                          MISTATUSLIN:=50;
                          MISTATUSCAB:=50;
                          INSERT INTO VDINVENCAB (CODINVEN, DATOSHOST, DESINVEN, CODDIVR, CODCLASE, CODCLASIFR, CODAREAR, CODUBIR,ALTURAR, CODMATR, CODARTR, CODLOTR, SWTUBISINMOV, 
                                           FECDESDEUBIINV, SWTUBIMARCADAS, PUBIAINVEN,STATUS, CODOPEINS, FECINS, HORAINS, CODOPEVAL, FECVAL,  HORAVAL, CODCOMEN, CODOPEMODIF, 
                                           FECMODIF, HORAMODIF, FECINTERF, HORAINTERF, TIPOINVEN, PRIOINVEN) 
                                   VALUES (:CODINVEN,'',:DESINVEN,'','','',:CODAREAR,:CODUBIR,:ALTURAR,:CODMATR,:CODARTR,'',:SWTUBISINMOV,
                                           :FECDESDEUBIINV,'N',:PUBIAINVEN,MISTATUSCAB,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS,'',0,'',0,VDUSER.GETUSER,
                                           VD.FECHASYS,VD.HORASYS,0,'','MANUAL',:PRIOINVEN);
                    END;
                  FOR I IN C1 LOOP
                      IF DBMS_RANDOM.VALUE(1,100)<=:PUBIAINVEN THEN
                          SMINVEN.INSERTAENINVEN(:CODINVEN,I.CODUBI,MISTATUSLIN);
                         ELSE
                          VDLOG.PONMENSAJE('PRUEBA','NO INSERTO');
                        END IF;
                   END LOOP;
                   SELECT COUNT(*) INTO PROCESADAS FROM VDINVENCONTEO WHERE CODINVEN=:CODINVEN;
                   IF PROCESADAS=0 THEN 
                       DELETE VDINVENCAB WHERE CODINVEN=:CODINVEN;
                       :CODINVEN:=0;
                    END IF; 
                END;@