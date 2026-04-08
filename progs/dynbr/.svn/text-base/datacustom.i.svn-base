&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Include 
/*------------------------------------------------------------------------
    File        : datacustom.i
    Purpose     : References the start of the custom super procedure.
                  Allows properties initialization.

    Syntax      : {src/adm2/custom/datacustom.i}

    Description :

    Created     : 06/03/1999
    Notes       : Referenced in {src/adm2/data.i}
  ----------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

 DEFINE VARIABLE ghPersistenProc AS HANDLE    NO-UNDO.
 DEFINE VARIABLE ghAppservlib    AS HANDLE    NO-UNDO.
 DEFINE VARIABLE cQueryString    AS CHARACTER NO-UNDO.

 &GLOBAL-DEFINE EXCLUDE-openQuery X

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
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

/* Starts here the custom super procedure 
   Uncomment to run it */
/* SHO customization according to changes in 9.1B + starting up of appservlib.p */  

  RUN start-super-proc ("adm2/custom/datacustom.p":U).
  {get DataQueryString cQueryString}.
  {get DataHandle ghDataQuery}.
  ghDataQuery:QUERY-PREPARE(cQueryString).   
  IF SOURCE-PROCEDURE = ? THEN DO: /* only run on server: */
    ASSIGN ghPersistenProc = SESSION:FIRST-PROCEDURE.
    DO WHILE VALID-HANDLE(ghPersistenProc):
      IF ghPersistenProc:FILE-NAME = 'appservlib.p' THEN
      DO: 
        ASSIGN ghAppservlib = ghPersistenProc.
        LEAVE.
      END.
      ghPersistenProc = ghPersistenProc:NEXT-SIBLING.
    END.
    IF NOT VALID-HANDLE(ghAppservlib) THEN
       RUN appservlib.p PERSISTENT SET ghAppservlib.
  END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


