#*****************************************************************************************
#Modulo: ASTSEPAR.PAN
#Funcionalidad : Maestro de tipo de separaciones
#Autor: JOTA      
#Fecha: 27-12-2022
#*******************************************************************************************
#* Historico de cambios
#* ====================
TIPO SEPARACION
Tipo Separacion Descripcion Ultima modificacion 
      @@@       ___________ _32________ ¿D-MM-Y.YY ________
|

TABLA=ASTSEPAR
ORDERBY=TIPOSEP;

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=TIPOSEP, TOOLTIP("Tipo Separacion"),TITULO("Tipo")
CAMPO=DESCSEPARACION, TOOLTIP("Descripcion de separaciones de la cubeta"),TITULO("Descripcion")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizo la ultima modificacion"),TITULO("Ultima modificacion")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;