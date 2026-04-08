
/*------------------------------------------------------------------------
    File        : ttlocmapa.i
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     : Fri Mar 27 19:33:55 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
DEFINE TEMP-TABLE ttLocMapa NO-UNDO
    FIELD id          AS INT64
    FIELD descripcion AS CHARACTER
    FIELD latitud     AS DECIMAL
    FIELD longitud    AS DECIMAL
    FIELD marker      AS CHARACTER
    FIELD popupLabel  AS CLOB
    FIELD imagen      AS BLOB
    FIELD c1          AS CHARACTER
    FIELD c2          AS CHARACTER
    FIELD c3          AS CHARACTER
    FIELD c4          AS CHARACTER
    FIELD c5          AS CHARACTER
    FIELD c6          AS CHARACTER
    FIELD i1          AS INT64
    FIELD i2          AS INT64
    FIELD i3          AS INT64
    FIELD i4          AS INT64
    FIELD i5          AS INT64
    FIELD i6          AS INT64
    FIELD d1          AS DATETIME
    FIELD d2          AS DATETIME
    FIELD d3          AS DATETIME
    FIELD d4          AS DATETIME
    FIELD d5          AS DATETIME
    FIELD d6          AS DATETIME
    INDEX id id.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
