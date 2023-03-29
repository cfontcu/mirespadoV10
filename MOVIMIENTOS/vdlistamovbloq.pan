# M�dulo   : VDLISTAMOVBLOQ.PAN
# Funci�n  : Lista de Movimientos con informaci�n sobre bloqueos
#
# Creaci�n : 07-08-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
LISTA DE MOVIMIENTOS
Contenedor Ubicaci�n    C�digo   Concepto Articulo     Lote       Cantidad   Stat  Bloqueos              Inserci�n           
_18_______ _20_________ @L@@@@@@ _10_____ _40_________ _40_______ #15L##.### @L@@@ __________ __________ _32_________ �D-MM-Y.YY ________ 
|
TABLA=VDMOVIM


CAMPO=CODMATORI,TOOLTIP("Matr�cula origen"),TITULO("Contenedor"),WLONX=16
CAMPO=CODUBIORI,TOOLTIP("Ubicaci�n origen"),TITULO("Ubicaci�n"),WLONX=16
CAMPO=CODMOV,TOOLTIP("C�digo del movimiento"),POSTCHANGE=FDESIGNACION("CSELART",""),TITULO("C�digo")
CAMPO=CODCONCE,TOOLTIP("Concepto del movimiento"),CONTEXTUAL=FEJECUTAFORM("VDCONCEPTO","N","","","CODCONCE=:CODCONCE","Selecci�n de concepto","S"),TITULO("Concepto"),WLONX=16
CAMPO=CODART,NOENTER,TITULO("Art�culo")
CAMPO=DESART,AUXILIAR,NOENTER,OCULTO,"_100"
CAMPO=CODLOT,NOENTER,TITULO("Lote")
CAMPO=CANTIDAD,TOOLTIP("Cantidad en unidades host"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART"),TITULO("Cantidad")
CAMPO=STATUS,TOOLTIP("Estado del movimiento"),
                CONTEXTUAL=FEJECUTAFORM("VDSTATUS","N","TIPOSTATUS='MOV'","","STATUS=:STATUS","Selecci�n de status","S"),
                TITULO("Stat")
CAMPO=BLOQUEOSORI,NOENTER,TITULO("Bloqueos")
CAMPO=BLOQUEOSDEST,NOENTER
CAMPO=CODOPEINS,NOENTER,TITULO("Inserci�n")
CAMPO=FECINS,NOENTER,TITULO("")
CAMPO=HORAINS,NOENTER

CURSOR=CSELART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

                   

