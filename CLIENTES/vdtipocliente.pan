#*****************************************************************
#M�dulo: VDTIPOCLIENTE.PAN
#Funcionalidad : mantenimiento de la tabnla de tipos de clientes
#Autor: JMM      
#Fecha: 10-12-2007
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
#*****************************************************************
#
#
#*****************************************************************
MANTENIMIENTO DE TIPOS DE CLIENTE
 Tipo      Designaci�n                     Ultima modificacion
 _5___     _40___________________________  _32_______________ �D-MM-YY.Y ________ 

|

POSX=17
POSY=10
REGPAG=20

TABLA=VDTIPOCLIENTE
ORDERBY=TIPOCLI ASC;
PQUERY



PREINSERT=FEJECUTA("CSELMODIF","No puedo asignar fecha de modificaci�n.")
PREUPDATE=FEJECUTA("CSELMODIF","No puedo asignar fecha de modificaci�n.")

CAMPO=TIPOCLI,UPPER,TOOLTIP("Tipo de cliente")
CAMPO=DESCTIPOCLI,TOOLTIP("Descripci�n del tipo de cliente")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que hizo la ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,UPPER,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

AYUDA=MANTENIMIENTO DE TIPOS DE CLIENTE
ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F9} Borrar registro {Ctrl-F7} Copia {Esc} Salir;
