
/*------------------------------------------------------------------------
    File        : IWhereParent
    Purpose     : 
    Syntax      : 
    Description : Interfaz para los forms/dialog que necesiten ser
                  contenedores de ParametroWhereControl.
    Author(s)   : Marcelo Ferrante
    Created     : Thu Apr 16 22:43:06 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING mfvsys.Reporte.ui.ParametroWhereControl.

INTERFACE mfvsys.Reporte.ui.IWhereParent:  
	METHOD PUBLIC VOID AgregarParametro().
    METHOD PUBLIC VOID BorrarParametro().
END INTERFACE.