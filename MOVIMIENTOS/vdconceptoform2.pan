# M�dulo   : VDCONCEPTOFORM.PAN
# Funci�n  : Mantenimiento de asignaciones de conceptos a transf./regularizaciones de stock desde pantalla
#
# Creaci�n : 05-06-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
DETALLE DE CONCEPTOS DE MOVIMIENTOS A CAMPOS DEL STOCK

 Priv
 _1024____________________________________________________________________________________________________ 
 Rango.Div
 _1000____________________________________________________________________________________________________ 
 Clases                          Ultima modificaci�n
 _15____________ _15____________ _32________ �D-MM-Y.YY  ________

|

TABLA=VDCONCEPTOFORM
ORDERBY=TIPOPROP,ORDEN;
#WFRAME(312,-1,142,0,"Entradas","")
#WFRAME(458,-1,142,0,"Salidas","")

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=TIPOPROP,VIRTUAL,OCULTO
CAMPO=ORDEN,VIRTUAL,OCULTO
CAMPO=PRIVILEGIOS,TOOLTIP("PRIVILEGIOS NECESARIOS PARA REALIZAR LA REGULARIZACION/TRANSFORMACION DE STOCK"),TITULO("Privilegios"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=RANGODIV,TOOLTIP("DIVISION A LA QUE SE LE ASIGNAN LOS CONCEPTOS( Admite seleccion multiple separada por ,)"),TITULO("Rango Div"),COMBOXMULTIPLE("CLISTADIV")
CAMPO=CODCLASIF,TOOLTIP("CLASIFICACION CONSIDERADA PARA ASIGNAR LOS CONCEPTOS"),TITULO("Clasif. / Clase Art�culos"),COMBOX("CLISTACLASIF")
CAMPO=CODCLASE,TOOLTIP("CLASE DE LA CLASIFICACION, CONSIDERADA PARA ASIGNAR LOS CONCEPTOS"),COMBOX("CLISTACLASE")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CLISTACLASIF SELECT CODCLASIF,DESCLASIF FROM VDCLASIFICACIONES WHERE TABLACLASIF='VDARTIC' ORDER BY ORDENCLASIF;

CURSOR=CLISTACLASE SELECT CODCLASE,DESCLASE FROM VDCLASES WHERE CODCLASIF=:CODCLASIF ORDER BY CODCLASE;

CURSOR=CLISTADIV SELECT CODDIV,DESDIV FROM VDDIVIS ORDER BY CODDIV;

CURSOR=CLISTAPRIV SELECT PRIVILEGIO, COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;


