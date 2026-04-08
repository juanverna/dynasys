/*===============================================================================================*/
/*    DEFINICION DE LA TABLA TEMPORAL PARA EXPORTACIONES A EXCEL                                 */
/*===============================================================================================*/

DEFINE TEMP-TABLE ttReprt NO-UNDO
    FIELD ttValr AS CHARACTER
    FIELD ttRango AS CHARACTER
    FIELD ttRangoColm AS INTEGER
    FIELD ttRangoFila AS INTEGER
    FIELD ttOper AS CHARACTER
    FIELD ttSheet AS INT
    FIELD ttOrden as int
    INDEX xorden ttorden ascending.

DEFINE TEMP-TABLE ttDefcolumnas NO-UNDO
    FIELD ttnumero_columna AS INTEGER
    FIELD ttnombre_columna AS CHARACTER
    INDEX x-numero IS UNIQUE ttnumero_columna 
    INDEX x-nombre IS UNIQUE ttnombre_columna.
