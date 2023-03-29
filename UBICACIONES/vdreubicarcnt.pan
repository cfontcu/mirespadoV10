#*****************************************************************
#M�dulo: VDREUBICARCNT.PAN
#Funcionalidad : Reubica un palet completo a una ubicaci�n compatible
#Autor: ICC      
#Fecha: 08-05-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#*****************************************************************
REUBICAR PALETS COMPLETOS
Ubicaci�n    Area       B Matr�cula          Tipo       C�digo seriado       Posici�n  Altura  Reubicar
_20_________ _10_______ _ _18_______________ _10_______ _20_________________ @L9@@@    @L9@@@     _
|

SOLOQUERY   
SELECT=SELECT CODMAT,TIPOCONTE,CODUBI,POSCONTE,ALTURACONTE,CODAREA,BLOQUEOSE,REUBI
       FROM (SELECT CNT.CODMAT, CNT.TIPOCONTE, CNT.CODUBI, CNT.POSCONTE, CNT.ALTURACONTE, UBI.CODAREA,BLOQUEOSE,'N' REUBI
             FROM VDCONTE CNT, VDUBICA UBI, VDSTOCK STK
             WHERE CNT.CODUBI = UBI.CODUBI AND UBI.TIPOUBI='R' AND CNT.CODMAT=STK.CODMAT 
               AND CNT.TIPOCONTE NOT IN ( 'VIRTUAL','TMP') AND VDSTK.CNTRESERVADO(CNT.CODMAT)=0)
       WHERE 1=1;

ORDERBY=CODMAT,CODAREA;

WLONX=1150
PREUPDATE=FEJECUTA(FIF("CUPDREUBI", FEJECUTA(FREUBICONTE(":CODMAT",":TAREA","CODMOV","","",""),":V10ERROR",
                                            %FFAILURE,"GENERADO MOVIMIENTO :CODMOV",
                                            FCOMMIT,"")),"")
											
POSTCOMMIT=FEJECUTA(FPULSATECLAS("F5"))											

CAMPO=CODUBI,TOOLTIP("C�digo de la ubicaci�n donde se encuentra el contenedor"),TITULO("Ubicaci�n"),PREFIJO=UBI
CAMPO=CODAREA,NOUPDATE,TOOLTIP("C�digo del �rea donde se encuentra el contenedor"),TITULO("Area")
CAMPO=BLOQUEOSE,TOOLTIP("Bloqueo de recargas"),TITULO("B")
CAMPO=CODMAT,TOOLTIP("Matricula del contenedor en el que se halla el stock"),TITULO("Matr�cula")
CAMPO=TIPOCONTE,NOENTER,TOOLTIP("Tipo de contenedor"),TITULO("Tipo")
CAMPO=CNTSSCC,TOOLTIP("C�digo seriado del contenedor"),TITULO("C�digo Seriado")
CAMPO=POSCONTE,TOOLTIP("Posici�n del contenedor en la ubicaci�n"),TITULO("Posici�n"),WLONX=22
CAMPO=ALTURACONTE,TOOLTIP("Altura del contenedor"),TITULO("Altura"),WLONX=20
CAMPO=REUBI,AUXILIAR,TITULO("Reubi"),POSTCHANGE=FVERIFICA("SN","Valores: S=Enviar a ubicaci�n libre, N=No reubicar"),WLONX=18,CHECKBOX("N","S")
CAMPO=CODMOV,OCULTO,"@L9@@@"
CAMPO=TAREA,OCULTO,AUXILIAR,"_32_"

CURSOR=CUPDREUBI SELECT 'REUBICAR' TAREA FROM DUAL WHERE :REUBI = 'S';

                      
