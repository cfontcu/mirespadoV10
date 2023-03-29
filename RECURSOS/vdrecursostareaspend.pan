# M�dulo   : VDRECURSOSTAREASPEND.PAN
# Funci�n  : Recursos con tareas asignadas
#
# Creaci�n : 07-04-2020
# Autor    : CGG
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE RECURSOS
C�digo     Descripci�n                  Activo Direcci�n        Conectado Terminal         Usuario           Perfil
__________ _40_________________________ _      _30_____________ _         ________________ ________________  ____________________ _40___________________________
|

TABLA=VDRECURSO
WHERE=CODRECURSO IN (SELECT DISTINCT CODRECURSO
                       FROM VDMOVIM
                      WHERE CODRECURSO IS NOT NULL
                        AND STATUS < VDST.FMOVFINALIZADO);
ORDERBY=CODRECURSO;
NOINSERT
NOUPDATE
NODELETE
PQUERY


CAMPO=CODRECURSO,NOUPDATE,TOOLTIP("C�digo del recurso"),TITULO("C�digo")
CAMPO=DESRECURSO,TOOLTIP("Designaci�n del recurso"),POSTCHANGE=FVALNOCERO("Debe introducir la designaci�n del recurso"),TITULO("Descripci�n")
CAMPO=ACTIVO,TOOLTIP("Indica si el recurso es utilizable"),CHECKBOX("N","S"),TITULO("Act."),WLONX=15
CAMPO=DIRRECURSO,TOOLTIP("Direccion f�sica del recurso (Normalmente direcci�n ip)"),TITULO("Direcci�n")
CAMPO=CONECTADO,TOOLTIP("Indica si el recurso est� conectado"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S"),TITULO("Con."),WLONX=15
CAMPO=TERMINAL,TOOLTIP("Maquina a la que se ha conectado el recurso"),TITULO("M�quina")
CAMPO=CODOPE,TOOLTIP("Operario identificado en el terminal"),TITULO("Operario")
CAMPO=CODPERFIL,TOOLTIP("Perfil que esta ejecutando el recurso"),POSTCHANGE=FDESIGNACION("CSELDESPERFIL","No existe perfil"),TITULO("Perfil")
CAMPO=DESPERFIL,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del perfil que esta ejecutando el recurso")

CURSOR=CSELDESPERFIL SELECT DESPERFIL FROM VDPERFILTAREA WHERE CODPERFIL=:CODPERFIL
                   UNION
                  SELECT '' DESPERFIL FROM DUAL WHERE :CODPERFIL IS NULL;



CURSOR=CDESASIGNA DECLARE
                   RET NUMBER;
                  BEGIN
                   RET:=VDPLANMOV.DESASIGNAMOV(:CODRECURSO);
                   COMMIT;
                  END;@
                                
