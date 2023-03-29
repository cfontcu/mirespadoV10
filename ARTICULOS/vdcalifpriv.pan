# M�dulo   : VDCALIFPRIV.PAN
# Funci�n  : Mantenimiento de cambios de calif. con privilegios especiales
#
# Creaci�n : 17-06-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CAMBIOS DE CALIFICACION CON PRIVILEGIOS ESPECIALES
  Valores Privilegios       Descripci�n                       Ultima modificaci�n 
  
De _ a _  _1024____________ _40______________________________  _32________ �D-MM-Y.YY  ________    
|

TABLA=VDCALIFPRIV

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=INDICADOR,VIRTUAL,OCULTO
CAMPO=VALORCALIF,TOOLTIP("Posici�n del indicador"),NOUPDATE,TITULO("VALOR"),WLONX=35
CAMPO=NUEVOVALORCALIF,TOOLTIP("Posici�n del indicador"),NOUPDATE,TITULO("NUEVO VALOR"),WLONX=80
CAMPO=PRIVCALIF,TOOLTIP("Privilegio para el cambio de Calificaci�n"),TITULO("Privilegios")
CAMPO=DESCAMBIO,TOOLTIP("Designaci�n del cambio de calificaci�n"),TITULO("Descripci�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



