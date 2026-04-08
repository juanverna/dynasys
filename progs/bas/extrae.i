/*extrae.i extraccion de un tag del XML*/
function extrae RETURNS CHARACTER
  (  ppatron AS CHAR ,pdata AS CHAR) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEFINE VAR kk AS INT NO-UNDO.
kk = LOOKUP( ppatron , pdata , "|" ). 
IF kk = 0 THEN RETURN ?.
RETURN ENTRY(kk + 1, pdata , "|" ).

END FUNCTION.
