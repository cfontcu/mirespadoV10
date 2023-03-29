#*****************************************************************
#M�dulo: VDINVENERRONEOSLIN.PAN
#Funcionalidad : Muestra los conteos de los inventarios que no han pasado las validaciones y el usuario decide qu� conteo,
#                validar, anular, o mandar un reconteo.
#Autor: ICC      
#Fecha: 28-01-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
INVENTARIOS REALIZADOS
���������������� Stock te�rico ��������������������������������������� Stock real ������������������������
Art�culo                      Lote      Cantidad Art�culo                        Lote      Cantidad Rotas Operario Fecha inicio         Acc         
_40_________ _100____________ _40______ ######## _40_________ _100______________ _40______ ######## ##### _32_____ �D-MM-Y.YYY _8______ _  
                                                                                                                                             |

WFRAME(1,-2,338,0,"Stock te�rico","text-aling:center")
WFRAME(338,-2,406,0,"Stock real","text-aling:center")
WLONX=1100
TABLA=VDINVENCONTEO
WHERE=STATUS IN (VDST.FINONOOK, VDST.FINONOKFIN);
ORDERBY=FECINI DESC, HORAINI DESC;

NODELETE
NOINSERT

PREUPDATE=FEJECUTA(FIF("CSELVALIDAV", FEJECUTA("CAJUDIFERENCIA", "ERROR\n:V10ERROR",
                                               "CVERSIERROR", ":MSJERROR",
                                               "CFININVENTARIO", "ERROR FINALIZANDO LINEA DE INVENTARIO"),
                                      FEJECUTA(FIF("CSELVALIDAR", FEJECUTA("CUPDINVENLIN", "ERROR ACTUALIZANDO LA LINEA DE IVNENTARIO",
                                                                           "CUPSTINVENCONTEO", "ERROR SOLICITANDO RECONTEO"),
                                                                  FEJECUTA("CSELVALIDAA","",
                                                                           "CUPSTINVENCONTEO", "ERROR ANULANDO LAS LINEAS DE CONTEOS",
                                                                           "CFININVENTARIO", "ERROR FINALIZANDO LINEA DE INVENTARIO")
                                                  ),"")),"",
                  "CSELMODIF","",
                  FCOMMIT,"",
                  %FFAILURE,"ACTUALIZADOS LOS CAMBIOS",
                  FPULSATECLAS("F6"),"")


CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"),VIRTUAL, OCULTO
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),VIRTUAL, OCULTO
CAMPO=CODMAT,TOOLTIP("C�digo de matr�cula a inventariar"),VIRTUAL, OCULTO
CAMPO=SEQINVEN,OCULTO,"##"
CAMPO=CODARTTEORICO,NOENTER,TOOLTIP("C�digo de art�culo antes de inventariar"), POSTCHANGE=FDESIGNACION("+CSELDESARTT",""),TITULO("Art�culo te�rico")
CAMPO=DESARTT,AUXILIAR,NOENTER
CAMPO=CODLOTTEORICO,NOENTER,TOOLTIP("C�digo de lote antes de inventaria"),TITULO("Lote")
CAMPO=CANTTEORICO,NOENTER,TOOLTIP("Cantidad antes de inventaria"),TITULO("Cantidad"),WLONX=20
CAMPO=CODARTREAL,NOENTER,TOOLTIP("C�digo de art�culo despu�s de inventariar"),POSTCHANGE=FDESIGNACION("+CSELDESARTR",""),TITULO("Art�culo real")
CAMPO=DESARTR,NOENTER,AUXILIAR,NOENTER
CAMPO=CODLOTREAL,NOENTER,TOOLTIP("C�digo de lote despu�s de inventaria"),TITULO("Lote")
CAMPO=CANTREAL,NOENTER,TOOLTIP("Cantidad total despu�s de inventariar, incluidas las rotas"),TITULO("Cantidad"),WLONX=20
CAMPO=CANTROTAS,NOENTER,TOOLTIP("Cantidad de unidades rotas"),TITULO("Rotas"),WLONX=20
CAMPO=CODOPE,NOENTER,TOOLTIP("C�digo de operario que realiza el inventario"),TITULO("Operario"),WLONX=20
CAMPO=FECINI,NOENTER,TOOLTIP("Fecha en juliano en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula"),TITULO("Fecha inicio")
CAMPO=HORAINI,NOENTER,TOOLTIP("Hora en que se inicia el inventario, es decir, cuando al operario comienza a inventariar la matr�cula")
CAMPO=ACCION,AUXILIAR,UPDATE,TOOLTIP("Acci�n. Posibles valores:  V(alidar), R(einventariar), A(anular)"),TITULO("Acc"),WLONX=15,COMBOX("CSELACCION"),
             POSTCHANGE=FDESIGNACION(FVERIFICA("VRA ","Debe introducir V(alidar), R(einventariar), A(anular)"),"",
                                                     "-CVALIDA", "NO PUEDE VALIDAR ESTE INVENTARIO,\nHA CAMBIADO EL STOCK DESDE QUE SE INVENTARIO\nSELECCIONE REINVENTARIAR O ANULAR")
CAMPO=CODCONCE,OCULTO,AUXILIAR,"__________"
CAMPO=STATUS,OCULTO,"######"
CAMPO=CODART,AUXILIAR,  OCULTO,VIRTUAL
CAMPO=CODLOT,AUXILIAR,  OCULTO,VIRTUAL
CAMPO=CANTIDAD,AUXILIAR,OCULTO,VIRTUAL
CAMPO=MSJERROR,OCULTO,AUXILIAR,"_200____________________________________"
CAMPO=CODOPEMODIF,OCULTO,"_32__",TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,OCULTO,"#######",TOOLTIP("Fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,OCULTO,"________",TOOLTIP("Hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELACCION SELECT 'V','Validar' FROM DUAL UNION
                  SELECT 'R','Reinventariar' FROM DUAL UNION
                  SELECT 'A','Anular' FROM DUAL;
                  


CURSOR=CSELDESARTT SELECT DESART DESARTT
                     FROM VDARTIC
                    WHERE CODART = :CODARTTEORICO;

CURSOR=CSELDESARTR SELECT DESART DESARTR
                     FROM VDARTIC
                    WHERE CODART = :CODARTREAL;


CURSOR=CVALIDA SELECT :ACCION
                 FROM DUAL
                WHERE :ACCION = 'V'
                  AND (:CODARTTEORICO != :CODART 
                   OR :CODLOTTEORICO != :CODLOT);

CURSOR=CSELVALIDAV SELECT VDST.FINOVALIDADO STATUS FROM DUAL WHERE :ACCION = 'V';
CURSOR=CSELVALIDAR SELECT VDST.FINOSRECONTEO STATUS FROM DUAL WHERE :ACCION = 'R';
CURSOR=CSELVALIDAA SELECT VDST.FINOANULADO STATUS FROM DUAL WHERE :ACCION = 'A';


#Acci�n= 'V' ----> Ajustar el stock
CURSOR=CAJUDIFERENCIA BEGIN
                         VDINVEN.REGULARIZAINVEN (:CODINVEN, :CODUBI, :SEQINVEN, :CODART, :CODLOT, :CANTIDAD, :MSJERROR);
                      END;@

CURSOR=CVERSIERROR SELECT :MSJERROR
                     FROM DUAL
                    WHERE :MSJERROR IS NULL;

CURSOR=CFININVENTARIO BEGIN VDINVEN.FININVENTARIO (:CODINVEN, :CODUBI, :CODMAT); END;@
#Acci�n='R' -----> Abrir el inventario.
CURSOR=CUPDINVENLIN UPDATE VDINVENLIN
                       SET STATUS = VDST.FINLENCURSO,
                           CODOPEMODIF = VDUSER.GETUSER,
                           FECMODIF    = VD.FECHASYS,
                           HORAMODIF   = VD.HORASYS
                     WHERE CODINVEN = :CODINVEN
                       AND CODUBI   = :CODUBI
                       AND NVL(CODMAT,:CODMAT) = :CODMAT;
                       
CURSOR=CUPSTINVENCONTEO UPDATE VDINVENCONTEO
                           SET STATUS = :STATUS,
                               CODOPEMODIF = VDUSER.GETUSER,
                               FECMODIF    = VD.FECHASYS,
                               HORAMODIF   = VD.HORASYS
                      WHERE CODINVEN = :CODINVEN
                        AND CODUBI   = :CODUBI
                        AND CODMAT   = :CODMAT;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;


ONLINE= {F1} Ayuda    {F2} Consulta    {F4} Confirmar cambios    {Esc} Cerrar Pantalla    
        {May-F7} Documentaci�n {May+F8} Imprimir  {F9} Borrar un registro    {F5} Borrar Pantalla    ;


