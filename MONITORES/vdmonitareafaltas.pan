#
MOVIMIENTOS CON FALTAS EN LA RESERVA
C�digo    Articulo                      Cantidad  
@L@@@@@@@ _40______ _100_______________ @L,@@@@@  
|

SOLOQUERY
TABLA=FRES
SELECT=SELECT FRES.CODMOV,FRES.CODART,ART.DESART,FRES.CANTIDAD
         FROM VDFALTASRES FRES,VDARTIC ART,VDMOVIM MOV 
        WHERE FRES.TAREA = :TAREA AND FRES.CODART=ART.CODART AND FRES.CODMOV=MOV.CODMOV AND MOV.CANTIDAD>0;
ORDERBY=FRES.CODMOV;

CAMPO=TAREA,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODMOV,NOUPDATE,TOOLTIP("C�digo del movimiento"),TITULO("C�digo")
CAMPO=CODART,NOUPDATE,TITULO("Articulo")
CAMPO=DESART,AUXILIAR,NOUPDATE,TITULO("Descripci�n")
CAMPO=CANTIDAD,NOUPDATE,TITULO("Cantidad")

CONTEXTUAL=FEJECUTAFORM("VDMOVIM","S","CODMOV=:CODMOV")