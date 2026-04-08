&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*--------------------------------------------------------------------------
    File        : querycustom.p
    Purpose     : Super procedure to extend query class.

    Syntax      : querycustom.p

    Modified    : 06/03/1999
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

&SCOPED-DEFINE ADMSuper querycustom.p

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-getCustomRowidString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getCustomRowidString Procedure 
FUNCTION getCustomRowidString RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-insertExpression) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD insertExpression Procedure 
FUNCTION insertExpression RETURNS CHARACTER
  (pcWhere      AS CHAR,   
   pcExpression AS CHAR,     
   pcAndOr      AS CHAR) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-newWhereClause) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD newWhereClause Procedure 
FUNCTION newWhereClause RETURNS CHARACTER PRIVATE
  (pcBuffer     AS CHAR,   
   pcExpression AS char,  
   pcWhere      AS CHAR,
   pcAndOr      AS CHAR) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-rowidWhere) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rowidWhere Procedure 
FUNCTION rowidWhere RETURNS CHARACTER
  ( pcWhere AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setCustomRowidString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setCustomRowidString Procedure 
FUNCTION setCustomRowidString RETURNS LOGICAL
  ( pcCustomRowidString AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-whereclauseBuffer) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-EXTERNAL whereclauseBuffer Procedure 
FUNCTION whereclauseBuffer RETURNS CHARACTER PRIVATE
  (pcWhere AS CHAR):
/*------------------------------------------------------------------------------
  Purpose:     Returns the buffername of a where clause expression. 
               This function avoids problems with leading or double blanks in 
               where clauses.
  Parameters:
    pcWhere - Complete where clause for ONE table with or without the FOR 
              keyword. The buffername must be the second token in the
              where clause as in "EACH order OF Customer" or if "FOR" is
              specified the third token as in "FOR EACH order".
  
  Notes:      PRIVATE, used internally in query.p only.
              SHO: no customization, added because of private-status. This function
              is needed in rowidWhere.
------------------------------------------------------------------------------*/
  pcWhere = LEFT-TRIM(pcWhere).
  
  /* Remove double blanks */
  DO WHILE INDEX(pcWhere,"  ":U) > 0:
    pcWhere = REPLACE(pcWhere,"  ":U," ":U).
  END.
  
  RETURN ENTRY(IF pcWhere BEGINS "FOR ":U THEN 3 ELSE 2,pcWhere," ":U).
  
END.

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
         WIDTH              = 20.8.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Procedure 
/* ************************* Included-Libraries *********************** */

{src/adm2/qryprop.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-getCustomRowidString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getCustomRowidString Procedure 
FUNCTION getCustomRowidString RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cCustomRowidString AS CHARACTER NO-UNDO.

  {get CustomRowidString cCustomRowidString}.
  RETURN cCustomRowidString.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-insertExpression) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION insertExpression Procedure 
FUNCTION insertExpression RETURNS CHARACTER
  (pcWhere      AS CHAR,   
   pcExpression AS CHAR,     
   pcAndOr      AS CHAR):                         
/*------------------------------------------------------------------------------
 Purpose:     Inserts an expression into ONE buffer's where-clause.
 Parameters:  
      pcWhere      - Complete where clause with or without the FOR keyword,
                     but without any comma before or after.
      pcExpression - New expression OR OF phrase (Existing OF phrase is replaced)
      pcAndOr      - Specifies what operator is used to add the new expression 
                     to existing ones.
                     - AND (default) 
                     - OR         
 Notes:       The new expression is embedded in parenthesis, but no parentheses
              are placed around the existing one.  
              Lock keywords must be unabbreviated or without -lock (i.e. SHARE
              or EXCLUSIVE.)   
              Any keyword in comments may cause problems.
              This is PRIVATE to query.p.  
              
              SHO: no customization, added because of private-status. This function
              is needed in rowidWhere.
------------------------------------------------------------------------------*/  
  DEFINE VARIABLE cTable        AS CHAR NO-UNDO.  
  DEFINE VARIABLE cRelTable     AS CHAR NO-UNDO.  
  DEFINE VARIABLE cJoinTable    AS CHAR NO-UNDO.  
  DEFINE VARIABLE cWhereOrAnd   AS CHAR NO-UNDO.  
  DEFINE VARIABLE iTblPos       AS INT  NO-UNDO.
  DEFINE VARIABLE iWherePos     AS INT  NO-UNDO.
  DEFINE VARIABLE lWhere        AS LOG  NO-UNDO.
  DEFINE VARIABLE iOfPos        AS INT  NO-UNDO.
  DEFINE VARIABLE iRelTblPos    AS INT  NO-UNDO.  
  DEFINE VARIABLE iInsertPos    AS INT  NO-UNDO.    
  
  DEFINE VARIABLE iUseIdxPos    AS INT  NO-UNDO.        
  DEFINE VARIABLE iOuterPos     AS INT  NO-UNDO.        
  DEFINE VARIABLE iLockPos      AS INT  NO-UNDO.      
  
  DEFINE VARIABLE iByPos        AS INT  NO-UNDO.        
  DEFINE VARIABLE iIdxRePos     AS INT  NO-UNDO.        
           
  ASSIGN 
    cTable        = whereClauseBuffer(pcWhere)
    iTblPos       = INDEX(pcWhere,cTable) + LENGTH(cTable,"CHARACTER":U)
    
    iWherePos     = INDEX(pcWhere," WHERE ":U) + 6    
    iByPos        = INDEX(pcWhere," BY ":U)    
    iUseIdxPos    = INDEX(pcWhere," USE-INDEX ":U)    
    iIdxRePos     = INDEX(pcWhere + " ":U," INDEXED-REPOSITION ":U)    
    iOuterPos     = INDEX(pcWhere + " ":U," OUTER-JOIN ":U)     
    iLockPos      = MAX(INDEX(pcWhere + " ":U," NO-LOCK ":U),
                        INDEX(pcWhere + " ":U," SHARE-LOCK ":U),
                        INDEX(pcWhere + " ":U," EXCLUSIVE-LOCK ":U),
                        INDEX(pcWhere + " ":U," SHARE ":U),
                        INDEX(pcWhere + " ":U," EXCLUSIVE ":U)
                        )    
    iInsertPos    = LENGTH(pcWhere) + 1 
                    /* We must insert before the leftmoust keyword,
                       unless the keyword is Before the WHERE keyword */ 
    iInsertPos    = MIN(
                      (IF iLockPos   > iWherePos THEN iLockPos   ELSE iInsertPos),
                      (IF iOuterPos  > iWherePos THEN iOuterPos  ELSE iInsertPos),
                      (IF iUseIdxPos > iWherePos THEN iUseIdxPos ELSE iInsertPos),
                      (IF iIdxRePos  > iWherePos THEN iIdxRePos  ELSE iInsertPos),
                      (IF iByPos     > iWherePos THEN iByPos     ELSE iInsertPos)
                       )                                                        
    lWhere        = INDEX(pcWhere," WHERE ":U) > 0 
    cWhereOrAnd   = (IF NOT lWhere          THEN " WHERE ":U 
                     ELSE IF pcAndOr = "":U OR pcAndOr = ? THEN " AND ":U 
                     ELSE " ":U + pcAndOr + " ":U) 
    iOfPos        = INDEX(pcWhere," OF ":U).
  
  IF LEFT-TRIM(pcExpression) BEGINS "OF ":U THEN 
  DO:   
    /* If there is an OF in both the join and existing query we replace the 
       table unless they are the same */      
    IF iOfPos > 0 THEN 
    DO:
      ASSIGN
        /* Find the table in the old join */               
        cRelTable  = ENTRY(1,LEFT-TRIM(SUBSTRING(pcWhere,iOfPos + 4))," ":U)      
        /* Find the table in the new join */       
        cJoinTable = SUBSTRING(LEFT-TRIM(pcExpression),3).
      
      IF cJoinTable <> cRelTable THEN
        ASSIGN 
         iRelTblPos = INDEX(pcWhere + " ":U," ":U + cRelTable + " ":U) 
                      + 1                            
         SUBSTRING(pcWhere,iRelTblPos,LENGTH(cRelTable)) = cJointable. 
    END. /* if iOfPos > 0 */ 
    ELSE 
      SUBSTRING(pcWhere,iTblPos,0) = " ":U + pcExpression.                                                                
  END. /* if left-trim(pcExpression) BEGINS "OF ":U */
  ELSE             
    SUBSTRING(pcWhere,iInsertPos,0) = cWhereOrAnd 
                                      + "(":U 
                                      + pcExpression 
                                      + ")":U. 
                                            
  RETURN RIGHT-TRIM(pcWhere).
  
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-newWhereClause) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION newWhereClause Procedure 
FUNCTION newWhereClause RETURNS CHARACTER PRIVATE
  (pcBuffer     AS CHAR,   
   pcExpression AS char,  
   pcWhere      AS CHAR,
   pcAndOr      AS CHAR):
/*------------------------------------------------------------------------------
  Purpose:     Inserts a new expression to query's prepare string for a specified 
               buffer.
  Parameters:  pcBuffer     - Which buffer.
               pcExpression - The new expression. 
               pcWhere      - The current query prepare string.
               pcAndOr      - Specifies what operator is used to add the new
                              expression to existing expression(s)
                              - AND (default) 
                              - OR                                                
  Notes:       PRIVATE to query.p   
               SHO: no customization, added because of private-status. This function
                    is needed in rowidWhere.          
------------------------------------------------------------------------------*/
 DEFINE VARIABLE iComma      AS INT    NO-UNDO. 
 DEFINE VARIABLE iCount      AS INT    NO-UNDO.
 DEFINE VARIABLE iStart      AS INT    NO-UNDO.
 DEFINE VARIABLE iLength     AS INT    NO-UNDO.
 DEFINE VARIABLE iEnd        AS INT    NO-UNDO.
 DEFINE VARIABLE cWhere      AS CHAR   NO-UNDO.
 DEFINE VARIABLE cString     AS CHAR   NO-UNDO.
 DEFINE VARIABLE cFoundWhere AS CHAR   NO-UNDO.
 DEFINE VARIABLE cNextWhere  AS CHAR   NO-UNDO.
 DEFINE VARIABLE hQuery      AS HANDLE NO-UNDO.

 ASSIGN
   cString = pcWhere
   iStart  = 1.          

 DO WHILE TRUE:
   
   iComma  = INDEX(cString,","). 
   
   /* If a comma was found we split the string into cFoundWhere and cNextwhere */  
   IF iComma <> 0 THEN 
     ASSIGN
       cFoundWhere = cFoundWhere + SUBSTR(cString,1,iComma)
       cNextWhere  = SUBSTR(cString,iComma + 1)     
       iCount      = iCount + iComma.       
   ELSE 
     
     /* cFoundWhere is blank if this is the first time or if we have moved on 
        to the next buffers where clause
        If cFoundwhere is not blank the last comma that was used to split 
        the string into cFoundwhere and cNextwhere was not a join, 
        so we must set them together again.   
     */     
     cFoundWhere = IF cFoundWhere = "":U 
                   THEN cString
                   ELSE cFoundWhere + cNextwhere.
          
   /* We have a complete table whereclause if there are no more commas
      or the next whereclause starts with each,first or last */    
   IF iComma = 0 
   OR CAN-DO("EACH,FIRST,LAST":U,ENTRY(1,TRIM(cNextWhere)," ":U)) THEN
   DO:
     /* Remove comma or period before inserting the new expression */
     ASSIGN
       cFoundWhere = RIGHT-TRIM(cFoundWhere,",.":U) 
       iLength     = LENGTH(cFoundWhere).
     
     IF whereClauseBuffer(cFoundWhere) = pcBuffer  THEN
     DO:   
       SUBSTR(pcWhere,iStart,iLength) = insertExpression(cFoundWhere,
                                                         pcExpression,
                                                         pcAndOr).           
       LEAVE.
     END.
     ELSE
       /* We're moving on to the next whereclause so reset cFoundwhere */ 
       ASSIGN      
         cFoundWhere = "":U                     
         iStart      = iCount + 1.      
     
     /* No table found and we are at the end so we need to get out of here */  
     IF iComma = 0 THEN 
     DO:
       /* (Buffer is not in query) Is this a run time error ? */.
       LEAVE.    
     END.
   END. /* if iComma = 0 or can-do(EACH,FIRST,LAST */
   cString = cNextWhere.  
 END. /* do while true. */
 RETURN pcWhere.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-rowidWhere) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rowidWhere Procedure 
FUNCTION rowidWhere RETURNS CHARACTER
  ( pcWhere AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:    Returns the ROWID (converted to a character string) of the first 
              database query row satisfying the where clause.  In the case of a 
              join, only the rowid of the first table in the join will be 
              returned and the expression in pcWhere can only reference that 
              table.
 
  Parameters:
    pcWhere - The where clause to apply to the database query to fetch the
              first record whose ROWID will be returned.
  
  Notes:      The ROWID is returned as a string both in anticipation of it
              being used as an argument to fetchRowIdent, and also to allow
              this function to be invoked from outside Progress.
              
              SHO customization: if the new property CustomRowidString is filled,
                                 the newWhereClause is set accordingly.
------------------------------------------------------------------------------*/
  DEFINE VARIABLE hQuery     AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hBuffer    AS HANDLE    NO-UNDO.
  DEFINE VARIABLE hRowQuery  AS HANDLE    NO-UNDO.
  DEFINE VARIABLE cQueryText AS CHARACTER NO-UNDO.
  DEFINE VARIABLE lOK        AS LOGICAL   NO-UNDO.
  DEFINE VARIABLE cBuffer    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i          AS INTEGER   NO-UNDO.
  DEFINE VARIABLE lDbQualify AS LOG       NO-UNDO.
  DEFINE VARIABLE cRowId     AS CHARACTER NO-UNDO INIT ?.
  DEFINE VARIABLE cRowIds    AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cWhere     AS CHARACTER NO-UNDO.

    {get QueryHandle hQuery}.
    {get UseDbQualifier lDbQualify}.

    IF NOT hQuery:IS-OPEN THEN RETURN ?.

    {get QueryWhere cQueryText}.

    CREATE QUERY hRowQuery.     /* Get a query to do the "FIND" */
    /* Create buffers and add to the query.
       we must create buffers to avoid conflict with the original query
       in case it's PRESELECT (non-indexed sort) */
    DO i = 1 TO hQuery:NUM-BUFFERS:
      ASSIGN
        hBuffer = hQuery:GET-BUFFER-HANDLE(i)
        cBuffer = hBuffer:NAME.

      CREATE BUFFER hBuffer FOR TABLE cBuffer BUFFER-NAME cBuffer.
      lOK = hRowQuery:ADD-BUFFER(hBuffer).

      /* Add the where clause to the first buffer's existing query */
      IF lOK AND i = 1 THEN DO:
        {get CustomRowidString cRowIds}.
        ASSIGN
          cBuffer =  (IF lDbQualify THEN hBuffer:DBNAME + ".":U ELSE "":U)
                      + cBuffer
          cWhere  = IF cRowIds = '' OR cRowIds = ? THEN pcWhere 
                    ELSE ' LOOKUP(string(rowid(' + cBuffer + ')),' + '~"' + cRowids + '~") NE 0 '
                   
          cQueryText = newWhereClause(cBuffer,cWhere,cQueryText,"":U).
      END.

    END.  /* do i = 1 */

    IF lOK THEN
    DO:
      lOK = hRowQuery:QUERY-PREPARE(cQueryText) NO-ERROR.
      IF lOK THEN lOK = hRowQuery:QUERY-OPEN().
      IF lOK THEN lOK = hRowQuery:GET-FIRST().
      
      ASSIGN hBuffer = hRowQuery:GET-BUFFER-HANDLE(1)
             cRowId  = IF lOK AND cRowIds NE '' THEN ENTRY(1,cRowIds)
                       ELSE IF lOK AND hBuffer:AVAILABLE
                       THEN STRING(hBuffer:ROWID)
                       ELSE ?.
    END. /* END DO IF lOK */

    /* delete the temporary buffers */
    DO i = 1 TO hRowQuery:NUM-BUFFERS:
      ASSIGN
        hBuffer = hRowQuery:GET-BUFFER-HANDLE(i).
      DELETE OBJECT hBuffer.
    END. /* do i = 1 to hRowQuery:num-buffers */
    DELETE OBJECT hRowQuery.

    RETURN cRowid.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setCustomRowidString) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setCustomRowidString Procedure 
FUNCTION setCustomRowidString RETURNS LOGICAL
  ( pcCustomRowidString AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  {set CustomRowidString pcCustomRowidString}. 
  RETURN TRUE.   
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

