/*crea las facturas en el disco en la nube para propositos de backup*/
{advtexto.i}
{crystal_dyna.p}
{html.i}
{findempresa.i}
 
DEFINE VAR n AS INT64 NO-UNDO.

DEFINE TEMP-TABLE archivos NO-UNDO
        FIELD archivo AS CHAR
        FIELD direccion AS CHAR
        FIELD comprobante AS CHAR
        FIELD fecha AS DATE  
        FIELD cuit AS CHAR FORMAT "X(13)" 
        /*FIELD neto AS char
        FIELD iva AS CHAR*/
        FIELD tot AS char.

DEFINE VAR ReportePath AS CHAR NO-UNDO.
DEFINE VAR cFullPath AS CHAR NO-UNDO.
DEFINE VAR xFullPath AS CHAR NO-UNDO.

FUNCTION formularioFAC RETURNS CHARACTER
      ( INPUT rid_factura AS ROWID ) :
    /*------------------------------------------------------------------------------
      Purpose:  retorna el formulario a utilizar
    ------------------------------------------------------------------------------*/
    DEFINE VARIABLE que_formulario      AS CHARACTER NO-UNDO.
    DEFINE VARIABLE x-formulario        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE j                   AS INTEGER NO-UNDO.
    
    {parlocales.i}

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.

    FIND Tipocomprobante OF Fac_header NO-LOCK.
    IF Tipocomprobante.usa_letra
       THEN FIND Condicion_impos OF Fac_header NO-LOCK.

    x-formulario = Tipocomprobante.prefijo_formulario.
    IF Tipocomprobante.usa_letra
       THEN x-formulario = REPLACE(x-formulario,"*",Condicion_impos.tipo_factura). 

    RUN getparametro.p (  INPUT  x-formulario,
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    que_formulario = Tipocomprobante.prefijo_programa + STRING(v-valor_n, "999").
    IF Tipocomprobante.usa_letra
       THEN que_formulario = REPLACE(que_formulario,"*",Condicion_impos.tipo_factura).

    FIND Punto-venta 
        WHERE Punto-venta.cdg_empresa = Fac_header.cdg_empresa
          AND Punto-venta.cdg_puntovta = Fac_header.prf_comprob
              NO-LOCK.

    que_formulario = que_formulario + TRIM(Punto-venta.impresor).

    RETURN que_formulario.   /* Function return value. */

END FUNCTION.


/*proceso*/
/*a quien le enviamos*/
SESSION:IMMEDIATE-DISPLAY = TRUE.
n = 0.
FOR EACH fac_header NO-LOCK WHERE fac_header.prf_comprob = 3 AND fac_header.cai <> "":
    exportFileName = "c:\backupNube\Facturas\" + "Fact_" + fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + ".pdf".
    IF SEARCH( exportFileName ) <> ? THEN NEXT.
    DISPLAY fac_header.tip_comprob fac_header.prf_comprob fac_header.nro_comprob.
    FIND punto-venta WHERE punto-venta.cdg_puntovta = fac_header.prf_comprob NO-LOCK NO-ERROR. 
    ReportePath = "FAC/" + formularioFAC( ROWID(fac_header) ).
    RUN VALUE( reportePath + "MR.p")  ( 
                            INPUT fac_header.tip_comprob,
                            INPUT fac_header.prf_comprob,
                            INPUT fac_header.nro_comprob,
                            INPUT fac_header.nro_comprob,
                            INPUT fac_header.cdg_empresa,
                            INPUT TRUE,
                            OUTPUT xfile
                           ).
    RUN fullPath (ReportePath, '.rpt':U, OUTPUT cFullPath).
    IF cFullPath = ? THEN 
            RETURN ERROR fac_header.tip_comprob + "-" + string(fac_header.prf_comprob) + "-" + string(fac_header.nro_comprob) + " impresor " + ReportePath + ".rpt no encontrado".
    
    CREATE "CrystalRuntime.Application" chApplication.
        chReport = chApplication:OpenReport(cFullPath, {&crOpenReportByTempCopy}).
        chReport:DiscardSavedData(). /*eliminando lo previamente grabado*/
    RUN fullpath ( INPUT xfile, INPUT "", OUTPUT xFullPath ).
        chReport:Database:Tables:item(1):setTableLocation(xFullPath, '', '').
   /*  chReport:DisplayProgressDialog = FALSE.    */
    RUN crearReporte(chReport,"pdf",/*ViewReport*/ FALSE, /*impresora*/ "" , 
            /*exportToDisk*/ true, INPUT-OUTPUT exportFileName ).        
    RELEASE OBJECT chReport. 
    chReport = ?.
    RELEASE OBJECT chApplication.
    chApplication = ?.  
    n = n + 1.
    DISPLAY n.
    PAUSE 0.1.
END.


