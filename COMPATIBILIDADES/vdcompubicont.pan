# M�dulo   : VDCOMPUBICONT.PAN
# Funci�n  : Compatibilidades de clases de ubicaciones con contenedores
#
# Creaci�n : 15-11-2007
# Autor    : ICC
###########################################
# Hist�rico de cambios:
COMPATIBILIDAD CON TIPOS DE CONTENEDORES 

                                   Tipo de                           Altura      Peso
Clasif.Ubicaci�n Clase Ubicaci�n   contenedor                        M�x.(cc)   M�x.(gr)    Prio.   Ult. Modif.
 _______________ _______________   __________ _20___________________ #L####### #L#,###,###  @L@     _32__________ �DD-MM-Y.YYY  

|
TABLA=VDUBICONTE
ORDERBY=CODCLASIF,CODCLASE,TIPOCONTE,PRIOUBI;

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL INSERTAR COD. OPERARIO Y FECHA")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL ACTUALIZAR COD. OPERARIO Y FECHA")

CAMPO=CODCLASIF,TOOLTIP("C�digo de la clasificaci�n de ubicaciones que se asigna a un tipo de contenedor"),TITULO("Clasif.Ubicaci�n")
CAMPO=CODCLASE,TOOLTIP("C�digo de la clase de ubicaciones dentro de la clasificaci�n que se parametriza"),
               POSTCHANGE=FEJECUTA("CCLASEU","No existe la clase :CODCLASE en la clasificaci�n :CODCLASIF"),TITULO("Clase Ubicaci�n")
CAMPO=TIPOCONTE,TOOLTIP("C�digo del contenedor a asignar a una ubicaci�n"),
                POSTCHANGE=FEJECUTA("CTIPOCONTE","TIPO DE CONTENEDOR NO EXISTE O NO ES MOVIBLE","+CTIPOCONTE2",""),TITULO("Tipo Conte")
CAMPO=DESTIPOCONTE,AUXILIAR,NOENTER,TITULO("")
CAMPO=ALTURAMAX,TOOLTIP("Altura maxima de los contenedores a ubicar en esta clase de ubicaci�n, en cent�metros"),TITULO("Alt.Max (cc)"),WLONX=45
CAMPO=PESOMAX,TOOLTIP("Peso m�ximo de los contenedores a ubicar en esta clase de ubicaci�n, en gramos"),TITULO("Peso.Max (gr)"), WLONX=45
CAMPO=PRIOUBI, TOOLTIP("Prioridad con la que asignaremos una clase de ubicaci�n a un tipo de contenedor"),TITULO("Prio"), WLONX=18
CAMPO=CODOPEMODIF, NOENTER, TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF, NOENTER, TOOLTIP("Ult. Modificaci�n: :CODOPEMODIF :FECMODIF :HORAMODIF")
CAMPO=HORAMODIF,OCULTO,"_8________", NOENTER, TOOLTIP("Hora en que se realiz� la Ultima modificaci�n")


#CURSORES

CURSOR=CPONCLASIF SELECT 'UBICACIONES' OBJCLASIF,'CONTENEDORES' CODCLASIF FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CCLASEU SELECT CODCLASE FROM VDCLASES WHERE CODCLASIF=:CODCLASIF AND CODCLASE=:CODCLASE ;

CURSOR=CTIPOCONTE SELECT :TIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE AND MOVIBLE='S';

CURSOR=CTIPOCONTE2 SELECT DESTIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE=:TIPOCONTE;


