# M�dulo   : VDCORREOSPOOL2.PAN
# Funci�n  : Mantenimiento Detallado de spool de env�o de correos
#
# Creaci�n : 04-07-2008
# Autor    : FGS
###########################################
Mantenimiento Detallado de spool de env�o de correos
Estado:    #L### _30_______________________    Prioridad: ###

De: ________________________________                        Para: _200______________________________________________________ 
CC: _1000_________________________________________________  CCO:  _1000_____________________________________________________ 

Asunto:    _1000____________________________________________________________________________________________________________
Adjunto:   _  _50_______________________ _256____________________________________________ _256______________________________
Texto:     
_4000_______________________________________________________________________________________________________________________

Inserci�n:     _32_________ �D-MM-Y.YYY ________ Ord: _32___________  M�dulo/Acci�n: _64_______________ _64_________________   
Planificado:   �D-MM-Y.YYY ________        Inf. Extra: _255_________________________________________________________________
Enviado:       �D-MM-Y.YYY ________   Cod. Comentario: @L@@@@@@@      Ult. Modif.: _32_________ �D-MM-Y.YYY ________
|

TABLA=VDCORRSMTP
#WPLEGADO

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=IDMSG,VIRTUAL,OCULTO,TOOLTIP("Secuencial del correo")
CAMPO=STATUS,TOOLTIP("Estado del correo en el spool"),POSTCHANGE=FDESIGNACION("+CDESSTATUS","ERROR OBTENIENDO DESCRICION DEL ESTADO")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=PRIORIDAD,TOOLTIP("Prioridad del correo")
CAMPO=CUENTA,TOOLTIP("Cuenta Remitente del correo")
CAMPO=PARA,TOOLTIP("Destinatarios del correo")
CAMPO=CC,TOOLTIP("Direcciones en copia del correo")
CAMPO=CCO,TOOLTIP("Direcciones en copia oculta del correo")
CAMPO=ASUNTO,MIXED,TOOLTIP("Asunto del correo")
CAMPO=ADJUNTO,TOOLTIP("Ficheros adjunto que se incluyen en el correo")
CAMPO=MIME,TOOLTIP("Tipo de MIME usado")
CAMPO=DIRECTORIO,MIXED,TOOLTIP("Directorio en donde se encuentra el fichero. NOTA: Es un DIRECTORIO ORACLE.")
CAMPO=FICHERO,MIXED,TOOLTIP("Nombre del Fichero a adjuntar")
CAMPO=CUERPO,MIXED,TOOLTIP("Texto que se env�a en el correo")
CAMPO=CODOPEINS,NOENTER,TOOLTIP("Operario que realiz� la insercci�n")
CAMPO=FECINS,NOENTER,TOOLTIP("Fecha en la que se realiz� la insercci�n")
CAMPO=HORAINS,NOENTER,TOOLTIP("Hora en la que se realiz� la insercci�n")
CAMPO=ORDENADOR,NOENTER,TOOLTIP("Ordenador desde el que se inserta el env�o del correo")
CAMPO=MODULOINS,NOENTER,TOOLTIP("M�dulo desde el que se inserta el correo")
CAMPO=ACCIONINS,NOENTER,TOOLTIP("Acci�n desde la que se inserta el correo")
CAMPO=FECPLANIF,TOOLTIP("Fecha prevista de env�o del correo, si NULL cuando se pueda")
CAMPO=HORAPLANIF,TOOLTIP("Hora prevista de env�o del correo, NULL idem.")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente")
CAMPO=FECENVIO,NOENTER,TOOLTIP("Fecha en la que se ha enviado el correo")
CAMPO=HORAENVIO,NOENTER,TOOLTIP("Hora en la que se ha enviado el correo")
CAMPO=CODCOMEN,NOENTER,TOOLTIP("Comentario asociado al correo")
CAMPO=CODOPEMODIF,NOENTER,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")

CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='CSP';

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
