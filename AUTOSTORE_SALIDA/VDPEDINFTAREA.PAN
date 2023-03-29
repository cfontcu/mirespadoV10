#*****************************************************************************************
#Modulo: VDPEDINFTAREA.PAN
#Funcionalidad : InformaciСn de detalle de la tarea seleccionada
#Autor: FermМn
#Fecha: 23-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INFORMACIсN TAREA
 
 оддддддддддддддддддддд DETALLE ддддддддддддддддддддддддддддддддддддддддддддддддддддддддк
 Ё                                                                                      Ё
 Ё C.Agrp     AgrupaciСn         Destino      Tipo tarea   Urgencia   Num.Pos.          Ё
 Ё ######    _________________   __________   __________    @@@@@@@@   @@@@@@@@         Ё
 Ё                                                                                      Ё
 Ё                                                                                      Ё
 Ё                                                                                      Ё
 Ё                                                                                      Ё
 юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
 |

TABLA=MET_BULTOCAB
#WHERE=STATUS=410;

CAMPO=CODAGRP,NOENTER,VIRTUAL,TITULO("C.Agrp"),WLONX=10
CAMPO=CODBULTO,NOENTER,TITULO("AgrupaciСn"),WLONX=30
CAMPO=CODCLIENTE,NOENTER,TITULO("Destino"),TOOLTIP("Destinatario del bulto"),WLONX=20
CAMPO=TIPOPEDIDO,NOENTER,TITULO("Tipo tarea"),TOOLTIP("Tipo de trea"),WLONX=15
CAMPO=URGENCIA,NOENTER,TITULO("Urgencia"),TOOLTIP("Urgencia del pedido"),WLONX=10
CAMPO=NUMPOS,NOENTER,TITULO("Num.Pos."),TOOLTIP("NЗmero de posiciones de pedido"),WLONX=10
