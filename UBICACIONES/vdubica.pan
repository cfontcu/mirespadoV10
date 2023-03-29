# M�dulo   : VDUBICA.PAN
# Funci�n  : Mantenimiento de ubicaciones
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE UBICACIONES

 Ubicaci�n _20___________ Area _20_________ _40_____________________________________
 Art�culo  _40___________________ _100______________________________________________

 Zona _3N Planta @L@@ Pasillo @L@@ Acera @L Modulo @L@ Columna @L@@    Altura @L@@   Prof. @L@@
 ��������� Comportamiento �������  ������ Ordenes  �����  ���������� Capacidad ���������� 
 � Tipo _          Etiqueta _   �  � Entrada @L@@@@@@@ �  � Agrupaci�n entrada   _1_    �  
 � Agrupa l�neas _ Stock    _   �  � Salida  @L@@@@@@@ �  � Agrupaci�n capacidad _1_    �
 � Multiart�culo _ Tr�nsito _   �  � Movto   @L@@@@@@@ �  � Stock m�ximo   #L#######    �
 � Multiformato  _ Recargar _   �  �                   �  � Stock M�nimo   #L#######    �
 � Bloq.Entrada  _ Bloq.Salida _�  �                   �  � Stock Urgente  #L#######    �
 ��������������������������������  ���������������������  �������������������������������
 Dimensiones: @L@@-@L@@-@L@@ Coef: @L@
                                                          Unidades     Emb     Cont 
 Extra _255_______________________________________ Stk:  #L#,###,##   @,@L@   @,@@L@
 Comentario @L@@@@@@@                              Ord:  #L#,###,##   @,@@L   @L,@L@
 Ult.Modif. _32________ �D-MM-Y.YY ________        Res:  #L#,###,##   @,@@L   @,@@L@
|                                                      
TABLA=VDUBICA                                          

PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
POSTQUERY=FEJECUTA("CSELSTOCK","")
#,                   "CCOLORES","") 


CAMPO=CODUBI,NOUPDATE,TOOLTIP("C�digo de la ubicaci�n"),INCLUDECSS="border-style:ridge;background-color:#F7BE81;"
CAMPO=CODAREA,TOOLTIP("C�digo del area al que pertenece la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELAREA","No existe area"),COMBOX("CSELAREAS")
#                         CONTEXTUAL=FEJECUTAFORM("VDSELAREA","N","","","CODAREA=:CODAREA","Selecci�n de area","S"),
CAMPO=DESAREA,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del �rea")
CAMPO=CODART,TOOLTIP("Articulo asociado a la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELARTIC","No existe art�culo"),INCLUDECSS="border-style:ridge;background-color:#F7BE81;"
#CONTEXTUAL=FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","Selecci�n de art�culo","S"),
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo asociado a la ubicacion")
CAMPO=CODZONA,TOOLTIP("C�digo de la zona")
CAMPO=PLANTA,TOOLTIP("Planta")
CAMPO=PASILLO,TOOLTIP("Pasillo")
CAMPO=ACERA,TOOLTIP("Acera")
CAMPO=MODULO,TOOLTIP("Modulo")
CAMPO=COLUMNA,TOOLTIP("Columna")
CAMPO=ALTURA,TOOLTIP("Altura")
CAMPO=PROFUNDIDAD,TOOLTIP("Profundidad")
CAMPO=TIPOUBI,TOOLTIP("Indica si la ubicaci�n es R(eal) o V(irtual)"),POSTCHANGE=FVERIFICA("RV","Debe introducir R(eal) o V(irtual)")
CAMPO=SWTETIQ,TOOLTIP("Indica si la ubicaci�n tiene etiqueta"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=ORDENENTRADA,TOOLTIP("Orden de la ubicaci�n para entradas")
CAMPO=UNIAGRUPAE,TOOLTIP("Unidad de agrupacion para entradas"),POSTCHANGE=FVERIFICA("UEC","Debe introducir U(nidades) E(mbalajes) C(ontenedores)"),COMBOX("C - Contenedores","E - Embalajes","U - Unidades")
CAMPO=AGRUPALIN,TOOLTIP("Indica si la ubicaci�n ha de agrupar las lineas con las mismas caracteristicas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=STOCK,TOOLTIP("Indica si la ubicaci�n guarda stock o actua como sumidero/manantial"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=ORDENSALIDA,TOOLTIP("Orden de la ubicaci�n para salidas")
CAMPO=UNICAPAC,TOOLTIP("Unidad de agrupaci�n para medir la capacidad"),POSTCHANGE=FVERIFICA("UEC","Debe introducir U(nidades) E(mbalajes) C(ontenedores)"),COMBOX("C - Contenedores","E - Embalajes","U - Unidades")
CAMPO=MULTIARTICULO,TOOLTIP("Indica si la ubicaci�n puede contener m�s de un art�culo"),CHECKBOX("N","S")
CAMPO=TRANSITO,TOOLTIP("Indica si la ubicaci�n es de transito"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=ORDENMOVIM,TOOLTIP("Orden de la ubicaci�n para movimientos")
CAMPO=STKMAX,TOOLTIP("Stock m�ximo en la ubicaci�n medida en la unidades de capacidad de la ubicacion")
CAMPO=MULTIFORMATO,TOOLTIP("Indica si la ubicacion puede contener mas de un formato o lote"),POSTCHANGE=FVERIFICA("SNL","Debe introducir S(i), N(o) o L(ote)")
CAMPO=RECARGAR,TOOLTIP("Indica si la ubicacion ha de ser recargada por el programa autom�tico\nPuede valer S Si F Rellena a saturaci�n"),POSTCHANGE=FVERIFICA("SF ","Debe introducir S(i) o  F a saturaci�n")
CAMPO=STKMIN,TOOLTIP("Stock m�nimo en la ubicaci�n medida en la unidades de capacidad de la ubicacion")
CAMPO=BLOQUEOSE,TOOLTIP("Indica si la ubicaci�n esta bloqueada para entradas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")
CAMPO=BLOQUEOSS,TOOLTIP("Indica si la ubicaci�n esta bloqueada para salidas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)"),CHECKBOX("N","S")

CAMPO=STKURG,TOOLTIP("Stock urgente en la ubicaci�n medida en la unidades de capacidad de la ubicacion")
CAMPO=LARGOUBI,TOOLTIP("Largo de la ubicacion")
CAMPO=ANCHOUBI,TOOLTIP("Ancho de la ubicacion")
CAMPO=ALTOUBI,TOOLTIP("Alto de la ubicacion")
CAMPO=COEFUBI,TOOLTIP("Coeficiente de ocupaci�n de la ubicacion")
CAMPO=VDEXTRA,TOOLTIP("Campo extra disponible para el implantador")

CAMPO=STOCKUNI,AUXILIAR,NOENTER
CAMPO=STOCKEMBA,AUXILIAR,NOENTER
CAMPO=STOCKCONTE,AUXILIAR,NOENTER
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario asociado al producto")

CAMPO=ORDENUNI,AUXILIAR,NOENTER
CAMPO=ORDENEMBA,AUXILIAR,NOENTER
CAMPO=ORDENCONTE,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro"),COMBOX("CALENDARIO")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CAMPO=RESUNI,AUXILIAR,NOENTER
CAMPO=RESEMBA,AUXILIAR,NOENTER
CAMPO=RESCONTE,AUXILIAR,NOENTER



CURSOR=CSELAREAS SELECT CODAREA,DESAREA,CODALM FROM VDAREA ORDER BY CODALM,CODAREA;

CURSOR=CSELSTOCK SELECT VDSTK.UBISTOCK(:CODUBI, 'U',NULL, NULL,0, NULL,1) STOCKUNI,
                        VDSTK.UBISTOCK(:CODUBI, 'E') STOCKEMBA,
                        VDSTK.UBISTOCK(:CODUBI, 'C') STOCKCONTE,
                        VDUBI.UBIORDENADO(:CODUBI,'U',1) ORDENUNI,
                        VDUBI.UBIORDENADO(:CODUBI,'E') ORDENEMBA,
                        VDUBI.UBIORDENADO(:CODUBI,'C') ORDENCONTE,
                        VDUBI.UBIRESERVADO(:CODUBI,'U',NULL,NULL,1) RESUNI,
                        VDUBI.UBIRESERVADO(:CODUBI,'E') RESEMBA,
                        VDUBI.UBIRESERVADO(:CODUBI,'C') RESCONTE FROM DUAL;

CURSOR=CCOLORES SELECT DECODE(:ORDENUNI,0,-1,19)  ORDENUNI__COLOR, 
                       DECODE(:ORDENUNI,0,-1,19)  ORDENEMBA__COLOR, 
                       DECODE(:ORDENUNI,0,-1,19)  ORDENCONTE__COLOR, 
                       DECODE(:RESUNI,0,-1,18)  RESUNI__COLOR,
                       DECODE(:RESUNI,0,-1,18)  RESEMBA__COLOR,
                       DECODE(:RESUNI,0,-1,18)  RESCONTE__COLOR FROM DUAL;
 
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELAREA SELECT DESAREA FROM VDAREA WHERE CODAREA=:CODAREA;

CURSOR=CSELARTIC SELECT DESART FROM VDARTIC WHERE CODART=:CODART
                   UNION
                 SELECT '' DESART FROM DUAL WHERE :CODART IS NULL;


#TECLA=SF7,FEJECUTAFORM("VDCOMEN","S","","CODCOMEN=:CODCOMEN","","COMENTARIOS DE CODCOMEN :CODCOMEN","S")

CURSOR=CCLEAR BEGIN
                CLEARMINI(:CODUBI);
              END;@

TECLA=SF8,FEJECUTA("CCLEAR","",FCOMMIT,"")




