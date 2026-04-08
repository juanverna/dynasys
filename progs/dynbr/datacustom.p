&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*--------------------------------------------------------------------------
    File        : datacustom.p
    Purpose     : Super procedure to extend data class.

    Syntax      : datacustom.p

    Modified    : 06/03/1999
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

&SCOPED-DEFINE ADMSuper datacustom.p

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-getDataQuerySort) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getDataQuerySort Procedure 
FUNCTION getDataQuerySort RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getDataQueryString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getDataQueryString Procedure 
FUNCTION getDataQueryString RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-openQuery) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD openQuery Procedure 
FUNCTION openQuery RETURNS LOGICAL
  (  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setdataQuerysort) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setdataQuerysort Procedure 
FUNCTION setdataQuerysort RETURNS LOGICAL
  ( pcDataQuerySort AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setDataQueryString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setDataQueryString Procedure 
FUNCTION setDataQueryString RETURNS LOGICAL
  ( pcDataQuerystring AS CHARACTER )  FORWARD.

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
   Other Settings: CODE-ONLY COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Procedure ASSIGN
         HEIGHT             = 17
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Procedure 
/* ************************* Included-Libraries *********************** */

{src/adm2/dataprop.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-getDataQuerySort) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getDataQuerySort Procedure 
FUNCTION getDataQuerySort RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cDataQuerySort AS CHARACTER NO-UNDO.

  {get DataQuerySort cDataQuerySort}.
  RETURN cDataQuerySort.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getDataQueryString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getDataQueryString Procedure 
FUNCTION getDataQueryString RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cDataQuerystring AS CHARACTER NO-UNDO.

  {get DataQueryString cDataQueryString}. 
  RETURN cDataQuerystring.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-openQuery) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION openQuery Procedure 
FUNCTION openQuery RETURNS LOGICAL
  (  ) :
/*------------------------------------------------------------------------------
  Purpose:     Opens the SmartDataObject's database query based on the current 
               WHERE clause.
  
  Parameters:  <none>
  
  SHO customization:  IF cQueryString <> "":U THEN changed to
                      IF cQueryString <> "":U AND NOT cQueryString = ?
                      because cQueryString can be ? when using a searchfield within 
                      a dynbrowser. 
                      The query is now build with a DataQueryString- and
                      DataQuerySort property to make re-sorting possible
------------------------------------------------------------------------------*/    
   DEFINE VARIABLE cASDivision      AS CHARACTER NO-UNDO.
   DEFINE VARIABLE hAppServer       AS HANDLE    NO-UNDO.
   DEFINE VARIABLE hDataQuery       AS HANDLE    NO-UNDO.
   DEFINE VARIABLE cQueryString     AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cOperatingMode   AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cContext         AS CHARACTER NO-UNDO.
   DEFINE VARIABLE iByClause        AS INTEGER   NO-UNDO.
   DEFINE VARIABLE cQueryWhere      AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cQuerySort       AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cDataQueryString AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cDataQuerySort   AS CHARACTER NO-UNDO.
   DEFINE VARIABLE lOk              AS LOG       NO-UNDO.

  /* Close the RowObject query and empty the current RowObject table. */
   {get DataHandle hDataQuery}.
   IF VALID-HANDLE(hDataQuery) THEN
   DO:
     IF hDataQuery:IS-OPEN THEN
       {fn closeQuery}.
     ELSE DO: 
       ASSIGN cDataQueryString = DYNAMIC-FUNCTION('getDataQueryString':U IN TARGET-PROCEDURE)
              cDataQuerySort   = DYNAMIC-FUNCTION('getDataQuerySort':U IN TARGET-PROCEDURE).
       IF cDataQueryString + cDataQuerySort NE hDataQuery:PREPARE-STRING THEN
         hDataQuery:QUERY-PREPARE(cDataQueryString + cDataQuerySort) NO-ERROR.
     END.
   END.

   /* NOTE: How to do this without actually repreparing the temp-table query twice.
   {set DataSort '':U}.           /* Reset these qualifiers on the Temp-Table */
   {set DataWhere '':U}.          /*  in case the data has been filtered. */
   */
   
   /* If this is the client half of a divided DataObject, fetchFirst will
      retrieve the Temp-table across the connection. */
   {get ASDivision cASDivision}.

   IF cASDivision = 'Client':U THEN
   DO:
     /* Reset this last-record flag on the client */ 
     {set LastRowNum ?}.
     {get ASHandle hAppServer}.
     IF VALID-HANDLE(hAppServer) THEN 
     DO:
       /* The getQueryString will return the client side QueryString 
         if query manipulation methods has been used. */ 
       {get QueryString cQueryString}.

       IF cQueryString <> "":U AND NOT cQueryString = ? THEN
          {fnarg prepareQuery cQueryString}. /* will be sendt to server. */
 
       IF {fn openQuery hAppServer} THEN DO: 
         RUN fetchFirst IN TARGET-PROCEDURE.
         RETURN TRUE.
       END. /* If successfully opened the query */
       
       IF cOperatingMode = "STATELESS" THEN 
       DO:
         RUN saveContextAndDestroy IN hAppServer (OUTPUT cContext).
         RUN setPropertyList IN TARGET-PROCEDURE (cContext).
       END.  /* If Stateless */
       RETURN lOk.

     END. /* If a valid appserver handle */
     ELSE RETURN FALSE.
   END.   /* END DO client */

   ELSE DO:  /* This is not the client */
     /**  
     IF cASDivision = 'SERVER':U THEN DO:
       {set FirstRowNum ?}.
       {set LastRowNum ?}.
       {set FirstResultRow ?}.
       {set LastResultRow ?}.
       RUN doEmptyModTable IN TARGET-PROCEDURE.
     END.  /* If on the server */
     **/ 
     RETURN SUPER().
     
   END.  /* ELSE DO: Not the client */

  END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setdataQuerysort) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setdataQuerysort Procedure 
FUNCTION setdataQuerysort RETURNS LOGICAL
  ( pcDataQuerySort AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  {set DataQuerySort pcDataQuerySort}. 
  RETURN TRUE.   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setDataQueryString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setDataQueryString Procedure 
FUNCTION setDataQueryString RETURNS LOGICAL
  ( pcDataQuerystring AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  {set DataQuerystring pcDataQuerystring}. 
  RETURN TRUE.   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

