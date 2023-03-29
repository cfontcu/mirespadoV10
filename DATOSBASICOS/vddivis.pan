###################################################################
#M�dulo: VDDIVIS.PAN
#Funcionalidad : Mantenimiento de divisiones
#Autor: FPD      
#Fecha: 26-06-2008
###################################################################
# Hist�rico de cambios:
TABLA DE DIVISIONES

  Divisi�n
  _20_ _40________________________________________
  C�digo interno   Abreviatura  
  ____             _10________  
  NIF              C�digo EAN
  _15_____________ _______
  
  Sufijo Documentos _____
  
  Contacto: _40____________________________
  
  Direcci�n    
  _40______________________________________
  _40______________________________________
  _40______________________________________
  _40______________________________________
  Poblaci�n                         
  _40______________________________________
  Pa�s 
  _____ __________________________________
  Provincia                         D.P.   
  ______ _40_______________________ _10________
  
  Tel�fono1     Fax1          
  _12__________ _12__________ 
  Tel�fono2     Fax2        
  _12__________ _12__________ 

  e-mail                        
  _40______________________________________
  EDI
  _40______________________________________

  Buz�n entrada interfases
  _256____________________________________

  Buz�n salida interfases
  _256____________________________________


  Ultima Modificaci�n:
  _32__________ �D-MM-Y.YY _8________
 
                                                 |
TABLA=VDDIVIS


PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")




CAMPO=CODEMP,OCULTO,"_3_"

CAMPO=CODDIV,NOUPDATE,TOOLTIP("C�digo de la division"),POSTCHANGE=FVALNOCERO("EL C�digo DE DIVISION\nNO PUEDE SER NULO")
CAMPO=DESDIV,TOOLTIP("Nombre completo de la division")
CAMPO=CODDIVEMP,TOOLTIP("C�digo empresa-division"),POSTCHANGE=FVALNOCERO("EL C�digo DIVISION-EMPRESA\nNO PUEDE SER NULO")
CAMPO=DABDIV,TOOLTIP("Abreviatura de la division")
CAMPO=NIF,TOOLTIP("NIF de la division")
CAMPO=CODEANEMP,TOOLTIP("C�digo EAN de la empresa.\nDebe contener el C�digo de pa�s.\nEn Espa�a es 84")
CAMPO=SUFIJODOC,TOOLTIP("Sufijo a a�adir a los nombres documentos de esta divisi�n")
CAMPO=CONTACTO,TOOLTIP("Persona de contacto en la divisi�n")
CAMPO=DIRECCION1,TOOLTIP("Direcci�n de la division")
CAMPO=DIRECCION2,TOOLTIP("Direcci�n de la division")
CAMPO=DIRECCION3,TOOLTIP("Direcci�n de la division")
CAMPO=DIRECCION4,TOOLTIP("Direcci�n de la division")
CAMPO=POBLACION,TOOLTIP("Poblaci�n de la division")
CAMPO=CODPAIS,TOOLTIP("C�digo del pa�s de la division"),POSTCHANGE=FDESIGNACION("CSELDESPAIS","No existe pa�s"),
                CONTEXTUAL=FEJECUTAFORM("VDPAIS","N","","","CODPAIS=:CODPAIS","Selecci�n de pais","S")
CAMPO=DESPAIS,AUXILIAR,NOENTER,TOOLTIP("Nombre del pais de la divisi�n")
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de la division"),POSTCHANGE=FDESIGNACION("CSELDESPROV","No existe la provincia"),
                CONTEXTUAL=FEJECUTAFORM("VDSELPROVI","N","","CODPAIS=:CODPAIS","CODPROV=:CODPROV","Selecci�n de provincia","S")
CAMPO=DESPROV,AUXILIAR,NOENTER,TOOLTIP("Nombre de la provincia de la division")
CAMPO=DP,TOOLTIP("Distrito postal de la division")
CAMPO=TELEFONO1,TOOLTIP("Tel�fono1 de la division")
CAMPO=FAX1,TOOLTIP("Fax 1 de la division")
CAMPO=TELEFONO2,TOOLTIP("Tel�fono 2 de la division")
CAMPO=FAX2,TOOLTIP("Fax 2 de la division")
CAMPO=EMAIL,TOOLTIP("E-Mail de la division")
CAMPO=EDI,TOOLTIP("EDI de la division")
CAMPO=BUZONIN, TOOLTIP("Directorio de entrada de los interfases de la division")
CAMPO=BUZONOUT, TOOLTIP("Directorio de salida de los interfases de la division")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha en que se modificaron los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora en que se modificaron a los datos del registro")




CURSOR=CSELDESPROV SELECT DESPROV FROM VDPROVI WHERE CODPROV=:CODPROV AND CODPAIS=:CODPAIS;
CURSOR=CSELDESPAIS SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:CODPAIS;
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;


#TECLA=SF7,FIMPRIME("VDARTIC.REP","CODDIV=:CODDIV","0","C:\prueba.PDF","1")

