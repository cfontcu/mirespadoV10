###################################################################
#M�dulo: VDESCADA.PAN
#Funcionalidad : Monitor de entradas pendientes para bultos.
#Autor: ICC
#Fecha: 01-07-2008
###################################################################
# Hist�rico de cambios:
MAPA DE DESTINOS
            1     2     3    4     5       Rechazo             NDST Pdte en Zona pero  
         -------------------------------------------                sin Destino en SGT
 ODS:     ____  ____  ____  ____                               PDTE Destino pendiente
                                                               AKI  En l�nea de restos
 RESTOS:  ____  ____  ____  ____  ____      ____               OK   Zona terminada
                                    Ultima visita: ________ _33________________________ 
|                                                                               

SOLOQUERY
SELECT=SELECT COUNT(DISTINCT(CODBULTO)) TOTAL FROM XVDSGTPENDIENTE;

POSTQUERY=FDESIGNACION("CMONISGT","ERROR EN CMONISGT","CMONISGT2","ERROR EN CMONISGT2","+CULTVISITA","ERROR EN CULTVISITA")


CAMPO=CODBULTO,VIRTUAL("CODMAT"),AUXILIAR,TOOLTIP(""), OCULTO
CAMPO=ODS1, AUXILIAR, TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN EL ODS1.1, SI HA ENTRADO, O SI YA HA SALIDO")
CAMPO=ODS2, AUXILIAR, TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN EL ODS1.2, SI HA ENTRADO, O SI YA HA SALIDO")
CAMPO=ODS3, AUXILIAR, TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN EL ODS1.3, SI HA ENTRADO, O SI YA HA SALIDO")
CAMPO=ODS4, AUXILIAR, TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN EL ODS1.4, SI HA ENTRADO, O SI YA HA SALIDO")

CAMPO=RESTOS1,AUXILIAR,TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN FILA DE RESTOS N� 1")
CAMPO=RESTOS2,AUXILIAR,TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN FILA DE RESTOS N� 2")
CAMPO=RESTOS3,AUXILIAR,TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN FILA DE RESTOS N� 3")
CAMPO=RESTOS4,AUXILIAR,TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN FILA DE RESTOS N� 4")
CAMPO=RESTOS5,AUXILIAR,TOOLTIP("INDICA SI EL BULTO :CODBULTO ESTA PENDIENTE DE ENTRAR EN FILA DE RESTOS N� 5")
CAMPO=RECHAZO,AUXILIAR,NOENTER
CAMPO=TOTAL, OCULTO, "@L@@@@@@@@@"
CAMPO=ULTIMAVISITA,AUXILIAR,NOENTER
CAMPO=FECULTVISITA,AUXILIAR,NOENTER 
                      
CURSOR=CULTVISITA SELECT DESTINO ULTIMAVISITA,VD.TIME2CHAR(FECHAHORAVISITA) FECULTVISITA   FROM XVDSGTVISITADO VISI, XVDSGTDESTINOS DST 
                      WHERE VISI.CODBULTO='00'||:CODBULTO AND
                            VISI.DESTVISITADO = DST.DESTINOSGT 
                 ORDER BY VISI.FECHAHORAVISITA DESC;
                      
CURSOR=CMONISGT SELECT VDSGT.MONITORBULTOSGT(:CODBULTO, 1, 'ODS1') ODS1,
											 VDSGT.MONITORBULTOSGT(:CODBULTO, 2, 'ODS2') ODS2,
											 VDSGT.MONITORBULTOSGT(:CODBULTO, 3, 'ODS3') ODS3,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 4, 'ODS4') ODS4,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RESTOS1') RESTOS1,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RESTOS2') RESTOS2,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RESTOS3') RESTOS3,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RESTOS4') RESTOS4,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RESTOS5') RESTOS5,
										   VDSGT.MONITORBULTOSGT(:CODBULTO, 0, 'RECHAZO') RECHAZO
										   
								FROM DUAL;
								
CURSOR=CMONISGT2 SELECT DECODE(:ODS1, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) ODS1__COLOR,
                        DECODE(:ODS2, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) ODS2__COLOR,
                        DECODE(:ODS3, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) ODS3__COLOR,
                        DECODE(:ODS4, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) ODS4__COLOR,
                        DECODE(:RESTOS1, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RESTOS1__COLOR,
                        DECODE(:RESTOS2, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RESTOS2__COLOR,
                        DECODE(:RESTOS3, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RESTOS3__COLOR,
                        DECODE(:RESTOS4, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RESTOS4__COLOR,
                        DECODE(:RESTOS5, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RESTOS5__COLOR,
                        DECODE(:RECHAZO, 'OK', 19, 'PDTE',18,'AKI',19, 'NDST',18,-1) RECHAZO__COLOR
                        
                   FROM DUAL;
										   
                            
## sacar los datos de DESTPENDIENTE de la tabla de destinos
CURSOR = CSELPDTEDEST SELECT DECODE(DEST.DESTINO, 'ODS1','PDTE', '') ODS1,
                             DECODE(DEST.DESTINO, 'ODS2','PDTE', '') ODS2,
                             DECODE(DEST.DESTINO, 'ODS3','PDTE', '') ODS3,
                             DECODE(DEST.DESTINO, 'ODS4','PDTE', '') ODS4,
                             DECODE(DEST.DESTINO, 'RESTOS1','PDTE', '') RESTOS1,
                             DECODE(DEST.DESTINO, 'RESTOS2','PDTE', '') RESTOS2,
                             DECODE(DEST.DESTINO, 'RESTOS3','PDTE', '') RESTOS3,
                             DECODE(DEST.DESTINO, 'RESTOS4','PDTE', '') RESTOS4,
                             DECODE(DEST.DESTINO, 'RESTOS5','PDTE', '') RESTOS5
                        FROM XVDSGTPENDIENTE SGTP, XVDSGTDESTINOS DEST
                       WHERE SGTP.DESTPENDIENTE = DEST.DESTINOSGT
                         AND SGTP.CODBULTO='00'||:CODBULTO;



CURSOR=CSELENRUTA SELECT DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS1'), 25, 'RUTA',50,'ZONA',100,'ZONA',:ODS1) ODS1,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS1'), 25, 18, 50, 18, 100, 18,-1) ODS1__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS2'), 25, 'RUTA',50,'ZONA',100,'ZONA',:ODS2) ODS2,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS2'), 25, 18, 50, 18, 100, 18,-1) ODS2__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS3'), 25, 'RUTA',50,'ZONA',100,'ZONA',:ODS3) ODS3,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS3'), 25, 18, 50, 18, 100, 18,-1) ODS3__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS4'), 25, 'RUTA',50,'ZONA',100,'ZONA',:ODS4) ODS4,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'ODS4'), 25, 18, 50, 18, 100, 18,-1) ODS4__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS1'), 25, 'RUTA',50,'ZONA',100,'ZONA', :RESTOS1) RESTOS1,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS1'), 25, 18, 50, 18, 100, 18,-1) RESTOS1__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS2'), 25, 'RUTA',50,'ZONA',100,'ZONA', :RESTOS2) RESTOS2,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS2'), 25, 18, 50, 18, 100, 18,-1) RESTOS2__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS3'), 25, 'RUTA',50,'ZONA',100,'ZONA', :RESTOS3) RESTOS3,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS3'), 25, 18, 50, 18, 100, 18,-1) RESTOS3__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS4'), 25, 'RUTA',50,'ZONA',100,'ZONA', :RESTOS4) RESTOS4,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS4'), 25, 18, 50, 18, 100, 19,-1) RESTOS4__COLOR,                         
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS5'), 25, 'RUTA',50,'ZONA',100,'OK', :RESTOS5) RESTOS5,
                         DECODE(VDSGT.MONVISITADA(:CODBULTO,'RESTOS5'), 25, 18, 50, 18, 100, 19,-1) RESTOS5__COLOR
                    FROM DUAL;
                 

AYUDA=MAPA DE DESTINOS
ONLINE=;


