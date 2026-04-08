 
 /*------------------------------------------------------------------------
    File        : ParametroUtil
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Fri Mar 27 17:55:06 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Progress.Lang.*.

CLASS mfvsys.Common.ParametroUtil FINAL: 
    DEFINE STATIC TEMP-TABLE ttParametro NO-UNDO
        FIELD Nombre AS CHARACTER
        FIELD Valor  AS CHARACTER
        INDEX Nombre Nombre.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC STATIC VOID cargaParametro(INPUT pcNombre AS CHARACTER, INPUT pcValor AS CHARACTER):
		CREATE ttParametro.
		ASSIGN ttParametro.Nombre = pcNombre
		       ttParametro.Valor  = pcValor.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC STATIC CHARACTER getValor(INPUT pcNombre AS CHARACTER):
		FIND FIRST ttParametro WHERE ttParametro.Nombre = pcNombre NO-LOCK NO-ERROR.
		IF AVAILABLE(ttParametro) THEN
		    RETURN ttParametro.Valor.
		ELSE
		    RETURN "".
	END METHOD.
END CLASS.