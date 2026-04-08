&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*--------------------------------------------------------------------------
    File        : browsercustom.p
    Purpose     : Super procedure to extend browser class.

    Syntax      : browsercustom.p

    Modified    : 06/03/1999
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
  
  /* This is needed by some procedures so that another procedure we call
     can identify what the original TARGET-PROCEDURE is. The value is 
     returned by getTargetProcedure. */
  DEFINE VARIABLE ghTargetProcedure AS HANDLE NO-UNDO.
&SCOPED-DEFINE ADMSuper browsercustom.p

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-getSearchFld) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getSearchFld Procedure 
FUNCTION getSearchFld RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-ModifySearchfield) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ModifySearchfield Procedure 
FUNCTION ModifySearchfield RETURNS LOGICAL
  (INPUT cSearchField AS CHARACTER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setSearchFld) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setSearchFld Procedure 
FUNCTION setSearchFld RETURNS LOGICAL
  ( pcSearchFld AS CHAR )  FORWARD.

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
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Procedure 
/* ************************* Included-Libraries *********************** */

{src/adm2/brsprop.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-initializeObject) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE initializeObject Procedure 
PROCEDURE initializeObject :
/*------------------------------------------------------------------------------
  Purpose:     SmartDataBrowser version of initializeObject which executes 
               code mainly to set properties values.
  Parameters:  <none>
  Notes:       May create a dynamic 'Search' FILL-IN if the SearchField
               property is set.
               SHO Customized: 
               - the SearchField property now can be a 
                 comma-separated list. In case it is column-searching is 
                 allowed. 
               - the SearchField is set to a fixed WIDTH and no longer associated
                 with it's format (thus no problems with big formats anymore). 
------------------------------------------------------------------------------*/

  DEFINE VARIABLE hDataSource      AS HANDLE NO-UNDO.
  DEFINE VARIABLE hBrowse          AS HANDLE NO-UNDO.
  DEFINE VARIABLE hFrameField      AS HANDLE    NO-UNDO.
  DEFINE VARIABLE iRowsToBatch     AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cFieldHandles    AS CHARACTER NO-UNDO INIT "":U.
  DEFINE VARIABLE cEnabledHandles  AS CHARACTER NO-UNDO INIT "":U.
  DEFINE VARIABLE cEnabledFields   AS CHARACTER NO-UNDO INIT "":U.
  DEFINE VARIABLE cCreateHandles   AS CHARACTER NO-UNDO INIT "":U.
  DEFINE VARIABLE cRowIdent        AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cUIBMode         AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lSaveSource      AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE lQueryObject     AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE cTarget          AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lQueryBrowsed    AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE cFields          AS CHARACTER NO-UNDO.
  DEFINE VARIABLE hDataQuery       AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hDataBuffer      AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hTableio         AS HANDLE    NO-UNDO.
  DEFINE VARIABLE iField           AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cField           AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lResult          AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE hField           AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hFrame           AS HANDLE    NO-UNDO.
  DEFINE VARIABLE cSearchField     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cSearchFields    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cSearchLabel     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE hSearchLabel     AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hSearchField     AS HANDLE    NO-UNDO.
  DEFINE VARIABLE cAssigns         AS CHARACTER NO-UNDO.
  DEFINE VARIABLE iEntry           AS INTEGER   NO-UNDO.
  DEFINE VARIABLE cSortField       AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lDynamic         AS LOGICAL   NO-UNDO INIT no.
  DEFINE VARIABLE lHideOnInit      AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE cValidation      AS CHARACTER NO-UNDO INIT "":U.
  DEFINE VARIABLE lCalcWidth       AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE iNumDown         AS INTEGER   NO-UNDO.
  DEFINE VARIABLE lOpenOnInit      AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE iSearchField     AS INTEGER   INITIAL 0 NO-UNDO.
  DEFINE VARIABLE cColumn          AS CHARACTER NO-UNDO.
  /* NEW FOR 9.1B: stash the TARGET-PROCEDURE handle away so the
       Data-Source can identify it if it's an SBO */
  ghTargetProcedure = TARGET-PROCEDURE.
  
  {get UIBMode cUIBMode}.

  /* First determine whether this is a "dynamic" browser (actually an
     empty static browser to be filled in at runtime). */
  {get DataSource hDataSource}.   /* Proc. handle of our SDO. */
  {get BrowseHandle hBrowse}.     /* Handle of the browse widget. */
  IF hBrowse:NUM-COLUMNS = 0 THEN
  DO:
    lDynamic = yes.            /* Signal to code below. */
    /* Get Displayed and Enabled fields at runtime. */
    IF NOT VALID-HANDLE(hDataSource) THEN
      RETURN ERROR.                 /* Can't do anything without it. */
 
    {get DataHandle hDataQuery hDataSource}.  /* Handle of the SDO's query. */
    hBrowse:QUERY = hDataQuery.               /* Attach this to the Browse. */
    hDataBuffer = hDataQuery:GET-BUFFER-HANDLE(1).  /* SDO Buffer handle.   */
      
    {get EnabledFields cEnabledFields}.
    {get DisplayedFields cFields}.

    /* If DisplayedFields is blank, this means take all fields from the SDO.
       If EnabledFields is blank, this means take all updatable fields
       from the SDO, IF there is a Tableio-Source. */
    IF cFields = "":U THEN
    DO:
      {get DataColumns cFields hDataSource}.
      {set DisplayedFields cFields}.         /* Set the property. */
    END.    /* END DO IF cFields "" */

    DO iField = 1 TO NUM-ENTRIES(cFields):
      /* Add the requested columns to the browse. */
      hField = hDataBuffer:BUFFER-FIELD(ENTRY(iField, cFields)).
      IF hField:VALIDATE-EXPRESSION NE ? THEN DO: 
          cValidation = hField:VALIDATE-EXPRESSION.
          hField:VALIDATE-EXPRESSION = "":U.
          hBrowse:ADD-LIKE-COLUMN(hField).
          hField:VALIDATE-EXPRESSION = cValidation.
      END.  /* if vaildate-expression ne ? */
      ELSE hBrowse:ADD-LIKE-COLUMN(hField).
    END.  /* END DO iField */
         
    IF cEnabledFields = "":U THEN
    DO:
      {get TableIOSource hTableIO}.
      IF VALID-HANDLE(hTableIO) THEN
      DO:
        {get UpdatableColumns cEnabledFields hDataSource}.
        /* If the Display list was specified, but the Enabled list wasn't,
           make sure we remove any fields from the Enable list which
           weren't in the Display list. */
        DO iField = 1 TO NUM-ENTRIES(cEnabledFields):
          cField = ENTRY(iField, cEnabledFields).
          IF LOOKUP(cField, cFields) = 0 THEN
            ASSIGN cEnabledFields = REPLACE(',':U + cEnabledFields + ',':U, 
                     ',':U + cField + ',':U, ',':U)
                   cEnabledFields = 
                     SUBSTR(cEnabledFields, 2, LENGTH(cEnabledFields) - 2,
                     "CHARACTER":U).
        END. /* END DO iField */
        {set EnabledFields cEnabledFields}.
      END.   /* END DO IF TableIOSource */
    END.     /* END DO IF cEnabledFields "" */
         
    /* If there are any enabled fields, set the enabled prop to yes,
       because they will be explitly disabled by initializeObject if needed. */
    IF cEnabledFields NE "":U THEN
    DO:
      /* Now enable the appropriate columns. 
         The Browse must be made updatable first. */
      hBrowse:READ-ONLY = no.    
      hField = hBrowse:FIRST-COLUMN.
      DO WHILE VALID-HANDLE(hField):
        IF LOOKUP(hField:NAME,cEnabledFields) NE 0 THEN
          hField:READ-ONLY = no.
        hField = hField:NEXT-COLUMN.
      END. /* END DO WHILE hField */
      {set FieldsEnabled yes}.
    END. /* END DO IF cEnabledFields */
    ELSE DO:
      /* SHO Customcode start */
      {get SearchField cSearchFields}.
      ASSIGN cSearchField = IF NUM-ENTRIES(cSearchFields) > 1 THEN 
                                   ENTRY(1,cSearchFields)
                            ELSE cSearchFields.
      {set SearchFld cSearchField}.
      IF NUM-ENTRIES(cSearchFields) > 1 THEN 
      DO:
        hField = hBrowse:FIRST-COLUMN. 
        DO WHILE VALID-HANDLE(hField):
          IF LOOKUP(hField:NAME,cSearchFields) NE 0 THEN
            ASSIGN iSearchField = iSearchField + 1
                   hField:LABEL = hField:LABEL + ' *':U
                   hField:COLUMN-BGCOLOR = IF iSearchField = 1 THEN 9  ELSE 15
                   hField:COLUMN-FGCOLOR = IF iSearchField = 1 THEN 10 ELSE 0.
          hField = hField:NEXT-COLUMN.
        END.
        hBrowse:ALLOW-COLUMN-SEARCHING = TRUE.
      END.
      
      /* SHO Customcode end */
    END.
    
  END.   /* END DO IF NUM-COLUMNS = 0 -- "dynamic" browser */

  /* We need to set expandable to TRUE here when CalcWidth is TRUE before
     the browse is viewed so that calcWidth can calculate column widths
     correctly. */
  {get CalcWidth lCalcWidth}.
  IF NOT (cUIBMode BEGINS "Design":U) AND lCalcWidth THEN hBrowse:EXPANDABLE = FALSE.

  {get QueryObject lQueryObject}.
  /* We need to set CheckLastOnOpen to TRUE so that LastDBRowIdent is set
     when the query is opened, we can then check the value of LastDBRowIdent
     in fetchNext to determine if we have just moved to the last row in 
     the query, if we have then QueryPosition can be set properly */
  IF lQueryObject THEN
    {set CheckLastOnOpen TRUE}. 

  RUN SUPER. 
  IF RETURN-VALUE = "ADM-ERROR":U THEN
    RETURN "ADM-ERROR":U.

  /* If this object or its parent is in design mode, then we don't need to
     open the query or do any of the rest of this initialization code. */
  
  IF cUIBMode BEGINS "Design":U
    THEN RETURN.
  
  /* If we have no TableIO-Source, or if it's an Update panel in "Update" mode,
     or if there's no Update-Target, then the Browse should be disabled. */
  {get SaveSource lSaveSource}.
  {get UpdateTarget cTarget}.
  IF (NOT lSaveSource) OR (cTarget = "":U) THEN
    RUN disableFields IN TARGET-PROCEDURE('All':U).
    
  {get DataSource hDataSource}.
  {get BrowseHandle hBrowse}.
  {get QueryObject lQueryObject}.
  hBrowse:CREATE-ON-ADD = TRUE.
  hBrowse:SET-REPOSITIONED-ROW (INT(hBrowse:DOWN / 2),"CONDITIONAL":U).

  IF lQueryObject THEN
  DO:
    {get ForeignFields cFields}.
    /* This browser is browsing its own db query. If there's no other DataSource
       dependency and we're not in design mode, open that query. */
    IF (NOT VALID-HANDLE(hDataSource) AND (NOT cUIBMode BEGINS "Design":U))
        OR cFields = "":U
      THEN {fn openQuery}.
    /* Otherwise if there's a DataSource, find out if there's a row waiting
       for us; if there is, dataAvailable will open our dependent query. */
    ELSE IF VALID-HANDLE(hDataSource) THEN
      RUN dataAvailable In TARGET-PROCEDURE ("DIFFERENT":U).
    hDataQuery = hBrowse:QUERY.
    IF hDataQuery:NUM-RESULTS > 0 THEN
      {set RecordState 'RecordAvailable':U}.
  END.   /* END Do for QueryObject */ 
  ELSE IF VALID-HANDLE(hDataSource) THEN
  DO:
    /* Reassign the Browse to use the Data Object's query. */
    {get DataHandle hdataQuery hDataSource} NO-ERROR.  /* NO-ERROR for design*/
    IF VALID-HANDLE(hDataQuery) THEN
    DO:
      {get DataQueryBrowsed lQueryBrowsed hDataSource}.
      IF lQueryBrowsed THEN
      DO:
        DYNAMIC-FUNCTION("showMessage":u IN TARGET-PROCEDURE,
          "SDO query cannot be browsed by more than one SmartDataBrowser.":U).
        RETURN "ADM-ERROR":U.
      END.

      /* Else go ahead and attach the query and set the source's property.*/
      IF NOT lDynamic THEN       /* If dynamic, this has been done above. */
        hBrowse:QUERY = hDataQuery.
      {set DataQueryBrowsed yes hDataSource}. 
      
      RUN 'dataAvailable':U IN TARGET-PROCEDURE ('DIFFERENT':U).
    END.     /* END DO IF VALID-HANDLE */
  END.       /* END DO for non-QueryObject */
  
  /* Initialize the list of handles of the browse fields, 
     for displayFields and updateRecord to use. 
     Also set a similar list of the field names for updateRecord to use. 
     Also a list of Enabled Field handles for enable/disableFields,
       and a list of any fields to be enabled for Create. */
  IF VALID-HANDLE(hBrowse) THEN
  DO:           /* SKip all this at design time or when there's no query yet. */
    {get EnabledFields cEnabledFields}.
    hFrameField = hBrowse:FIRST-COLUMN.

    /* SHO Customcode end */
    DO WHILE VALID-HANDLE(hFrameField):
      cFieldHandles = cFieldHandles + 
        (IF cFieldHandles NE "":U THEN "," ELSE "":U) + STRING(hFrameField).
      IF LOOKUP(hFrameField:NAME, cEnabledFields) NE 0 THEN
        cEnabledHandles = cEnabledHandles + 
          (IF cEnabledHandles NE "":U THEN ",":U ELSE "":U) 
            + STRING(hFrameField).
      hFrameField = hFrameField:NEXT-COLUMN.
    END.
    {set EnabledHandles cEnabledHandles}.
    {set CreateHandles cCreateHandles}.
    {set FieldHandles cFieldHandles}.
    
    /* If there is a SearchField, then allocate the first line of the frame
       to it and define the label and fill-in for it. */   
    
    IF cSearchField NE "":U AND cSearchField NE ? THEN
    DO:
      {get ContainerHandle hFrame}.    /* Frame handle to put the widgets in. */
      /* NOTE: This resorts the query by the SearchField. */
      cColumn = {fnarg columnDbColumn cSearchField hDataSource}.
      cSortField = ENTRY(NUM-ENTRIES(cColumn, ".":U), cColumn, ".":U).

      IF cSortField <> "":U THEN
      DO:      
        ASSIGN hBrowse:HEIGHT = hBrowse:HEIGHT - 1  /* Shorten the browse */
               hBrowse:ROW = 2                     /* and place at row 2 */ 
               cSearchLabel = {fnarg columnLabel cSearchfield hDataSource}
                              + ": ":U.          
        CREATE TEXT hSearchLabel            /* Label for the field */ 
          ASSIGN 
           SCREEN-VALUE = cSearchLabel
           FORMAT = "X(":U + STRING(LENGTH(cSearchLabel)) + ")":U
           ROW     = 1
           WIDTH   = FONT-TABLE:GET-TEXT-WIDTH(cSearchLabel)
           HEIGHT  = 1
           COL     = 2
           FRAME   = hFrame
           SCREEN-VALUE = cSearchLabel
           HIDDEN       = FALSE
           PRIVATE-DATA = 'SearchLabel':U.
  
        CREATE FILL-IN hSearchField
          ASSIGN DATA-TYPE = dynamic-function('columnDataType':U IN hDataSource, 
            cSearchField)
           FORMAT = dynamic-function('columnFormat':U IN hDataSource, 
                                      cSearchField)
           WIDTH  = hBrowse:WIDTH - FONT-TABLE:GET-TEXT-WIDTH(cSearchLabel) - 40
           ROW = 1 
           COL = hSearchLabel:COL + hSearchLabel:WIDTH 
           FRAME = hFrame
           VISIBLE = yes 
           SENSITIVE = yes
           PRIVATE-DATA = 'SearchField':U
           SIDE-LABEL-HANDLE = hSearchLabel
           TRIGGERS: 
             ON ANY-PRINTABLE
             PERSISTENT RUN searchTrigger IN TARGET-PROCEDURE. 
           END TRIGGERS.
        {set SearchHandle hSearchField}.
        /* When there is a SearchField, opening the query visualizes the 
           browse due to code in DataAvailable (browse.i) that applies "home"
           to the browse.  If HideOnInit is true, we need to hide the object.
           If OpenOnInit is FALSE then we do not want to open the query here
           at all. */
        {set QuerySort cSortField hDataSource}. 
        {get OpenOnInit lOpenOnInit hDataSource}.
        IF lOpenOnInit THEN 
          {fn openQuery hDataSource}.
        {get HideOnInit lHideOnInit}.
        IF lHideOnInit THEN 
          RUN hideObject IN TARGET-PROCEDURE.
      END. /* if cSortfield <> '':U */

/*
      /* When there is a SearchField, opening the query visualizes the 
         browse due to code in DataAvailable (browse.i) that applies "home"
         to the browse.  If HideOnInit is true, we need to hide the object */
      {get HideOnInit lHideOnInit}.
      IF lHideOnInit THEN RUN hideObject IN TARGET-PROCEDURE.
*/       
    END.      /* END IF SearchField */
    
    IF lCalcWidth THEN RUN calcWidth IN TARGET-PROCEDURE.
    {get NumDown iNumDown}. 
     IF iNumDown > 0 THEN RUN setDown IN TARGET-PROCEDURE (INPUT iNumDown).

    /* If this browse is dynamic we need to select the first row because it 
       isn't done automatically and the first row needs to be selected when
       working with navigation panels.  We need the NO-ERROR in case the
       SDO is initialized after the browser to avoid errors about not being
       able to select-row when there are no rows in the browser.  */
    IF lDynamic THEN hBrowse:SELECT-ROW(1) NO-ERROR.


    /* We initially set MAX-DATA-GUESS to Rows to Batch, MAX-DATA-GUESS
       later gets adjusted by calls to assignMaxGuess from data.p's 
       batch processing. */
    {get RowsToBatch iRowsToBatch hDataSource}.
    ASSIGN hBrowse:MAX-DATA-GUESS = iRowsToBatch.

  END.        /* END IF VALID-HANDLE(hBrowse) */ 
  ghTargetProcedure = ?.         /* 9.1B: reset local storage of this. */  
  RETURN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-searchTrigger) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE searchTrigger Procedure 
PROCEDURE searchTrigger :
/*------------------------------------------------------------------------------
  Purpose:     This is the procedure run from the trigger on the SearchField
               for the SmartDataBrowser, if one has been defined. It repositions 
               the query to the first row GE the value requested 
               (SearchValue property).
  Parameters:  <none>
------------------------------------------------------------------------------*/

  DEFINE VARIABLE hSource      AS HANDLE    NO-UNDO.
  DEFINE VARIABLE cSearchField AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cDataType    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cRowIdent    AS CHARACTER NO-UNDO.
  
  /* First we must capture the keystroke which fired the trigger. */
  APPLY LAST-KEY.

  {get DataSource hSource}.
  {get SearchFld cSearchField}.
  cDataType = dynamic-function('columnDataType':U IN hSource, cSearchField).
  cRowIdent = dynamic-function('rowidWhere':U In hSource,
    cSearchField + ' >= ':U + 
      (IF cDataType BEGINS "CHAR":U OR cDataType = "DATE":U THEN "'":U ELSE "":U)
      + SELF:SCREEN-VALUE + 
      (IF cDataType BEGINS "CHAR":U OR cDataType = "DATE":U THEN "'":U ELSE "":U)).
  IF cRowIdent NE ? THEN
    dynamic-function('fetchRowIdent' IN hSource, cRowIdent, '':U).
  
  /* Now we must throw away the krystroke event to avoid getting double
     characters in the fill-in. */
  RETURN NO-APPLY.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setDown) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE setDown Procedure 
PROCEDURE setDown :
/*------------------------------------------------------------------------------
  Purpose:     Sets the down attribute for the browse and resizes the browse 
               appropriately.
  Parameters:  piNumDown AS INTEGER
  Notes:       Called from initializeObject for dynamic SmartDataBrowsers.
  
               SHO customization: in first call to resizeobject first
                       parameter + 2 changed to + 5 because previous code
                       gave an errormessage with a columnlabel of 2 lines
                       in a search-browser.
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER piNumDown AS INTEGER NO-UNDO.

DEFINE VARIABLE hBrowse AS HANDLE NO-UNDO.

  {get BrowseHandle hBrowse}.
  hBrowse:VISIBLE = TRUE.

  RUN resizeObject IN TARGET-PROCEDURE ((piNumDown * (hBrowse:ROW-HEIGHT + 0.2)) + 5,
                                        hBrowse:WIDTH).
  /* There is a core bug where if down is already set to the number we are trying to 
     set it to then setting down doesn't have any affect on height - which is what
     we need to have adjusted to get rid of any extra space at the bottom.  So when 
     down is equal to what we are about to set it to then we need to set it twice for
     it to have the correct affect. */  

  IF hBrowse:DOWN = piNumDown THEN hBrowse:DOWN = piNumDown - 1 NO-ERROR.
  hBrowse:DOWN = piNumDown NO-ERROR.
  
  RUN resizeObject IN TARGET-PROCEDURE (hBrowse:ROW - 1 + hBrowse:HEIGHT, hBrowse:WIDTH).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-getSearchFld) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getSearchFld Procedure 
FUNCTION getSearchFld RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cSearchFld AS CHARACTER NO-UNDO.

  {get SearchFld cSearchFld}.
  RETURN cSearchFld.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-ModifySearchfield) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ModifySearchfield Procedure 
FUNCTION ModifySearchfield RETURNS LOGICAL
  (INPUT cSearchField AS CHARACTER) :
/*------------------------------------------------------------------------------
  Purpose:  SHO function to modify the searchfield in a dynbrowser-instance
            and re-open the query. This function is called from within 
            a start-search trigger in dynbrowser.w
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VARIABLE hWidget          AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hFrame           AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hSearchLabel     AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hSearchField     AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hDataSource      AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hBrowse          AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hAppServer       AS HANDLE    NO-UNDO.
  DEFINE VARIABLE cSearchLabel     AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cDataQuerySort   AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cDataQueryString AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lHideOnInit      AS LOGICAL   NO-UNDO.    

  {get ContainerHandle hFrame}.    
  {get BrowseHandle hBrowse}.
  {get DataSource hDataSource}.
  {set SearchFld cSearchField}.
  
  /* NOTE: This resorts the query by the SearchField. */

  ASSIGN hWidget    = hFrame:FIRST-CHILD
         hWidget    = hWidget:FIRST-CHILD.
  DO WHILE VALID-HANDLE(hWidget).
    IF hWidget:PRIVATE-DATA = 'SearchLabel':U THEN
      ASSIGN hSearchLabel = hWidget.
    ELSE IF hWidget:PRIVATE-DATA = 'SearchField':U THEN
      ASSIGN hSearchField = hWidget.
    hWidget = hWidget:NEXT-SIBLING.
  END.

  ASSIGN cDataQueryString = DYNAMIC-FUNCTION('getDataQueryString':U IN hDataSource) 
         cDataQueryString = IF INDEX(cDataQueryString,"INDEXED-REPOSITION":U) NE 0 THEN
                              REPLACE(cDataQueryString,"INDEXED-REPOSITION":U,'':U)
                            ELSE cDataQueryString
         cDataQuerySort   = ' BY ':U + cSearchField
         hAppServer       = DYNAMIC-FUNCTION('getASHandle':U IN hDataSource).
         
  DYNAMIC-FUNCTION('setDataQuerySort':U IN hDataSource,cDataQuerySort).
  DYNAMIC-FUNCTION('setDataQueryString':U IN hDataSource,cDataQueryString).
  /* local rowidwhere in sdo (runs on server) needs cDataQuerySort too: */
  IF VALID-HANDLE(hAppServer) THEN DO:
    DYNAMIC-FUNCTION('setDataQuerySort':U IN hAppServer,cDataQuerySort).
    DYNAMIC-FUNCTION('setDataQueryString':U IN hAppServer,cDataQueryString).
  END.
 
  DYNAMIC-FUNCTION('openQuery':U IN hDataSource).
  
  DELETE WIDGET hSearchField.
  ASSIGN cSearchLabel              = {fnarg columnLabel cSearchfield hDataSource} + ": ":U
         hSearchLabel:FORMAT       = "X(":U + STRING(MAX(1,LENGTH(cSearchLabel))) + ")":U
         hSearchLabel:WIDTH        = FONT-TABLE:GET-TEXT-WIDTH(cSearchLabel)
         hSearchLabel:SCREEN-VALUE = cSearchLabel.

  CREATE FILL-IN hSearchField
    ASSIGN DATA-TYPE   = DYNAMIC-FUNCTION('columnDataType':U IN hDataSource, 
                                           cSearchField)
     FORMAT            = DYNAMIC-FUNCTION('columnFormat':U IN hDataSource, 
                                           cSearchField)
     WIDTH             = hBrowse:WIDTH - FONT-TABLE:GET-TEXT-WIDTH(cSearchLabel) - 40
     ROW               = 1 
     COL               = hSearchLabel:COL + hSearchLabel:WIDTH 
     FRAME             = hFrame
     VISIBLE           = yes 
     SENSITIVE         = yes
     PRIVATE-DATA      = 'SearchField':U
     SIDE-LABEL-HANDLE = hSearchLabel
     TRIGGERS: 
       ON ANY-PRINTABLE
       PERSISTENT RUN searchTrigger IN TARGET-PROCEDURE. 
     END TRIGGERS.
  {set SearchHandle hSearchField}.
  /* When there is a SearchField, opening the query visualizes the 
     browse due to code in DataAvailable (browse.i) that applies "home"
     to the browse.  If HideOnInit is true, we need to hide the object */
  {get HideOnInit lHideOnInit}.
  IF lHideOnInit THEN RUN hideObject IN TARGET-PROCEDURE.
  
  hBrowse:SELECT-ROW(1) NO-ERROR.
  
  RETURN FALSE.   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setSearchFld) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setSearchFld Procedure 
FUNCTION setSearchFld RETURNS LOGICAL
  ( pcSearchFld AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  {set SearchFld pcSearchFld}. 
  RETURN TRUE.   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

