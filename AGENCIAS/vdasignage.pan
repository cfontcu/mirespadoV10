###################################################################
#M�dulo: VDASIGNAGE.PAN
#Funcionalidad : Mantenimiento de asignacion de agencias
#Autor: FPD      
#Fecha: 08-04-2008
###################################################################
# Hist�rico de cambios:
MANTENIMIENTO DE ASIGNACION DE AGENCIAS
 
  Id: @L@@@@@@@    Agencia  _10_______ _30____________________________
  
  Entorno _30________________________________ Prioridad de asignaci�n @L@         
 
  Informaci�n: _255______________________________________________________
 
 ��� Art�culo �����������������������������������������������������������������������������������������������������������
 �                                                                                                        Peso Valor    � 
 �  C�digo de art�culo    _1024_______________________________ _255_____________________________________    @@@@@       � 
 �                                                                                                                      � 
 �  Clase                 _1024_______________________________ _255_____________________________________    @@@@@       � 
 �                                                                                                                      � 
 �  Divisi�n del art�culo _1024_______________________________ _255_____________________________________    @@@@@       � 
 �                                                                                                                      � 
 ������������������������������������������������������������������������������������������������������������������������
 
 ��� Pedido �������������������������������������������������������������������������������������������������������������    
 �                                                                                                                      � 
 �  Cliente         _1024_______________________________________________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Tipo de pedido  _1024_______________________________________________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Div. del pedido _1024__________________________________ _255________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Rango DP        _1024_______________________________________________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Zona geografica _255___________________________________ _255________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Pa�ses          _1024__________________________________ _255________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Rango Bultos    ____________________________________________________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Rango Peso      _1024_____________________________________________________________________________ Gr.  @@@@@       �
 �                                                                                                                      �
 �  Rango Volumen   _1024__________________________________________________________________________ Litros  @@@@@       �
 �                                                                                                                      �
 �  Rango Agencia:  _1024__________________________________ _255________________________________________    @@@@@       �
 �                                                                                                                      �
 �  Urgencia @L          Prioridad @L@@                                                         Peso Tarifa @@@@@       �
 �                                                                                                                      �
 ������������������������������������������������������������������������������������������������������������������������   

   Ultima modificaci�n _32_______ �D-MM-YY.Y ________  
| 


PROTECT("SUPERVISOR")

TABLA=VDASIGNAGE
ORDERBY=CODAGE;


PREINSERT=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.","CNEXTAGASI","No puedo calcular siguiente secuencial")
PREUPDATE=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.")

CAMPO=SECASIGNAGE,NOENTER,TOOLTIP("C�digo que identifica la regla de asignaci�n de agencia")
CAMPO=CODAGE,UPPER,POSTCHANGE=FDESIGNACION("CSELDESAGE","No existe agencia"),TOOLTIP("C�digo de agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n completa de la agencia")
CAMPO=ENTORNO,TOOLTIP("Entorno de asignacion REAL es el productivo")
CAMPO=PRIORIDADREGLA,TOOLTIP("Es la prioridad para asignar la prioridad,siendo 1 la mas alta y 999 O 0 la mas baja")
CAMPO=VDEXTRA,TOOLTIP("Informaci�n extra �til para el cliente")
CAMPO=RANGOCODART,POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),TOOLTIP("C�digo de art�culo (Admite seleccion multiple separada por ,)")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Descripci�n completa del art�culo")
CAMPO=PESORANGOCODART
CAMPO=RANGOCODCLASE,POSTCHANGE=FDESIGNACION("CSELCLASE","No existe clase de articulos"),TOOLTIP("C�digo de clase de art�culo (Admite seleccion multiple separada por ,)")
CAMPO=DESCLASE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la clase de articulo")
CAMPO=PESORANGOCODCLASE
CAMPO=RANGOCODDIVART,POSTCHANGE=FDESIGNACION("CSELDESDIVART","No existe division del art�culo"),TOOLTIP("C�digo de divisi�n del art�culo (Admite seleccion multiple separada por ,)")
CAMPO=DESDIVART,AUXILIAR,NOENTER,TOOLTIP("Descripci�n completa de la divisi�n del art�culo")
CAMPO=PESORANGOCODDIVART
CAMPO=RANGOCLIENTE,TOOLTIP("C�digo de cliente (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGOCLIENTE
CAMPO=RANGOTIPOPEDIDO,TOOLTIP("Rango de tipos de pedido (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGOTIPOPEDIDO
CAMPO=RANGOCODDIVPED,POSTCHANGE=FDESIGNACION("CSELDESDIVCP","No existe division del pedido"),TOOLTIP("C�digo de divisi�n del pedido (Admite seleccion multiple separada por ,)")
CAMPO=DESDIVCP,AUXILIAR,NOENTER,TOOLTIP("Descripci�n completa de la divisi�n del pedido")
CAMPO=PESORANGOCODDIVPED
CAMPO=RANGODP,TOOLTIP("Rango de distritos postales (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGODP
CAMPO=RANGOZONAGEO,POSTCHANGE=FDESIGNACION("CSELZONAGEO","No existe zona geografica"),TOOLTIP("Rango de zonas geogr�ficas (Admite seleccion multiple separada por ,)")
CAMPO=DESZONAGEO,AUXILIAR,NOENTER
CAMPO=PESORANGOZONAGEO
CAMPO=RANGOCODPAIS,POSTCHANGE=FDESIGNACION("CSELPAISES","No existe el C�digo del pa�s"),TOOLTIP("Rango de C�digos de pa�ses (Admite seleccion multiple separada por ,)")
CAMPO=DESPAIS,AUXILIAR,NOENTER
CAMPO=PESORANGOCODPAIS
CAMPO=RANGOBULTOS,POSTCHANGE=FDESIGNACION("CVERBULTOSNUM","Los rangos de bultos han de ser numericos\n:MSGERROR"),TOOLTIP("Rango de n�mero de bultos (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGOBULTOS
CAMPO=RANGOPESO,POSTCHANGE=FDESIGNACION("CVERPESONUM","Los rangos de pesos han de ser numericos\n:MSGERROR"),TOOLTIP("Rango de pesos en gramos (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGOPESO
CAMPO=RANGOVOLUMEN,POSTCHANGE=FDESIGNACION("CVERVOLUMENNUM","Los rangos de volumen han de ser numericos\n:MSGERROR"),TOOLTIP("Rango de volumen en litros (Admite seleccion multiple separada por ,)")
CAMPO=PESORANGOVOLUMEN
CAMPO=RANGOCODAGE,POSTCHANGE=FDESIGNACION("CSELAGEN","No existe C�digo de Agencia Original (Admite seleccion multiple separada por ,)"),TOOLTIP("Rango de C�digos de Agencia Original (Admite seleccion multimple separada por ,)")
CAMPO=DESAGEOR, AUXILIAR,NOENTER,TOOLTIP("Descripcion del C�digo de Agencia")
CAMPO=PESORANGOCODAGE
CAMPO=URGENCIA,TOOLTIP("Urgencia del pedido (0-99)")
CAMPO=PRIORIDAD,TOOLTIP("Prioridad del pedido (0-99)")
CAMPO=PESOTARIFA
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("C�digo de Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,UPPER,NOENTER,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")
CAMPO=MSGERROR,AUXILIAR,OCULTO,"_1024"

CURSOR=CNEXTAGASI SELECT VDSECASIGNAGE.NEXTVAL SECASIGNAGE FROM DUAL;

CURSOR=CMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF
                FROM DUAL;

CURSOR=CVERPESONUM SELECT VDAGE.VALIDORANGONUM(:RANGOPESO) MSGERROR FROM DUAL WHERE VDAGE.VALIDORANGONUM(:RANGOPESO) IS NULL OR :RANGOPESO = '%';

CURSOR=CVERVOLUMENNUM SELECT VDAGE.VALIDORANGONUM(:RANGOVOLUMEN) MSGERROR FROM DUAL WHERE VDAGE.VALIDORANGONUM(:RANGOVOLUMEN) IS NULL OR :RANGOVOLUMEN ='%'; 

CURSOR=CVERBULTOSNUM SELECT VDAGE.VALIDORANGONUM(:RANGOBULTOS) MSGERROR FROM DUAL WHERE VDAGE.VALIDORANGONUM(:RANGOBULTOS) IS NULL OR :RANGOBULTOS = '%';

CURSOR=CSELDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE;

CURSOR=CSELZONAGEO SELECT DESZONAGEO FROM VDZONAGEOCAB WHERE CODZONAGEO=:RANGOZONAGEO
                    UNION
                   SELECT '' DESZONAGEO FROM DUAL WHERE :RANGOZONAGEO IS NULL OR :RANGOZONAGEO='%'
                    UNION
                   SELECT NVL(VDAGE.VALIDORANGO('VDZONAGEOCAB','CODZONAGEO',:RANGOZONAGEO),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOZONAGEO,',')>0 OR INSTR(:RANGOZONAGEO,'-')>0);

CURSOR=CSELPAISES SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:RANGOCODPAIS
                    UNION
                   SELECT '' DESPAIS FROM DUAL WHERE :RANGOCODPAIS IS NULL OR :RANGOCODPAIS ='%'
                    UNION
                   SELECT NVL(VDAGE.VALIDORANGO('VDPAIS','CODPAIS',:RANGOCODPAIS),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODPAIS,',')>0 OR INSTR(:RANGOCODPAIS,'-')>0);


CURSOR=CSELCLASE SELECT DESCLASE FROM VDCLASES WHERE CODCLASIF=NVL(VD.GETPROP('CLASIFASIGNAGE'),'ASIGNAGE') AND CODCLASE=:RANGOCODCLASE
                  UNION
                 SELECT '' DESCLASE FROM DUAL WHERE :RANGOCODCLASE IS NULL OR :RANGOCODCLASE = '%'
                  UNION
                 SELECT NVL(VDAGE.VALIDORANGO('VDCLASES','CODCLASE',:RANGOCODCLASE),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODCLASE,',')>0 OR INSTR(:RANGOCODCLASE,'-')>0);

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:RANGOCODART
                   UNION
                  SELECT '' DESART FROM DUAL WHERE :RANGOCODART IS NULL OR :RANGOCODART = '%'
                   UNION
                  SELECT NVL(VDAGE.VALIDORANGO('VDARTIC','CODART',:RANGOCODART),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODART,',')>0 OR INSTR(:RANGOCODART,'-')>0);

CURSOR=CSELDESDIVART SELECT DESDIV DESDIVART FROM VDDIVIS WHERE CODDIV=:RANGOCODDIVART
                      UNION
                     SELECT '' DESDIVART FROM DUAL WHERE :RANGOCODDIVART IS NULL OR :RANGOCODDIVART = '%'
                      UNION
                     SELECT NVL(VDAGE.VALIDORANGO('VDDIVIS','CODDIV',:RANGOCODDIVART),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODDIVART,',')>0 OR INSTR(:RANGOCODDIVART,'-')>0);

CURSOR=CSELDESDIVCP SELECT CODDIV DESDIVCP FROM VDDIVIS WHERE CODDIV=:RANGOCODDIVPED
                     UNION
                    SELECT '' DESDIVCP FROM DUAL WHERE :RANGOCODDIVPED IS NULL OR :RANGOCODDIVPED ='%'
                     UNION
                    SELECT NVL(VDAGE.VALIDORANGO('VDDIVIS','CODDIV',:RANGOCODDIVPED),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODDIVPED,',')>0 OR INSTR(:RANGOCODDIVPED,'-')>0);

CURSOR=CSELAGEN SELECT DESAGE DESAGEOR FROM VDAGENCIA WHERE CODAGE=:RANGOCODAGE
                   UNION
                  SELECT '' DESAGEOR FROM DUAL WHERE :RANGOCODAGE IS NULL OR :RANGOCODAGE ='%'
                   UNION
                  SELECT NVL(VDAGE.VALIDORANGO('VDAGENCIA','CODAGE',:RANGOCODAGE),'SELECCION MULTIPLE') FROM DUAL WHERE (INSTR(:RANGOCODAGE,',')>0 OR INSTR(:RANGOCODAGE,'-')>0);

