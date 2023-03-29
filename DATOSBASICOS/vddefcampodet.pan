# M�dulo   : VDDEFCAMPODET.PAN
# Funci�n  : Mantenimiento detallado de valores por defecto de campos
#
# Creaci�n : 17-12-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CARACTERISTICAS DETALLADAS POR DEFECTO DE CAMPOS

Tipo Pantalla: _            Capitaliza: _ Traducible: _  Scan: _                Ult. Modif.: _32________ �D-MM-Y.YY  ________

T�tulo: _40__________________________________________________________________________________________________________________  

Tooltip: _1024___________________________________________ Funci�n Tooltip: _1024_____________________________________________
 
Convierte:  _1024________________________________________ Postchange: _1024__________________________________________________

Contextual: _1024________________________________________ Teclas: _1024______________________________________________________ 

Priv. Modificar: _1024____________________________________________  Priv. Ver: _1024_________________________________________

Adicionales: _1024___________________________________________________________________________________________________________
|

TABLA=VDDEFCAMPO

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")



CAMPO=NCAMPO,TOOLTIP("Nombre del campo"),VIRTUAL,OCULTO
CAMPO=TIPOPANTALLA,TOOLTIP("Tipo de pantallas a las que se aplican los defectos puede ser F(orms) R(adios) o A(mbos)")
CAMPO=CAPITALIZA,TOOLTIP("Capitalizaci�n del campo U(pper) L(ower) M(ixed)")
CAMPO=ESTRADUCIBLE,TOOLTIP("Indica si el campo es traducible")
CAMPO=ESSCAN,TOOLTIP("Indica si el campo es escaneable")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CAMPO=TTITULO,MIXED,TOOLTIP("Titulo del campo cuando se exporta a EXCEL")
CAMPO=TTOOLTIP,MIXED,TOOLTIP("Tooltip del campo")
CAMPO=FTOOLTIP,MIXED,TOOLTIP("Funci�n que se ha de aplicar al tooltip antes de presentarlo")
CAMPO=FCONVIERTE,TOOLTIP("Funciones de conversion del campo")
CAMPO=FPOSTCHANGE,TOOLTIP("Funcion de postchange del campo")
CAMPO=FCONTEXTUAL,TOOLTIP("Funci�n que ejecuta si pulsa Shift+F10")
CAMPO=FTECLA,TOOLTIP("Funciones de teclas contextuales del campo")
CAMPO=PRIVMODIF,TOOLTIP("Privilegios necesarios para modificar el campo")
CAMPO=PRIVVER,TOOLTIP("Privilegios para ver el campo")
CAMPO=FAUXILIAR,TOOLTIP("Propiedades Adicionales del campo")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




