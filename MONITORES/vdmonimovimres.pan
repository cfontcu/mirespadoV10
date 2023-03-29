# M�dulo   : VDMONIMOVIMRES.PAN
# Funci�n  : Monitor de movimientos. Resumen del movimiento
#
# Creaci�n : 04-08-2008
# Autor    : JMM
###########################################
# Hist�rico de cambios:
#
DETALLE DEL MOVIMIENTO
 Art�culo _40_____________ _100______________________________     Cantidad #15L###########    
                                                                                                                       
 Uni/emb #L15########## Emb. conte. @L@@@ Tipo emba __________   Bloqueos:    Origen __________  Destino __________ 

 Concepto _20_____ 
 Creacion _32___________ �D-MM-Y.YY ________ Ejecuci�n _32_________ �D-MM-Y.YY ________ Fin �D-MM-Y.YY _______
                                                                                                                       
|
TABLA=VDMOVIM

CAMPO=CODMOV,VIRTUAL,OCULTO
CAMPO=CODART,TOOLTIP("C�digo del art�culo"),POSTCHANGE=FDESIGNACION("CSELDESART","No existe art�culo"),
                CONTEXTUAL=FEJECUTAFORM("VDSELART","S","","","CODART=:CODART","Selecci�n de articulo","N") 
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designaci�n del art�culo")
CAMPO=CANTIDAD,TOOLTIP("Cantidad en unidades host"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=UNIEMB,TOOLTIP("Unidades por embalaje en unidades host"),CONVIERTE=FCONVIERTEARTFROMDB(":CODART");FCONVIERTEART2DB(":CODART")
CAMPO=EMBCONT,TOOLTIP("Embalajes por contenedor")
CAMPO=TIPOEMBA,TOOLTIP("Tipo de embalaje"),POSTCHANGE=FDESIGNACION("CSELTIPOEMBA","No existe el tipo de embalaje"),
                CONTEXTUAL=FEJECUTAFORM("VDTIPOEMBA","S","","","TIPOEMBA=:TIPOEMBA","Selecci�n de tipo de embalaje","S") 
CAMPO=BLOQUEOSORI,TOOLTIP("Bloqueo de la mercancia"),POSTCHANGE=FDESIGNACION("-CVERBLOQUEOORI",":V10ERROR")
CAMPO=BLOQUEOSDEST,TOOLTIP("Bloqueo de la mercancia"),POSTCHANGE=FDESIGNACION("-CVERBLOQUEODEST",":V10ERROR")
CAMPO=CODCONCE
CAMPO=CODOPEINS
CAMPO=FECINS
CAMPO=HORAINS
CAMPO=CODOPEEJEMOV
CAMPO=FECINIMOV
CAMPO=HORAINIMOV
CAMPO=FECFINMOV
CAMPO=HORAFINMOV

CURSOR=CSELDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELCODLOT SELECT :CODLOT FROM VDLOTES WHERE CODART=:CODART AND CODLOT=:CODLOT
                   UNION
                  SELECT '' CODLOT FROM DUAL WHERE :CODLOT IS NULL;

CURSOR=CSELTIPOEMBA SELECT :TIPOEMBA FROM VDTIPOEMBA WHERE TIPOEMBA=:TIPOEMBA
                   UNION
                  SELECT '' TIPOEMBA FROM DUAL WHERE :TIPOEMBA IS NULL;

CURSOR=CVERBLOQUEOORI SELECT VDART.VALIDABLOQUEO(:BLOQUEOSORI) V10ERROR FROM DUAL 
                       WHERE VDART.VALIDABLOQUEO(:BLOQUEOSORI) IS NOT NULL AND :BLOQUEOSORI IS NOT NULL;
                       
CURSOR=CVERBLOQUEODEST SELECT VDART.VALIDABLOQUEO(:BLOQUEOSDEST) V10ERROR FROM DUAL 
                        WHERE VDART.VALIDABLOQUEO(:BLOQUEOSDEST) IS NOT NULL AND :BLOQUEOSDEST IS NOT NULL;


