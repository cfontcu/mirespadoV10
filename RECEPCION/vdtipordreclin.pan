#*****************************************************************
#M�dulo: VDTIPORDRECLIN.PAN
#Funci�n: Mantenimiento de las l�neas de los tipos de recepci�n
#Autor: ICC      
#Fecha: 12-02-2008
#*****************************************************************
#* Hist�rico de cambios
#* ====================
#
MANTENIMIENTO DE LAS LINEAS DE LOS TIPOS DE RECEPCION

Clasificaci�n   Clase          RO RU MUESTREAR AM  C. Lote Est. lote  Est. stock D. Ant D. Ret M. lote Lote por defecto  Mult.   Ultima modificaci�n
_15____________ _15____________ _  _     _      _     _    _10_______ _10_______  ###    ###     _     _40______________ _1____  _32_______ �D-MM-Y.YYY _8______
|
TABLA=VDTIPORDRECLIN
WLONY=220


PREINSERT=FEJECUTA("CVALCODCLASIF", "ERROR, EL C�digo DE CLASIFICACION :CODCLASIF NO EXISTE",
                   "CVALCODCLASE", "ERROR, EL C�digo DE CLASE :CODCLASE\n NO EXISTE PARA LA CLASIFICACION :CODCLASIF",
                   "-CVALNUMERICO", ":MSGERROR",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")
PREUPDATE=FEJECUTA("CVALCODCLASIF", "ERROR, EL C�digo DE CLASIFICACION :CODCLASIF NO EXISTE",
                   "CVALCODCLASE", "ERROR, EL C�digo DE CLASE :CODCLASE\n NO EXISTE PARA LA CLASIFICACION :CODCLASIF",
                   "-CVALNUMERICO", ":MSGERROR",
                   "CSELMODIF","ERROR AL OBTENER LA FECHA DE MODIFICACION")

CAMPO=TIPORDREC,VIRTUAL,TOOLTIP("Tipo de orden de recepci�n"),OCULTO
CAMPO=CODCLASIF,TOOLTIP("Es el C�digo alfanum�rico �nico asociado a cada clasificaci�n."),
                CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDMNTOCLASIF.FRM","N","","","CODCLASIF=:CODCLASIF","","S")),
                TITULO("Clasificaci�n")
CAMPO=CODCLASE,TOOLTIP("Es el C�digo alfanum�rico asociado a cada clase dentro de la clasificaci�n."),UPPER,
               CONTEXTUAL=FDESIGNACION(FEJECUTAFORM("VDCLASES.FRM","N","","CODCLASIF=:CODCLASIF","CODCLASE=:CODCLASE","","S")),
               TITULO("Clase")
CAMPO=REQUIERE_ORDEN,TOOLTIP("Indicador de si se requiere la existencia de orden de recepci�n para poder hacer una recepci�n"),UPPER,
                     POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),
                     TITULO("RO"),WLONX=15
CAMPO=RECEPCION_UNICA,TOOLTIP("Indica si toda la recepci�n debe hacerse en una �nica entrada. Para chequeo de tolerancias"),UPPER,
                      POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),
                      TITULO("RU"),WLONX=15
CAMPO=MUESTREAR,TOOLTIP("Indicador de si requiere toma de muestras para control de calidad.\n 'N' no se muestrea, 'P' se muestrea por palet,\n 'L' se muestrea por Lote,'R' se muestrea por recepci�n"),UPPER,
                POSTCHANGE=FVERIFICA("NLPR","EL CAMPO DEBE SER N(NO) O L(LOTE) O P(PALET) O R(RECEPCION)"),
                TITULO("MUESTREAR"),WLONX=70
CAMPO=ALTAS_MANUALES,TOOLTIP("N=Entrada repasada. Debe existir la recepci�n. S=Se permite dar de alta la l�nea de recepci�n"),UPPER,
                     POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),
                     TITULO("AM"),WLONX=15
CAMPO=CREA_LOTE,TOOLTIP("N=No se permite crear lote.S=Se crea el lote desde la pantalla de recepci�n"),UPPER,
                POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),
                TITULO("C.Lote"),WLONX=30
CAMPO=ESTADOS_LOTE,TOOLTIP("Estados con los que se crear� el lote cuando CREA_LOTE es distinto de N"),
                   TITULO("Est. Lote"),WLONX=28
CAMPO=ESTADOS_STOCK,TOOLTIP("Cada byte puede tomar un valor que se transmitir� al stock o _ en cuyo caso dicho byte se toma del maestro de lotes"),
                   TITULO("Est. stock"),WLONX=-6
CAMPO=DIASANTFECPREV,TOOLTIP("D�as de antelaci�n permitidos sobre la fecha prevista de recepci�n de una l�nea de orden de recepci�n."),
                     TITULO("D.Ant"),WLONX=20
CAMPO=DIASRETFECPREV,TOOLTIP("D�as de retraso permitidos sobre la fecha prevista de recepci�n de una l�nea de orden de recepci�n."),
                     TITULO("D.Ret"),WLONX=20
CAMPO=INDLOTE,TOOLTIP("Indicador de si debe mostrarse el lote en pantalla o no, valores: S/N \nSi queremos que se cree el Lote autom�tico tiene que estar a N"),UPPER,
              POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),
              TITULO("M.Lote"),WLONX=35
CAMPO=LOTEDEF,TOOLTIP("En caso de que INDLOTE=N, deber� informarse el C�digo de lote por defecto que se crear�"),TITULO("Lote por defecto")
CAMPO=MULTIARTICULO,TOOLTIP("Mostrar� en la pantalla la posibilidad de recepcionar un palet multiart�culo, valores: S/N"),UPPER,
                    POSTCHANGE=FVERIFICA("SN","EL CAMPO DEBE SER S(SI) O N(NO)"),TITULO("Mult."),WLONX=-12
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n"),TITULO("Ultima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Es la fecha  en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Es la hora en que se efectu� alguna modificaci�n a los datos del registro")
CAMPO=MSGERROR,AUXILIAR,OCULTO,"_100_____________________________________________________________"
CAMPO=DUMMY,AUXILIAR,OCULTO,"#"


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF, VD.FECHASYS FECMODIF, VD.HORASYS HORAMODIF FROM DUAL;

CURSOR=CVALCODCLASIF SELECT 1 DUMMY
                       FROM VDCLASIFICACIONES
                      WHERE CODCLASIF = :CODCLASIF;
                      
CURSOR=CVALCODCLASE SELECT 1 DUMMY
                      FROM VDCLASES
                     WHERE CODCLASIF = :CODCLASIF
                       AND CODCLASE  = :CODCLASE;

CURSOR=CVALNUMERICO SELECT CASE WHEN VD.ISVALOR(:ESTADOS_LOTE, '_0123456789') != 0 THEN
                                     'ERROR, LOS ESTADOS DEL LOTE SOLO PUEDEN SER NUMERICO O "_"'
                                ELSE 'ERROR, LOS ESTADOS DEL STOCK SOLO PUEDEN SER NUMERICO O "_"'
                           END MSGERROR
                      FROM DUAL
                     WHERE VD.ISVALOR(:ESTADOS_LOTE, '_0123456789') != 0
                        OR VD.ISVALOR(:ESTADOS_STOCK, '_0123456789') != 0;

