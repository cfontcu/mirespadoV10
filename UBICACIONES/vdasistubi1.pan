# M�dulo   : VDASISTUBI1.PAN
# Funci�n  : Asistente de Creaci�n de Ubicaciones
#
# Creaci�n : 14-07-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
ASISTENTE DE CREACION DE UBICACIONES

 Zona @L@   Area _20_________ _40__________________________________
  
 Tipo _ (V)irtual/(R)eal   Agrupa l�neas _ (S/N)    Etiqueta _ (S/N)
 
 Multiart�culo _ (S/N)   
 Multiformato  _ (S/N) 
 
 Bloqueos: Entrada _ (S/N)  
           Salida  _ (S/N)    
 
 Agrupaci�n entrada   _  (C)ontenedores, (E)mbalajes o (U)nidades
 Agrupaci�n capacidad _  (C)ontenedores, (E)mbalajes o (U)nidades
    
   Stock Max: #L########.#### 
   Stock M�n: #L########.#### 
   Stock Urg: #L########.####
 
 Tr�nsito _ (S/N)   
 Stock    _ (S/N)    
 Recargar _ (S/F/' ')    
 Confirmar Picking _ (S/N)
 
 Art�culo _40___________________ _100_______________________________

�������������������������������������������������������������������� 
�                                                                  �
� Planta:      de @L@@ a @L@@, inc @L@@  (N�m.Plantas  @L@@) (pla) � 
� Pasillo:     de @L@@ a @L@@, inc @L@@  (N�m.Pasillos @L@@) (pas) � 
� Columna:     de @L@@ a @L@@, inc @L@@  (N�m.Columnas @L@@) (col) � 
� Altura:      de @L@@ a @L@@, inc @L@@  (N�m.Alturas  @L@@) (alt) �
� Profundidad: de @L@@ a @L@@, inc @L@@  (N�m.Profund. @L@@) (pro) �
�                                                                  � 
� M�scara: _40__________________________  Total Ubic. @@L@@@@      �
��������������������������������������������������������������������
 
 ������������������������ Clasificaciones ������������������������� 
 �                                                                �
 �  Estados:      _______________   Compatible:  _______________  � 
 �                                                                �
 �  Contenedores: _______________   Embalajes:   _______________  �
 �                                                                � 
 �                (Shift+F10 para seleccionar clases)             �
 ������������������������������������������������������������������
 
 Orden de Ubicaciones:  
  Orden entrada    _1000____________________________________________
  Orden salida     _1000____________________________________________
  Orden movimiento _1000____________________________________________
|

TABLA=DUAL
NOQUERY

CAMPO=CODZONA,AUXILIAR,TOOLTIP("C�digo de la zona")
CAMPO=CODAREA,AUXILIAR,TOOLTIP("C�digo del area al que pertenece la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELAREA","No existe area"),
                         CONTEXTUAL=FEJECUTAFORM("VDSELAREA","N","","","CODAREA=:CODAREA","Selecci�n de area","S")
CAMPO=DESAREA,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del �rea")
CAMPO=TIPOUBI,AUXILIAR,TOOLTIP("Indica si la ubicaci�n es R(eal) o V(irtual)"),POSTCHANGE=FVERIFICA("RV","Debe introducir R(eal) o V(irtual)")
CAMPO=AGRUPALIN,AUXILIAR,TOOLTIP("Indica si la ubicaci�n ha de agrupar las l�neas con las mismas caracter�sticas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=SWTETIQ,AUXILIAR,TOOLTIP("Indica si la ubicaci�n tiene etiqueta"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=MULTIARTICULO,AUXILIAR,TOOLTIP("Indica si la ubicaci�n puede contener m�s de un art�culo"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=MULTIFORMATO,AUXILIAR,TOOLTIP("Indica si la ubicacion puede contener mas de un formato o lote"),POSTCHANGE=FVERIFICA("SNL","Debe introducir S(i), N(o) o L(ote)")
CAMPO=BLOQUEOSE,AUXILIAR,TOOLTIP("Indica si la ubicaci�n esta bloqueada para entradas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=BLOQUEOSS,AUXILIAR,TOOLTIP("Indica si la ubicaci�n esta bloqueada para salidas"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=UNIAGRUPAE,AUXILIAR,TOOLTIP("Unidad de agrupacion para entradas"),POSTCHANGE=FVERIFICA("UEC","Debe introducir U(nidades) E(mbalajes) C(ontenedores)")
CAMPO=UNICAPAC,AUXILIAR,TOOLTIP("Unidad de agrupaci�n para medir la capacidad"),POSTCHANGE=FVERIFICA("UEC","Debe introducir U(nidades) E(mbalajes) C(ontenedores)")
CAMPO=STKMAX,AUXILIAR,TOOLTIP("Stock m�ximo en la ubicaci�n medido en las unidades de capacidad de la ubicaci�n")
CAMPO=STKMIN,AUXILIAR,TOOLTIP("Stock m�nimo en la ubicaci�n medido en la unidades de capacidad de la ubicaci�n")
CAMPO=STKURG,AUXILIAR,TOOLTIP("Stock urgente en la ubicaci�n medido en la unidades de capacidad de la ubicaci�n")
CAMPO=TRANSITO,AUXILIAR,TOOLTIP("Indica si la ubicaci�n es de tr�nsito"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=STOCK,AUXILIAR,TOOLTIP("Indica si la ubicaci�n guarda stock o act�a como sumidero/manantial"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=RECARGAR,AUXILIAR,TOOLTIP("Indica si la ubicacion ha de ser recargada por el programa autom�tico\nPuede valer S Si F Rellena a saturaci�n"),POSTCHANGE=FVERIFICA("SF ","Debe introducir S(i) o  F a saturaci�n")
CAMPO=CONFPICKING,AUXILIAR,TOOLTIP("Indica si se ha de confirmar la siguiente caja existente en la ubicaci�n en el proceso de picking, dependiendo del campo CONFPICKING del maestro de art�culos. Puede tomar los valores: S(i) o N(o)"),POSTCHANGE=FVERIFICA("SN","Debe introducir S(i) o N(o)")
CAMPO=CODART,AUXILIAR,TOOLTIP("Articulo asociado a la ubicaci�n"),POSTCHANGE=FDESIGNACION("CSELARTIC","No existe art�culo"),
                        CONTEXTUAL=FEJECUTAFORM("VDSELART","N","","","CODART=:CODART","Selecci�n de art�culo","S")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo asociado a la ubicacion")
CAMPO=INIPLANTA,AUXILIAR
CAMPO=FINPLANTA,AUXILIAR
CAMPO=INCPLANTA,AUXILIAR,POSTCHANGE=FDESIGNACION("CNUMPLANTAS","ERROR CALCULANDO NUMERO DE PLANTAS","CNUMUBI","ERROR EN CNUMUBI")
CAMPO=NUMPLANTAS,NOENTER,AUXILIAR
CAMPO=INIPASILLO,AUXILIAR
CAMPO=FINPASILLO,AUXILIAR
CAMPO=INCPASILLO,AUXILIAR,POSTCHANGE=FDESIGNACION("CNUMPASILLOS","ERROR CALCULANDO NUMERO DE PASILLOS","CNUMUBI","ERROR EN CNUMUBI")
CAMPO=NUMPASILLOS,NOENTER,AUXILIAR
CAMPO=INICOLUMNA,AUXILIAR
CAMPO=FINCOLUMNA,AUXILIAR
CAMPO=INCCOLUMNA,AUXILIAR,POSTCHANGE=FDESIGNACION("CNUMCOLUMNAS","ERROR CALCULANDO NUMERO DE COLUMNAS","CNUMUBI","ERROR EN CNUMUBI")
CAMPO=NUMCOLUMNAS,NOENTER,AUXILIAR
CAMPO=INIALTURA,AUXILIAR
CAMPO=FINALTURA,AUXILIAR
CAMPO=INCALTURA,AUXILIAR,POSTCHANGE=FDESIGNACION("CNUMALTURAS","ERROR CALCULANDO NUMERO DE ALTURAS","CNUMUBI","ERROR EN CNUMUBI")
CAMPO=NUMALTURAS,NOENTER,AUXILIAR
CAMPO=INIPROFUNDIDAD,AUXILIAR
CAMPO=FINPROFUNDIDAD,AUXILIAR
CAMPO=INCPROFUNDIDAD,AUXILIAR,POSTCHANGE=FDESIGNACION("CNUMPROFUNDIDADES","ERROR CALCULANDO NUMERO DE PROFUNDIDADES","CNUMUBI","ERROR EN CNUMUBI")
CAMPO=NUMPROFUNDIDADES,NOENTER,AUXILIAR
CAMPO=MASCARA,MIXED,AUXILIAR,TOOLTIP("M�scara de creaci�n de ubicaciones; p.e. A%pas2-%col3-%alt")
CAMPO=NUMUBI,NOENTER,AUXILIAR,TOOLTIP("N�mero de ubicaciones que se van a crear seg�n criterios seleccionados")
CAMPO=CODCLASEESTADOS,NOUPDATE,AUXILIAR,CONTEXTUAL=FEJECUTAFORM("VDSELCLASE","N","CODCLASIF='ESTADOS'","","CODCLASEESTADOS=:CODCLASE"),POSTCHANGE=FEJECUTA("CCHECKCLASEESTADOS","LA CLASE DE LA CLASIF. ESTADOS ES INCORRECTA")
CAMPO=CODCLASECOMPATIBLE,NOUPDATE,AUXILIAR,CONTEXTUAL=FEJECUTAFORM("VDSELCLASE","N","CODCLASIF='COMPATIBLE'","","CODCLASECOMPATIBLE=:CODCLASE"),POSTCHANGE=FEJECUTA("CCHECKCLASECOMPATIBLE","LA CLASE DE LA CLASIF. COMPATIBLE ES INCORRECTA")
CAMPO=CODCLASECONTENEDORES,NOUPDATE,AUXILIAR,CONTEXTUAL=FEJECUTAFORM("VDSELCLASE","N","CODCLASIF='CONTENEDORES'","","CODCLASECONTENEDORES=:CODCLASE"),POSTCHANGE=FEJECUTA("CCHECKCLASECONTENEDORES","LA CLASE DE LA CLASIF. CONTENEDORES ES INCORRECTA")
CAMPO=CODCLASEEMBALAJES,NOUPDATE,AUXILIAR,CONTEXTUAL=FEJECUTAFORM("VDSELCLASE","N","CODCLASIF='EMBALAJES'","","CODCLASEEMBALAJES=:CODCLASE"),POSTCHANGE=FEJECUTA("CCHECKCLASEEMBALAJES","LA CLASE DE LA CLASIF. EMBALAJES ES INCORRECTA")
CAMPO=SQLORDENENTRADA,AUXILIAR,TOOLTIP("FOrmula para calcular orden de entrada de ubicaciones; P.E. ROWNUM, o PLANTA*100+COLUMNA*10+ALTURA")
CAMPO=SQLORDENSALIDA,AUXILIAR,TOOLTIP("FOrmula para calcular orden de salida de ubicaciones; P.E. ROWNUM, o PLANTA*100+COLUMNA*10+ALTURA")
CAMPO=SQLORDENMOVIMIENTO,AUXILIAR,TOOLTIP("FOrmula para calcular orden de movto de ubicaciones; P.E. ROWNUM, o PLANTA*100+COLUMNA*10+ALTURA")
CAMPO=MSJERROR,AUXILIAR,OCULTO,"_1000__________"

CURSOR=CCHECKCLASEESTADOS SELECT :CODCLASEESTADOS FROM VDCLASES WHERE CODCLASIF='ESTADOS' AND (:CODCLASEESTADOS=CODCLASE OR :CODCLASEESTADOS IS NULL);

CURSOR=CCHECKCLASECOMPATIBLE SELECT :CODCLASECOMPATIBLE FROM VDCLASES WHERE CODCLASIF='COMPATIBLE' AND (:CODCLASECOMPATIBLE=CODCLASE OR :CODCLASECOMPATIBLE IS NULL);

CURSOR=CCHECKCLASECONTENEDORES SELECT :CODCLASECONTENEDORES FROM VDCLASES WHERE CODCLASIF='CONTENEDORES' AND (:CODCLASECONTENEDORES=CODCLASE OR :CODCLASECONTENEDORES IS NULL);

CURSOR=CCHECKCLASEEMBALAJES SELECT :CODCLASEEMBALAJES FROM VDCLASES WHERE CODCLASIF='EMBALAJES' AND (:CODCLASEEMBALAJES=CODCLASE OR :CODCLASEEMBALAJES IS NULL);

CURSOR=CNUMPLANTAS SELECT ((:FINPLANTA-:INIPLANTA)+(1*DECODE(:INCPLANTA,0,1,:INCPLANTA)))/DECODE(:INCPLANTA,0,1,:INCPLANTA) NUMPLANTAS FROM DUAL 
                             WHERE (:INIPLANTA>0 AND :FINPLANTA>0 AND :INCPLANTA>0) OR 
                                   (:INIPLANTA=0 AND :FINPLANTA=0 AND :INCPLANTA=0) OR
                                   ((:INIPLANTA + :FINPLANTA)>0 AND :INCPLANTA>0);
                             
CURSOR=CNUMPASILLOS SELECT ((:FINPASILLO-:INIPASILLO)+(1*DECODE(:INCPASILLO,0,1,:INCPASILLO)))/DECODE(:INCPASILLO,0,1,:INCPASILLO) NUMPASILLOS FROM DUAL 
                             WHERE (:INIPASILLO>0 AND :FINPASILLO>0 AND :INCPASILLO>0) OR
                                   (:INIPASILLO=0 AND :FINPASILLO=0 AND :INCPASILLO=0) OR
                                   ((:INIPASILLO + :FINPASILLO)>0 AND :INCPASILLO>0);	
                             			 
CURSOR=CNUMCOLUMNAS SELECT ((:FINCOLUMNA-:INICOLUMNA)+(1*DECODE(:INCCOLUMNA,0,1,:INCCOLUMNA)))/DECODE(:INCCOLUMNA,0,1,:INCCOLUMNA) NUMCOLUMNAS FROM DUAL 
                             WHERE (:INICOLUMNA>0 AND :FINCOLUMNA>0 AND :INCCOLUMNA>0) OR
                                   (:INICOLUMNA=0 AND :FINCOLUMNA=0 AND :INCCOLUMNA=0) OR
                                   ((:INICOLUMNA + :FINCOLUMNA)>0 AND :INCCOLUMNA>0);
                                   
CURSOR=CNUMALTURAS SELECT ((:FINALTURA-:INIALTURA)+(1*DECODE(:INCALTURA,0,1,:INCALTURA)))/DECODE(:INCALTURA,0,1,:INCALTURA) NUMALTURAS FROM DUAL 
                             WHERE (:INIALTURA>0 AND :FINALTURA>0 AND :INCALTURA>0) OR
                                   (:INIALTURA=0 AND :FINALTURA=0 AND :INCALTURA=0) OR
                                   ((:INIALTURA + :FINALTURA)>0 AND :INCALTURA>0);

CURSOR=CNUMPROFUNDIDADES SELECT ((:FINPROFUNDIDAD-:INIPROFUNDIDAD)+(1*DECODE(:INCPROFUNDIDAD,0,1,:INCPROFUNDIDAD)))/DECODE(:INCPROFUNDIDAD,0,1,:INCPROFUNDIDAD) NUMPROFUNDIDADES FROM DUAL 
                             WHERE (:INIPROFUNDIDAD>0 AND :FINPROFUNDIDAD>0 AND :INCPROFUNDIDAD>0) OR
                                   (:INIPROFUNDIDAD=0 AND :FINPROFUNDIDAD=0 AND :INCPROFUNDIDAD=0) OR
                                   ((:INIPROFUNDIDAD + :FINPROFUNDIDAD)>0 AND :INCPROFUNDIDAD>0);

CURSOR=CNUMUBI SELECT DECODE(:NUMPLANTAS,0,1,:NUMPLANTAS) * 
                      DECODE(:NUMPASILLOS,0,1,:NUMPASILLOS) * 
                      DECODE(:NUMCOLUMNAS,0,1,:NUMCOLUMNAS) *
                      DECODE(:NUMALTURAS,0,1,:NUMALTURAS)  *
                      DECODE(:NUMPROFUNDIDADES,0,1,:NUMPROFUNDIDADES) NUMUBI FROM DUAL;

CURSOR=CSELAREA SELECT DESAREA FROM VDAREA WHERE CODAREA=:CODAREA;

CURSOR=CSELARTIC SELECT DESART FROM VDARTIC WHERE CODART=:CODART
                   UNION
                 SELECT '' DESART FROM DUAL WHERE :CODART IS NULL;



CURSOR=CCHEQUEADATOS1 SELECT VDUBI.CHEQUEADATOSUBI(:CODZONA,:CODAREA,:TIPOUBI,:AGRUPALIN,:SWTETIQ,:MULTIARTICULO, :MULTIFORMATO,:BLOQUEOSE, :BLOQUEOSS,                         
                                                                    :STKMAX ,    :STKMIN,    :STKURG, :STOCK, :TRANSITO, :UNIAGRUPAE,:UNICAPAC,:RECARGAR, :CODART, :CONFPICKING,
                                                                    :INIPLANTA,  :FINPLANTA, :INCPLANTA,
                                                                    :INIPASILLO, :FINPASILLO,:INCPASILLO,
                                                                    :INICOLUMNA, :FINCOLUMNA,:INCCOLUMNA,
                                                                    :INIALTURA,  :FINALTURA, :INCALTURA,
                                                                    :INIPROFUNDIDAD, :FINPROFUNDIDAD, :INCPROFUNDIDAD,
                                                                    :MASCARA, :SQLORDENENTRADA, :SQLORDENSALIDA, :SQLORDENMOVIMIENTO ) MSJERROR FROM DUAL;
                                                                    
CURSOR=CCHEQUEAMSJERROR SELECT :MSJERROR FROM DUAL WHERE :MSJERROR IS NOT NULL;


TECLA=F4,FEJECUTA("CCHEQUEADATOS1","ERROR EN CCHEQUEADATOS1",
                  "-CCHEQUEAMSJERROR","ERROR :MSJERROR",
                   FPULSATECLAS("F6","F3","F2"))
                   

