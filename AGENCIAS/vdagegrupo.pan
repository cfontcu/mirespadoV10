###################################################################
#M�dulo: VDAGEGRUPO.PAN
###################################################################
# Hist�rico de cambios:
GRUPO DE AGENCIAS ASOCIADO
GRUPOAGE   CODDIV     CODCLIAGE            CODAGE               Ultima modif. 
_20_______ _20_______ _20_________________ _20_________________ _32_____ �D-MM-YY.Y ________  
|

PROTECT("ADMINISTRADOR")

TABLA=VDAGEGRUPODIVIS
WLONX=1100
REGPAG=10

PREINSERT=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.")
PREUPDATE=FEJECUTA("CMODIF","No puedo asignar fecha de modificaci�n.")

#CAMPOS
CAMPO=GRUPOAGE,VIRTUAL,NOUPDATE,TITULO("Grupo")
CAMPO=CODDIV,TITULO("Division")
CAMPO=CODCLIAG,TITULO("Cliente") 
CAMPO=CODAGE,TITULO("Agencia") 
CAMPO=CODOPeMODIF,TITULO("Ultima modificaci�n")
CAMPO=FECMODIF
CAMPO=HORAMODIF

#CURSORES
CURSOR=CMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF
                FROM DUAL;
  





