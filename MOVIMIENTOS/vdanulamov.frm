# M�dulo   : VDEJECUTAMOV.FRM
# Funci�n  : Lista de ejecuci�n manual de movimientos
#
# Creaci�n : 25-04-2008
# Autor    : RFD
###########################################
# Hist�rico de cambios:
BEGINBLOQUE=VDANULAMOV.PAN
    CAMPO=FLUJOPED,AUXILIAR,OCULTO,"_255_"
    PREREGISTRO=PRESEHIJO
    PREQUERY=FEJECUTA("CSELFLUJOSPED","ERROR OBTENIENDO FLUJOS PARA PEDIDOS")
    WHERE=STATUS BETWEEN -VDST.FMOVPDTERUTA AND VDST.FMOVENUBIINTER 
                AND  VD.CONTIENE(NVL(:FLUJOPED,0),TAREA,'#') <=0  ;

    ORDERBY=CODUBIORI,CODMATORI,CODUBIDEST;
    
    CURSOR=CSELFLUJOSPED SELECT VD.GETPROP('FLUJOSPEDIDO') FLUJOPED FROM DUAL;
    REGPAG=30
    POSX=1
    POSY=1
ENDBLOQUE

