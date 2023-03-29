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
VALORES DE PARAMETROS DEL ALGORITMO
Par�metro      Valor                  Descripci�n
_20___________ _255__________________ _256______________________________________
|


SOLOQUERY
TABLA=ALG
NOCOMMIT

SELECT= SELECT PAR.NOMBREPARAM,PAR.DESCRIPCION,VD.PIECE(:PARAMALG,'#',PAR.POSICION) VALOR,
               PAR.POSICION POSICION,PAR.INFORMAR,:PROCESO PROCESO, 'F' TIPOPROC
        FROM  VDPARAMALGPROC PAR
        WHERE PAR.FUNCION = :FUNCIONALG AND 
	            PAR.TIPOPROC='F';
ORDERBY=PAR.POSICION; 

TECLA=F4,FPULSATECLAS("CF6","CF6","SF4")

CAMPO=PROCESO,VIRTUAL,AUXILIAR,OCULTO
CAMPO=NOMBREALG,VIRTUAL,AUXILIAR,OCULTO
CAMPO=FUNCIONALG,VIRTUAL,AUXILIAR,OCULTO
CAMPO=PARAMALG,VIRTUAL,AUXILIAR,OCULTO

CAMPO=NOMBREPARAM,UPPER,NOUPDATE,TOOLTIP(":DESCRIPCION"),TITULO("Par�metro")
CAMPO=VALOR,MIXED, AUXILIAR,TOOLTIP("Valor del par�metro"),POSTCHANGE=FEJECUTA(+FRECALCPADRE("+CACTPARAM","ERROR EN CACTPARAM"),"","@CSELINFORMAR","","CSELVALORNULO","Obligatorio informar el parametro :NOMBREPARAM"),TITULO("Valor")
CAMPO=DESCRIPCION,NOUPDATE,TOOLTIP("Descripci�n del valor"),TITULO("Descripci�n")
CAMPO=POSICION, OCULTO, "@@@"
CAMPO=TIPOPROC, OCULTO, "_"
CAMPO=INFORMAR,OCULTO,"_"


CURSOR=CSELINFORMAR SELECT :INFORMAR 
                      FROM DUAL 
                     WHERE :INFORMAR='S';
                     
CURSOR=CSELVALORNULO SELECT :VALOR
                       FROM DUAL
                      WHERE :VALOR IS NOT NULL;                     


CURSOR=CACTPARAM SELECT VD.SUSTPIECE(:PARAMALG,:POSICION,:VALOR) PARAMALG FROM DUAL;



