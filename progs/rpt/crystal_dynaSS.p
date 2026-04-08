&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Procedure 
/*------------------------------------------------------------------------
    File        : .p
    Purpose     : conversiones a xml.

     (fvergniaud@dynasys.com.ar)                                                                               
  ----------------------------------------------------------------------*/
DEFINE STREAM xml_salida.
DEF VAR chApplication AS COM-HANDLE NO-UNDO.
DEF VAR chReport AS COM-HANDLE NO-UNDO.
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR exportFileName AS CHAR NO-UNDO.


/* External procedure definitions */
PROCEDURE GetCurrentDirectoryA EXTERNAL "KERNEL32.DLL":
    DEFINE INPUT        PARAMETER intBufferSize AS LONG.
    DEFINE INPUT-OUTPUT PARAMETER ptrToString   AS MEMPTR.
    DEFINE RETURN       PARAMETER intResult     AS SHORT.
END PROCEDURE.

PROCEDURE SetCurrentDirectoryA EXTERNAL "KERNEL32.DLL":
    DEFINE INPUT  PARAMETER chrCurDir AS CHARACTER.
    DEFINE RETURN PARAMETER intResult AS LONG.
END PROCEDURE.

PROCEDURE GetProfileStringA EXTERNAL 'kernel32.dll':
    def input param ip1 as char.
    def input param ip2 as char.
    def input param ip3 as char.
    def output param ip4 as MEMPTR.
    def input param ip5 as long.
END PROCEDURE.

PROCEDURE GetProfileSectionA EXTERNAL 'kernel32.dll':
    def input param ip1 as char.
    def input param ip2 as memptr.
    def input param ip3 as long.
END PROCEDURE.

PROCEDURE WriteProfileStringA external 'kernel32.dll':
    DEF input param ip1 as char.
    DEF input param ip2 as char.
    DEF input param ip3 as char.
END PROCEDURE.

/*------------------------------------------------------------------------
    File        : crystal/crystal_define_ce.i
    Purpose     : Crystal Report - Enumerated types
                  Define the enumerated types as Progress preprocessors
                  Complete description in Crystal Reports: CR_SDK.CHM

    Progress Benelux (ede@progress.com)                                                                               
  ----------------------------------------------------------------------*/

/* Crystal report enumerated type: CRExportFormatType */
&GLOB crEFTCharSeparatedValues 7
&GLOB crEFTCommaSeparatedValues 5
&GLOB crEFTCrystalReport 1
&GLOB crEFTCrystalReport70 33
&GLOB crEFTDataInterchange 2
&GLOB crEFTExactRichText 35
&GLOB crEFTExcel50 21
&GLOB crEFTExcel50Tabular 22
&GLOB crEFTExcel70 27
&GLOB crEFTExcel70Tabular 28
&GLOB crEFTExcel80 29
&GLOB crEFTExcel80Tabular 30
&GLOB crEFTExcel97 36
&GLOB crEFTExplorer32Extend 25
&GLOB crEFTHTML32Standard 24
&GLOB crEFTHTML40 32
&GLOB crEFTLotus123WK1 12 
&GLOB crEFTLotus123WK3 13
&GLOB crEFTLotus123WKS 11
&GLOB crEFTNoFormat 0
&GLOB crEFTODBC 23
&GLOB crEFTPaginatedText 10
&GLOB crEFTPortableDocFormat 31
&GLOB crEFTRecordStyle 3
&GLOB crEFTReportDefinition 34
&GLOB crEFTTabSeparatedText 9
&GLOB crEFTTabSeparatedValues 6
&GLOB crEFTText 8 
&GLOB crEFTWordForWindows 14
&GLOB crEFTXML 37

/* Crystal report enumerated type: CRExportDestinationType */
&GLOB crEDTApplication 5
&GLOB crEDTDiskFile 1
&GLOB crEDTEMailMAPI 2
&GLOB crEDTEMailVIM 3
&GLOB crEDTLotusDomino 6
&GLOB crEDTMicrosoftExchange 4
&GLOB crEDTNoDestination 0

/* Crystal report enumerated type: CRFieldValueType */
&GLOB crBitmapField 17
&GLOB crBlobField 15
&GLOB crBooleanField 9
&GLOB crChartField 21
&GLOB crCurrencyField 8
&GLOB crDateField 10
&GLOB crDateTimeField 16
&GLOB crIconField 18
&GLOB crInt16sField 3
&GLOB crInt16uField 4
&GLOB crInt32sField 5
&GLOB crInt32uField 6
&GLOB crInt8sField 1
&GLOB crInt8uField 2
&GLOB crNumberField 7
&GLOB crOleField 20
&GLOB crPersistentMemoField 14
&GLOB crPictureField 19
&GLOB crStringField 12
&GLOB crTimeField 11
&GLOB crTransientMemoField 13 
&GLOB crUnknownField 22
 
/* Crystal report enumerated type: CROpenReportMethod: */
&GLOB crOpenReportByDefault 0
&GLOB crOpenReportByTempCopy 1

/* End of CR preprocessor definitions */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Procedure
&Scoped-define DB-AWARE no



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-aUnicode) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD aUnicode Procedure 
FUNCTION aUnicode returns character
  ( ipcString as char )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-crFormat) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD crFormat Procedure 
FUNCTION crFormat RETURNS INTEGER PRIVATE
  ( pcFormat AS CHARACTER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-dflformat) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD dflformat Procedure 
FUNCTION dflformat RETURNS CHARACTER
  ( que_reporte AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getBufferValue) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getBufferValue Procedure 
FUNCTION getBufferValue RETURNS CHARACTER
  ( phField AS HANDLE, piIndex AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getCurrentDirectory) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getCurrentDirectory Procedure 
FUNCTION getCurrentDirectory RETURNS CHARACTER PRIVATE
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getDefaultPrinter) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getDefaultPrinter Procedure 
FUNCTION getDefaultPrinter RETURNS CHARACTER PRIVATE
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinterDefinition) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getPrinterDefinition Procedure 
FUNCTION getPrinterDefinition RETURNS CHARACTER PRIVATE
  ( pcPrinter AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinterDefinitions) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getPrinterDefinitions Procedure 
FUNCTION getPrinterDefinitions RETURNS CHARACTER PRIVATE
  ( /* parameter-DEFINEinitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinters) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getPrinters Procedure 
FUNCTION getPrinters RETURNS CHARACTER
  ( )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrintersNames) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD getPrintersNames Procedure 
FUNCTION getPrintersNames RETURNS CHARACTER
  ( /* parameter-definitions */ )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-listaParametro) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD listaParametro Procedure 
FUNCTION listaParametro RETURNS LOGICAL
  ( chReport AS COM-HANDLE , p-param AS CHAR  )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setCurrentDirectory) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setCurrentDirectory Procedure 
FUNCTION setCurrentDirectory RETURNS LOGICAL PRIVATE
  ( pcDirectory AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setDefaultPrinter) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setDefaultPrinter Procedure 
FUNCTION setDefaultPrinter RETURNS LOGICAL PRIVATE
  ( pcPrinter AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setParametro) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD setParametro Procedure 
FUNCTION setParametro RETURNS LOGICAL
  ( chReport AS COM-HANDLE , p-param AS CHAR , p-valor AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-Tempfile) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD Tempfile Procedure 
FUNCTION Tempfile RETURNS CHARACTER
  ( direct AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-TempReport) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD TempReport Procedure 
FUNCTION TempReport RETURNS CHARACTER
  ( direct AS CHAR )  FORWARD.

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
         HEIGHT             = 20.57
         WIDTH              = 59.2.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Procedure 
/* ************************* Included-Libraries *********************** */

{windows.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Procedure 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-borra_temp) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE borra_temp Procedure 
PROCEDURE borra_temp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*borra el archivo el archivo pasado como parametro*/
DEFINE INPUT PARAMETER xfile AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER errcdg AS INT NO-UNDO.
OS-DELETE VALUE(xfile).
errcdg = OS-ERROR.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-crearReporte) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE crearReporte Procedure 
PROCEDURE crearReporte :
/*------------------------------------------------------------------------------
  Actual creation of the report
  
  si el PrinterName <> "" usa pa impresora pasada
  si "?" pregunta simple.
  si "?EX" pregunta avanzada
  
  si ExportTodisk = ? pregunta las distintas opciones y formatos
  si es no no esporta
  si es si exporta al exportFileName o genera uno y lo devuelve al que lo llamo.
  
  si ViewReport es true previsualiza
  si es false no previsualiza.
  
  ver para mas opciones
  
7  C:\Archivos de programa\Archivos comunes\Crystal Decisions\2.5\bin\craxdrt.dll
  
------------------------------------------------------------------------------*/
  DEFINE INPUT PARAMETER chReport AS COM-HANDLE NO-UNDO.
  DEFINE INPUT PARAM reportFormat AS CHAR NO-UNDO.
  DEFINE INPUT PARAM ViewReport AS LOGICAL NO-UNDO.
  DEFINE INPUT PARAM PrinterName AS CHARACTER NO-UNDO.
  DEFINE INPUT PARAM exportToDisk AS LOGICAL NO-UNDO.
  DEFINE INPUT-OUTPUT PARAM exportFileName AS CHARACTER NO-UNDO.

  DEFINE VARIABLE chField           AS COM-HANDLE NO-UNDO.
  DEFINE VARIABLE cDll              AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE itmp              AS INTEGER    NO-UNDO.
  DEFINE VARIABLE iType             AS INTEGER    NO-UNDO.
  DEFINE VARIABLE cPrinter          AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE hViewer           AS HANDLE     NO-UNDO.
  DEFINE VARIABLE lOk               AS LOGICAL    NO-UNDO.
  DEFINE VARIABLE iParam            AS INTEGER    NO-UNDO.
  DEFINE VARIABLE iFormatType       AS INTEGER    NO-UNDO.
  DEFINE VARIABLE iFiles            AS INTEGER    NO-UNDO.
  DEFINE VARIABLE cFullPath         AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE ReportInstance    AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE gcCurrentDirectory AS CHAR NO-UNDO.

  /*Este el el TBL
  C:\Archivos de programa\Archivos comunes\Crystal Decisions\2.5\bin\craxdrt.dll
  */

   gcCurrentDirectory = getcurrentdirectory().
  IF ExportToDisk = TRUE AND exportFileName <> '' THEN
        ReportInstance = exportFileName.
  ELSE
        ReportInstance = TempReport("") + "." + reportFormat.
  /*chReport = gchApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).*/
  IF chReport:HasSavedData THEN
     chReport:DiscardSavedData(). /*descartamos se se guardo con datos*/
      
  IF ExportToDisk = TRUE OR ReportFormat <> 'rpt':U THEN
  DO:
      iFormatType = crFormat(ReportFormat).
        chReport:exportOptions:formatType = iFormatType.
        /* Set the output filename (depends on format) */
        IF iFormatType = {&crEFTHTML32Standard} 
          OR iFormatType = {&crEFTHTML40} THEN
          chReport:exportOptions:HTMLFileName = ReportInstance.
        ELSE IF iFormatType = {&crEFTXML} THEN
          chReport:exportOptions:XMLFileName = ReportInstance.
        ELSE 
          chReport:exportOptions:DiskFileName = ReportInstance.
  END.

  IF ExportToDisk = TRUE OR ExportToDisk = ? OR (ViewReport AND ReportFormat <> 'rpt':U) THEN
  DO:
          chReport:exportOptions:destinationType = {&crEDTDiskFile}.
          NO-RETURN-VALUE chReport:export(ExportToDisk = ?) NO-ERROR. 
          IF ERROR-STATUS:NUM-MESSAGES > 0 THEN
            RUN ponmensj.p("CRY011").
  END.

    /* Print report */
  IF PrinterName <> '' THEN
  DO:
     IF PrinterName = "?" THEN 
         chReport:PrinterSetup(0).
     ELSE do:
         IF PrinterName = "?EX" THEN 
            chReport:PrinterSetupEx(0).
         ELSE do:
            cPrinter = getPrinterDefinition(PrinterName).
            chReport:SelectPrinter(ENTRY(2, cPrinter), ENTRY(1, cPrinter), ENTRY(3, cPrinter)).
         END.
     END.
     chReport:PrintOut(NO).
     /*   /* Prompt user */
    ttCrystal.ReportNumberOfCopies,
    ttCrystal.ReportCollated,
    ttCrystal.ReportStartPage,
    ttCrystal.ReportEndPage).
     */
  END.

     /* View generated report */
  IF ViewReport THEN
  DO:
      IF ReportFormat = 'rpt':U THEN
      DO:
          RUN crystal_view.w PERSISTENT SET hViewer.
          RUN attachReport IN hViewer(chReport).
      END.
      ELSE
          RUN openFileByOS IN TARGET-PROCEDURE(ReportInstance).
  END.
  setCurrentDirectory(gcCurrentDirectory).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-Datoslistado) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Datoslistado Procedure 
PROCEDURE Datoslistado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER que_listado AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER que_fecha AS CHAR NO-UNDO.
DEFINE OUTPUT PARAMETER que_parametro AS CHAR NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER p-xfile AS CHAR NO-UNDO.
    
{findempresa.i}
DEFINE VAR dfecha AS DATETIME NO-UNDO.

dfecha = DATETIME(que_fecha).

IF p-xfile = "" OR p-xfile = ?
    THEN p-xfile = tempfile("").
FIND datalistado WHERE datalistado.reporte = que_listado AND
    datalistado.fecha = dfecha AND datalistado.cdg_empresa = empresa.cdg_empresa NO-LOCK NO-ERROR. 
IF AVAILABLE datalistado THEN DO:
    COPY-LOB 
    FROM datalistado.datos TO FILE p-xfile.
    que_parametro = datalista.crparametro.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-fullPath) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE fullPath Procedure 
PROCEDURE fullPath :
/*------------------------------------------------------------------------------
Locate the full pathname of a file, potentially using a suffix
------------------------------------------------------------------------------*/
  DEFINE INPUT  PARAMETER pcFileName AS CHARACTER  NO-UNDO.
  DEFINE INPUT  PARAMETER pcSuffix   AS CHARACTER  NO-UNDO.
  DEFINE OUTPUT PARAMETER pcFullPath AS CHARACTER  NO-UNDO.
  
  FILE-INFO:FILE-NAME = pcFileName.
  IF FILE-INFO:FULL-PATHNAME = ? THEN
    FILE-INFO:FILE-NAME = pcFileName + pcSuffix.
  pcFullPath = FILE-INFO:FULL-PATHNAME.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-graba_temp) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE graba_temp Procedure 
PROCEDURE graba_temp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER que_listado AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER que_parametros AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER xfile AS CHAR NO-UNDO.
{findempresa.i}

FIND usuario WHERE usuario.cdg_usuario = userid("SIC").
CREATE datalistado.

ASSIGN datalistado.fecha = NOW
       datalistado.reporte = que_listado
       datalistado.crparametros = que_parametros
       datalistado.cdg_empresa = empresa.cdg_empresa
       datalistado.nro_usuario = usuario.nro_usuario.
COPY-LOB 
    FROM FILE xfile TO datalistado.datos.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-invocaCrystal) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE invocaCrystal Procedure 
PROCEDURE invocaCrystal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER v-nombre_reporte AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER xfile AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER p-param AS CHAR NO-UNDO.
DEFINE INPUT PARAM reportFormat AS CHAR NO-UNDO.
DEFINE INPUT PARAM ViewReport AS LOGICAL NO-UNDO.
DEFINE INPUT PARAM PrinterName AS CHARACTER NO-UNDO.
DEFINE INPUT PARAM exportToDisk AS LOGICAL NO-UNDO.
DEFINE INPUT-OUTPUT PARAM exportFileName AS CHARACTER NO-UNDO.

DEFINE var chReport AS COM-HANDLE NO-UNDO.
DEFINE var chApplication AS com-handle NO-UNDO.
DEFINE VAR cFullPath AS CHAR NO-UNDO.
DEFINE VAR xFullPath AS CHAR NO-UNDO.
DEFINE VAR ERROR_nro AS INT NO-UNDO.

RUN fullPath (v-nombre_reporte, '.rpt':U, OUTPUT cFullPath).
       IF cFullPath = ? 
       THEN DO:
           RUN mensajepar.p (INPUT v-nombre_reporte + ".rpt", INPUT "CREP000").
           RETURN ERROR.
       END.
reportFormat = IF reportformat = "" THEN dflFormat( INPUT v-nombre_reporte) ELSE reportformat.
CREATE "CrystalRuntime.Application" chApplication.
       chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
       chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
       RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
       chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
       listaParametro(chReport,p-param).
       
       RUN crearReporte(chReport,reportFormat,/*ViewReport*/ ViewReport,/*PrinterName*/ PrinterName,
                         /*exportToDisk*/ exportToDisk, INPUT-OUTPUT exportFileName ).        
       
        
       RUN borra_temp (INPUT exportFileName,OUTPUT ERROR_nro).
       RELEASE OBJECT chReport. 
       chReport = ?.
       RELEASE OBJECT chApplication.
       chApplication = ?.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-openFileByOs) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE openFileByOs Procedure 
PROCEDURE openFileByOs :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Open a file using the default mechanism of the OperatingSystem
------------------------------------------------------------------------------*/
/*   DEFINE INPUT  PARAMETER pcFile AS CHARACTER  NO-UNDO.     */
/*   /* OS-COMMAND NO-WAIT VALUE(SUBST('START &1', pcFile)).*/ */
/*   DEFINE VARIABLE hInstance AS INTEGER.                     */
/*   RUN ShellExecute{&A} IN hpApi  (0,                        */
/*                                   "open",                   */
/*                                   pcFile,                   */
/*                                   "",                       */
/*                                   "",                       */
/*                                   1,                        */
/*                                   OUTPUT hInstance).        */
/*                                                             */
/* END PROCEDURE.                                              */
/*                                                             */
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Open a file using the default mechanism of the OperatingSystem
------------------------------------------------------------------------------*/
  DEFINE INPUT  PARAMETER pcFile AS CHARACTER  NO-UNDO.
   OS-COMMAND NO-WAIT VALUE(SUBST('START &1', pcFile)).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-aUnicode) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION aUnicode Procedure 
FUNCTION aUnicode returns character
  ( ipcString as char ) :
/*------------------------------------------------------------------------------
  Convert a characterstring into UNICODE
------------------------------------------------------------------------------*/

    def var iChar   as int  no-undo.
    def var cString as char no-undo case-sensitive.

    if ipcString = '' then
        return ipcString.


    cString = ipcString.
    cString = REPLACE(cString,CHR(13) + CHR(10)," ").
    cString = REPLACE(cString,CHR(160) ,"á").
    cString = REPLACE(cString,CHR(131) ,"è").
    cString = REPLACE(cString,CHR(161) ,"í").
    cString = REPLACE(cString,CHR(162) ,"ó").
    cString = REPLACE(cString,CHR(163) ,"ú").
    cString = REPLACE(cString,CHR(13) ," ").
    cString = REPLACE(cString,CHR(10) ," ").
    cString = REPLACE(cString,CHR(8) ,"        ").
    cString = REPLACE(cString,"&","&amp;").

    repeat iChar = 128 to 128 + 63:
        if index(cString, chr(iChar))      > 0 then
            cString = replace(cString, chr(iChar),      chr(194) + chr(iChar)).
        if index(cString, chr(iChar + 64)) > 0 then
            cString = replace(cString, chr(iChar + 64), chr(195) + chr(iChar)).
    end.

    return cString.

end function.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-crFormat) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION crFormat Procedure 
FUNCTION crFormat RETURNS INTEGER PRIVATE
  ( pcFormat AS CHARACTER) :
/*------------------------------------------------------------------------------
  Purpose:  Convert generic export format to CR internal format for export
------------------------------------------------------------------------------*/
  DEFINE VARIABLE iFormat AS INTEGER    NO-UNDO.

  CASE pcFormat:
    WHEN 'pdf':U THEN iFormat = {&crEFTPortableDocFormat}.
    WHEN 'doc':U THEN iFormat = {&crEFTWordForWindows}.
    WHEN 'html':U OR WHEN 'htm':U THEN iFormat = {&crEFTHTML40}.
    WHEN 'rtf':U THEN iFormat = {&crEFTExactRichText}.
    WHEN 'xml':U THEN iFormat = {&crEFTXML}.
    WHEN 'xls':U THEN iFormat = {&crEFTExcel97}.
    WHEN 'csv':U THEN iFormat = {&crEFTCommaSeparatedValues}.
    WHEN 'rpt':U THEN iFormat = {&crEFTCrystalReport}.
    WHEN 'wk1':U THEN iFormat = {&crEFTLotus123WK1}.
    WHEN 'wk3':U THEN iFormat = {&crEFTLotus123WK3}.
    WHEN 'wks':U THEN iFormat = {&crEFTLotus123WKS}.
    WHEN 'txt':U THEN iFormat = {&crEFTText}.
  END CASE.

  RETURN iFormat.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-dflformat) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION dflformat Procedure 
FUNCTION dflformat RETURNS CHARACTER
  ( que_reporte AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: devuelve la extension por default del reporte 
    Notes:  
------------------------------------------------------------------------------*/
FIND listadef WHERE listadef.reporte = que_reporte NO-LOCK NO-ERROR.
IF NOT AVAILABLE listadef THEN DO:
    RUN mensajepar.p (INPUT que_reporte, INPUT "CREP000").
    RETURN ERROR.
END.
{findempresa.i}
IF NOT CAN-DO(listadef.lst_empresa,empresa.cdg_empresa) THEN DO:
    RUN mensajepar.p (INPUT que_reporte, INPUT "CREP005").
END.
RETURN Listadef.dfl_visualizacion .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getBufferValue) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getBufferValue Procedure 
FUNCTION getBufferValue RETURNS CHARACTER
  ( phField AS HANDLE, piIndex AS INTEGER ) :
/*------------------------------------------------------------------------------
   Returns a buffer value int the XML format required by CR  
------------------------------------------------------------------------------*/
    DEFINE VARIABLE cValue AS CHARACTER  NO-UNDO.
    DEFINE VARIABLE dValue AS DATE       NO-UNDO.

    IF phField:BUFFER-VALUE(piIndex) <> ? THEN
    DO:
      CASE  phField:DATA-TYPE:
        WHEN 'character':U THEN 
        DO:
          cValue = aUnicode(phField:BUFFER-VALUE(piIndex)).
        END.
        WHEN 'decimal':U THEN 
        DO:
          cValue = STRING(phField:BUFFER-VALUE(piIndex)).
          IF INDEX(cValue, ',':U) > 0 THEN
            cValue = REPLACE(cValue, ',':U, '.':U).
        END.                    
        WHEN 'integer':U THEN 
          cValue = STRING(phField:BUFFER-VALUE(piIndex)).
        WHEN 'logical':U THEN
          cValue = TRIM(STRING(phField:BUFFER-VALUE(piIndex), 'true/false':U)).
        WHEN 'date':U THEN  
        ASSIGN
          dValue = phField:BUFFER-VALUE(piIndex)
          cValue = STRING(YEAR(dValue), '9999':U) + '-' + 
                 STRING(MONTH(dValue), '99':U) + '-' +
                 STRING(DAY(dValue), '99':U).
        OTHERWISE
          cValue = aUnicode( phField:BUFFER-VALUE(piIndex) ).
      END CASE.
    END.

    RETURN cValue.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getCurrentDirectory) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getCurrentDirectory Procedure 
FUNCTION getCurrentDirectory RETURNS CHARACTER PRIVATE
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Use windows API to identify current directory 
------------------------------------------------------------------------------*/
  DEFINE VARIABLE iBufferSize    AS INTEGER    NO-UNDO INITIAL 256.
  DEFINE VARIABLE iResult        AS INTEGER    NO-UNDO.
  DEFINE VARIABLE mString        AS MEMPTR     NO-UNDO.
  DEFINE VARIABLE cDirectory     AS CHARACTER  NO-UNDO.

  SET-SIZE(mString) = 256.    
  RUN GetCurrentDirectoryA (INPUT iBufferSize,
                            INPUT-OUTPUT mString,
                            OUTPUT iResult).
  ASSIGN cDirectory = GET-STRING(mString,1).
  SET-SIZE(mString) = 0.
  RETURN cDirectory.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getDefaultPrinter) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getDefaultPrinter Procedure 
FUNCTION getDefaultPrinter RETURNS CHARACTER PRIVATE
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Use windows API to return the default printer 
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cDefaultPrinter AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE mDefaultPrinter AS MEMPTR     NO-UNDO.
  SET-SIZE(mDefaultPrinter) = 300.

  RUN GetProfileStringA(
      'Windows',
      'Device',
      ',,,',
      OUTPUT mDefaultPrinter,
      300).

    cDefaultPrinter = GET-STRING(mDefaultPrinter, 1).
    IF NUM-ENTRIES(cDefaultPrinter, ':') = 2 THEN 
        cDefaultPrinter = ENTRY(1, cDefaultPrinter, ':').
  RETURN cDefaultPrinter.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinterDefinition) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getPrinterDefinition Procedure 
FUNCTION getPrinterDefinition RETURNS CHARACTER PRIVATE
  ( pcPrinter AS CHAR ) :
/*------------------------------------------------------------------------------
  Use windows API to retrieve definition of a single printer
------------------------------------------------------------------------------*/
  DEFINE VARIABLE iPrinter AS INTEGER    NO-UNDO.
  DEFINE VARIABLE cPrinter AS CHARACTER  NO-UNDO.
  DEFINE VARIABLE cPrinterlist AS CHARACTER  NO-UNDO.

  cPrinterList = getPrinterDefinitions().
  DO iPrinter = 1 TO NUM-ENTRIES(cPrinterList, CHR(1)).
    cPrinter = ENTRY(iPrinter, cPrinterList, CHR(1)).
    IF ENTRY(1, cPrinter) = pcPrinter THEN
    DO:
      RETURN cPrinter.
      LEAVE.
    END.
  END.

  RETURN ?.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinterDefinitions) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getPrinterDefinitions Procedure 
FUNCTION getPrinterDefinitions RETURNS CHARACTER PRIVATE
  ( /* parameter-DEFINEinitions */ ) :
/*------------------------------------------------------------------------------
  Use windows API to retrieve a list of all printer definitions 
------------------------------------------------------------------------------*/
    DEFINE VAR cPrinterList AS char no-undo.

    DEFINE var m AS memptr.
    DEFINE var p AS int no-undo.
    DEFINE var cPrinter AS char no-undo.

    set-size(m) = 3000.

    run GetProfileSectionA (
        'PrinterPorts',
        m,
        get-size(m)).

    p = 1.
    repeat:
        if p > get-size(m) then
            leave.
        cPrinter = get-string(m, p).
        if cPrinter = '' then
            leave.
        p = p + length(cPrinter) + 1.
        if num-entries(cPrinter, ':') = 2 then
            cPrinter = entry(1, cPrinter, ':').
        cPrinter = replace(cPrinter, '=', ',').
        cPrinterList = cPrinterList + chr(1) + cPrinter.
    end.

    cPrinterList = trim(cPrinterList, chr(1)).

    set-size(m) = 0.

  RETURN cPrinterList.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrinters) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getPrinters Procedure 
FUNCTION getPrinters RETURNS CHARACTER
  ( ) :
/*------------------------------------------------------------------------------
  Returns a list of printers
------------------------------------------------------------------------------*/
  DEFINE VARIABLE cPrinterList AS CHARACTER  NO-UNDO.
  cPrinterList = SESSION:GET-PRINTERS().
  RETURN cPrinterList.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-getPrintersNames) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION getPrintersNames Procedure 
FUNCTION getPrintersNames RETURNS CHARACTER
  ( /* parameter-definitions */ ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR cPrinterListLoc AS CHAR NO-UNDO.
DEF VAR i AS INT NO-UNDO.
    cPrinterListLoc = "".
  FOR EACH impresora:
     cPrinterListLoc = cPrinterListLoc + "," + Impresora.nombre.
  END.
  IF LENGTH(cPrinterListLoc) = 0 THEN cPrinterListLoc = DYNAMIC-FUNCTION('getPrinters':U).
  ELSE cPrinterListLoc = SUBSTRING(cPrinterListLoc,2).
  RETURN cPrinterListLoc.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-listaParametro) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION listaParametro Procedure 
FUNCTION listaParametro RETURNS LOGICAL
  ( chReport AS COM-HANDLE , p-param AS CHAR  ) :
/*------------------------------------------------------------------------------
  Purpose:  Para parametro en modo lista al Crystal Report
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR k AS INT NO-UNDO.
DO k = 1 TO NUM-ENTRIES(p-param,CHR(1)) BY 2:
    setParametro(chReport, ENTRY(k,p-param,CHR(1)) , ENTRY(k + 1,p-param,CHR(1))).
END.
  RETURN FALSE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setCurrentDirectory) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setCurrentDirectory Procedure 
FUNCTION setCurrentDirectory RETURNS LOGICAL PRIVATE
  ( pcDirectory AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Use windows API to set the current directory
------------------------------------------------------------------------------*/
  DEFINE VARIABLE iResult AS INTEGER    NO-UNDO.

  RUN SetCurrentDirectoryA (INPUT pcDirectory, OUTPUT iResult).
  RETURN iResult = 0.

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setDefaultPrinter) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setDefaultPrinter Procedure 
FUNCTION setDefaultPrinter RETURNS LOGICAL PRIVATE
  ( pcPrinter AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Use windows API to set the default printer for the current user
------------------------------------------------------------------------------*/
  /* Ensure that we got the full printer definition (including port + driver) */
  IF NUM-ENTRIES(pcPrinter) = 1 THEN
    pcPrinter = getPrinterDefinition(pcPrinter).

  /* Fix the required format */
  IF INDEX(pcPrinter, ':') = 0 then
      pcPrinter = pcPrinter + ':'.

  RUN WriteProfileStringA (
      'Windows',
      'Device',
      pcPrinter).
  RETURN YES.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-setParametro) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION setParametro Procedure 
FUNCTION setParametro RETURNS LOGICAL
  ( chReport AS COM-HANDLE , p-param AS CHAR , p-valor AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: pasa los parametros por nombre en vez de por posicion 
    Notes:  
------------------------------------------------------------------------------*/
        DEFINE VARIABLE chField       AS COM-HANDLE NO-UNDO.
        DEFINE VARIABLE iTmp AS INT NO-UNDO.
        chField = chReport:ParameterFields:GetItemByName(p-param).
        iTmp = chField:valueType.
          CASE iTmp:
            WHEN {&crStringField} THEN
              chField:AddCurrentValue( p-valor ).
            WHEN {&crNumberField} THEN
              chField:AddCurrentValue( DECIMAL( p-valor )).
            WHEN {&crDateField} THEN
              chField:AddCurrentValue( DATE( p-valor )).
            WHEN {&crBooleanField} THEN
              chField:AddCurrentValue( LOGICAL( p-valor )).
            OTHERWISE DO:
              RUN ponmensj.p("CRY010").
              RETURN FALSE.
            END.
          END CASE.
          RELEASE OBJECT chField.
          chField = ?.
          RETURN TRUE.
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-Tempfile) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION Tempfile Procedure 
FUNCTION Tempfile RETURNS CHARACTER
  ( direct AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: retorna el fullpath de  archivo temporal  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR seed AS CHAR NO-UNDO.
IF direct = "" THEN direct = SESSION:TEMP-DIRECTORY.
/*seed = GUID(GENERATE-UUID).*/
seed=USERID("sic").
xfile = SUBST('&1/cr-' + seed , direct) . 
xfile = REPLACE(xfile,"/","\").
xfile = xfile + ".xml".
  RETURN xfile.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-TempReport) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION TempReport Procedure 
FUNCTION TempReport RETURNS CHARACTER
  ( direct AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose: retorna el fullpath  de un archivo temporal sin extension  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR xfile AS CHAR NO-UNDO.
DEF VAR seed AS CHAR NO-UNDO.
IF direct = "" THEN direct = SESSION:TEMP-DIRECTORY.
/*seed = GUID(GENERATE-UUID).*/
seed=USERID("sic").
xfile = SUBST('&1/cr-' + seed , direct) . 
xfile = REPLACE(xfile,"/","\").
  RETURN xfile.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

