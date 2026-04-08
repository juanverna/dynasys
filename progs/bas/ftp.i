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
/* handle to internet session */
  define var hInternetSession   as  int  no-undo.
/* handle to the ftp session inside the internet connection */
  define var hFTPSession        as  int  no-undo.
/* current directory which we are processing */
  define var cCurrentDir        as  char no-undo.

&GLOBAL  MAX_PATH 260

&GLOBAL FILE_ATTRIBUTE_NORMAL  128

/* Internet constants */

&GLOBAL INTERNET_OPEN_TYPE_PRECONFIG    0
/* indicates to use config information from registry */
/*536870912*/
&GLOBAL INTERNET_FLAG_EXISITING_CONNECT 536870912
/* used for ftp connections*/
&GLOBAL INTERNET_FLAG_PASSIVE   134217728        

/* Flags for FTP transfer mode */
&GLOBAL  FTP_TRANSFER_TYPE_ASCII  1   /* 0x00000001 */
&GLOBAL  FTP_TRANSFER_TYPE_BINARY 2   /* 0x00000002 */


&GLOBAL INTERNET_DEFAULT_FTP_PORT     21
&GLOBAL INTERNET_DEFAULT_GOPHER_PORT  70
&GLOBAL INTERNET_DEFAULT_HTTP_PORT    80
&GLOBAL INTERNET_DEFAULT_HTTPS_PORT  443
&GLOBAL INTERNET_DEFAULT_SOCKS_PORT 1080

/* Type of service to access */
&GLOBAL INTERNET_SERVICE_FTP    1
&GLOBAL INTERNET_SERVICE_GOPHER 2
&GLOBAL INTERNET_SERVICE_HTTP   3

PROCEDURE InternetConnectA EXTERNAL "wininet.dll" PERSISTENT:
  define input parameter  hInternetSession  as  long.
  define input parameter  lpszServerName    as  char.
  define input parameter  nServerPort       as  long.
  define input parameter  lpszUserName      as  char.
  define input parameter  lpszPassword      as  char.
  define input parameter  dwService         as  long.
  define input parameter  dwFlags           as  long.
  define input parameter  dwContext         as  long.
  define return parameter hInternetConnect  as  long.
END.

PROCEDURE InternetGetLastResponseInfoA EXTERNAL "wininet.dll" PERSISTENT:
  define output parameter lpdwError          as  long.
  define output parameter lpszBuffer         as  char.
  define input-output  parameter lpdwBufferLength   as  long.
  define return parameter iResultCode       as  long.
END.

PROCEDURE InternetOpenUrlA EXTERNAL "wininet.dll" PERSISTENT:
  define input parameter  hInternetSession  as  long.
  define input parameter  lpszUrl           as  char.
  define input parameter  lpszHeaders       as  char.
  define input parameter  dwHeadersLength   as  long.
  define input parameter  dwFlags           as  long.
  define input parameter  dwContext         as  long.
  define return parameter iResultCode       as  long.
END.

PROCEDURE InternetOpenA EXTERNAL "wininet.dll" PERSISTENT:
  define input parameter  sAgent            as  char.
  define input parameter  lAccessType       as  long.
  define input parameter  sProxyName        as  char.
  define input parameter  sProxyBypass      as  char.
  define input parameter  lFlags            as  long.
  define return parameter iResultCode       as  long.
END.

PROCEDURE InternetReadFile EXTERNAL "wininet.dll" PERSISTENT:
  define input  parameter  hFile            as  long.
  define output parameter  sBuffer          as  char.
  define input  parameter  lNumBytesToRead  as  long.
  define output parameter  lNumOfBytesRead  as  long.
  define return parameter  iResultCode      as  long.
END.

PROCEDURE InternetCloseHandle EXTERNAL "wininet.dll" PERSISTENT:
  define input parameter  hInet             as  long.
  define return parameter iResultCode       as  long.
END.

PROCEDURE FtpFindFirstFileA EXTERNAL "wininet.dll" PERSISTENT :
    define input parameter  hFtpSession as  long.
    define input parameter  lpFileName as char.
    define OUTPUT parameter  lpFindFileData as memptr.
    define input parameter  dwFlags        as long.
    define input parameter  dwContext      as long.
    define return parameter hSearch as long.
END PROCEDURE.    


PROCEDURE InternetFindNextFileA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hSearch as long.
    define input parameter  lpFindFileData as memptr.
    define return parameter found as long.
END PROCEDURE.


PROCEDURE FtpGetCurrentDirectoryA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession as long.
    define input parameter  lpszCurrentDirectory as long.
    define input-output parameter lpdwCurrentDirectory as long.
    define return parameter iRetCode as long.
END PROCEDURE.

PROCEDURE FtpSetCurrentDirectoryA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession as long.
    define input parameter  lpszDirectory as long.
    define return parameter iRetCode as long.
END PROCEDURE.

PROCEDURE FtpOpenFileA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession  as long.
    define input parameter  lpszFileName as long.
    define input parameter  dwAccess     as long.
    define input parameter  dwFlags      as long.
    define input parameter  dwContext    as long.
    define return parameter iRetCode as long.
END PROCEDURE.

PROCEDURE FtpPutFileA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession       as long.
    define input parameter  lpszLocalFile     as long.
    define input parameter  lpszNewRemoteFile as long.
    define input parameter  dwFlags           as long.
    define input parameter  dwContext         as long.
    define return parameter iRetCode          as long.
END PROCEDURE.

PROCEDURE FtpGetFileA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession          as long.
    define input parameter  lpszRemoteFile       as long.
    define input parameter  lpszNewFile          as long.
    define input parameter  fFailIfExists        as long.
    define input parameter  dwFlagsAndAttributes as long.
    define input parameter  dwFlags              as long.
    define input parameter  dwContext            as long.
    define return parameter iRetCode             as long.
END PROCEDURE.

PROCEDURE FtpDeleteFileA EXTERNAL "wininet.dll" PERSISTENT:
    define input parameter  hFtpSession          as long.
    define input parameter  lpszRemoteFile       as long.
    define return parameter iRetCode             as long.
END PROCEDURE.

PROCEDURE GetLastError external "kernel32.dll" :
  define return parameter dwMessageID as long. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD CloseInternetConnection Include 
FUNCTION CloseInternetConnection RETURNS LOGICAL
  ( input phInternetSession as integer )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD ConnectWinInet Include 
FUNCTION ConnectWinInet RETURNS LOGICAL
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD FTPConnect Include 
FUNCTION FTPConnect RETURNS LOGICAL
  ( input pcURL as char, cuser AS CHAR , cPasswd AS CHAR) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD FtpDeleteFile Include 
FUNCTION FtpDeleteFile RETURNS INTEGER
  ( cRemoteFile AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD FtpGetFile Include 
FUNCTION FtpGetFile RETURNS INTEGER
  ( input pcFilename as char ,cRemotefile AS CHAR)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD FTPListDir Include 
FUNCTION FTPListDir RETURNS INTEGER
  (INPUT cSearchDir      as CHAR,
   INPUT cSearchFileSpec as CHAR,
   INPUT hFTPSession     as INT,
   INPUT cProgCallBack   as CHAR,
   INPUT hCallProc       as HANDLE) FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD FtpPutFile Include 
FUNCTION FtpPutFile RETURNS INTEGER
  ( input pcLocalFile as char,
    input pcRemoteFile as char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD InternetGetLastResponseInfo Include 
FUNCTION InternetGetLastResponseInfo RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

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


/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION CloseInternetConnection Include 
FUNCTION CloseInternetConnection RETURNS LOGICAL
  ( input phInternetSession as integer ) :
/*------------------------------------------------------------------------------
  Purpose:  Close the handle the InternetSession.  Since all other handles are 
            leafs of this handle, the will also be closed when the root is 
            closed. (i.e. hFTPSession. )
 
    Notes:  
------------------------------------------------------------------------------*/
  define variable iRetCode      as  integer no-undo.

  run InternetCloseHandle(input  phInternetSession,
                          output iRetCode).
     

  RETURN iRetCode > 0.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION ConnectWinInet Include 
FUNCTION ConnectWinInet RETURNS LOGICAL
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  connect to specified website and exchange information.
    Notes:  
------------------------------------------------------------------------------*/
 
  /*-------------------------------------------------------------------------- 
    Call to establish an Internet session.  The handle, hInternetSession,
    will be used when connecting to the URL. 
  ---------------------------------------------------------------------------*/
  run InternetOpenA(input  'WebBasedAgent',
                    input  {&INTERNET_OPEN_TYPE_PRECONFIG},
                    input  '',
                    input  '',
                    input  0,
                    output hInternetSession).
  
  RETURN hInternetSession <> 0. /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION FTPConnect Include 
FUNCTION FTPConnect RETURNS LOGICAL
  ( input pcURL as char, cuser AS CHAR , cPasswd AS CHAR):
/*------------------------------------------------------------------------------
  Purpose:  connect to the ftp site for a given internet session.
    Notes:  
------------------------------------------------------------------------------*/
  def var iError as int no-undo.
  
  run InternetConnectA(input  hInternetSession,
                       input  pcURL,
                       input  {&INTERNET_DEFAULT_FTP_PORT},
                       input  cUser,
                       input  cPasswd,
                       input  {&INTERNET_SERVICE_FTP},
                       input  0,
                       input  0,
                       output hFTPSession).
  

  /* FOR CERN based Firewall support 
  RUN InternetOpenUrlA(INPUT hInternetSession,
                       INPUT pcURL,
                       INPUT '',
                       INPUT 0,
                       INPUT {&INTERNET_FLAG_PASSIVE},
                       INPUT 0,
                       OUTPUT hFTPSession).
  */

  IF hFTPSession = 0 then
  do:
    run GetLastError(output iError).
    message "InternetConnectA Failed:  " iError view-as alert-box.
    InternetGetLastResponseInfo().
    RETURN FALSE.
  end.

  RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION FtpDeleteFile Include 
FUNCTION FtpDeleteFile RETURNS INTEGER
  ( cRemoteFile AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  Deletes a file from the FTP Server if you have permissions.
    Notes:  
------------------------------------------------------------------------------*/

  define var lpRemoteFile   as  memptr  no-undo.
  define var iRetCode       as  integer no-undo.

  
  assign
  /* remove the file size from the file name */
  
  set-size(lpRemoteFile)     = length(cRemoteFile) + 1
  put-string(lpRemoteFile,1) = cRemoteFile.
  
  Session:Set-Wait-State('General':U).
  
  run FtpDeleteFileA(input hFtpSession,
                     input get-pointer-value(lpRemoteFile),
                     output iRetCode).
                 
  Session:Set-Wait-State('':U).
  
  /*if iRetCode = 0 then
    InternetGetLastResponseInfo().
    else
    message 'File Deleted...' view-as alert-box.*/

  assign
  set-size(lpRemoteFile)     = 0.

  RETURN  iRetCode.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION FtpGetFile Include 
FUNCTION FtpGetFile RETURNS INTEGER
  ( input pcFilename as char ,cRemotefile AS CHAR) :

/*------------------------------------------------------------------------------
  Purpose:  Retrieves a file from the FTP Server and stores it under the 
            specified file name, creating a new local file in the process.
    Notes:  
------------------------------------------------------------------------------*/

  define var lpRemoteFile   as  memptr  no-undo.
  define var lpNewFile      as  memptr  no-undo.
  define var fOverwirte     as  log     no-undo.
  define var iRetCode       as  integer no-undo.

  assign
  /* remove the file size from the file name */
  
  set-size(lpRemoteFile)     = length(cRemoteFile) + 1
  put-string(lpRemoteFile,1) = cRemoteFile
  set-size(lpNewFile)        = length(pcFilename) + 1
  put-string(lpNewFile,1)    = pcFileName.
  
  Session:Set-Wait-State('General':U).
  
  run FtpGetFileA(input hFtpSession,
                 input get-pointer-value(lpRemoteFile),
                 input get-pointer-value(lpNewFile),
                 input 0, /* 1 - fail if file exists, 0 - overwrite */
                 input {&FILE_ATTRIBUTE_NORMAL},
                 input {&FTP_TRANSFER_TYPE_BINARY},
                 input 0,
                 output iRetCode).
                 
  Session:Set-Wait-State('':U).
  
  /*if iRetCode = 0 then
    InternetGetLastResponseInfo().
  else
    message 'File Received...' view-as alert-box.*/

  assign
  set-size(lpRemoteFile)     = 0
  set-size(lpNewFile)        = 0.

  RETURN  iRetCode.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION FTPListDir Include 
FUNCTION FTPListDir RETURNS INTEGER
  (INPUT cSearchDir      as CHAR,
   INPUT cSearchFileSpec as CHAR,
   INPUT hFTPSession     as INT,
   INPUT cProgCallBack   as CHAR,
   INPUT hCallProc       as HANDLE):
/*------------------------------------------------------------------------

  Function:    DirList

  Description: Returns integer corresponding to the error:
                   0 - if there were no errors.
                   1 - file list buffer is too small
                   2 - file list buffer is too big
                   3 - invalid path given
                   5 - directory on drive is invaild

               
               cSearchDir:
                 Directory to search in, can be relative, use /../../, etc.                 
               
               cSearchFileSpec:
                 comma delimited list of file types, can have trailing 
                 comma e.g: " foo?ar.*  ,  *.p, "
                 
               hFTPSession - handle to an open ftp session.

               cProgCallBack:
                 Program to be called if a file is found passing in
                 to input parameters, the directory being searched, 
                 and the filename found.
                 
               hCallProc
                 Handle to the calling program where call back process
                 is to execute.

  Notes:       FtpFindFirstFile can only occur once within a given FTP
               session.  To issue another one, a call must be made
               InternetCloseHandle.

  History: 
          
------------------------------------------------------------------------*/
  def var lpFindData   as memptr    no-undo.
  def var hSearch      as integer   no-undo.
  def var iFound       as integer   no-undo initial 1.
  def var iFileSpec    as integer   no-undo.
  def var cFileList    as char      no-undo.
  def var iRetCode     as integer   no-undo.


  &GLOBAL  FIND_DATA-SIZE 4           /* dwFileAttributes       */~
                       + 8           /* ftCreationTime         */~
                       + 8           /* ftLastAccessTime       */~
                       + 8           /* ftLastWriteTime        */~
                       + 4           /* nFileSizeHigh          */~
                       + 4           /* nFileSizeLow           */~
                       + 4           /* dwReserved0            */~
                       + 4           /* dwReserved1            */~
                       + {&MAX_PATH} /* cFileName[MAX_PATH]    */~
                       + 14          /* cAlternateFileName[14] */
  
  /* allocate the memory for the find_data structure */
  assign
  set-size(lpFindData) = {&FIND_DATA-SIZE}.

  do iFileSpec = 1 to num-entries(cSearchFileSpec):

    iFound = 1.
    run FtpFindFirstFileA (input  hFtpSession,
                           input  "*" /*cSearchDir + '/' + 
                                  entry(iFileSpec, cSearchFileSpec)*/, 
                           OUTPUT lpFindData,
                           input  {&INTERNET_FLAG_EXISITING_CONNECT},
                           input  0,
                           output hSearch).

    if hSearch <> -1 then 
    repeat while iFound <> 0:
     
      run value(cProgCallBack) in hCallProc
            (input lpFindData,
             input  cSearchDir).                 /* current directory */
         
      run InternetFindNextFileA (input  hSearch, 
                                 input  lpFindData,
                                 output iFound).
        
    end. /* repeat while ifound <> 0... */

    /* set error for invalid file specification */
    else 
      iRetCode = 5.
 
  end. /* do iFileSpec = 1 to ... */
    
  set-size(lpFindData) = 0.

  /* close file handle now so we can do a find again */
  run InternetCloseHandle (input hSearch, OUTPUT iRetCode).

  return iRetCode.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION FtpPutFile Include 
FUNCTION FtpPutFile RETURNS INTEGER
  ( input pcLocalFile as char,
    input pcRemoteFile as char ) :
/*------------------------------------------------------------------------------
  Purpose:  Sends a file to the FTP Server and stores it under the 
            specified file name, creating a new remote file in the process
            if you have the appropriate permissions.  If not you will be told
            so via InternetGetLastResponse.
    Notes:  
------------------------------------------------------------------------------*/

  define var lpLocalFile        as  memptr  no-undo.
  define var lpNewRemoteFile    as  memptr  no-undo.
  define var fOverwirte         as  log     no-undo.
  define var iRetCode           as  integer no-undo.
  
  assign
  /* remove the file size from the file name */
  set-size(lpNewRemoteFile)     = length(pcRemoteFile) + 1
  put-string(lpNewRemoteFile,1) = pcRemoteFile
  set-size(lpLocalFile)         = length(pcLocalFile) + 1
  put-string(lpLocalFile,1)     = pcLocalFile.
  
  Session:Set-Wait-State('General':U).
  
  run FtpPutFileA(input hFtpSession,
                  input get-pointer-value(lpLocalFile),
                  input get-pointer-value(lpNewRemoteFile),
                  input {&FTP_TRANSFER_TYPE_BINARY},
                  input 0,
                  output iRetCode).
                 
  Session:Set-Wait-State('':U).
  
  /*if iRetCode = 0 then
    InternetGetLastResponseInfo().
    else
    message 'File Sent...' view-as alert-box.*/

  assign
  set-size(lpNewRemoteFile)     = 0
  set-size(lpLocalFile)         = 0.
 


  RETURN iRetCode.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION InternetGetLastResponseInfo Include 
FUNCTION InternetGetLastResponseInfo RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  If an error is encountered then display what the last response
            was.
    Notes:  
------------------------------------------------------------------------------*/
  define var cBuffer            as  char no-undo.
  define var iBufferSz          as  int init 4096 no-undo.
  define var iResultCode        as  int no-undo.
  define var iTemp              as  int no-undo.
  
  /* allocate for the buffer */
  assign
  cBuffer = fill(' ', iBufferSz).

  run InternetGetLastResponseInfoA (output iResultCode,
                                    output cBuffer,
                                    input-output iBufferSz,
                                    output iTemp).

  message substitute('Error (&1):  &2',
                     iResultCode,
                     substr(cBuffer,1,iBufferSz)) view-as alert-box.
                       
  RETURN "".   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

