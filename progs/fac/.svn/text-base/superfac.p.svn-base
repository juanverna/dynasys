&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12
&ANALYZE-RESUME
/* Connected Databases 
          sic              PROGRESS
*/
{adecomm/appserv.i}

/* Temp-Table and Buffer definitions                                    */
DEFINE TEMP-TABLE T-Fac_header NO-UNDO LIKE Fac_header.


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*------------------------------------------------------------------------
    File        : 
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     :
    Notes       :
  ----------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-fnTraducirTabla) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnTraducirTabla Procedure 
FUNCTION fnTraducirTabla RETURNS CHARACTER
  ( INPUT v-nombre_tabla       AS CHARACTER,
    INPUT v-campo_clave        AS CHARACTER,
    INPUT v-campo_descripcion  AS CHARACTER,
    INPUT v-valor_clave        AS CHARACTER
  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Procedure
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: CODE-ONLY COMPILE APPSERVER
   Temp-Tables and Buffers:
      TABLE: T-Fac_header T "?" NO-UNDO sic Fac_header
   END-TABLES.
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Procedure ASSIGN
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-traducir_tabla) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE traducir_tabla Procedure 
PROCEDURE traducir_tabla :
/*==============================================================================================*/
/*                 TRADUCE UN CODIGO EN UNA DESCRIPCIÒN EN BASE A UNA TABLA                     */
/*==============================================================================================*/

DEFINE INPUT  PARAMETER v-nombre_tabla       AS CHARACTER INITIAL "Cliente".
DEFINE INPUT  PARAMETER v-campo_clave        AS CHARACTER INITIAL "cdg_cliente".
DEFINE INPUT  PARAMETER v-campo_descripcion  AS CHARACTER INITIAL "nom_cliente".
DEFINE INPUT  PARAMETER v-valor_clave        AS CHARACTER INITIAL "B00001".
DEFINE OUTPUT PARAMETER v-valor_descripcion  AS CHARACTER FORMAT "X(30)".

/*==============================================================================================*/
/*                                         VARIABLES                                            */
/*==============================================================================================*/

DEFINE VARIABLE fh           AS WIDGET-HANDLE EXTENT 200.
DEFINE VARIABLE qh           AS WIDGET-HANDLE.
DEFINE VARIABLE hTabla       AS WIDGET-HANDLE.
DEFINE VARIABLE i            AS INTEGER.
DEFINE VARIABLE i-cdg        AS INTEGER.
DEFINE VARIABLE i-dsc        AS INTEGER.

DEFINE VARIABLE v-predicado  AS CHARACTER.

/*==============================================================================================*/
/*                                     BLOQUE PRINCIPAL                                         */
/*==============================================================================================*/

CREATE QUERY qh.
CREATE BUFFER hTabla FOR TABLE v-nombre_tabla.
qh:SET-BUFFERS(hTabla:HANDLE). 

DO i = 1 TO hTabla:NUM-FIELDS:
    fh[i] = hTabla:BUFFER-FIELD(i).
    IF fh[i]:NAME = v-campo_clave       THEN i-cdg = i.
    IF fh[i]:NAME = v-campo_descripcion THEN i-dsc = i.
END.

v-predicado = "FOR EACH " + v-nombre_tabla + " WHERE " + v-campo_clave + " = " +
              ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" ) + 
              v-valor_clave + 
              ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" ).

v-valor_descripcion = ?.
qh:QUERY-PREPARE(v-predicado).
qh:QUERY-OPEN().
qh:GET-NEXT().
IF qh:QUERY-OFF-END THEN LEAVE.
v-valor_descripcion = fh[i-dsc]:BUFFER-VALUE.

qh:QUERY-CLOSE().
DELETE OBJECT qh.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-fnTraducirTabla) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnTraducirTabla Procedure 
FUNCTION fnTraducirTabla RETURNS CHARACTER
  ( INPUT v-nombre_tabla       AS CHARACTER,
    INPUT v-campo_clave        AS CHARACTER,
    INPUT v-campo_descripcion  AS CHARACTER,
    INPUT v-valor_clave        AS CHARACTER
  ) :

/*==============================================================================================*/
/*                 TRADUCE UN CODIGO EN UNA DESCRIPCIÒN EN BASE A UNA TABLA                     */
/*==============================================================================================*/

/*==============================================================================================*/
/*                                         VARIABLES                                            */
/*==============================================================================================*/

DEFINE VARIABLE fh           AS WIDGET-HANDLE EXTENT 200.
DEFINE VARIABLE qh           AS WIDGET-HANDLE.
DEFINE VARIABLE hTabla       AS WIDGET-HANDLE.
DEFINE VARIABLE i            AS INTEGER.
DEFINE VARIABLE i-cdg        AS INTEGER.
DEFINE VARIABLE i-dsc        AS INTEGER.

DEFINE VARIABLE v-predicado  AS CHARACTER.
DEFINE VARIABLE v-valor_descripcion  AS CHARACTER FORMAT "X(30)".

/*==============================================================================================*/
/*                                     BLOQUE PRINCIPAL                                         */
/*==============================================================================================*/

  CREATE QUERY qh.
  CREATE BUFFER hTabla FOR TABLE v-nombre_tabla.
  qh:SET-BUFFERS(hTabla:HANDLE). 

  DO i = 1 TO hTabla:NUM-FIELDS:
      fh[i] = hTabla:BUFFER-FIELD(i).
      IF fh[i]:NAME = v-campo_clave       THEN i-cdg = i.
      IF fh[i]:NAME = v-campo_descripcion THEN i-dsc = i.
  END.

  v-predicado = "FOR EACH " + v-nombre_tabla + " WHERE " + v-campo_clave + " = " +
                ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" ) + 
                v-valor_clave + 
                ( IF fh[i-cdg]:DATA-TYPE = "character":U THEN "'" ELSE "" ).

  v-valor_descripcion = ?.
  qh:QUERY-PREPARE(v-predicado).
  qh:QUERY-OPEN().
  qh:GET-NEXT().
  IF qh:QUERY-OFF-END THEN LEAVE.
  v-valor_descripcion = fh[i-dsc]:BUFFER-VALUE.

  qh:QUERY-CLOSE().
  DELETE OBJECT qh.

  RETURN v-valor_descripcion.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

