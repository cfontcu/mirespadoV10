BEGINBLOQUE=VDDEFGRUPOBLOQUE.PAN
 PREREGISTRO=PRESEHIJO
 POSX=1
 POSY=1
 REGPAG=10
 AYUDA=PRIVILEGIOS POR DEFECTO EN PANTALLAS
ENDBLOQUE
BEGINBLOQUE=VDDEFBLOQUEPRIV.PAN
 PADRE=VDDEFGRUPOBLOQUE.PAN
 PREREGISTRO=PRESEHIJO
 CAMPO=GRUPOBLOQUEAUX,AUXILIAR,VIRTUAL("GRUPOBLOQUE"),OCULTO
 WHERE=GRUPOBLOQUE LIKE :GRUPOBLOQUEAUX;
 POSX=1
 POSY=16
 REGPAG=40
 WLONX=1100
ENDBLOQUE

