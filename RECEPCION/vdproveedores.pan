#####
# VDPROVEEDORES.PAN
#                                                    
# Prop�sito: Mantenimiento de la tabla de proveedores                          
#                                                                              
#####
MANTENIMIENTO DE PROVEEDORES
 
 Proveedor: _20_____________ _60______________________________    
 Tipo: _20_______________    NIF:  _30___________   Activo: __
 
 ������������������������������������������ ENVIO ������������������������������������������
 �                                                                                         �
 � Direcci�n: _40___________________________  _40___________________________               �
 �                                                                                         �
 �            _40___________________________  _40___________________________               �
 �                                                                                         �
 � Pa�s: _____ _30_________________  Provincia: _____ _40__________________                �
 �                                                                                         �
 � Poblaci�n: _40_________________ DP: _10____  Contacto: _40_____________________________ �
 �                                                                                         �
 � Tel�fono: _12_______            Fax: _12______     Email: _40__________________________ �
 �������������������������������������������������������������������������������������������
 
 Cajas a verificar:@@@   Margen de peso:@@@@    Verificaci�n FMD:_
 
 Observaciones: _256________________________________________________________________________ 
 
 Ultima modificaci�n: _32________________ �D-MM-YY.Y ________

|

TABLA=VDPROVEEDOR


#TRIGGERS
PREINSERT=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

PREUPDATE=FEJECUTA("CSELMODIF","ERROR OBTENIENDO LA FECHA DE MODIFICACION")

#CAMPOS				   
CAMPO=CODPROVE,TOOLTIP("Es el c�digo de proveedor al que se realiza el pedido de compra")
CAMPO=DESPROVE,TOOLTIP("Designaci�n completa del proveedor")
CAMPO=TIPOPROVE,TOOLTIP("Tipo de proveedor")
CAMPO=NIF,TOOLTIP("Nif del proveedor")
CAMPO=ACTIVO,TOOLTIP("Indica si el proveedor est� activo o no")
CAMPO=DIRECCION,TOOLTIP("Es la direcci�n del proveedor. Est� descompuesta en cuatro campos de 40 caracteres")
CAMPO=DIRECCION1,TOOLTIP("L�nea 2 de la direcci�n de proveedor")
CAMPO=DIRECCION2,TOOLTIP("L�nea 3 de la direcci�n de proveedor")
CAMPO=DIRECCION3,TOOLTIP("L�nea 4 de la direcci�n de proveedor")
CAMPO=CODPAIS,TOOLTIP("Pa�s de proveedor"),POSTCHANGE=FDESIGNACION("+CSELPAISDEST",""),COMBOX("CLISTAPAIS")
CAMPO=DESPAISDEST,AUXILIAR,NOENTER
CAMPO=CODPROV,TOOLTIP("C�digo de la provincia de proveedor"),POSTCHANGE=FDESIGNACION("+CSELDESPROVDEST",""),COMBOX("CLISTAPROV")
CAMPO=DESPROVDEST,AUXILIAR,NOENTER
CAMPO=POBLACION,TOOLTIP("Poblaci�n del proveedor")
CAMPO=DP,TOOLTIP("Distrito postal de la direcci�n de proveedor"),POSTCHANGE=FDESIGNACION("+CSELPOB",""),COMBOX("CLISTADP")
CAMPO=CONTACTO,TOOLTIP("Indica el posible contacto con el proveedor")
CAMPO=TELEFONO,TOOLTIP("Tel�fono correspondiente a direcci�n de proveedor")
CAMPO=FAX,TOOLTIP("N�mero de fax del proveedor")
CAMPO=EMAIL,TOOLTIP("Direccion email correspondiente a direcci�n de proveedor")
CAMPO=CAJASAVERIF,TOOLTIP("N�mero de cajas a verificar asociado al proveedor")
CAMPO=MARGENPESO,TOOLTIP("Margen de peso asociado al proveedor")
CAMPO=SWTFMD,TOOLTIP("Requiere verificaci�n FMD, (N)unca, (S)iempre, (O)casionalmente")
CAMPO=OBSERVACIONES,TOOLTIP("observaciones al cliente")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiza la modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la �ltima modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la �ltima modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")


#CURSORES
CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF,NVL(:SWTFMD,'N') SWTFMD FROM DUAL;

CURSOR=CSELDESPROVDEST SELECT DESPROV DESPROVDEST
                         FROM VDPROVI 
                        WHERE CODPROV = :CODPROV AND CODPAIS = :CODPAIS;

CURSOR=CSELPAISDEST SELECT DESPAIS DESPAISDEST
                      FROM VDPAIS
                     WHERE CODPAIS = :CODPAIS;
                     
CURSOR=CLISTAPAIS SELECT CODPAIS,DESPAIS DESPAISDEST FROM VDPAIS ORDER BY DESPAIS;

CURSOR=CLISTAPROV SELECT CODPROV,DESPROV DESPROVDEST FROM VDPROVI;

CURSOR=CLISTADP SELECT DP,LOCALIDAD POBLACION FROM VDLOCALIDAD WHERE NVL(:CODPAIS,CODPAIS)=CODPAIS AND NVL(:CODPROV,CODPROV)=CODPROV AND NVL(:POBLACION,LOCALIDAD)=LOCALIDAD
                ORDER BY DP,LOCALIDAD;

CURSOR=CSELPOB SELECT :POBLACION POBLACION FROM DUAL;



AYUDA=MANTENIMIENTO DE PROVEEDORES
ONLINE=     {F1} Ayuda {F2} Consulta {F4} Confirmar cambios {F5} Borrar pantalla
              {F9} Borrar registro {Ctrl-F7} Copia {Esc} Salir;

