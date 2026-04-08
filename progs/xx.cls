  
 /*------------------------------------------------------------------------
    File        : xx
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : fernando
    Created     : Fri Oct 07 13:42:09 ACT 2016
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.



CLASS xx INHERITS Form   : 
	
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.


		
	CONSTRUCTOR PUBLIC xx (  ):
		
		
        SUPER().
        InitializeComponent().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END CONSTRUCTOR.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:SuspendLayout().
        THIS-OBJECT:Name = "xx".
        THIS-OBJECT:Text = "xx".
        THIS-OBJECT:ResumeLayout(false).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

	END METHOD.


	DESTRUCTOR PUBLIC xx ( ):

		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.

	END DESTRUCTOR.

END CLASS.