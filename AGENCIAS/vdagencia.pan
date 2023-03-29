###################################################################
#M�dulo: VDAGENCIA.PAN
#Funcionalidad : Mantenimiento de agencias de transporte
#Autor: FPD      
#Fecha: 08-04-2008
###################################################################
# Hist�rico de cambios:
# M001 - DFL: A�ADIR CAMPO VDEXTRA(Cursor/Imp) PARA ASOCIAR UN CURSOR ESPEC�FICO A LA IMPRESION DE ETIQUETAS
#
MANTENIMIENTO DE AGENCIAS
 C�digo      Descripci�n                      Pue Grupo    Servicio Prod.      Sufijo   Ind. Bol. Alb. Fact. Agrupa   Sec.     Cursor/Imp.    Ultima modif.
 _10________ _40_____________________________ @L  _10_____ _10_____ _10_______ _10_____ @L   @@   @L@   @L   _20_____ _20_____ _20___________ _32_____ �D-MM-YYY.Y ________ 

|


PROTECT("ADMINISTRADOR")

TABLA=VDAGENCIA
WLONX=1400

WHERE=ORDER BY CODAGE;

PREINSERT=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.")
PREUPDATE=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.")

CAMPO=CODAGE,UPPER,TOOLTIP("C�digo de la agencia de transporte"),TITULO("C�digo")
CAMPO=DESAGE,UPPER,TOOLTIP("Descripci�n de la agencia de transporte"),TITULO("Descripci�n")
CAMPO=PUERTO,TOOLTIP("Puerto por el que se lanzan los pedidos por defecto"),TITULO("Pu."),WLONX=8
CAMPO=GRUPOAGE,UPPER,TOOLTIP("Grupo de transporte al que pertenece la agencia de transporte"),TITULO("Grupo")
CAMPO=SERVICIO,UPPER,TOOLTIP("Servicio espec�fico que realiza la agencia de transporte"),TITULO("Servicio")
CAMPO=PRODUCTO,UPPER,TOOLTIP("Indica si se ha de entregar a otra transportadora"),TITULO("Transp."),WLONX=40
CAMPO=SUFIJODOC,UPPER,TOOLTIP("Tipo de la etiqueta a imprimir.\nSe concatena al nombre de cada etiqueta."),TITULO("Sufijo")
CAMPO=NUMBOLIND,TITULO("Ind"),TOOLTIP("Numero de boletines de entrega"),WLONX=30
CAMPO=NUMBOL,TOOLTIP("N�mero de boletas (albaranes de transporte) a imprimir para el transportista."),TITULO("Bol."),WLONX=20
CAMPO=NUMALBA,TOOLTIP("N�mero de copias de albaranes a imprimir para el transportista"),TITULO("Alb."),WLONX=20
CAMPO=NUMFAC,TOOLTIP("N�mero de copias de factura proforma a imprimir para el transportista"),TITULO("Fact."),WLONX=20
CAMPO=AGRUPASERIE,TITULO("Agrupa")
CAMPO=NOMBRESECUEN,TITULO("Secuen")
CAMPO=VDEXTRA,TITULO("Cursor/Imp."),TOOLTIP("Asociar un cursor espec�fico, para la impresion de etiquetas de bulto")
CAMPO=CODOPEMODIF,NOENTER,TITULO("Ult. Modif."),WLONX=12
CAMPO=FECMODIF,NOENTER,TITULO(""),WLONX=10
CAMPO=HORAMODIF,UPPER,NOENTER,TITULO(""),WLONX=10
CAMPO=CODCOMEN,OCULTO,"@L@@@@@@"

CURSOR=CMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF
                FROM DUAL;

                



