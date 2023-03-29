#*****************************************************************
#M�dulo: VDRECLIN.PAN
#Funcionalidad : Consulta de las l�neas de recepci�n
#Autor: ICC
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
LINEAS DE RECEPCION
RECEPCION  L�neaREc  OrdenAso     LinOrdAso  Div.  Art�culo                                     Lote            Caduci   Bloq. stock Cant. recep Muest. Ultima modificaci�n              Observaciones
@@@@@@@@@@ @L@@@@@@@ _20_________ @@@@@@@@@@ _20__ _40_____________ _100_______________________ _40____________ _8______ _10_______  @L,@@@@@@@@   _    _32_________ �D-MM-Y.YY ________ _60_________________________________________________________ 
|
NOINSERT
WLONX = 1400

TABLA=VDRECEPLIN

CAMPO=CODRECEP,NOENTER,TITULO("Recepci�n"), TOOLTIP("N�mero de recepci�n dentro de la misma orden de recepci�n")
CAMPO=SECLINREC,NOENTER,TOOLTIP("Secuencia de l�nea de recepci�n dentro de la propia recepci�n "),TITULO("L�nea Rec.")
CAMPO=CODORDREC,VIRTUAL,NOENTER,TITULO("Orden Aso."),TOOLTIP("Orden de recepci�n/Compra Asociada")
CAMPO=SECLINORD,NOENTER, TITULO("Lin.Ord.Aso"),TOOLTIP("Linea de la orden de recepci�n/Compra asociada")
CAMPO=CODDIV,NOENTER,TOOLTIP("C�digo de la divisi�n"),TITULO("Divisi�n"),WLONX=26
CAMPO=CODART,NOENTER,TOOLTIP("C�digo de art�culo"),TITULO("Art�culo"),POSTCHANGE=FEJECUTA("CDESART","ERROR CONSULTANDO LA DESCRIPCION DEL ARTICULO")
CAMPO=DESART,NOENTER,AUXILIAR,TOOLTIP("Descripci�n de art�culo"),TITULO("Art�culo")
CAMPO=CODLOT,NOENTER,TOOLTIP("Lote"),TITULO("Lote"),WLONX=-10
CAMPO=CADUCI,TOOLTIP("Caducidad en formato AAAAMMDD"),TITULO("Caduci"),WLONX=15
CAMPO=BLOQSTOCK,NOENTER,TOOLTIP("Bloqueos con los que entra el stock"),TITULO("Bloq.stock"),WLONX=20
CAMPO=CANTIDADR,NOENTER,TOOLTIP("Cantidad recibida en esta recepci�n en registro burocratico por pantalla de PC"),TITULO("Cant. recep.")
CAMPO=CODCOMEN,NOENTER,OCULTO,"#########",TOOLTIP("")
CAMPO=MUESTREADO,NOENTER,TOOLTIP("Indica si se ha muestreado ese lote"),TITULO("Muestreado"),WLONX=70
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=OBSERVACION1,TOOLTIP("Observaciones a la l�nea de recepci�n"),TITULO("Observaciones")

CURSOR=CDESART SELECT DESART
                 FROM VDARTIC
                WHERE CODART = :CODART;
               
CONTEXTUAL=FLEEMENU("VDRECEPLIN.ZOO")                