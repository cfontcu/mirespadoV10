#*****************************************************************
#M�dulo: VDTIPORDRECCAB.PAN
#Funci�n: Mantenimiento de las cabeceras de los tipos de recepci�n
#Autor: ICC      
#Fecha: 12-02-2008
##*****************************************************************
#* Hist�rico de cambios
#* ====================
MANTENIMIENTO DE LAS CABECERAS DE LOS TIPOS DE RECEPCION

Tipo                                            Concepto                            Privilegio         Inf. adicional         Ultima modificaci�n            
_10_______ _40_________________________________ _10_______ _80_____________________ _20_______________ _255__________________ _32_______ �D-MM-Y.YYY _8______
|

TABLA=VDTIPORDRECCAB

PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=TIPORDREC,TOOLTIP("Tipo de orden de recepci�n"),TITULO("Tipo"),NOUPDATE
CAMPO=DESORDREC,TOOLTIP("Designaci�n del tipo de orden de recepci�n"),TITULO("Descripcion")
CAMPO=CODCONCE,POSTCHANGE=FDESIGNACION("CSELVDCONCEPTODESCONCE","ERROR AL EJECUTAR CURSOR CSELVDCONCEPTODESCONCE"),TOOLTIP("Concepto del movimiento de entrada de mercanc�a, desde un manantial hasta su pulm�n correspondiente."),
               CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDCONCEPTO","S","","","CODCONCE=:CODCONCE","","S")),
               TITULO("Concepto")
CAMPO=DESCONCE,NOENTER,AUXILIAR,TOOLTIP("Descripci�n del concepto"),TITULO("Desc. del concepto")
CAMPO=RANGOPRIVILEGIO,TOOLTIP("Privilegio que debe tener el operario para modificar este tipo de Ordenes"),TITULO("Privilegio"),COMBOXMULTIPLE("CLISTAPRIV")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente"),TITULO("Inf. Adicional")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELVDCONCEPTODESCONCE SELECT DESCONCE FROM VDCONCEPTO WHERE CODCONCE=:CODCONCE;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CLISTAPRIV SELECT PRIVILEGIO, COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;