#*****************************************************************************************
#Modulo: VDORDENESPEND.PAN
#Funcionalidad : Listado de las órdenes de recepción pendientes de realizar
#Autor: Fermín
#Fecha: 08-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 ORDENES DE RECEPCIÓN PENDIENTES
 ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ORDENES pendientes ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË
 ³                                                                                      ³
 ³ Doc.Mat.   Pos.   Art.   Cant. Lote     O.T.           PosOT FPC         Centro      ³
 ³ _10_______ ______ _6____ @@@@@ _12_____ _____________  _____ __________  __________  ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ³                                                                                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                                                      |

AQUERY
TABLA=VDORDRECLIN
WHERE=STATUS=100 ORDER BY CODORDREC;

CAMPO=CLAVEEXT,NOENTER,TITULO("Doc.Mat."),TOOLTIP("Documento de material")
CAMPO=TIPOLOTE,NOENTER,TITULO("Pos"),TOOLTIP("Línea del documento de material")
CAMPO=CODART,NOENTER,TITULO("Art."),TOOLTIP("Código del articulo")
CAMPO=CANTIDAD,NOENTER,TITULO("Cant."),TOOLTIP("Cantidad a meter de este artículo")
CAMPO=MARCASTK,NOENTER,TITULO("Cod.Lote"),TOOLTIP("Lote del artículo")
CAMPO=CODORDREC,NOENTER,TITULO("O.T."),TOOLTIP("Código de la orden de transporte")
CAMPO=SECLINORD,NOENTER,TITULO("PosOT"),TOOLTIP("Línea de la orden de transporte")
CAMPO=CADUCI,NOENTER,POSTCHANGE=FEJECUTA("CDECORAFECHA","Error formateando el campo FPC"),TITULO("FPC"),TOOLTIP("Fecha preferente de consumo")
CAMPO=VDEXTRA,NOENTER,TITULO("Centro"),TOOLTIP("Centro asignado a esta entrada")  

TIMEOUT=QUERYAUTOM,200

CURSOR=CDECORAFECHA SELECT CASE
                             when to_date(orl.caduci,'yyyymmdd')<add_months(sysdate,120) then substr(orl.caduci,7,2)||'-'||substr(orl.caduci,5,2)||'-'||substr(orl.caduci,0,4)
							 when to_date(orl.caduci,'yyyymmdd')>add_months(sysdate,120) then 'SIN F.P.C.'
						   END CADUCI
				    FROM VDORDRECLIN orl
					WHERE CLAVEEXT=:CLAVEEXT
                      AND TIPOLOTE=:TIPOLOTE
                      AND CODART=:CODART
                      AND CANTIDAD=:CANTIDAD
                      AND MARCASTK=:MARCASTK
                      AND CODORDREC=:CODORDREC
                      AND SECLINORD=:SECLINORD
                      AND VDEXTRA=:VDEXTRA;					  


