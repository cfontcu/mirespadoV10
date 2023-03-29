Monitor de zonas
Z. Operario Bultos Lineas Unid.
@L ________ @L,@@@ @L,@@@ @L,@@@        
|
SOLOQUERY

SELECT=          SELECT CODZONA,SUM(DECODE(TIPOBULTO,'U',1,0)) BULUNI,SUM(DECODE(TIPOBULTO,'U',LINEAS,0)) LINUNI,SUM(DECODE(TIPOBULTO,'U',UNIDADES,0)) UNIUNI,
              DECODE(MAX(CODOPEPREPARA),MIN(CODOPEPREPARA),MAX(CODOPEPREPARA),'VARIOS') CODOPE
 FROM
  (SELECT BUC.TIPOBULTO,BUC.CODBULTO,BUL.CODOPEPREPARA,BUL.STATUS,UBI.CODZONA,
          COUNT(*) LINEAS,SUM(CANTPEDIDA) UNIDADES
   FROM VDPEDIDOCAB PEC,VDSERIEPREP SEP,VDBULTOCAB BUC,VDBULTOLIN BUL,VDMOVIM MOV,VDUBICA UBI
   WHERE PEC.CODSERIEPREP=SEP.CODSERIEPREP AND 
         PEC.CODPED=BUC.CODPED AND PEC.CODDIV=BUC.CODDIV AND PEC.ANOPED=BUC.ANOPED AND PEC.SEQPED=BUC.SEQPED AND
         BUC.CODBULTO=BUL.CODBULTO AND SEP.CODSERIEPREP=:CODSERIEPREP
         AND MOV.CODMOV=BUL.CODMOV AND MOV.CODUBIORI=UBI.CODUBI
   GROUP BY BUC.TIPOBULTO,BUC.CODBULTO,BUL.CODOPEPREPARA,BUL.STATUS,UBI.CODZONA)
   GROUP BY CODZONA;
   
CAMPO=CODSERIEPREP,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODZONA,TITULO("Z."),WLONX=8
CAMPO=CODOPE,TITULO("Operario"),WLONX=20
CAMPO=BULUNI,TITULO("Bultos"),WLONX=15
CAMPO=LINUNI,TITULO("L�neas"),WLONX=15
CAMPO=UNIUNI,TITULO("Unid."),WLONX=15