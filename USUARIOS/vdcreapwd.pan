#CREACION DE UN NUEVO PASSWORD
CREACION DE UN PASSWORD

 Usuario:  _32____________
 Password: _P40_________________________
 Repita:   _P40_________________________

|

TABLA=DUAL

PREINSERT=FEJECUTA("CVERREPETICION","Los passwords no coinciden",
                   "+CPASAMAY","No puedo pasar el password a mayusculas",                  
                   FVERIFICANUEVOPASS(":CODOPE",":PASSWORD","HPASSWORD","MENSAJE"),"PASSWORD INCORRECTO\n:MENSAJE",
                   "CUPDAPASSWORD","No puedo actualizar el password",
                   FCOMMIT,"")
POSTCOMMIT=FPULSATECLAS("F10")

CAMPO=CODOPE,MIXED,AUXILIAR,NOENTER("SUPERUSUARIO"),TOOLTIP("C�digo del usuario al que se ha de crear un password")
CAMPO=PASSWORD,MIXED,NOENTER("SUPERUSUARIO"),AUXILIAR,TOOLTIP("Nuevo password para el usuario")
CAMPO=REPITE,MIXED,NOENTER("SUPERUSUARIO"),AUXILIAR,TECLA=CR,FPULSATECLAS("F4"),TOOLTIP("Repita el password por seguridad")
CAMPO=HPASSWORD,AUXILIAR,OCULTO,"_100"
CAMPO=MENSAJE,AUXILIAR,OCULTO,"_500"

CURSOR=CVERREPETICION SELECT :CODOPE FROM DUAL WHERE :PASSWORD=:REPITE;

CURSOR=CUPDAPASSWORD UPDATE VDUSUARIO SET HPASSWORD=:HPASSWORD,FECCADUC=VD.FECHASYS WHERE CODOPE=:CODOPE;

CURSOR=CPASAMAY SELECT UPPER(:CODOPE) CODOPE,UPPER(:PASSWORD) PASSWORD,UPPER(:REPITE) REPITE FROM DUAL WHERE VD.GETPROP('PAADMITEMINUS')='N';
