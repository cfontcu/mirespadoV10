# M�dulo   : VDDEFBLOQUEDET.PAN
# Funci�n  : Mantenimiento detallado de propiedades por defecto de bloques
#
# Creaci�n : 18-12-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
CARACTERISTICAS POR DEFECTO DE BLOQUES DE DATOS

Tipo de Pantalla: _   PosX: @L@  PosY: @L@  Reg. por P�gina: @L@@    Modo Query: _   Capitaliza: _ 

Online:  _1024________________________________________________________________________________________________________________

T�tulo:  _1024________________________________________________________________________________________________________________

Context: _1024_______________________________________________  Teclas: _1024__________________________________________________           

Where:   _1024________________________________________________________________________________________________________________

OrderBy: _1024________________________________________________________________________________________________________________

Topic Ayuda: _1024___________________________________________________________________

Privilegios: DeInsert _ _1024_________________ DeUpdate _ _1024_________________ Ult.Modificaci�n: _32________ �D-MM-Y.YY ________
             DeDelete _ _1024_________________ DeOrains _ _1024_________________                      
             DeEnter  _ _1024_________________
Adicionales: _1024___________________________________________________________________________________________________________________________________
|


TABLA=VDDEFBLOQUE
#WPLEGADO
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=NBLOQUE,VIRTUAL,OCULTO
CAMPO=TIPOPANTALLA,TOOLTIP("Tipo de pantallas a las que se aplican los defectos puede ser F(orms) R(adios) o A(mbos)")
CAMPO=NUMPOSX,TOOLTIP("Coordenada X en el que comienza la pantalla")
CAMPO=NUMPOSY,TOOLTIP("Coordenada Y en el que comienza la pantalla")
CAMPO=NUMREGPAG,TOOLTIP("N�mero de registros de la pantalla")
CAMPO=MODOQUERY,TOOLTIP("Modo de query de la pantalla: A(query), P(query), T(query) o NULO")
CAMPO=CAPITALIZA,TOOLTIP("Capitalizaci�n del campo U(pper) L(ower) M(ixed)"),POSTCHANGE=FEJECUTA(FSUCCESS,"")
CAMPO=AYUDAONLINE,MIXED,TOOLTIP("Ayuda online del Bloque. Si se antepone un signo + se concatena a la ayuda online por defecto")
CAMPO=TITULOBLOQUE,TOOLTIP("T�tulo del bloque de datos")
CAMPO=FCONTEXTUAL,TOOLTIP("Funci�n a ejecutar al pulsar Shift+F10")
CAMPO=FTECLA,TOOLTIP("Funciones programables para puslaciones de teclas especiales")
CAMPO=TWHERE,TOOLTIP("Texto where de la pantalla, anteponi�ndole un signo + lo concatena a la where en fichero de la misma")
CAMPO=TORDERBY,TOOLTIP("Criterio de ordenaci�n de la pantalla")
CAMPO=FAYUDA,TOOLTIP("Topic en la ayuda de V10 (.HLP)")
CAMPO=CNOINSERT,TOOLTIP("Si tiene protegido para no INSERT")
CAMPO=PRIVINSERT,TOOLTIP("Privilegios para Insertar registros")
CAMPO=CNOUPDATE,TOOLTIP("Si tiene protegido para no UPDATE")
CAMPO=PRIVUPDATE,TOOLTIP("Privilegios para Insertar registros")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CAMPO=CNODELETE,TOOLTIP("Si tiene protegido para no DELETE")
CAMPO=PRIVDELETE,TOOLTIP("Privilegios para Insertar registros")
CAMPO=CNOORAINS,TOOLTIP("Si tiene protegido para no ORAINS")
CAMPO=PRIVORAINS,TOOLTIP("Privilegios para Insertar registros")
CAMPO=CNOENTER,TOOLTIP("Si tiene protegido para no ENTER")
CAMPO=PRIVNOENTER,TOOLTIP("Privilegios para Insertar registros")
CAMPO=FAUXILIAR,TOOLTIP("Propiedades adicionales a a�adir a la pantalla")

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;





