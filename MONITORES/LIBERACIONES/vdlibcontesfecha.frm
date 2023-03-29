CAMPO=POSICION,AUXILIAR,OCULTO,"#L#"
CAMPO=VALORPDTECALIDAD,AUXILIAR,OCULTO,"#L#"
CAMPO=VALORLIBERADO,AUXILIAR,OCULTO,"#L#"
CAMPO=VALORRECHAZADO,AUXILIAR,OCULTO,"#L#"
BEGINBLOQUE=VDLIBFECHAS.PAN
  TECLA=F4,PRESEHIJO
  CAMPO=POSICION,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORPDTECALIDAD,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORLIBERADO,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORRECHAZADO,AUXILIAR,VIRTUAL,OCULTO
  TITULO=CONSULTA DE CAMBIOS DE CALIFICACION DE CONTENEDORES POR FECHA
  CURSOR=CSELBLOQUEOS SELECT 2 POSICION,'2' VALORPDTECALIDAD,'0' VALORLIBERADO,'1' VALORRECHAZADO FROM DUAL;
  PREBLOQUE=FEJECUTA("CSELBLOQUEOS","")
ENDBLOQUE
BEGINBLOQUE=VDLISTAMOVBLOQ.PAN
  PREREGISTRO=PRESEHIJO
  PADRE=VDLIBFECHAS.PAN
  CAMPO=POSICION,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORPDTECALIDAD,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORLIBERADO,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=VALORRECHAZADO,AUXILIAR,VIRTUAL,OCULTO  
  CAMPO=DESDE,VIRTUAL,AUXILIAR,OCULTO
  CAMPO=HASTA,VIRTUAL,AUXILIAR,OCULTO
  CAMPO=MICODART,VIRTUAL("CODART"),AUXILIAR,OCULTO
  CAMPO=MICODLOT,VIRTUAL("CODLOT"),AUXILIAR,OCULTO
  
  WHERE= FECINS BETWEEN :DESDE AND :HASTA AND 
             SUBSTR(BLOQUEOSORI,:POSICION,1)!=SUBSTR(BLOQUEOSDEST,:POSICION,1) AND
             NVL(:MICODART,CODART)=CODART AND  NVL(:MICODLOT,CODLOT)=CODLOT;
    ORDERBY=FECINS DESC,HORAINS DESC;
  POSY=14
  REGPAG=34
ENDBLOQUE    
 
