# M�dulo   : VDCONFI.PAN
# Funci�n  : Mantenimiento de configuraci�n
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE PARAMETROS DE CONFIGURACION
 User      Ordenador       Programa          Modulo          SIDHIST SERIALH O HISTDATEDESDE            HISTDATEHASTA            Instancia  Propiedad        Comentario              T Valor             Activo Permitidos Priv ver    Priv mod     Ultima modificaci�n             
 _64______ _64____________ _64______________ _64____________ @L@@@@@ @L@@@@@ _ ________________________ ________________________ _40_______ _64_____________ _512___________________ _ _255_____________   _    _1000_____ _1000______ _1000_______ _32_________ �D-MM-Y.YY ________
|

TABLA=VDCONFI$AUD

REGPAG=25
NOINSERT
NODELETE
NOUPDATE

WHERE=VDUSER.TENGOPRIVILEGIO(PRIVILEGIOSVER)=1;
ORDERBY=HISTDATEDESDE DESC,HISTDATEHASTA DESC;
SELECT=DECODE(VDUSER.TENGOPRIVILEGIO(PRIVILEGIOSMOD),1,1,0) VALOR__ENTER;


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=GRUPOPROP,OCULTO,"_20"
CAMPO=ROWIDHIST,OCULTO,"_40"
CAMPO=USERNAMEHIST,TITULO("USERNAMEHIST")
CAMPO=MACHINEHIST,TITULO("MACHINEHIST")
CAMPO=PROGRAMHIST,TITULO("PROGRAMHIST")
CAMPO=MODULEHIST,TITULO("MODULEHIST")
CAMPO=SIDHIST,TITULO("SIDHIST")
CAMPO=SERIALHIST,TITULO("SERIALHIST")
CAMPO=OPERACIONHIST,TITULO("OPERACIONHIST")
CAMPO=HISTDATEDESDE,TITULO("HISTDATEDESDE")
CAMPO=HISTDATEHASTA,TITULO("HISTDATEHASTA")
CAMPO=INSTANCIA
CAMPO=PROPIEDAD,NOUPDATE("IMPLANTADOR"),TOOLTIP("Nombre del par�metro de configuraci�n"),TITULO("Propiedad")
CAMPO=COMENTARIO,NOUPDATE("IMPLANTADOR"),TOOLTIP("Designaci�n del par�metro de configuraci�n"),TITULO("Comentario")
CAMPO=TIPODATO,NOUPDATE("IMPLANTADOR"),TOOLTIP("Tipo de dato del par�metro"),TITULO("T")
CAMPO=VALOR,TOOLTIP("Valor del par�metro de configuraci�n"), TITULO("Valor"),MIXED
CAMPO=ACTIVO,UPPER,NOUPDATE("IMPLANTADOR"),TOOLTIP("Indica si la propiedad de configuraci�n est� activa o no"),TITULO("Act"), WLONX=15
CAMPO=PERMITIDOS,NOUPDATE("IMPLANTADOR"),TOOLTIP("Rango de valores permitidos para el par�metro"),TITULO("Permitidos")
CAMPO=PRIVILEGIOSVER,NOUPDATE("IMPLANTADOR"),TOOLTIP("Privilegios necesarios para ver el par�metro"),TITULO("Privilegios Ver")
CAMPO=PRIVILEGIOSMOD,NOUPDATE("IMPLANTADOR"),TOOLTIP("Privilegios para modificar el par�metro"),TITULO("Privilegios Modif")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")




