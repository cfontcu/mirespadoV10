# M�dulo   : VDTIPOCOMEN.PAN
# Funci�n  : Mantenimiento de tipo de comentarios
#
# Creaci�n : 20-11-2007
# Autor    : FGS
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE TIPOS DE COMENTARIO
                                        Max.                                              
Ord Tabla          Tipo           Not. L�neas Descripci�n               Priv. Ver     Priv. Modif   Priv. Insertar Ultima modificaci�n
@L  _32___________ _32___________  _   @L@@@@ _40______________________ _1000________ _1000________ _1000________  _32_________ �D-MM-Y.YY ________
 
|

TABLA=VDTIPOCOMEN
ORDERBY=TABLACOMEN,ORDEN;


PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=ORDEN,TOOLTIP("Orden en el que se muestran el tipo de comentario"),TITULO("Ord"), WLONX=15
CAMPO=TABLACOMEN,TOOLTIP("Tabla a la que se asocia el tipo de comentario"),TITULO("Tabla")
CAMPO=TIPOCOMEN,TOOLTIP("Tipo de comentario"),TITULO("Tipo")
CAMPO=NOTIFICABLE,UPPER,TOOLTIP("Indica si los eventos de este tipo de comentario deben notificarse autom�ticamente.\n"
                                "Valores posibles S(�), N(o) o blanco"),
                        POSTCHANGE=FVERIFICA("SN ","Valores posibles S(�) N(o) o blanco"),TITULO("Not"), WLONX=15
CAMPO=MAXLINEAS,TOOLTIP("Numero m�ximo de lineas de comentarios que puede tener un objeto de este tipo; 0 ilimitado"),TITULO("Max Lineas"),WLONX=35
CAMPO=DESTIPOCOMEN,TOOLTIP("Descripci�n del comentario"),POSTCHANGE=FVALNOCERO("Debe introducir designacion del tipo de comentario"),TITULO("Descripci�n")
CAMPO=PRIVILEGIOSVER,PROTECT("IMPLANTADOR"),TITULO("Priv. Ver"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=PRIVILEGIOSMOD,PROTECT("IMPLANTADOR"),TITULO("Priv. Modif"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=PRIVILEGIOSINS,PROTECT("IMPLANTADOR"),TITULO("Priv. Insert"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en la que se realiz� la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en la que se realiz� la Ultima modificaci�n")

CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


