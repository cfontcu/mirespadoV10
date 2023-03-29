# M�dulo   : VDGRAFICASERIE.PAN
# Funci�n  : PANTALLA DE DEFINICION DE SERIES DE GRAFICAS EN V10
#
# Creaci�n : 26-01-2010
# Autor    : FGS
# Fichero generado por el Asistente de Generaci�n de Pantallas V10 
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE SERIES DE GRAFICAS DE ESTADISTICAS

 N�mero: @L Tipo: __________ Campo: _32___________  T�tulo: _255____________________________________  Offset X: @L@ Offset Y: @L@              
 
 ����� Leyenda ����  ������� Valores �������  ����� Graf. Barras ����  ���� Series y L�neas ����  ������ Graf. Pastel ������
 �                �  � Color: _32_________ �  �                     �  � Punto                 �  �                        �
 � Visible:   _   �  � Ancho:       @L     �  � Agrupar Barras: _   �  �   tama�o:@L           �  � Porc. Ancho: @L        �
 � Desglosar: _   �  � Opacidad:    @L     �  � Orientaci�n:    _   �  �   color: _32_________ �  � Porc. Alto:  @L        �
 �                �  � Ancho Borde: @L     �  �                     �  � Borde Punto           �  � Posici�n: _32________  �
 �                �  � Opac. Borde: @L     �  �                     �  �   tama�o:@L           �  � Ver Etiq.     _        �
 �                �  �                     �  �                     �  �   color: _32_________ �  �                        �
 ������������������  �����������������������  �����������������������  �������������������������  ��������������������������
                                                                      
  Inf. Adiccional: _255__________________  Ult. Modificaci�n: _32_________ �D-MM-Y.YY ________   


|                                                                   

TABLA=VDGRAFICASERIE
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN CSELMODIF")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

# LISTA DE CAMPOS DE LA PANTALLA
CAMPO=NOMBREGRAF,VIRTUAL,TOOLTIP("Nombre de la gr�fica"),OCULTO
CAMPO=NUMSERIE,TOOLTIP("N�mero de serie en la gr�fica")
CAMPO=TIPOSERIE,TOOLTIP("Tipo de Serie: Linea, Barras, Area o Pastel"),COMBOX("BARRAS","LINEA","AREAS","PASTEL")
CAMPO=CAMPOSERIE,TOOLTIP("Campo del bloque del cual se muestran los valores en la serie")
CAMPO=TITULOSERIE,TOOLTIP("Titulo de la serie")
CAMPO=PADDINGX,TOOLTIP("Desplazamiento de los valores en el eje X (horizotalmente)")
CAMPO=PADDINGY,TOOLTIP("Desplazamiento de los valores de la gr�fica en el eje Y (verticalmente)")

CAMPO=COLORVALORSERIE,TOOLTIP("Color de los valores de la serie"),COMBOX("COLOR")
CAMPO=LEYENDASERIE,TOOLTIP("Si se incluye la serie en la leyenda de la gr�fica"),CHECKBOX("N","S")
CAMPO=ANCHOVALORSERIE
CAMPO=AGRUPARBARRAS,TOOLTIP("En serie de barras, si se agrupan barras "),CHECKBOX("N","S")
CAMPO=TAMA�OPUNTO,TOOLTIP("Tama�o de los puntos"),COMBOX("0","1","2","3","4","5","6","7","8","9","10")
CAMPO=ANCHOPIE,TOOLTIP("Porcentaje de anchura del pastel de 0(100) a 99")
CAMPO=LEYENDAARBOL,TOOLTIP("Si se despliegan los valores de la serie en el leyenda, a modo de �rbol"),CHECKBOX("N","S")
CAMPO=OPACIDADVALORSERIE,TOOLTIP("Opacidad de los valores de la serie (linea, barra o sector de pastel) ")
CAMPO=ORIENTACION,COMBOX("CORIENTACION")
CAMPO=COLORPUNTO,TOOLTIP("Color de los puntos de las l�neas o �reas "),COMBOX("COLOR")
CAMPO=ALTOPIE,TOOLTIP("Porcentaje de altura del pastel de 0(100) a 99")
CAMPO=ANCHOBORDESERIE,TOOLTIP("Ancho del borde de los valores de la serie  ")
CAMPO=POSICIONPIE,TOOLTIP("Posici�n del pasten en el DIV de la gr�fica"),MIXED,COMBOX("left","right","center","topLeft","topCenter","topRight","centerLeft","centerRight","bottomLeft","bottomCenter","bottomRight")
CAMPO=OPACIDADBORDERSERIE,TOOLTIP("Opacidad del borde de los valores de la serie")
CAMPO=ANCHOBORDEPUNTO,TOOLTIP("Ancho del borde de los puntos"),COMBOX("0","1","2","3","4","5","6","7","8","9","10")
CAMPO=VERLABELPIE,TOOLTIP("Muestra etiquetas de sectores del pastel S/N"),CHECKBOX("N","S")

CAMPO=COLORBORDEPUNTO,TOOLTIP("Color de los bordes de estos puntos "),COMBOX("COLOR")


CAMPO=VDEXTRA,TOOLTIP("Campo V10 para informaci�n adiccional")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

# PARTE PERSONALIZADA DE LA PANTALLA 
CURSOR=CORIENTACION SELECT 'V','VERTICAL' FROM DUAL UNION SELECT 'H','HORIZONTAL' FROM DUAL;