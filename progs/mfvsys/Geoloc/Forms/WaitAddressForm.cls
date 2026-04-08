 
 /*------------------------------------------------------------------------
    File        : WaitAddressForm
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Mon Mar 23 23:19:13 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.



CLASS mfvsys.Geoloc.Forms.WaitAddressForm INHERITS Form: 
	
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE prBar AS System.Windows.Forms.ProgressBar NO-UNDO.

    DEFINE VARIABLE lSube      AS LOGICAL NO-UNDO INITIAL TRUE.
    DEFINE VARIABLE currentValue AS INTEGER NO-UNDO.
    DEFINE VARIABLE maxValue     AS INTEGER NO-UNDO.
    DEFINE VARIABLE minValue     AS INTEGER NO-UNDO.
    DEFINE PRIVATE VARIABLE TimerAutoRun AS System.Windows.Forms.Timer NO-UNDO.
		
	CONSTRUCTOR PUBLIC WaitAddressForm (  ):
        SUPER().
        InitializeComponent().
    /*    THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).*/
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END CONSTRUCTOR.

	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        THIS-OBJECT:prBar = NEW System.Windows.Forms.ProgressBar().
        THIS-OBJECT:TimerAutoRun = NEW System.Windows.Forms.Timer(THIS-OBJECT:components).
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* prBar */
        /*  */
        THIS-OBJECT:prBar:Location = NEW System.Drawing.Point(3, 2).
        THIS-OBJECT:prBar:Name = "prBar".
        THIS-OBJECT:prBar:Size = NEW System.Drawing.Size(174, 23).
        THIS-OBJECT:prBar:TabIndex = 0.
        /*  */
        /* TimerAutoRun */
        /*  */
        THIS-OBJECT:TimerAutoRun:Tick:Subscribe(THIS-OBJECT:timer1_Tick).
        /*  */
        /* WaitAddressForm */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(179, 30).
        THIS-OBJECT:ControlBox = FALSE.
        THIS-OBJECT:Controls:Add(THIS-OBJECT:prBar).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:Fixed3D.
        THIS-OBJECT:Name = "WaitAddressForm".
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterScreen.
        THIS-OBJECT:Text = "Verificando la Direccion".
        THIS-OBJECT:TopMost = TRUE.
        THIS-OBJECT:Shown:Subscribe(THIS-OBJECT:WaitAddressForm_Shown).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID timer1_Tick( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		IF currentValue = maxValue THEN
            ASSIGN lSube = FALSE.

        IF currentValue = minValue THEN
            ASSIGN lSube = TRUE. 

            IF lSube THEN
                ASSIGN currentValue = currentValue + 1.
            ELSE
               ASSIGN currentValue = currentValue - 1.

        ASSIGN prBar:VALUE = currentValue.
		RETURN.

	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID WaitAddressForm_Shown( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        /*ASSIGN prBar:Style = Infragistics.Win.UltraWinProgressBar.ProgressBarStyle:Segmented.*/
               prBar:MINIMUM = 1.
               prBar:MAXIMUM = 100.
               prBar:VALUE   = 2.
               maxValue      = prBar:MAXIMUM.
               minValue      = prBar:MINIMUM.
               currentValue  = prBar:VALUE.
               TimerAutoRun:INTERVAL = 10.
        TimerAutoRun:Start().
	END METHOD.

	DESTRUCTOR PUBLIC WaitAddressForm ( ):

	END DESTRUCTOR.

END CLASS.
