#*****************************************************************
#Módulo: VDLOGINFECH.PAN
#Funcionalidad : 
#Fecha: 08-06-2022
#*****************************************************************
#* Histórico de cambios
#* ====================
#
#*****************************************************************
ACCESOS A LA APLICACION
Operario Correcto?  Fecha y hora login    Máquina              Programa
_40_____ _1________ ¿D-MM-Y.YY  ________  _64________________  _64__________________ 
                                                                                                           |
TABLA=VDLOGIN
WHERE=FECLOGIN BETWEEN :FECDESDE AND :FECHASTA;
ORDERBY=FECLOGIN DESC,HORALOGIN DESC;

WLONX=700

CAMPO=CODOPE,VIRTUAL,TOOLTIP("Codigo del usuario"), TITULO("Operario")
CAMPO=CORRECTO,VIRTUAL,TOOLTIP("Indica si el intento de login fue correcto"), TITULO("¿Correcto?"),WLONX=24
CAMPO=FECLOGIN,TOOLTIP("Fecha del login"), TITULO("Fecha y hora de Login")
CAMPO=HORALOGIN,TOOLTIP("Hora del login")
CAMPO=MACHINE,TOOLTIP("Maquina en la que se realiz¢ el login"), TITULO("Máquina")
CAMPO=PROGRAM,TOOLTIP("Programa con el que realiz¢ el login"), TITULO("Programa"),WLONX=5
CAMPO=FECDESDE,AUXILIAR,VIRTUAL,OCULTO
CAMPO=FECHASTA,AUXILIAR,VIRTUAL,OCULTO

BOTON=B1,750,100,70,70,"P",miimprimir.png,CF10,"Impresión de informe",INCLUDECSS="background-color: transparent;border-width:0px"

ONLINE= {F1} Ayuda    {F2} Consulta    {F4} Confirmar cambios    {Esc} Cerrar Pantalla    
        {May-F7} Documentación {May+F8} Imprimir  {F9} Borrar un registro    {F5} Borrar Pantalla    ;
