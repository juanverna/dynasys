/* ==========================================================
   file:  BrowseForFolder.p
   ========================================================== */
{windows.i}
 
DEFINE INPUT  PARAMETER DialogTitle AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER FolderName  AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER Canceled    AS LOGICAL NO-UNDO.
 
DEF VAR MAX_PATH       AS INTEGER INITIAL 260.
DEF VAR lpbi           AS MEMPTR.  /* pointer to BROWSEINFO structure */
DEF VAR pszDisplayName AS MEMPTR.
DEF VAR lpszTitle      AS MEMPTR.
DEF VAR lpItemIDList   AS INTEGER NO-UNDO.
DEF VAR ReturnValue    AS INTEGER NO-UNDO.
 
SET-SIZE(lpbi)           = 32.
SET-SIZE(pszDisplayName) = MAX_PATH.
SET-SIZE(lpszTitle)      = LENGTH(DialogTitle) + 1.
 
PUT-STRING(lpszTitle,1)  = DialogTitle.
 
PUT-LONG(lpbi, 1) = 0.  /* hwnd for parent */
PUT-LONG(lpbi, 5) = 0.
PUT-LONG(lpbi, 9) = GET-POINTER-VALUE(pszDisplayName).
PUT-LONG(lpbi,13) = GET-POINTER-VALUE(lpszTitle).
PUT-LONG(lpbi,17) = 1. /* BIF_RETURNONLYFSDIRS = only accept a file system directory */
PUT-LONG(lpbi,21) = 0. /* lpfn, callback function */
PUT-LONG(lpbi,25) = 0. /* lParam for lpfn */
PUT-LONG(lpbi,29) = 0.
 
RUN SHBrowseForFolder IN hpApi ( INPUT  GET-POINTER-VALUE(lpbi), 
                                 OUTPUT lpItemIDList ).
 
/* parse the result: */
IF lpItemIDList=0 THEN DO:
   Canceled   = YES.
   FolderName = "".
END.
ELSE DO:
   Canceled = NO.
   FolderName = FILL(" ", MAX_PATH).
   RUN SHGetPathFromIDList IN hpApi(lpItemIDList, 
                                    OUTPUT FolderName,
                                    OUTPUT ReturnValue).
   FolderName = TRIM(FolderName).
END.   
 
/* free memory: */
SET-SIZE(lpbi)=0.
SET-SIZE(pszDisplayName)=0.
SET-SIZE(lpszTitle)=0.
RUN CoTaskMemFree (lpItemIDList).
 
PROCEDURE CoTaskMemFree EXTERNAL "ole32.dll" :
  DEFINE INPUT PARAMETER lpVoid AS LONG.
END PROCEDURE.
