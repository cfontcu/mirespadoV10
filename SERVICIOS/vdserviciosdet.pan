# M�dulo   : VDERVICIOSDET.PAN
# Funci�n  : Mantenimiento detallado de servicios
#
# Creaci�n : 25-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DETALLADO DE SERVICIOS
Servicio                   Designaci�n                     Activo   Estado                  
_32_______________________ _32____________________________  _       @L@@@ _40_____________________ 
 �������������������������   �������� Horario (Modo A) ��������  �������� Planificado (Modo P) ��������
 �  PID:      @L@@@@@@@  �   � Patr�n: _256__________________ �  � Intervalo:  @L@@@                  � 
 �  SID:      @L@@@@@@@  �   � Hora inicio: _8________        �  � Ejec. al Arranque: _  al Cierre: _ � 
 �  SERIAL:   @L@@@@@@@  �   � Hora l�mite: _8________        �  � Ejecutar Ahora :   _               �
 �  VISUALIZADO: _       �   � Fecha Arrancado: �D-MM-Y.YY    �  � Ult.Ejec:   �D-MM-Y.YY _8________  �
 �                       �   �                                �  � Prox. Ejec: �D-MM-Y.YY _8________  �
 �������������������������   ����������������������������������  ��������������������������������������

Ejecutable: _512______________________________________________________________________________________________ 
Entorno:    _512______________________________________________________________________________________________ 
Path V10:   _512______________________________________________________________________________________________ 
Path:       _512______________________________________________________________________________________________ 
Par�metros: _512______________________________________________________________________________________________ 
Ultima modificaci�n: _32_________ �D-MM-Y.YY _8________
|

#WPLEGADO

TABLA=VDSERVICIOS


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODGRUPOSERV,VIRTUAL,NOUPDATE,OCULTO
CAMPO=CODSERVICIO,VIRTUAL,NOENTER,TOOLTIP("C�digo del servicio")
CAMPO=DESSERVICIO,TOOLTIP("Designaci�n del servicio"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del servicio")
CAMPO=ACTIVO,TOOLTIP("Indica si el servicio se puede ejecutar"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=STATUS,NOENTER,TOOLTIP("Estado del servicio"),POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe el estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del estado del servicio")
CAMPO=PID,NOENTER,TOOLTIP("El PID del programa")
CAMPO=PATRONPLANIF,COMBOXMULTIPLE("CLISTADIAS"),COMBOXREGPAG=6
CAMPO=INTERVALO
CAMPO=SID,NOENTER,TOOLTIP("SID de la conexion ORACLE")
CAMPO=HORAINICIO
CAMPO=ARRANQUE
CAMPO=CIERRE
CAMPO=SERIAL,NOENTER,TOOLTIP("SERIAL de la conexi�n ORACLE")
CAMPO=HORALIMITE
CAMPO=EJECUTAR
CAMPO=VISUALIZADO,TOOLTIP("Si se puede visualizar el servicio desde el cliente de visualizaci�n")
CAMPO=FECARRANQUE
#,NOENTER
CAMPO=FECULTEJEC
CAMPO=HORAULTEJEC
CAMPO=FECEJEC
CAMPO=HORAEJEC
CAMPO=EJECUTABLE,TOOLTIP("Ejecutable que implementa el servicio"),MIXED
CAMPO=ENVSERVICIO,MIXED,TOOLTIP("Variables de entorno del servicio separadas por \n"),MIXED
CAMPO=PATHV10SERVICIO,TOOLTIP("Path V10 particular del servicio, se a�ade al path gen�rico del grupo")
CAMPO=PATHSERVICIO,TOOLTIP("Path particular del servicio, se a�ade al path gen�rico del grupo")
CAMPO=PARAMSERVICIO,TOOLTIP("Par�metros particulares del servicio, se a�ade a los par�metros gen�ricos del grupo")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTADIAS SELECT DECODE(ROWNUM,1,'L',2,'M',3,'X',4,'J',5,'V',6,'S',7,'D',8,'L-D') LDIA,
                         DECODE(ROWNUM,1,'LUNES',2,'MARTES',3,'MIERCOLES',4,'JUEVES',5,'VIERNES',6,'SABADO',7,'DOMINGO',8,'TODOS LOS DIAS') NOMDIA 
                     FROM VDSERVICIOS WHERE ROWNUM<9;
 
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='SER' AND STATUS=:STATUS;




