RECURSOS UTILIZADOS POR LA BASE DE DATOS

  Nombre del Recurso    Utilizados Max.utilizados Asign.Inicial  Valor L�mite
  _30__________________    @@@@         @@@@      _10________    _10_________ 
|
               																			   
TABLA=V$RESOURCE_LIMIT

CAMPO=RESOURCE_NAME,NOENTER,TOOLTIP("Nombre del recurso")
CAMPO=CURRENT_UTILIZATION,NOENTER,TOOLTIP("N�mero de recursos,locks o procesos utilizados actualmente")
CAMPO=MAX_UTILIZATION,NOENTER,TOOLTIP("N�mero m�ximo de consumo del recurso")
CAMPO=INITIAL_ALLOCATION,NOENTER,TOOLTIP("N�mero de asignaci�n inicial")
CAMPO=LIMIT_VALUE,NOENTER,TOOLTIP("Ilimitado para recursos y locks.Puede ser tan grande como la asignacion inicial.UNLIMITED para limite infinito")


