# M�dulo   : VDIMPREASIGTIPO.PAN
# Funci�n  : Mantenimiento de Asignaci�n de Informes a Impresoras
#
# Creaci�n : 13-05-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ASIGNACION DE INFORMES
Usuario       Ordenador        Impresora         Nombre de Documento                      Activo Ult. Modificaci�n            
_32__________ _32_____________ _15______________ _256____________________________________   _    _32_________ �D-MM-Y.YY ________
|

TABLA=VDIMPREASIG
ORDERBY=ORDENADOR;

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=TIPOIMPRE,VIRTUAL,OCULTO
CAMPO=CODOPEASIG,TOOLTIP("Usuario que realiza la impresi�n"),TITULO("Usuario"),COMBOX("CLISTAUSU")
CAMPO=ORDENADOR,TOOLTIP("Ordenador desde el que se imprime. 'DEFECTO' para cualquiera"),TITULO("Ordenador")
CAMPO=CODIMPRE,TOOLTIP("C�digo V10 de la impresora asignada"),TITULO("Impresora"),COMBOX("CLISTAIMPRE")
CAMPO=DOCUMENTO,TOOLTIP("Documento que se imprime. 'DEFECTO' para cualquiera. No se indica ruta completa, se buscar� en el Path"),TITULO("Documento")
CAMPO=ACTIVO,TOOLTIP("Si la asignaci�n est� activa actualmente"),POSTCHANGE=FEJECUTA(FVERIFICA("NS"),"CAMPO ACTIVO DEBE SER 'S' O 'N'"),TITULO("Act"),WLONX=15
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

CURSOR=CLISTAUSU SELECT DISTINCT CODOPE,NOMBRE || ' ' || APELLIDO1 ||' ' || APELLIDO2 FROM VDUSUARIO ORDER BY CODOPE;
CURSOR=CLISTAIMPRE SELECT CODIMPRE,DESIMPRE,SPOOL,DRIVER,FICHERO,DECODE(TIPOCONEX,0,'sin conex', 1, 'TCP cerrando socket',2, 'RS232',3,'TCP manteniendo socket') MITIPOCONEX 
                             FROM VDIMPRESORAS IMP, VDIMPREGRUPO IGR 
                             WHERE IMP.GRUPOIMPRE= IGR.GRUPOIMPRE AND
                                   IMP.ACTIVO='S' AND
                                   IGR.ACTIVO='S' 
                               ORDER BY CODIMPRE;
                                 
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



