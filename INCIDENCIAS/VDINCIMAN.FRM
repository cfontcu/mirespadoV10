# M�dulo   : VDINCIDENCIAS.FRM
# Funci�n  : MONITOR DE INCIDENCIAS
#
# Creaci�n : 10-09-2009
# Autor    : JCSR
###########################################
# Hist�rico de cambios:
BEGINBLOQUE = VDINCICABMAN.PAN
	POSX = 1
	PREREGISTRO = PRESEHIJO
	NOORAINS
    NODELETE

#	BOTON = FACTURABLE,750,60,70,45,"FACTURAR",carte_rouge.png,F8,"Mandar a facturaci�n",INCLUDECSS="background-color: transparent;border-width:0px"
	BOTON = CERRAR,650,60,70,70,"CERRAR INCIDENCIA",candao.gif,CF7,"Cerrar incidencia",INCLUDECSS="background-color: transparent;border-width:0px"
	BOTON = ANULAR,750,60,70,70,"ANULAR INCIDENCIA",ANULAR.png,AF8,"Anular incidencia",INCLUDECSS="background-color: transparent;border-width:0px"

#	BOTON = RAQUETAZO,650,160,70,70,"CAMBIAR ASIGNACION",Users.png,CF8,"Cambiar el operario a quien \n est� asignada",INCLUDECSS="background-color: transparent;border-width:0px"
#	BOTON = INFOCLI,750,160,70,70,"INFORMACION DEL CLIENTE",Agenda_icono.PNG,CF6,"Datos del cliente",INCLUDECSS="background-color: transparent;border-width:0px"
ENDBLOQUE
BEGINBLOQUE = VDLINEASINCI.PAN
	PADRE = VDINCICABMAN.PAN
	WLONX = 1000
	POSY = 44
	REGPAG = 10
	PREQUERY = QUERYHIJO
	PREREGISTRO = PRESEHIJO
	BOTON = A�ADIR,1020,600,70,70,"A�ADIR LINEA",editpaste.png,AF7,"A�adir l�nea de incidencia",INCLUDECSS="background-color: transparent;border-width:0px"
ENDBLOQUE
BEGINBLOQUE = VDOPEACTUACION.PAN
	PADRE = VDLINEASINCI.PAN
	POSX = 89
	POSY = 32
    REGPAG = 8	
	PREQUERY = QUERYHIJO
	PREREGISTRO = PRESEHIJO
ENDBLOQUE
	
