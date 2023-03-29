# M�dulo   : VDALMA.PAN
# Funci�n  : Mantenimiento de almacenes
#
# Creaci�n : 01-10-2007
# Autor    : EAA
###########################################
# Hist�rico de cambios:
MANTENIMIENTO DE ALMACENES
 Cod. Alm.  ____ Designaci�n _40_______________________________ Contacto _40___________________________
 Direccion: _40______________________________________ _40______________________________________________
            _40______________________________________ _40______________________________________________
 Poblaci�n  _40______________________________________
 Pais       _____  _30_______________________________
 Provincia  _5_  _40_________________________      DP _10________
 Tel�fono1  _12_________ Fax1 _12_________ Tel�fono 2 _12_________ Fax 2 _12_________
 e-mail     _40______________________________________ EDI _40______________________________________
 
 Ultima modificaci�n _32________ �D-MM-Y.YY  ________
|

TABLA=VDALMA
ORDERBY=CODALM;
PREINSERT=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")




CAMPO=CODALM,NOUPDATE,TOOLTIP("C�digo del almac�n")
CAMPO=DESALM,TOOLTIP("Designaci�n del almac�n")
CAMPO=CONTACTO,TOOLTIP("Persona de contacto en el almac�n")
CAMPO=DIRECCION1,MIXED,TOOLTIP("Direcci�n del almac�n")
CAMPO=DIRECCION2,MIXED,TOOLTIP("Direcci�n del almac�n")
CAMPO=DIRECCION3,MIXED,TOOLTIP("Direcci�n del almac�n")
CAMPO=DIRECCION4,MIXED,TOOLTIP("Direcci�n del almac�n")
CAMPO=POBLACION,MIXED,TOOLTIP("Poblaci�n del almac�n")
CAMPO=CODPAIS,TOOLTIP("C�digo del pa�s del almac�n\nMay-F10   Ayuda contextual"),POSTCHANGE=FDESIGNACION("CSELDESPAIS","No existe pa�s"),
                CONTEXTUAL=FEJECUTAFORM("VDPAIS","N","","","CODPAIS=:CODPAIS","Selecci�n de pais","S"),
                COMBOX("CLISTAPAIS")
CAMPO=DESPAIS,AUXILIAR,NOENTER,TOOLTIP("Nombre del del almac�n")
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia del almac�n\nMay-F10   Ayuda contextual"),POSTCHANGE=FDESIGNACION("CSELDESPROV","No existe provincia"),
                CONTEXTUAL=FEJECUTAFORM("VDSELPROVI","N","","CODPAIS=:CODPAIS","CODPROV=:CODPROV","Selecci�n de provincia","S"),
                COMBOX("CLISTAPROV"),WLONX=8,COMBOXREGPAG=15
CAMPO=DESPROV,AUXILIAR,NOENTER,TOOLTIP("Nombre de la provincia del almac�n")
CAMPO=DP,TOOLTIP("Distrito postal del almac�n")
CAMPO=TELEFONO1,TOOLTIP("Tel�fono del almac�n")
CAMPO=TELEFONO2,TOOLTIP("Tel�fono del almac�n")
CAMPO=FAX1,TOOLTIP("Fax del almac�n")
CAMPO=FAX2,TOOLTIP("Fax del almac�n")
CAMPO=EMAIL,TOOLTIP("Direcci�n de correo electr�nico del almac�n")
CAMPO=EDI,TOOLTIP("Direcci�n EDI del almac�n")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")

CURSOR=CLISTAPAIS SELECT CODPAIS, DESPAIS FROM VDPAIS;

CURSOR=CLISTAPROV SELECT CODPROV, DESPROV,CODPAIS FROM VDPROVI WHERE CODPAIS=:CODPAIS;

CURSOR=CSELDESPROV SELECT DESPROV FROM VDPROVI WHERE CODPAIS=:CODPAIS AND CODPROV=:CODPROV;
CURSOR=CSELDESPAIS SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:CODPAIS;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


