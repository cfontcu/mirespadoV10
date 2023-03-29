MONITOR DE DEVOLUCIONES POR ESTADO

  ��������������� L�neas �����������������������đ
  Estado                   Total  CajaCliente  Apto  NoApto  SalidaExt Destruidas   Inventario
  @L@@ _30________________ @L@@    @L@@        @L@@  @L@@     @L@@       @L@@        @L@@

|
WFRAME(10,6,690,15,"L�neas de devoluci�n","border-bottom-width:0px")

SOLOQUERY
SELECT = SELECT DVC.STATUS,ST.DESSTATUS,
                COUNT(*) TOTAL FROM 
          VDDEVOLCAB DVC,VDSTATUS ST WHERE
           DVC.STATUS=ST.STATUS AND ST.TIPOSTATUS='DVC';
GROUPBY=DVC.STATUS,ST.DESSTATUS;      
ORDERBY=STATUS ASC;
     
POSTQUERY=FEJECUTA("+CCUENTALINEAS","")
CURSOR=CCUENTALINEAS SELECT SUM(DECODE(DVL.STATUS,VDVST.FDVLDEVCLIENTE,1,0)) CAJACLIENTE,
                            SUM(DECODE(DVL.STATUS,VDVST.FDVLAPTO,1,0)) APTO,
                            SUM(DECODE(DVL.STATUS,VDVST.FDVLNOAPTO,1,0)) NOAPTO,
                            SUM(DECODE(DVL.STATUS,VDVST.FDVLDEVEXT,1,0)) SALIDAEXT,
                            SUM(DECODE(DVL.STATUS,VDVST.FDVLDESTRUIDA,1,0)) DESTRUIDA,
                            SUM(DECODE(DVL.STATUS,VDVST.FDVLINVENTARIO,1,0)) INVENTARIO
                        FROM VDDEVOLCAB DVC, VDDEVOLLIN DVL
                        WHERE DVC.SEQDEVOL = DVL.SEQDEVOL AND DVC.STATUS= :STATUS;
                            


CAMPO=STATUS,TITULO("Estado devoluci�n")
CAMPO=DESSTATUS
CAMPO=TOTAL,TITULO("Total"),WLONX=20
CAMPO=CAJACLIENTE,TITULO("Caja cliente"),WLONX=60
CAMPO=APTO,TITULO("Apto"),WLONX=20
CAMPO=NOAPTO,TITULO("No Apto"),WLONX=28
CAMPO=SALIDAEXT,TITULO("Salida Ext"),WLONX=60
CAMPO=DESTRUIDA,TITULO("Destruida"),WLONX=60
CAMPO=INVENTARIO,TITULO("Inventario"),WLONX=70



