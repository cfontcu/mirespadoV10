# M�dulo   : VDSTATUS.PAN
# Funci�n  : Mantenimiento de status
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
TABLA DE ESTADOS
Ti. Est.   Descripci�n                              Abreviatura   T Extra            Ultima modificaci�n
___ @L@@@@ _40_____________________________________ _10_______    _ _256____________ _32__________ �D-MM-Y.YY _8________
|

TABLA=VDSTATUS
ORDERBY=TIPOSTATUS,STATUS;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=TIPOSTATUS,NOUPDATE,TOOLTIP("Tipo del status indica a que tabla se refiere"),POSTCHANGE=FVALNOCERO("Debe introducir tipo del estado"),TITULO("Tipo"),WLONX=20
CAMPO=STATUS,TOOLTIP("C�digo del status"),TITULO("Valor")
#,INCLUDECSS="background-color:darkgreen;color:white;font-weight:bold"
CAMPO=DESSTATUS,TOOLTIP("Designaci�n del Status"),POSTCHANGE=FVALNOCERO("Debe introducir designacion del estado"),TITULO("Descripci�n")
CAMPO=DABSTATUS,TOOLTIP("Abreviatura del status imprescindible para generaci�n autom�tica"),POSTCHANGE=FVALNOCERO("Debe introducir abreviatura del estado"),WLONX=20,TITULO("Abreviada")
CAMPO=TIPOAPP,TOOLTIP("Tipo de aplicacion S(tandar) o P(ersonalizada)"),POSTCHANGE=FVERIFICA("SP","Debe introducir S(tandard) o P(ersonalizada)"),TITULO("T")
#,CHECKBOX("S","P")
CAMPO=VDEXTRA,TITULO("Extra")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CURSOR=CPRUEBA SELECT DECODE(:CODOPEMODIF,'X',20,19) FECMODIF__COLOR FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


