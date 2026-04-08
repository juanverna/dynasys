
/*------------------------------------------------------------------------
    File        : getreporteschema.p
    Purpose     : 

    Syntax      :

    Description :  

    Author(s)   : 
    Created     : Fri Apr 10 00:12:07 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
{inc/dsReporteSchema.i} 
{inc/eReporteParamPredef.i}

DEFINE OUTPUT PARAMETER DATASET FOR dsReporteSchema.
DEFINE OUTPUT PARAMETER TABLE   FOR eReporteParamPredef.

/* ********************  Preprocessor Definitions  ******************** */

/* ***************************  Main Block  *************************** */
/*FOR EACH ReporteSchTabla NO-LOCK:
    CREATE eReporteSchTabla.
    BUFFER-COPY ReporteSchTabla TO eReporteSchTabla.
    FIND FIRST _file WHERE _file._file-name = ReporteSchTabla.Tabla NO-LOCK NO-ERROR.

    FOR EACH ReporteSchCampo NO-LOCK WHERE ReporteSchCampo.Tabla = ReporteSchTabla.Tabla:
        CREATE eReporteSchCampo.
        BUFFER-COPY ReporteSchCampo TO eReporteSchCampo.
        FIND FIRST _field WHERE _field._file-recid = RECID(_file) AND _field._field-name = ReporteSchCampo.Campo NO-LOCK NO-ERROR.
        IF AVAILABLE(_field) THEN
            ASSIGN eReporteSchCampo.Tipo = _field._Data-type.
    END.
END.

FOR EACH ReporteParamPredef:
    CREATE eReporteParamPredef.
    BUFFER-COPY ReporteParamPredef TO eReporteParamPredef.
END.*/

