# M�dulo   : VDRECURSO.PAN
# Funci�n  : Mantenimiento de recursos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE RECURSOS
C�digo: __________ _40_________________________ Activo: _ Direcci�n: _30_____________
Conectado: _ Sid: @L@@@@@@@ Serial: @L@@@@@@@ Terminal: ________________
Contenedores: _ Embalajes: _ Unidades: _ M�xima altura: @L@ M�nima: @L@
Admite teclear: _ Ubicaci�n asignada: _20_________ Matr�cula _18_____________
Usuario: ________________ Priv. login: _1000________________________
Estado: @L@@@ _40________________________________ Driver: _32_____________
Perfil ____________________ _40___________________________ Pantalla _256_____________________
Impresora _15____________
Planificador: Lib: _256_________________ Func: _32____________ Param: _256___________________
Extra: _255_______________________________ Comentario: @L@@@@@@@
Ultima ubicaci�n visitada: ___________ Ultima modificaci�n _32_________ �D-MM-Y.YY _8________
|


TABLA=VDRECURSO
ORDERBY=CODRECURSO;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODRECURSO,NOUPDATE,TOOLTIP("C�digo del recurso")
CAMPO=DESRECURSO,TOOLTIP("Designaci�n del recurso"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del recurso")
CAMPO=ACTIVO,TOOLTIP("Indica si el recurso es utilizable"),CHECKBOX("N","S")
CAMPO=DIRRECURSO,TOOLTIP("Direccion f�sica del recurso (Normalmente direcci�n ip)")
CAMPO=CONECTADO,TOOLTIP("Indica si el recurso est� conectado"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=SID,TOOLTIP("SID Oracle de la sesion a la que se ha conectado el terminal")
CAMPO=SERIALNUM,TOOLTIP("SERIAL# de la sesion a la que se ha conectado el terminal")
CAMPO=TERMINAL,TOOLTIP("Maquina a la que se ha conectado el recurso")
CAMPO=CONTENEDORES,TOOLTIP("Indica si el recurso puede transportar contenedores"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=EMBALAJES,TOOLTIP("Indica si el recurso puede transportar embalajes"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=UNIDADESSUELTAS,TOOLTIP("Indica si el recurso puede transportar unidades sueltas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=MAXALT,TOOLTIP("M�xima altura a la que puede acceder el recurso")
CAMPO=MINALT,TOOLTIP("M�nima altura a la que puede acceder el recurso")
CAMPO=TECLEO,TOOLTIP("Indica si el recurso puede teclear en campos scaneables"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=CODUBI,TOOLTIP("Ubicaci�n temporal asociada al recurso")
CAMPO=CODMAT,TOOLTIP("Matricula asignada el recurso")
CAMPO=CODOPE,TOOLTIP("Operario identificado en el terminal")
CAMPO=PRIVILEGIOSLOGIN,TOOLTIP("Privilegios necesarios para hacer login en este recurso")
CAMPO=STATUS,POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado"),TOOLTIP("Estado del recurso"),COMBOX("CLISTASTATUS")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designacion del estado")
CAMPO=DRIVER,TOOLTIP("Driver C que gestiona el recurso")
CAMPO=CODPERFIL,TOOLTIP("Perfil que esta ejecutando el recurso"),POSTCHANGE=FDESIGNACION("CSELDESPERFIL","No existe perfil")
CAMPO=DESPERFIL,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del perfil que esta ejecutando el recurso")
CAMPO=NPANTALLA,TOOLTIP("Nombre de la pantalla a ejecutar")
CAMPO=CODIMPRE,TOOLTIP("C�digo mnemot�cnico de la impresora/etiq.")
CAMPO=LIBPLANIFICADOR,TOOLTIP("Librer�a donde esta ubicado el planificador del recurso")
CAMPO=PLANIFICADOR,TOOLTIP("Funcion de planificador del recurso")
CAMPO=PARAMPLANIF,TOOLTIP("Parametro que se pasa al planificador")
CAMPO=VDEXTRA,TOOLTIP("Informacion extra para el implantador de V10")
CAMPO=CODCOMEN,TOOLTIP("Comentario")
CAMPO=ULTCODUBI,TOOLTIP("Ultima ubicaci�n visitada por el recurso")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTASTATUS SELECT STATUS,DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='REC' ORDER BY STATUS;
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='REC';

CURSOR=CSELDESPERFIL SELECT DESPERFIL FROM VDPERFILTAREA WHERE CODPERFIL=:CODPERFIL
                   UNION
                  SELECT '' DESPERFIL FROM DUAL WHERE :CODPERFIL IS NULL;



CURSOR=CDESASIGNA DECLARE
                   RET NUMBER;
                  BEGIN
                   RET:=VDPLANMOV.DESASIGNAMOV(:CODRECURSO);
                   COMMIT;
                  END;@
                                
