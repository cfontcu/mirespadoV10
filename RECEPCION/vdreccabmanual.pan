#*****************************************************************
#M�dulo: VDRECCABMANUAL.PAN
#Funcionalidad : Mantenimiento de la cabecera de recepci�n para recepciones manuales
#Autor: ICC      
#Fecha: 25-03-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
CABECERA DE RECEPCION MANUAL

Cod. recepci�n Tipo   Pulm�n     Cod. Orden     Divisi�n            Albar�n transportista                Albar�n proveedor Clave ext Fecha recepci�n     Estado Observaciones                Ultima modificaci�n             
_20___________ _10___ _15_______ _20____________ _20_ _40__________ _20__________ _40___________________ _20_____________  _50_____ �D-MM-Y.YYY _8______ #####  _60__________ _60__________ _32_________ �D-MM-Y.YY ________
|
TABLA=VDRECEPCAB
WHERE=STATUS = VDST.FRCCACTIVA
  AND SWTRECEP ='M';
ORDERBY=TO_NUMBER(CODRECEP) DESC, CODDIV;


PROTECT("RECEPCIONES")

POSTQUERY=FEJECUTA("CSELPULMON","ERROR SELECCIONANDO EL PULMON")

PREUPDATE=FEJECUTA("CVALTIPO", "ERROR TIPO DE ORDEN NO PERMITIDO PARA ALTAS MANUALES",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   FCOMMIT,"")

PREINSERT=FEJECUTA("CVALTIPO", "ERROR TIPO DE ORDEN NO PERMITIDO PARA ALTAS MANUALES",
                   "CSELDEFECTO", "ERROR SELECCIONANDO LOS VALORES POR DEFECTO",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION",
                   FCOMMIT,"")

CAMPO=CODRECEP,TOOLTIP("N�mero �nico y clave de recepci�n.Utiliza la secuencia VDSECRECEP"),NOENTER,TITULO("Cod. Recepci�n")
CAMPO=TIPORDREC,NOUPDATE,TOOLTIP("Tipo de orden de recepci�n que debe existir en la tabla VDTIPORDREC "),
                CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDTIPORDREC.FRM","N","TIPORDREC IN (SELECT TIPORDREC FROM VDTIPORDRECLIN A WHERE A.TIPORDREC = TIPORDREC AND ALTAS_MANUALES='S')","","TIPORDREC=:TIPORDREC","","S")),
                TITULO("Tipo")
CAMPO=PULMON,AUXILIAR,TOOLTIP("Ubicaci�n pulm�n donde se va a recepcionar"), 
             POSTCHANGE=FEJECUTA("CVERIFPULMON","\nERROR,\nNO EXISTE\n EL PULMON :PULMON",
                                 "CSELFUENTE","\nERROR,\nNO EXISTE NINGUNA FUENTE\nEN EL AREA DE :PULMON"),
             TITULO("Pulm�n")
CAMPO=CODUBI,AUXILIAR,OCULTO,"_20_______"
CAMPO=CODAREA,AUXILIAR,OCULTO,"_20_______"
CAMPO=CODORDREC,TOOLTIP("C�digo de la orden de recepci�n. Si esta informado debe existir en VDCABORDREC"),
                CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDORDENESRECEP.FRM","N","","","CODORDREC=:CODORDREC CODDIV=:CODDIV TIPORDREC=:TIPORDREC","","S")),
                TITULO("Cod. Orden")
CAMPO=CODDIV,NOUPDATE,TOOLTIP("C�digo de la divisi�n/compa��a.Para permitir duplicidad de Ordenes en distintas divisiones = interfases"),
             POSTCHANGE=FDESIGNACION("CSELDESDIV", "ERROR, DIVISION NO EXISTE"),
             COMBOX("CLISTADIVIS"),TITULO("Divisi�n"),WLONX=25
CAMPO=DESDIV,AUXILIAR,NOENTER
CAMPO=CODALBTRAN,TOOLTIP("C�digo del albar�n del transportista"),TITULO("Albar�n Transportista")
CAMPO=DESTRAN,TOOLTIP("Designaci�n del transportista")
CAMPO=CODALBPROVE,TOOLTIP("C�digo de albar�n de proveedor"),TITULO("Albar�n Proveedor"),WLONX=30
CAMPO=CLAVEEXT,TOOLTIP("Clave externa que permite relacionar con otros sistemas no definidos"),TITULO("Clave Ext."),WLONX=20
CAMPO=FECRECEP,NOENTER,TOOLTIP("Fecha de la recepci�n"),TITULO("Fecha Recepci�n")
CAMPO=HORARECEP,NOENTER,TOOLTIP("Hora de la recepci�n")
CAMPO=STATUS,NOENTER,TOOLTIP("Es el estado en el que se encuentra la recepci�n"),TITULO("Estado")
CAMPO=OBSERVACION1,TOOLTIP("Observaciones a la cabecera de recepci�n"),TITULO("Observaciones")
CAMPO=OBSERVACION2,TOOLTIP("M�s observaciones a la cabecera de recepci�n")
CAMPO=VDEXTRA,OCULTO,"_255_",TOOLTIP("Datos adicionales externos a V10 y �tiles para el cliente")
CAMPO=CODCOMEN,OCULTO,"#########",TOOLTIP("C�digo de comentario")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Usuario que ha realizado la Ultima modificaci�n.Es utilizado para depuraci�n y control de los registros en las tablas"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora  en que se efectu� alguna modificaci�n. Es utilizado para depuraci�n y control de los registros en las tablas")
CAMPO=SWTRECEP,OCULTO,"_"
CAMPO=DUMMY,AUXILIAR,OCULTO,"#"

CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CSELDESDIV SELECT DESDIV
                    FROM VDDIVIS
                   WHERE CODDIV = :CODDIV;

CURSOR=CSELPULMON SELECT CODUBIDEST PULMON
                    FROM VDMOVIM
                   WHERE CODRECEP = :CODRECEP
                     AND CODCONCE IN (SELECT CODCONCE 
                                        FROM VDTIPORDRECCAB
                                       WHERE TIPORDREC = :TIPORDREC);

#La ubicaci�n debe existir y ser de stock y no bloqueado para entrada y salida:
CURSOR=CVERIFPULMON SELECT CODAREA
                      FROM VDUBICA
                     WHERE CODUBI    = :PULMON
                       AND STOCK     = 'S'
                       AND BLOQUEOSE = 'N'
                       AND BLOQUEOSS = 'N';

#Buscar la fuente de esa �rea, es decir, una ubicaci�n que no sea de stock y no est� bloqueada para salida.
CURSOR=CSELFUENTE SELECT CODUBI
                    FROM VDUBICA
                   WHERE CODAREA = :CODAREA
                     AND STOCK     = 'N'
                     AND BLOQUEOSS = 'N';

CURSOR=CVALTIPO SELECT 1 DUMMY
                  FROM VDTIPORDRECLIN LTO
                 WHERE LTO.TIPORDREC = :TIPORDREC
                   AND LTO.ALTAS_MANUALES='S';

CURSOR=CSELDEFECTO SELECT VDSECRECEP.NEXTVAL CODRECEP, VDST.FRCCACTIVA STATUS, 'M' SWTRECEP, VD.FECHASYS FECRECEP, VD.HORASYS HORARECEP
                     FROM DUAL;

CURSOR=CLISTADIVIS SELECT CODDIV,DESDIV FROM VDDIVIS ORDER BY CODDIV;

#CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDORDENESRECEP.FRM","S","CODORDREC=:CODORDREC CODDIV=:CODDIV","","","","S"))                           

