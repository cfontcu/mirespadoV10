###################################################################
#M�dulo: VDPEDCABMANU.PAN
#Funcionalidad : Inserci�n de manual de pedidos
#Autor: FPD
#Fecha: 13-12-2013
###################################################################
# Hist�rico de cambios:
CREACION MANUAL DE PEDIDOS 
 �������������������������������������� DATOS DEL PEDIDO  ��������������������������������������
 � Divisi�n: _20__  _40______________  Pedido: _20___________  A�o: @@@@@                       �
 � Pedido Cliente: _60_____________   Fecha:  �D-MM-Y.YYY     Fecha Servicio:�D-MM-Y.YYY       �
 � Pedido Host: _60_____________                                                               � 
 � Observaciones:  _255______________________________________________________________________  �
 �����������������������������������������������������������������������������������������������
 ��������������������������������������     ENTREGA       ��������������������������������������
 �  Consignatario: _20_________________ _60__________________ @@@   NIF: _30___________        � 
 �  Direcci�n: _40___________________________  _40___________________________                  �
 �  Pa�s: _5___ _30___________________________   Provincia: _5___ _40__________________        �
 �  DP: _10_____ Poblaci�n: _40_________________ Contacto : _40_______________________________ �
 �  Tel�fono: _12_______            Fax: _12______     Email: _40__________________________    �
 �����������������������������������������������������������������������������������������������
 ������������������������������������ DATOS DE PREPARACI�N  ������������������������������������
 � Tipo Pedido: ________ Familia:_15_______ Partic.Transporte: _15_______ Expedicion:_20_______�  
 � Prioridad: @@@    Urgencia: @@@     Idioma Etiq.: ______ Idioma doc.: _______               �
 � Dcto: ###,##      Recargo: ###,##   Valorado: _          Totales: _          Factura: _     �
 � N�Albaranes:@@@   POD:_    EDI:_    Backorder:_          Anular Precintos:_                 �
 �����������������������������������������������������������������������������������������������
 ���������������������������������������� TRANSPORTE  ������������������������������������������
 � Agencia:__________ _30______________________                                                �
 � Seguro: _1_     Reembolso:_1_     Portes:_1_      Aduana:_1_        Recargo: ######.##      �
 �                                                                                             �
 �����������������������������������������������������������������������������������������������
  Estado: @L@@@ _30__________________________
  Ultima modificaci�n: _32_______  �D-MM-Y.YYY  ________
|

TABLA=VDPEDIDORIGCAB
SELECT=CODCOMEN CODCOMENAUX;
WHERE=STATUS in (50,100);
WLONX=800

#POSTQUERY=FEJECUTA("+CSELCODPEDCLIENTE","NO SE PUEDE OBTENER CODIGO INTERNO DE PEDIDO CLIENTE",
#                   "+CSELCOMENTARIO","ERROR OBTENIENDO COMENTARIO")


PREINSERT=FEJECUTA("CCHECKCODDIV","EL CAMPO DIVISION DEL PEDIDO NO PUEDE SER NULO",
                   "CDESDIV","C�digo de divisi�n no existe.",
                   "CINITCAMPOS","ERROR INICIALIZANDO CAMPOS",
                   "CCHECKPOBLACION","LA POBLACION DE ENVIO NO PUEDE SER NULA",
                   "CCHECKDP","EL CODIGO POSTAL NO PUEDE SER NULO.",
                   "CCHECKLOCALIDAD","ERROR VALIDANDO LA POBLACION\n  -ES INCORRECTA \n  -NO ESTA DADA DE ALTA EN EL SISTEMA \n  -NO ESTA ASOCIADA A LA PROVINCIA O PAIS ",
                   FIF("CCHECKFACTU","CCHECKLOCALIDADFACTU",FSUCCESS),"ERROR VALIDANDO LA POBLACION DE FACTURACION\n  -ES INCORRECTA \n  -NO ESTA DADA DE ALTA EN EL SISTEMA \n  -NO ESTA ASOCIADA A LA PROVINCIA O PAIS ",
                   "CSELCODCOMEN","NO SE PUEDE OBTENER SECUENCIAL DE CODIGO DE COMENTARIO",
                   "CINSCOMENTARIO","ERROR INSERTANDO COMENTARIO",
				   "CCREACOMENPEC"," ERROR CREANDO COMENTARIOS ",
                   "+CSELCODPED","",                   
				   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
				   "CVEREXPEDICION","El campo Expedicion no puede ser nulo",
				   FPULSATECLAS("F2"),"")


PREUPDATE=FEJECUTA("CCHECKPOBLACION","LA POBLACION DE ENVIO NO PUEDE SER NULA",
                   "CCHECKDP","EL CODIGO POSTAL NO PUEDE SER NULO.",
                   "CCHECKLOCALIDAD","ERROR VALIDANDO LA POBLACION\n  -ES INCORRECTA \n  -NO ESTA DADA DE ALTA EN EL SISTEMA \n  -NO ESTA ASOCIADA A LA PROVINCIA O PAIS ",
				   "CDESDIV","C�digo de divisi�n no existe.",
                   FIF("CCHECKFACTU","CCHECKLOCALIDADFACTU",FSUCCESS),"ERROR VALIDANDO LA POBLACION DE FACTURACION\n  -ES INCORRECTA \n  -NO ESTA DADA DE ALTA EN EL SISTEMA \n  -NO ESTA ASOCIADA A LA PROVINCIA O PAIS ",
                   "CUPDCOMENTARIO","ERROR ACTUALIZANDO COMENTARIO",
				   "CCREACOMENPEC"," ERROR ACTUALIZANDO COMENTARIOS ",
				   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

PREDELETE=FEJECUTA("+CDELLINEASPED","")

CAMPO=CODDIV,TOOLTIP("Division o compa�ia del pedido"),POSTCHANGE=FDESIGNACION("+CDESDIV","C�digo de divisi�n no existe."),COMBOX("CLISTADIV"),WLONX=10
CAMPO=DESDIV,AUXILIAR,NOENTER,TITULO("Descripci�n") ,CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S"),WHERE=CODDIV IN (SELECT CODDIV FROM VDDIVIS WHERE DESDIV LIKE '%'||:DESDIV||'%');
CAMPO=CODPED,NOENTER,TOOLTIP("C�digo del pedido"),POSTCHANGE=FEJECUTA("+CSELANOPED","")
CAMPO=ANOPED,NOENTER,TOOLTIP("A�o del pedido")
CAMPO=PEDIDOCLIENTE,UPPER,TOOLTIP("C�digo de pedido del cliente")
CAMPO=FECPEDIDOCLIENTE,TOOLTIP("Fecha en la que el cliente realiz� el pedido"),COMBOX("CALENDARIO")
CAMPO=FECSERVICIO,TOOLTIP("Fecha en que est� previsto que se sirva el el pedido, se utiliza para ordenar los pedidos en la pantalla de creaci�n de series"),COMBOX("CALENDARIO")
CAMPO=PEDIDOHOST,TOOLTIP("C�digo interno del pedido para el HOST")
#CAMPO=FECINIPREPARA,OCULTO,"�D-MM-Y.YYY",TOOLTIP("Fecha tope de inicio de preparaci�n de un pedido")
CAMPO=MENHOST,TOOLTIP("Observaciones al pedido")
###############################################################################
CAMPO=CODPEDCLIENTE,AUXILIAR,OCULTO,"_20_"
CAMPO=CODCLIENTE,TOOLTIP("Es el c�digo de cliente que realiza el pedido, recibido por el fichero de interfase con el Host"),
                 POSTCHANGE=FDESIGNACION("+CSELDEF","","+CDESCLI","",FPOSICIONACAMPO(FSUCCESS,"TIPOPEDIDO"),""),
#                 CONTEXTUAL=FEJECUTAFORM("VDCLIENTES","N","CODCLIENTE IN (SELECT CODCLIENTE FROM VDCLIENTESDIVIS WHERE (CODDIV=:CODDIV OR :CODDIV IS NULL) AND (CODCLIDIV=:CODCLIENTE OR :CODCLIENTE IS NULL))","","CODCLIENTE=:CODCLIENTE DESCLIENTE=:DESCLIENTE SEQCODCLI=:SEQCODCLI NIF=:NIF DIRECCION=:DIRECCION DIRECCION1=:DIRECCION1 DIRECCION2=:DIRECCION2 DIRECCION3=:DIRECCION3 POBLACION=:POBLACION DP=:DP CODPAIS=:CODPAIS CODPROV=:CODPROV CONTACTO=:CONTACTO TELEFONO=:TELEFONO FAX=:FAX EMAIL=:EMAIL","SELECCIONAR  CLIENTE")
				 CONTEXTUAL=FEJECUTAFORM("VDCLIENTES","N","CODCLIENTE IN (SELECT CODCLIENTE FROM VDCLIENTESDIVIS WHERE (CODDIV=:CODDIV OR :CODDIV IS NULL) AND (CODCLIDIV=:CODCLIENTE OR :CODCLIENTE IS NULL))","","CODCLIENTE=:CODCLIENTE ","SELECCIONAR  CLIENTE")
CAMPO=DESCLIENTE,TOOLTIP("Designaci�n completa del cliente que realiza el pedido. Tambi�n recibido en el interfase")
CAMPO=SEQCODCLI,AUXILIAR,NOENTER,TOOLTIP("Secuencial de cliente para el caso en el que tenga m�s de una direccion")
CAMPO=NIF,TOOLTIP("Nif del cliente")
CAMPO=DIRECCION,TOOLTIP("Es la direcci�n del cliente o direcci�n destino del pedido. Se recibe en el interfase con el Host. Est� descompuesta en cuatro campos de 40 caracteres")
CAMPO=DIRECCION1,TOOLTIP("L�nea 2 de la direcci�n de envio del pedido")
CAMPO=DIRECCION2,OCULTO,"_40_",TOOLTIP("L�nea 3 de la direcci�n de envio del pedido")
CAMPO=DIRECCION3,OCULTO,"_40_",TOOLTIP("L�nea 4 de la direcci�n de envio del pedido")
CAMPO=CODPAIS,TOOLTIP("Pa�s de env�o"),POSTCHANGE=FDESIGNACION("+CSELPAISDEST",""),COMBOX("CSELCOMBOXPAIS")
CAMPO=DESPAISDEST,AUXILIAR,NOENTER
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de envio. Recibido del HOST"),POSTCHANGE=FDESIGNACION("+CSELDESPROVDEST",""),COMBOX("CSELCOMBOXPROV")
CAMPO=DESPROVDEST,AUXILIAR,NOENTER
CAMPO=DP,TOOLTIP("Distrito postal de la direcci�n de envio. Recibido de la interfase"),COMBOX("CSELCOMBOXDP")
CAMPO=POBLACION,TOOLTIP("Poblaci�n destino del pedido. Recibido del HOST"),COMBOX("CSELCOMBOXLOCALIDAD")
CAMPO=CONTACTO,TOOLTIP("Dato recibido en el interfase, de libre introducci�n. Es el posible contacto con el cliente")
CAMPO=TELEFONO,TOOLTIP("Tel�fono correspondiente a direcci�n de envio. Recibido del HOST")
CAMPO=FAX,TOOLTIP("N�mero de fax del cliente")
CAMPO=EMAIL,TOOLTIP("Direccion email correspondiente a direcci�n de envio. Recibido del HOST")
##############################################################################################
CAMPO=SWTMISCELANEO,OCULTO,"_"

CAMPO=SWTFACTU,OCULTO,"_"
CAMPO=CODCLIFACTU,OCULTO,"_20_"
CAMPO=DESCLIFACTU,OCULTO,"_60_"
CAMPO=NIFFACTU,OCULTO,"_30_"
CAMPO=DIRFACTU,OCULTO,"_40_"
CAMPO=DIRFACTU1,OCULTO,"_40_"
CAMPO=DIRFACTU2,OCULTO,"_40_"
CAMPO=DIRFACTU3,OCULTO,"_40_"
CAMPO=POBFACTU,OCULTO,"_40_"
CAMPO=DPFACTU,OCULTO,"_10_"
CAMPO=CODPAISFACTU,OCULTO,"_5_"
CAMPO=CODPROVFACTU,OCULTO,"_5_"
CAMPO=CONTAFACTU,OCULTO,"_40_"
CAMPO=TELFACTU,OCULTO,"_12_"
CAMPO=FAXFACTU,OCULTO,"_12_"
CAMPO=EMAILFACTU,OCULTO,"_40_"

CAMPO=TIPOPEDIDO,TOOLTIP("Identifica el tipo del pedido seg�n criterio de la compa��a. Es recibido del Host y tal como se recibe se introduce en la Base de datos. Tiene utilidad para establecer restricciones a la hora de crear series de pedidos."),
      COMBOX("CADUCADO")
CAMPO=PECFAMILIA,AUXILIAR,WHERE=CODCOMEN IN (SELECT CODCOMEN FROM VDCOMEN WHERE TIPOCOMEN='PECFAMILIA' AND LINCOMEN=1 AND COMENTARIO=:PECFAMILIA);,COMBOX("CFAMILIA"),TOOLTIP("Seleccione familia")
CAMPO=PECPARTRANS,AUXILIAR,WHERE=CODCOMEN IN (SELECT CODCOMEN FROM VDCOMEN WHERE TIPOCOMEN='PECPARTRANS' AND LINCOMEN=1 AND COMENTARIO=:PECPARTRANS);,COMBOX("CLISTAPART"),TOOLTIP("Seleccione particularidades del transporte")
CAMPO=CODAREAEXPED,TOOLTIP("Area de Expedici�n"),COMBOX ("CSELEXPEDI")


CAMPO=PRIORIDAD,TOOLTIP("Prioridad de asignaci�n de stock al pedido: 0 M�xima 99 M�nima. Tiene prioridad sobre la fecha de servicio")
CAMPO=URGENCIA,TOOLTIP("Urgencia del pedido 0 M�xima 99 M�nima")
CAMPO=IDIOMAETIQ,TOOLTIP("Idioma de las etiquetas de envio")
CAMPO=IDIOMADOC,TOOLTIP("Idioma de la documentaci�n de envio")
CAMPO=DESCUENTO,TOOLTIP("Indica el porcentaje de descuento global que se aplicar� pedido")
CAMPO=DESCUENTOLIN,AUXILIAR,OCULTO,"###,##"
CAMPO=RECARGO,TOOLTIP("Indica el porcentaje de recargo a nivel global que se aplicar� al pedido")
CAMPO=RECARGOLIN,AUXILIAR,OCULTO,"###,##"
CAMPO=IVA,AUXILIAR,OCULTO,"###,##"
CAMPO=SWTVALORADO,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S', si el pedido debe llevar albar�n valorado. 'N' para lo contrario ")
CAMPO=SWTTOTALES,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' imprimir albar�n valorado con impuestos y totales 'N' Albar�n s�lo con l�neas valoradas")
CAMPO=SWTPROFORMA,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: de 'S' para imprimir una factura proforma que acompa�e al pedido (esta factura se a�adir� en el momento de impresi�n de la documentaci�n de env�o de las agencias). 'N' para no incluir ninguna factura")
CAMPO=SWTMODELO,OCULTO,"_",POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' el pedido ha de llevar documentaci�n adicional, 'N' no lleva documentaci�n adicional")
CAMPO=REFMODELO,OCULTO,"_80_",TOOLTIP("Referencia de la documentaci�n adicional")
CAMPO=NUMALBA,TOOLTIP("N�mero de albaranes a imprimir autom�ticamente en verificaci�n")
CAMPO=SWTALBSELLADO,UPPER,TOOLTIP("Indica si el pedido debe llevar comprobante de entrega")
CAMPO=SWTEDI,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que se debe enviar interfase EDI al cliente o 'N' no se debe enviar intefase EDI.")
CAMPO=BACKORDER,TOOLTIP("Indicador recibido del host, que puede tomar los siguientes valores: 'T' todas las l�neas \ndel pedido deben servirse en su totalidad(estricto), 'L' todas las l�neas deben servirse pero si una l�nea est� servida \no no depende de la pol�tica de la l�nea, 'P' el pedido puede servirse parcialmente ")
CAMPO=SWTANULAR,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador con valores: 'S' anular precintos 'N' no anular precintos. Esto es en funci�n de si el pedido debe llevar el precio anulado o no.")
CAMPO=SWTAGRUPAR,OCULTO,"_",POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N' en funci�n de si el pedido puede ser agrupado con otros pedidos del mismo cliente, agencia y destino, con el fin de ser facturado por la agencia como un �nico albar�n. Nota: Se agrupar�n pedidos incluso de diferentes divisiones y empresas.")
CAMPO=SWTPALETIZAR,OCULTO,"_",POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que el pedido se debe paletizar o 'N' no se debe paletizar.")
CAMPO=SWTNUMEROSERIE,OCULTO,"_",POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador con valores: 'S' leer n�meros de serie o 'N' no leerlos.")
#CAMPO=REFCLIENTE,OCULTO,"_60_",TOOLTIP("Referencia del cliente que realiza el pedido")
#CAMPO=PEDCLIFINAL,OCULTO,"_60_",TOOLTIP("C�digo de pedido del cliente final")
##############################################################################
CAMPO=CODAGE,TOOLTIP("Es el c�digo de la agencia que transportar� el pedido. Deber� existir en la tabla de agencias"),POSTCHANGE=FDESIGNACION("CDESAGE","Agencia no existe."),
      CONTEXTUAL=FEJECUTAFORM("VDAGENCIA","N","CODAGE=:CODAGE OR :CODAGE IS NULL","","CODAGE=:CODAGE"),COMBOX("CAGENCIAS")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia de transporte")
CAMPO=SWTSEGURO,UPPER,COMBOX("S S�","N No"),POSTCHANGE=FVERIFICA("SN ","Los posibles valores son S(�) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva seguro y se factura, 'P', seguro pagado, 'D', seguro debido o 'N', el pedido no lleva seguro. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=SWTREEMBOLSO,COMBOX("S S�","N No"),UPPER,POSTCHANGE=FVERIFICA("SN ","Los posibles valores son S(�) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva reembolso y se factura, 'P', reembolso pagado, 'D', reembolso debido o 'N', el pedido no lleva reembolso. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=PORTES,UPPER,COMBOX("D Debidos","P Pagados","F Francos"),POSTCHANGE=FVERIFICA("DPF ","Los posibles valores son 'D' Debidos, 'P' Pagados, 'F' Francos"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'D' Debidos, 'P' Pagados, 'F' Francos")
CAMPO=SWTADUANA,COMBOX("S S�","N No"),UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'S', el pedido lleva documentaci�n de la aduana o 'N', el pedido no lleva doumentaci�n de la aduana. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=RECARGOAGE,TOOLTIP("Cantidad adicional a pagar a la agencia. Utilizado para la autofacturaci�n de agencias")
#CAMPO=FECPREVISTA,TOOLTIP("Fecha prevista de entrega del pedido al cliente")
#CAMPO=HORAINIPREVISTA,TOOLTIP("Hora inicial prevista para la entrega del pedido al cliente"),
#                      COMBOX("00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30",
#                      "08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30",
#                      "17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"),COMBOXREADONLY
#CAMPO=HORAFINPREVISTA,TOOLTIP("Hora final prevista para la entrega del pedido al cliente"),
#                      COMBOX("00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30",
#                      "08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30",
#                      "17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"),COMBOXREADONLY
CAMPO=STATUS,NOENTER,POSTCHANGE=FDESIGNACION("+CDESSTATUS","Estado incorrecto.")
CAMPO=DESSTATUS,NOENTER,AUXILIAR
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiza la modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la �ltima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificacion")
CAMPO=SEQPED,OCULTO,"@@@@"
################################################################################################################

CAMPO=SWTREEXP,OCULTO,"_"
CAMPO=SWTALBEXTERIOR,OCULTO,"_"
CAMPO=CDE,OCULTO,"_"
CAMPO=SWTCOMUNICAR,OCULTO,"_"
CAMPO=SWTPACKINGLIST,OCULTO,"_"
CAMPO=SWTNOETIQCC,OCULTO,"_"
CAMPO=SWTETIQECI,OCULTO,"_"
CAMPO=SWTBLOQEXP,OCULTO,"_"
CAMPO=SWTMAIL,OCULTO,"_"
CAMPO=SWTFAX,OCULTO,"_"
CAMPO=SWTPREPMONO,OCULTO,"_"

CAMPO=FECCAPTURA,OCULTO,"@@@@@@@"
CAMPO=HORACAPTURA,OCULTO,"_8_"
CAMPO=FECGRABACION,OCULTO,"@@@@@@@"
CAMPO=HORAGRABACION,OCULTO,"_8_"
CAMPO=FECRECEP,OCULTO,"@@@@@@@"
CAMPO=HORARECEP,OCULTO,"_8_"
CAMPO=CODCOMEN,OCULTO,"@L@@@@@@@",POSTCHANGE=FDESIGNACION("+CSELSEQCODCLI","")
CAMPO=CODCOMENAUX,AUXILIAR,OCULTO,"@L@@@@@@@"

CAMPO=CODCLIREEXP,OCULTO,"_20_"
CAMPO=DESCLIREEXP,OCULTO,"_60_"
CAMPO=NIFREEXP,OCULTO,"_30_"
CAMPO=DIRREEXP,OCULTO,"_40_"
CAMPO=DIRREEXP1,OCULTO,"_40_"
CAMPO=DIRREEXP2,OCULTO,"_40_"
CAMPO=DIRREEXP3,OCULTO,"_40_"
CAMPO=POBREEXP,OCULTO,"_40_"
CAMPO=DPREEXP,OCULTO,"_10_"
CAMPO=CODPAISREEXP,OCULTO,"_5_"
CAMPO=CODPROVREEXP,OCULTO,"_5_"
CAMPO=CONTAREEXP,OCULTO,"_40_"
CAMPO=TELREEXP,OCULTO,"_12_"
CAMPO=FAXREEXP,OCULTO,"_12_"
CAMPO=EMAILREEXP,OCULTO,"_40_"
CAMPO=NUMLINEAS,AUXILIAR,NOUPDATE,OCULTO,"@@@@@"
CAMPO=DUMMY,AUXILIAR,NOUPDATE,OCULTO,"@"
CAMPO=SWTCAJASCOMPLETAS,OCULTO,"_1_"
CAMPO=SWTIMPNODESPALETIZAR,OCULTO,"_1_"
CAMPO=SWTSEPARARCAPAS,OCULTO,"_1_"
CAMPO=SWTSEPARARREFERENCIAS,OCULTO,"_1_"



CURSOR=CFAMILIA SELECT 'NINGUNA', NULL
                FROM DUAL
                UNION
                SELECT CODCLASE, DESCLASE
                FROM VDCLASES
                WHERE CODCLASIF = 'FAMILIA'
                ORDER BY 1;
				
CURSOR=CLISTAPART SELECT DESCLASE TIPO_TRANSPORTE, CODCLASE
				  FROM VDCLASES
                  WHERE CODCLASIF='TRANSPORTE'
				  UNION
				  SELECT 'VACIO', 'NULL'
				  FROM DUAL
				  UNION
				  SELECT 'TODOS', 'TODOS'
				  FROM DUAL
				  ORDER BY 1;
				  

CURSOR=CSELCOMBOXPAIS SELECT CODPAIS, DESPAIS CODPAISDEST FROM VDPAIS ORDER BY DECODE(CODPAIS,'724',1,'620',2,3),DESPAIS;

CURSOR=CSELCOMBOXPROV SELECT CODPROV,DESPROV FROM VDPROVI WHERE CODPAIS=:CODPAIS AND CODPAIS IS NOT NULL  ;  
                                 
CURSOR=CSELCOMBOXDP  SELECT DISTINCT(DP) FROM VDLOCALIDAD WHERE CODPAIS=:CODPAIS AND :CODPAIS IS NOT NULL AND CODPROV=:CODPROV AND :CODPROV IS NOT NULL 
                        ORDER BY DP;

CURSOR=CSELCOMBOXLOCALIDAD SELECT LOCALIDAD FROM VDLOCALIDAD WHERE CODPAIS=:CODPAIS AND :CODPAIS IS NOT NULL AND CODPROV=:CODPROV AND :CODPROV IS NOT NULL AND DP=:DP AND :DP IS NOT NULL
                        ORDER BY LOCALIDAD;                        
 
CURSOR=CDESUSUARIO SELECT NOMBRE||' '||APELLIDO1 NOMBREAVISOA
                     FROM VDUSUARIO
                    WHERE CODOPE=:RECAVISOA;

CURSOR=CLISTAUSUARIOS SELECT RECAVISOA,NOMBRE
                      FROM (SELECT 0 NUM, CODOPE RECAVISOA,NOMBRE||' '||APELLIDO1 NOMBRE FROM VDUSUARIO WHERE CODOPE=VDUSER.GETUSER
                            UNION
                            SELECT 1 NUM, CODOPE RECAVISOA,NOMBRE||' '||APELLIDO1 NOMBRE FROM VDUSUARIO WHERE CODOPE <> VDUSER.GETUSER)
                      ORDER BY NUM, RECAVISOA;
					  
CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';

CURSOR=CINITCAMPOS SELECT 'N' SWTREEXP, 'N' SWTALBEXTERIOR, 'N' CDE, 'N' SWTCOMUNICAR, NVL(:SWTMISCELANEO,'N') SWTMISCELANEO,
                          'N' SWTPACKINGLIST, 'N' SWTNOETIQCC, 'N' SWTETIQECI, 'N' SWTBLOQEXP, 'N' SWTMAIL,
                          'N' SWTFAX, 'N' SWTPREPMONO, VD.FECHASYS FECCAPTURA, VD.HORASYS HORACAPTURA, 
                          VD.FECHASYS FECGRABACION, VD.HORASYS HORAGRABACION, VD.FECHASYS FECRECEP, VD.HORASYS HORARECEP, 50 STATUS,
                          DECODE(:ANOPED,0,TO_CHAR(SYSDATE,'YYYY'),:ANOPED) ANOPED,
                          DECODE(:FECSERVICIO,0,VD.FECHASYS,:FECSERVICIO) FECSERVICIO,NVL(:SWTALBSELLADO,'N') SWTALBSELLADO,
                          NVL(:SWTSEGURO,'N') SWTSEGURO, NVL(:SWTREEMBOLSO,'N') SWTREEMBOLSO,'N' SWTFACTU,
						  DECODE(:PRIORIDAD,0,50,:PRIORIDAD) PRIORIDAD,DECODE(:URGENCIA,0,50,:URGENCIA) URGENCIA,
						  1 SEQPED, 'N' SWTCAJASCOMPLETAS, 'N' SWTIMPNODESPALETIZAR, 'N' SWTSEPARARCAPAS, 'N' SWTSEPARARREFERENCIAS
                     FROM DUAL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE
                UNION 
               SELECT NULL DESAGE FROM DUAL WHERE :CODAGE IS NULL;

CURSOR=CSELDESPROVDEST SELECT DESPROV DESPROVDEST
                         FROM VDPROVI 
                        WHERE CODPROV = :CODPROV AND CODPAIS = :CODPAIS;

CURSOR=CSELDESPROVFACT SELECT DESPROV DESPROVFACTU
                         FROM VDPROVI 
                        WHERE CODPROV = :CODPROVFACTU AND CODPAIS = :CODPAISFACTU;

CURSOR=CSELPAISDEST SELECT DESPAIS DESPAISDEST
                      FROM VDPAIS
                     WHERE CODPAIS = :CODPAIS;

                                          
CURSOR=CSELPAISFACT SELECT DESPAIS DESPAISFACT
                      FROM VDPAIS
                     WHERE CODPAIS = :CODPAISFACTU;

CURSOR=CDESDIV SELECT DESDIV
                 FROM VDDIVIS
                WHERE CODDIV=:CODDIV;
				
CURSOR=CCHECKCODDIV SELECT :CODDIV FROM DUAL WHERE :CODDIV IS NOT NULL;

CURSOR=CCHECKPOBLACION SELECT :POBLACION POBLACION FROM DUAL WHERE :POBLACION IS NOT NULL;

CURSOR=CCHECKDP SELECT :DP FROM DUAL WHERE :DP IS NOT NULL;

CURSOR=CCHECKPAIS SELECT :CODPAIS FROM VDPAIS WHERE CODPAIS = :CODPAIS AND DESPAIS = 'PORTUGAL';

CURSOR=CDELLINEASPED DELETE FROM VDPEDIDORIGLIN WHERE CODPED = :CODPED AND CODDIV = :CODDIV AND ANOPED = :ANOPED;

#CURSOR=CINSPEDORIG INSERT INTO VDPEDIDORIGCAB (CODDIV, ANOPED, CODPED, ANOALB, CODALB, TIPOPEDIDO, NLINEAS, PEDIDOCLIENTE, FECPEDIDOCLIENTE, 
#                                               PEDIDOHOST, CODCLIENTE, DESCLIENTE, NIF, CONTACTO, DIRECCION, DIRECCION1, DIRECCION2, DIRECCION3, 
#                                               POBLACION, CODPROV, DP, CODPAIS, TELEFONO, FAX, EMAIL, DIRECCIONEDI, IDIOMAETIQ, IDIOMADOC, NUMALBA, MENHOST, 
#                                               SWTANULAR, SWTVALORADO, SWTTOTALES, SWTPROFORMA, SWTALBEXTERIOR, SWTALBSELLADO, SWTAGRUPAR, SWTCOMUNICAR, SWTMODELO, 
#                                               REFMODELO, SWTMISCELANEO, SWTPACKINGLIST, SWTNOETIQCC, SWTPALETIZAR, SWTETIQECI, SWTBLOQEXP, SWTMAIL, SWTFAX, 
#                                               SWTEDI, CODAREAEXPED, BACKORDER, SWTPREPMONO, TPCVERIF, COLCAMBIOVOL, MONEDA, DESCUENTO, DESDESCUENTO, 
#                                               RECARGO, DESRECARGO, CONDPAGO, PRIORIDAD, URGENCIA, CODAGE, TRACKINGAGE, DATOSAGE, SWTADUANA, SWTREEXP, CODCLIREEXP, DESCLIREEXP, 
#                                               NIFREEXP, CONTAREEXP, DIRREEXP, DIRREEXP1, DIRREEXP2, DIRREEXP3, POBREEXP, CODPROVREEXP, DPREEXP, CODPAISREEXP, TELREEXP, FAXREEXP, 
#                                               EMAILREEXP, DIRECCIONEDIREEXP, SWTFACTU, CODCLIFACTU, DESCLIFACTU, NIFFACTU, CONTAFACTU, DIRFACTU, DIRFACTU1, 
#                                               DIRFACTU2, DIRFACTU3, POBFACTU, CODPROVFACTU, DPFACTU, CODPAISFACTU, TELFACTU, FAXFACTU, EMAILFACTU, DIRECCIONEDIFACTU, CODCOMEN, FECCAPTURA, 
#                                               HORACAPTURA, FECSERVICIO, FECGRABACION, HORAGRABACION, FECRECEP, HORARECEP, FECTERMIN, HORATERMIN, STATUS, VDEXTRA, CODOPEMODIF, FECMODIF, 
#                                               HORAMODIF, SWTSEGURO, SWTREEMBOLSO, PORTES, CDE, RECARGOAGE, PESOPEDIDO, REFCLIENTE, PEDCLIFINAL,FECPREVISTA,HORAINIPREVISTA,HORAFINPREVISTA,
#											   SWTMANUAL) 
#                   VALUES (:CODDIV, :ANOPED, :CODPED, 0, NULL, :TIPOPEDIDO, 0, :PEDIDOCLIENTE, :FECPEDIDOCLIENTE, 
#                           :PEDIDOHOST, :CODCLIENTE, :DESCLIENTE, :NIF, :CONTACTO, :DIRECCION, :DIRECCION1, :DIRECCION2, :DIRECCION3, 
#                           :POBLACION, :CODPROV, :DP, :CODPAIS, :TELEFONO, :FAX, :EMAIL, NULL, :IDIOMAETIQ, :IDIOMADOC, :NUMALBA, :MENHOST, 
#                           :SWTANULAR, :SWTVALORADO, :SWTTOTALES, :SWTPROFORMA, :SWTALBEXTERIOR, :SWTALBSELLADO, :SWTAGRUPAR, :SWTCOMUNICAR, :SWTMODELO, 
#                           :REFMODELO, :SWTMISCELANEO, :SWTPACKINGLIST, :SWTNOETIQCC, :SWTPALETIZAR, :SWTETIQECI, :SWTBLOQEXP, :SWTMAIL, :SWTFAX, 
#                           :SWTEDI, :CODAREAEXPED, :BACKORDER, :SWTPREPMONO, 0, NULL, NULL, :DESCUENTO, NULL, 
#                           :RECARGO, NULL, NULL, :PRIORIDAD, :URGENCIA, :CODAGE, NULL, NULL, :SWTADUANA, :SWTREEXP, :CODCLIREEXP, :DESCLIREEXP, 
#                           :NIFREEXP, :CONTAREEXP, :DIRREEXP, :DIRREEXP1, :DIRREEXP2, :DIRREEXP3, :POBREEXP, :CODPROVREEXP, :DPREEXP, :CODPAISREEXP, :TELREEXP, :FAXREEXP, 
#                           :EMAILREEXP, NULL, :SWTFACTU, :CODCLIFACTU, :DESCLIFACTU, :NIFFACTU, :CONTAFACTU, :DIRFACTU, :DIRFACTU1, 
#                           :DIRFACTU2, :DIRFACTU3, :POBFACTU, :CODPROVFACTU, :DPFACTU, :CODPAISFACTU, :TELFACTU, :FAXFACTU, :EMAILFACTU, NULL, :CODCOMENAUX, :FECCAPTURA, 
#                           :HORACAPTURA, :FECSERVICIO, :FECGRABACION, :HORAGRABACION, :FECRECEP, :HORARECEP, 0, NULL, VDST.FPECGRABMANUAL, NULL, VDUSER.GETUSER, VD.FECHASYS, 
#                           VD.HORASYS, :SWTSEGURO, :SWTREEMBOLSO, NVL(:PORTES,'P'), :CDE, :RECARGOAGE, 0, :REFCLIENTE, :PEDCLIFINAL,:FECPREVISTA,:HORAINIPREVISTA,:HORAFINPREVISTA,
#						   'S');

CURSOR=CCHECKLOCALIDAD SELECT :POBLACION
                         FROM VDLOCALIDAD LOC, VDPAIS PAI
                        WHERE UPPER(LOC.LOCALIDAD)=UPPER(:POBLACION) 
                          AND LOC.CODPROV = :CODPROV 
                          AND UPPER(LOC.CODPAIS) =UPPER(:CODPAIS) 
                          AND TRIM(LOC.DP)=TRIM(:DP) 
                          AND PAI.CODPAIS = :CODPAIS;

CURSOR=CCHECKFACTU SELECT :SWTFACTU FROM DUAL WHERE :SWTFACTU = 'S';

CURSOR=CCHECKLOCALIDADFACTU SELECT :POBFACTU
                              FROM VDLOCALIDAD LOC, VDPAIS PAI
                             WHERE UPPER(LOC.LOCALIDAD)=UPPER(:POBFACTU) 
                               AND LOC.CODPROV = :CODPROVFACTU 
                               AND UPPER(LOC.CODPAIS) =UPPER(:CODPAISFACTU) 
                               AND TRIM(LOC.DP)=DECODE(TRIM(PAI.DESPAIS),'PORTUGAL','9'||SUBSTR(TRIM(:DPFACTU),1,4),TRIM(:DPFACTU)) 
                               AND PAI.CODPAIS = :CODPAISFACTU;

CURSOR=CCHECKHAYLINEAS SELECT :CODPED FROM VDPEDIDORIGLIN WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND ANOPED=:ANOPED
                       UNION
                       SELECT :CODPED FROM DUAL WHERE :TIPOPEDIDO IN ('RECOGIDA','REPARTO') OR :CODPED LIKE 'M%';

CURSOR=CSELNUMLINEAS SELECT COUNT(*) NUMLINEAS FROM VDPEDIDORIGLIN WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND ANOPED=:ANOPED;
 					   
CURSOR=CUPDSTATUSPED UPDATE VDPEDIDORIGCAB 
                        SET STATUS = VDST.FPECRECIBIDO, CODOPEMODIF=VDUSER.GETUSER , FECMODIF=VD.FECHASYS ,HORAMODIF=VD.HORASYS,
                            SWTMISCELANEO=DECODE(:NUMLINEAS,0,'S','N') 
                      WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND ANOPED=:ANOPED;

CURSOR=CSELSEQCODCLI SELECT VDCOM.DAMECOMEN(:CODCOMEN,'SEQCODCLI',1) SEQCODCLI FROM DUAL WHERE :SEQCODCLI=0;

CURSOR=CSELCODPED SELECT 'M'||LPAD(VDSECCODPED.NEXTVAL,7,'0') CODPED FROM DUAL WHERE :CODPED IS NULL;

#CURSOR=CSELCODPEDCLIENTE SELECT CODPED CODPEDCLIENTE FROM VDPEDCLICAB WHERE PEDIDOCLIENTE=:PEDIDOCLIENTE AND CODDIV=:CODDIV;

CURSOR=CSELCODCOMEN SELECT VDSECCOMEN.NEXTVAL CODCOMENAUX FROM DUAL;

CURSOR=CINSCOMENTARIO INSERT INTO VDCOMEN (TIPOCOMEN, CODCOMEN, LINCOMEN, COMENTARIO, NOTIFICAR, CODOPEMODIF, FECMODIF, HORAMODIF) 
                        VALUES('SEQCODCLI',:CODCOMENAUX,1,:SEQCODCLI,'N',VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS);

CURSOR=CUPDCOMENTARIO UPDATE VDCOMEN SET COMENTARIO=:SEQCODCLI
                       WHERE CODCOMEN = :CODCOMENAUX AND TIPOCOMEN='SEQCODCLI';

#CURSOR=CSELCOMENTARIO SELECT VDCOM.DAMECOMEN(:CODCOMENAUX,'SEQCODCLI',1) SEQCODCLI, 
#                             VDCOM.DAMECOMEN(:CODCOMENAUX,'PECFAMILIA',1) PECFAMILIA, 
#							 VDCOM.DAMECOMEN(:CODCOMENAUX,'PECPARTRANS',1) PECPARTRANS FROM DUAL;
							 
CURSOR=CCREACOMENPEC BEGIN
                                 VDCOM.CREACOMEN('VDPEDIDORIGCAB',:CODCOMENAUX,'PECFAMILIA',1,:PECFAMILIA);
								 VDCOM.CREACOMEN('VDPEDIDORIGCAB',:CODCOMENAUX,'PECPARTRANS',1,:PECPARTRANS);
                                END;@ 							 

CURSOR=CAGENCIAS SELECT CODAGE,DESAGE FROM VDAGENCIA WHERE CODAGE!='TARIFA' ORDER BY DESAGE;

CURSOR=CSELDEF SELECT 'N' SWTVALORADO,'N' SWTTOTALES,'N' SWTPROFORMA,'N' SWTMODELO,'N' SWTANULAR,'N' SWTEDI, 
                      'N' SWTAGRUPAR,'N' SWTPALETIZAR,'N' SWTADUANA,'T' BACKORDER,'N' SWTNUMEROSERIE FROM DUAL;

CURSOR=CLISTADIV SELECT CODDIV,DESDIV,DESEMP FROM VDDIVIS DIV,VDEMPRE EMP WHERE EMP.CODEMP=DIV.CODEMP AND DIV.SWTACTIVA='S' ORDER BY CODDIV;

CURSOR=CCHECKPEDGRABADO SELECT :CODPED FROM VDPEDIDORIGCAB WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND ANOPED=:ANOPED;	

CURSOR=CCHECKLIN SELECT :CODPED FROM VDPEDIDORIGLIN WHERE CODPED=:CODPED AND CODDIV=:CODDIV AND ANOPED=:ANOPED AND ROWNUM=1;	
								
								
CURSOR=CCHECKCLIENTE SELECT 1 DUMMY FROM DUAL WHERE :DESCLIENTE IS NOT NULL;

CURSOR=CHCHECKDIRECCION SELECT 1 DUMMY FROM DUAL WHERE :DIRECCION||:DIRECCION1||:DIRECCION2||:DIRECCION3 IS NOT NULL;

CURSOR=CCHECKAGENCIA SELECT 1 DUMMY FROM DUAL WHERE :NUMLINEAS>0 OR (:NUMLINEAS=0 AND :CODAGE IS NOT NULL);

CURSOR=CCCHECKPECFAMILIA SELECT 1 DUMMY FROM DUAL WHERE :NUMLINEAS>0 OR VD.CONTIENECAD(VD.GETPROP('MISCDIVISFAMILIAOBL'), :CODDIV)=0 OR (:NUMLINEAS=0 AND VD.CONTIENECAD(VD.GETPROP('MISCDIVISFAMILIAOBL'), :CODDIV)=1 AND VDCOM.DAMECOMEN(:CODCOMENAUX,'PECFAMILIA',1) IS NOT NULL);

CURSOR=CCCHECKPECPARTRANS SELECT 1 DUMMY FROM DUAL WHERE :NUMLINEAS>0 OR (:NUMLINEAS=0 AND VDCOM.DAMECOMEN(:CODCOMENAUX,'PECPARTRANS',1) IS NOT NULL);

CURSOR=CSELEXPEDI SELECT CODAREA, ALM.DESALM  FROM VDAREA ARE, VDALMA ALM WHERE ARE.CODALM=ALM.CODALM AND CODAREA LIKE 'EXPEDI%' ;

CURSOR=CVEREXPEDICION SELECT :CODAREAEXPED FROM DUAL WHERE :CODAREAEXPED IS NOT NULL;

CURSOR=CSELANOPED SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) ANOPED FROM DUAL;

CURSOR=CDESCLI SELECT CODCLIENTE, DESCLIENTE, SEQCODCLI,NIF, DIRECCION, DIRECCION1, DIRECCION2, DIRECCION3, POBLACION, 
                      DP, CODPAIS, CODPROV, CONTACTO, TELEFONO, FAX, EMAIL
                 FROM VDCLIENTES
				 WHERE CODCLIENTE=:CODCLIENTE AND CODDIV=:CODDIV;
				 
TECLA=SF4,FEJECUTA("CCHECKPEDGRABADO","DEBE GRABAR EL PEDIDO ANTES DE ACTIVARLO",
                   "CCHECKCLIENTE","DEBE INDICAR LA DESCRIPCI�N DEL CONSIGNATARIO",
                   "CHCHECKDIRECCION","DEBE INDICAR LA DIRECCI�N DEL CONSIGNATARIO ",
                   "+CSELNUMLINEAS","",
				   "CCCHECKPECFAMILIA","PEDIDO SIN LINEAS. OBLIGATORIO INFORMAR FAMILIA PARA DIVISION :CODDIV",
				   "CCCHECKPECPARTRANS","PEDIDO SIN LINEAS. OBLIGATORIO INFORMAR PARTICULARIDADES DEL TRANSPORTE",
				   "CCHECKAGENCIA","PEDIDO SIN LINEAS. OBLIGATORIO INFORMAR AGENCIA",
                   "CUPDSTATUSPED","ERROR ACTUALIZANDO ESTADO DEL PEDIDO",
                   FCOMMIT,"ERROR HACIENDO COMMIT",
                   %FFAILURE,"PEDIDO :CODPED DE LA DIVISION :CODDIV ACTIVADO",
				   FPULSATECLAS("F5"),"")
#                   "CCHECKHAYLINEAS","DEBE GRABAR LINEAS ANTES DE ACTIVAR EL PEDIDO",
#				   				   

TECLA=SF7,FEJECUTA("CCHECKPEDGRABADO","DEBE GRABAR ANTES EL PEDIDO",
	               "-CCHECKLIN","EL PEDIDO NO PUEDE TENER L�NEAS",
				   FIMPRIME("INFORME","VDALBARAN_ORIG.RPT","ANOPED=:ANOPED;CODDIV=:CODDIV;CODPED=:CODPED",""),"Error imprimiendo pedido")

				   
				   
BOTON=B1,720,60,50,50,"B1",Copiar.png,CF7,"COPIAR PEDIDO",INCLUDECSS="background-color: transparent;border-width:0px"
BOTON=B4,720,120,50,50,"B4",vertis\vertisok.png,SF4,"ACTIVAR PEDIDO",INCLUDECSS="background-color: transparent;border-width:0px"
BOTON=B5,720,180,50,50,"B5",miimprimir.png,SF7,"Impresi�n del Albar�n",INCLUDECSS="background-color: transparent;border-width:0px"
#BOTON=B2,720,120,50,50,"B2",vertis\vertisguardar.png,F4,"GRABAR PEDIDO",INCLUDECSS="background-color: transparent;border-width:0px"
#BOTON=B3,720,180,50,50,"B3",vertis\vertisinventario.png,F6,"INTRODUCIR LINEAS",INCLUDECSS="background-color: transparent;border-width:0px"

AYUDA=INSERCION MANUAL DE PEDIDOS 
ONLINE= {F1} Ayuda             {F2} Consulta       {F4} Grabar pedido   {M�y+F4} Activar pedido 
        {F6} Introducir lineas de pedido {Esc} Cerrar Pantalla  {F9} Borrar pedido  {M�y+F10} Men� Contextual ;
