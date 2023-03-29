#M�dulo: VDRESOLBULEMBACNT.PAN
#Funci�n: Resolucion de bultos de caja completa y contenedor
#
#Autor: JMM
#Fecha creaci�n: 21-07-2008
#
RESOLUCION DE BULTOS DE CAJA COMPLETA Y CONTENEDOR
 Bulto                  Tipo Articulo        Unidades       Agencia         Div  A�o  Pedido          Ver  Serie  Pri. Resol.
 _20___________________  _   _40____________ #L#,###,###.## _30____________ _20_ @L@@ _20____________ @L@  @L@@@@ @@@@   _   
|

SOLOQUERY
PQUERY
SELECT=SELECT DISTINCT BUC.CODBULTO,BUC.TIPOBULTO,VDART.VD2HOST(BUL.CANTPEDIDA,BUL.CODART) CANTPEDIDA,BUL.CODART,BUC.CODPED,BUC.SEQPED,BUC.ANOPED,BUC.CODDIV,
              SPR.CODSERIEPREP,SPR.PRIORIDAD,PEC.CODAGE,'N' RESOLVER
         FROM VDBULTOCAB BUC,VDPEDIDOCAB PEC,VDSERIEPREP SPR,VDBULTOLIN BUL,VDMOVIM MOV,VDUBICA UBI  
        WHERE BUC.STATUS IN (VDST.FBUCBULABAN,VDST.FBUCCC) AND BUC.TIPOBULTO IN ('E','C') AND
              PEC.CODPED=BUC.CODPED AND PEC.SEQPED=BUC.SEQPED AND PEC.CODDIV=BUC.CODDIV AND PEC.ANOPED=BUC.ANOPED AND 
              SPR.CODSERIEPREP=PEC.CODSERIEPREP AND
              BUL.CODBULTO=BUC.CODBULTO AND MOV.CODMOV=BUL.CODMOV AND 
              MOV.STATUS+0=VDST.FMOVPDTERECOGE AND MOV.TAREA IN ('PEDEMBA','PEDCONTE')
              AND MOV.CODUBIORI=UBI.CODUBI AND UBI.CODAREA IN ('HR','RP','DP');

ORDERBY=BUL.CODART,SPR.PRIORIDAD,SPR.CODSERIEPREP,BUC.CODPED;

REGPAG=50

#POSTQUERY=FEJECUTA(FIF("CSELTODOS",FMODIFICA,FSUCCESS),"")

PREUPDATE=FEJECUTA("@CCHECK","",
                   FRESUELVEBULTO("ACTSTKORIGEN","ACTSTKDESTINO",":CODBULTO"),"ERROR RESOLVIENDO BULTO :CODBULTO\n:V10ERROR",
                   FCOMMIT,"",
                   "CSELETIQ","ERROR OBTENIENDO DATOS DE ETIQUETA",
                   "CUPDDATOSBULTO","ERROR ACTUALIZANDO DATOS DE IMPRESION DE BULTO :CODBULTO",
                   "CUPDVERIFICACION","ERROR AL CAMBIAR ESTADO DE BULTO :CODBULTO A VERIFICACION",
#                   FIMPRIMEBULTO("INFORME",":CODBULTO","PICKINGLIST.RPT","PCODBULTO=:CODBULTO",""),"ERROR IMPRIMIENDO LISTADO DE BULTO :CODBULTO\n:V10ERROR",
                   FIMPRIMEBULTO("ETIQ",":CODBULTO",":FICETIQUETA;:NOMBREVSQ;:NOMBRECURSOR","CODBULTO=:CODBULTO;ESCOPIA=:ESCOPIA",""),"ERROR AL IMPRIMIR ETIQUETA\n:V10ERROR",
                   FCOMMIT,"")

                   
POSTCOMMIT=FEJECUTA(FPULSATECLAS("CF2","F2"),"ERROR EN PULSACION DE TECLAS")


CAMPO=CODBULTO,AUXILIAR,NOENTER,TITULO("Bulto")
CAMPO=TIPOBULTO,AUXILIAR,NOENTER,TITULO("Tipo")
CAMPO=CODART,AUXILIAR,NOENTER,POSTCHANGE=FEJECUTA("+CSELDESART",""),TOOLTIP(":DESART"),TITULO("Art�culos")
CAMPO=DESART,AUXILIAR,OCULTO,"_40_"
CAMPO=CANTPEDIDA,NOENTER,TOOLTIP("Cantidad pedida "),TITULO("Unidades")
CAMPO=CODAGE,OCULTO,"_10_",POSTCHANGE=FEJECUTA("CSELDESAGE","ERROR OBTENIENDO DATOS DE LA AGENCIA"),TITULO("Agencia")
CAMPO=DESAGE,AUXILIAR,NOENTER
CAMPO=CODDIV,AUXILIAR,NOENTER,TITULO("Div")
CAMPO=ANOPED,AUXILIAR,NOENTER,TITULO("A�o")
CAMPO=CODPED,AUXILIAR,NOENTER,TITULO("Pedido")
CAMPO=SEQPED,AUXILIAR,NOENTER,TITULO("Ver")
CAMPO=CODSERIEPREP,AUXILIAR,NOENTER,TITULO("Serie")
CAMPO=PRIORIDAD,AUXILIAR,NOENTER,TITULO("Pri."),WLONX=-16
CAMPO=RESOLVER,AUXILIAR,UPPER,POSTCHANGE=FENRANGO("S,N","Debe introducir S(i) o N(o)"),TITULO("Resol."),WLONX=26

CAMPO=ULTIMOBULTO,AUXILIAR,OCULTO,"_"
CAMPO=ANULAR,AUXILIAR,OCULTO,"_"
CAMPO=ESCOPIA,AUXILIAR,OCULTO,"_10_"
CAMPO=FICETIQUETA,AUXILIAR,OCULTO,"_30_"
CAMPO=NOMBRECURSOR,AUXILIAR,OCULTO,"_20______________"
CAMPO=NOMBREVSQ,AUXILIAR,OCULTO,"_20______________"
CAMPO=TIPOETIQUETA,AUXILIAR,OCULTO,"_10________"
CAMPO=CODMOV,AUXILIAR,OCULTO,"@L@@@@@@@"
CAMPO=CODOPE,AUXILIAR,OCULTO,"_32_"
CAMPO=FICETIQECI,AUXILIAR,OCULTO,"_30_"
CAMPO=SWTETIQECI,AUXILIAR,OCULTO,"_"

CURSOR=CSELTODOS SELECT :RESOLVER FROM DUAL WHERE :RESOLVER='S';

CURSOR=CSELECI SELECT :SWTETIQECI FROM VDPEDIDOCAB WHERE ARKOCHIM.CLIENTEECI(:CODPED,:CODDIV,:ANOPED,:SEQPED)=1 AND CODDIV=:CODDIV AND ANOPED=:ANOPED AND CODPED=:CODPED AND SEQPED=:SEQPED;

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART = :CODART;

CURSOR=CSELDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE;

CURSOR=CCHECK SELECT :RESOLVER FROM VDBULTOCAB
               WHERE :RESOLVER='S' AND CODBULTO=:CODBULTO AND
                     STATUS IN (VDST.FBUCBULABAN,VDST.FBUCCC)
                 FOR UPDATE NOWAIT;

CURSOR=CSELETIQ SELECT 'CSELBULTO' NOMBRECURSOR,'VDETIQUETAS.VSQ' NOMBREVSQ, 'VDETIQBU.GEN' FICETIQUETA,'N' ESCOPIA   
                  FROM DUAL;

CURSOR=CUPDDATOSBULTO UPDATE VDBULTOCAB SET CODOPEIMPRIME = VDUSER.GETUSER,
                                            FECIMPRIME = VD.FECHASYS, HORAIMPRIME = VD.HORASYS
                       WHERE CODBULTO=:CODBULTO;

CURSOR=CSELRESOLVER SELECT :RESOLVER FROM DUAL WHERE :RESOLVER='S';
                       
CURSOR=CSELULTIMO SELECT VDBULTO.DAMEULTBULTO(:CODBULTO) ULTIMOBULTO, SWTANULAR ANULAR
                    FROM VDBULTOCAB 
                   WHERE CODBULTO = :CODBULTO;

CURSOR=CHAYULTIMO SELECT :ULTIMOBULTO
                    FROM DUAL
                   WHERE :ULTIMOBULTO='S' OR :ANULAR = 'S';

CURSOR=CUPDVERIFICACION UPDATE VDBULTOCAB SET STATUS=VDST.FBUCAVERIF
                         WHERE CODBULTO=:CODBULTO;

CURSOR=CUPDVERIFICACION2 UPDATE VDBULTOCAB SET SWTLLEVAALB='S'
                         WHERE CODBULTO=:CODBULTO AND :ULTIMOBULTO='S';

CURSOR=CUPDENPUERTO UPDATE VDBULTOCAB SET STATUS=VDST.FBUCENEXPED
                      WHERE CODBULTO=:CODBULTO;





