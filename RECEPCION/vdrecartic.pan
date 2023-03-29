#*****************************************************************
#M�dulo: VDRECARTIC.PAN
#Funci�n : muestra los art�culos recepcionados
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
ARTICULOS RECEPCIONADOS

 Art�culo                                             Lote                  Caducidad  Cantidad recep.   Cant.regularizada Cantidad final
 _40___________ _100_________________________________ _40_________________  _________  ################# ################# #################
|

SOLOQUERY
SELECT=SELECT SECLINREC, CODART, CODLOT, CADUCI, SUM(CANTIDADR) CANTIDADR
         FROM VDRECEPLIN;
GROUPBY= SECLINREC, CODART, CODLOT, CADUCI;
ORDERBY=CODART;

POSTQUERY=FDESIGNACION("+CCALCULAREG","Error calculando regularizaci�nes",
                       "CTOTAL","Error calculando total")


CAMPO=CODORDREC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=TIPORDREC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODDIV,VIRTUAL,AUXILIAR,OCULTO

CAMPO=CODRECEP,VIRTUAL,OCULTO,TOOLTIP("N�mero de recepci�n dentro de la misma orden de recepci�n")
CAMPO=CODART,TOOLTIP("C�digo de art�culo"),POSTCHANGE=FEJECUTA("CDESART","ERROR CONSULTANDO LA DESCRIPCION DEL ARTICULO"),TITULO("Art�culo")
CAMPO=DESART,TOOLTIP("Descripci�n del art�culo")
CAMPO=CODLOT,TOOLTIP("Lote"),TITULO("Lote")
CAMPO=CADUCI,TOOLTIP("Caducidad"),TITULO("Caducidad")
CAMPO=CANTIDADR,TOOLTIP("Cantidad recibida en esta recepci�n, incluidas las muestras si las hubiese"),TITULO("Cantidad")
CAMPO=CANTIDADREG,AUXILIAR,NOENTER,TOOLTIP("Cantidad regularizada"),TITULO("Cant. regularizada")
CAMPO=CANTIDADFIN,AUXILIAR,NOENTER,TOOLTIP("Cantidad tras regularizazci�n"),TITULO("Cant. final")
CAMPO=SECLINREC,OCULTO,"@@@@@@@@"


CURSOR=CDESART SELECT DESART
                 FROM VDARTIC
                WHERE CODART = :CODART;

CURSOR=CCALCULAREG SELECT SUM(DECODE(MOV.CODCONCE,'REGENT+',MOV.CANTIDAD,MOV.CANTIDAD*-1)) CANTIDADREG
                      FROM VDMOVIM MOV
                    WHERE MOV.CODCONCE IN ('REGENT+','REGENT-')
                    AND MOV.CODRECEP = :CODRECEP
                    AND MOV.CODART = :CODART AND MOV.CODLOT=:CODLOT
                    AND STATUS BETWEEN 0 AND 7000;

CURSOR=CTOTAL SELECT :CANTIDADR + :CANTIDADREG CANTIDADFIN FROM DUAL;

CONTEXTUAL=FEJECUTAFORM("VDARTIC","S","CODART=:CODART")