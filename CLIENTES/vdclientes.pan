#####
# VDCLIENTES.PAN
#                                                    
# Prop�sito: Mantenimiento de la tabla de clientes                          
#                                                                              
# Autor  : JMM                                                           
# Fecha  : 06-10-2008                                                          
#####
#  Modificaciones:
#  DFL 29/01/2020: AJUSTAR PORQUE EL ESTANDAR NO FUNCIONA BIEN
#                  * A�ADIR CODDIV-DESDIV
#                  * INCLUIR DATOS POR DEFECTO OBLIGATORIOS
#
#####
MANTENIMIENTO DE CLIENTES
 Divisi�n:_20___  _40_______________________________   
 Cliente: _20_________________ _60__________________ @@@@@ Tipo: _5___  NIF: _30___________
 
 ������������������������������������������ ENVIO ������������������������������������������
 �                                                                                         �
 � Direcci�n: _40___________________________  _40___________________________               �
 �                                                                                         �
 �            _40___________________________  _40___________________________               �
 �                                                                                         �
 � Poblaci�n: _40_________________ DP: _10____        Provincia: _5_ _40__________________ �
 �                                                                                         �
 � Pa�s: _5_ _30_________________  Contacto: _40_____________________________________      �
 �                                                                                         �
 � Tel�fono: _12_______            Fax: _12______     Email: _40__________________________ �
 �                                                                                         �
 �������������������������������������������������������������������������������������������
 ���������������������������������������� FACTURA ������������������������������������������
 � FACTURA _                                                                               �
 � Cliente Fact: _20_________________ _60____________________________ NIF: _30___________  �
 �                                                                                         �
 � Direcci�n: _40___________________________  _40___________________________               �
 �                                                                                         �
 �            _40___________________________  _40___________________________               �
 �                                                                                         �
 � Poblaci�n: _40_________________ DP: _10____        Provincia: _5_ _40__________________ �
 �                                                                                         �
 � Pa�s: _5_ _30_________________  Contacto: _40_____________________________________      �
 �                                                                                         �
 � Tel�fono: _12_______            Fax: _12______     Email: _40__________________________ �
 �                                                                                         �
 � Serie: _7_____  Forma Pago: ____ _40_____________________________________               �
 �                                                                                         �
 �������������������������������������������������������������������������������������������
 
 Tipo Pedido: ___   Prioridad: @@ Urgencia: @@ Idioma Etiq.: __________ Idioma doc.: __________
 
 Descuento Cab: ###,## Descuento l�nea: ###,##  Recargo Cab: ###,## Recargo l�nea:###,## IVA: ###,## 
 
 N�Albaranes: @@@   Preparaci�n: _     Anular Precintos: _  Valorado: _  Totales: _   Proforma: _ 
 
 Agrupar: _ Paletizar: _    Modelo: _  Ref.Modelo: _80___   Bloq Dev. _ Scan _ Admite dev _
 
 Portes: _  Seguro: _ Tipo _ Base #L###.###       EDI: _     Reembolso: _ Aduana: _ Activo _
 
 Agencia: _10_______  _30_________________________ Recargo Agen.: ######.##  % Verificacion: @@@@@

 Observaciones: _256_________________________________________________________________________________ 
 
 Ultima modificaci�n: _32________________ �D-MM-YY.Y ________

|

TABLA=VDCLIENTES

PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION",
                   "+CSELINI","",
                   "CVERIFCODAGE","LA AGENCIA :CODAGE NO EXISTE O NO HA SIDO INFORMADA")

PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION",
                   "+CSELINI","",
                   "CVERIFCODAGE","LA AGENCIA :CODAGE NO EXISTE O NO HA SIDO INFORMADA")

CAMPO=CODDIV,TOOLTIP("Division o compa�ia del pedido"),POSTCHANGE=FDESIGNACION("+CDESDIV","C�digo de divisi�n no existe."),COMBOX("CLISTADIV"),WLONX=10
CAMPO=DESDIV,AUXILIAR,NOENTER,TITULO("Descripci�n") ,CONTEXTUAL=FEJECUTAFORM("VDSELDIVIS","N","","","CODDIV=:CODDIV","Selecci�n de divisi�n","S"), WHERE=CODDIV IN (SELECT CODDIV FROM VDDIVIS WHERE DESDIV LIKE '%'||:DESDIV||'%');
CAMPO=CODCLIENTE,TOOLTIP("Es el C�digo de cliente que realiza el pedido, recibido por el fichero de interfase con el Host")
CAMPO=DESCLIENTE,TOOLTIP("Designaci�n completa del cliente que realiza el pedido. Tambi�n recibido en el interfase")
CAMPO=SEQCODCLI,TOOLTIP("Secuencial de cliente para el caso en el que tenga m�s de una direccion")
CAMPO=TIPOCLI,TOOLTIP("Tipo de cliente")
CAMPO=NIF,TOOLTIP("Nif del cliente")
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

CAMPO=SWTFACTU,UPPER,POSTCHANGE=FVERIFICA("SN ","Los posibles valores de facturaci�n son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N', si el pedido tiene direcci�n de facturaci�n")
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
CAMPO=TIPOFORMAPAGO,TOOLTIP("Tipo de Forma de pago. Determina la forma en la que el cliente realizar� el pago de sus pedidos.")
CAMPO=DESCTIPOFORMAPAGO,AUXILIAR,NOENTER
CAMPO=TIPOPEDIDO,TOOLTIP("Identifica el tipo del pedido seg�n criterio de la compa��a. Es recibido del Host y tal como se recibe se introduce en la Base de datos. Tiene utilidad para establecer restricciones a la hora de crear series de pedidos.")
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de asignaci�n de stock al pedido 0 M�xima 99 M�nima")
CAMPO=URGENCIA,TOOLTIP("Urgencia del pedido 0 M�xima 99 M�nima")
CAMPO=IDIOMAETIQ,TOOLTIP("Idioma de las etiquetas de envio")
CAMPO=IDIOMADOC,TOOLTIP("Idioma de la documentaci�n de envio")
CAMPO=DESCUENTOCAB,TOOLTIP("Indica el porcentaje de descuento global que se aplicar� pedido")
CAMPO=DESCUENTOLIN,TOOLTIP("Indica el porcentaje de descuento que se aplicar� a las l�neas del pedido")
CAMPO=RECARGOCAB,TOOLTIP("Indica el porcentaje de recargo a nivel global que se aplicar� al pedido")
CAMPO=RECARGOLIN,TOOLTIP("Indica el porcentaje de recargo que se aplicar� a las l�neas del pedido")
CAMPO=IVA,TOOLTIP("Porcentaje de IVA sobre el producto")
CAMPO=NUMALBA,TOOLTIP("N�mero de albaranes a imprimir autom�ticamente en verificaci�n")
CAMPO=BACKORDER,TOOLTIP("Indicador recibido del host, que puede tomar los siguientes valores: 'T' todas las l�neas \ndel pedido deben servirse en su totalidad(estricto), 'L' todas las l�neas deben servirse pero si una l�nea est� servida \no no depende de la pol�tica de la l�nea, 'P' el pedido puede servirse parcialmente ")
CAMPO=SWTANULAR,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("Indica si deben anularse los precintos de la seguridad social")
CAMPO=SWTVALORADO,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("Puede tomar los valores de: S, si el pedido debe llevar albar�n valorado. N para lo contrario")
CAMPO=SWTTOTALES,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("S imprimir albar�n valorado con impuestos y totales, N Albar�n s�lo con l�neas valoradas")
CAMPO=SWTPROFORMA,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: de 'S' para imprimir una factura proforma que acompa�e al pedido (esta factura se a�adir� en el momento de impresi�n de la documentaci�n de env�o de las agencias). 'N' para no incluir ninguna factura")
CAMPO=SWTAGRUPAR,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("Sus posibles valores son 'S' o 'N' en funci�n de si el pedido puede ser agrupado con otros pedidos del mismo cliente, agencia y destino, con el fin de ser facturado por la agencia como un �nico albar�n. Nota: Se agrupar�n pedidos incluso de diferentes divisiones y empresas")
CAMPO=SWTPALETIZAR,UPPER,POSTCHANGE=FVERIFICA("SN ","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que el pedido se debe paletizar o 'N' no se debe paletizar.")
CAMPO=SWTMODELO,POSTCHANGE=FVERIFICA(" SN","El indicador puede tomar dos valores: S(i) o N(o)"),TOOLTIP("S El pedido ha de llevar documentaci�n adicional, N no la lleva")
CAMPO=REFMODELO,TOOLTIP("Referencia de la documentaci�n adicional")
CAMPO=SWTBLOQDEV,POSTCHANGE=FVERIFICA(" SN","Debe introducir S(i) o N(o)")
CAMPO=SWTBLOQSCAN,POSTCHANGE=FVERIFICA(" SN","Debe introducir S(i) o N(o)")
CAMPO=ADMITEDEF,POSTCHANGE=FVERIFICA(" SN","Debe introducir S(i) o N(o)")
CAMPO=PORTES,TOOLTIP("D debidos P pagados F franco"),POSTCHANGE=FVERIFICA("DPF ","Los posibles valores son 'D' Debidos, 'P' Pagados, 'F' Francos")
CAMPO=SWTSEGURO,POSTCHANGE=FVERIFICA("FPDN ","Los posibles valores son F(actura), P(agado), D(ebido) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva seguro y se factura, 'P', seguro pagado, 'D', seguro debido o 'N', el pedido no lleva seguro. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=TIPOBASESEGURO,UPPER,POSTCHANGE=FVERIFICA(" SPF","Los posibles valores son\nBlanco\n S(tandard) Importe total del pedido * Porseguro\n P(ortes) Portes del pedido * Porseguro\n F(ijo) Cantidad fija indicada en base"),TOOLTIP("Los posibles valores son\n S(tandard) Importe total del pedido * %seguro\n P(ortes) Portes del pedido * %seguro|n F(ijo) Cantidad fija indicada en base. Utilizado informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=BASESEGURO,UPPER,TOOLTIP("Base del seguro si es % y va a 0 se toma el indicada en la tarifa de la agencia. Utilizado informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=SWTEDI,UPPER,POSTCHANGE=FVERIFICA(" SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que se debe enviar interfase EDI al cliente o 'N' no se debe enviar intefase EDI.")
CAMPO=SWTREEMBOLSO,UPPER,POSTCHANGE=FVERIFICA("FPDN ","Los posibles valores son F(actura), P(agado), D(ebido) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva reembolso y se factura, 'P', reembolso pagado, 'D', reembolso debido o 'N', el pedido no lleva reembolso. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=SWTADUANA,UPPER,POSTCHANGE=FVERIFICA("SN ","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'S', el pedido lleva documentaci�n de la aduana o 'N', el pedido no lleva doumentaci�n de la aduana. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=ACTIVO
CAMPO=CODAGE,POSTCHANGE=FDESIGNACION("+CDESAGE","C�digo de agencia no existe."),TOOLTIP("Es el C�digo de la agencia que transportar� el pedido. Deber� existir en la tabla de agencias. A su derecha aparece el tipo de la agencia, N=normal, F=fr�o o A=ambos y el nombre completo de la misma. El tipo de agencia debe ser compatible con los art�culos del pedido, en caso contrario el programa de carga de la interfase del HOST lo dejar� en estado erroneo: ERROR ASIGNANDO AGENCIA")
CAMPO=DESAGE,NOENTER,AUXILIAR,TOOLTIP("Nombre completo de la agencia")
CAMPO=RECARGOAGE,TOOLTIP("Cantidad adicional a pagar a la agencia. Utilizado para la autofacturaci�n de agencias")
CAMPO=TPCVERIF
CAMPO=OBSERVACIONES,TOOLTIP("observaciones al cliente")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")

CURSOR=CVERIFCODAGE SELECT :CODAGE FROM VDAGENCIA WHERE CODAGE=:CODAGE
                     UNION 
                   SELECT :CODAGE FROM DUAL WHERE :CODAGE IS NULL;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CDESAGE SELECT DESAGE
                 FROM VDAGENCIA
                WHERE CODAGE=:CODAGE;

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

CURSOR=CINICIALIZA SELECT '' TIPOPEDIDO, 'ESP' IDIOMAETIQ, 'ESP' IDIOMADOC, 'S' SWTVALORADO, 1 NUMALBA, 'S' SWTTOTALES,
                          'N' SWTPROFORMA, 'P' INDPORTES, 'N' SWTANULAR, 'N' SWTPALETIZAR, 
                          'N' SWTAGRUPAR, 50 PRIORIDAD, 50 URGENCIA, 'N' SWTMODELO, '' REFMODELO,
                          DECODE(:CODPAIS,NULL,'034',:CODPAIS) CODPAIS, 
                          DECODE(:CODPAISFACTU,NULL,'034',:CODPAISFACTU) CODPAISFACTU,
                          'T' BACKORDER, 'N' SWTFACTU, 'N' SWTSEGURO, 'N' SWTEDI, 'N' SWTREEMBOLSO, 'N' SWTADUANA
                          FROM DUAL;

CURSOR=CDESDIV SELECT DESDIV FROM VDDIVIS WHERE CODDIV=:CODDIV;

CURSOR=CLISTADIV SELECT CODDIV,DESDIV,DESEMP FROM VDDIVIS DIV,VDEMPRE EMP WHERE EMP.CODEMP=DIV.CODEMP AND DIV.SWTACTIVA='S' ORDER BY CODDIV;

CURSOR=CSELINI SELECT NVL(:SWTFACTU,'N') SWTFACTU, NVL(:SWTPALETIZAR,'N') SWTPALETIZAR, NVL(:SWTADUANA,'N') SWTADUANA FROM DUAL;
				
CONTEXTUAL=FLEEMENU("VDCLIENTES.ZOO")

TECLA=F7,FDESIGNACION("CINICIALIZA","ERROR INICIALIZANDO DATOS")

AYUDA=MANTENIMIENTO DE CLIENTES
ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F5} Borrar pantalla
              {F9} Borrar registro {Ctrl-F7} Copia {Esc} Salir;

