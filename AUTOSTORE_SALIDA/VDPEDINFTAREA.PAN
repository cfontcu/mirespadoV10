#*****************************************************************************************
#Modulo: VDPEDINFTAREA.PAN
#Funcionalidad : Informaci�n de detalle de la tarea seleccionada
#Autor: Ferm�n
#Fecha: 23-03-2023
#*******************************************************************************************
#* Historico de cambios
#* ====================
 INFORMACI�N TAREA
 
 ���������������������� DETALLE ���������������������������������������������������������
 �                                                                                      �
 � C.Agrp     Agrupaci�n         Destino      Tipo tarea   Urgencia   Num.Pos.          �
 � ######    _________________   __________   __________    @@@@@@@@   @@@@@@@@         �
 �                                                                                      �
 �                                                                                      �
 �                                                                                      �
 �                                                                                      �
 ����������������������������������������������������������������������������������������
 |

TABLA=MET_BULTOCAB
#WHERE=STATUS=410;

CAMPO=CODAGRP,NOENTER,VIRTUAL,TITULO("C.Agrp"),WLONX=10
CAMPO=CODBULTO,NOENTER,TITULO("Agrupaci�n"),WLONX=30
CAMPO=CODCLIENTE,NOENTER,TITULO("Destino"),TOOLTIP("Destinatario del bulto"),WLONX=20
CAMPO=TIPOPEDIDO,NOENTER,TITULO("Tipo tarea"),TOOLTIP("Tipo de trea"),WLONX=15
CAMPO=URGENCIA,NOENTER,TITULO("Urgencia"),TOOLTIP("Urgencia del pedido"),WLONX=10
CAMPO=NUMPOS,NOENTER,TITULO("Num.Pos."),TOOLTIP("N�mero de posiciones de pedido"),WLONX=10
