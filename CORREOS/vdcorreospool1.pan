# M�dulo   : VDCORREOSPOOL1.PAN
# Funci�n  : Mantenimiento de COLA de env�o de correos
#
# Creaci�n : 04-07-2008
# Autor    : FGS
###########################################
Mantenimiento de COLA de env�o de correos
Secuencia Ordenador    Cuenta Remitente Para              CC               CCO              Status Ult. Modif.
######### _32_________ _100_____________ _200_____________ _1000___________ _1000___________ #####  _32_________ �D-MM-Y.YYY ________
|
TABLA=VDCORRSMTP
ORDERBY=IDMSG DESC;
#WPLEGADO


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=IDMSG,NOENTER,TOOLTIP("Secuencial del correo"),TITULO("Secuencia"), WLONX=32
CAMPO=ORDENADOR,TOOLTIP("Ordenador desde el que se inserta el env�o del correo"),TITULO("Ordenador")
CAMPO=TIPOCORREO,VIRTUAL,OCULTO,TOOLTIP("Tipo de correo a enviar")
CAMPO=CUENTA,TOOLTIP("Remitente del correo"),TITULO("Cuenta Remitente"), WLONX=50,MIXED
CAMPO=PARA,TOOLTIP("Destinatarios del correo"),TITULO("Para")
CAMPO=CC,TOOLTIP("Direcciones en copia del correo"),TITULO("CC")
CAMPO=CCO,TOOLTIP("Direcciones en copia oculta del correo"),TITULO("CCO")
CAMPO=STATUS,TOOLTIP("Estado del correo en el spool"),TITULO("Estado"), WLONX=20
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

