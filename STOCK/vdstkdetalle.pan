STOCK EN DETALLE
 Art�culo             Designaci�n                           Lote       Caduci   Cantidad  Dispo     Bloqu     Inciden. Ubicaci�n    Matr�cula      Numero Serie      Marca           Inventario      Ref. Cli.  Observaciones
_4___ _40_________________ _40_____________________________ _20_______ ________ @L,@@@@@@ @L,@@@@@@ @L,@@@@@@ @L,@@@   _12_________ _20___________ _60______________ _60____________ _60______________ _40_______ _255______________________
|

SOLOQUERY
REGPAG=40
WLONY=650
WLONX=1200

SELECT=SELECT ART.CODDIV,ART.CODART,ART.CODARTDIV,ART.DESART,STK.CODLOT,
              STK.NUMEROSERIE,STK.MARCASTK,STK.BULTO,
              SUM(STK.CANTIDAD) CANTIDADSTK,
              SUM(DECODE(STK.BLOQUEOS,'0000000000',CANTIDAD,0)) DISPONIBLESTK,
              SUM(DECODE(STK.BLOQUEOS,'0000000000',0,CANTIDAD)) BLOQUEADOSTK,
              SUM(DECODE(SUBSTR(STK.BLOQUEOS,8,1),1,CANTIDAD,0)) INCIDENCIA,
              UBI.CODUBI,CNT.CODMAT,STK.ORDENSTK,STK.VDEXTRA,STK.CODRECEP
         FROM VDARTIC ART,VDSTOCK STK,VDCONTE CNT,VDUBICA UBI
        WHERE ART.CODART=STK.CODART AND STK.CODMAT=CNT.CODMAT AND CNT.CODUBI=UBI.CODUBI;
GROUPBY=ART.CODDIV,ART.CODART,ART.CODARTDIV,ART.DESART,STK.CODLOT,STK.NUMEROSERIE,STK.MARCASTK,STK.BULTO,UBI.CODUBI,CNT.CODMAT,STK.ORDENSTK,STK.VDEXTRA,STK.CODRECEP,CNT.CODUBI;

ORDERBY=CNT.CODUBI;

POSTQUERY=FEJECUTA("+CSELREFCLI","")



CAMPO=CODDIV,NOUPDATE,TITULO("Divis."),PREFIJO=ART,WLONX=10
CAMPO=CODART,NOUPDATE,TITULO("Art�culo"),PREFIJO=ART
#CAMPO=CODARTDIV,NOUPDATE,TITULO("Art�culo"),PREFIJO=ART
#CAMPO=CODART,OCULTO,"_40_"
CAMPO=CODARTDIV,OCULTO,"_40_"
CAMPO=DESART,NOUPDATE,TITULO("Descripci�n"),PREFIJO=ART
CAMPO=CODLOT,NOUPDATE,TITULO("Lote"),PREFIJO=STK,POSTCHANGE=FDESIGNACION("CSELCODLOT","No existe lote")
CAMPO=CADUCI,NOUPDATE,AUXILIAR,NOENTER,WLONX=20
CAMPO=CANTIDADSTK,NOENTER,TITULO("Cant.")
CAMPO=DISPONIBLESTK,NOENTER,TITULO("Dispo.")
CAMPO=BLOQUEADOSTK,NOENTER,TITULO("Bloq.")  
CAMPO=INCIDENCIA,NOENTER,TITULO("Incid."),TOOLTIP("Incidencia")          

CAMPO=CODUBI,NOUPDATE,TITULO("Ubicaci�n"),PREFIJO=CNT
CAMPO=CODMAT,NOUPDATE,TITULO("Matr�cula"),PREFIJO=CNT
CAMPO=NUMEROSERIE,NOUPDATE,TITULO("Numero serie"),PREFIJO=STK
CAMPO=MARCASTK,NOUPDATE,TITULO("Maqueta"),PREFIJO=STK
CAMPO=BULTO,NOUPDATE,TITULO("Inventario"),PREFIJO=STK
CAMPO=REFCLI,AUXILIAR,NOUPDATE,TITULO("Ref. Cli.")
CAMPO=ORDENSTK,AUXILIAR,OCULTO,"@@@@@@@"
CAMPO=CODRECEP,OCULTO,"_20_"
CAMPO=VDEXTRA,NOUPDATE,TITULO("Observaciones")


CURSOR=CSELCODLOT SELECT :CODLOT,CADUCI FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT;

CURSOR=CSELREFCLI SELECT ORC.CLAVEEXT REFCLI 
                    FROM VDORDRECCAB ORC,VDRECEPCAB REC
                   WHERE ORC.CODORDREC=REC.CODORDREC AND REC.CODRECEP=:CODRECEP;

CURSOR=CLISTADIV SELECT CODDIV,DESDIV,DESEMP FROM VDDIVIS DIV,VDEMPRE EMP WHERE EMP.CODEMP=DIV.CODEMP AND DIV.ACTIVA='S' AND DIV.CODDIV IN (SELECT ART.CODDIV FROM VDARTIC ART,VDSTOCK STK WHERE STK.CODART=ART.CODART) ORDER BY DIV.CODDIV;


CONTEXTUAL=FLEEMENU("VDARTIC.ZOO")

TECLA=SF9,FEJECUTAFORM("VDREGULARIZASTK","S","CODMAT=:CODMAT AND ORDENSTK=:ORDENSTK","","","REGULARIZACIONES DE STOCK","S")

ONLINE={May+F9} Regularizar;