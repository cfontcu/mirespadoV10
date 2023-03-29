# M�dulo   : VDGRUPOPROP.PAN
# Funci�n  : Mantenimiento de grupos de propiedades
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE CONFIGURACION
Grupo                                                Privilegios para ver               Ultima modificaci�n
____________________ _40____________________________ _1000_____________________________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDGRUPOPROP

WHERE=VDUSER.TENGOPRIVILEGIO(PRIVILEGIOSVER)=1;
ORDERBY=GRUPOPROP;


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=GRUPOPROP,NOUPDATE,TOOLTIP("C�digo del grupo de propiedades"),TITULO("Grupo")
CAMPO=DESGRUPOPROP,MIXED,TOOLTIP("Designaci�n del grupo de propiedades"),TITULO("Descripci�n")
CAMPO=PRIVILEGIOSVER,TOOLTIP("Privilegios necesarios para ver el grupo"),TITULO("Privilegios para ver"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




