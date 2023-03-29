######
# VDDISCALGORITMOS.PAN - Sistema de ventanas de configuraci�n de algoritmos.
# 
# Prop�sito: Ventana para dar modificar par�metros del discriminante de los algoritmos.
#               
#           
# Autor	   : Jos� Carlos Santos
# Fecha    : 20-12-2007
####
# Modificaciones:
####
DISCRIMINANTE DEL ALGORITMO
 Item           Valor            Descripci�n
 _20___________ _255____________ _256____________________
| 


SOLOQUERY
TABLA=ALG
NOCOMMIT

SELECT= SELECT PAR.NOMBREPARAM,PAR.DESCRIPCION,VD.PIECE(:DISCRIMINANTE,'#',PAR.POSICION) VALOR,PAR.POSICION POSICION, 'D' TIPOPROC
        FROM  VDPARAMALGPROC PAR
         WHERE
              PAR.FUNCION = :FUNCIONPROC AND 
	            PAR.TIPOPROC='D';
ORDERBY=PAR.POSICION; 

TECLA=F4,FPULSATECLAS("CF6","SF4")

CAMPO=PROCESO,VIRTUAL,AUXILIAR,OCULTO
CAMPO=NOMBREALG,VIRTUAL,AUXILIAR,OCULTO
CAMPO=FUNCIONPROC, VIRTUAL,AUXILIAR, OCULTO
CAMPO=DISCRIMINANTE, VIRTUAL,AUXILIAR, OCULTO

CAMPO=NOMBREPARAM,UPPER,NOUPDATE,TOOLTIP(":DESCRIPCION"),TITULO("Item")
CAMPO=POSICION, OCULTO, "@@@"
CAMPO=TIPOPROC, OCULTO, "_"
CAMPO=VALOR,UPPER, AUXILIAR,TOOLTIP("Es el valor del par�metro\nAdmite Rango de Valores tipo A,B,C y A-C"), POSTCHANGE=FRECALCPADRE("+CACTDISC","ERROR EN CACTDISC"),TITULO("Valor")
CAMPO=DESCRIPCION,NOUPDATE,TOOLTIP("Es la descripci�n del par�metro"),TITULO("Descripci�n")

CURSOR=CACTDISC SELECT VD.SUSTPIECE(NVL(:DISCRIMINANTE,'#'),:POSICION,:VALOR) DISCRIMINANTE 
                      FROM DUAL 
                      WHERE :DISCRIMINANTE IS NOT NULL;



