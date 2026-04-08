/*=================================================================================*/
/*               IMPRESION DE FACTURAS DE TIPO B                                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*se genera el dataset y se llama al CR para su impresion */
/*a fin de reutilizar codigo se utilizar el programa de rango 
con desde Y hasta en el mismo formulario*/


DEFINE VAR reporte AS CHAR NO-UNDO.
DEF VAR ERROR_nro AS INT NO-UNDO.
FIND fac_header WHERE ROWID(fac_header) = act_factura NO-LOCK.
FIND empresa OF fac_header NO-LOCK.

{crystal_dyna.p}
RUN FAC/prfab234MR.p ( 
    INPUT  Fac_header.tip_comprob ,
    INPUT  Fac_header.prf_comprob,
    INPUT  Fac_header.nro_comprob,
    INPUT  Fac_header.nro_comprob,
    INPUT  empresa.cdg_empresa,
    OUTPUT  xfile ).

CREATE "CrystalRuntime.Application" chApplication.
RUN fullpath(xfile,"",OUTPUT xfile).
RUN fullpath("FAC/prfab234.rpt","",OUTPUT reporte).
chReport = chApplication:OpenReport(reporte).
chReport:Database:Tables:item(1):setTableLocation(xfile, '', '').


/* The FALSE parameter below will keep the print dialog from displaying. */
/* See Crystal Reports ActiveX documentation for other options.          */

chReport:PrintOut(FALSE).

RELEASE OBJECT chReport.                    
RELEASE OBJECT chApplication.
RUN borra_temp( INPUT xfile, OUTPUT ERROR_nro ).
