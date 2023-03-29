# M�dulo   : VDIMPREASIGIMPRE.PAN
# Funci�n  : Mantenimiento de Asignaci�n de Informes a Impresoras
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ASIGNACION DE INFORMES
Usuario        Ordenador      Tipo Imp.    Nombre de Documento                      Activo Ult. Modificaci�n            
_32___________ _32___________ ____________ _256____________________________________   _    _32_________ �D-MM-Y.YY ________
|

TABLA=VDIMPREASIG
ORDERBY=ORDENADOR;

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=CODIMPRE,VIRTUAL,OCULTO
CAMPO=CODOPEASIG,TOOLTIP("Usuario que realiza la impresi�n"),TITULO("Usuario")
CAMPO=ORDENADOR,TOOLTIP("Ordenador desde el que se imprime. 'DEFECTO' para cualquiera"),TITULO("Ordenador")
CAMPO=TIPOIMPRE,TOOLTIP("Tipo de Impresi�n"),TITULO("Tipo Impr.")
CAMPO=DOCUMENTO,TOOLTIP("Documento que se imprime. 'DEFECTO' para cualquiera. No se indica ruta completa, se buscar� en el Path"),TITULO("Documento")
CAMPO=ACTIVO,TOOLTIP("Si la asignaci�n est� activa actualmente"),POSTCHANGE=FEJECUTA(FVERIFICA("NS"),"CAMPO ACTIVO DEBE SER 'S' O 'N'"),TITULO("Activo"),WLONX=20
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




