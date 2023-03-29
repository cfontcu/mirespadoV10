######
# VDALGORITMOS.PAN - Sistema de ventanas de configuraci�n de algoritmos.
# 
# Prop�sito: Ventana para dar crear/modificar/borrar algoritmos
#               
#           
# Autor	   : Jos� Carlos Santos
# Fecha    : 18-12-2007
####
# Modificaciones:
####
MANTENIMIENTO DE ALGORITMOS
 Algoritmo        Funci�n                    Librer�a       Act Descripci�n                                          Fec. Modif Hora modif. Usuario 
 _40_____________ _32_______________________ _256___________ _  _256________________________________________________ �D-MM-Y.YY _32________ ________ 
|           

TABLA=VDALGORITMOS

ORDERBY=NOMBREALG;

PREUPDATE=FEJECUTA("CFORMATEADISC","",
                   "CSELMODIF","No se puede actualizar fecha de modificaci�n.")

PREINSERT=FEJECUTA("CFORMATEADISC","",
                   "CSELMODIF","No se puede insertar fecha de modificaci�n.")

CAMPO=NOMBREALG,UPPER,TOOLTIP("Es el nombre del algoritmo"),TITULO("Algoritmo")
CAMPO=FUNCIONALG,MIXED,TOOLTIP("Funci�n del algortimo"),TITULO("Funci�n")
CAMPO=FUNCIONPROC,VIRTUAL,AUXILIAR,OCULTO
CAMPO=LIBALGORITMO,UPPER,TOOLTIP("Librer�a del algortimo"),TITULO("Librer�a")
CAMPO=ACTIVO,UPPER,TOOLTIP("Indica si el algoritmo est� activo"),TITULO("Act"),WLONX=5,CHECKBOX("N","S")
CAMPO=DISCRIMINANTE,OCULTO,"_256___________________",PROTECT("IMPLANTADOR")
CAMPO=DESALG,TOOLTIP("Descripci�n del algoritmo"),TITULO("Descripci�n")
CAMPO=FECMODIF,NOENTER,TITULO("Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER
CAMPO=CODOPEMODIF,UPPER,NOENTER
CAMPO=PROCESO,VIRTUAL, OCULTO
CAMPO=PARAMALG,OCULTO,"_256________"

TECLA=SF4,FEJECUTA(FMODIFICA,"",FPULSATECLAS("F4"))

CURSOR=CFORMATEADISC SELECT VDPROC.FORMATEADISCRIMINANTE(:FUNCIONPROC,:DISCRIMINANTE) DISCRIMINANTE FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;  


