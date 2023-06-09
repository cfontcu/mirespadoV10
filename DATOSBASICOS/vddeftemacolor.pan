# Módulo   : VDDEFTEMACOLOR.PAN
# Función  : Mantenimiento de definciones de colores por tema
#
# Creación : 05-11-2008
# Autor    : JMM
###########################################
# Histórico de cambios:
CONFIGURACION DE LA PALETA DE COLORES
                                                                        Tinta    Papel  
  1.  __100__________________________________________________________  @HL@@@   @HL@@@
  3.  __100__________________________________________________________  @HL@@@   @HL@@@
  2.  __100__________________________________________________________  @HL@@@   @HL@@@
  4.  __100__________________________________________________________  @HL@@@   @HL@@@
  
  7.  __100__________________________________________________________  @HL@@@   @HL@@@
  6.  __100__________________________________________________________  @HL@@@   @HL@@@
  
 11.  __100__________________________________________________________  @HL@@@   @HL@@@
 12.  __100__________________________________________________________  @HL@@@   @HL@@@
 10.  __100__________________________________________________________  @HL@@@   @HL@@@
 13.  __100__________________________________________________________  @HL@@@   @HL@@@
 
 14.  __100__________________________________________________________  @HL@@@   @HL@@@
 15.  __100__________________________________________________________  @HL@@@   @HL@@@
 16.  __100__________________________________________________________  @HL@@@   @HL@@@
 17.  __100__________________________________________________________  @HL@@@   @HL@@@
 
 18.  __100__________________________________________________________  @HL@@@   @HL@@@
 19.  __100__________________________________________________________  @HL@@@   @HL@@@
 20.  __100__________________________________________________________  @HL@@@   @HL@@@
 
  5.  __100__________________________________________________________  @HL@@@   @HL@@@
  8.  __100__________________________________________________________  @HL@@@   @HL@@@
  9.  __100__________________________________________________________  @HL@@@   @HL@@@
 
|

TABLA=VDDEFCOLOR
POSTQUERY=FEJECUTA("CCARGASINUSO","",
                   "+CCARGACAMPO1","ERROR EN CCARGACAMPO1",
                   "+CCARGACAMPO2","ERROR EN CCARGACAMPO2",
                   "+CCARGACAMPO3","ERROR EN CCARGACAMPO3",
                   "+CCARGACAMPO4","ERROR EN CCARGACAMPO4",
                   "+CCARGACAMPO5","ERROR EN CCARGACAMPO5",
                   "+CCARGACAMPO6","ERROR EN CCARGACAMPO6",
                   "+CCARGACAMPO7","ERROR EN CCARGACAMPO7",
                   "+CCARGACAMPO8","ERROR EN CCARGACAMPO8",
                   "+CCARGACAMPO9","ERROR EN CCARGACAMPO9",
                   "+CCARGACAMPO10","ERROR EN CCARGACAMPO10",
                   "+CCARGACAMPO11","ERROR EN CCARGACAMPO11",
                   "+CCARGACAMPO12","ERROR EN CCARGACAMPO12",
                   "+CCARGACAMPO13","ERROR EN CCARGACAMPO13",
                   "+CCARGACAMPO14","ERROR EN CCARGACAMPO14",
                   "+CCARGACAMPO15","ERROR EN CCARGACAMPO15",
                   "+CCARGACAMPO16","ERROR EN CCARGACAMPO16",
                   "+CCARGACAMPO17","ERROR EN CCARGACAMPO17",
                   "+CCARGACAMPO18","ERROR EN CCARGACAMPO18",
                   "+CCARGACAMPO19","ERROR EN CCARGACAMPO19",
                   "+CCARGACAMPO20","ERROR EN CCARGACAMPO20")




PREINSERT=FEJECUTA("CSELMODIF","ERROR INSERTANDO ULTIMA MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR ACTUALIZANDO ULTIMA MODIFICACION")

CAMPO=TEMA,NOENTER,VIRTUAL,OCULTO
CAMPO=NOMBRECOLOR,VIRTUAL,OCULTO,TOOLTIP("Nombre del conjunto de colores")

CAMPO=CAMPO1,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA1
CAMPO=PAPEL1

CAMPO=CAMPO3,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA3
CAMPO=PAPEL3

CAMPO=CAMPO2,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA2
CAMPO=PAPEL2

CAMPO=CAMPO4,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA4
CAMPO=PAPEL4

CAMPO=CAMPO7,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA7
CAMPO=PAPEL7

CAMPO=CAMPO6,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA6
CAMPO=PAPEL6

CAMPO=CAMPO11,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA11
CAMPO=PAPEL11

CAMPO=CAMPO12,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA12
CAMPO=PAPEL12

CAMPO=CAMPO10,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA10
CAMPO=PAPEL10

CAMPO=CAMPO13,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA13
CAMPO=PAPEL13

CAMPO=CAMPO14,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA14
CAMPO=PAPEL14

CAMPO=CAMPO15,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA15
CAMPO=PAPEL15

CAMPO=CAMPO16,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA16
CAMPO=PAPEL16

CAMPO=CAMPO17,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA17
CAMPO=PAPEL17

CAMPO=CAMPO18,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA18
CAMPO=PAPEL18

CAMPO=CAMPO19,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA19
CAMPO=PAPEL19

CAMPO=CAMPO20,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA20
CAMPO=PAPEL20

CAMPO=CAMPO5,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA5
CAMPO=PAPEL5

CAMPO=CAMPO8,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA8
CAMPO=PAPEL8

CAMPO=CAMPO9,NOENTER,AUXILIAR,TOOLTIP("Descripción del color de la paleta")
CAMPO=TINTA9
CAMPO=PAPEL9

CAMPO=CODOPEMODIF,NOENTER,OCULTO,"_32"
CAMPO=FECMODIF,NOENTER,OCULTO,"¿D-MM-Y.YY"
CAMPO=HORAMODIF,NOENTER,OCULTO,"________"
                                        
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR = CCARGASINUSO SELECT 'SIN USO' CAMPO1,'SIN USO' CAMPO2,'SIN USO' CAMPO3,'SIN USO' CAMPO4,'SIN USO' CAMPO5,
                             'SIN USO' CAMPO6,'SIN USO' CAMPO7,'SIN USO' CAMPO8,'SIN USO' CAMPO9,'SIN USO' CAMPO10,
                             'SIN USO' CAMPO11,'SIN USO' CAMPO12,'SIN USO' CAMPO13,'SIN USO' CAMPO14,'SIN USO' CAMPO15,
                             'SIN USO' CAMPO16,'SIN USO' CAMPO17,'SIN USO' CAMPO18,'SIN USO' CAMPO19,'SIN USO' CAMPO20 FROM DUAL;

CURSOR=CCARGACAMPO1 SELECT DESCCOLOR CAMPO1 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=1;
CURSOR=CCARGACAMPO2 SELECT DESCCOLOR CAMPO2 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=2;
CURSOR=CCARGACAMPO3 SELECT DESCCOLOR CAMPO3 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=3;
CURSOR=CCARGACAMPO4 SELECT DESCCOLOR CAMPO4 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=4;
CURSOR=CCARGACAMPO5 SELECT DESCCOLOR CAMPO5 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=5;
CURSOR=CCARGACAMPO6 SELECT DESCCOLOR CAMPO6 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=6;
CURSOR=CCARGACAMPO7 SELECT DESCCOLOR CAMPO7 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=7;
CURSOR=CCARGACAMPO8 SELECT DESCCOLOR CAMPO8 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=8;
CURSOR=CCARGACAMPO9 SELECT DESCCOLOR CAMPO9 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=9;
CURSOR=CCARGACAMPO10 SELECT DESCCOLOR CAMPO10 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=10;
CURSOR=CCARGACAMPO11 SELECT DESCCOLOR CAMPO11 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=11;
CURSOR=CCARGACAMPO12 SELECT DESCCOLOR CAMPO12 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=12;
CURSOR=CCARGACAMPO13 SELECT DESCCOLOR CAMPO13 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=13;
CURSOR=CCARGACAMPO14 SELECT DESCCOLOR CAMPO14 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=14;
CURSOR=CCARGACAMPO15 SELECT DESCCOLOR CAMPO15 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=15;
CURSOR=CCARGACAMPO16 SELECT DESCCOLOR CAMPO16 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=16;
CURSOR=CCARGACAMPO17 SELECT DESCCOLOR CAMPO17 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=17;
CURSOR=CCARGACAMPO18 SELECT DESCCOLOR CAMPO18 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=18;
CURSOR=CCARGACAMPO19 SELECT DESCCOLOR CAMPO19 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=19;
CURSOR=CCARGACAMPO20 SELECT DESCCOLOR CAMPO20 FROM VDDEFCOLORPALETA WHERE NOMBRECOLOR=:NOMBRECOLOR AND NUMCOLOR=20;


TECLA=SF7,FEJECUTA(FCARGATEMA(":TEMA"),"",%FFAILURE," SE VA A CARGAR PANTALLA DE DEMO",FEJECUTAFORM("VDDEFTEMA","S","","","","PANTALLA DE DEMO","S"),"")

