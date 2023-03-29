#*****************************************************************
#Módulo: RECEPSINVOL.PAN
#Función : Muestra articulos recepcionados en estado 25 sin volumetria
#Autor: Carmen Fontcuberta     
#Fecha: 04-01-2023
#******************************************************************
#*****************************************************************
#* Histórico de cambios
# ====================  TO_CHAR(SYSDATE,'YYYYMMDD')

ARTICULOS RECEPCIONADOS SIN VOLUMETRIA

 Artículo                                             Lote                  Caducidad  
 _40___________ _100_________________________________ _40_________________  _________  
|

REGPAG=25
WLONY=300
WLONX=1600

SOLOQUERY
SELECT=SELECT CAB.CODORDREC,CAB.CODDIV,LIN.CODART,LIN.CODLOT,LIN.CADUCI,LIN.SECLINORD
        FROM VDORDRECCAB CAB, VDORDRECLIN LIN  WHERE CAB.CODORDREC = LIN.CODORDREC
        AND CAB.CODDIV = LIN.CODDIV 
        AND CAB.STATUS= 25;
        
#GROUPBY= LIN.SECLINORD, LIN.CODART, LIN.CODLOT, LIN.CADUCI;
ORDERBY=LIN.CODART;


CAMPO=CODORDREC,AUXILIAR,OCULTO,"_20_____"
CAMPO=CODDIV,AUXILIAR,OCULTO,"_20___"
CAMPO=CODART,TOOLTIP("Código de artículo"),POSTCHANGE=FEJECUTA("CDESART","ERROR CONSULTANDO LA DESCRIPCION DEL ARTICULO"),TITULO("Artículo")
CAMPO=DESART,TOOLTIP("Descripción del artículo")
CAMPO=CODLOT,TOOLTIP("Lote"),TITULO("Lote")
CAMPO=CADUCI,TOOLTIP("Caducidad"),TITULO("Caducidad")
CAMPO=SECLINORD,OCULTO,"@@@@@@@@"


CURSOR=CDESART SELECT DESART
                 FROM VDARTIC
                WHERE CODART = :CODART;


CONTEXTUAL=FEJECUTAFORM("VDARTIC","S","CODART=:CODART")REGPAG=25
