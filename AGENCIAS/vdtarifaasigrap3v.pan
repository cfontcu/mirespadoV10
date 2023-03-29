# M�dulo   : VDTARIFADIV.PAN
# Funci�n  : Asignaci�n de tarifas a divisiones
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
# (1) 15-04-2008: Adaptar pantallas a las especificaciones de Movianto. Sergio Rojo
ASIGNACION DE TARIFAS
A�adir Divisi�n                        ClaseTarifa  Validez
   _   _20_________ _40_________________    _         �D-MM-Y.YY �D-MM-Y.YY 
                                                                                |

SOLOQUERY

SELECT=SELECT CODDIV, DESDIV,'V' CLASETARIFA 
         FROM VDDIVIS
        WHERE CODDIV NOT IN (SELECT CODDIV FROM VDTARIFADIV WHERE SEQTARIFA=:SEQTARIFA AND CODAGE=:CODAGE) ;


ORDERBY= CODDIV ASC;

POSTQUERY=FEJECUTA("CINICIALIZA","No puedo seleccionar datos",
                   FPOSICIONACAMPO(FSUCCESS,"SWTPEDMUL"),"")


PREUPDATE=FEJECUTA("@CSELSWTPEDMUL","\n Error en cursor CSELSWTPEDMUL \n\n",
                   "CSELCODTARIFA","Error en cursor CSELCODTARIFA.",
                   "-CSELREGCOMPRA","ERROR, \n\nExisten divisiones de Compra para la tarifa :CODTARIFA. ",
                   "CASIGNATARIFADIV","\n Error al asignar la division a la tarifa \n\n",
                   FPULSATECLAS("F3","F2"),""
                   )
                   
                   

CAMPO=SWTPEDMUL,AUXILIAR,UPPER,POSTCHANGE=FVERIFICA("SN","Debe introducir S o N"),TITULO("A�adir"),WLONX=20
CAMPO=SEQTARIFA,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODAGE,VIRTUAL,AUXILIAR,OCULTO
CAMPO=CODDIV,TOOLTIP("C�digo de la divisi�n"),TITULO("Divisi�n")
CAMPO=DESDIV,NOENTER,TOOLTIP("Designaci�n de la divisi�n")
CAMPO=CLASETARIFA,NOENTER,AUXILIAR,UPPER,POSTCHANGE=FVERIFICA("CV","Debe introducir C(oste) o V(enta)"),TOOLTIP("Clase de la tarifa debe ser C(oste) o V(enta)"),
                  TITULO("Clase Tarifa"),WLONX=40
CAMPO=FECDESDE,AUXILIAR,TOOLTIP("Fecha inicio de validez de la tarifa"),TITULO("Validez"),COMBOX("CALENDARIO")
CAMPO=FECHASTA,AUXILIAR,TOOLTIP("Fecha de final de validez de la tarifa"),COMBOX("CALENDARIO")

CAMPO=CODTARIFA,OCULTO,"_20___"

CURSOR=CSELCODTARIFA SELECT :CODTARIFA FROM VDTARIFA WHERE SEQTARIFA=:SEQTARIFA;


CURSOR=CSELREGCOMPRA SELECT CODTARIFA FROM VDTARIFADIV WHERE CODTARIFA=:CODTARIFA AND CLASETARIFA='C' GROUP BY CODTARIFA;

CURSOR=CINICIALIZA SELECT 'N' SWTPEDMUL FROM DUAL;

CURSOR=CSELSWTPEDMUL SELECT :SWTPEDMUL SWTPEDMUL FROM DUAL WHERE :SWTPEDMUL='S';


CURSOR=CASIGNATARIFADIV  Insert into VDTARIFADIV (SEQTARIFA,CODAGE, CODDIV, FECDESDE, FECHASTA, 
                                                  CODTARIFA, CODOPEMODIF, FECMODIF, HORAMODIF, CLASETARIFA)
                                          Values (:SEQTARIFA,:CODAGE, :CODDIV, :FECDESDE,:FECHASTA, 
                                                  :CODTARIFA,VDUSER.GETUSER,VD.FECHASYS, VD.HORASYS, :CLASETARIFA);
                         
AYUDA=ASIGNACION RAPIDA DE AGENCIAS A TARIFAS



ONLINE={F1} Ayuda  {F4} Confirmar Cambios  {F6} Cambio de pantalla
                {F9} Borrar Registro {May-F10} Men� contextual;
