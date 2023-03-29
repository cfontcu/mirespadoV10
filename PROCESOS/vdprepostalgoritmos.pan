######
# VDPREPOSTALGORITMOS.PAN - Sistema de ventanas de configuraci�n de algoritmos.
# 
# Prop�sito: Ventana para dar crear/modificar/borrar algoritmos
#               
#           
# Autor	   : Jos� Carlos Santos
# Fecha    : 18-12-2007
####
# Modificaciones:
####
LISTA DE PREALGORITMOS Y POSTALGORITMOS
 Tipo              P.  Funci�n         Librer�a        Act Descripci�n                          Fec. Modif Hora modif. Usuario 
 _ _______________ @L@ _32____________ _256___________ _1_ _256_______________________________ �D-MM-Y.YY _32________ ________ 
                                                                            |

TABLA=VDPREPOSTALGORITMOS

ORDERBY=DECODE(TIPOALG,'A',0,'D',1),PRIORIDAD;

PREINSERT=FEJECUTA("CSELMODIF","No se puede insertar fecha de modificaci�n.")
                   
PREUPDATE=FEJECUTA("CSELMODIF","No se puede actualizar fecha de modificaci�n.")

POSTQUERY=FEJECUTA("CDAMEDESCTIPO","")

CAMPO=TIPOALG,TOOLTIP("Tipo de ejecuci�n (A)ntes del algoritmo o (D)espu�s del algoritmo"),TITULO("Tipo")
CAMPO=DESCTIPO,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del tipo")
CAMPO=PROCESO,VIRTUAL, OCULTO
CAMPO=NOMBREALG,VIRTUAL,OCULTO
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de ejecuci�n"),TITULO("P.")
CAMPO=FUNCIONALG,TOOLTIP("Nombre de la funci�n"),TITULO("Funci�n")
CAMPO=LIBALGORITMO, UPPER,TOOLTIP("Nombre de la librer�a, si est� vac�o, est� en el ejecutable"),TITULO("Librer�a")
CAMPO=ACTIVO, UPPER,TOOLTIP("Indica si est� o no activo"),TITULO("Act")
CAMPO=DESALG,TOOLTIP("Designaci�n del pre/postalgoritmo"),TITULO("Descripci�n")
CAMPO=FECMODIF, NOENTER,TITULO("Ultima modificaci�n")
CAMPO=HORAMODIF, NOENTER
CAMPO=CODOPEMODIF, NOENTER

CAMPO=PARAMALG,OCULTO,"_256__________________"

CURSOR=CDAMEDESCTIPO SELECT DECODE(:TIPOALG,'A','PREALGORITMO','D','POSTALGORITMO') DESCTIPO FROM DUAL;

TECLA=SF4,FEJECUTA(FMODIFICA,"",FPULSATECLAS("F4"))

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;   


