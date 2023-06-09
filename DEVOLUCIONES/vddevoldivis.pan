MANTENIMIENTO DE DIVISIONES DE VERTIS

  Seq:     @L@@
  
  Coddiv:  _20___  _40___________________________________________________
  
  Informe: _256________________________________________________________

  Correo:  _ ____________

  Rango Abonable:              Meses Margen de caducidad para Apto. @L
    Meses Ant.   @L  
    Meses Post.  @L 

  Ultima modificaci�n _32________ �D-MM-Y.YY  ________  
|

PROTECT("VSUPERVISOR")

TABLA=VDDEVOLDIVIS
ORDERBY = DECODE(CODDIV,NULL,0,1);
REGPAG=1
PREINSERT=FEJECUTA("+CDAMESEQ","","CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
CAMPO=SEQDIV,NOENTER
CAMPO=CODDIV
CAMPO=DESDIV
CAMPO=INFORMEDIV
CAMPO=ENVCORREO,CHECKBOX("N","S")
CAMPO=TIPOCORREO,COMBOX("CCOMBOXCORREO")
CAMPO=MESESPOSTAPTO,TOOLTIP("Meses posteriores de rango de caducidades para ver si es apto"),WLONX=6
CAMPO=MESESANTAB,TOOLTIP("Meses previos de rango de caducidades para ver si es abonable"),WLONX=6
CAMPO=MESESPOSTAB,TOOLTIP("Meses posteriores de rango de caducidades para ver si es abonable"),WLONX=6
CAMPO=CODCOMEN,OCULTO,"@L@@@@@@@@"
CAMPO=CODOPEMODIF,NOENTER,TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER
CAMPO=HORAMODIF,NOENTER,WLONX=20

CURSOR=CCOMBOXCORREO SELECT TIPOCORREO, DESTIPOCORREO FROM VDCORRTIPOS;

CURSOR=CDAMESEQ SELECT VDSEQDEVOLDIV.NEXTVAL SEQDIV, VDSECCOMEN.NEXTVAL CODCOMEN FROM DUAL;      

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;