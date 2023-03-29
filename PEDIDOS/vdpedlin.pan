###################################################################
#M�dulo: VDPEDLIN.PAN
#Funcionalidad : Mantenimiento de l�neas de pedido
#Autor: RFD
#Fecha:26-03-2008
###################################################################
#Hist�rico de cambios:
LINEAS DE PEDIDO
Sec      Art�culo                        Caj  Pedida      A servir    Servida.    Status P B C M R Comentario Ultima modificaci�n           VDExtra
@L@@@@@@ _40_______ _40_________________ @L@@ #L#,###,### #L#,###,### #L#,###,### @L@@@  _ _ _ _ _ @L@@@@@@@   _32_______ �D-MM-YY ________  __250____
|

TABLA=VDPEDIDOLIN
ORDERBY=SEQLINEA;

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

PROTECT("SUPERVISOR")
#NODELETE
CAMPO=CODDIV,VIRTUAL,OCULTO
CAMPO=ANOPED,VIRTUAL,OCULTO
CAMPO=CODPED,VIRTUAL,OCULTO
CAMPO=SEQPED,VIRTUAL,OCULTO

CAMPO=SEQLINEA,TOOLTIP("N�mero secuencial de linea"),TITULO("N�L�nea")
CAMPO=CODART,UPPER,TOOLTIP("Es el C�digo del art�culo a servir"),TITULO("Art�culo"),
        POSTCHANGE=FDESIGNACION("CDESART","C�digo de art�culo no existe.")
CAMPO=DESART,AUXILIAR,UPPER,NOENTER,TITULO("Descripci�n")
CAMPO=CAJAS,AUXILIAR,NOENTER,TITULO("Cajas"),WLONX=20
CAMPO=CODLOT,UPPER,TOOLTIP("Es el lote del art�culo.\nSi viene informado se servir� dicho lote,\nen caso contrario el sistema decide el lote a servir."),TITULO("Lote"),OCULTO,"_20"
CAMPO=CADUCI,UPPER,TOOLTIP("Caducidad del lote servido"),TITULO("Caducidad"),WLONX=20,OCULTO,"_8"
CAMPO=UNIDADESHOST,TOOLTIP("Unidades, :UNIDADESHOST ,en que mide el host la cantidad pedida.\nEn la interfase de salida indicaremos\nla cantidad servida en las mismas unidades"),TITULO("Uni"),WLONX=10,OCULTO,"_10"
CAMPO=CANTPEDIDA,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),NOUPDATE,TOOLTIP("Cantidad pedida "),TITULO("Pedida")
CAMPO=CANTASERVIR,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),NOUPDATE,TOOLTIP("Cantidad a servir"),TITULO("A servir")
CAMPO=CANTSERVIDA,CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),TOOLTIP("Cantidad servida"),TITULO("Servida")
CAMPO=STATUS,TOOLTIP("Estado de la l�nea de pedido seg�n tabla de estados tipo LP"),TITULO("Estado"),WLONX=20
CAMPO=DESSTATUS,AUXILIAR,OCULTO,"_30_"
CAMPO=OPCIONPRECIO,TOOLTIP("Indicador de precio, que indica de d�nde se toma el precio.\nL=del campo PRECIOUNI de la l�nea.\nM=del campo PRECIOUNI del maestro de art�culos."),TITULO("P")
CAMPO=BACKORDER,TOOLTIP("Indicador de la pol�tica de preparaci�n de la l�nea.Puede ser 'E' Exacta se debe servir en su totalidad o 'P' puede servir parcial"),TITULO("B")
CAMPO=SWTCREAVERSION,TOOLTIP("Indica si debe crear otra versi�n del pedido con el resto de la l�nea.\nPuede ser,\nS=Crear versi�n con cantidad pendiente.\nN=No crea versi�n con resto"),TITULO("C")
CAMPO=MARCARPT,TOOLTIP("Indicador que permite poner una marca (p.e. un asterisco) para alguna aclaraci�n en cualquier report asociado al pedido"),TITULO("M")
CAMPO=TIPOREDONDEO,TOOLTIP("Tipo de redondeo. 'N' no existe redondeo, 'C' contenedor, 'E' cajas por exceso, 'D' cajas por defecto"),TITULO("R")
CAMPO=CODCOMEN,TOOLTIP("C�digo de los comentarios a la l�nea del pedido"),TITULO("Comen")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificacion")
CAMPO=VDEXTRA


CURSOR=CDESART SELECT DESART,UNIDADESHOST,FLOOR(:CANTPEDIDA/UNIEMB) CAJAS
                 FROM VDARTIC AR
                WHERE AR.CODART=:CODART;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


CONTEXTUAL=FLEEMENU("VDPEDLIN.ZOO")