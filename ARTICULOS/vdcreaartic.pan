# M�dulo   : VDCREAARTIC.PAN
# Funci�n  : Creaci�n de art�culos
#
# Creaci�n : 14-02-2014
# Autor    : FPD
###########################################
# Hist�rico de cambios:
CREACION DE ARTICULOS
Divisi�n _____ _40______________________________   
Art�culo �nico _ 
Art�culo para Divisi�n _40___________________

C�digo _40____________________ Designaci�n ________________________________________
                                           ________________________________________
 Peso: #L,####.### Kg.
 Ancho: @L@@ cm. Alto: @L@@ cm. Largo: @L@@ cm.

 Palet defecto __________ __40___________________________

 Activo: _ (S/N)    Comentario @L@@@@@@@    Ultima modificaci�n _32________ �D-MM-Y.YY  ________
|


TABLA=VDARTIC
SELECT=PESOUNI/1000 PESOUNIAUX,LARGOUNI/10 LARGOUNIAUX,ALTOUNI/10 ALTOUNIAUX,ANCHOUNI/10 ANCHOUNIAUX,'S' ARTICUNICO;
ORDERBY=CODART DESC;

NOUPDATE
NOINSERT,PROTECT("ARTICULOS")

PREINSERT=FEJECUTA("+CSELDEFECTO","","CSELMODIF","ERROR EN FECHA DE MODIFICACION")
POSTINSERT=FEJECUTA("CCREACLASES","NO PUEDO CLASIFICAR EL ARTICULO",
                    "CINSTRADCODIGO","ERROR INSERTANDO CODIGO ALTERNATIVO",
                    %FFAILURE,"ARTICULO :CODART CREADO ",
                    FCOMMIT,"ERROR HACIENDO COMMIT")



CURSOR=CDAMETIPOCONTE SELECT DESTIPOCONTE FROM VDTIPOCONTE WHERE TIPOCONTE = :TIPOCONTEDEF;

CAMPO=CODDIV,TOOLTIP("Divisi�n a la que pertenece el art�culo"),POSTCHANGE=FDESIGNACION("CSELDIVIS","No existe divisi�n"),COMBOX("CLISTADIV"),
                CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S")
CAMPO=DESDIV,AUXILIAR,NOENTER,TOOLTIP("Designaci�n de la divisi�n"),CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S"),WHERE=CODDIV IN (SELECT CODDIV FROM VDDIVIS WHERE DESDIV LIKE '%'||:DESDIV||'%');
CAMPO=ARTICUNICO,AUXILIAR,TOOLTIP("Art�culo �nico en el maestro, no repetido para otras divisiones"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)")
CAMPO=CODARTDIV,TOOLTIP("C�digo del art�culo para la divisi�n"),POSTCHANGE=FDESIGNACION("+CSELCODART","")
CAMPO=CODART,NOENTER,TOOLTIP("C�digo interno del art�culo")
CAMPO=DESART,TOOLTIP("Designaci�n del art�culo")
CAMPO=DESARTALT,TOOLTIP("Designaci�n del art�culo")
CAMPO=PESOUNIAUX,AUXILIAR,TOOLTIP("Peso de la unidad")
CAMPO=LARGOUNIAUX,AUXILIAR,TOOLTIP("Largo de la unidad")
CAMPO=ANCHOUNIAUX,AUXILIAR,TOOLTIP("Ancho de la unidad")
CAMPO=ALTOUNIAUX,AUXILIAR,TOOLTIP("Alto de la unidad")
CAMPO=PESOUNI,OCULTO,"#L,######"
CAMPO=ANCHOUNI,OCULTO,"@L@@"
CAMPO=ALTOUNI,OCULTO,"@L@@"
CAMPO=LARGOUNI,OCULTO,"@L@@"
CAMPO=TIPOCONTEDEF,TOOLTIP("Tipo de contenedor por defecto"),POSTCHANGE=FDESIGNACION("CDAMETIPOCONTE",""),CONTEXTUAL=FEJECUTAFORM("VDTIPOCONTE","N","","","TIPOCONTEDEF=:TIPOCONTE","Selecci�n de tipo de contenedor","S")
CAMPO=DESTIPOCONTE,AUXILIAR,NOENTER,TOOLTIP("Tipo del contenedor por defecto")
CAMPO=SWTACTIVO,TOOLTIP("Indica si el producto esta activo"),POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)")
CAMPO=CODCOMEN,NOENTER,TOOLTIP("C�digo de comentario asociado al producto")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")


CAMPO=CODNAC,NOENTER,TOOLTIP("C�digo nacional"),OCULTO,"_____________"
CAMPO=UNIDADES,OCULTO,"_10"
CAMPO=UNIDADESHOST,OCULTO,"_10"
CAMPO=DECIMALES,OCULTO,"@L"
CAMPO=SWTANULADO,OCULTO,"_"
CAMPO=SWTGENERICO,OCULTO,"_"
CAMPO=SWTSTOCK,OCULTO,"_"
CAMPO=ORDENSAL,OCULTO,"_"
CAMPO=TRAZABULTO,OCULTO,"_"
CAMPO=SWTETIQ,OCULTO,"_"
CAMPO=AGRUPALIN,OCULTO,"_"
CAMPO=EMBCONT,OCULTO,"@L@@"
CAMPO=EMBPISO,OCULTO,"@L@@"
CAMPO=TIPOEMBADEF,OCULTO,"_10"
CAMPO=TIPOCAJC,OCULTO,"_10"
CAMPO=SWTPESACAJA,OCULTO,"_"
CAMPO=LARGOCAJC,OCULTO,"@L@@"
CAMPO=ANCHOCAJC,OCULTO,"@L@@"
CAMPO=ALTOCAJC,OCULTO,"@L@@"
CAMPO=PESOCAJC,OCULTO,"#L,######.###"
CAMPO=TIPOVOL,OCULTO,"_10"
CAMPO=TPCVERIF,OCULTO,"@L@"
CAMPO=TPCMARGENPESO,OCULTO,"@L@"
CAMPO=SWTTUMBABLE,OCULTO,"_"
CAMPO=UNIEMB,OCULTO,"@L@@@"
CAMPO=COEFUNI,OCULTO,"@L@@@"
CAMPO=UNIPAQ,OCULTO,"@L@@@"
CAMPO=LARGOPAQ,OCULTO,"@L@@@"
CAMPO=ANCHOPAQ,OCULTO,"@L@@@"
CAMPO=ALTOPAQ,OCULTO,"@L@@@"
CAMPO=PESOPAQ,OCULTO,"@L@@@"
CAMPO=COEFPAQ,OCULTO,"@L@@@"
CAMPO=SWTANALISIS,OCULTO,"_"
CAMPO=TCADUC,OCULTO,"@L"
CAMPO=UNICADUC,OCULTO,"_"
CAMPO=SWTLOTE,OCULTO,"_"
CAMPO=FORMATOLOTE,OCULTO,"_"
CAMPO=TRETEST,OCULTO,"@L@"
CAMPO=UNIRETEST,OCULTO,"_"
CAMPO=TAVISA,OCULTO,"@L"
CAMPO=UNIAVISA,OCULTO,"_"
CAMPO=PEDMULTIPLO,OCULTO,"@L"
CAMPO=TIPOAJUSTE,OCULTO,"_"
CAMPO=MINPENDIENTE,OCULTO,"@L"
CAMPO=MAXUNI,OCULTO,"@L"
CAMPO=MINPAL,OCULTO,"@L"
CAMPO=PICKINV,OCULTO,"_"
CAMPO=INVCONT,OCULTO,"_"
CAMPO=PETINICAJA,OCULTO,"_"
CAMPO=CONFPICKING,OCULTO,"_"
CAMPO=PVPVIGENTE,OCULTO,"#L#######"
CAMPO=PVPNUEVO,OCULTO,"#L#######"
CAMPO=PVPANTIGUO,OCULTO,"#L#######"
CAMPO=FECVIGNP,OCULTO,"�D-MM-Y.YY"
CAMPO=PVDVIGENTE,OCULTO,"#L#######"
CAMPO=PVDNUEVO,OCULTO,"#L#######"
CAMPO=PVDANTIGUO,OCULTO,"#L#######"
CAMPO=PVPIVAVIGENTE,OCULTO,"#L#######"
CAMPO=PVPIVANUEVO,OCULTO,"#L#######"
CAMPO=PVPIVAANTIGUO,OCULTO,"#L#######"
CAMPO=DUMMY,AUXILIAR,OCULTO,"_"

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDIVIS SELECT DESDIV, 'NORMAL' TIPOCONTEDEF, 'S' SWTACTIVO,'S' ARTICUNICO FROM VDDIVIS WHERE CODDIV=:CODDIV;

CURSOR=CCREACLASES BEGIN
                      INSERT INTO VDCLASEARTIC (CODCLASIF,CODCLASE,CODART,VDEXTRA,CODOPEMODIF,FECMODIF,HORAMODIF)
                      VALUES ('UBICACION','NORMAL',:CODART,'',VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);
                      INSERT INTO VDCLASEARTIC (CODCLASIF,CODCLASE,CODART,VDEXTRA,CODOPEMODIF,FECMODIF,HORAMODIF)
                      VALUES ('RECEPCION','CONLOTE',:CODART,'',VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);
                      INSERT INTO VDCLASEARTIC (CODCLASIF,CODCLASE,CODART,VDEXTRA,CODOPEMODIF,FECMODIF,HORAMODIF)
                      VALUES ('VENTA','NORMAL',:CODART,'',VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);
                    END;@

CURSOR=CSELDEFECTO SELECT '' CODNAC,'UN' UNIDADES,'UN' UNIDADESHOST,3 DECIMALES,'N' SWTANULADO,'N' SWTGENERICO,'S' SWTSTOCK,
                          'C' ORDENSAL,'N' TRAZABULTO,'S' SWTETIQ,'S' AGRUPALIN,1 EMBCONT,1 EMBPISO,'CAJA' TIPOEMBADEF,
                          0 PESOCAJC,'NORMAL' TIPOVOL,0 TPCVERIF,0 TPCMARGENPESO,'S' SWTTUMBABLE,
                          0 COEFUNI,0 UNIPAQ,0 LARGOPAQ,0 ALTOPAQ,0 ANCHOPAQ,0 PESOPAQ,0 COEFPAQ,
                          'N' SWTANALISIS,0 TCADUC,'M' UNICADUC,0 TRETEST,'M' UNIRETEST,0 TAVISA,'M' UNIAVISA,'S' INVCONT,'C' PETINICAJA,
                          'S' CONFPICKING,'U' FORMATOLOTE,'S' SWTPESACAJA,'N' PICKINV,'N' TIPOAJUSTE,1 PEDMULTIPLO,
                          NVL(:SWTACTIVO,'S') SWTACTIVO, 1 UNIEMB, 'S' SWTLOTE, :LARGOUNIAUX*10 LARGOCAJC, :ANCHOUNIAUX*10 ANCHOCAJC, :ALTOUNIAUX*10 ALTOCAJC,
                          :LARGOUNIAUX*10 LARGOUNI, :ANCHOUNIAUX*10 ANCHOUNI, :ALTOUNIAUX*10 ALTOUNI,:PESOUNIAUX*1000 PESOUNI,
                          99999 MAXUNI
                    FROM DUAL;

CURSOR=CSELCODART SELECT CASE :ARTICUNICO WHEN 'S' THEN :CODARTDIV ELSE :CODDIV||:CODARTDIV END CODART FROM DUAL;

CURSOR=CLISTADIV SELECT CODDIV,DESDIV,DESEMP FROM VDDIVIS DIV,VDEMPRE EMP WHERE EMP.CODEMP=DIV.CODEMP AND DIV.SWTACTIVA='S' ORDER BY CODDIV;

CURSOR=CINSTRADCODIGO INSERT INTO VDTRADCODIGO (CODART,CODARTALT,SWTACTIVO,TIPOBARRAS,CODCOMEN,CODOPEMODIF, FECMODIF, HORAMODIF)
                           VALUES (:CODART,:CODARTDIV,'S',NULL,0,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);

ONLINE={F1} Ayuda  {F4} Confirmar Cambios  {F6} Cambio de pantalla  {F9} Borrar Registro;



