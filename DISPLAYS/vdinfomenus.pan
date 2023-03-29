# M�dulo   : VDINFOMENUS.PAN
# Funci�n  : Mantenimiento de menus de picking
#
# Creaci�n : 21-05-2008
# Autor    : Maite Gonz�lez
###########################################
MENUS DE PICKING
Men�       Padre Men� Ord Texto            A Funci�n                     Estado               T.Tick Presenta                  Cod.Ope.     Ultima modificaci�n
_10_______ _10_______ @L@ _256____________ _ _255_______________________ @L@@@ _32___________ @L@@@@ _255_____________________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDINFOMENUS
ORDERBY=PADREMENU,ORDENMENU;

PROTECT("SUPERVISOR")

PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

CAMPO=IDMENU,TOOLTIP("Identificador del menu"),TITULO("Men�")
CAMPO=PADREMENU,TOOLTIP("Padre de la opcion de menu"),TITULO("Padre Men�")
CAMPO=ORDENMENU,TOOLTIP("Orden de la opcion dentro del padre"),TITULO("Ord")
CAMPO=TEXTO,TOOLTIP("Texto que aparece en el display"),TITULO("Texto")
CAMPO=TIPOACCION,TOOLTIP("Accion que ejecuta la opcion de menu M->submenu F->Funci�n con parametros"),TITULO("A")
CAMPO=FUNCION,TOOLTIP("Funcion que se ejecuta cuando se confirma"),TITULO("Funci�n")
CAMPO=STATUSORIGZONA,POSTCHANGE=FDESIGNACION(FIF("-CHAYSTATUS","CSELSTATUS"),"No existe estado"),TOOLTIP("Status original de la zona para entrar en el menu"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripcion del estatus original de la zona")
CAMPO=TTICK, TOOLTIP("Tiempo en cent�simas de segundo para ejecutar el tick"),TITULO("T.TICK")
CAMPO=FPRESENTA, TOOLTIP("Funci�n que se ejecuta en cada tick"),TITULO("Funci�n TICK")
CAMPO=CODOPEMODIF,NOENTER, TOOLTIP("Usuario que ha realizado la ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER, TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUSORIGZONA AND TIPOSTATUS='ZON';
CURSOR=CHAYSTATUS SELECT 0 STATUSORIGZONA FROM DUAL WHERE :STATUSORIGZONA = 0;

