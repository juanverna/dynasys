/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER rad AS ROWID NO-UNDO.
DEFINE INPUT PARAMETER has_fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER timpre AS INT NO-UNDO.
DEFINE VARIABLE chSTATUS   AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE cFullPath     AS CHARACTER NO-UNDO. 
DEFINE VARIABLE xFullPath     AS CHARACTER NO-UNDO. 
DEFINE VARIABLE ReportePath AS CHARACTER NO-UNDO.
DEFINE VARIABLE ERROR_nro        AS INT NO-UNDO.
DEFINE BUFFER administrador FOR cliente.
DEF VAR cprinter AS CHAR.
{crystal_dyna.p}
{findempresa.i}
{impresoras.i}

DEFINE TEMP-TABLE T-orden       
    FIELD orden AS INT
    FIELD rfac AS ROWID
INDEX orden orden.
 {DEBUG.i}  
FIND administrador WHERE rowid(administrador) = rad NO-LOCK.
/*resumen de cobranzas*/  
RUN prinresumenesrec.p ( INPUT Empresa.cdg_empresa,
                     INPUT administrador.cdg_cliente,
                     INPUT administrador.cdg_cliente,
                     INPUT has_fecha,
                     INPUT 01/01/3000,
                     INPUT "*" , /*LISTA DE PUNTOS DE VENTA*/
                     INPUT 1,
                     OUTPUT TABLE t-orden,
                     OUTPUT xfile).
IF xfile <> ? THEN do:
    
    OS-DELETE VALUE( xfile + "R" ).
    OS-RENAME value(xfile) VALUE( xfile + "R" ).
    xfile = xfile + "R" .
    FIND FIRST t-orden NO-ERROR.
    IF NOT AVAILABLE t-orden THEN RETURN.
    RUN fullpath(xfile,"",OUTPUT xfile).
    ReportePath = "Resumen_cobranzas".
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? 
        THEN DO:
            RUN mensajepar.p (INPUT ReportePath, INPUT "CREP000").
            RETURN ERROR.
        END.
    
    CREATE "CrystalRuntime.Application" chApplication.
    chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
     IF chReport:HasSavedData THEN
            chReport:DiscardSavedData().
    chReport:Database:Tables:item(1):setTableLocation(xfile, '', '').
    cPrinter = getPrinterDefinition( impreport(timpre) ). 
    chReport:SelectPrinter(ENTRY(2, cPrinter), ENTRY(1, cPrinter), ENTRY(3, cPrinter)).
    chReport:DisplayProgressDialog = FALSE.
  /*  chReport:PaperSize = 11. /*A5 ver definiciones en cristal_dyna*/ 
    chReport:PaperOrientation = {&crLandScape}.*/
    CHstatus = chReport:PrintingStatus.
    chReport:PrintOut(FALSE).
    
    DO WHILE chStatus:PROGRESS = 2: END. 
    RELEASE OBJECT chReport. 
    RELEASE OBJECT chStatus. 
    RELEASE OBJECT chApplication.
    chApplication = ?.
    chReport = ?. 
    chStatus = ?.                  
    ETIME(YES).
    DO WHILE ETIME < 1000: END.
END.
    /*recibos pendientes*/
FOR EACH t-orden:
        FIND fac_header WHERE rowid(fac_header) = t-orden.rfac NO-LOCK.
        IF Fac_header.estado_2_impresion <> "" THEN NEXT.
        RUN imprerec1.p (t-orden.rfac,timpre).
/*        FIND evento WHERE fac_header.nro_evento = evento.nro_evento NO-ERROR.
        IF AVAILABLE evento THEN RUN impcertif(evento.nro_evento , "RE", 8 ).*/
        ETIME(YES).
        DO WHILE ETIME < 1000: END.
END.



