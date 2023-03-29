# M�dulo   : VDMONIMOVIMS.PAN
# Funci�n  : Monitor de movimientos. Desglose de estados
#
# Creaci�n : 04-08-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
#
TAREAS
Tarea             Total   
________________  @L@@@@@  
|

WLONX=330
SOLOQUERY
SELECT=SELECT MOV.TAREA, COUNT(DISTINCT MOV.CODMOV) TOTAL
         FROM VDMOVIM MOV
        WHERE MOV.STATUS < VDST.FMOVINTERFASAD;
GROUPBY=MOV.TAREA;        
ORDERBY=MOV.TAREA;
        

CAMPO=TAREA,NOENTER,TOOLTIP("Tarea movimiento"),TITULO("Tarea")
CAMPO=TOTAL,AUXILIAR,NOENTER,TOOLTIP("Numero total de movimientos de la tarea"),TITULO("Total")

CONTEXTUAL=FEJECUTAFORM("VDMOVIM","S","TAREA=:TAREA AND STATUS<VDST.FMOVINTERFASAD")


