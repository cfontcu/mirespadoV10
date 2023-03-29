###################################################################
#M�dulo: VDBULLINPINV.PAN
#Funcionalidad : Mantenimiento de l�neas de bultos de picking inverso
#Autor: Maite Gonz�lez      
#Fecha: 03-06-2008
###################################################################
# Hist�rico de cambios:
MANTENIMIENTO DE MOVIMIENTOS DEL BULTO DE PICKING INVERSO
Mov.      Art�culo                           Lote             Cantidad       Estado                  Fecha Preparaci�n            Ultima modificaci�n              Comentario
@L@@@@@@@ _40__________ _100________________ _40_____________ #L#,###,###.## @L@@@ _30______________ _32____  �D-MM-YY.Y ________ _32________  �D-MM-YY.Y ________ @@@@ 
|
TABLA=VDMOVIM


PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")


ORDERBY=CODMOV;

CAMPO=CODBULTOORI,VIRTUAL("CODBULTO"),OCULTO
CAMPO=CODMOV,NOUPDATE,TOOLTIP("Secuencial de l�nea en el bulto"),TITULO("L�nea")
CAMPO=CODART,NOUPDATE,UPPER,POSTCHANGE=FDESIGNACION("CDESART","C�digo de art�culo no existe."),TOOLTIP("C�digo del art�culo"),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,UPPER,NOENTER,TOOLTIP("Descripci�n del art�culo")
CAMPO=CODLOT,NOUPDATE,TOOLTIP("Lote del art�culo servido contenido en el bulto"),TITULO("Lote")
CAMPO=CANTIDAD,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),NOUPDATE,TOOLTIP("Cantidad"),TITULO("Cantidad")
CAMPO=STATUS,TOOLTIP("Estado de la l�nea de bulto.\n :DESSTATUS"),POSTCHANGE=FDESIGNACION("CSELSTATUS","Estado no existe"),TITULO("Estado")
CAMPO=DESSTATUS,UPPER,AUXILIAR,NOUPDATE,TOOLTIP("Descripci�n del estado")
CAMPO=CODOPEEJEMOV,NOENTER,TOOLTIP("Operario que prepara la l�nea")
CAMPO=FECINIMOV,NOENTER,TOOLTIP("Fecha de la preparaci�n"),TITULO("Fecha preparaci�n")
CAMPO=HORAINIMOV,NOENTER,TOOLTIP("Hora de la preparaci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")
CAMPO=CODCOMEN,NOUPDATE,TOOLTIP("C�digo de los comentarios a la l�nea del bulto"),TITULO("Comen")

CURSOR=CSELMOV SELECT CODMOV FROM VDMOVIM WHERE CODMOV=:CODMOV AND :STATUS<>VDST.FBPLANULADA;

CURSOR=CSELCODBULTO SELECT CODBULTO CODBULTOCLI FROM VDBULTOLIN WHERE CODMOV=:CODMOV;

CURSOR=CDESART SELECT DESART
                 FROM VDARTIC
                WHERE CODART=:CODART;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='MOV';
 
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;






