# M�dulo   : VDCONFI.PAN
# Funci�n  : Mantenimiento de configuraci�n
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE PARAMETROS DE CONFIGURACION
Instancia     Propiedad             Comentario                                   T Valor                                                                  Activo Permitidos       Priv ver            Priv mod             Ultima modificaci�n
_40__________ _64__________________ _512________________________________________ _ _255__________________________________________________________________   _    _1000___________ _1000______________ _1000_______________ _32_________ �D-MM-Y.YY ________
|

TABLA=VDCONFI
WLONX=1400

WHERE=VDUSER.TENGOPRIVILEGIO(PRIVILEGIOSVER)=1;
ORDERBY=PROPIEDAD;
SELECT=DECODE(VDUSER.TENGOPRIVILEGIO(PRIVILEGIOSMOD),1,1,0) VALOR__ENTER;


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=GRUPOPROP,VIRTUAL,OCULTO
CAMPO=INSTANCIA,VIRTUAL,TITULO("Instancia")
CAMPO=PROPIEDAD,NOUPDATE("IMPLANTADOR"),TOOLTIP("Nombre del par�metro de configuraci�n"),TITULO("Propiedad")
CAMPO=COMENTARIO,NOUPDATE("IMPLANTADOR"),TOOLTIP("Designaci�n del par�metro de configuraci�n"),TITULO("Comentario")
CAMPO=TIPODATO,NOUPDATE("IMPLANTADOR"),TOOLTIP("Tipo de dato del par�metro"),TITULO("T")
CAMPO=VALOR,TOOLTIP("Valor del par�metro de configuraci�n"),
            POSTCHANGE=FEJECUTA(FIF("CESNUM",
                                    FEJECUTA("CVERPERMITIDONUM",""),
                                    FEJECUTA("CVERPERMITIDO","")),"VALOR NO PERMITIDO\nLISTA :PERMITIDOS"), TITULO("Valor"),MIXED
CAMPO=ACTIVO,UPPER,NOUPDATE("IMPLANTADOR"),TOOLTIP("Indica si la propiedad de configuraci�n est� activa o no"),
             POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),TITULO("Act"), WLONX=15
CAMPO=PERMITIDOS,NOUPDATE("IMPLANTADOR"),TOOLTIP("Rango de valores permitidos para el par�metro"),TITULO("Permitidos")
CAMPO=PRIVILEGIOSVER,NOUPDATE("IMPLANTADOR"),TOOLTIP("Privilegios necesarios para ver el par�metro"),TITULO("Privilegios Ver"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=PRIVILEGIOSMOD,NOUPDATE("IMPLANTADOR"),TOOLTIP("Privilegios para modificar el par�metro"),TITULO("Privilegios Modif"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;


CURSOR=CESNUM SELECT :TIPODATO FROM DUAL WHERE :TIPODATO='E';

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CVERPERMITIDO SELECT :PERMITIDOS FROM DUAL WHERE VD.CONTIENECAD(:PERMITIDOS,:VALOR)=1;

CURSOR=CVERPERMITIDONUM SELECT :PERMITIDOS FROM DUAL WHERE VD.CONTIENENUM(:PERMITIDOS,:VALOR)=1;


TECLA=SF6,FLEEMENU("VD$AUD.ZOO")



