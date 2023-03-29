# M�dulo   : VDGRAFICAEJE.PAN
# Funci�n  : PANTALLA DE DEFINICION DE EJES DE GRAFICAS EN V10
#
# Creaci�n : 26-01-2010
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:   
MANTENIMIENTO DE EJES DE GRAFICAS DE ESTADISTICAS   
                                                   
 Tipo de Eje: _  T�tulo:  _255_____________________________________ Clase Css T�tulo:  _32____________        
  
 ��������� Valores ��������   ��������� Cursor Inf. ��������  ��������� Rejilla ���������  ����������� Formato ����������
 � M�x      @L@@@@@@@     �   � Texto _32_________________ �  � Grosor   @L             �  � Moneda             _       �
 � Min      @L@@@@@@@     �   � Color Fondo _32___________ �  � Color    _32___________ �  � Decimales Forzados @L      �
 � ClassCss _32__________ �   � Color Texto _32___________ �  � Opacidad @L             �  � Decimales M�ximos  @L      �
 �                        �   � ClassCss    _32___________ �  �                         �  � Separador dec. _  miles. _ �
 ��������������������������   ������������������������������  ���������������������������  ������������������������������
   
   Inf. Adiccional: _255__________________  Ult. Modificaci�n: _32_________ �D-MM-Y.YY ________ 
   
|

TABLA=VDGRAFICAEJE
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=NOMBREGRAF,VIRTUAL,TOOLTIP("Nombre de la gr�fica"),OCULTO
CAMPO=EJE,TOOLTIP("Tipo de Eje, X o Y "),COMBOX("X","Y")
CAMPO=TITULOEJE,TOOLTIP("Texto a mostrar en el Eje ")
CAMPO=CSSTITULO,TOOLTIP("Clase CSS del TITULO del eje"),MIXED,COMBOX("ejetitulo")

CAMPO=MAXVALOR,TOOLTIP("M�ximo valor del eje (si se informa)")
CAMPO=CURSORTEXTO,TOOLTIP("Prefijo del Texto de informaci�n de cursor del eje, NULO no se muestra")
CAMPO=GRIDGROSOR,TOOLTIP("Grosor de la l�nea de rejilla del eje,NULO no se muestran"),COMBOX("0","1","2","3","4","5","6","7","8","9","10")
CAMPO=VALORESMONEDA,TOOLTIP("Si se informa, valor del eje muestra monedas con este s�mbolo")
#,COMBOX("$","�","�","�"),WLONX=16
CAMPO=MINVALOR,TOOLTIP("M�nimo valor del eje (si se informa)")
CAMPO=CURSORCOLOR,TOOLTIP("Color de fondo del texto de cursor del eje  "),COMBOX("COLOR")
CAMPO=GRIDCOLOR,TOOLTIP("Color de las l�neas de rejilla  "),COMBOX("COLOR")
CAMPO=VALORESMINDEC,TOOLTIP("Si se informa, n�mero de decimales forzados en valores del eje"),COMBOX("0","1","2","3","4","5")
CAMPO=CSSVALORES,TOOLTIP("Clase CSS de los textos de valores del eje  "),MIXED,COMBOX("ejevalor","ejetitulo2","invisible")
CAMPO=CURSORTEXTCOLOR,TOOLTIP("Color del texto de cursor del eje  "),COMBOX("COLOR")
CAMPO=GRIDOPACIDAD,TOOLTIP("Opacidad de las l�neas de rejilla  ")
CAMPO=VALORESMAXDEC,TOOLTIP("Si se informa, n�mero de decimales m�ximo en valores del eje"),COMBOX("0","1","2","3","4","5")
CAMPO=CURSORCSS
CAMPO=VALORESSEPDEC,TOOLTIP("Si se informa, s�mbolo separador de decimales"),COMBOX(",",".")
CAMPO=VALORESSEPMIL,TOOLTIP("Si se informa, s�mbolo separador de miles"),COMBOX(",",".")
CAMPO=VDEXTRA,TOOLTIP("Campo reservado para informaci�n adiccional")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

# PARTE PERSONALIZADA DE LA PANTALLA 