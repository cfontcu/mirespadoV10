#CERRAR PRECINTOS
CERRAR PRECINTOS



                    Precinto  Tipo            Descripci�n             Nuevo     Creado por
                    _________ _______________ _40____________________ _________ _15____________ �D-MM-Y.YY ________
                      
|

SOLOQUERY
TABLA=PR
AQUERY
POSX=1
POSY=6
REGPAG=26
WLONX=1250
WLONY=900
INCLUDEFICHEROCSS="vertis.css"
INCLUDECSS=".v10tabla td{height:34px;}"
INCLUDEFICHEROHTML="botoneratactil.html"
INCLUDEHTML="<SCRIPT> var eventoforzado=1; window.document.getElementById('tactil').style.top=550+'px'; window.document.getElementById('tactil').style.left=970+'px'; </SCRIPT>"


SELECT=SELECT CODPRECINTO,PR.TIPOPRECINTO,DESTIPOPRECINTO,FECINS,HORAINS,CODOPEINS 
          FROM VDPRECINTO PR,WVERTISTIPOPRECINTO TPR
          WHERE PR.TIPOPRECINTO=TPR.TIPOPRECINTO AND PR.STATUS=VDST.FPRCABIERTO;
        
PREUPDATE=FEJECUTA("@CHAYNUEVO","",
                   "-CNOUSADO","Precinto ya ha sido usado",
                   "CCIERRAVIEJO","No puedo cerrar el precinto antiguo",
                   "CINSERTANUEVO","No puedo insertar nuevo precinto")
        
CAMPO=CODPRECINTO,NOUPDATE,TITULO("Precinto"),PREFIJO=PR
CAMPO=TIPOPRECINTO,NOUPDATE,TITULO("Tipo"),PREFIJO=PR
CAMPO=DESTIPOPRECINTO,NOUPDATE,INCLUDECSS="overflow:auto",AUXILIAR
CAMPO=CODPRECINTONUEVO,AUXILIAR,POSTCHANGE=FEJECUTA("-CNOUSADO","Precinto ya ha sido usado"),TITULO("Nuevo"),WLONX=37,INCLUDECSS="font-size:18px;color:red"
CAMPO=CODOPEINS,NOUPDATE,TITULO("Ult. Modificaci�n")
CAMPO=FECINS,NOUPDATE
CAMPO=HORAINS,NOUPDATE

CURSOR=CHAYNUEVO SELECT :CODPRECINTONUEVO FROM DUAL WHERE :CODPRECINTONUEVO IS NOT NULL;

CURSOR=CNOUSADO SELECT :CODPRECINTONUEVO FROM VDPRECINTO WHERE CODPRECINTO=:CODPRECINTONUEVO;

CURSOR=CCIERRAVIEJO UPDATE VDPRECINTO SET  STATUS=VDST.FPRCCERRADO,
                                           CODOPECIERRA=VDUSER.GETUSER,
                                           FECCIERRA=VD.FECHASYS,
                                           HORACIERRA=VD.HORASYS,
                                           CODOPEMODIF=VDUSER.GETUSER,
                                           FECMODIF=VD.FECHASYS,
                                           HORAMODIF=VD.HORASYS
                            WHERE CODPRECINTO=:CODPRECINTO;
             
CURSOR=CDAMEUNPRECINTO SELECT VDSEQPRECINTO.NEXTVAL CODPRECINTONUEVO FROM DUAL;			 

CURSOR=CINSERTANUEVO  INSERT INTO VDPRECINTO(CODPRECINTO,TIPOPRECINTO,STATUS,CODOPEMODIF,FECMODIF,HORAMODIF,
                                              CODOPEINS,FECINS,HORAINS,CODOPECIERRA,FECCIERRA,HORACIERRA,CODOPEDESTRUYE,FECDESTRUYE,HORADESTRUYE,CODCOMEN)
                            VALUES (:CODPRECINTONUEVO,:TIPOPRECINTO,VDST.FPRCABIERTO,VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS,
                                    VDUSER.GETUSER,VD.FECHASYS,VD.HORASYS,'',0,'','',0,'',0);                            


TECLA=10000,FPULSATECLAS("F4","ESC")
TECLA=10001,FEJECUTA("+CDAMEUNPRECINTO","")

BOTON=SALIR,1050,120,120,80,"Salir",NO,27,"Salir de la pantalla" 
BOTON=VALIDAR,1050,260,120,80,"Confirmar",NO,10000,"Confirmar cambis" 
BOTON=PONPRECINTO,1050,400,120,80,"Nuevo Precinto",NO,10001,"Confirmar cambis" 
ONLINE={F4} Confirmar {Esc} Salir;