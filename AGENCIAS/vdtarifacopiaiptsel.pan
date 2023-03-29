# M�dulo   : VDTARIFACOPIA.PAN
# Funci�n  : Copia una tarifa existente con los incrementos porcentuales configurados en ese momento.
#
# Creaci�n : 16-02-2009
# Autor    : Sergio Rojo 
########################################### 
COPIAR TARIFA CON INCREMENTOS PORCENTUALES

 C�digo    Tarifa Original       Tarifa Copia         Entorno     Inc.    Conf. Validez Copia Hasta Copia  Sel
 @L@@@@@@@ _20_________________  _20_________________ _30________ #L#.##  _     �D-MM-Y.YY    �D-MM-Y.YY     _

|

POSY=2
POSX=2
REGPAG=34

NOINSERT
NODELETE
NOUPDATE

TABLA=VDTARIFA
#Informamos los campos de fecha desde y hasta con el primer y ultimo dia del a�o actual.
#Informamos el C�digo de tarifa con el el a�o actual concantenado con el nombre de la tarifa a copiar
SELECT= 'N' SEL, TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')))||'-'||CODTARIFA CODTARIFACOPIA,
        TO_CHAR(TO_DATE('0101'||TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))),'DDMMYYYY'),'J') FECDESDECOPIA,
        TO_CHAR(TO_DATE('3112'||TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))),'DDMMYYYY'),'J') FECHASTACOPIA;
ORDERBY=SEQTARIFA ASC;

PREUPDATE=FEJECUTA("@CVERSEL","",
                   "CVALIDATARIFACOPIA","Ya existe una ruta con ese C�digo de Tarifa.",
                   "CCOPIATARIFA","Error en funci�n - COPIATARIFA -",
                   "CCOMMIT","No puedo hacer commit")

POSTCOMMIT=FPULSATECLAS("F5")
               
                   

CAMPO=SEQTARIFA,NOUPDATE,NOUPDATE,TITULO("C�digo")
CAMPO=CODTARIFA,TOOLTIP("C�digo de la tarifa"),NOUPDATE,TITULO("Tarifa Original")
CAMPO=CODTARIFACOPIA,UPPER,AUXILIAR,TOOLTIP("C�digo de la tarifa"),TITULO("Tarifa Copia")
CAMPO=ENTORNO,UPPER,AUXILIAR,TOOLTIP("Indica el entorno para simulaciones distinto de real")
CAMPO=INCREMENTO,AUXILIAR,TOOLTIP("Incremento lineal en todos los campos")
CAMPO=INCCONF,AUXILIAR,POSTCHANGE=FVERIFICA(" SN","Indica si los incrementos se sacan de configuracion")
CAMPO=FECDESDECOPIA,AUXILIAR,TOOLTIP("Fecha inicio de validez de la tarifa"),TITULO("Validez Copia"),COMBOX("CALENDARIO")
CAMPO=FECHASTACOPIA,AUXILIAR,TOOLTIP("Fecha de final de validez de la tarifa"),TITULO("Hasta Copia"),COMBOX("CALENDARIO")
CAMPO=SEL,AUXILIAR,UPPER,TITULO("Sel"),WLONX=15


######################################################################################################
####################### CAMPOS OCULTOS ###############################################################
######################################################################################################
CAMPO=SEQTARIFACOPIA,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=DUMMY,AUXILIAR,OCULTO,"@"



CURSOR=CCOPIATARIFA BEGIN 
  IF NVL(:INCCONF,'N')='S' THEN 
     :SEQTARIFACOPIA := VDAUTOFAC.COPIATARIFAIPT ( :SEQTARIFA, :ENTORNO,:FECDESDECOPIA, :FECHASTACOPIA, :CODTARIFACOPIA);
   ELSE
     :SEQTARIFACOPIA := VDAUTOFAC.COPIATARIFA( :SEQTARIFA, :ENTORNO,:FECDESDECOPIA, :FECHASTACOPIA, :CODTARIFACOPIA,:INCREMENTO);
   END IF;
  
  COMMIT; 
END;@ 

                   
CURSOR=CVALIDATARIFACOPIA SELECT 1 DUMMY FROM DUAL WHERE NOT EXISTS (SELECT CODTARIFA FROM VDTARIFA
                                                                                     WHERE CODTARIFA=:CODTARIFACOPIA);

CURSOR=CVALIDAFECHAS SELECT 1 DUMMY FROM DUAL WHERE (:FECDESDECOPIA<>'' ) AND (:FECHASTACOPIA<>'' );

CURSOR=CCOMMIT COMMIT;

CURSOR=CVERSEL SELECT :SEL SEL FROM DUAL WHERE :SEL='S';


AYUDA=COPIAR TARIFAS
ONLINE={F1} Ayuda      {F4} CREAR COPIA DE TARIFAS SELECIONADAS    {F6} Cambio de pantalla    {F9} Borrar Registro;
