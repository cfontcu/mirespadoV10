SESIONES DE LA BASE DE DATOS

 SID   NSerie Usuario Estado        Terminal   Tipo      Programa              M�dulo                   Inf. Cliente
 @L@@  @L@@@  _30____ _14__________ _16_______ _10______ _48__________________ _48_____________________ _32___________________
|
          																			   
TABLA=V$SESSION
NOROWID
POSTQUERY=FEJECUTA("CMATASESION","NO PUEDO EJECUTAR EL CURSOR")

CAMPO=SID,NOENTER,TOOLTIP("Identificador de sesi�n"),TITULO("SID")
CAMPO=SERIAL#,NOENTER,TOOLTIP("N�mero de serie del proceso"),TITULO("NSerie"), WLONX=20
CAMPO=USERNAME,NOENTER,TOOLTIP("Nombre de usuario del Sistema Operativo"),TITULO("Usuario"), WLONX=20
CAMPO=STATUS,NOENTER,TOOLTIP("Estado de la sesion"),TITULO("Estado")
CAMPO=TERMINAL,NOENTER,TOOLTIP("Nombre del terminal"),TITULO("Terminal")
CAMPO=TYPE,NOENTER,TOOLTIP("Tipo de sesi�n"),TITULO("Tipo")
CAMPO=PROGRAM,NOENTER,TOOLTIP("Nombre del programa"),TITULO("Programa")
CAMPO=MODULE,NOENTER,TOOLTIP("Nombre del modulo"),TITULO("M�dulo")
CAMPO=CLIENT_INFO,NOENTER,TOOLTIP("Nombre de acci�n"),TITULO("Inf. Cliente")
CAMPO=KILLER,AUXILIAR,OCULTO,"_80___________________________________________________________"

CURSOR=CMATASESION SELECT 'ALTER SYSTEM KILL SESSION ''' || :SID ||',' || :SERIAL# ||'''' KILLER FROM DUAL;

TECLA=F8,FEJECUTA(FEJECUTACAMPO("KILLER","SESION NO SE HA PODIDO MATAR"),"SESION NO SE HA PODIDO MATAR",
                   %FFAILURE,"SESION MATADA CON �XITO",
                   FPULSATECLAS("F3","F2"))
                   
