 /*------------------------------------------------------------------------
    File        : WhereDialog
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Marcelo Ferrante
    Created     : Sun Apr 12 16:32:43 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/
USING Progress.Windows.Form.
USING mfvsys.Reporte.ui.ParametroWhereControl.

CLASS mfvsys.Reporte.ui.WhereDialog INHERITS Form IMPLEMENTS mfvsys.Reporte.ui.IWhereParent FINAL:
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE pnBotones AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnParametros AS System.Windows.Forms.FlowLayoutPanel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnTop AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE lbTabla AS System.Windows.Forms.Label NO-UNDO.

    DEFINE PRIVATE VARIABLE iOrden  AS INT64 NO-UNDO.
    DEFINE PRIVATE VARIABLE txTabla AS System.Windows.Forms.TextBox NO-UNDO.

    DEFINE PUBLIC PROPERTY IDReporte AS INT64                NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY Campos    AS System.Object EXTENT NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY Params    AS System.Object EXTENT NO-UNDO GET. SET.

    DEFINE PUBLIC PROPERTY BufferName AS CHARACTER GET.
    SET(INPUT nuevo AS CHARACTER):
        ASSIGN BufferName   = nuevo
               txTabla:TEXT = nuevo.
    END SET.

    DEFINE TEMP-TABLE ttParametro NO-UNDO
        FIELD Orden  AS INT64
        FIELD Objeto AS Progress.Lang.Object
        INDEX orden orden.

    {inc/eReporteBuffCond.i}

	CONSTRUCTOR PUBLIC WhereDialog():
		SUPER().
		InitializeComponent().
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC WhereDialog():
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID AgregarParametro():
        DEFINE VARIABLE par1 AS ParametroWhereControl NO-UNDO.
        ASSIGN par1       = NEW ParametroWhereControl(THIS-OBJECT)
               par1:Size  = NEW System.Drawing.Size(556, 30)
               iOrden     = iOrden + 10
               par1:Orden = iOrden.
        par1:CargarCampos(Campos).
        par1:CargarParametros(Params).
        THIS-OBJECT:pnParametros:Controls:Add(par1).
        CREATE ttParametro.
        ASSIGN ttParametro.Orden  = iOrden
               ttParametro.Objeto = par1.
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ObtieneTempTable(OUTPUT TABLE eReporteBuffCond):
        DEFINE VARIABLE p AS ParametroWhereControl NO-UNDO.

        FOR EACH ttParametro NO-LOCK:
            ASSIGN p = CAST(ttParametro.Objeto, ParametroWhereControl).
            CREATE eReporteBuffCond.
            ASSIGN eReporteBuffCond.AndOr         = p:Condicion
                   eReporteBuffCond.Campo         = p:NombreCampo
                   eReporteBuffCond.IDCondicion   = p:Orden
                   eReporteBuffCond.IDReporte     = THIS-OBJECT:IDReporte
                   eReporteBuffCond.NombreBuffer  = THIS-OBJECT:BufferName
                   eReporteBuffCond.Operador      = p:Operador
                   eReporteBuffCond.ParentesisDer = p:ParentesisDerecho
                   eReporteBuffCond.ParentesisIzq = p:ParentesisIzquierdo
                   eReporteBuffCond.Valor         = p:Valor.
        END.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID BorrarParametro():
		UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Ok.
		THIS-OBJECT:Close().
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
	METHOD PRIVATE VOID cancelButton_Click (sender AS System.Object, e AS System.EventArgs):
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Cancel.
		THIS-OBJECT:Close().
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/   
	METHOD PRIVATE VOID InitializeComponent ( ):

		/* NOTE: The following method is automatically generated.
		   
		   We strongly suggest that the contents of this method only be modified using the 
		   Visual Designer to avoid any incompatible modifications.
		   
		   Modifying the contents of this method using a code editor will invalidate any support for this file. */
		
        THIS-OBJECT:buttonOk = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonCancel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:pnTop = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:txTabla = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbTabla = NEW System.Windows.Forms.Label().
        THIS-OBJECT:pnParametros = NEW System.Windows.Forms.FlowLayoutPanel().
        THIS-OBJECT:pnBotones = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:pnTop:SuspendLayout().
        THIS-OBJECT:pnBotones:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(428, 2).
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
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(506, 2).
        THIS-OBJECT:buttonCancel:Name = "buttonCancel".
        THIS-OBJECT:buttonCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonCancel:TabIndex = 1.
        THIS-OBJECT:buttonCancel:Text = "Cancelar".
        THIS-OBJECT:buttonCancel:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonCancel:Click:Subscribe(THIS-OBJECT:cancelButton_Click).
        /*  */
        /* pnTop */
        /*  */
        THIS-OBJECT:pnTop:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:txTabla).
        THIS-OBJECT:pnTop:Controls:Add(THIS-OBJECT:lbTabla).
        THIS-OBJECT:pnTop:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:pnTop:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnTop:Name = "pnTop".
        THIS-OBJECT:pnTop:Size = NEW System.Drawing.Size(585, 34).
        THIS-OBJECT:pnTop:TabIndex = 2.
        /*  */
        /* txTabla */
        /*  */
        THIS-OBJECT:txTabla:Location = NEW System.Drawing.Point(61, 5).
        THIS-OBJECT:txTabla:Name = "txTabla".
        THIS-OBJECT:txTabla:ReadOnly = TRUE.
        THIS-OBJECT:txTabla:Size = NEW System.Drawing.Size(210, 20).
        THIS-OBJECT:txTabla:TabIndex = 1.
        /*  */
        /* lbTabla */
        /*  */
        THIS-OBJECT:lbTabla:Location = NEW System.Drawing.Point(10, 4).
        THIS-OBJECT:lbTabla:Name = "lbTabla".
        THIS-OBJECT:lbTabla:Size = NEW System.Drawing.Size(45, 20).
        THIS-OBJECT:lbTabla:TabIndex = 0.
        THIS-OBJECT:lbTabla:Text = "Tabla:".
        THIS-OBJECT:lbTabla:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbTabla:UseCompatibleTextRendering = TRUE.
        /*  */
        /* pnParametros */
        /*  */
        THIS-OBJECT:pnParametros:AutoScroll = TRUE.
        THIS-OBJECT:pnParametros:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnParametros:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnParametros:FlowDirection = System.Windows.Forms.FlowDirection:TopDown.
        THIS-OBJECT:pnParametros:Location = NEW System.Drawing.Point(0, 34).
        THIS-OBJECT:pnParametros:Name = "pnParametros".
        THIS-OBJECT:pnParametros:Size = NEW System.Drawing.Size(585, 357).
        THIS-OBJECT:pnParametros:TabIndex = 4.
        THIS-OBJECT:pnParametros:WrapContents = FALSE.
        /*  */
        /* pnBotones */
        /*  */
        THIS-OBJECT:pnBotones:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonCancel).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonOk).
        THIS-OBJECT:pnBotones:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnBotones:Location = NEW System.Drawing.Point(0, 362).
        THIS-OBJECT:pnBotones:Name = "pnBotones".
        THIS-OBJECT:pnBotones:Size = NEW System.Drawing.Size(585, 29).
        THIS-OBJECT:pnBotones:TabIndex = 5.
        /*  */
        /* WhereDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(585, 391).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnBotones).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnParametros).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnTop).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:FixedDialog.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "WhereDialog".
        THIS-OBJECT:ShowInTaskbar = FALSE.
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterScreen.
        THIS-OBJECT:Text = "Condiciones".
        THIS-OBJECT:Shown:Subscribe(THIS-OBJECT:WhereDialog_Shown).
        THIS-OBJECT:pnTop:ResumeLayout(FALSE).
        THIS-OBJECT:pnTop:PerformLayout().
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
 	METHOD PUBLIC VOID ShowModalDialog():
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID WhereDialog_Shown(INPUT sender AS System.Object, INPUT e AS System.EventArgs):
		AgregarParametro().
	END METHOD.
END CLASS.
