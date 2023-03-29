# M�dulo   : VDDEMANDALINDET.PAN
# Funci�n  : Detalle de L�neas de Demanda
#
# Creaci�n : 25-03-2008
# Autor    : FGS
###########################################
# Hist�rico de cambios:
DETALLE DE LINEAS DE DEMANDA

 ������������������������������������������� Filtros ������������������������������������������     
 � Codmat: __________________        Lote: _40_______________   Bloqueos: __________          �
 � Uniemb: #L15##########       Marca Stk: _60_______________  Tipo Emba: __________          �
 � Precio: #L15##########      Cod.Recep.: _20_______________                                 �  
 � Bulto:  _20_______________  Num. Serie: _60_______________                                 �  
 ����������������������������������������������������������������������������������������������
 
 BackOrder: _    Uniagrupa: _   Redondeo: _  Orden Reserva: _  Orden Reserva en Uic.: _ Comentario: #L#######
 Marca Stk Origen: _60________________________________ Claveext: _50________________________________________
 
 Inicio:   �D-MM-Y.YY  ________      Insercci�n: _32________ �D-MM-Y.YY  ________ 
 Finaliz:  �D-MM-Y.YY  ________      Ult. Modif: _32________ �D-MM-Y.YY  ________
|


TABLA=VDDEMANDALIN

PREUPDATE=FEJECUTA("CSELMODIF","ERROR EN FECHA DE MODIFICACION")


CAMPO=CODDEMANDA,VIRTUAL,OCULTO
CAMPO=TIPODEMANDA,VIRTUAL,OCULTO
CAMPO=LINDEMANDA,VIRTUAL,OCULTO
CAMPO=CODART,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODUBIORI,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODUBIDEST,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODAREAORI,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODAREADEST,AUXILIAR,VIRTUAL,OCULTO
CAMPO=CODMAT,TOOLTIP("Si se informa, matr�cula donde se debe encontrar la mercanc�a a trasladar.")
CAMPO=CODLOT,TOOLTIP("Si se informa, Lote a trasladar")
CAMPO=BLOQUEOS,TOOLTIP("Si se informa, patr�n de estado a satisfacer por la mercancia a trasladar")
CAMPO=UNIEMB,TOOLTIP("Si se informa, Unidades por embalaje de la mercancia a trasladar")
CAMPO=MARCASTK,TOOLTIP("Si se informa, la mercancia a trasladar debe estar marcado con su valor")
CAMPO=TIPOEMBA,TOOLTIP("Si se informa, Tipo de embalaje de la mercancia a trasladar")
CAMPO=PRECIOUNI,TOOLTIP("Si se informa, precio unitario de la mercancia a trasladar")
CAMPO=CODRECEP,TOOLTIP("Si se informa, C�digo de Recepci�n de la mercanc�a a trasladar")
CAMPO=BULTO,TOOLTIP("Si se informa, C�digo de bulto de la mercanc�a a trasladar")
CAMPO=NUMEROSERIE,TOOLTIP("Si se informa, valor del campo NUMEROSERIE a cumplir por la mercancia a trasladar")
CAMPO=BACKORDER,NOUPDATE,TOOLTIP("Backorder de la l�nea de Demanda, (P)arcial (cantidad reservada superior o inferior) o (E)xacta")
CAMPO=UNIAGRUPA,NOUPDATE,TOOLTIP("Determina en que se expresa la cantidad pedida. (U)nidades,(E)mbalajes o (C)ontenedores")
CAMPO=TIPOREDONDEO,TOOLTIP("Tipo de Redondeo de la l�nea en caso de BACKORDER a (E)xacto. Puede ser\n(N) sin redondeo\n(B) redondea a bulto si hay trazabilidad de bulto\n(E) redondea a embalajes completos seg�n stock, por exceso (CEIL)\n(D) redondea a embalajes completos seg�n stock, por defecto (FLOOR)\n(C) redondea a contenedor completo")
CAMPO=ORDENRESERVA,TOOLTIP("(A) dentro de la misma prioridad de �rea, ORDSALAUT(FEFO) y PRIORIDAD EMBALAJE, se reserva por cantidad ascendente del contenedor. Por defecto.\n(D) dentro de la misma prioridad de �reas,ORDSALAUT(FEFO) y PRIORIDAD EMBALAJE, se reserva por cantidad descendente del contenedor")
CAMPO=ORDENRESERVAUBI,TOOLTIP("En reserva de stock, despu�s de ordenar por ORDENRESERVA, para una ubicaci�n, se reserva por\n(A) POCONTE y ORDENSTK ascendente. Por defecto.\n(D) POSCONTE y ORDENSTK descendente")
CAMPO=CODCOMEN,NOENTER,TOOLTIP("Identificador de los comentarios asociados a la l�nea de la Demanda")
CAMPO=MARCASTKORIGEN,NOUPDATE,TOOLTIP("Si se informa, no se genera movto en la mercancia encontrada, se limita a marcarla con su valor")
CAMPO=CLAVEEXT,NOENTER,TOOLTIP("Clave externa que permite relacionar con otros sistemas")
CAMPO=FECINI,NOUPDATE,TOOLTIP("Fecha en la que se reserva la linea o la primera parte de esta")
CAMPO=HORAINI,NOUPDATE,TOOLTIP("Hora en la que se reserva la linea o la primera parte de esta")
CAMPO=CODOPEINSERT,NOENTER,TOOLTIP("Operario que inserto la l�nea de demanda")
CAMPO=FECINSERT,NOENTER,TOOLTIP("Fecha de insercci�n de la l�nea")
CAMPO=HORAINSERT,NOENTER,TOOLTIP("Hora de inserci�n de la l�nea")
CAMPO=FECFIN,NOUPDATE,TOOLTIP("Fecha de cierra la l�nea de demanda, al ejecutarse sus movtos")
CAMPO=HORAFIN,NOUPDATE,TOOLTIP("Hora de cierre de la l�nea, al ejecutarse sus movtos")
CAMPO=CODOPEMODIF,NOENTER,TOOLTIP("Operario que realiz� la �ltima modificaci�n")
CAMPO=FECMODIF,NOENTER,TOOLTIP("Fecha de la Ultima modificaci�n")
CAMPO=HORAMODIF,NOENTER,TOOLTIP("Hora de la Ultima modificaci�n")


CURSOR=CSELMODIF SELECT VDUSER.GETUSER CODOPEMODIF,VD.FECHASYS FECMODIF,VD.HORASYS HORAMODIF FROM DUAL;




