#*****************************************************************************************
#Modulo: VDPEDSALTAREA.PAN
#Funcionalidad : Listado de lOS pedidos por tipo de pedidos y sus datos más relevantes pendientes de realizar
#Autor: Fermín
#Fecha: 23-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 SELECTOR DE TAREAS PENDIENTES

 Tipo Tarea: _10_________    Tarea: #L##########       Cod.AGRP. ######       Num. Cubetas: #L#####
 |

NOQUERY
TABLA=DUAL

CAMPO=TIPOTAREA,POSTCHANGE=FEJECUTA("CLISTAREAS","No hay tareas pendientes de tipo :TIPOTAREA",FPULSATECLAS("F6","F2","CF6"),""),TOOLTIP("Tipo de tarea"),WLONX=75,COMBOX("NORMAL","TAQUILLA","TRASLADO","KANBAS"),WLONX=60
CAMPO=CODGRTASK,POSTCHANGE=FEJECUTA("CCUENTACUBETAS","Error contando las cubetas de la tarea","CCOGECODAGRP","Error obteniendo el código de OLE4",FPULSATECLAS("F6","F2","CF6"),"E"),TOOLTIP("Código de tarea"),WLONX=100,COMBOX("CLISTAREAS"),WLONX=30
CAMPO=CODAGRP,AUXILIAR,NOENTER,TOOLTIP("Código de la agrupación"),WLONX=30
CAMPO=NUMCUBETAS,AUXILIAR,NOENTER,TOOLTIP("Número de cubetas que salen para esta tarea"),WLONX=10

CURSOR=CLISTAREAS SELECT CODGRTASK FROM ASTGRTASKCAB WHERE VDEXTRA=:TIPOTAREA AND STATUS=100;
CURSOR=CCUENTACUBETAS SELECT COUNT(CODMAT) NUMCUBETAS FROM ASTGRTASKLIN WHERE CODGRTASK=:CODGRTASK AND STATUS=100;
CURSOR=CCOGECODAGRP SELECT SECLINORD CODAGRP FROM ASTGRTASKCAB WHERE CODGRTASK=:CODGRTASK;



#POSTCHANGE=FEJECUTA(PRESEBLOQUE("VDPEDINFTAREA.PAN","SELECT ROWNUM, CODDESTIN, TIPOPEDIDO, URGENCIA, NUMPOS, NUMCUB FROM MET_BULTOCAB WHERE CODBULTO=:CODAGRP"),""), 
