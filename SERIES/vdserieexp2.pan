###################################################################
#M�dulo: VDSERIEEXP2.PAN
#Funcionalidad : Mantenimiento de series de expedici�n
#Autor: FGS      
#Fecha: 03-09-2008
###################################################################
# Hist�rico de cambios:
DETALLES DE LA SERIE
Pedidos: @L@@@@@ Bultos: @L@@@@ 

Unid   : @@@,@@@ Emb  : @@@,@@@ Cnt: @@@ 

Total Unidades: #L#,###,###

Lanzamiento: _32_____ �D-MM-Y.YY ________

Terminaci�n:          �D-MM-Y.YY ________ 

Expedici�n:           �D-MM-Y.YY ________

Ult. Modif: _32_____ �D-MM-Y.YY ________ 
|

TABLA=VDSERIEEXP

POSTQUERY=FEJECUTA("CCUENTABUL","ERROR OBTENIENDO NUMERO DE BULTOS","CCUENTAPED","","CCUENTAUNID","","CSELDATOS","")


CAMPO=CODSERIEEXP,VIRTUAL,OCULTO
CAMPO=NUMPED,AUXILIAR,NOENTER
CAMPO=BULTOS,AUXILIAR,NOENTER,TOOLTIP("N�mero total de bultos que componen la serie")
CAMPO=NUMBULUNI,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades aproximados del pedido")
CAMPO=NUMBULEMBA,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades aproximados del pedido")
CAMPO=NUMBULPAL,AUXILIAR,NOENTER,TOOLTIP("N�mero de bultos de unidades aproximados del pedido")
CAMPO=UNIDADES,AUXILIAR,NOENTER
CAMPO=CODOPELANZA,NOENTER,TOOLTIP("Operario que lanza la serie")
CAMPO=FECLANZA,NOENTER,TOOLTIP("Fecha de lanzamiento de la serie")
CAMPO=HORALANZA,NOENTER,TOOLTIP("Hora de lanzamiento de la serie")
CAMPO=FECTERMIN,NOENTER,TOOLTIP("Fecha de terminaci�n de la serie")
CAMPO=HORATERMIN,NOENTER,TOOLTIP("Hora de terminaci�n de la serie")
CAMPO=FECEXPIDE,TOOLTIP("Fecha de expedici�n de la serie")
CAMPO=HORAEXPIDE,TOOLTIP("Hora de expedici�n de la serie")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro.")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro.")

CURSOR=CCUENTABUL SELECT COUNT(*) BULTOS
                    FROM VDBULTOCAB BUC,VDPEDIDOCAB PEC
                   WHERE PEC.CODDIV=BUC.CODDIV AND PEC.ANOPED=BUC.ANOPED AND
                         PEC.CODPED=BUC.CODPED AND PEC.SEQPED=BUC.SEQPED AND
                         PEC.CODSERIEEXP=:CODSERIEEXP;

CURSOR=CCUENTAPED SELECT COUNT(*) NUMPED
                    FROM VDPEDIDOCAB PEC
                   WHERE PEC.CODSERIEEXP=:CODSERIEEXP;

CURSOR=CCUENTAUNID SELECT SUM(CANTSERVIDA) UNIDADES FROM VDPEDIDOLIN PEL, VDPEDIDOCAB PEC 
                          WHERE PEC.CODSERIEEXP=:CODSERIEEXP
                          AND PEC.CODDIV=PEL.CODDIV AND PEC.ANOPED=PEL.ANOPED AND
                         PEC.CODPED=PEL.CODPED AND PEC.SEQPED=PEL.SEQPED;
                         

CURSOR=CSELDATOS SELECT SUM(DECODE(TIPOBULTO,'U',1,0)) NUMBULUNI,
                            SUM(DECODE(TIPOBULTO,'E',1,0)) NUMBULEMBA,
                            SUM(DECODE(TIPOBULTO,'C',1,0)) NUMBULPAL
                       FROM VDBULTOCAB BUC,VDPEDIDOCAB PEC
                   WHERE PEC.CODDIV=BUC.CODDIV AND PEC.ANOPED=BUC.ANOPED AND
                         PEC.CODPED=BUC.CODPED AND PEC.SEQPED=BUC.SEQPED AND
                         PEC.CODSERIEEXP=:CODSERIEEXP;

