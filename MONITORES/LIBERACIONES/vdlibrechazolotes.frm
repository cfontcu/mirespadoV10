CAMPO=POSICION,AUXILIAR,OCULTO,"#L#"
CAMPO=BLOQUEOACTUAL,AUXILIAR,OCULTO,"_"
CAMPO=NUEVOBLOQUEO,AUXILIAR,OCULTO,"_"
CAMPO=TIPOACCION,AUXILIAR,OCULTO,"_50________"
BEGINBLOQUE=VDLOTES.PAN
  CAMPO=MITITULO,AUXILIAR,OCULTO,"_256_____________"
  CAMPO=POSICION,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=BLOQUEOACTUAL,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=NUEVOBLOQUEO,AUXILIAR,VIRTUAL,OCULTO
  CAMPO=TIPOACCION,AUXILIAR,VIRTUAL,OCULTO
  WHERE=SUBSTR(BLOQLOTE,:POSICION,1)=:BLOQUEOACTUAL;

	CURSOR=CPRUEBA SELECT 2 POSICION, 1 BLOQUEOACTUAL, 2 NUEVOBLOQUEO, 'RECHAZO' TIPOACCION FROM DUAL;	
	PREBLOQUE=FEJECUTA("CPRUEBA","")

  REGPAG=25
  WLONY=380
  TITULO=LISTA DE LOTES PENDIENTES DE CALIDAD A RECHAZAR
	CURSOR=CFORMATITULO SELECT TRIM(:TIPOACCION) || ' DEL LOTE ' || :CODLOT || ' DEL ARTICULO ' || :CODART MITITULO FROM DUAL;
  BOTON=INFORME,450,520,100,100,"Tratar Lote",vertis\cajaaprecinto.png,SF9,"Tratar Lote",INCLUDECSS="border-style:outset;background-color:transparent" 

  TECLA=SF9,FEJECUTA("CFORMATITULO","",
                     FEJECUTAFORM("VDLIBUNLOTE","S","STK.CODART=:CODART AND STK.CODLOT=:CODLOT","POSICION=:POSICION BLOQUEOACTUAL=:BLOQUEOACTUAL NUEVOBLOQUEO=:NUEVOBLOQUEO TIPOACCION=:TIPOACCION","",":MITITULO","S"))
  ONLINE={F1} Ayuda  {F4} Confirmar Cambios  {F6} Cambio de pantalla  {May-F9} Rechazar Lote {May-F10} Men� contextual;
ENDBLOQUE