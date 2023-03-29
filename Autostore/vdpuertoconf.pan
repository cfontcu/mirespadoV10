#*****************************************************************************************
#Modulo: VDPUERTOCONF.PAN
#Funcionalidad : Configurador de puertos
#Autor: JOTA      
#Fecha: 17-01-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
CONFIGURADOR DE PUERTOS AUTOSTORE
 Puerto  Estado  Reqtime  Categoria1 Categoria2 Categoria3 Categoria4 Categoria5 Categoria6 Categoria7 Categoria8 Ultima modificacion 
 @@@@@@  @@@@@   @15@@@@     _          _          _          _          _          _          _          _       _32________ ¿D-MM-Y.YY ________ 
|

PROTECT("ADMINISTRADOR")
NOINSERT
 
TABLA=ASTPUERTO

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")

CAMPO=PUERTO,TOOLTIP("Identificador del puerto"),TITULO("Puerto")
CAMPO=STATUS,TOOLTIP("Estado del puerto"),TITULO("Estado")
CAMPO=REQTIME,TOOLTIP("Identificador del puerto"),TITULO("Req_time")
CAMPO=CATEGORIA1,TOOLTIP("Categoria 1 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat1")
CAMPO=CATEGORIA2,TOOLTIP("Categoria 2 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat2")
CAMPO=CATEGORIA3,TOOLTIP("Categoria 3 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat3")
CAMPO=CATEGORIA4,TOOLTIP("Categoria 4 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat4")
CAMPO=CATEGORIA5,TOOLTIP("Categoria 5 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat5")
CAMPO=CATEGORIA6,TOOLTIP("Categoria 6 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat6")
CAMPO=CATEGORIA7,TOOLTIP("Categoria 7 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat7")
CAMPO=CATEGORIA8,TOOLTIP("Categoria 8 activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Cat8")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizo la ultima modificacion"),TITULO("Ultima modificacion")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro"),WLONX=10
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")



CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;