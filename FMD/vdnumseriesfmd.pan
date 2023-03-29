# M�dulo   : VDNUMSERIESFMD
# Funci�n  : N�meros de serie asociados a bulto
#
###########################################
# Hist�rico de cambios:
NUMEROS DE SERIE ASOCIADOS A BULTO
N�mero de serie       Art�culo                                       Lote              Bulto           QR                Acci�n           Motivo       Estado       �ltima modificaci�n 
_60_________________  _40___________ _100__________________________  _40______________ _20____________ _250___________   _20_____________ _20_________ _20_________ _32________ �D-MM-Y.YY  ________
|
TABLA=VDNUMSERIESFMD
ORDERBY=FECMODIF DESC,HORAMODIF DESC,CODART,CODLOT;

NOINSERT
NOUPDATE
NODELETE

REGPAG=50
WLONX=1300

CAMPO=NUMEROSERIE,TOOLTIP("N�mero de serie"),TITULO("N�mero de serie")
CAMPO=CODART,TOOLTIP("C�digo del art�culo"),POSTCHANGE=FDESIGNACION("CSELDESART","No existe el art�culo"),TECLA=SF10,FEJECUTAFORM("VDARTIC","N","CODART=:CODART","","","","N"),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo"),TITULO("Descripci�n")
CAMPO=CODLOT,TOOLTIP("Lote"),POSTCHANGE=FDESIGNACION("+CSELCODLOT","No existe el lote"),TECLA=SF10,FEJECUTAFORM("VDLOTES","N","CODART=:CODART AND CODLOT=:CODLOT","","","","N"),TITULO("Lote")
CAMPO=CODBULTO,TITULO("Bulto Asoc."), TOOLTIP("Bulto asociado")
CAMPO=CODBIDI,TITULO("QR"),TOOLTIP("C�digo QR leido")
CAMPO=ACCION,TOOLTIP("Acci�n realizada en el hub FMD"),TITULO("Acci�n")
CAMPO=MOTDECOM,TOOLTIP("Motivo asociado a la acci�n realizada"),TITULO("Motivo")
CAMPO=ESTADO,TOOLTIP("Estado del n�mero de serie"),TITULO("Estado")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("�ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,TOOLTIP("Hora en que se modificaron los datos del registro")

#CURSORES
CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELCODLOT SELECT :CODLOT FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT;
