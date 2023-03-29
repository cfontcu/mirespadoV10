# Módulo   : VDNUMSERIESFMD
# Función  : Números de serie asociados a bulto
#
###########################################
# Histórico de cambios:
NUMEROS DE SERIE ASOCIADOS A BULTO
Número de serie       Artículo                                       Lote              Bulto           QR                Acción           Motivo       Estado       Última modificación 
_60_________________  _40___________ _100__________________________  _40______________ _20____________ _250___________   _20_____________ _20_________ _20_________ _32________ ¿D-MM-Y.YY  ________
|
TABLA=VDNUMSERIESFMD
ORDERBY=FECMODIF DESC,HORAMODIF DESC,CODART,CODLOT;

NOINSERT
NOUPDATE
NODELETE

REGPAG=50
WLONX=1300

CAMPO=NUMEROSERIE,TOOLTIP("Número de serie"),TITULO("Número de serie")
CAMPO=CODART,TOOLTIP("Código del artículo"),POSTCHANGE=FDESIGNACION("CSELDESART","No existe el artículo"),TECLA=SF10,FEJECUTAFORM("VDARTIC","N","CODART=:CODART","","","","N"),TITULO("Artículo")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designación del artículo"),TITULO("Descripción")
CAMPO=CODLOT,TOOLTIP("Lote"),POSTCHANGE=FDESIGNACION("+CSELCODLOT","No existe el lote"),TECLA=SF10,FEJECUTAFORM("VDLOTES","N","CODART=:CODART AND CODLOT=:CODLOT","","","","N"),TITULO("Lote")
CAMPO=CODBULTO,TITULO("Bulto Asoc."), TOOLTIP("Bulto asociado")
CAMPO=CODBIDI,TITULO("QR"),TOOLTIP("Código QR leido")
CAMPO=ACCION,TOOLTIP("Acción realizada en el hub FMD"),TITULO("Acción")
CAMPO=MOTDECOM,TOOLTIP("Motivo asociado a la acción realizada"),TITULO("Motivo")
CAMPO=ESTADO,TOOLTIP("Estado del número de serie"),TITULO("Estado")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realizó la última modificación"),TITULO("Última modificación")
CAMPO=FECMODIF,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,TOOLTIP("Hora en que se modificaron los datos del registro")

#CURSORES
CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELCODLOT SELECT :CODLOT FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT;
