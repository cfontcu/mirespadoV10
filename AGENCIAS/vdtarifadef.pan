# M�dulo   : VDTARIFADEF.PAN
# Funci�n  : Mantenimiento de datos basicos de tarifa
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
# (1) 15-04-2008: Adaptar pantallas a las especificaciones de Movianto. Sergio Rojo 
MANTENIMIENTO DE PRECIOS DE TARIFA
Clase F.Vol. Fijo   M�nimo   P.O.D.  FirmaBT Reemb. %Reem.  M.reemb. B Seguro % Seg.  M.Seg. Dua    %Dua    M. Dua Ultima modificaci�n
 _   #L#.## #L#.## #L,##.## #L##.## #L##.## #L,.## #L#.### #L,##.##  _ #L#.## #L#.### #L#.## #L#.## #L#.### #L#.## _32________ �D-MM-Y.YY  ________
|

TABLA=VDTARIFADEF


PREINSERT=FEJECUTA("CSELUNICOREGISTRO","ERROR, La defincion de la tarifa debe de contener\n       un unico registro",
                   "CSELMODIF","ERROR EN FECHA DE MODIFICACION",
                   "CSELPRECIOSELLAR","Error en cursor CSELPRECIOSELLAR")
PREUPDATE=FEJECUTA("CSELUNICOREGISTRO","ERROR, La defincion de la tarifa debe de contener\n       un unico registro",
                   "CSELMODIF","ERROR EN FECHA DE MODIFICACION")
#(1)I
PREDELETE=FEJECUTA("-CSELVDTARIFAKG"," No puede borrar esta tarifa !!! \n\n En bloque 6 tiene TARIFAS POR RANGO DE KILOS asignadas. \n",
                   "-CSELVDTARIFABULTO"," No puede borrar esta tarifa !!! \n\n En bloque 7 tiene TARIFAS POR RANGO NUMERO DE BULTOS asignadas. \n")

POSTQUERY=FEJECUTA("CSELUNICOREGISTRO","ERROR, La defincion de la tarifa debe de contener\n       un unico registro")

#(1)F


CAMPO=SEQTARIFA,VIRTUAL,OCULTO
CAMPO=ZONATARIF,VIRTUAL,OCULTO
CAMPO=CLASETARIFA,POSTCHANGE=FVERIFICA("CV","Debe introducir C(oste) o V(enta)"),WLONX=30,TOOLTIP("Clase de tarifa puede ser C(oste) o V(enta)"),TITULO("Clase")
CAMPO=FACTORVOLUM,TOOLTIP("Factor de conversion de volumen en peso en kilos/m3"),TITULO("F.Vol.")
CAMPO=PRECIOFIJO,TOOLTIP("Precio fijo por albar�n"),TITULO("Fijo")
CAMPO=MINIMOFIJO,TOOLTIP("M�nimo precio por albar�n"),TITULO("M�nimo")
CAMPO=PRECIOSELLAR,TOOLTIP("Precio por devolver POD"),TITULO("P.O.D.")
CAMPO=PRECIOFIRMA,TOOLTIP("Precio por devolver albar�n transporte firmado"),TITULO("Fima Alb.T."),WLONX=30
CAMPO=PRECIOREEMB,TOOLTIP("Precio por reembolso"),TITULO("Reemb."),WLONX=20
CAMPO=PORCENREEMB,TOOLTIP("Porcentaje del importe por reembolso"),TITULO("%Reemb."),WLONX=20
CAMPO=MINIMOREEMB,TOOLTIP("M�nimo a cobrar por reembolso"),TITULO("Min.Reemb."),WLONX=20
CAMPO=TIPOBASESEGURO,TOOLTIP("El tipo de la base del seguro por defecto")
CAMPO=PRECIOSEGURO,TOOLTIP("Precio fijo por seguro"),TITULO("Seguro"),WLONX=20
CAMPO=PORCENSEGURO,TOOLTIP("Porcentaje del importe por seguro"),TITULO("%Seg.")
CAMPO=MINIMOSEGURO,TOOLTIP("M�nimo a cobrar por seguro"),TITULO("M.Seg.")
CAMPO=PRECIODUA,TOOLTIP("Precio fijo por dua"),TITULO("Dua")
CAMPO=PORCENDUA,TOOLTIP("Porcentaje del importe por dua"),TITULO("%Dua")
CAMPO=MINIMODUA,TOOLTIP("M�nimo a cobrar por dua"),TITULO("M.Dua")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ult. Modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")
CAMPO=DUMMY,OCULTO, AUXILIAR,"@"
CAMPO=CODCOMEN,OCULTO,"@@@@@"

CURSOR=CSELPRECIOSELLAR SELECT 0 PRECIOSELLAR FROM DUAL;

#(1)I
CURSOR=CSELVERCLASE SELECT 1 DUMMY
                      FROM VDTARIFADIV D 
                     WHERE D.SEQTARIFA=:SEQTARIFA
                       AND D.CLASETARIFA=:CLASETARIFA;
                       
CURSOR=CSELUNICOREGISTRO  SELECT 1 DUMMY FROM VDTARIFADEF I 
                           WHERE SEQTARIFA=:SEQTARIFA AND ZONATARIF=:ZONATARIF 
                          having count(*) < 2;                     

CURSOR=CSELVDTARIFAKG SELECT SEQTARIFA FROM VDTARIFAKG WHERE SEQTARIFA=:SEQTARIFA AND ZONATARIF=:ZONATARIF AND CLASETARIFA=:CLASETARIFA;

CURSOR=CSELVDTARIFABULTO SELECT SEQTARIFA FROM VDTARIFABULTO WHERE SEQTARIFA=:SEQTARIFA AND ZONATARIF=:ZONATARIF AND CLASETARIFA=:CLASETARIFA;

#(1)F


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;



AYUDA=MANTENIMIENTO PRECIOS DE TARIFA

#TECLA=SF10,FLEEMENU("VDTARIFADEF.ZOO")

ONLINE=   {F4} Confirmar Cambios   {F6} Cambio de pantalla   {F9} Borrar Registro   {May-F10} Men� contextual;
