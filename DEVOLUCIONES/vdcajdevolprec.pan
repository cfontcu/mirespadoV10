Paso de cajas de devoluci�n a precintos
    C�digo      #L####### Cliente _20____________ _40_________________________________________
    Divisi�n:   _20__ _40__________________________________________________
    Dev.cliente ____________________  Importe #L,####.## Unidades @L,@@@ Bultos @L,@@ Cajas Cliente: @L@
    Estado      @L@@@ _40________________________________
    Inserci�n   _______________ �D-MM-Y.YY ________     Validaci�n    _______________ �D-MM-Y.YY ________
    Conf. Prot. _______________ �D-MM-Y.YY ________     Finalizaci�n: _______________ �D-MM-Y.YY ________
    Observ. _255____________________________________________ Modifica:_______________ �D-MM-Y.YY ________
|

TABLA=VDDEVOLCAB
NOINSERT


CAMPO=SEQDEVOL,NOUPDATE,TOOLTIP("C�digo de la devoluci�n"),TECLA=CR,FPULSATECLAS("F2","F6")
CAMPO=CODCLIENTE,UPPER,POSTCHANGE=FVALNOCERO("Debe introducir C�digo de cliente")
CAMPO=DESCLIENTE,UPPER,POSTCHANGE=FVALNOCERO("Debe introducir designaci�n de cliente")
CAMPO=CODDIV,NOUPDATE,POSTCHANGE=FEJECUTA("+CSELDIVIS","")
CAMPO=DESDIV,AUXILIAR,NOENTER
CAMPO=CODDEVCLI
CAMPO=PRECIODEV
CAMPO=NUMUNI,NOUPDATE
CAMPO=NUMBULTOS
CAMPO=CAJASCLIENTE,NOUPDATE
CAMPO=STATUS,NOUPDATE,POSTCHANGE=FDESIGNACION("CSELSTATUS","No existe estado")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODOPEINS,NOENTER
CAMPO=FECINS,NOENTER
CAMPO=HORAINS,NOENTER
CAMPO=CODOPEVALIDA,NOENTER
CAMPO=FECVALIDA,NOENTER
CAMPO=HORAVALIDA,NOENTER

CAMPO=CODOPEPROTO,NOENTER
CAMPO=FECPROTO,NOENTER
CAMPO=HORAPROTO,NOENTER
CAMPO=CODOPEFIN,NOENTER
CAMPO=FECFIN,NOENTER
CAMPO=HORAFIN,NOENTER
CAMPO=MENSAJE,AUXILIAR,OCULTO,"_100_"
CAMPO=OBSERV,REGPAG=4,INCLUDECSS="border-style:inset;border-width:2px;background-color:#FBE9C0",WPOSY=4
CAMPO=CODOPEMODIF,NOENTER
CAMPO=FECMODIF,NOENTER
CAMPO=HORAMODIF,NOENTER
#CAMPO=CODPRECINTOCITO,AUXILIAR,VIRTUAL,OCULTO
#CAMPO=CODPRECINTONORMAL,AUXILIAR,VIRTUAL,OCULTO

CURSOR=CSELDIVIS SELECT DESDIV FROM VDDEVOLDIVIS WHERE NVL(CODDIV,'-') = NVL(:CODDIV,'-');

CURSOR=CSELSTATUS SELECT TO_NUMBER(:STATUS) STATUS,DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='DVC';
                    

BOTON=SALIR,960,70,120,120,"Salir",vertis\vertissalir.png,27,"Salir de la pantalla" ,INCLUDECSS="border-style:outset;background-color:transparent"


