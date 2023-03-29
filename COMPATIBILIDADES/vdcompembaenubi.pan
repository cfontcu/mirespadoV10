# M�dulo   : VDCOMPUBIEST.PAN
# Funci�n  : Compatibilidades de ubicaciones con la clasificaci�n EMBALAJES.
#            CODCLASIF siempre debe ser EMBALAJES, por defecto se graba EMBALAJES.
#
# Creaci�n : 15-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
COMPATIBILIDAD CON EMBALAJES CON CLASES DE UBICACION
 
 Tipo Embalaje   Clase Ubicaci�n        Prio     Ult. Modif.
  __________     _______________         @L@     �DD-MM-Y.YYY 

|
TABLA=VDUBIEMBA
ORDERBY=TIPOEMBA,PRIOEMBA,CODCLASE;


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL INSERTAR COD. OPERARIO Y FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL ACTUALIZAR COD. OPERARIO Y FECHA")

CAMPO=TIPOEMBA,UPPER,TOOLTIP("C�digo del embalaje a asignar a una ubicaci�n"),
              POSTCHANGE=FEJECUTA("CEMBALAJE","NO EXISTE TIPO DE EMBALAJE"),TITULO("Tipo Embalaje"), WLONX=45
CAMPO=CODCLASE,UPPER,TOOLTIP("C�digo de la clase de ubicaciones dentro de la clasificaci�n EMBALAJES"),
      POSTCHANGE=FEJECUTA("CCLASEU","No existe la clase :CODCLASE en la clasificaci�n EMBALAJES"),TITULO("Clase Ubicaci�n"), WLONX=55
CAMPO=PRIOEMBA, TOOLTIP("Prioridad con la que asignaremos una clase de ubicaci�n a un tipo de embalaje"),TITULO("Prioridad"), WLONX=40
CAMPO=CODOPEMODIF,OCULTO," _32__________", NOENTER, TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF, NOENTER, TOOLTIP("Ult. Modificaci�n: :CODOPEMODIF :FECMODIF :HORAMODIF"),TITULO("Ult. Modif."),WLONX=55
CAMPO=HORAMODIF, OCULTO,"_8________", NOENTER, TOOLTIP("Hora en que se realiz� la Ultima modificaci�n")


#CURSORES

CURSOR=CEMBALAJE SELECT :TIPOEMBA FROM VDTIPOEMBA WHERE TIPOEMBA=:TIPOEMBA;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCLASEU SELECT CODCLASE FROM VDCLASES WHERE CODCLASIF='EMBALAJES' AND CODCLASE=:CODCLASE;





