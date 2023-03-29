#*****************************************************************
#M�dulo: VDINVENERRONEOS.PAN
#Funcionalidad : 
#Autor: ICC      
#Fecha: 28-01-2010
#*****************************************************************
#* Hist�rico de cambios
#* ====================
INVENTARIOS QUE INCUMPLEN LAS CONDICIONES PARA SER VALIDOS
                                                              ����������������������� Stock actual �������������������������đ  
Inventario                     Ubicaci�n    Matr�cula          Art�culo                                  Lote        Cantidad 
######## _40__________________ _20_________ _18_______________ _40_____________ _100____________________ _40________ ######### 
                                                                                                                                |

SELECT=SELECT DISTINCT INVO.CODINVEN, INVO.CODUBI, INVO.CODMAT
         FROM VDINVENCONTEO INVO, VDINVENLIN INVL
        WHERE INVL.CODINVEN = INVO.CODINVEN
          AND INVL.CODUBI   = INVO.CODUBI
          AND NVL(INVL.CODMAT, INVO.CODMAT) = INVO.CODMAT
          AND INVL.STATUS != VDST.FINLVALIDADO
          AND INVO.STATUS IN (VDST.FINONOOK, VDST.FINONOKFIN)
          AND (INVO.CODINVEN, INVO.CODUBI, INVO.CODMAT) NOT IN (SELECT CODINVEN,CODUBI, CODMAT
                                                                  FROM VDINVENCONTEO
                                                                 WHERE STATUS IN (VDST.FINOFINALIZADO,VDST.FINOVALIDADO));
ORDERBY=1,2,3;

SOLOQUERY
AQUERY

POSX=1
POSY=1
REGPAG=25

WFRAME(418,-2,426,0,"Stock actual","text-aling:center")

CAMPO=CODINVEN,TOOLTIP("C�digo de inventario"), POSTCHANGE=FDESIGNACION("CSELDESINVEN","",
                                                                        "+CSELSTOCK", ""),TITULO("Inventario")
CAMPO=DESINVEN,AUXILIAR
CAMPO=CODUBI,TOOLTIP("C�digo de ubicaci�n a inventariar"),TITULO("Ubicaci�n")
CAMPO=CODMAT,TOOLTIP("C�digo de matr�cula a inventariar"),TITULO("Matr�cula")
CAMPO=CODART,AUXILIAR, POSTCHANGE=FDESIGNACION("+CSELDESART",""),TITULO("Art�culo")
CAMPO=DESART,AUXILIAR
CAMPO=CODLOT,AUXILIAR,TITULO("Lote")
CAMPO=CANTIDAD,AUXILIAR,TITULO("Cantidad")

CURSOR=CSELDESINVEN SELECT DESINVEN
                      FROM VDINVENCAB
                     WHERE CODINVEN = :CODINVEN;
                     
CURSOR=CSELDESART SELECT DESART
                    FROM VDARTIC
                   WHERE CODART = :CODART;
                    
CURSOR=CSELSTOCK SELECT CODART,CODLOT, SUM(CANTIDAD) CANTIDAD
                   FROM VDSTOCK
                  WHERE CODMAT = :CODMAT
                  GROUP BY CODART,CODLOT;
                    


ONLINE= ONLINE= {F1} Ayuda    {F2} Consulta    {Esc} Cerrar Pantalla    {F5} Borrar Pantalla    ;
