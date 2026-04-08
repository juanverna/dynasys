&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12
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

DEFINE VARIABLE hxPrint         AS INT  NO-UNDO.        /* xPrint DLL Handle */
DEFINE VARIABLE l-preview       AS LOGICAL NO-UNDO.     /* Flag para preview de documentos */

DEFINE STREAM bxPrint.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD centerText Include 
FUNCTION centerText RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD decimalALign Include 
FUNCTION decimalALign RETURNS CHARACTER
  ( myText as char, myFont as char, myLength as decimal )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD endLink Include 
FUNCTION endLink RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getbackGround Include 
FUNCTION getbackGround RETURNS CHARACTER
  ( /* parameter-definitions */ A as CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD linkto Include 
FUNCTION linkto RETURNS CHARACTER
  ( /* parameter-definitions */ A as char)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD mailto Include 
FUNCTION mailto RETURNS CHARACTER
  ( /* parameter-definitions */ A as char)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD reduce Include 
FUNCTION reduce RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD rightJustify Include 
FUNCTION rightJustify RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal)  FORWARD.

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE loadxPrint Include 
PROCEDURE loadxPrint :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*         Run loadLibraryA("{&xPrintPATH}xPrint.dll", output hxPrint). */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE unloadxPrint Include 
PROCEDURE unloadxPrint :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* DEF VAR xretCode    AS INT NO-UNDO.            */
/*                                                */
/*     Run freeLibrary(hxPrint, OUTPUT xretCode). */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE windowsAPI Include 
PROCEDURE windowsAPI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

PROCEDURE LoadLibraryA EXTERNAL "KERNEL32" :
  DEFINE INPUT  PARAMETER libname AS CHAR.
  DEFINE RETURN PARAMETER hproc   AS LONG.
END PROCEDURE.

PROCEDURE FreeLibrary EXTERNAL "KERNEL32" :
  DEFINE INPUT  PARAMETER hproc       AS LONG.
  DEFINE RETURN PARAMETER ReturnValue AS LONG.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE xPrintAPI Include 
PROCEDURE xPrintAPI :
/*------------------------------------------------------------------------------
  Purpose:     
  PARAMETERs:  <none>
  Notes:       March 2002: all exteranl procedures are now PERSISTENT
------------------------------------------------------------------------------*/

END PROCEDURE.

/*  xPRINT (4GL) entry points
    =======================*/
    
    
PROCEDURE printFile EXTERNAL "{&xPrintPATH}xPrint.dll"           PERSISTENT :
    DEF INPUT PARAMETER A AS CHAR.
    END.

PROCEDURE printFileStat EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF INPUT PARAMETER  A AS CHAR.
    DEF OUTPUT PARAMETER O AS LONG.
    END.
        
PROCEDURE printPDF EXTERNAL "{&xPrintPATH}xPrint.dll"            PERSISTENT :
    DEF INPUT PARAMETER A AS CHAR.
    DEF INPUT PARAMETER B AS CHAR.
    DEF INPUT PARAMETER C AS CHAR.
    END.

PROCEDURE getPrinterList EXTERNAL "{&xPrintPATH}xPrint.dll"      PERSISTENT :
    DEF INPUT PARAMETER L   AS LONG.
    DEF INPUT PARAMETER A   AS MEMPTR.
    END.    

PROCEDURE getPrinterFonts EXTERNAL "{&xPrintPATH}xPrint.dll"     PERSISTENT :
    DEF INPUT PARAMETER L   AS LONG.
    DEF INPUT PARAMETER A   AS MEMPTR.
    END.
    
PROCEDURE getTextWidth EXTERNAL "{&xPrintPATH}xPrint.dll"        PERSISTENT :
    DEF INPUT PARAMETER myText   AS CHAR.
    DEF INPUT PARAMETER myFont   AS CHAR.
    DEF OUTPUT PARAMETER lengthInPixels  AS LONG.
    END.
        
PROCEDURE getPrinterRes EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF OUTPUT PARAMETER PrinterResolution  AS LONG.
    END.

PROCEDURE getScreenRes EXTERNAL "{&xPrintPATH}xPrint.dll"        PERSISTENT :
    DEF OUTPUT PARAMETER ScreenResolution  AS LONG.
    END.
    
PROCEDURE getScreenFonts EXTERNAL "{&xPrintPATH}xPrint.dll"      PERSISTENT :
    DEF INPUT PARAMETER L   AS LONG.
    DEF INPUT PARAMETER A   AS MEMPTR.
    END.
    
PROCEDURE fontDialog EXTERNAL "{&xPrintPATH}xPrint.dll"          PERSISTENT :
    DEF INPUT PARAMETER L   AS LONG.
    DEF INPUT PARAMETER A   AS MEMPTR.
    DEF OUTPUT PARAMETER R  AS LONG.
    END.
    
PROCEDURE getTextHeight EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF INPUT  PARAMETER myText          AS CHAR.
    DEF INPUT  PARAMETER myFont          AS CHAR.
    DEF INPUT  PARAMETER lengthInPixels  AS LONG.
    DEF OUTPUT PARAMETER numberOfLines   AS LONG.
    END.
    
PROCEDURE xPrintVersion EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF INPUT PARAMETER versionNumber   AS MEMPTR.
    END.

PROCEDURE getImageDim   EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF INPUT PARAMETER A   AS CHAR.
    DEF INPUT-OUTPUT PARAMETER H   AS LONG.
    DEF INPUT-OUTPUT PARAMETER W   AS LONG.
    END.

PROCEDURE getLPI EXTERNAL "{&xPrintPATH}xPrint.dll"              PERSISTENT :
    DEF INPUT PARAMETER A AS CHAR.
    DEF INPUT PARAMETER B AS MEMPTR.
    END.

PROCEDURE printerDialog EXTERNAL "{&xPrintPATH}xPrint.dll"       PERSISTENT :
    DEF INPUT PARAMETER A   AS MEMPTR.
    END.

PROCEDURE getPrinter EXTERNAL "{&xPrintPATH}xPrint.dll"          PERSISTENT :
    DEF INPUT PARAMETER A   AS MEMPTR.
    END.

PROCEDURE setPrinter EXTERNAL "{&xPrintPATH}xPrint.dll"          PERSISTENT :
    DEF INPUT PARAMETER A   AS CHAR.
    END.

PROCEDURE saveFromClipBoard EXTERNAL "{&xPrintPATH}xPrint.dll"   PERSISTENT :
    DEF INPUT PARAMETER  A AS CHAR.
    DEF OUTPUT PARAMETER O AS LONG.
    END.

/*  New 6.3a
    ======*/
PROCEDURE pageCount EXTERNAL "{&xPrintPATH}xPrint.dll"           PERSISTENT :
    DEF INPUT PARAMETER  myFile          AS CHAR.
    DEF OUTPUT PARAMETER numberOfPages   AS LONG.
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION centerText Include 
FUNCTION centerText RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  Feb. 2002 : make usage of the <SAVE> and <RESTORE> tags to allow millimeter
                        setting (<UNITS=MM>)
------------------------------------------------------------------------------*/

def var lengthOfFillChar    as int no-undo.
def var lengthOfText        as int no-undo.
def var NumberOfFillChar    as int no-undo.
def var R                   as INT NO-undo.
def var fillChar            as char no-undo initial " ".
    /* NOTE : if you want to use the '-' char, you have to set the PROGRESS mode to off
              with a </PROGRESS> tag
    */              
def var printerRes          as INT  NO-UNDO.
def var saveEuropean        as char NO-UNDO.
def var returnValue         as char NO-UNDO.  


/* get length of text in pixels             */
        run getTextWidth( myText, myFont, output lengthOfText).

/* how many pixels are in my printable area ? */   
        run getPrinterRes( Output printerRes).
        R = printerRes * myLength.                   /* length of my area in pixels */   
      

/* if fill character is a space, more precision is obtained by <AT> tag than generating spaces.
        (You can comment this lines, because it's xPrint specific.)                                                                        
   =========================================================================================================*/
        if fillchar = " " then do :
            saveEuropean = SESSION:numeric-format.      /* Don't forget the european users !                */
            SESSION:numeric-format = "AMERICAN".        /* for ., setting */
            returnValue = "<AT=,+"
                                + string( (R - lengthofText) / 2 / printerRes )
                                + ">" + myText.

            Session:NUMERIC-FORMAT = saveEuropean.
            return "<SAVE=UNITS><UNITS=IN>" + returnValue + "<RESTORE=UNITS>".
            end.

/* otherwise, return the centered text with fillchar left AND right (if not a space)
   ===============================================================================*/
    /* What's the length of the fill character ?    */      
        run getTextWidth( fillChar, myFont, output lengthOfFillChar).
        
    /* Then the number of fill char to generate can be obtained with    */        
        NumberOfFillChar = (R - lengthOfText) / 2 / lengthOfFillChar.
        
        RETURN fill(fillChar, NumberOfFillChar) + myText 
                    + (if fillchar <> " " then fill(fillchar, NumberOfFillChar) else "")
               .

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION decimalALign Include 
FUNCTION decimalALign RETURNS CHARACTER
  ( myText as char, myFont as char, myLength as decimal ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR I as int NO-UNDO.

        I = MAX( R-INDEX(myText, ","), R-INDEX(myText, ".")).   /* Determine the decimal sign as the rightmost character */

        IF I = 0 THEN                                       /* no sign */
                RETURN rightJustify(myText, myFont, myLength).
        else
                RETURN RightJustify( SUBSTRING(myText, 1, I), myFont, myLength) + SUBSTRING(myText, I + 1).

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION endLink Include 
FUNCTION endLink RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  RETURN "<HTML-INSERT=\</A\>>".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getbackGround Include 
FUNCTION getbackGround RETURNS CHARACTER
  ( /* parameter-definitions */ A as CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
Def var ReturnLines     as CHAR NO-UNDO.
def var L               as CHAR NO-UNDO.

IF SEARCH(A) = ? THEN DO :
         A = A + ".XPR".
         IF SEARCH(A) = ? THEN
                RETURN "".
         END.

     FILE-INFO:FILE-NAME = A.

     Input stream bxPrint From value(File-INFO:FULL-PATHNAME) NO-ECHO.
     
     Repeat :
           Import stream bxPrint unformatted L.
           
           ReturnLines = ReturnLines + chr(13) + L.
           end.
     
     Input stream bxPrint Close.
           
     Return Substring(ReturnLines, 2).
     end.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION linkto Include 
FUNCTION linkto RETURNS CHARACTER
  ( /* parameter-definitions */ A as char) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  html syntax
            <A HREF=www.4gl.fr>
------------------------------------------------------------------------------*/

  Return 
        "<HTML-INSERT=\<A HREF=~"" + A + "~"\>>".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION mailto Include 
FUNCTION mailto RETURNS CHARACTER
  ( /* parameter-definitions */ A as char) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  html syntax
            <A HREF=mailto:info@4gl.fr>
------------------------------------------------------------------------------*/

  Return 
        "<HTML-INSERT=\<A HREF=mailto:" + A + "\>>".

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION reduce Include 
FUNCTION reduce RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal) :
/*------------------------------------------------------------------------------
  Purpose:  Reduce a text to fit in a given width
    Notes:  
------------------------------------------------------------------------------*/
def var lengthOfText        as INT NO-UNDO.
def var R                   as INT NO-UNDO.          
def var printerRes          as INT  NO-UNDO.

/* how many pixels are in my printable area ? */   
        run getPrinterRes( Output printerRes).
        R = printerRes * myLength.                   /* length of my area in pixels */   


/* get length of text in pixels             */
        run getTextWidth( myText, myFont, output lengthOfText).

DO WHILE R < lengthOfText 
   AND myText > "" :
        mytext = SUBSTRING(myText, 1, LENGTH(myText) - 1).      /* reduce by 1 char */
        run getTextWidth( myText, myFont, output lengthOfText).
        END.
        
RETURN myText.
        
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION rightJustify Include 
FUNCTION rightJustify RETURNS CHARACTER
  ( /* parameter-definitions */ myText as char, myFont as char, myLength as decimal) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

def var lengthOfFillChar    as int no-undo.
def var lengthOfText        as int no-undo.
def var NumberOfFillChar    as int no-undo.
def var R                   as INT NO-undo.
def var fillChar            as char no-undo initial " ".
    /* NOTE : if you want to use the '-' char, you have to set the PROGRESS mode to off
              with a </PROGRESS> tag
    */              
def var printerRes          as INT  NO-UNDO.
def var saveEuropean        as char NO-UNDO.
def var returnValue         as char NO-UNDO.  


/* get length of text in pixels             */
        run getTextWidth( myText, myFont, output lengthOfText).

/* how many pixels are in my printable area ? */   
        run getPrinterRes( Output printerRes).
        R = printerRes * myLength.                   /* length of my area in pixels */   
      

/* if fill character is a space, more precision is obtained by <AT> tag than generating spaces.
        (You can comment this lines, because it's xPrint specific.)                                                                        
   =========================================================================================================*/
        if fillchar = " " then do :
            saveEuropean = SESSION:numeric-format.      /* Don't forget the european users !                */
            SESSION:numeric-format = "AMERICAN".        /* for ., setting */
            returnValue = "<AT=,+"
                                + string( (R - lengthofText)  / printerRes )
                                + ">" + myText.
            Session:numeric-format = saveEuropean.
            RETURN "<SAVE=UNITS><UNITS=IN>" + returnValue + "<RESTORE=UNITS>".
            end.

/* otherwise, return the centered text with fillchar left AND right (if not a space)
   ===============================================================================*/
    /* What's the length of the fill character ?    */      
        run getTextWidth( fillChar, myFont, output lengthOfFillChar).
        
    /* Then the number of fill char to generate can be obtained with    */        
        NumberOfFillChar = (R - lengthOfText) / lengthOfFillChar.
        
        RETURN fill(fillChar, NumberOfFillChar) + myText 
                    + (if fillchar <> " " then fill(fillchar, NumberOfFillChar) else "")
               .

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

