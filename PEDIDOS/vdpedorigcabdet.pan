###################################################################
#M�dulo: VDPEDCAB.PAN
#Funcionalidad : Mantenimiento de cabecera de pedidos
#Autor: RFD      
#Fecha: 24-03-2008
###################################################################
# Hist�rico de cambios:
DATOS DE ENTREGA, REEXPEDICION Y FACTURACION DEL PEDIDO ORIGINAL
 
  Pedido:  _20_________ Divisi�n: _20__  _40______________  A�o:  @@@@  
 
 ��� Entrega ����������������������������������������������������������������������������������������������������������
 �                                                                                                                    � 
 �  Cliente: _20_______  _60__________________________________________________ NIF: _30____________                   �
 �  Contacto:   _40_________________  Tel�fono: ____________ Fax: _12_________ e-mail: _40___________________________ �
 �  Dire. EDI:  _40__________________________________                                                                 �
 �  Direcci�n:  _40________________________________  Direcci�n1: _40________________________________                  �
 �  Direcci�n2: _40________________________________  Direcci�n3: _40________________________________                  �
 �  Poblaci�n:  _40_________________  Pa�s: ____ _30_____________  CP: _____ _40____________ DP: __________           �
 �                                                                                                                    �
 ����������������������������������������������������������������������������������������������������������������������
 
 ���  Reexpedici�n ����������������������������������������������������������������������������������������������������
 �                                                                                                                    �
 �  SWTReexpedici�n: _ Cliente: _20_______  _60________________________________ NIF: _30____________                  �
 �  Contacto:  _40_________________  Tel�fono: ____________  Fax: _12_________ e-mail: _40___________________________ �
 �  Dire. EDI:  _40________________________________                                                                   �
 �  Direcci�n:  _40________________________________  Direcci�n1: _40________________________________                  �
 �  Direcci�n2: _40________________________________  Direcci�n3: _40________________________________                  �
 �  Poblaci�n:  _40_________________  Pa�s: ____ _30_____________  CP: _____ _40____________ DP: __________           �
 �                                                                                                                    �
 ���������������������������������������������������������������������������������������������������������������������� 
 
 ���  Facturaci�n �����������������������������������������������������������������������������������������������������  
 �                                                                                                                    � 
 �  SWTFacturaci�n: _ Cliente: _20_______  _60_________________________________ NIF: _30____________                  �
 �  Contacto:  _40_________________  Tel�fono: ____________  Fax: _12_________ e-mail: _40___________________________ �
 �  Dire. EDI:  _40________________________________                                                                   �
 �  Direcci�n:  _40________________________________  Direcci�n1: _40________________________________                  �
 �  Direcci�n2: _40________________________________  Direcci�n3: _40________________________________                  �
 �  Poblaci�n:  _40_________________  Pa�s: ____ _30_____________  CP: _____ _40____________ DP: ___________          �
 �                                                                                                                    �
 ���������������������������������������������������������������������������������������������������������������������� 
 
 Estado: @@@@@ _30___________________________    Ultima modificaci�n: _32_______  �D-MM-Y.YYY  ________

|


TABLA=VDPEDIDORIGCAB


PREINSERT=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=CODPED,TOOLTIP("C�digo del pedido")
CAMPO=CODDIV,TOOLTIP("Division o compa�ia del pedido"),POSTCHANGE=FDESIGNACION("CDESDIV","C�digo de divisi�n no existe.")
CAMPO=DESDIV,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la divisi�n o compa��a del pedido")
CAMPO=ANOPED,TOOLTIP("A�o del pedido")

CAMPO=CODCLIENTE,TOOLTIP("Es el C�digo de cliente que realiza el pedido, recibido por el fichero de interfase con el Host.")
CAMPO=DESCLIENTE,TOOLTIP("Designaci�n completa del cliente que realiza el pedido. Tambi�n recibido en el interfase.")
CAMPO=NIF,TOOLTIP("NIF del cliente")
CAMPO=CONTACTO,TOOLTIP("Dato recibido en el interfase, de libre introducci�n. Es el posible contacto con el cliente.")
CAMPO=TELEFONO,TOOLTIP("Telefono correspondiente a direccion de envio. Recibido del HOST")
CAMPO=FAX,TOOLTIP("Fax correspondiente a direccion de envio. Recibido del HOST")
CAMPO=EMAIL,TOOLTIP("e-mail correspondiente a direccion de envio. Recibido del HOST")
CAMPO=DIRECCIONEDI,TOOLTIP("Direcci�n EDI correspondiente a direccion de envio. Recibido del HOST")
CAMPO=DIRECCION,TOOLTIP("Es la direcci�n del cliente o direcci�n destino del pedido. Se recibe en el interfase con el Host. Esta descompuesta en cuatro campos de 40 caracteres.")
CAMPO=DIRECCION1,TOOLTIP("L�nea 2 de la direccion de envio del pedido")
CAMPO=DIRECCION2,TOOLTIP("L�nea 3 de la direccion de envio del pedido")
CAMPO=DIRECCION3,TOOLTIP("L�nea 4 de la direccion de envio del pedido")
CAMPO=POBLACION,TOOLTIP("Poblacion destino del pedido. Recibido del HOST")
CAMPO=CODPAIS,TOOLTIP("Pais de envio"),POSTCHANGE=FDESIGNACION("CDESPAIS","Pa�s no existe.")
CAMPO=DESPAIS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del pa�s de envio")
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de envio. Recibido del HOST."),POSTCHANGE=FDESIGNACION("CDESPROV","C�digo de provincia no existe.")
CAMPO=DESPROV,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la provincia de envio")
CAMPO=DP,TOOLTIP("Distrito postal de la direccion de envio. Recibido de la interfase.")

CAMPO=SWTREEXP,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores de reexpedici�n son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N', si el pedido ha de reexpedirse una vez en el cliente")
CAMPO=CODCLIREEXP,TOOLTIP("C�digo del cliente de reexpedici�n")
CAMPO=DESCLIREEXP,TOOLTIP("Caso de reexpedirse el pedido, contiene el nombre del destinatario de la reexpedici�n")
CAMPO=NIFREEXP,TOOLTIP("NIF del cliente de reexpedici�n")
CAMPO=CONTAREEXP,TOOLTIP("Contacto que figura en albar�n si hay reexpedici�n")
CAMPO=TELREEXP,TOOLTIP("Tel�fono que figura en albar�n si hay reexpedici�n")
CAMPO=FAXREEXP,TOOLTIP("Fax correspondiente a direccion de reexpedici�n. Recibido del HOST")
CAMPO=EMAILREEXP,TOOLTIP("email correspondiente a direccion de reexpedici�n. Recibido del HOST")
CAMPO=DIRECCIONEDIREEXP,TOOLTIP("Direcci�n EDI correspondiente a direccion de reexpedici�n. Recibido del HOST")
CAMPO=DIRREEXP,TOOLTIP("Es la direcci�n de la reexpedici�n. En cuatro campos")
CAMPO=DIRREEXP1,TOOLTIP("L�nea 2 de la direcci�n que figura en albar�n si hay reexpedici�n")
CAMPO=DIRREEXP2,TOOLTIP("L�nea 3 de la direcci�n que figura en albar�n si hay reexpedici�n")
CAMPO=DIRREEXP3,TOOLTIP("L�nea 4 de la direcci�n que figura en albar�n si hay reexpedici�n")
CAMPO=POBREEXP,TOOLTIP("Poblaci�n que figura en albar�n si hay reexpedici�n")
CAMPO=CODPAISREEXP,TOOLTIP("Pa�s que figura en albar�n si hay reexpedici�n"),POSTCHANGE=FDESIGNACION("CDESPAISREEXP","Pa�s no existe.")
CAMPO=DESPAISREEXP,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del pa�s de reexpedici�n")
CAMPO=CODPROVREEXP,TOOLTIP("C�digo de provincia que figura en albar�n si hay reexpedici�n"),POSTCHANGE=FDESIGNACION("CDESPROVREEXP","C�digo de provincia no existe.")
CAMPO=DESPROVREEXP,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la provincia de reexpedici�n")
CAMPO=DPREEXP,TOOLTIP("Distrito postal que figura en albar�n si hay reexpedici�n")

CAMPO=SWTFACTU,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores de facturaci�n son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N', si el pedido tiene direcci�n de facturaci�n")
CAMPO=CODCLIFACTU,TOOLTIP("C�digo del cliente de la direcci�n de facturaci�n")
CAMPO=DESCLIFACTU,TOOLTIP("Destinatario de la direcci�n de facturaci�n")
CAMPO=NIFFACTU,TOOLTIP("NIF del cliente de direcci�n de facturaci�n")
CAMPO=CONTAFACTU,TOOLTIP("Contacto de la direcci�n de facturaci�n")
CAMPO=TELFACTU,TOOLTIP("Tel�fono de la direcci�n de facturaci�n")
CAMPO=FAXFACTU,TOOLTIP("Fax correspondiente a direccion de facturaci�n. Recibido del HOST")
CAMPO=EMAILFACTU,TOOLTIP("email correspondiente a direccion de facturaci�n. Recibido del HOST")
CAMPO=DIRECCIONEDIFACTU,TOOLTIP("Direcci�n EDI correspondiente a direccion de facturaci�n. Recibido del HOST")
CAMPO=DIRFACTU,TOOLTIP("Es la direcci�n de la facturaci�n. En cuatro campos")
CAMPO=DIRFACTU1,TOOLTIP("L�nea 2 de la direcci�n de facturaci�n")
CAMPO=DIRFACTU2,TOOLTIP("L�nea 3 de la direcci�n de facturaci�n")
CAMPO=DIRFACTU3,TOOLTIP("L�nea 4 de la direcci�n de facturaci�n")
CAMPO=POBFACTU,TOOLTIP("Poblaci�n de la direcci�n de facturaci�n")
CAMPO=CODPAISFACTU,TOOLTIP("Pa�s de la direcci�n de facturaci�n"),POSTCHANGE=FDESIGNACION("CDESPAISFACTU","Pa�s no existe.")
CAMPO=DESPAISFACTU,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del pa�s de facturaci�n")
CAMPO=CODPROVFACTU,TOOLTIP("C�digo de provincia de la direcci�n de facturaci�n"),POSTCHANGE=FDESIGNACION("CDESPROVFACTU","C�digo de provincia no existe.")
CAMPO=DESPROVFACTU,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la provincia de facturaci�n")
CAMPO=DPFACTU,TOOLTIP("Distrito postal de la direcci�n de facturaci�n")
CAMPO=STATUS,TOOLTIP("Es el estado en que se encuentra el pedido en el momento de la consulta."),POSTCHANGE=FDESIGNACION("CDESSTATUS","Estado incorrecto."),COMBOX("CLISTASTATUS"),COMBOXREGPAG=6
CAMPO=DESSTATUS,AUXILIAR,NOENTER,TOOLTIP("Descripci�n del estado en el que se encuentra el pedido")

CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificacion")

CAMPO=ALBARAN,AUXILIAR,OCULTO,"_20_"
CAMPO=RUTA,AUXILIAR,OCULTO,"_256_"

CURSOR=CLISTASTATUS SELECT STATUS,DESSTATUS,TIPOSTATUS FROM VDSTATUS WHERE TIPOSTATUS='PEC' ORDER BY STATUS;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESPROV SELECT DESPROV
                  FROM VDPROVI
                 WHERE CODPROV=:CODPROV AND CODPAIS=:CODPAIS
                 UNION ALL
                 SELECT '' DESPROV
                 FROM DUAL WHERE :CODPROV IS NULL;
CURSOR=CDESPROVREEXP SELECT DESPROV DESPROVREEXP
                  FROM VDPROVI
                 WHERE CODPROV=:CODPROVREEXP AND CODPAIS=:CODPAISREEXP
                 UNION ALL
                 SELECT '' DESPROVREEXP
                 FROM DUAL WHERE :CODPROVREEXP IS NULL;
CURSOR=CDESPROVFACTU SELECT DESPROV DESPROVFACTU
                  FROM VDPROVI
                 WHERE CODPROV=:CODPROVFACTU AND CODPAIS=:CODPAISFACTU
                 UNION ALL
                 SELECT '' DESPROVFACTU
                 FROM DUAL WHERE :CODPROVFACTU IS NULL;

CURSOR=CDESPAIS SELECT DESPAIS FROM VDPAIS WHERE CODPAIS=:CODPAIS 
                     UNION ALL
                     SELECT '' DESPAIS  FROM DUAL WHERE :CODPAIS IS NULL;
CURSOR=CDESPAISREEXP SELECT DESPAIS DESPAISREEXP FROM VDPAIS WHERE CODPAIS=:CODPAISREEXP 
                     UNION ALL
                     SELECT '' DESPAISREEXP  FROM DUAL WHERE :CODPAISREEXP IS NULL;
CURSOR=CDESPAISFACTU SELECT DESPAIS DESPAISFACTU FROM VDPAIS WHERE CODPAIS=:CODPAISFACTU
                     UNION ALL
                     SELECT '' DESPAISFACTU  FROM DUAL WHERE :CODPAISFACTU IS NULL;

CURSOR=CDESDIV SELECT DESDIV
                 FROM VDDIVIS
                WHERE CODDIV=:CODDIV;
CURSOR=CDESAGE SELECT DESAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE
                UNION
               SELECT '' DESAGE FROM VDAGENCIA WHERE :CODAGE IS NULL;

CURSOR=CDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';

#Se selecciona as� el albar�n hasta que el sufijodoc se incluya en vdpedidocaborig y se pueda cargar por interfase
CURSOR=CSELALBARAN SELECT CASE WHEN :TIPOPEDIDO IN ('VP', 'P2') THEN
                                    '$(VDALBARAN)'
                               WHEN :TIPOPEDIDO ='PX' THEN
                                    'ALBARAN DE ENVIO POR CANJE'
                               WHEN :TIPOPEDIDO ='PA' THEN
                                    'ALBARAN DE ENVIO ALMACENES PULMON'
                          END ALBARAN, 'C:\ALBARAN_'||:CODPED||'.PDF' RUTA
                     FROM DUAL
                     WHERE :TIPOPEDIDO IN ('VP', 'P2','PX','PA');


TECLA=F10,FEJECUTA("CSELALBARAN", "ERROR OBTENIENDO EL ALBARAN",
                   FIMPRIMEPEDIDO("INFORME",":CODDIV",":ANOPED",":CODPED",":SEQPED",":ALBARAN","FORMCODDIV=:CODDIV;FORMANOPED=:ANOPED;FORMCODPED=:CODPED;FORMSEQPED=:SEQPED",""),":V10ERROR")

TECLA=F11,FEJECUTA("CSELALBARAN", "ERROR OBTENIENDO EL ALBARAN",
                   FEXPORTAPEDIDO("INFORME",":CODDIV",":ANOPED",":CODPED",":SEQPED",":ALBARAN","FORMCODDIV=:CODDIV;FORMANOPED=:ANOPED;FORMCODPED=:CODPED;FORMSEQPED=:SEQPED",":RUTA","1"),":V10ERROR")


