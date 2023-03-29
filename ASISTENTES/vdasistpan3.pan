# M�dulo   : VDASISPAN3.PAN
# Funci�n  : Lista de campos de la pantalla
#
# Creaci�n : 31-08-2009
# Autor    : FGS
###########################################
# Hist�rico de cambios:
Campos de la pantalla


Ord Campo          S FORMATO                Titulo         Prefijo      VVirtual       VProtect   VOc  VNoenter      VnoUpdate      VCheckbox  VAU  Cap  VTOOLTIP
@L@ _32___________ _ _1024_________________ _32___________ _32_________ _ _20_________ _20_______  _   _ _32________ _ _32_________ _10______   _    _   _1024___________________________________________________________________
|                                                                                


TABLA=VDTMPCAMPOS
WHERE=MIUSER=VDUSER.GETUSER;
ORDERBY=ORDEN;
REGPAG=46

PREINSERT=FEJECUTA("CSELMIID","")

CAMPO=MIUSER,OCULTO,"_32________"
CAMPO=NBLOQUE,OCULTO,VIRTUAL
CAMPO=ORDEN,TITULO("Ord"),WLONX=15
CAMPO=NCAMPO,TITULO("Campo")
CAMPO=INCLUIR,TITULO("I"),CHECKBOX("","S")
CAMPO=FORMATOCAMPO,TITULO("FORMATO"),COMBOX("CLISTAFORMATOS")
CAMPO=CTITULO,TITULO("TITULO")
CAMPO=CPREFIJO,TITULO("PREFIJO")
CAMPO=CVIRTUAL,TITULO("VIRTUAL"),CHECKBOX("","S")
CAMPO=CCVIRTUAL
CAMPO=CPROTECT,TITULO("PROTECT"),COMBOXMULTIPLE("CLISTAPRIV"),COMBOXREADONLY
CAMPO=COCULTO,TITULO("O"),CHECKBOX("","S"),WLONX=-14,TOOLTIP("Campo Oculto")  
CAMPO=CNOENTER,TITULO("NOENTER"),CHECKBOX("","S")
CAMPO=PRIVNOENTER,COMBOXMULTIPLE("CLISTAPRIV"),COMBOXREADONLY
CAMPO=CNOUPDATE,TITULO("NOUPDATE"),CHECKBOX("","S")
CAMPO=PRIVNOUPDATE,COMBOXMULTIPLE("CLISTAPRIV"),COMBOXREADONLY
CAMPO=CCHECKBOX,TITULO("CHECKBOX"),TOOLTIP("Formato: Valor_False,Valor True. (valores entre comillas)"),WLONX=30
CAMPO=CAUXILIAR,TITULO("A"),CHECKBOX("","S"),WLONX=-18,TOOLTIP("Auxiliar")
CAMPO=CCAPITALIZA,TITULO("Cap"),COMBOX("CCCAPITALIZA"),COMBOXREADONLY,TOOLTIP("Capitaliza"),WLONX=15
CAMPO=CTOOLTIP,TITULO("TOOLTIP")

CURSOR=CLISTAFORMATOS SELECT '�D-MM-Y.YY','--->','FECHA ' FROM DUAL UNION
                      SELECT '@L@@@@@@@','--->','NUMERO ' FROM DUAL UNION
                      SELECT '_XX__________','--->','CADENA ' FROM DUAL;
                      
CURSOR=CCCAPITALIZA SELECT 'U','UPPER' FROM DUAL 
                    UNION
                   SELECT 'L','LOWER' FROM DUAL 
                    UNION
                   SELECT 'M','MIXED' FROM DUAL;

CURSOR=CDELETELISTA DELETE VDTMPCAMPOS WHERE MIUSER=VDUSER.GETUSER AND NBLOQUE=:NBLOQUE;
                    
CURSOR=CLISTAPRIV SELECT PRIVILEGIO,COMENTARIO FROM VDPRIVILEGIO ORDER BY PRIVILEGIO;

CURSOR=CSELMIID SELECT VDUSER.GETUSER MIUSER FROM DUAL;

 TECLA=F8,FEJECUTA("CDELETELISTA","ERROR BORRANDO LISTA DE CAMPOS",
                  FCOMMIT,"",
                  FPULSATECLAS("F3","F2"))  