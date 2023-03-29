# M�dulo   : VDTARIFAAG.PAN
# Funci�n  : Asignaci�n de tarifas a agencias
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
# (1) 15-04-2008: Adaptar pantallas a las especificaciones de Movianto. Sergio Rojo 
AGENCIAS ASIGNADAS A LA TARIFA
Agencia                         Ultima modificaci�n
__________ _40_________________ _32________ �D-MM-Y.YY  ________
                                                                 |
NOINSERT
NODELETE
NOUPDATE

TABLA=VDTARIFAAG
ORDERBY=CODAGE;


######################################################################################################
####################### CAMPOS VIRTUALES ###############################################################
######################################################################################################
CAMPO=SEQTARIFA,VIRTUAL,OCULTO
######################################################################################################


CAMPO=CODAGE,POSTCHANGE=FDESIGNACION("CSELDESAGE","No existe agencia"),TOOLTIP("C�digo de la agencia"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la agencia")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CSELDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE;


ONLINE={F1} Ayuda  {F4} Confirmar Cambios  {F6} Cambio de pantalla
                {F9} Borrar Registro {May-F10} Men� contextual;
