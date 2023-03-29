######
# VDPARAMETROS.PAN - Sistema de ventanas de configuraci�n de algoritmos.
#
# Prop�sito: Ventana para dar crear/modificar/borrar par�metros de los procesos.
#
#
# Autor	   : Jos� Carlos Santos
# Fecha    : 12-12-2007
####
# Modificaciones:
####
PARAMETROS DE LA FUNCION
Par�metro        Valor                  Descripci�n
_20_____________ _255__________________ _256______________________________
                                                                          |

SOLOQUERY


SELECT= SELECT PAR.NOMBREPARAM,VD.PIECE(PRO.PARAM,'#',PAR.POSICION) VALOR,PAR.POSICION POSICION,PAR.INFORMAR,PAR.DESCRIPCION
        FROM  VDPARAMALGPROC PAR, VDPROCESOS PRO
        WHERE PRO.PROCESO = :PROCESO AND
	            PAR.FUNCION = PRO.FUNCIONPROC AND
	            PAR.TIPOPROC='F';
ORDERBY=PAR.POSICION;

PREUPDATE=FEJECUTA("CUPDPARPROC","ERROR ACTUALIZANDO PARAMETRO DE LA FUNCION",
		               FCOMMIT,"ERROR EN EL COMMIT",
                   FPULSATECLAS("CF2","F2"),"")


CAMPO=PROCESO,VIRTUAL,AUXILIAR,OCULTO
CAMPO=FUNCIONPROC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=NOMBREPARAM,UPPER,TOOLTIP("Es el nombre del par�metro"),TITULO("Par�metro")
CAMPO=VALOR,UPPER,AUXILIAR,POSTCHANGE=FEJECUTA("@CSELINFORMAR","","CSELVALORNULO","Obligatorio informar el parametro :NOMBREPARAM"),  TOOLTIP("Es el valor del par�metro"),TITULO("Valor")
CAMPO=DESCRIPCION,NOUPDATE,TOOLTIP("Descripci�n del valor"),TITULO("Descripci�n")
CAMPO=POSICION,OCULTO,"@@@"
CAMPO=INFORMAR,OCULTO,"_"


CURSOR=CSELINFORMAR SELECT :INFORMAR
                      FROM DUAL
                     WHERE :INFORMAR='S';

CURSOR=CSELVALORNULO SELECT :VALOR
                       FROM DUAL
                      WHERE :VALOR IS NOT NULL;

CURSOR=CUPDPARPROC UPDATE VDPROCESOS SET PARAM = VD.SUSTPIECE(PARAM,:POSICION,:VALOR),
                                         CODOPEMODIF = VDUSER.GETUSER, FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS
		                WHERE PROCESO = :PROCESO ;



