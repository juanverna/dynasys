{inc/ttParametroInfo.i}
 
DEFINE INPUT  PARAMETER piReporte AS INT64 NO-UNDO.
DEFINE INPUT  PARAMETER TABLE FOR ttParametroInfo.
DEFINE OUTPUT PARAMETER DATASET-HANDLE phDataSet .

DEFINE VARIABLE lOk      AS LOGICAL  NO-UNDO.
DEFINE VARIABLE cSchema  AS LONGCHAR NO-UNDO.
DEFINE VARIABLE iBuffer  AS INT64    NO-UNDO.
DEFINE VARIABLE iBuffers AS INT64    NO-UNDO.

FUNCTION prepareBuffer RETURNS LOGICAL(INPUT hBuffer AS HANDLE):
    DEFINE VARIABLE hDBBuffer   AS HANDLE    NO-UNDO.
    DEFINE VARIABLE hDataSource AS HANDLE    NO-UNDO.
    DEFINE VARIABLE cCondicion  AS CHARACTER NO-UNDO.

    CREATE DATA-SOURCE hDataSource.
    CREATE BUFFER hDBBuffer FOR TABLE hBuffer:XML-NODE-NAME.

    hDataSource:ADD-SOURCE-BUFFER(hDBBuffer, ?).
    hBuffer:ATTACH-DATA-SOURCE(hDataSource).

    /*Buscamos si el buffer tiene un WHERE*/
    FIND FIRST ReporteBuffer WHERE ReporteBuffer.IDReporte = piReporte AND
                                   ReporteBuffer.nombre    = hBuffer:NAME NO-LOCK NO-ERROR.
    IF AVAILABLE(ReporteBuffer) AND ReporteBuffer.Condicion NE "":U THEN DO:
        /*Reemplazamos los parametros*/
        ASSIGN cCondicion = ReporteBuffer.Condicion.
        FOR EACH ttParametroInfo WHERE ttParametroInfo.NombreBuffer = hBuffer:NAME NO-LOCK:
            ASSIGN cCondicion = REPLACE(cCondicion, "$(":U + ttParametroInfo.NombreParametro + ")":U, ttParametroInfo.Valor).
        END.
        /*hdatasource:QUERY-PREPARE("for each " + hbuffer:NAME).*/
        ASSIGN hDataSource:FILL-WHERE-STRING = cCondicion.
    END.

    /*Buscamos si hay campos para relciones. Si las hay registramos
      el after row fill procedimiento para llenar esos campos.*/
    IF CAN-FIND(FIRST ReporteCampo WHERE ReporteCampo.IDReporte    = piReporte       AND
                                         ReporteCampo.BufferNombre = hBuffer:NAME AND
                                         ReporteCampo.Tipo         = "RL":U)   THEN
        hBuffer:SET-CALLBACK-PROCEDURE("AFTER-ROW-FILL":U, "rowAfterFill":U).

    IF CAN-FIND(FIRST ReporteCampo WHERE ReporteCampo.IDReporte    = piReporte    AND
                                         ReporteCampo.BufferNombre = hBuffer:NAME AND
                                         ReporteCampo.Tipo         NE "RL":U)   THEN
        hBuffer:SET-CALLBACK-PROCEDURE("AFTER-FILL":U, "bufferAfterFill":U).

END FUNCTION. /*prepareBuffer*/

FIND FIRST Reporte WHERE Reporte.IDReporte = piReporte NO-LOCK NO-ERROR.
IF NOT AVAILABLE(Reporte) THEN
    RETURN ERROR "No Existe Registro de Reporte".

COPY-LOB FROM Reporte.Esquema TO cSchema.

CREATE DATASET phDataSet.
ASSIGN lOk = phDataset:READ-XMLSCHEMA("LONGCHAR":U, cSchema, FALSE) NO-ERROR.

ASSIGN cSchema = ?.

IF NOT lOk THEN
    RETURN ERROR "No se pudo cargar el Schema del Dataset".

IF Reporte.AfterFillProcedure NE "":U THEN
    phDataSet:SET-CALLBACK-PROCEDURE("AFTER-FILL":U, "datasetAfterFill":U).

ASSIGN iBuffers = phDataset:NUM-BUFFERS.
REPEAT iBuffer = 1 TO iBuffers:
    prepareBuffer(phDataset:GET-BUFFER-HANDLE(iBuffer)).
END.

phDataset:FILL().

REPEAT iBuffer = 1 TO iBuffers:
    phDataset:GET-BUFFER-HANDLE(iBuffer):DETACH-DATA-SOURCE.
END.

PROCEDURE rowAfterFill:
    DEFINE INPUT  PARAMETER DATASET-HANDLE phDataset.

    DEFINE VARIABLE lOkFind AS LOGICAL      NO-UNDO.
    DEFINE VARIABLE hTargetBuffer AS HANDLE NO-UNDO.

    FOR EACH ReporteCampo WHERE ReporteCampo.IDReporte    = piReporte AND
                                ReporteCampo.BufferNombre = SELF:NAME AND
                                ReporteCampo.Tipo         = "RL":U NO-LOCK:

        CREATE BUFFER hTargetBuffer FOR TABLE ReporteCampo.TablaOrigen.
        ASSIGN lOkFind = hTargetBuffer:FIND-FIRST(" WHERE " + ReporteCampo.TablaOrigen + "." + ENTRY(1, ReporteCampo.Relacion) + " = " + SELF:BUFFER-FIELD(ENTRY(2, ReporteCampo.Relacion)):BUFFER-VALUE) NO-ERROR.
        IF lOkFind AND hTargetBuffer:AVAILABLE THEN
            ASSIGN SELF:BUFFER-FIELD(ReporteCampo.Campo):BUFFER-VALUE = hTargetBuffer:BUFFER-FIELD(ReporteCampo.CampoOrigen):BUFFER-VALUE.
        ELSE
            ASSIGN SELF:BUFFER-FIELD(ReporteCampo.Campo):BUFFER-VALUE = "".

        DELETE OBJECT hTargetBuffer.
        ASSIGN hTargetBuffer = ?.
    END.
END PROCEDURE. /*rowAfterFill*/

PROCEDURE bufferAfterFill:
    DEFINE INPUT PARAMETER DATASET-HANDLE phDataset.

   /* IF SELF:BUFFER-FIELD("AfterFillProcedure":U):BUFFER-VALUE NE "":U THEN
        RUN VALUE(SELF:BUFFER-FIELD("AfterFillProcedure":U):BUFFER-VALUE) (INPUT SELF:HANDLE) NO-ERROR.
   */
END PROCEDURE. /*rowAfterFill*/

PROCEDURE datasetAfterFill:
    DEFINE INPUT PARAMETER DATASET-HANDLE phDataset.
/*
    IF SELF:BUFFER-FIELD("AfterFillProcedure":U):BUFFER-VALUE NE "":U THEN
        RUN VALUE(SELF:BUFFER-FIELD("AfterFillProcedure":U):BUFFER-VALUE) (INPUT SELF:HANDLE) NO-ERROR.
*/
END PROCEDURE. /*rowAfterFill*/
