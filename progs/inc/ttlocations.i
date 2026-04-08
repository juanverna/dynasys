
/*------------------------------------------------------------------------
    File        : ttlocations.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sat Mar 21 19:17:37 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE {1} TEMP-TABLE ttLocations NO-UNDO
    FIELD Orden       AS INT64
    FIELD Tipo        AS CHARACTER
    FIELD Descripcion AS CHARACTER
    FIELD Numero      AS CHARACTER
    FIELD Calle       AS CHARACTER
    FIELD Partido     AS CHARACTER
    FIELD Ciudad      AS CHARACTER
    FIELD Provincia   AS CHARACTER
    FIELD Pais        AS CHARACTER
    FIELD Latitud     AS DECIMAL
    FIELD Longitud    AS DECIMAL
    INDEX orden orden.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
