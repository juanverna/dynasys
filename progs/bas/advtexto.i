&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Include 
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

DEFINE TEMP-TABLE tttexto 
    FIELD tfecha AS DATETIME LABEL "Fecha" FORMAT "99/99/9999 HH:MM"
    FIELD tusuario AS CHAR LABEL "Usuario" FORMAT "X(12)"
    FIELD ttexto  LIKE tarea.descripcion
    INDEX por_fecha tfecha DESCENDING.

  DEFINE VAR qadvtexto AS HANDLE NO-UNDO.
  IF VALID-HANDLE(qadvtexto) THEN
     qadvtexto:QUERY-CLOSE.
  DELETE OBJECT qadvtexto NO-ERROR.
  CREATE QUERY qadvtexto.

DEFINE QUERY cortoqadvtexto FOR tttexto.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD agregaAdvTexto Include 
FUNCTION agregaAdvTexto RETURNS CHARACTER
  ( v-texto AS CHAR, temptexto AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD cortoAdvTexto Include 
FUNCTION cortoAdvTexto RETURNS CHARACTER
  ( TABLE tttexto )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD limpiafecha Include 
FUNCTION limpiafecha RETURNS DATETIME
  ( p AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD saveAdvTexto Include 
FUNCTION saveAdvTexto RETURNS CHARACTER
  ( v-texto AS CHAR, TABLE tttexto )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD saveAdvTexto2 Include 
FUNCTION saveAdvTexto2 RETURNS CHARACTER
  ( v-texto AS CHAR, v-texto2 AS CHAR ,TABLE tttexto )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Include
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: INCLUDE-ONLY
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Include ASSIGN
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Include 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadAdvTexto Include 
PROCEDURE loadAdvTexto :
/*------------------------------------------------------------------------------
  Purpose: cargar el texto, previa conversion en una temp-table   
  Parameters:  
    p-texto a convertir,
    brw handle del browse (BROWSE BROWSE-7:HANDLE )
    temp-table de salida
    v-texto campo a mostrar.

  Notes: Crear un browse y un editor
  RUN loadAdvTexto ( "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-texto AS CHARACTER.
  DEFINE INPUT PARAMETER brw AS HANDLE.
  DEFINE OUTPUT PARAMETER TABLE FOR tttexto. 
  DEFINE OUTPUT PARAMETER v-texto AS CHAR.
  
  DEFINE VAR i AS INT NO-UNDO.
  DEFINE VAR ttemp AS CHAR NO-UNDO.


  RUN loadAdvTTtexto( p-texto , OUTPUT TABLE tttexto ).
    
    qadvtexto:QUERY-CLOSE.
    qadvtexto:SET-BUFFERS( BUFFER tttexto:handle ).
    qadvtexto:QUERY-PREPARE("for each tttexto" ).
    brw:QUERY = qadvtexto.
    brw:ADD-COLUMNS-FROM("tttexto") /* IN FRAME {&FRAME-NAME}. */.
    brw:COLUMN-MOVABLE = TRUE.
    brw:COLUMN-RESIZABLE = TRUE.
    brw:SENSITIVE = TRUE.
    qadvtexto:QUERY-OPEN.  /*se para en el ultimo entrado por el indice*/
   
    IF AVAILABLE tttexto THEN 
       v-texto = replace(tttexto.ttexto,CHR(9),CHR(13)).
   ELSE
       v-texto = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadAdvTTtexto Include 
PROCEDURE loadAdvTTtexto :
/*------------------------------------------------------------------------------
  Purpose: cargar el texto, previa conversion en una temp-table   
  Parameters:  
    p-texto a convertir,
    brw handle del browse (BROWSE BROWSE-7:HANDLE )
    temp-table de salida
    v-texto campo a mostrar.

  Notes: Crear un browse y un editor
  RUN loadAdvTexto ( "" ,BROWSE BROWSE-7:HANDLE,OUTPUT TABLE tttexto,OUTPUT v-texto).
  DISPLAY v-texto WITH FRAME {&FRAME-NAME}.
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-texto AS CHARACTER.
  DEFINE OUTPUT PARAMETER TABLE FOR tttexto. 
  

  DEFINE VAR i AS INT NO-UNDO.
  DEFINE VAR ttemp AS CHAR NO-UNDO.
  DEFINE VAR ff AS DATETIME NO-UNDO.
    /*
    El separador de registro "·" y el separador de campo "|".
    */

    EMPTY TEMP-TABLE tttexto.
/*    IF NUM-ENTRIES(p-texto , "·" ) = 1  THEN DO: /*es la version monoobservacion*/
        CREATE tttexto.
        ASSIGN tttexto.tfecha = 01/01/2000
               tttexto.tusuario = "Desconocido"   
               tttexto.ttexto = p-texto NO-ERROR.
    END.
    ELSE */ 
    DO i = 1 TO NUM-ENTRIES(p-texto , "·" ):
        ttemp = ENTRY( i , p-texto, "·" ).
        IF NUM-ENTRIES(ttemp,"|") <> 3 THEN 
            do:
            MESSAGE "Error en la conversion de los datos observacion" SKIP ttemp VIEW-AS ALERT-BOX ERROR.
            NEXT.
        END.
        CREATE tttexto.
        ff = datetime(ENTRY(1,ttemp,"|")) NO-ERROR.
        IF ERROR-STATUS:ERROR THEN DO:
            SESSION:DATE-FORMAT = "ymd".
            ff = datetime(ENTRY(1,ttemp,"|")) NO-ERROR.
            SESSION:DATE-FORMAT = "dmy".
            IF ERROR-STATUS:ERROR THEN 
               MESSAGE "Error en la conversion de los datos observacion" SKIP ttemp VIEW-AS ALERT-BOX ERROR.
        END.
        IF ff = ? THEN MESSAGE ttemp VIEW-AS ALERT-BOX ERROR.
        ASSIGN tttexto.tfecha = ff 
               tttexto.tusuario = ENTRY(2,ttemp,"|").   
               tttexto.ttexto = REPLACE(ENTRY(3,ttemp,"|"),CHR(13),chr(9)) NO-ERROR.
        IF ERROR-STATUS:ERROR THEN
            MESSAGE "Error en la conversion de los datos observacion" SKIP ttemp VIEW-AS ALERT-BOX ERROR.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION agregaAdvTexto Include 
FUNCTION agregaAdvTexto RETURNS CHARACTER
  ( v-texto AS CHAR, temptexto AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: Agrega a un campo de texto avanzado un renglon 
    Notes:  
------------------------------------------------------------------------------*/
IF trim(v-texto) <> "" THEN
              temptexto = temptexto + (IF length(TRIM(temptexto)) > 0 THEN "·" ELSE "") + string(NOW) + "|" + userid("sic") +
                                  "|" + trim(v-texto).
RETURN temptexto.   /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION cortoAdvTexto Include 
FUNCTION cortoAdvTexto RETURNS CHARACTER
  ( TABLE tttexto ) :
/*------------------------------------------------------------------------------
  Purpose: Entrega un texto de la ultima observacion entreda si pone [***] es que hay mas
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR mas AS LOGICAL NO-UNDO.
DEFINE VAR tt AS CHAR NO-UNDO.


  OPEN QUERY cortoqadvtexto FOR EACH tttexto.  /*se para en el ultimo entrado por el indice*/
  GET NEXT cortoqadvtexto.
  IF AVAILABLE tttexto THEN DO:
     tt = tttexto.ttexto.
  GET NEXT cortoqadvtexto.
  mas = AVAILABLE tttexto.
  END.
  CLOSE QUERY cortoqadvtexto.


  RETURN (IF mas THEN "[***]" ELSE "") + tt.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION limpiafecha Include 
FUNCTION limpiafecha RETURNS DATETIME
  ( p AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  intenta recuperar la fecha de las mayor de las formas posibles sino da error
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VAR ff AS DATETIME NO-UNDO.
  DEFINE VAR i AS INT NO-UNDO.
  SESSION:DATE-FORMAT = "ymd".
  ff = DATETIME(p) NO-ERROR.
  IF NOT ERROR-STATUS:ERROR THEN do:
     SESSION:DATE-FORMAT = "ymd".
      RETURN ff.
  END.
  SESSION:DATE-FORMAT = "dmy".
  ff = DATETIME( p ) NO-ERROR.
  IF NOT ERROR-STATUS:ERROR THEN RETURN ff.

  p = REPLACE(p,"  "," ").
  p = REPLACE(p,"--","-").

  REPEAT i = 1 TO NUM-ENTRIES(p,"-") :
     SESSION:DATE-FORMAT = "ymd".
     ff = DATETIME( trim(ENTRY(i,p,"-"))) NO-ERROR.
     IF NOT ERROR-STATUS:ERROR THEN do:
            SESSION:DATE-FORMAT = "dmy".
            RETURN ff.
     END.
     
     SESSION:DATE-FORMAT = "dmy".
     ff = DATETIME( trim(ENTRY(i,p,"-"))) NO-ERROR.
     IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
  END.

  REPEAT i = 1 TO NUM-ENTRIES(p," ") :
     SESSION:DATE-FORMAT = "ymd".
     ff = DATETIME( trim(ENTRY(i,p," "))) NO-ERROR.
     IF NOT ERROR-STATUS:ERROR THEN do:
            SESSION:DATE-FORMAT = "dmy".
            RETURN ff.
     END.
     
     SESSION:DATE-FORMAT = "dmy".
     ff = DATETIME( trim(ENTRY(i,p," "))) NO-ERROR.
     IF NOT ERROR-STATUS:ERROR THEN RETURN ff.
  END.
  RETURN ?.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION saveAdvTexto Include 
FUNCTION saveAdvTexto RETURNS CHARACTER
  ( v-texto AS CHAR, TABLE tttexto ) :
/*------------------------------------------------------------------------------
  Purpose:  Convierte la tabla con los textos avanzados en un campo y agrega el v-texto
    Notes:  
            tarea.descripcion = saveAdvTexto(v-texto:INPUT-VALUE,TABLE tttexto).
------------------------------------------------------------------------------*/
DEFINE VAR temptexto AS CHAR NO-UNDO.
DEFINE VAR dformat AS CHAR NO-UNDO.
     ASSIGN 
          v-texto = TRIM(v-texto).
          v-texto = REPLACE(v-texto,"·",".").
          v-texto = REPLACE(v-texto,"|",";").
      temptexto = "".
      FOR EACH TTtexto:
          temptexto = temptexto + (IF length(TRIM(temptexto)) > 0 THEN "·" ELSE "") + string(tttexto.tfecha) + "|" + tttexto.tusuario +
                    "|" + tttexto.ttexto.
      END.
      FIND TTtexto WHERE TTtexto.ttexto = v-texto NO-ERROR.
      IF NOT AVAILABLE TTtexto THEN DO:
              temptexto = agregaAdvTexto(v-texto,temptexto).
      END.
  RETURN temptexto.   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION saveAdvTexto2 Include 
FUNCTION saveAdvTexto2 RETURNS CHARACTER
  ( v-texto AS CHAR, v-texto2 AS CHAR ,TABLE tttexto ) :
/*------------------------------------------------------------------------------
  Purpose:  Convierte la tabla con los textos avanzados en un campo y agrega el v-texto
    Notes:  
            tarea.descripcion = saveAdvTexto(v-texto:INPUT-VALUE,TABLE tttexto).
------------------------------------------------------------------------------*/
DEFINE VAR temptexto AS CHAR NO-UNDO.
DEFINE VAR dformat AS CHAR NO-UNDO.
     ASSIGN 
          v-texto = TRIM(v-texto).
          v-texto = REPLACE(v-texto,"·",".").
          v-texto = REPLACE(v-texto,"|",";").
      temptexto = "".
      FOR EACH TTtexto:
          temptexto = temptexto + (IF length(TRIM(temptexto)) > 0 THEN "·" ELSE "") + string(tttexto.tfecha) + "|" + tttexto.tusuario +
                    "|" + tttexto.ttexto.
      END.
      FIND TTtexto WHERE TTtexto.ttexto = v-texto NO-ERROR.
      IF NOT AVAILABLE TTtexto THEN DO:
              temptexto = agregaAdvTexto(v-texto,temptexto).
      END.
      FIND TTtexto WHERE TTtexto.ttexto = v-texto2 NO-ERROR.
      IF NOT AVAILABLE TTtexto THEN DO:
              temptexto = agregaAdvTexto(v-texto2,temptexto).
      END.
  RETURN temptexto.   

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

