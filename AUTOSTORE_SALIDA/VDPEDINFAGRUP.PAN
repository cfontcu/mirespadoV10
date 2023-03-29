#*****************************************************************************************
#Modulo: VDPEDINFTAREA.PAN
#Funcionalidad : Información de detalle de l tarea seleccionada
#Autor: Fermín
#Fecha: 23-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INFORMACIÓN TAREA
 
 ÏÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ DETALLE ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄË
 ³                                                                                                                              ³
 ³ Agrupación              Destino             T.tarea      Urg.         Ord.Trans.       Artículo   Lote     Centro   Cantidad ³
 ³ ____________________    _________________   __________   __________   ______________   ________   ______   ______   ######## ³
 ³                                                                                                                              ³
 ³                                                                                                                              ³
 ³                                                                                                                              ³
 ³                                                                                                                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 |

TABLA=MET_BULTOLIN

CAMPO=CODBULTO,NOENTER,VIRTUAL,TITULO("Agrpación"),TOOLTIP("Código de la agrupación"),WLONX=12
CAMPO=CODCLIENTE,NOENTER,TITULO("Destino"),TOOLTIP("Destinatario del bulto")
CAMPO=TIPOPEDIDO,NOENTER,TITULO("T.tarea"),TOOLTIP("Tipo de trea")
CAMPO=URGENCIA,NOENTER,TITULO("Urg."),TOOLTIP("Urgencia del pedido"),WLONX=2
CAMPO=CODPED,NOENTER,TITULO("Ord.Trans."),TOOLTIP("Código de la orden de transporte"),WLONX=9
CAMPO=CODART,NOENTER,TITULO("Artículo"),TOOLTIP("Código del artículo")
CAMPO=PROPIETARIO,NOENTER,TITULO("Lote"),TOOLTIP("Lote del artículo")
CAMPO=CENTRO,NOENTER,TITULO("Centro"),TOOLTIP("Centro al que el artículo está asignado")
CAMPO=CANTPEDIDA,NOENTER,TITULO("Cantidad"),TOOLTIP("Cantidad pedida")
