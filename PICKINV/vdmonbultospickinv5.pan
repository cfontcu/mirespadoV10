###################################################################
#M�dulo: VDMONBULTOSPICKINV5.PAN
#Funcionalidad : Monitor de bultos de picking inverso, movtos de la l�nea de bulto 
#Autor: FGS   
#Fecha: 24-06-2008
###################################################################
# Hist�rico de cambios:
MANTENIMIENTO DE CABECERAS DE BULTO


 C�digo : _18_______________   Matr�cula Asoc.:  _18_______________  
 
 Cant.Total: #L####### Resto: #L####### Capac.Caja: #L####### CajaCompleta: _
 
 Estado: @L@@@@ _30________________________   Prepicking: _ 
 
 Fecha de creaci�n:     �D-MM-YY.Y ________
 Fecha de finalizaci�n: �D-MM-YY.Y ________        
 Ult. Modif.: _32_______ �D-MM-YY.Y ________   Comentario:@L@@@@@@@
 Informaci�n: _255____________________________________________________________
|

TABLA=VDBULTOCABPINV

PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")


CAMPO=CODBULTO,NOUPDATE,POSTCHANGE=FDESIGNACION("CSELCODART","","+CSELUNIEMB","","+CCANTIDAD","","+CRESTOS",""),TOOLTIP("C�digo del bulto. N�mero �nico que lo identifica")
CAMPO=CODART,AUXILIAR,OCULTO,"_40________"
CAMPO=CODMAT,PROTECT("IMPLANTADOR"),TOOLTIP("Matr�cula asociada al bulto de picking inverso")
CAMPO=CANTIDAD,NOENTER,AUXILIAR,TOOLTIP("Cantidad Total que se mueve en el bulto"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=RESTO,NOENTER,AUXILIAR,TOOLTIP("Cantidad de Resto que se mueve en el bulto"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=UNIEMB,NOENTER,AUXILIAR,TOOLTIP("Cantidad de la caja al completo"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=CAJACOMPLETA,NOENTER,TOOLTIP("Si la caja se sirve en su totalidad para el picking inverso, o solo una parte de la misma")
CAMPO=STATUS,PROTECT("IMPLANTADOR"),TOOLTIP("Estado del bulto seg�n tabla de estados tipo BUC"),POSTCHANGE=FDESIGNACION("CSELSTATUS","Estado no existe")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado del bulto seg�n tabla de estados tipo BUC")
CAMPO=PREPICKING,AUXILIAR,NOENTER,TOOLTIP("Si el articulo se sirve con prepicking o no")
CAMPO=FECCREADO,NOENTER,TOOLTIP("Fecha en que cre� el bulto")
CAMPO=HORACREADO,NOENTER,TOOLTIP("Hora en que creo el bulto")
CAMPO=FECFINALIZA,NOENTER,TOOLTIP("Fecha en que se finaliz� el bulto")
CAMPO=HORAFINALIZA,NOENTER,TOOLTIP("Hora en que se finaliz� el bulto")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que realiza la Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,UPPER,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")
CAMPO=CODCOMEN,NOUPDATE,TOOLTIP("C�digo de los comentarios a la cabecera del bulto")
CAMPO=VDEXTRA,PROTECT("SUPALMACEN"),TOOLTIP("Datos adicionales externos a V10")

CURSOR=CSELCODART SELECT ART.CODART,DECODE(PICKINV,'P','S','N') PREPICKING FROM VDBULTOLINPINV BPL, VDARTIC ART WHERE CODBULTO=:CODBULTO AND BPL.CODART=ART.CODART ; 

CURSOR=CSELUNIEMB SELECT UNIEMB FROM VDBULTOLINPINV BPL, VDMOVIM MOV 
                     WHERE BPL.CODMOV=MOV.CODMOV AND BPL.CODBULTO=:CODBULTO;

CURSOR=CCANTIDAD SELECT SUM(CANTPEDIDA) CANTIDAD FROM VDBULTOLINPINV WHERE CODBULTO=:CODBULTO;

CURSOR=CRESTOS SELECT SUM(CANTPEDIDA) RESTO FROM VDBULTOLINPINV BPL WHERE  BPL.CODBULTO=:CODBULTO  AND STATUS= VDST.FBPLRESTOS;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMOD
IF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='BPC';


TECLA=F12,FEJECUTA(FIMPRIMEBULTO("ETIQ","VDBULTO.ZPL;VDPRUEBABU.VSQ;CSELPRUEBABU","CODBULTO=:CODBULTO",""),":V10ERROR")

 



