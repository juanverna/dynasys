 /*------------------------------------------------------------------------
    File        : ParametrosDialog
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Wed Feb 11 10:11:37 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Progress.Windows.Form.
USING mfvsys.Reporte.ui.ParametroControl.

CLASS mfvsys.Reporte.ui.ParametrosDialog INHERITS Form   : 
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE pnBotones AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnParametros AS System.Windows.Forms.FlowLayoutPanel NO-UNDO.

    {inc/ttParametro.i "REFERENCE-ONLY"}
	CONSTRUCTOR PUBLIC ParametrosDialog(INPUT TABLE ttParametro BIND):
		SUPER().
		InitializeComponent ( ).
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC ParametrosDialog( ):
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.

    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
        FOR EACH ttParametro:
            ASSIGN ttParametro.Valor = CAST(ttParametro.Objeto, ParametroControl):Valor.
        END.
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Ok.
		THIS-OBJECT:Close ( ).
	END METHOD.

	METHOD PRIVATE VOID cancelButton_Click (sender AS System.Object, e AS System.EventArgs):
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Cancel.
		THIS-OBJECT:Close ( ).
	END METHOD.

	METHOD PRIVATE VOID InitializeComponent ( ):

		/* NOTE: The following method is automatically generated.
		   
		   We strongly suggest that the contents of this method only be modified using the 
		   Visual Designer to avoid any incompatible modifications.
		   
		   Modifying the contents of this method using a code editor will invalidate any support for this file. */
		
        THIS-OBJECT:buttonOk = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonCancel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:pnBotones = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:pnParametros = NEW System.Windows.Forms.FlowLayoutPanel().
        THIS-OBJECT:pnBotones:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(196, 2).
        THIS-OBJECT:buttonOk:Name = "buttonOk".
        THIS-OBJECT:buttonOk:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonOk:TabIndex = 0.
        THIS-OBJECT:buttonOk:Text = "Aceptar".
        THIS-OBJECT:buttonOk:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonOk:Click:Subscribe(THIS-OBJECT:okButton_Click).
        /*  */
        /* buttonCancel */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonCancel:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(273, 2).
        THIS-OBJECT:buttonCancel:Name = "buttonCancel".
        THIS-OBJECT:buttonCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonCancel:TabIndex = 1.
        THIS-OBJECT:buttonCancel:Text = "Cancelar".
        THIS-OBJECT:buttonCancel:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonCancel:Click:Subscribe(THIS-OBJECT:cancelButton_Click).
        /*  */
        /* pnBotones */
        /*  */
        THIS-OBJECT:pnBotones:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonCancel).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonOk).
        THIS-OBJECT:pnBotones:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnBotones:Location = NEW System.Drawing.Point(0, 302).
        THIS-OBJECT:pnBotones:Name = "pnBotones".
        THIS-OBJECT:pnBotones:Size = NEW System.Drawing.Size(354, 29).
        THIS-OBJECT:pnBotones:TabIndex = 2.
        /*  */
        /* pnParametros */
        /*  */
        THIS-OBJECT:pnParametros:AutoScroll = TRUE.
        THIS-OBJECT:pnParametros:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnParametros:FlowDirection = System.Windows.Forms.FlowDirection:TopDown.
        THIS-OBJECT:pnParametros:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnParametros:Name = "pnParametros".
        THIS-OBJECT:pnParametros:Size = NEW System.Drawing.Size(354, 302).
        THIS-OBJECT:pnParametros:TabIndex = 3.
        THIS-OBJECT:pnParametros:WrapContents = FALSE.
        /*  */
        /* ParametrosDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(354, 331).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnParametros).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnBotones).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:FixedDialog.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "ParametrosDialog".
        THIS-OBJECT:ShowInTaskbar = FALSE.
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterScreen.
        THIS-OBJECT:Text = "Ingreso de Parametros".
        THIS-OBJECT:Load:Subscribe(THIS-OBJECT:ParametrosDialog_Load).
        THIS-OBJECT:pnBotones:ResumeLayout(FALSE).
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
	METHOD PRIVATE VOID ParametrosDialog_Load( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		DEFINE VARIABLE i     AS INTEGER          NO-UNDO.
		DEFINE VARIABLE parametroClass AS ParametroControl NO-UNDO.

		FOR EACH ttParametro:
            ASSIGN parametroClass                     = NEW ParametroControl(INPUT TEMP-TABLE ttParametro:DEFAULT-BUFFER-HANDLE)
                   parametroClass:Name                = STRING("Texto" + STRING(i))
                   parametroClass:VISIBLE             = TRUE
                   parametroClass:Buscador            = ttParametro.Buscador
                   parametroClass:BuscadorCampoID     = ttParametro.BuscadorCampoID
                   parametroClass:BuscadorCampoNombre = ttParametro.BuscadorCampoNombre
                   parametroClass:BuscadorTabla       = ttParametro.BuscadorTabla
                   ttParametro.Objeto                 = parametroClass.
		    pnParametros:Controls:Add(parametroClass).
		END.
	END METHOD.

	METHOD PUBLIC VOID ShowModalDialog(  ):
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD.
END CLASS.
