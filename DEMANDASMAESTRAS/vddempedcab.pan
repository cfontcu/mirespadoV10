###################################################################
#M�dulo: VDDEMPEDCAB.PAN
#Funcionalidad : Inserci�n de demanda para pedidos
#Autor: RFD
#Fecha: 13-10-2009
###################################################################
# Hist�rico de cambios:
CREACION DE DEMANDA MAESTRA DE PEDIDOS 
�������������������������������������� DATOS DEL CLIENTE ������������������������������������
�Cliente: _20_________________ _60__________________   Tipo: _5___  NIF: _30___________     �
�������������������������������           ENTREGA           ������������������������������  �
�� Direcci�n: _40___________________________  _40___________________________             �  �
��            _40___________________________  _40___________________________             �  �
�� Poblaci�n: _40_________________ DP: _10____       Pa�s: _5_ _30______________________ �  �
�� Provincia: _5_ _40__________________    Contacto: _40________________________________ �  �
�� Tel�fono:  _12_______          Fax: _12______    Email: _40_________________________  �  �
��                                                                                       �  �
������������������������������������������������������������������������������������������  �
�����������������������������            FACTURA _         �������������������������������  �
�� Cliente Fact: _20_________________ _60____________________________ NIF: _30___________�  �
�� Direcci�n: _40___________________________  _40___________________________             �  �
��            _40___________________________  _40___________________________             �  �
�� Poblaci�n: _40_________________   DP: _10____       Pa�s: _5_ _30_____________________�  �
�� Provincia: _5_ _40__________________    Contacto: _40_________________________________�  �
�� Tel�fono:  _12_______            Fax: _12______    Email: _40________________________ �  �
������������������������������������������������������������������������������������������  �
� Tipo Pedido: ___ Prioridad: @@ Urgencia: @@ Idioma Etiq.: ________                        �
� Idioma doc.: ________  Dcto: ###,##      Recargo: ###,##  N�Albar�n: @@@ Valorado: _      �
� Totales: _ Profor.: _ Modelo: _ Ref. Modelo: _80______________________                    �
� Anul Precintos: _ EDI: _ Backorder: _  Agrupar: _   Paletizar: _                          �
���������������������������������������������������������������������������������������������
Divisi�n: _20__  _40______________     Pedido: _20___________  A�o: @@@@ Secuencia: @@@@  
Pedido Host: _60_____________ Pedido Cliente: _60_____________  Fecha: �D-MM-Y.YYY 
Fec. Servicio: �D-MM-Y.YYY    Mensaje Host:   _255_______________________________________
Datos Agencia:  Agencia: __________ _30______________________     Recargo: ######.##
                Seguro: _     Reembolso: _ 
                Portes: _        Aduana: _ 
                Peso:   #L########.### Kg.      Volumen: #L########.### litros
Demanda: _20______   __________ Estado demanda: @@@@@ _40_______________________
 Estado: @@@@@  _40__________________  Ultima modificaci�n: _32_______  �D-MM-Y.YYY  ________
|

TABLA=VDPEDIDOCAB
NOINSERT,PROTECT("ADMINISTRADOR")
NOUPDATE,PROTECT("ADMINISTRADOR")
NODELETE,PROTECT("ADMINISTRADOR")

POSTQUERY=FEJECUTA("+CINTIPESOYVOL","")

#WHERE=STATUS = VDST.FPECDEMPEDIDO;
WHERE=STATUS = 3600;

PREINSERT=FEJECUTA("CCHECKCODDIV","EL CAMPO DIVISION DEL PEDIDO NO PUEDE SER NULO",
                   "CINITCAMPOS","ERROR INICIALIZANDO CAMPOS",
                   "CCHECKPOBLACION","LA POBLACION DE ENVIO NO PUEDE SER NULA",
                   "CCHECKDP","EL C�digo POSTAL NO PUEDE SER NULO.",
                   "CSELSINCLAVE","ERROR AL OBTENER C�digo DE PEDIDO",
                   "CINSPEDORIG","ERROR INSERTANDO PEDIDO ORIGINAL",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   "CSELDEMANDA","ERROR OBTENIENDO NUEVA DEMANDA",
                   "CINSNUEVADEMANDA","ERROR INSERTANDO DEMANDA",
                   "+CSELDESSTAPEC","ERROR OBTENIENDO DESCRIPCION DE ESTADO",
                   "+CSELSTATUSDEM","ERROR OBTENIENDO ESTADO DEMANDA",
                   "+CSELDESSTADEM","ERROR OBTENIENDO DESCRIPCION DE ESTADO")
                   
PREUPDATE=FEJECUTA("CCHECKPOBLACION","LA POBLACION DE ENVIO NO PUEDE SER NULA",
                   "CCHECKDP","EL C�digo POSTAL NO PUEDE SER NULO.",
                   "+CUPDPESOYVOL","",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

PREDELETE=FEJECUTA("+CDELLINEASPED","")

CAMPO=CODCLIENTE,TOOLTIP("Es el C�digo de cliente que realiza el pedido, recibido por el fichero de interfase con el Host"),POSTCHANGE=FDESIGNACION("+CSELTIPOCLI","",FPOSICIONACAMPO(FSUCCESS,"CODDIV"),"")
CAMPO=DESCLIENTE,TOOLTIP("Designaci�n completa del cliente que realiza el pedido. Tambi�n recibido en el interfase")
CAMPO=TIPOCLI,AUXILIAR,NOENTER,TOOLTIP("Tipo de cliente")
CAMPO=NIF,TOOLTIP("Nif del cliente")
CAMPO=DIRECCION,TOOLTIP("Es la direcci�n del cliente o direcci�n destino del pedido. Se recibe en el interfase con el Host. Est� descompuesta en cuatro campos de 40 caracteres")
CAMPO=DIRECCION1,TOOLTIP("L�nea 2 de la direcci�n de envio del pedido")
CAMPO=DIRECCION2,TOOLTIP("L�nea 3 de la direcci�n de envio del pedido")
CAMPO=DIRECCION3,TOOLTIP("L�nea 4 de la direcci�n de envio del pedido")
CAMPO=POBLACION,TOOLTIP("Poblaci�n destino del pedido. Recibido del HOST")
CAMPO=DP,TOOLTIP("Distrito postal de la direcci�n de envio. Recibido de la interfase")
CAMPO=CODPAIS,TOOLTIP("Pa�s de env�o"),POSTCHANGE=FDESIGNACION("+CSELPAISDEST","")
CAMPO=DESPAISDEST,AUXILIAR,NOENTER
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de envio. Recibido del HOST"),POSTCHANGE=FDESIGNACION("+CSELDESPROVDEST","")
CAMPO=DESPROVDEST,AUXILIAR,NOENTER
CAMPO=CONTACTO,TOOLTIP("Dato recibido en el interfase, de libre introducci�n. Es el posible contacto con el cliente")
CAMPO=TELEFONO,TOOLTIP("Tel�fono correspondiente a direcci�n de envio. Recibido del HOST")
CAMPO=FAX,TOOLTIP("N�mero de fax del cliente")
CAMPO=EMAIL,TOOLTIP("Direccion email correspondiente a direcci�n de envio. Recibido del HOST")

CAMPO=SWTFACTU,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores de facturaci�n son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N', si el pedido tiene direcci�n de facturaci�n"),WPOSX=-272,WPOSY=-2
CAMPO=CODCLIFACTU,TOOLTIP("C�digo del cliente de la direcci�n de facturaci�n")
CAMPO=DESCLIFACTU,TOOLTIP("Descripci�n del cliente de facturaci�n")
CAMPO=NIFFACTU,TOOLTIP("NIF del cliente de direcci�n de facturaci�n")
CAMPO=DIRFACTU,TOOLTIP("Es la direcci�n de facturacion del pedido. Esta descompuesta en cuatro campos de 40 caracteres.")
CAMPO=DIRFACTU1,TOOLTIP("L�nea 2 de la direccion de facturacion del pedido")
CAMPO=DIRFACTU2,TOOLTIP("L�nea 3 de la direccion de facturacion del pedido")
CAMPO=DIRFACTU3,TOOLTIP("L�nea 4 de la direccion de facturacion del pedido")
CAMPO=POBFACTU,TOOLTIP("Poblaci�n de facturaci�n del pedido. Recibido del HOST")
CAMPO=DPFACTU,TOOLTIP("Distrito postal de la direcci�n de facturaci�n. Recibido de la interfase")
CAMPO=CODPAISFACTU,TOOLTIP("Pa�s de facturaci�n"),POSTCHANGE=FDESIGNACION("+CSELPAISFACT","")
CAMPO=DESPAISFACT,AUXILIAR,NOENTER
CAMPO=CODPROVFACTU,TOOLTIP("C�digo de la provincia de facturaci�n. Recibido del HOST"),POSTCHANGE=FDESIGNACION("+CSELDESPROVFACT","")
CAMPO=DESPROVFACTU,AUXILIAR,NOENTER
CAMPO=CONTAFACTU,TOOLTIP("Contacto de facturaci�n")
CAMPO=TELFACTU,TOOLTIP("Telefono correspondiente a direccion de facturacion.")
CAMPO=FAXFACTU,TOOLTIP("Fax correspondiente a direccion de facturacion.")
CAMPO=EMAILFACTU,TOOLTIP("Email correspondiente a direccion de facturaci�n.")

CAMPO=TIPOPEDIDO,TOOLTIP("Identifica el tipo del pedido seg�n criterio de la compa��a. Es recibido del Host y tal como se recibe se introduce en la Base de datos. Tiene utilidad para establecer restricciones a la hora de crear series de pedidos.")
CAMPO=PRIORIDAD,TOOLTIP("Prioridad de asignaci�n de stock al pedido: 0 M�xima 99 M�nima. Tiene prioridad sobre la fecha de servicio")
CAMPO=URGENCIA,TOOLTIP("Urgencia del pedido 0 M�xima 99 M�nima")
CAMPO=IDIOMAETIQ,TOOLTIP("Idioma de las etiquetas de envio")
CAMPO=IDIOMADOC,TOOLTIP("Idioma de la documentaci�n de envio")
CAMPO=DESCUENTO,TOOLTIP("Indica el porcentaje de descuento global que se aplicar� pedido")
CAMPO=DESCUENTOLIN,AUXILIAR,OCULTO,"###,##"
CAMPO=RECARGO,TOOLTIP("Indica el porcentaje de recargo a nivel global que se aplicar� al pedido")
CAMPO=RECARGOLIN,AUXILIAR,OCULTO,"###,##"
CAMPO=IVA,AUXILIAR,OCULTO,"###,##"
CAMPO=NUMALBA,TOOLTIP("N�mero de albaranes a imprimir autom�ticamente en verificaci�n")
CAMPO=SWTVALORADO,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S', si el pedido debe llevar albar�n valorado. 'N' para lo contrario ")
CAMPO=SWTTOTALES,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' imprimir albar�n valorado con impuestos y totales 'N' Albar�n s�lo con l�neas valoradas")
CAMPO=SWTPROFORMA,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: de 'S' para imprimir una factura proforma que acompa�e al pedido (esta factura se a�adir� en el momento de impresi�n de la documentaci�n de env�o de las agencias). 'N' para no incluir ninguna factura")
CAMPO=SWTMODELO,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' el pedido ha de llevar documentaci�n adicional, 'N' no lleva documentaci�n adicional")
CAMPO=REFMODELO,TOOLTIP("Referencia de la documentaci�n adicional")
CAMPO=SWTANULAR,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador con valores: 'S' anular precintos 'N' no anular precintos. Esto es en funci�n de si el pedido debe llevar el precio anulado o no.")
CAMPO=SWTEDI,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que se debe enviar interfase EDI al cliente o 'N' no se debe enviar intefase EDI.")
CAMPO=BACKORDER,TOOLTIP("Indicador recibido del host, que puede tomar los siguientes valores: 'T' todas las l�neas \ndel pedido deben servirse en su totalidad(estricto), 'L' todas las l�neas deben servirse pero si una l�nea est� servida \no no depende de la pol�tica de la l�nea, 'P' el pedido puede servirse parcialmente ")
CAMPO=SWTAGRUPAR,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)."),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' o 'N' en funci�n de si el pedido puede ser agrupado con otros pedidos del mismo cliente, agencia y destino, con el fin de ser facturado por la agencia como un �nico albar�n. Nota: Se agrupar�n pedidos incluso de diferentes divisiones y empresas.")
CAMPO=SWTPALETIZAR,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'S' indica que el pedido se debe paletizar o 'N' no se debe paletizar.")
CAMPO=CODDIV,TOOLTIP("Division o compa�ia del pedido"),POSTCHANGE=FDESIGNACION("CDESDIV","C�digo de divisi�n no existe.")
CAMPO=DESDIV,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la divisi�n o compa��a del pedido")
CAMPO=CODPED,TOOLTIP("C�digo del pedido")
CAMPO=ANOPED,TOOLTIP("A�o del pedido")
CAMPO=SEQPED,TOOLTIP("Versi�n del pedido")
CAMPO=PEDIDOHOST,TOOLTIP("C�digo interno del pedido para el HOST")
CAMPO=PEDIDOCLIENTE,TOOLTIP("C�digo interno del pedido para el cliente")
CAMPO=FECPEDIDOCLIENTE,TOOLTIP("Fecha en la que el cliente realiz� el pedido")
CAMPO=FECSERVICIO,TOOLTIP("Fecha en que est� previsto que se sirva el el pedido, se utiliza para ordenar los pedidos en la pantalla de creaci�n de series")
CAMPO=MENHOST,TOOLTIP("Contiene cualquier mensaje que el Host de la compa��a considere oportuno. Va dirigido al personal de la compa��a, por tanto, es de uso interno y no es impreso en documento alguno.")
CAMPO=CODAGE,TOOLTIP("Es el C�digo de la agencia que transportar� el pedido. Deber� existir en la tabla de agencias"),POSTCHANGE=FDESIGNACION("CDESAGE","Agencia no existe.")
CAMPO=DESAGE,AUXILIAR,NOENTER,TOOLTIP("Descripci�n de la agencia de transporte")
CAMPO=RECARGOAGE,TOOLTIP("Cantidad adicional a pagar a la agencia. Utilizado para la autofacturaci�n de agencias")
CAMPO=SWTSEGURO,UPPER,POSTCHANGE=FVERIFICA("FPDN ","Los posibles valores son F(actura), P(agado), D(ebido) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva seguro y se factura, 'P', seguro pagado, 'D', seguro debido o 'N', el pedido no lleva seguro. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=SWTREEMBOLSO,UPPER,POSTCHANGE=FVERIFICA("FPDN ","Los posibles valores son F(actura), P(agado), D(ebido) y N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'F', el pedido lleva reembolso y se factura, 'P', reembolso pagado, 'D', reembolso debido o 'N', el pedido no lleva reembolso. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=PORTES,UPPER,POSTCHANGE=FVERIFICA("DPF ","Los posibles valores son 'D' Debidos, 'P' Pagados, 'F' Francos"),TOOLTIP("Indicador que puede tomar los siguientes valores: 'D' Debidos, 'P' Pagados, 'F' Francos")
CAMPO=SWTADUANA,UPPER,POSTCHANGE=FVERIFICA("SN","Los posibles valores son S(i) N(o)"),TOOLTIP("Indicador que puede tomar los siguentes valores 'S', el pedido lleva documentaci�n de la aduana o 'N', el pedido no lleva doumentaci�n de la aduana. Utilizado para informar a la agencia y para la autofacturaci�n de agencias")
CAMPO=PESOPEDIDOAUX,AUXILIAR,TOOLTIP("Peso del pedido en Kg.")
CAMPO=PESOPEDIDO,OCULTO,"#L#############"
CAMPO=VOLUMENPEDIDOAUX,AUXILIAR,TOOLTIP("Volumen del pedido en litros.")
CAMPO=VOLUMENPEDIDO,OCULTO,"#L#############"
CAMPO=CODDEMANDA,TOOLTIP("Indica el C�digo de demanda de traslado realizado para reservar la mercanc�a a servir")
CAMPO=TIPODEMANDA,TOOLTIP("Indica el tipo de demanda de traslado realizado para reservar la mercanc�a a servir"),
                  POSTCHANGE=FDESIGNACION("+CSELSTATUSDEM","ERROR OBTENIENDO ESTADO DEMANDA")
CAMPO=STATUSDEM,AUXILIAR,NOENTER,POSTCHANGE=FDESIGNACION("+CSELDESSTADEM","ERROR OBTENIENDO DESCRIPCION DE ESTADO")
CAMPO=DESSTATUSDEM,AUXILIAR,NOENTER
CAMPO=STATUS,POSTCHANGE=FDESIGNACION("+CSELDESSTAPEC","ERROR OBTENIENDO DESCRIPCION DE ESTADO")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificacion")

################################################################################################################

CAMPO=SWTREEXP,OCULTO,"_"
CAMPO=SWTALBEXTERIOR,OCULTO,"_"
CAMPO=SWTALBSELLADO,OCULTO,"_"
CAMPO=SWTCOMUNICAR,OCULTO,"_"
CAMPO=SWTMISCELANEO,OCULTO,"_"
CAMPO=SWTPACKINGLIST,OCULTO,"_"
CAMPO=SWTNOETIQCC,OCULTO,"_"
CAMPO=SWTETIQECI,OCULTO,"_"
CAMPO=SWTBLOQEXP,OCULTO,"_"
CAMPO=SWTMAIL,OCULTO,"_"
CAMPO=SWTFAX,OCULTO,"_"
CAMPO=SWTPREPMONO,OCULTO,"_"
CAMPO=CODAREAEXPED,OCULTO,"_20_"

CAMPO=FECCAPTURA,OCULTO,"@@@@@@@"
CAMPO=HORACAPTURA,OCULTO,"_8_"
CAMPO=FECGRABACION,OCULTO,"@@@@@@@"
CAMPO=HORAGRABACION,OCULTO,"_8_"
CAMPO=FECRECEP,OCULTO,"@@@@@@@"
CAMPO=HORARECEP,OCULTO,"_8_"
CAMPO=ANOGRUP,OCULTO,"@@@@"
CAMPO=CODGRUP,OCULTO,"@@@@@@@@"
CAMPO=CODCOMENAUX,AUXILIAR,OCULTO,"@L@@@@@@@"

CAMPO=ESTADO,AUXILIAR,OCULTO,"#L#"
CAMPO=CUANTOS,AUXILIAR,OCULTO,"@@@@@"


CURSOR=CSELSTATUSDEM SELECT STATUS STATUSDEM FROM VDDEMANDACAB WHERE CODDEMANDA=:CODDEMANDA AND TIPODEMANDA=:TIPODEMANDA;
CURSOR=CSELDESSTADEM SELECT DESSTATUS DESSTATUSDEM FROM VDSTATUS WHERE STATUS=:STATUSDEM AND TIPOSTATUS='DEC';
CURSOR=CSELDESSTAPEC SELECT DESSTATUS  FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='PEC';

CURSOR=CSELDEMANDA SELECT  'DEMPEDIDO' TIPODEMANDA, VDSECDEMANDACAB.NEXTVAL CODDEMANDA FROM DUAL;

CURSOR=CINSNUEVADEMANDA INSERT INTO VDDEMANDACAB( TIPODEMANDA, CODDEMANDA, CLAVEEXT, BACKORDER, PRIORI, 
                                                 STATUS, CODOPEINSERT, 
                                                  FECINSERT, HORAINSERT, FECINI, HORAINI, FECFIN, HORAFIN, FECNEC, 
                                                  VDEXTRA, CODCOMEN, CODOPEMODIF, FECMODIF, HORAMODIF) 
                         (SELECT :TIPODEMANDA TIPODEMANDA,:CODDEMANDA CODDEMANDA, NULL CLAVEEXT,:BACKORDER BACKORDER,50 PRIORI,
                                100  STATUS, VDUSER.GETUSER CODOPEINSERT, VD.FECHASYS FECINSERT, VD.HORASYS HORAINSERT,
                                 NULL FECINI, NULL HORAINI,NULL FECFIN, NULL HORAFIN,VD.FECHASYS FECNEC, NULL VDEXTRA,0 CODCOMEN,VDUSER.GETUSER CODOPEMODIF,
                                 VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL);




CURSOR=CINITCAMPOS SELECT 'N' SWTREEXP, 'N' SWTALBEXTERIOR, 'N' SWTALBSELLADO, 'N' SWTCOMUNICAR, 'N' SWTMISCELANEO,
                          'N' SWTPACKINGLIST, 'N' SWTNOETIQCC, 'N' SWTETIQECI, 'N' SWTBLOQEXP, 'N' SWTMAIL,
                          'N' SWTFAX, 'N' SWTPREPMONO, 'EXPED' CODAREAEXPED, VD.FECHASYS FECCAPTURA, VD.HORASYS HORACAPTURA, 
                          VD.FECHASYS FECGRABACION, VD.HORASYS HORAGRABACION, VD.FECHASYS FECRECEP, VD.HORASYS HORARECEP, 3600 STATUS,
                          0 ANOGRUP, 0 CODGRUP, DECODE(:ANOPED,0,TO_CHAR(SYSDATE,'YYYY'),:ANOPED) ANOPED,
                          DECODE(:SEQPED,0,1,:SEQPED) SEQPED, :PESOPEDIDOAUX*1000 PESOPEDIDO, :VOLUMENPEDIDOAUX*1000 VOLUMENPEDIDO,
                          DECODE(:FECSERVICIO,0,VD.FECHASYS,:FECSERVICIO) FECSERVICIO 
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

CURSOR=CSELSINCLAVE SELECT :CODPED FROM DUAL WHERE :CODPED IS NOT NULL;

CURSOR=CDELLINEASPED DELETE FROM VDPEDIDOLIN WHERE CODPED = :CODPED AND CODDIV = :CODDIV AND SEQPED = :SEQPED AND ANOPED = :ANOPED;

CURSOR=CSELTIPOCLI SELECT TIPOCLI FROM VDCLIENTES WHERE CODCLIENTE = :CODCLIENTE;

CURSOR=CUPDPESOYVOL SELECT :PESOPEDIDOAUX*1000 PESOPEDIDO, :VOLUMENPEDIDOAUX*1000 VOLUMENPEDIDO FROM DUAL;

CURSOR=CINTIPESOYVOL SELECT :PESOPEDIDO/1000 PESOPEDIDOAUX, :VOLUMENPEDIDO/1000 VOLUMENPEDIDOAUX FROM DUAL;

CURSOR=CINSPEDORIG INSERT INTO VDPEDIDORIGCAB (CODDIV, ANOPED, CODPED, ANOALB, CODALB, TIPOPEDIDO, NLINEAS, PEDIDOCLIENTE, FECPEDIDOCLIENTE, 
                                               PEDIDOHOST, CODCLIENTE, DESCLIENTE, NIF, CONTACTO, DIRECCION, DIRECCION1, DIRECCION2, DIRECCION3, 
                                               POBLACION, CODPROV, DP, CODPAIS, TELEFONO, FAX, EMAIL, DIRECCIONEDI, IDIOMAETIQ, IDIOMADOC, NUMALBA, MENHOST, 
                                               SWTANULAR, SWTVALORADO, SWTTOTALES, SWTPROFORMA, SWTALBEXTERIOR, SWTALBSELLADO, SWTAGRUPAR, SWTCOMUNICAR, SWTMODELO, 
                                               REFMODELO, SWTMISCELANEO, SWTPACKINGLIST, SWTNOETIQCC, SWTPALETIZAR, SWTETIQECI, SWTBLOQEXP, SWTMAIL, SWTFAX, 
                                               SWTEDI, CODAREAEXPED, BACKORDER, SWTPREPMONO, TPCVERIF, COLCAMBIOVOL, MONEDA, DESCUENTO, DESDESCUENTO, 
                                               RECARGO, DESRECARGO, CONDPAGO, PRIORIDAD, URGENCIA, CODAGE, TRACKINGAGE, DATOSAGE, SWTADUANA, SWTREEXP, CODCLIREEXP, DESCLIREEXP, 
                                               NIFREEXP, CONTAREEXP, DIRREEXP, DIRREEXP1, DIRREEXP2, DIRREEXP3, POBREEXP, CODPROVREEXP, DPREEXP, CODPAISREEXP, TELREEXP, FAXREEXP, 
                                               EMAILREEXP, DIRECCIONEDIREEXP, SWTFACTU, CODCLIFACTU, DESCLIFACTU, NIFFACTU, CONTAFACTU, DIRFACTU, DIRFACTU1, 
                                               DIRFACTU2, DIRFACTU3, POBFACTU, CODPROVFACTU, DPFACTU, CODPAISFACTU, TELFACTU, FAXFACTU, EMAILFACTU, DIRECCIONEDIFACTU, CODCOMEN, FECCAPTURA, 
                                               HORACAPTURA, FECSERVICIO, FECGRABACION, HORAGRABACION, FECRECEP, HORARECEP, FECTERMIN, HORATERMIN, STATUS, VDEXTRA, CODOPEMODIF, FECMODIF, 
                                               HORAMODIF, SWTSEGURO, SWTREEMBOLSO, PORTES) 
                   VALUES (:CODDIV, :ANOPED, :CODPED, 0, NULL, :TIPOPEDIDO, 0, :PEDIDOCLIENTE, :FECPEDIDOCLIENTE, 
                           :PEDIDOHOST, :CODCLIENTE, :DESCLIENTE, :NIF, :CONTACTO, :DIRECCION, :DIRECCION1, :DIRECCION2, :DIRECCION3, 
                           :POBLACION, :CODPROV, :DP, :CODPAIS, :TELEFONO, :FAX, :EMAIL, NULL, :IDIOMAETIQ, :IDIOMADOC, :NUMALBA, :MENHOST, 
                           :SWTANULAR, :SWTVALORADO, :SWTTOTALES, :SWTPROFORMA, :SWTALBEXTERIOR, :SWTALBSELLADO, :SWTAGRUPAR, :SWTCOMUNICAR, :SWTMODELO, 
                           :REFMODELO, :SWTMISCELANEO, :SWTPACKINGLIST, :SWTNOETIQCC, :SWTPALETIZAR, :SWTETIQECI, :SWTBLOQEXP, :SWTMAIL, :SWTFAX, 
                           :SWTEDI, :CODAREAEXPED, :BACKORDER, :SWTPREPMONO, 0, NULL, NULL, :DESCUENTO, NULL, 
                           :RECARGO, NULL, NULL, :PRIORIDAD, :URGENCIA, :CODAGE, NULL, NULL, :SWTADUANA, :SWTREEXP, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
                           NULL, NULL, :SWTFACTU, :CODCLIFACTU, :DESCLIFACTU, :NIFFACTU, :CONTAFACTU, :DIRFACTU, :DIRFACTU1, 
                           :DIRFACTU2, :DIRFACTU3, :POBFACTU, :CODPROVFACTU, :DPFACTU, :CODPAISFACTU, :TELFACTU, :FAXFACTU, :EMAILFACTU, NULL, :CODCOMENAUX, :FECCAPTURA, 
                           :HORACAPTURA, :FECSERVICIO, :FECGRABACION, :HORAGRABACION, :FECRECEP, :HORARECEP, 0, NULL, VDST.FPECGRABADO, NULL, VDUSER.GETUSER, VD.FECHASYS, 
                           VD.HORASYS, :SWTSEGURO, :SWTREEMBOLSO, :PORTES);

CURSOR=CACTIVATRASLADOS UPDATE VDDEMANDALIN SET STATUS=VDST.FDELPDTERESERV 
                                   WHERE STATUS=VDST.FDELPDTEACTIV
                                     AND CODDEMANDA=:CODDEMANDA
                                     AND TIPODEMANDA=:TIPODEMANDA;

CURSOR=CACTIVACABTRAS UPDATE VDDEMANDACAB SET STATUS=VDST.FDECPDTERESERV
                                   WHERE STATUS=VDST.FDECCREADA
                                     AND CODDEMANDA=:CODDEMANDA
                                     AND TIPODEMANDA=:TIPODEMANDA;
CURSOR=CDAMESEMAFORO BEGIN :ESTADO:=0;:ESTADO:=VDSEM.DAMESEMAFORO('DEMANDA','N');END;@

CURSOR=CERRORSEMAFORO SELECT :ESTADO FROM DUAL WHERE :ESTADO=0;
                       
CURSOR=CLIBERASEMAFORO BEGIN VDSEM.LIBERASEMAFORO('DEMANDA'); END;@     


CURSOR=CUPDCABPEDIDO UPDATE VDPEDIDOCAB 
                        SET STATUS = 3700,CODOPEMODIF = VDUSER.GETUSER, 
                            FECMODIF = VD.FECHASYS, HORAMODIF = VD.HORASYS, PESOPEDIDO=:PESOPEDIDO,VOLUMENPEDIDO=:VOLUMENPEDIDO
                      WHERE CODPED = :CODPED AND CODDIV = :CODDIV AND ANOPED = :ANOPED AND SEQPED = :SEQPED;



CURSOR=CSELCUANTOS SELECT COUNT(LINDEMANDA) CUANTOS FROM VDDEMANDALIN WHERE CODDEMANDA=:CODDEMANDA AND TIPODEMANDA=:TIPODEMANDA;


CURSOR=CSELPESVOLDEM  BEGIN
                       VDDEM.DAMEPESOVOLDEMANDAMAESTRA(:CODDEMANDA,:TIPODEMANDA,:PESOPEDIDO,:VOLUMENPEDIDO);
                     END;@
  


CURSOR=CCREABULTOS DECLARE
                       RET NUMBER;
                   BEGIN
                       RET:=VDBULTO.CREABULTOSMISC(:CODDIV,:ANOPED,:CODPED,:SEQPED,VD.GETPROP('DIGITOEAN'),0,0,:CUANTOS,:PESOPEDIDO,:VOLUMENPEDIDO);
                       IF RET != 0 THEN
                           RAISE NO_DATA_FOUND;
                       END IF;
                   END;@

CURSOR=CCOMPRUEBATRAS SELECT :CODDEMANDA FROM VDDEMANDALIN 
                                   WHERE STATUS=VDST.FDELPDTEACTIV
                                     AND CODDEMANDA=:CODDEMANDA
                                     AND TIPODEMANDA=:TIPODEMANDA;

TECLA=SF8,FEJECUTA("CCOMPRUEBATRAS","COMPRUEBE DATOS PARA ACTIVAR TRASLADO",
                   "CACTIVATRASLADOS","ERROR ACTIVANDO LINEAS DE TRASLADO",
                   "CACTIVACABTRAS","ERROR ACTIVANDO CABECERA DE TRASLADO",
                   "CDAMESEMAFORO","ERROR OBTENIENDO SEMAFORO",
                   "CERRORSEMAFORO","SEMAFORO 'DEMANDA' OCUPADO",                  
                   FCOMMIT,"",   
                   FLANZATAREASSYNC("-TRESDEMANDAS","RESDEMANDAS.LOG -WVRESERVA_DEMANDAS","2","0"),":V10ERROR",
                   "CLIBERASEMAFORO","ERROR AL LIBERAR SEMAFORO",
                   "CSELPESVOLDEM","ERROR OBTENIENDO PESO Y VOLUMEN DE DEMANDA",
                   "CSELCUANTOS","ERROR OBTENIENDO BULTOS A CREAR",
                   "CCREABULTOS","ERROR CREANDO BULTOS A PEDIDO",                   
                   "CUPDCABPEDIDO","ERROR ACTUALIZANDO CABECERA DE PEDIDO",
                   FCOMMIT,"",
                   %FFAILURE,"TRASLADO LANZADO")


CONTEXTUAL=FLEEMENU("VDDEMPEDIDOS.ZOO")


ONLINE= {F4} Grabar demanda pedido  {F6} Introducir lineas de pedido   {M�y+F8} Lanzar demanda de pedido  {M�y+F10} Men� Contextual ;
