#*****************************************************************
#M�dulo: VDRECMAT.PAN
#Funci�n: 
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
DESCRIPCION DE LAS MATRICULAS DONDE SE HA RECEPCIONADO

Matr�cula          Tipo contenedor           Ubicaci�n   Area      Altura    Estado   Fecha entrada       Ultima modificaci�n              
_18_______________ _10_______ _40___________ _20______ _10______  ######### ######### �D-MM-Y.YYY _8______ _32_________ �D-MM-Y.YY ________
|

SOLOQUERY
SELECT=SELECT DISTINCT CNT.CODMAT, CNT.TIPOCONTE, CNT.CNTSSCC, CNT.CODUBI, CNT.ALTURACONTE, CNT.STATUS,
                       CNT.FECENTRADA, CNT.HORAENTRADA, CNT.CODCOMEN, CNT.CODOPEMODIF, CNT.FECMODIF, CNT.HORAMODIF,
                       CNT.VDEXTRA
         FROM VDCONTE CNT, VDSTOCK STK
        WHERE STK.CODRECEP  = :CODRECEP
          AND STK.CODMAT    = CNT.CODMAT
          AND STK.CODART=:CODART AND STK.CODLOT=:CODLOT;
ORDERBY= CODMAT;


CAMPO=CODRECEP,VIRTUAL,OCULTO
CAMPO=CODORDREC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=TIPORDREC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODDIV,VIRTUAL,AUXILIAR,OCULTO
CAMPO=SECLINREC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODART,VIRTUAL,OCULTO
CAMPO=CODLOT,VIRTUAL,OCULTO
CAMPO=CODMAT,TOOLTIP("Matr�cula del contenedor"),TITULO("Matr�cula")
CAMPO=TIPOCONTE,POSTCHANGE=FDESIGNACION("CSELVDTIPOCONTEDESTIPOCONTE","ERROR AL EJECUTAR CURSOR CSELVDTIPOCONTEDESTIPOCONTE"),TOOLTIP("Tipo del contenedor"),TITULO("Tipo Contenedor")
CAMPO=DESTIPOCONTE,NOENTER,AUXILIAR,TOOLTIP("Descripci�n del tipo de contenedor")
CAMPO=CNTSSCC,OCULTO,"_20_",TOOLTIP("C�digo seriado de env�o para bultos paletizados")
CAMPO=CODUBI,POSTCHANGE=FDESIGNACION("CSELVDUBICACODAREA","ERROR AL EJECUTAR CURSOR CSELVDUBICACODAREA"),TOOLTIP("Ubicaci�n del contenedor"),TITULO("Ubicaci�n"),WLONX=25
CAMPO=CODAREA,NOENTER,AUXILIAR,TOOLTIP("Es el C�digo del �rea en la que est� la ubicaci�n"),TITULO("Area")
#CAMPO=POSCONTE,TOOLTIP("Posici�n del contenedor dentro de la ubicaci�n")
CAMPO=ALTURACONTE,TOOLTIP("Altura real de contenedor"),TITULO("Altura")
CAMPO=STATUS,TOOLTIP("Indica si el contenedor est� en situaci�n de ser reubicado (0) o (distinto de 0) se ha detectado alg�n error de compatibilidad o flujo"),TITULO("Estado")
CAMPO=FECENTRADA,TOOLTIP("Fecha en la que se realiza la entrada, �til para FIFO"),TITULO("Fecha entrada")
CAMPO=HORAENTRADA,TOOLTIP("Hora en la que se realiza la entrada, �til para FIFO")
CAMPO=VDEXTRA,OCULTO,"_255_",TOOLTIP("Datos adicionales �tiles para el cliente")
CAMPO=CODCOMEN,OCULTO,"#########",TOOLTIP("")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"

CURSOR=CSELVDTIPOCONTEDESTIPOCONTE SELECT DESTIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE;
CURSOR=CSELVDUBICACODAREA SELECT CODAREA FROM VDUBICA WHERE CODUBI=:CODUBI;

TECLA=SF2,FEJECUTA("CCREAMOVANUL","ERROR CREANDO MOVIMIENTO Y ACTUALIZANDO LINEAS DE RECEPCION\n ASOCIADAS A LA MATRICULA :CODMAT",
                   FIF("CSELMOVS", FEJECUTA(FWHILE(FERRORCURSOR("CSELMOVS"),                                                                                                                 
                                                    FEJECUTA(FEJECUTAMOVSYNC("ACTSTKORIGEN","ACTSTKDESTINO",":CODMOV",""),"\n ERROR\n\n :V10ERROR\n EJECUTANDO MOVIMIENTO",
                                                            +FFETCHCURSOR("CSELMOVS"),"ERROR EN FETCH")),"ERROR EN FWHILE")),"ERROR EN FIF",
                   FCOMMIT,"",
                   FFAILURE," ANULADA MATRICULA :CODMAT DE LA RECEPCION :CODRECEP ",
                   FPULSATECLAS("F5"),"")                
  
CURSOR=CCREAMOVANUL DECLARE
                     CURSOR C1 IS
                          SELECT STK.CODART, STK.CODLOT, STK.UNIEMB, STK.CANTIDAD, STK.BLOQUEOS
                            FROM VDSTOCK STK
                           WHERE STK.CODMAT   = :CODMAT;
                     BEGIN
                        FOR I IN C1 LOOP
                            IF I.CANTIDAD > 0 THEN
                               :CODMOV := 0;
                               VDMOV.CREAMOV (:CODMOV, VD.GETPROP('TAREARECEP'), VD.GETPROP('REGULARIZA-'), VDST.FMOVRECOGIDO, :CODMAT, 'REGULARIZA', :CODMAT, 
                                              I.CODART, I.CODLOT,I.UNIEMB,'',I.CANTIDAD,0,0, NULL);
                               IF :CODMOV > 0 THEN
                                   UPDATE VDMOVIM
                                     SET CODRECEP = :CODRECEP
                                   WHERE CODMOV   = :CODMOV;
                                  UPDATE VDRECEPLIN
                                     SET CANTIDADR = (CANTIDADR - I.CANTIDAD),
                                         CODOPEMODIF = VDUSER.GETUSER, FECMODIF = VD.FECHASYS, HORAMODIF = VD.HORASYS 
                                   WHERE CODRECEP  = :CODRECEP
                                     AND CODDIV    = :CODDIV
                                     AND CODART    = I.CODART
                                     AND CODLOT    = I.CODLOT
                                    AND BLOQSTOCK = I.BLOQUEOS;
                               ELSE
                                 RAISE NO_DATA_FOUND;
                               END IF;
                            ELSE
                               RAISE NO_DATA_FOUND;
                            END IF;
                       END LOOP;
                     END;@

CURSOR=CSELMOVS SELECT CODMOV
                  FROM VDMOVIM
                 WHERE CODRECEP  = :CODRECEP
                   AND CODMATORI = :CODMAT
                   AND STATUS    = VDST.FMOVRECOGIDO;


