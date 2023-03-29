# M�dulo   : VDCOMPUBIEST.PAN
# Funci�n  : Compatibilidades de ubicaciones con la clasificaci�n EMBALAJES.
#            CODCLASIF siempre debe ser EMBALAJES, por defecto se graba EMBALAJES.
#
# Creaci�n : 15-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
COMPATIBILIDAD CON EMBALAJES
 
Clasif         Clase           Embalaje             P. Ult Modif:
______________ _______________ ____________________ @L �DD-MM-Y.YYY 

|
TABLA=VDUBIEMBA
ORDERBY=CODCLASE,TIPOEMBA,PRIOEMBA;


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL INSERTAR COD. OPERARIO Y FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL ACTUALIZAR COD. OPERARIO Y FECHA")

CAMPO=CODCLASIF,TITULO("Clasif.")
CAMPO=CODCLASE,WLONX=30,UPPER,TOOLTIP("C�digo de la clase de ubicaciones dentro de la clasificaci�n EMBALAJES"),
      POSTCHANGE=FEJECUTA("CCLASEU","No existe la clase :CODCLASE en la clasificaci�n EMBALAJES"),TITULO("Clase 'EMBALAJES'")
CAMPO=TIPOEMBA,WLONX=30,UPPER,TOOLTIP("C�digo del embalaje a asignar a una ubicaci�n"),TITULO("Tipo Embalaje")
CAMPO=PRIOEMBA, TOOLTIP("Prioridad con la que asignaremos una clase de ubicaci�n a un tipo de embalaje"),TITULO("Prio"), WLONX=15
CAMPO=CODOPEMODIF,OCULTO," _32__________", NOENTER, TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF, NOENTER, TOOLTIP("Ult. Modificaci�n: :CODOPEMODIF :FECMODIF :HORAMODIF"),TITULO("Ult. Modif.")
CAMPO=HORAMODIF, OCULTO,"_8________", NOENTER, TOOLTIP("Hora en que se realiz� la Ultima modificaci�n")


#CURSORES

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCLASEU SELECT CODCLASE FROM VDCLASES WHERE CODCLASIF=:CODCLASIF AND CODCLASE=:CODCLASE;






