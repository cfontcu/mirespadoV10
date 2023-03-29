# M�dulo   : VDSIMULADORPICKING
# Funci�n  : Simulador de las zonas de picking
#
# Creaci�n : 24-08-2008
# Autor    : MGM
###########################################
CONFIGURACION DE LAS ZONAS DE PICKING
Cod Ges A Pr. N. Dis.     T ND  Scan    M.C. A.A T.OK. T.FIN Estado              Men�     Proc. Zona  Proc. Disp.   Op. Bul. Operario   Ultima modificaci�n
@L@ @L@ _ @@  @L@ @L@@@@@ _ @@@ @L@ @L@  @@   _  @L@@@ @L@@@ @L@@ _40___________ _10_____ _32________ _32__________ @L@ @L   __________ _32_________ �D-MM-Y.YY ________
                                                                                                                                                                        |

TABLA=VDZONAS
ORDERBY=CODZONA;


PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

CAMPO=CODZONA,NOUPDATE,TOOLTIP("Clave primaria de una zona InfoPick"),TITULO("Zon"),WLONX=15
CAMPO=IDINFOGEST,TOOLTIP("Identificador del programa que gestiona la zona"),TITULO("Ges"),WLONX=15
CAMPO=ACTIVA,UPPER,POSTCHANGE=FVERIFICA("SN","Activa: (S)i o (N)o"),TOOLTIP("Si toma el valor S indica que la zona est� habilitada. En caso contrario la zona no es accesible"),TITULO("A")
CAMPO=PRIOZONA,TOOLTIP("Si toma el valor S indica la prioridad para utilizar displays de la zona. Se puede usar en picking inverso y en otras aplicaciones"),TITULO("Pri"),WLONX=10
CAMPO=IDINFOPICK,TOOLTIP("Identificador del INFOPICK HARDWARE que gestiona el controlador"),TITULO("Display")
CAMPO=NUMDISP,TOOLTIP("N�mero de display en la red InfoPick")
CAMPO=TIPOZONA,UPPER,POSTCHANGE=+FVERIFICA("UEI","Tipo de zona:(U)nidades o (E)mbalajes o (I)nverso"),TOOLTIP("Indica el tipo de zona, (U)nidades o (E)mbalajes"),TITULO("T")
CAMPO=DISPILUMINADOS,TOOLTIP("N�mero m�ximo de displays iluminados simult�neamente en una zona."),TITULO("D.Ilum."),WLONX=30
CAMPO=REDSCAN,TOOLTIP("Red de scanners al que pertenece el scanner asociado"),TITULO("Red Scan"), WLONX=45
CAMPO=SCANNER,TOOLTIP("N�mero de esc�ner o puerto serie asociado a la zona"),TITULO("Scan"),WLONX=18
CAMPO=MAXCAPACIDAD,TOOLTIP("Representa la capacidad m�xima por encima de la cual no entrar�n mas cajas a la zona"),TITULO("M.C."),WLONX=15
CAMPO=AUTOAPERTURA,UPPER,POSTCHANGE=FVERIFICA("SN","Autoapertura: (S)i o (N)o"),TOOLTIP("Si toma el valor S la zona se activa con la lectura de bultos.Si toma el valor N un operario debe identificarse."),TITULO("A.A."),WLONX=15
CAMPO=TIEMPOOK,TOOLTIP("Tiempo que permanece OK en pantalla en milisegundos\n0 indica que se ha de validar"),TITULO("T.OK"),WLONX=12
CAMPO=TIEMPOFIN,TOOLTIP("Tiempo que permanece FIN en pantalla en milisegundos\n0 indica que se ha de validar"),TITULO("T.FIN"),WLONX=12
CAMPO=STATUS,POSTCHANGE=FEJECUTA("CDESSTATUS","No existe status"),TOOLTIP("Estado de la zona"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,TOOLTIP("Descripcion del status")
CAMPO=IDMENU,TOOLTIP("Menu actualmente cargado en la zona"),TITULO("Men�")
CAMPO=PROCESOZONA,UPPER,TOOLTIP("Proceso que gestiona las teclas de la zona"),TITULO("Proc.Zona")
CAMPO=PROCESODISP,UPPER,TOOLTIP("Proceso que gestiona las teclas de los displays de la zona"),TITULO("Proc.Display")
CAMPO=MAXOPER,TOOLTIP("M�ximo numero de operarios en la zona"),TITULO("Op."),WLONX=15
CAMPO=MAXBULTOSOPER,TOOLTIP("M�ximo numero de bultos por operario"),TITULO("Bul"),WLONX=15
CAMPO=CODOPE,TOOLTIP("C�digo del operario conectado.SOlo si el operario se identifica."),TITULO("Operario")
CAMPO=CODOPEMODIF,NOENTER, TOOLTIP("Usuario que ha realizado la ultima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER, TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER, TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CDELBULTOZONA DELETE VDBULTOZONA WHERE CODZONA=:CODZONA;

CURSOR=CIERRAZONA UPDATE VDZONAS SET IDMENU=NULL,CODOPE=NULL,STATUS=VDST.ZONCERRADA, CODOPEMODIF=VDUSER.GETUSER,FECMODIF=VD.FECHASYS,HORAMODIF=VD.HORASYS WHERE CODZONA=:CODZONA;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;
CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS = 'ZON' AND STATUS = :STATUS;

