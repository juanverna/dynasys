
/*=================================================================================*/
/*                  GENERA EL LISTADO DE CONTRATO_RESTRICCIONES de contratos activos          */
/*=================================================================================*/
/*DEFINE var        p-periodo      AS CHAR INITIAL "092007". /*periodo de analisis formato mmAAAA*/
DEFINE VAR        p-xfile AS CHAR NO-UNDO INITIAL "c:\sic-temp\contratos_restriccion.xml".
*/
DEFINE INPUT PARAMETER        p-periodo      AS char. /*periodo de analisis formato mmAAAA*/
DEFINE INPUT-OUTPUT PARAMETER p-xfile AS CHAR NO-UNDO.

    

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/



/*=================================================================================*/
/*                                    TABLAS TEMPORALES                            */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Contrato_hd NO-UNDO LIKE Contrato_hd.
DEFINE TEMP-TABLE T-Contrato_restriccion NO-UNDO LIKE Contrato_restriccion.
DEFINE TEMP-TABLE T-Restriccion NO-UNDO LIKE Restriccion.
DEFINE TEMP-TABLE T-Recurso NO-UNDO LIKE Recurso.
DEFINE TEMP-TABLE T-cliente NO-UNDO LIKE Cliente.
DEFINE TEMP-TABLE tempresa NO-UNDO LIKE empresa.

/*=================================================================================*/
/*                                    DATASET Y FUNCIONES CRYSTAL                  */
/*=================================================================================*/

DEFINE DATASET dset FOR tempresa,T-Contrato_hd, T-Contrato_restriccion, T-Restriccion , t-cliente , T-Recurso.
DEFINE VAR ddd AS DATE NO-UNDO.
DEFINE VAR hhh AS DATE NO-UNDO.
{crystal_dyna.p}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

EMPTY TEMP-TABLE Tempresa.

{findempresa.i}
CREATE tempresa.
BUFFER-COPY empresa TO tempresa.

EMPTY TEMP-TABLE T-Contrato_hd.
EMPTY TEMP-TABLE T-Contrato_restriccion.
EMPTY TEMP-TABLE T-Restriccion.
EMPTY TEMP-TABLE T-Recurso.

/* --------------------------------------------------------------------------  */
/*         ACA SE COLOCA LA GENERACION DE LAS TABLAS TEMPORALES                */
/* --------------------------------------------------------------------------  */

ddd = DATE(int(SUBSTRING(p-periodo,1,2)),1,int(substring(p-periodo,3,4))).
hhh = DATE( MONTH(ddd + 32 ), 1 , YEAR( ddd + 32 ) ) - 1 .

FOR EACH contrato_hd WHERE contrato_hd.estado = "A" and contrato_hd.rige_hasta >= ddd AND
                           contrato_hd.rige_desde <= hhh AND
                           ( contrato_hd.cant_periodos = 0 OR resto_periodos > 0 ) AND
                           contrato_hd.primer_mes + contrato_hd.primer_ano * 100 <= int(SUBSTRING(p-periodo,1,2)) + int(SUBSTRING(p-periodo,3,4)) * 100 
                                       NO-LOCK:
    CREATE t-contrato_hd.
    BUFFER-COPY contrato_hd TO t-contrato_hd.
    FIND cliente OF contrato_hd NO-LOCK NO-ERROR.
    IF AVAILABLE cliente THEN DO:
        FIND t-cliente WHERE t-cliente.nro_cliente = cliente.nro_cliente NO-ERROR.
        IF NOT AVAILABLE t-cliente THEN DO:
            CREATE t-cliente.
            BUFFER-COPY cliente TO t-cliente.
        END.
    END.
    FOR EACH contrato_restriccion OF contrato_hd NO-LOCK:
        CREATE t-contrato_restriccion.
        BUFFER-COPY contrato_restriccion TO t-contrato_restriccion.
        FIND restriccion OF contrato_restriccion NO-LOCK NO-ERROR.
        IF AVAILABLE restriccion THEN DO:
            FIND t-restriccion WHERE t-restriccion.nro_restriccion = restriccion.nro_restriccion NO-ERROR.
            IF NOT AVAILABLE t-restriccion THEN DO:
                CREATE t-restriccion.
                BUFFER-COPY restriccion TO t-restriccion.
            END.
        END.

    END.
END.
IF p-xfile = "" OR p-xfile = ?
      THEN p-xfile = tempfile("") + ".xml".


  DATASET dset:WRITE-XML ("FILE", p-xfile, TRUE,
                                       ?,"",YES,YES).

