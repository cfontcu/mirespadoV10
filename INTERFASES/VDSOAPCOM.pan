MANTENIMIENTO DE IP6 SILO V10

TIPOINTERFASE      URL                                                                                                 Insercción                      
_18_______________ _500______________________________________________________________________________________________  _32_______ ¿D-MM-Y.YYY _8______    
|
TABLA=VDSOAPCOM
ORDERBY=TIPOINTERFASE DESC;

WLONX=1200

CAMPO=TIPOINTERFASE,TOOLTIP("Tipo de interfase"),TITULO("Tipo de interfase")
CAMPO=URL,TOOLTIP("Código seriado del contenedor"),TITULO("URL")
CAMPO=CODOPEINS,NOENTER,TOOLTIP("Usuario que ha realizado la ultima modificación.Es utilizado para depuración y control de los registros en las tablas"),TITULO("Usuario")
CAMPO=FECINS,NOENTER,TOOLTIP("Es la fecha  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas"),TITULO("Fecha")
CAMPO=HORAINS,NOENTER,TOOLTIP("Es la hora  en que se efectuó alguna modificación. Es utilizado para depuración y control de los registros en las tablas"),TITULO("Hora"),WLONX=30
