# M�dulo   : VDCORREOTIPO2.PAN
# Funci�n  : Mantenimiento de Tipos de Correos que se env�a el sistema
#
# Creaci�n : 04-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
Mantenimiento de Tipos de Correos
Tipo:   ____________  Activo: _
Desc:   ________________________________________ 

Cuenta:  _100_________________________________ 
Para _200___________________________________________________
CC:  _1000__________________________________________________ 
CCO: _1000__________________________________________________

Ult. Modif. __32_____ �D-MM-Y.YY ________ 

|
TABLA=VDCORRTIPOS


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=TIPOCORREO,VIRTUAL,TOOLTIP("Tipo de Correo")
CAMPO=ACTIVO,TOOLTIP("Si el tipo de correo est� activo para ser utilizado por el sistema")
CAMPO=DESTIPOCORREO,TOOLTIP("Descripci�n del tipo de Correo")
CAMPO=CUENTA,TOOLTIP("Cuenta Remitente del Correo"),MIXED
CAMPO=PARA,TOOLTIP("Destinatario del Correo")
CAMPO=CC,TOOLTIP("Direcciones en copia del correo")
CAMPO=CCO,TOOLTIP("Direcciones en copia oculta del correo")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


