
/*------------------------------------------------------------------------
    File        : getbuscadordatos.p
    Purpose     : 

    Syntax      :

    Description :

    Author(s)   : Marcelo Ferrante
    Created     : Thu Feb 12 13:36:43 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttBuscador NO-UNDO
    FIELD codigo AS CHARACTER
    FIELD nombre AS CHARACTER
    INDEX nombre nombre.

DEFINE INPUT  PARAMETER pcTable  AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER pcCodigo AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER pcNombre AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER TABLE FOR ttBuscador.

DEFINE VARIABLE hQuery  AS HANDLE NO-UNDO.
DEFINE VARIABLE hBuffer AS HANDLE NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
CREATE BUFFER hBuffer FOR TABLE pcTable.

CREATE QUERY hQuery.
hQuery:SET-BUFFERS(hBuffer).
hQuery:QUERY-PREPARE ("FOR EACH " + hBuffer:NAME + " NO-LOCK").
hQuery:QUERY-OPEN().

REPEAT:
    IF NOT hQuery:GET-NEXT() THEN
        LEAVE.

    CREATE ttBuscador.
    ASSIGN ttBuscador.codigo = STRING(hBuffer:BUFFER-FIELD (pcCodigo):BUFFER-VALUE)
           ttBuscador.nombre = STRING(hBuffer:BUFFER-FIELD (pcNombre):BUFFER-VALUE).
END.
hQuery:QUERY-CLOSE().
hQuery = ?.