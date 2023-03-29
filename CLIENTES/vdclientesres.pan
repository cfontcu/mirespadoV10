#M�dulo: VDCLIENTESRES.FRM
#Funcionalidad : Resumen del maestro de clientes
#Autor: JMM
#Fecha: 06-10-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
MANTENIMIENTO DE CLIENTES

 Cliente:_20_________________ _60___________________________ @@@ 
 Tipo:   _5___  _40_________________  NIF: _30___________
 ������������������������������������������ ENVIO ������������������������������������������
 � Direcci�n: _40___________________________  _40___________________________               �
 �            _40___________________________  _40___________________________               �
 � Poblaci�n: _40_________________ DP: _10____        Provincia: _5_ _40__________________ �
 � Pa�s: _5_ _30_________________  Contacto: _40_____________________________________      �
 � Tel�fono: _12_______            Fax: _12______     Email: _40__________________________ �
 �������������������������������������������������������������������������������������������
 ���������������������������������������� FACTURA ������������������������������������������
 � FACTURA _                                                                               � 
 � Cliente Fact: _20_________________ _60____________________________ NIF: _30___________  �
 � Direcci�n: _40___________________________  _40___________________________               �
 �            _40___________________________  _40___________________________               �
 � Poblaci�n: _40_________________ DP: _10____        Provincia: _5_ _40__________________ �
 � Pa�s: _5_ _30_________________  Contacto: _40_____________________________________      �
 � Tel�fono: _12_______            Fax: _12______     Email: _40__________________________ �
 � Serie: _7_____  Forma Pago: ____ _40_____________________________________               �
 �                                                                                         �
 �������������������������������������������������������������������������������������������
| 

TABLA=VDCLIENTES

NOINSERT                                 
NODELETE
NOUPDATE

POSX=10
POSY=2

CAMPO=CODCLIENTE,TOOLTIP("C�digo de cliente."),POSTCHANGE=FVALNOCERO("EL CAMPO C�digo DE CLIENTE\nNO PUEDE ESTAR VACIO")
CAMPO=DESCLIENTE,UPPER,TOOLTIP("Nombre del cliente."),POSTCHANGE=FVALNOCERO("EL CAMPO DESCRIPCION DEL CLIENTE\nNO PUEDE ESTAR VACIO")
CAMPO=SEQCODCLI,TOOLTIP("Secuencial del C�digo de Cliente, para los casos de m�ltiples direcciones para el cliente.")
CAMPO=TIPOCLI,TOOLTIP("Tipo de cliente sobre una clasificaci�n."),POSTCHANGE=FDESIGNACION("CDESTIPOCLI","EL CAMPO TIPO DE CLIENTE DEBE DE EXISTIR",FPOSICIONACAMPO(FSUCCESS,"SEQCODCLI"),"")
CAMPO=DESCTIPOCLI,UPPER,AUXILIAR,NOENTER
CAMPO=NIF,UPPER,TOOLTIP("NIF/CIF del cliente.")
CAMPO=DIRECCION,TOOLTIP("Es la direcci�n del cliente o direcci�n destino del pedido. Se recibe en el interfase con el Host. Est� descompuesta en cuatro campos de 40 caracteres")
CAMPO=DIRECCION1,TOOLTIP("L�nea 2 de la direcci�n de envio del pedido")
CAMPO=DIRECCION2,TOOLTIP("L�nea 3 de la direcci�n de envio del pedido")
CAMPO=DIRECCION3,TOOLTIP("L�nea 4 de la direcci�n de envio del pedido")
CAMPO=POBLACION,TOOLTIP("Poblaci�n destino del pedido. Recibido del HOST")
CAMPO=DP,TOOLTIP("Distrito postal de la direcci�n de envio. Recibido de la interfase")
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de envio. Recibido del HOST"),POSTCHANGE=FDESIGNACION("+CSELDESPROVDEST","")
CAMPO=DESPROVDEST,AUXILIAR,NOENTER
CAMPO=CODPAIS,TOOLTIP("Pa�s de env�o"),POSTCHANGE=FDESIGNACION("+CSELPAISDEST","")
CAMPO=DESPAISDEST,AUXILIAR,NOENTER
CAMPO=CONTACTO,TOOLTIP("Dato recibido en el interfase, de libre introducci�n. Es el posible contacto con el cliente")
CAMPO=TELEFONO,TOOLTIP("Tel�fono correspondiente a direcci�n de envio. Recibido del HOST")
CAMPO=FAX,TOOLTIP("N�mero de fax del cliente")
CAMPO=EMAIL,TOOLTIP("Direccion email correspondiente a direcci�n de envio. Recibido del HOST")

CAMPO=SWTFACTU,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores de facturaci�n son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N', si el pedido tiene direcci�n de facturaci�n")
CAMPO=CODCLIFACTU,TOOLTIP("C�digo del cliente de la direcci�n de facturaci�n")
CAMPO=DESCLIFACTU,TOOLTIP("Descripci�n del cliente de facturaci�n")
CAMPO=NIFFACTU,TOOLTIP("NIF del cliente de direcci�n de facturaci�n")
CAMPO=DIRFACTU,TOOLTIP("Es la direcci�n de facturacion del pedido. Esta descompuesta en cuatro campos de 40 caracteres.")
CAMPO=DIRFACTU1,TOOLTIP("L�nea 2 de la direccion de facturacion del pedido")
CAMPO=DIRFACTU2,TOOLTIP("L�nea 3 de la direccion de facturacion del pedido")
CAMPO=DIRFACTU3,TOOLTIP("L�nea 4 de la direccion de facturacion del pedido")
CAMPO=POBFACTU,TOOLTIP("Poblaci�n de facturaci�n del pedido. Recibido del HOST")
CAMPO=DPFACTU,TOOLTIP("Distrito postal de la direcci�n de facturaci�n. Recibido de la interfase")
CAMPO=CODPROVFACTU,TOOLTIP("C�digo de la provincia de facturaci�n. Recibido del HOST"),POSTCHANGE=FDESIGNACION("+CSELDESPROVFACT","")
CAMPO=DESPROVFACTU,AUXILIAR,NOENTER
CAMPO=CODPAISFACTU,TOOLTIP("Pa�s de facturaci�n"),POSTCHANGE=FDESIGNACION("+CSELPAISFACT","")
CAMPO=DESPAISFACT,AUXILIAR,NOENTER
CAMPO=CONTAFACTU,TOOLTIP("Contacto de facturaci�n")
CAMPO=TELFACTU,TOOLTIP("Telefono correspondiente a direccion de facturacion.")
CAMPO=FAXFACTU,TOOLTIP("Fax correspondiente a direccion de facturacion.")
CAMPO=EMAILFACTU,TOOLTIP("Email correspondiente a direccion de facturaci�n.")
CAMPO=SERIEFACTURA,TOOLTIP("Serie de facturaci�n aplicable a los pedidos del cliente.")
CAMPO=TIPOFORMAPAGO,TOOLTIP("Tipo de Forma de pago. Determina la forma en la que el cliente realizar� el pago de sus pedidos."),POSTCHANGE=FDESIGNACION("+CSELDESTIPOPAGO","")
CAMPO=DESCTIPOFORMAPAGO,AUXILIAR,NOENTER

CURSOR=CDESTIPOCLI SELECT DESCTIPOCLI 
                     FROM VDTIPOCLIENTE 
                    WHERE TIPOCLI=:TIPOCLI;

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

CURSOR=CSELDESTIPOPAGO SELECT DESCTIPOFORMAPAGO FROM VDTIPOFORMAPAGO WHERE TIPOFORMAPAGO =:TIPOFORMAPAGO;

AYUDA=MANTENIMIENTO DE CLIENTES
ONLINE=     {F1} Ayuda {F2} Consulta {F5} Borrar pantalla {Esc} Salir;