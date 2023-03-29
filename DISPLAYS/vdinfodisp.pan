# M�dulo   : VDINFODISP.PAN
# Funci�n  : Mantenimiento de displays
#
# Creaci�n : 21-05-2008
# Autor    : Maite Gonz�lez
###########################################
CONFIGURACION DE LOS DISPLAYS DE PICKING
                        
Disp.       Ubicaci�n    Z.  Orden   D.Padre     D. Luz      Cubeta    Estado            Ultima modificaci�n
@L@ @L@@@@@ _20_________ @L@ @L@@@@@ @L@ @L@@@@@ @L@ @L@@@@@ _20______ @L@@ _32_________ _32_________ �D-MM-Y.YY ________ 
|
TABLA=VDINFODISP
ORDERBY=IDINFOPICK,CODZONA,NUMDISP;
                   
PROTECT("IMPLANTADOR")                   

PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

CAMPO=IDINFOPICK,TOOLTIP("N�mero de infopick hardware al que se refiere el display"),TITULO("Infopick"),WLONX=35
CAMPO=NUMDISP,TOOLTIP("N�mero de display en la red InfoPick.\nEste C�digo y el anterior forman la clave primaria."),TITULO("Display")
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n asociada al display"),TITULO("Ubicaci�n")
CAMPO=CODZONA,TOOLTIP("C�digo de Zona a la que pertenece el display asociado a la ubicaci�n, para picking directo"),
                     POSTCHANGE=FEJECUTA("+CSELZONA","ZONA :CODZONA NO EXISTE",
                                         "-CCHECKZONA","ZONA :CODZONA NO SE CORRESPONDE CON LA UBIC. DEL DISPLAY"),TITULO("Zona"),WLONX=15
CAMPO=ORDENDISP,TOOLTIP("Orden para seleccionar los displays"),TITULO("Orden")                                         
CAMPO=IDINFOPICKPADRE,TOOLTIP("N�mero de infopick hardware al que se refiere el display"),TITULO("Inf. Padre"),WLONX=45
CAMPO=DPADRE,TOOLTIP("Indica qu� display representa las operaciones a realizar.\nLos displays que se autorepresentan a s� mismos tienen como padres su mismo C�digo"),TITULO("Padre")
CAMPO=IDINFOPICKLUZ,TOOLTIP("N�mero de infopick hardware al que se refiere el display"),TITULO("Inf. Luz"),WLONX=30
CAMPO=NUMLUZ,TOOLTIP("Indica que display encender� su luz intermitente para indicar que en esa columna hay picking pendiente."),TITULO("Luz")
CAMPO=CODMAT,TOOLTIP("Matr�cula de caja o cubeta en el display"),TITULO("Matricula"),WLONX=30
CAMPO=STATUS,POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado"),TOOLTIP("Status del display"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,TOOLTIP("Descripcion del status")
CAMPO=CODOPEMODIF,NOENTER, TOOLTIP("Usuario que ha realizado la ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER, TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELZONA SELECT :CODZONA FROM VDZONAS WHERE CODZONA=:CODZONA;

CURSOR=CCHECKZONA SELECT :CODZONA  FROM VDUBICA UBI WHERE NVL(:CODUBI,'-')=CODUBI AND NVL(UBI.CODZONA,'-1')<>:CODZONA;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='IDI';



