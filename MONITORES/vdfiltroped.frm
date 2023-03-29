# MOdulo   : VDFILTROPED.FRM
# Función  : Filtro aplicable al monitor de pedidos
#
# Creación : 08-08-2008
# Autor    : JMM
###########################################
# HistOrico de cambios:
#
CAMPO=RANALM,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANALMAUX,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANDIV,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANDIVAUX,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANAGE,AUXILIAR,OCULTO,"_1024_"
CAMPO=RANAGEAUX,AUXILIAR,OCULTO,"_1024_"
BEGINBLOQUE=VDFILTROALMA.PAN
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALMAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIVAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGEAUX,AUXILIAR,VIRTUAL,OCULTO
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=10
  POSTQUERY=FEJECUTA("+CRELLENASEL","")
  PRECOMMIT=FEJECUTA("+CCOPIARAN","")
  CURSOR=CRELLENASEL SELECT DECODE(VD.CONTIENECAD(:RANALMAUX,:CODALM),1,'S',NULL) SEL FROM DUAL WHERE :RANALMAUX IS NOT NULL;
  CURSOR=CCOPIARAN SELECT :RANALM RANALMAUX FROM DUAL;  
  CURSOR=CBORRAFILTRO SELECT NULL RANALM, NULL RANALMAUX FROM DUAL;
  TECLA=F9,FEJECUTA("+CBORRAFILTRO","",+FPULSATECLAS("F3","F2"),"")
  TITULO=SELECCION DE ALMACEN ORIGEN
  ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F9} Borrar Filtro {F10} Volver a pantalla anterior;
ENDBLOQUE
BEGINBLOQUE=VDFILTRODIV.PAN
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALMAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIVAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGEAUX,AUXILIAR,VIRTUAL,OCULTO
  POSX=40
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=10
  POSTQUERY=FEJECUTA("+CRELLENASEL","")
  PRECOMMIT=FEJECUTA("+CCOPIARAN","")
  CURSOR=CRELLENASEL SELECT DECODE(VD.CONTIENECAD(:RANDIVAUX,:CODDIV),1,'S',NULL) SEL FROM DUAL WHERE :RANDIVAUX IS NOT NULL;
  CURSOR=CCOPIARAN SELECT :RANDIV RANDIVAUX FROM DUAL;
  CURSOR=CBORRAFILTRO SELECT NULL RANDIV, NULL RANDIVAUX FROM DUAL;
  TECLA=F9,FEJECUTA("+CBORRAFILTRO","",+FPULSATECLAS("F3","F2"),"")
  ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F9} Borrar Filtro {F10} Volver a pantalla anterior;
ENDBLOQUE
BEGINBLOQUE=VDFILTROAGE.PAN
  CAMPO=RANALM,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANALMAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIV,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANDIVAUX,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGE,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=RANAGEAUX,AUXILIAR,VIRTUAL,OCULTO
  POSX=80
  NOINSERT
  NOUPDATE
  NODELETE
  NOCOMMIT
  REGPAG=10
  POSTQUERY=FEJECUTA("+CRELLENASEL","")
  PRECOMMIT=FEJECUTA("+CCOPIARAN","")
  CURSOR=CRELLENASEL SELECT DECODE(VD.CONTIENECAD(:RANAGEAUX,:CODAGE),1,'S',NULL) SEL FROM DUAL WHERE :RANAGEAUX IS NOT NULL;
  CURSOR=CCOPIARAN SELECT :RANAGE RANAGEAUX FROM DUAL;
  CURSOR=CBORRAFILTRO SELECT NULL RANAGE, NULL RANAGEAUX FROM DUAL;
  TECLA=F9,FEJECUTA("+CBORRAFILTRO","",+FPULSATECLAS("F3","F2"),"")
  ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F9} Borrar Filtro {F10} Volver a pantalla anterior;
ENDBLOQUE
