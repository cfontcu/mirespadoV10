# M�dulo   : VDGRAFICA.PAN
# Funci�n  : PANTALLA DE DEFINICI'ON DE GRAFICAS EN V10
#
# Creaci�n : 26-01-2010
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE GRAFICAS DE ESTADISTICAS
NOMBREGRAF   DESGRAFICA             TITULOGRAF          LEYENDAGRAF  L CAMPOX        VDEXTRA   Ult. Modificaci�n  
_32_________ _1024_________________ _255_______________ _255________ @ _32__________ _255_____ _32___ �D-MM-Y.YY ________
|

TABLA=VDGRAFICA
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=NOMBREGRAF,TOOLTIP("Nombre de la gr�fica"),TITULO("Gr�fica")
CAMPO=DESGRAFICA,TOOLTIP("Descripci�n de la gr�fica"),TITULO("Descripci�n")
CAMPO=TITULOGRAF,TOOLTIP("T�tulo a mostrar en la gr�fica"),TITULO("T�tulo")
CAMPO=LEYENDAGRAF,TOOLTIP("T�tulo de la Leyenda de la gr�fica;  NULL no se muestra"),TITULO("Leyenda")
CAMPO=LEYENDAESTADO,TOOLTIP("Estado de la leyenda del grafico; 0 oculta, 1 minimizada, 2 maximizada"),COMBOX("CLEYENDAESTADO"),WLONX=16
CAMPO=CAMPOX,TOOLTIP("Campo del bloque de los valores del eje x de la gr�fica (eje y si orientacion es horizontal)"),TITULO("Campo")
CAMPO=VDEXTRA,TOOLTIP("Campo extra para informaci�n adiccional"),TITULO("Inf. Adicc.")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modif.")
CAMPO=FECMODIF,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora de la Ultima modificaci�n")

# PARTE PERSONALIZADA DE LA PANTALLA 
CURSOR=CLEYENDAESTADO SELECT '0','OCULTO' FROM DUAL UNION
                      SELECT '1','MINIMIZADO' FROM DUAL UNION 
                      SELECT '2','MAXIMIZADO' FROM DUAL; 