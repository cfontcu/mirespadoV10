#*****************************************************************************************
#Modulo: RECEPSINSEP.PAN
#Funcionalidad : Articulos recpcionados sin separaciones
#Autor: Carmen Fontcuberta     
#Fecha: 10-01-2023
#*******************************************************************************************
#* Histórico de cambios
# ====================  TO_CHAR(SYSDATE,'YYYYMMDD')
#*******************************************************************************************
ARTICULOS RECPCIONADOS SIN VOLUMETRIA
Tipo Sep Descripcion Activo   Unidades Ultima modificacion 
@@@@@@@@ ___________  _4___   @@@@@@@@ _32________ ¿D-MM-Y.YY ________
|

SOLOQUERY
#TABLA=ASTSEPUNI
SELECT=SELECT CODART CODART, TIPOSEP, ACTIVO, NUNIDADES, CODOPEMODIF, FECMODIF, HORAMODIF
         FROM (SELECT CODART, TIPOSEP, ACTIVO, NUNIDADES, CODOPEMODIF, FECMODIF, HORAMODIF
                 FROM ASTSEPUNI
                WHERE CODART=:CODART
				)
         WHERE 1=1;
         
         
         
#UNION
#               SELECT '' CODART, TIPOSEP, '' ACTIVO, 0 NUNIDADES, '' CODOPEMODIF, 0 FECMODIF, '' HORAMODIF
#                 FROM ARTSEPAR
#                WHERE (TIPOSEP  IN (SELECT TIPOSEP FROM ASTSEPUNI AND CODART=:CODART)))
#		WHERE ((CODARTL IS NULL OR CODARTL=:CODART) OR 1=1

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=CODART,VIRTUAL,OCULTO,"_40____"
CAMPO=TIPOSEP,TOOLTIP("Tipo de separacion"),POSTCHANGE=FDESIGNACION("CSELTIPOSEP","Tipo incorrecto."),COMBOXMULTIPLE("CTIPOSEP"),COMBOXREGPAG=4,TITULO("Tipo")
CAMPO=DESCSEPARACION,AUXILIAR,PREFIELD=FDESIGNACION("CSELDESCSEP","Tipo incorrecto."),TOOLTIP("Descripcion Separacion"),TITULO("Descripcion")
#CAMPO=ACTIVO,TOOLTIP("Tipo de separacion activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Activo")
CAMPO=ACTIVO,TOOLTIP("Tipo de separacion activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),TITULO("Activo")
CAMPO=NUNIDADES,TOOLTIP("Numero Maximo unidades"),TITULO("Unidades")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizo la Ultima modificacion"),TITULO("Operario")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro"),TITULO("Ultima Modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")



CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CTIPOSEP SELECT TIPOSEP, DESCSEPARACION FROM ASTSEPAR ORDER BY TIPOSEP;

CURSOR=CSELTIPOSEP SELECT DESCSEPARACION FROM ASTSEPAR WHERE TIPOSEP=:TIPOSEP;

CURSOR=CSELDESCSEP SELECT DESCSEPARACION FROM ASTSEPAR WHERE TIPOSEP=:TIPOSEP;

					