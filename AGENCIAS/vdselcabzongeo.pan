# M�dulo   : VDSELCABZONGEO.PAN
# Funci�n  : Seleccion de zonas geograficas
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CABECERAS DE ZONAS GEOGRAFICAS
Zona                                           Sel.
__________ _40________________________________    _
|

TABLA=VDZONAGEOCAB

SELECT=DECODE(VD.CONTIENE(:RANGOZONAS,CODZONAGEO),1,'S','N') SEL;

POSTQUERY=FMODIFICA
PRECOMMIT=FEJECUTA("CBORRARANGO","No puedo borrar el rango")
PREUPDATE=FEJECUTA("CANADEARANGO","No puedo a�adir la zona al rango")
POSTCOMMIT=FPULSATECLAS("F10")

NOINSERT
NODELETE
NOUPDATE

CAMPO=RANGOZONAS,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODZONAGEO,NOUPDATE,TOOLTIP("C�digo de zona geogr�fica")
CAMPO=DESZONAGEO,TOOLTIP("Designaci�n de la zona geogr�fica")
CAMPO=SEL,AUXILIAR,UPPER,POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)")

CURSOR=CBORRARANGO SELECT '' RANGOZONAS FROM DUAL;

CURSOR=CANADEARANGO SELECT :RANGOZONAS||DECODE(:SEL,'S',DECODE(:RANGOZONAS,NULL,'',',')||:CODZONAGEO,'') RANGOZONAS FROM DUAL;



#TECLA=SF10,FLEEMENU("VDCABZONGEO.ZOO")



AYUDA=MANTENIMIENTO DE ZONAS GEOGRAFICAS

ONLINE={F1} Ayuda  {F4} Confirmar Cambios  {F6} Cambio de pantalla {F9} Borrar Registro;
