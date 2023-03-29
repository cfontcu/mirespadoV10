###################################################################
#M�dulo: VDSTOCKFUENTE2.PAN
#Funcionalidad :  Pantalla para consulta detalada de los registros de la tabla vdstockfuente
#Autor: FGS      
#Fecha: 17-07-2008
###################################################################
# Hist�rico de cambios:
DETALLE DE REGISTROS PARA CREACION DE STOCK
 
 Estado:      @L@@@ _30___________________________
 
 Ubicaci�n:   _20___________ _20_________    Contenedor: __________________ __________ 
 
 Art�culo:    _40_________________ _100____________________________________  Lote: _40_________________  
 
 Cantidad Host: #########.#### _10_   Uniemb Host: #########.####  EmbCont: @L@@@   Tipo Embalaje: __________ 
 
 Peso Unit:   ############  Precio Unit: #######.#### Bulto: __________________ Bloqueos:  __________  Cod. Recep: _20_________
 
 Marca Stock: _60_____________________________________ N�m. Serie:  _60_____________________________________
 ������������������������ Datos del Lote �������������������������  Codcomen:    @L@@@@@@@@     
 � Lote Proveedor: _40__________________________________________ �
 � Caducidad:      ________    Retest:   ________                �  Info Extra:  _255_______________________________________ 
 � Bloqueos Lote:  __________  Potencia: ######.###              �
 �����������������������������������������������������������������  Ult. Modif.: _32_____________ �D-MM-Y.YYY ________
|
TABLA=VDSTOCKFUENTE


CAMPO=SEQFUENTE,VIRTUAL,OCULTO
CAMPO=STATUS,TOOLTIP("Estado del registro"),POSTCHANGE=FDESIGNACION("+CSELDESSTATUS","ERROR AL EJECUTAR CURSOR CSELDESSTATUS")
CAMPO=DESSTATUS,AUXILIAR,NOENTER
CAMPO=CODUBI,TOOLTIP("Ubicaci�n en la que se crear� el stock"),POSTCHANGE=FDESIGNACION("+CSELAREA","ERROR AL EJECUTAR CURSOR CSELAREA")
CAMPO=CODAREA,AUXILIAR,NOENTER,TOOLTIP("Area de la Ubicaci�n")
CAMPO=CODMAT,TOOLTIP("Si se informa, matr�cula en la que se crea el stock")
CAMPO=TIPOCONTE,TOOLTIP("Tipo de contenedor a crear, si no se informa matr�cula")
CAMPO=CODART,POSTCHANGE=FDESIGNACION("+CSELVDARTICDESART","ERROR AL EJECUTAR CURSOR CSELVDARTICDESART"),TOOLTIP("Art�culo del que se crea stock")
CAMPO=DESART,AUXILIAR,NOENTER,TOOLTIP("Designacion")
CAMPO=CODLOT,TOOLTIP("Lote del que se crea stock")
CAMPO=CANTIDADHOST,TOOLTIP("Cantidad a crear en stock en unidades HOST")
CAMPO=UNIDADESHOST,TOOLTIP("Unidades HOST de la cantidad de stock a crear")
CAMPO=UNIEMBHOST,TOOLTIP("Unidades por Embalaje (HOST) del stock a crear")
CAMPO=EMBCONT,TOOLTIP("Embalajes por contenedor del stock a crear")
CAMPO=TIPOEMBA,TOOLTIP("Tipo de Embalaje del stock a crear")
CAMPO=PESOUNI,TOOLTIP("Peso Unitario del stock a crear")
CAMPO=PRECIOUNI,TOOLTIP("Precio Unitario del stock a crear")
CAMPO=BULTO,TOOLTIP("C�digo de bulto en el stock a crear")
CAMPO=BLOQUEOS,TOOLTIP("Bloqueos del stock a crear, si es  NULO, coge el del lote")
CAMPO=CODRECEP,TOOLTIP("C�digo de Recepci�n del stock a crear")
CAMPO=MARCASTK,TOOLTIP("Marca de stock en el stock a crear")
CAMPO=NUMEROSERIE,TOOLTIP("N�mero de serie en el stock a crear")
CAMPO=CODCOMEN,TOOLTIP("C�digo de comentario del registro")
CAMPO=CODLOTPROV,TOOLTIP("Lote del proveedor, por si se crea lote al crear el stock")
CAMPO=CADUCI,TOOLTIP("Fecha de caducidad del Lote, por si se crea lote al crear el stock")
CAMPO=RETEST,TOOLTIP("Fecha de Retest del Lote, por si se crea lote al crear el stock")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente")
CAMPO=BLOQLOTE,TOOLTIP("Bloqueo del Lote, por si se crea lote al crear el stock")
CAMPO=POTENCIA,TOOLTIP("Potencia del Lote, por si se crea lote al crear el stock")
CAMPO=CODOPEMODIF,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n a los datos del registro")

CURSOR=CSELDESSTATUS SELECT DESSTATUS FROM VDSTATUS WHERE STATUS=:STATUS AND TIPOSTATUS='FTE';

CURSOR=CSELAREA SELECT CODAREA FROM VDUBICA WHERE CODUBI=:CODUBI;

CURSOR=CSELVDARTICDESART SELECT DESART FROM VDARTIC WHERE CODART=:CODART;

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;
