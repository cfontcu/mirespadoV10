###################################################################
#M�dulo: VDSERIEEXP.PAN
#Funcionalidad : Mantenimiento de series de expedici�n
#Autor: FPD      
#Fecha: 22-04-2008
###################################################################
# Hist�rico de cambios:
MANTENIMIENTO SERIES DE EXPEDICION
       Serie ��� BOLETA ��                                               
C�digo Prep.  A�o  C�digo Agencia                 P. Pri Estado             Desc 
@L@@@@ @L@@@@ @L@@ @L@@@@ _10____ _30____________ @@ @@  @L@@@@ _30________ _1000_____________ 

|

TABLA=VDSERIEEXP
ORDERBY=CODSERIEEXP DESC;

POSTQUERY=FEJECUTA("CSELAGENCIA","ERROR AL RECUPERAR LA DESCRIPCION DE LA AGENCIA")

WFRAME(61,-2,45,0,"Serie","")
WFRAME(106,-2,90,0,"Boleta","")


CAMPO=CODSERIEEXP,NOUPDATE,TOOLTIP("Clave �nica de la serie de expedici�n"),TITULO("C�digo"), WLONX=20
CAMPO=CODSERIEPREP,NOUPDATE,TOOLTIP("Clave �nica de la serie de preparaci�n"),TITULO("Prep.")
CAMPO=ANOBOLETA,NOENTER,TOOLTIP("A�o de expedici�n de la boleta de transporte"),TITULO("A�o")
CAMPO=CODBOLETA,NOENTER,TOOLTIP("C�digo de la boleta de transporte para la agencia"),TITULO("C�digo"), WLONX=20
CAMPO=CODAGE,NOENTER,TOOLTIP("C�digo de la agencia que recoge la serie"),CONTEXTUAL=FEJECUTAFORM("VDAGENCIA","N","CODAGE=:CODAGE","","","MANTENIMIENTO DE AGENCIAS","S"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia que recoge la serie")
CAMPO=PUERTO,TOOLTIP("N�mero de puerto del sorter por el que se desv�an las cajas de la serie"),TITULO("P.")
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de la serie de expedici�n. Inicialmente es heredada de la serie de preparaci�n."),TITULO("Pri"), WLONX=18
CAMPO=STATUS,NOUPDATE("IMPLANTADOR"),TOOLTIP("Estado en que se encuentra la serie /n :DESSTATUS"),POSTCHANGE=FDESIGNACION("CSELSTATUS","STATUS NO EXISTE"),TITULO("Estado"), WLONX=20
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TITULO("")
CAMPO=DESSERIE,TOOLTIP("Descripci�n de la serie"),TITULO("Descripci�n")
CAMPO=CODCOMEN,OCULTO,"@@@@@@@@@"

CURSOR=CSELSTATUS SELECT DESSTATUS 
                    FROM VDSTATUS 
                   WHERE TIPOSTATUS='SEX' AND STATUS=:STATUS; 
                   
CURSOR=CSELAGENCIA SELECT DESAGE 
                     FROM VDAGENCIA
                    WHERE CODAGE=:CODAGE;
                    



TECLA=SF8,FEJECUTA(FIMPRIME("INFORME","$(VDBOLETA)","CODBOLETA=:CODBOLETA;ANOBOLETA=:ANOBOLETA;FORMCOPIA='S';",""),":V10ERROR",FCOMMIT,"")


ONLINE= {May+F10} Datos de la serie de preparaci�n {May+F8} Impresion listado;
