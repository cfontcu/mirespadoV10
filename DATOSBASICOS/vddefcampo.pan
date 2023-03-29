# M�dulo   : VDDEFCAMPO.PAN
# Funci�n  : Mantenimiento de valores por defecto de campos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
CARACTERISTICAS POR DEFECTO DE CAMPOS
Campo              T T�tulo                 Tooltip                    Funci�n tooltip              Convierte               C T S Postchange             Contextual                           Tecla                                Privilegios para modificar   Privilegios para ver       Adicionales                      Ultima modificaci�n
_40_______________ _ _40___________________ _1024_____________________ _1024_______________________ _1024__________________ _ _ _ _1024_________________ _1024_______________________________ _1024_______________________________ _1024_______________________ _1024_____________________ _1024__________________________  _32________ �D-MM-Y.YY  ________
|


TABLA=VDDEFCAMPO

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=NCAMPO,TOOLTIP("Nombre del campo"),TITULO("Campo")
CAMPO=TIPOPANTALLA,TOOLTIP("Tipo de pantallas a las que se aplican los defectos puede ser F(orms) R(adios) o A(mbos)"),TITULO("T")
CAMPO=TTITULO,MIXED,TOOLTIP("Titulo del campo cuando se exporta a EXCEL"),TITULO("T�tulo")
CAMPO=TTOOLTIP,MIXED,TOOLTIP("Tooltip del campo"),TITULO("Tooltip")
CAMPO=FTOOLTIP,MIXED,TOOLTIP("Funci�n que se ha de aplicar al tooltip antes de presentarlo"),TITULO("Funci�n Tooltip")
CAMPO=FCONVIERTE,TOOLTIP("Funciones de conversion del campo"),TITULO("Convierte")
CAMPO=CAPITALIZA,TOOLTIP("Capitalizaci�n del campo U(pper) L(ower) M(ixed)"),TITULO("C")
CAMPO=ESTRADUCIBLE,TOOLTIP("Indica si el campo es traducible"),TITULO("T")
CAMPO=ESSCAN,TOOLTIP("Indica si el campo es escaneable"),TITULO("S")
CAMPO=FPOSTCHANGE,TOOLTIP("Funcion de postchange del campo"),TITULO("Postchange")
CAMPO=FCONTEXTUAL,TOOLTIP("Funci�n que ejecuta si pulsa Shift+F10"),TITULO("Contextual")
CAMPO=FTECLA,TOOLTIP("Funciones de teclas contextuales del campo"),TITULO("Tecla")
CAMPO=PRIVMODIF,TOOLTIP("Privilegios necesarios para modificar el campo"),TITULO("Privilegios Modif"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=PRIVVER,TOOLTIP("Privilegios para ver el campo"),TITULO("Privilegios Ver"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=FAUXILIAR,TOOLTIP("Propiedades adicionales a a�adir al campo"),TITULO("Auxiliar")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




