 
 /*------------------------------------------------------------------------
    File        : ReporteGlobales
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Thu Feb 12 13:38:06 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

CLASS mfvsys.Reporte.Common.GlobalesReporte: 
    DEFINE PUBLIC STATIC PROPERTY AppServerHandle AS HANDLE    NO-UNDO GET. SET.
    DEFINE PUBLIC STATIC PROPERTY AppServerPath   AS CHARACTER NO-UNDO GET. SET.
END CLASS.