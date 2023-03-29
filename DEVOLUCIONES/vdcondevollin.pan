LINEAS DE DEVOLUCION CON EL PRECINTO
Devol.    Articulo     Designaci�n                         Lote        Caduc.   E   Cant. Estado            Causa      Observ                Ultima modificaci�n
@L,@@@@@@ _40_________ _100_______________________________ _40________ ________ _ _ @L@@@ @L@@ _30_________ __________ _255_________________ _______________ �D-MM-Y.YY ________
|

TABLA=VDDEVOLLIN
WHERE= STATUS BETWEEN VDVST.FDVLAPTO AND VDVST.FDVLNOAPTO;
NOINSERT
NODELETE
NOUPDATE

REGPAG=25
WLONY=450
PREINSERT=FDESIGNACION("CSELOPEINS","")

CAMPO=CODPRECINTO,VIRTUAL,OCULTO
CAMPO=SEQDEVOL,TITULO("Devoluci�n"),WLONX=20
CAMPO=CODART,UPPER,POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),TITULO("C�digo")
CAMPO=DESART,AUXILIAR,NOENTER,TITULO("Designaci�n")
CAMPO=CODLOT,UPPER,POSTCHANGE=FDESIGNACION("CSELCODLOT","No existe lote"),TITULO("Lote")
CAMPO=CADUCI,AUXILIAR,NOENTER,TITULO("Caducidad")
CAMPO=STLOTEAB,NOENTER,TOOLTIP("El estado del lote para determinar si es abonable o no\n\n0 NO ABONABLE. Al no tener definidos criterios;\n\n1 NO ABONABLE. No ha caducado y caduca mas all� de X meses;\n\n2 ABONABLE. Caducado hace menos de Y meses o no caducado, y caduca en menos de X meses;\n\n3 NO ABONABLE. Caducado hace mas de Y meses")
CAMPO=STLOTEAPTO,NOENTER,TOOLTIP("El estado del lote para determinar si es apto o no\n\n0 NO APTO, al no definirse criterios\n\n1 NO APTO. No ha caducado pero caduca en menos de Z meses\n\n2 APTO.No ha caducado y caduca mas alla de Z meses\n\n3 NO APTO. Caducado")                                  
CAMPO=CANTIDAD,TITULO("Cantidad")
CAMPO=STATUS,NOENTER,POSTCHANGE=FEJECUTA("+CDAMESTATUS",""),TITULO("Estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODCAUSA,COMBOX("CSELCAUSA"),TITULO("Causa")
CAMPO=OBSERV,TITULO("Observaciones")
CAMPO=CODOPEINS,NOENTER,TITULO("Ultima modificaci�n")
CAMPO=FECINS,NOENTER
CAMPO=HORAINS,NOENTER,WLONX=12

CAMPO=CODOPESALIDAEXT,OCULTO,"_32_"
CAMPO=FECSALIDAEXT,OCULTO,"�D-MM-Y.YY"
CAMPO=HORASALIDAEXT,OCULTO,"________"
CAMPO=CODOPEDESTRUYE,OCULTO,"_32_"
CAMPO=FECDESTRUYE,OCULTO,"�D-MM-Y.YY"
CAMPO=HORADESTRUYE,OCULTO,"________"

CAMPO=CODOPEINVEN,OCULTO,"_32_"
CAMPO=FECINVEN,OCULTO,"�D-MM-Y.YY"
CAMPO=HORAINVEN,OCULTO,"________"
CAMPO=CODOPENOAPTO,OCULTO,"_32_"
CAMPO=FECNOAPTO,OCULTO,"�D-MM-Y.YY"
CAMPO=HORANOAPTO,OCULTO,"________"

CURSOR=CDAMESTATUS SELECT DABSTATUS DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='DVL';

CURSOR=CSELCAUSA SELECT CODCAUSA,DESCAUSA FROM VDDEVOLCAUSA
                  UNION
                 SELECT '','' FROM DUAL;


CURSOR=CSELOPEINS SELECT VDUSER.GETUSER CODOPEINS,VD.FECHASYS FECINS,VD.HORASYS HORAINS
                    FROM DUAL;
                    
CURSOR=CSELDESART BEGIN
                    SELECT DESART INTO :DESART FROM VDARTIC WHERE CODART=:CODART;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                      SELECT CODART,DESART INTO :CODART,:DESART FROM VDARTIC WHERE CODEAN LIKE '_'||:CODART;
                  END;@

CURSOR=CSELCODLOT SELECT CADUCI FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT;



CONTEXTUAL=FEJECUTAFORM("VDARTIC","S","CODART=:CODART")




