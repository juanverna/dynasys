 
 /*------------------------------------------------------------------------
    File        : BasicKeyNameElement
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Sun Nov 30 21:07:02 BRST 2014
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

CLASS mfvsys.Common.BasicKeyNameElement INHERITS System.Object: 
DEFINE PUBLIC PROPERTY elementKey  AS CHARACTER NO-UNDO GET. SET.
DEFINE PUBLIC PROPERTY elementName AS CHARACTER NO-UNDO GET. SET.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	CONSTRUCTOR PUBLIC BasicKeyNameElement (INPUT cKey AS CHARACTER, INPUT cName AS CHARACTER):
		SUPER ().
		ASSIGN elementKey  = cKey
		       elementName = cName.
	END CONSTRUCTOR.

	METHOD OVERRIDE PUBLIC CHARACTER ToString(  ):
		RETURN elementName.
	END METHOD.	
END CLASS.