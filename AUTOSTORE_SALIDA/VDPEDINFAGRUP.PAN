#*****************************************************************************************
#Modulo: VDPEDINFTAREA.PAN
#Funcionalidad : Informaci�n de detalle de l tarea seleccionada
#Autor: Ferm�n
#Fecha: 23-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INFORMACI�N TAREA
 
 ���������������������� DETALLE �������������������������������������������������������������������������������������������������
 �                                                                                                                              �
 � Agrupaci�n              Destino             T.tarea      Urg.         Ord.Trans.       Art�culo   Lote     Centro   Cantidad �
 � ____________________    _________________   __________   __________   ______________   ________   ______   ______   ######## �
 �                                                                                                                              �
 �                                                                                                                              �
 �                                                                                                                              �
 �                                                                                                                              �
 ��������������������������������������������������������������������������������������������������������������������������������
 |

TABLA=MET_BULTOLIN

CAMPO=CODBULTO,NOENTER,VIRTUAL,TITULO("Agrpaci�n"),TOOLTIP("C�digo de la agrupaci�n"),WLONX=12
CAMPO=CODCLIENTE,NOENTER,TITULO("Destino"),TOOLTIP("Destinatario del bulto")
CAMPO=TIPOPEDIDO,NOENTER,TITULO("T.tarea"),TOOLTIP("Tipo de trea")
CAMPO=URGENCIA,NOENTER,TITULO("Urg."),TOOLTIP("Urgencia del pedido"),WLONX=2
CAMPO=CODPED,NOENTER,TITULO("Ord.Trans."),TOOLTIP("C�digo de la orden de transporte"),WLONX=9
CAMPO=CODART,NOENTER,TITULO("Art�culo"),TOOLTIP("C�digo del art�culo")
CAMPO=PROPIETARIO,NOENTER,TITULO("Lote"),TOOLTIP("Lote del art�culo")
CAMPO=CENTRO,NOENTER,TITULO("Centro"),TOOLTIP("Centro al que el art�culo est� asignado")
CAMPO=CANTPEDIDA,NOENTER,TITULO("Cantidad"),TOOLTIP("Cantidad pedida")
