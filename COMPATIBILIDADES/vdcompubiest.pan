# M�dulo   : VDCOMPUBIEST.PAN
# Funci�n  : Compatibilidades de ubicaciones con la clasificaci�n estados.
#            CODCLASIF siempre debe ser estados, por defecto se graba estados.
#
# Creaci�n : 15-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
COMPATIBILIDAD CON ESTADOS DE MERCANCIA
 
Clasif         Clase           Patr�n               Ult Modif:
______________ _______________ ____________________ �DD-MM-Y.YYY 

|
TABLA=VDUBIESTADO


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL INSERTAR COD. OPERARIO Y FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL ACTUALIZAR COD. OPERARIO Y FECHA")

CAMPO=CODCLASIF,TITULO("Clasif.")
CAMPO=CODCLASE,WLONX=20,UPPER,TOOLTIP("C�digo de la clase de ubicaci�n dentro de la clasificaci�n ESTADOS"),
      POSTCHANGE=FEJECUTA("CCLASE","No existe la clase :CODCLASE en la clasificaci�n ESTADOS"),TITULO("Clase 'ESTADOS'")
CAMPO=PATRONESTADO,TOOLTIP("M�scara patr�n de estados con la que se exige compatibilidad"),
      POSTCHANGE=FVALNOCERO("EL PATRON DE LA UBICACION NO PUEDE SER NULO"),TITULO("Patr�n")
CAMPO=CODOPEMODIF,OCULTO,"_32__________", NOENTER, TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF, NOENTER, TOOLTIP("Ult. Modificaci�n: :CODOPEMODIF :FECMODIF :HORAMODIF"),TITULO("Ult. Modif.")
CAMPO=HORAMODIF, OCULTO,"_8________",NOENTER, TOOLTIP("Hora en que se realiz� la Ultima modificaci�n")



#CURSORES

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCLASE SELECT CODCLASE FROM VDCLASES WHERE CODCLASIF=:CODCLASIF AND CODCLASE=:CODCLASE;
