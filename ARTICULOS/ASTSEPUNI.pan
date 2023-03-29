#*****************************************************************************************
#Modulo: ASTSEPUNI.PAN
#Funcionalidad : Maestro cantidad maxima articulos por tipo separacion
#Autor: JOTA      
#Fecha: 27-12-2022
#*******************************************************************************************
#* Historico de cambios
#* ====================
CANTIDAD MAXIMA SEPARACION
 Tipo Sep Descripcion Activo   Unidades Ultima modificacion 
    @@    ___________   _      @@@@@@@@ _32________ ¿D-MM-Y.YY ________ 
|

SOLOQUERY

SELECT=SELECT :CODART CODART, TIPOSEP, '' ACTIVO, 0 NUNIDADES, '' CODOPEMODIF, 0 FECMODIF, '' HORAMODIF
         FROM ASTSEPAR
        WHERE TIPOSEP NOT IN (SELECT TIPOSEP FROM ASTSEPUNI WHERE CODART=:CODART) 
              AND :CODART IS NOT NULL
       UNION 
       SELECT CODART, TIPOSEP, ACTIVO, NUNIDADES, CODOPEMODIF, FECMODIF, HORAMODIF
         FROM ASTSEPUNI
        WHERE CODART=:CODART;

ORDERBY=TIPOSEP ASC;


PREUPDATE=FEJECUTA(FIF("CSELEXISTE", FEJECUTA("CUPDATE",""),
                                     FEJECUTA("CINSERT"),""),"")



CAMPO=CODART,VIRTUAL,OCULTO 
CAMPO=TIPOSEP,AUXILIAR,NOENTER,TOOLTIP("Tipo de separacion"),POSTCHANGE=FDESIGNACION("CSELTIPOSEP","Tipo incorrecto."),COMBOXMULTIPLE("CTIPOSEP"),COMBOXREGPAG=4,TITULO("Tipo")
CAMPO=DESCSEPARACION,AUXILIAR,NOENTER,TOOLTIP("Descripcion Separacion"),TITULO("Descripcion")
#CAMPO=ACTIVO,TOOLTIP("Tipo de separacion activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Activo")
CAMPO=ACTIVO,AUXILIAR,TOOLTIP("Tipo de separacion activa Si (S) o No (N)"),POSTCHANGE=FVERIFICA("SN ","Debe introducir S(i) o N(o)"),TITULO("Activo")
CAMPO=NUNIDADES,AUXILIAR,TOOLTIP("Numero Maximo unidades"),TITULO("Unidades")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realizo la Ultima modificacion"),TITULO("Ultima modificacion")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CURSOR=CTIPOSEP SELECT TIPOSEP, DESCSEPARACION FROM ASTSEPAR ORDER BY TIPOSEP;

CURSOR=CSELTIPOSEP SELECT DESCSEPARACION FROM ASTSEPAR WHERE TIPOSEP=:TIPOSEP OR :TIPOSEP IS NULL;


#-- PREUPDATE --
#---------------
CURSOR=CSELEXISTE SELECT :CODART
                    FROM ASTSEPUNI
				   WHERE CODART=:CODART AND TIPOSEP=:TIPOSEP;

CURSOR=CUPDATE UPDATE ASTSEPUNI
                  SET ACTIVO=:ACTIVO,
				      NUNIDADES=:NUNIDADES,
					  CODOPEMODIF=VDUSER.GETUSER, FECMODIF=VD.FECHASYS, HORAMODIF=VD.HORASYS
				WHERE CODART=:CODART AND TIPOSEP=:TIPOSEP;

CURSOR=CINSERT INSERT INTO ASTSEPUNI (CODART, TIPOSEP, ACTIVO, NUNIDADES, CODOPEMODIF, FECMODIF, HORAMODIF)
                              VALUES (:CODART, :TIPOSEP, :ACTIVO, :NUNIDADES, VDUSER.GETUSER, VD.FECHASYS, VD.HORASYS
							  CAMPOX);



				  

