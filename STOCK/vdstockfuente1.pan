###################################################################
#M�dulo: VDSTOCKFUENTE1.PAN
#Funcionalidad :  Pantalla para consulta de lso registros de la tabla vdstockfuente
#Autor: FGS      
#Fecha: 17-07-2008
###################################################################
# Hist�rico de cambios:
REGISTROS PARA CREACION DE STOCK
Sec.      Tipo       Ubic.        Codmat             Tipo Cont. Art�culo             Lote                 Cantidad Host       Status
######### _10_______ _20_________ __________________ __________ _40_________________ _40_________________ #########.#### _10_ @@@@@  _255____ _20______  
|
TABLA=VDSTOCKFUENTE
ORDERBY=SEQFUENTE DESC;


CAMPO=SEQFUENTE,TOOLTIP("Secuencia de la generaci�n de stock"),TITULO("Secuencia"),WLONX=22
CAMPO=TIPOFUENTE,TOOLTIP("Tipo de generaci�n de stock"),TITULO("Tipo")
CAMPO=CODUBI,TOOLTIP("Ubicaci�n en la que se crear� el stock"),TITULO("Ubicaci�n"),CONTEXTUAL=FEJECUTAFORM("VDUBICA","S","CODUBI=:CODUBI","","","Consulta de Ubicaci�n","S")
CAMPO=CODMAT,TOOLTIP("Si se informa, matr�cula en la que se crea el stock"),TITULO("Matr�cula"),CONTEXTUAL=FEJECUTAFORM("VDCONTE","S","CODMAT=:CODMAT","","","Consulta de Contenedor","S")
CAMPO=TIPOCONTE,TOOLTIP("Tipo de contenedor a crear, si no se informa matr�cula"),TITULO("Tipo Cont.")
CAMPO=CODART,TOOLTIP("Art�culo del que se crea stock"),TITULO("Art�culo"),CONTEXTUAL=FEJECUTAFORM("VDARTIC","S","CODART=:CODART"),TITULO("Articulo")
CAMPO=CODLOT,TOOLTIP("Lote del que se crea stock"),TITULO("Lote")
CAMPO=CANTIDADHOST,TOOLTIP("Cantidad a crear en stock en unidades HOST"),TITULO("Cantidad Host")
CAMPO=UNIDADESHOST,TOOLTIP("Unidades HOST de la cantidad de stock a crear")
CAMPO=STATUS,TOOLTIP("Estado del registro")
CAMPO=VDEXTRA,TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente")
CAMPO=CODRECEP,TOOLTIP("C�digo de Recepci�n del stock a crear")