# M�dulo   : VDRECURSO.PAN
# Funci�n  : Mantenimiento de recursos
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
LISTA DE RECURSOS
Recurso                                 A IP               T Matricula  Usuario Estado                     Perfil    Pantalla
__________ _40_________________________ _ _30_____________ _ _20_______ _20_____ @L@@@ _40________________ _20______ _20_______ _32_________ �D-MM-Y.YY _8________
|


TABLA=VDRECURSO
ORDERBY=CODRECURSO;

PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=CODRECURSO,NOUPDATE,TOOLTIP("C�digo del recurso"),TITULO("Recurso")
CAMPO=DESRECURSO,TOOLTIP("Designaci�n del recurso"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del recurso"),TITULO("")
CAMPO=ACTIVO,TOOLTIP("Indica si el recurso es utilizable"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("A")
CAMPO=DIRRECURSO,TOOLTIP("Direccion f�sica del recurso (Normalmente direcci�n ip)"),TITULO("IP")
CAMPO=TECLEO,TOOLTIP("Indica si el recurso puede teclear en campos scaneables"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("T")
CAMPO=CODMAT,TOOLTIP("Matricula asignada el recurso"),TITULO("Matricula")
CAMPO=CODOPE,TOOLTIP("Operario identificado en el terminal"),TITULO("Usuario")
CAMPO=STATUS,POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado"),TOOLTIP("Estado del recurso"),COMBOX("CLISTASTATUS"),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Designacion del estado"),TITULO("")
CAMPO=CODPERFIL,TOOLTIP("Perfil que esta ejecutando el recurso"),TITULO("Perfil")
CAMPO=NPANTALLA,TOOLTIP("Nombre de la pantalla a ejecutar"),TITULO("Pantalla")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro"),TITULO("Modificacion")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTASTATUS SELECT STATUS,DESSTATUS FROM VDSTATUS WHERE TIPOSTATUS='REC' ORDER BY STATUS;
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='REC';


CURSOR=CDESASIGNA DECLARE
                   RET NUMBER;
                  BEGIN
                   RET:=VDPLANMOV.DESASIGNAMOV(:CODRECURSO);
                   COMMIT;
                  END;@
                                
