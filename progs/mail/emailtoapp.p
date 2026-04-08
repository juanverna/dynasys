
/*------------------------------------------------------------------------
    File        : emailtoapp.p
    Purpose     : Recibe un XML con email y attachments desde el ActMail 

    Syntax      :

    Description :

    Author(s)   : Marcelo Ferrante
    Created     : Thu Aug 13 16:03:09 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE INPUT PARAMETER xmlChar AS LONGCHAR NO-UNDO.

DEFINE TEMP-TABLE ttHeader NO-UNDO XML-NODE-NAME "h":U
    FIELD uuid          AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "uid":U
    FIELD emailDesde    AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "d":U
    FIELD emailA        AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "a":U
    FIELD emailCC       AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "cc":U
    FIELD Subject       AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "s":U
    FIELD Body          AS CLOB      XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "b":U
    FIELD enviadoFecha  AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "e":U
    FIELD recibidoFecha AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "r":U
    FIELD carpeta       AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "c":U
    FIELD modo          AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "m":U.

DEFINE TEMP-TABLE ttAttachs NO-UNDO XML-NODE-NAME "at":U
    FIELD uuid   AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "uid":U
    FIELD nombre AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "n":U
    FIELD tamano AS CHARACTER XML-NODE-TYPE "ATTRIBUTE":U XML-NODE-NAME "t":U
    FIELD data AS CLOB.

DEFINE DATASET dsEmail FOR ttHeader, ttAttachs
    DATA-RELATION dr FOR ttHeader, ttAttachs RELATION-FIELD(uuid,uuid).

DEFINE VARIABLE decdmptr AS MEMPTR   NO-UNDO.
DEFINE VARIABLE decdlngc AS LONGCHAR NO-UNDO.

DEFINE VARIABLE lOk AS LOGICAL NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
ASSIGN lOk = DATASET dsEmail:READ-XML("LONGCHAR":U, xmlChar, "APPEND":U, ?,?) NO-ERROR.
IF NOT lOk OR ERROR-STATUS:ERROR THEN
    RETURN "No se pudo procesar el XML " + ERROR-STATUS:GET-MESSAGE(1).

FOR EACH ttHeader NO-LOCK:

    FOR EACH ttAttachs WHERE ttAttachs.uuid = ttHeader.uuid:
        COPY-LOB FROM ttAttachs.data TO decdlngc.
        decdmptr = BASE64-DECODE(decdlngc).
        COPY-LOB FROM decdmptr TO FILE "/tmp/" + ttAttachs.nombre.
        ttAttachs.data = ?.
        decdmptr = ?.
        decdlngc = ?.
    END.
END.

DATASET dsEmail:EMPTY-DATASET().

RETURN "OK":U.