# M�dulo   : VDTARIFAAG.PAN
# Funci�n  : Asignaci�n de tarifas a agencias
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
# (1) 15-04-2008: Adaptar pantallas a las especificaciones de Movianto. Sergio Rojo 
ASIGNACION DE AGENCIAS
 Agencia                         Ultima modificaci�n
 __________ _40_________________ _32________ �D-MM-Y.YY  ________
                                |

TABLA=VDTARIFAAG
ORDERBY=CODAGE;


PREINSERT=FEJECUTA("CSELMODIF","ERROR, Al calcular la fecha de modificacion. ")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR, Al calcular la fecha de modificacion. ")
#(1)I
PREDELETE=FEJECUTA("-CSELVDTARIFADIV"," No puede borrar esta tarifa !!! \n\n Existen DIVISIONES asignadas. \n")
PRECOMMIT=FEJECUTA("-CSELVDTARIFADIV"," No puede borrar esta tarifa !!! \n\n Existen DIVISIONES asignadas. \n")

#(1)F 

CAMPO=SEQTARIFA,VIRTUAL,OCULTO
CAMPO=CODAGE,POSTCHANGE=FDESIGNACION("CSELDESAGE","No existe agencia"),TOOLTIP("C�digo de la agencia"),TECLA=SF10,FEJECUTAFORM("VDAGENCIA","N","","","CODAGE=:CODAGE","","S"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la agencia")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CAMPO=CODCOMEN,OCULTO,"@@@@@"


#(1)I
CURSOR=CSELVDTARIFADIV SELECT SEQTARIFA FROM VDTARIFADIV WHERE SEQTARIFA=:SEQTARIFA AND CODAGE=:CODAGE;
#(1)F 

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE;


AYUDA=ASIGNACION DE TARIFAS A AGENCIAS

#TECLA=SF10,FLEEMENU("VDTARIFAAG.ZOO")

ONLINE=   {F4} Confirmar Cambios   {F6} Cambio de pantalla   {F9} Borrar Registro   {May-F10} Men� contextual;
