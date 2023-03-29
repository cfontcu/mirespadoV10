# M�dulo   : VDLIBFECHAS.PAN
# Funci�n  : Selecci�n de criterios para b�squeda
#
# Creaci�n : 07-08-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
Selecci�n de Criterios

  Desde �D-MM-Y.YY 
  Hasta �D-MM-Y.YY 
  Art�culo:   _40_________________ _100________________________________ 
  Lote:       _40_________________ ________
  
  Liberaciones _  
  Rechazos     _  
  
|
NOQUERY
NOINSERT
NODELETE

CAMPO=DESDE
CAMPO=HASTA
CAMPO=CODART,CONTEXTUAL=FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","Selecci�n de art�culo","S"),
                        POSTCHANGE=FDESIGNACION("+CDESART","Error obteniendo descripci�n del art�culo",PRESEHIJO,""),COMBOX("CLISTAART") 
CAMPO=DESART,NOENTER
CAMPO=CODLOT,CONTEXTUAL=FEJECUTAFORM("VDLOTES","N","CODART=:CODART","","CODLOT=:CODLOT","Selecci�n de lotes del art�culo","S"),COMBOX("CLISTALOTES") ,
             POSTCHANGE=FDESIGNACION("+CSELLOT","Error obteniendo descripci�n del art�culo",PRESEHIJO,"")
CAMPO=CADUCI,NOENTER
CAMPO=LIBERACIONES,POSTCHANGE=FEJECUTA(FVERIFICA(" NS"),"Debes seleccionar (S)i, (N)o o (B)lanco")
CAMPO=RECHAZOS,POSTCHANGE=FEJECUTA(FVERIFICA(" NS"),"Debes seleccionar (S)i, (N)o o (B)lanco")

CURSOR=CDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELLOT SELECT CADUCI FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT;

CURSOR=CLISTAART SELECT ART.CODART,ART.DESART,SUM(MOV.CANTIDAD) CANTIDAD
                   FROM VDARTIC ART, VDMOVIM MOV
                   WHERE MOV.CODART=ART.CODART AND
                         SUBSTR(MOV.BLOQUEOSORI,:POSICION,1)!=SUBSTR(MOV.BLOQUEOSDEST,:POSICION,1) AND MOV.FECINS BETWEEN :DESDE AND :HASTA
                   GROUP BY ART.CODART,ART.DESART
                   ORDER BY ART.CODART;
                   
CURSOR=CLISTALOTES SELECT LOT.CODLOT,LOT.CADUCI,SUM(MOV.CANTIDAD) CANTIDAD
                   FROM VDARTIC ART,VDMOVIM MOV,VDLOTES LOT
                   WHERE MOV.CODART=ART.CODART AND  
                         SUBSTR(MOV.BLOQUEOSORI,:POSICION,1)!=SUBSTR(MOV.BLOQUEOSDEST,:POSICION,1) AND MOV.FECINS BETWEEN :DESDE AND :HASTA AND
                         LOT.CODART=ART.CODART AND LOT.CODLOT=MOV.CODLOT AND LOT.CODART=:CODART
                   GROUP BY LOT.CODLOT,LOT.CADUCI
                   ORDER BY LOT.CODLOT;


ONLINE={F1} Ayuda  {F4} Aplicar Filtro y refrescar consulta;