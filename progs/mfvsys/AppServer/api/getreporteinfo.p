/*------------------------------------------------------------------------
    File        : getreporteinfo.p
    Purpose     :

    Syntax      :
 
    Description : 
 
    Author(s)   : 
    Created     : Tue Feb 10 23:46:17 BRST 2015  
    Notes       :  
  ----------------------------------------------------------------------*/ 

/* ***************************  Definitions  ************************** */
{inc/dsReporteInfo.i}

DEFINE INPUT  PARAMETER piReporte AS INT64 NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsReporteInfo.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
ASSIGN TEMP-TABLE ttReporteInfo:SCHEMA-MARSHAL   = "NONE":U
       TEMP-TABLE ttParametroInfo:SCHEMA-MARSHAL = "NONE":U
       TEMP-TABLE ttCampo:SCHEMA-MARSHAL         = "NONE":U.

FIND FIRST Reporte WHERE Reporte.IDReporte = piReporte NO-LOCK NO-ERROR.
IF AVAILABLE(Reporte) THEN DO:
    CREATE ttReporteInfo.
    BUFFER-COPY Reporte TO ttReporteInfo.

    FOR EACH ReporteParametro NO-LOCK WHERE ReporteParametro.IDReporte = piReporte:
        CREATE ttParametroInfo.
        BUFFER-COPY ReporteParametro TO ttParametroInfo.
    END.
END.

FOR EACH ReporteCampo WHERE ReporteCampo.IDReporte    =  piReporte AND
                            ReporteCampo.Tipo         NE "RL":U NO-LOCK:
    CREATE ttCampo.
    BUFFER-COPY ReporteCampo TO ttCampo.
END.