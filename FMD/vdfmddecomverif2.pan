##############################################################################
#  M�dulo  : VDLEERFMDROT1.PAN                                               #
#  Funci�n : Leer decomisiones de art�culos con FMD                          #
#                                                                            #
#  Autor : DFL                                                               #
#  Fecha : 16-07-2018                                                        #
#  Revisador por  :                                                          #
#  Fecha revisi�n :                                                          #
##############################################################################
#  Hist�rico de cambios
#  --------------------
#
##############################################################################
ART�CULOS PENDIENTES DE LEER FMD

 Art�culo                                             Lote           Cant. Servida Cant. Leidas Quedan   
 _40______________ _100______________________________ _40___________ #L########### #L########## #L#######  
|

SOLOQUERY
NOCOMMIT
NOINSERT
NOUPDATE
NODELETE
NOENTER
REGPAG=20

SELECT=SELECT BUL.CODART CODART,
                   ART.DESART DESART,  
                   BUL.CODLOT CODLOT,
                   DECODE(BUC.TIPOVOL,'PA',SUM(BUL.CANTPEDIDA),SUM(BUL.CANTSERVIDA)) CANTSERVIDA,
                   (SELECT COUNT(*) FROM VDNUMSERIESFMD FMD WHERE BUL.CODART = FMD.CODART AND  MOV.CODLOT = FMD.CODLOT AND BUL.CODBULTO = FMD.CODBULTO AND ACCION=VD.GETPROP('FMDACCIONVERIFICAR') AND RESULTADO IS NOT NULL) CANTLEIDA,
                   DECODE(BUC.TIPOVOL,'PA',SUM(BUL.CANTPEDIDA),SUM(BUL.CANTSERVIDA)) - (SELECT COUNT(*) FROM VDNUMSERIESFMD FMD WHERE BUL.CODART = FMD.CODART AND  MOV.CODLOT = FMD.CODLOT AND  BUL.CODBULTO = FMD.CODBULTO AND ACCION=VD.GETPROP('FMDACCIONVERIFICAR') AND RESULTADO IS NOT NULL) QUEDAN ,
                   SUM(DECODE(BUC.TIPOVOL,'PA',SUM(BUL.CANTPEDIDA),SUM(BUL.CANTSERVIDA)) - (SELECT COUNT(*) FROM VDNUMSERIESFMD FMD WHERE BUL.CODART = FMD.CODART AND  MOV.CODLOT = FMD.CODLOT AND BUL.CODBULTO = FMD.CODBULTO AND ACCION=VD.GETPROP('FMDACCIONVERIFICAR') AND RESULTADO IS NOT NULL)) OVER() QUEDANTOTAL ,
                   SUM((SELECT COUNT(*) FROM VDNUMSERIESFMD FMD WHERE BUL.CODART = FMD.CODART AND  MOV.CODLOT = FMD.CODLOT AND BUL.CODBULTO = FMD.CODBULTO AND ACCION=VD.GETPROP('FMDACCIONVERIFICAR') AND RESULTADO IS NOT NULL)) OVER() LEIDOSTOTAL
            FROM VDBULTOCAB BUC,VDBULTOLIN BUL
            INNER JOIN VDARTIC ART ON
              BUL.CODART=ART.CODART AND
              ART.SWTFMD = 'S'
            INNER JOIN VDMOVIM MOV ON
              BUL.CODMOV=MOV.CODMOV
            WHERE BUC.CODBULTO = :CODBULTO AND BUC.CODBULTO = BUL.CODBULTO
              HAVING  DECODE(BUC.TIPOVOL,'PA',SUM(BUL.CANTPEDIDA),SUM(BUL.CANTSERVIDA)) <> (SELECT COUNT(*) FROM VDNUMSERIESFMD FMD WHERE BUL.CODART = FMD.CODART AND  MOV.CODLOT = FMD.CODLOT AND BUL.CODBULTO = FMD.CODBULTO AND ACCION=VD.GETPROP('FMDACCIONVERIFICAR') AND RESULTADO IS NOT NULL)
            GROUP BY BUL.CODART,ART.DESART, BUL.CODLOT, BUL.CODBULTO,BUC.TIPOVOL,MOV.CODLOT;

			
CAMPO=CODBULTO,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CANTTOTAL,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODART,AUXILIAR,TITULO("ARTICULO")
CAMPO=DESART,AUXILIAR,TITULO("")
CAMPO=CODLOT,AUXILIAR,TITULO("LOTE")
CAMPO=CANTSERVIDA,AUXILIAR,TITULO("CANT.SERVIDA")
CAMPO=CANTLEIDA,AUXILIAR,TITULO("CANT.LEIDAS")
CAMPO=QUEDAN,AUXILIAR,TITULO("QUEDAN POR LEER")
CAMPO=QUEDANTOTAL,AUXILIAR,OCULTO,"#L#####"
CAMPO=LEIDOSTOTAL,AUXILIAR,OCULTO,"#L#####"

ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F5} Borrar pantalla {F9} Borrar registro
                                    {May-F10} Men� {Esc} Salir;
