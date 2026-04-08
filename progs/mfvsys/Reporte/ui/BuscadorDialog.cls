 /*------------------------------------------------------------------------
    File        : BuscadorDialog
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Thu Feb 12 11:31:27 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Progress.Windows.Form.
USING mfvsys.Reporte.Common.GlobalesReporte.  

CLASS mfvsys.Reporte.ui.BuscadorDialog INHERITS Form   : 

    DEFINE PRIVATE VARIABLE bsDatos AS Progress.Data.BindingSource NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE pnGrid AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnBotones AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE grDatos AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE txMensaje AS System.Windows.Forms.TextBox NO-UNDO.

    DEFINE VARIABLE Tabla AS CHARACTER NO-UNDO.
    DEFINE VARIABLE ID    AS CHARACTER NO-UNDO.
    DEFINE VARIABLE Campo AS CHARACTER NO-UNDO.

    DEFINE TEMP-TABLE ttBuscador NO-UNDO
        FIELD codigo AS CHARACTER
        FIELD nombre AS CHARACTER
        INDEX nombre nombre.

    DEFINE PUBLIC PROPERTY Codigo AS CHARACTER NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY Nombre AS CHARACTER NO-UNDO GET. SET.

    DEFINE QUERY qBuscador FOR ttBuscador SCROLLING.

	CONSTRUCTOR PUBLIC BuscadorDialog(INPUT pctabla AS CHARACTER, INPUT pcid AS CHARACTER, INPUT pccampo AS CHARACTER):
		SUPER().
		InitializeComponent().
		ASSIGN Tabla = pcTabla
		       ID    = pcid
		       Campo = pccampo.
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BuscadorDialog():
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID BuscadorDialog_Shown( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    ASSIGN txMensaje:TEXT      = "Obteniendo Datos..."
	           THIS-OBJECT:ENABLED = FALSE.

		IF GlobalesReporte:AppServerHandle = ? THEN
		    RUN getbuscadordatos.p (INPUT Tabla, INPUT ID, INPUT Campo, OUTPUT TABLE ttBuscador).
		ELSE
		    RUN getbuscadordatos.p ON SERVER GlobalesReporte:AppServerHandle (INPUT Tabla, INPUT ID, INPUT Campo, OUTPUT TABLE ttBuscador). 

        OPEN QUERY qBuscador FOR EACH ttBuscador NO-LOCK.
        bsDatos:HANDLE = QUERY qBuscador:HANDLE.

        ASSIGN txMensaje:TEXT      = ""
               THIS-OBJECT:ENABLED = TRUE.
	END METHOD.

    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
        ASSIGN THIS-OBJECT:Codigo = ttBuscador.codigo
               THIS-OBJECT:Nombre = ttBuscador.nombre.

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
		
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance3 AS Infragistics.Win.Appearance NO-UNDO.
        appearance3 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance4 AS Infragistics.Win.Appearance NO-UNDO.
        appearance4 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance5 AS Infragistics.Win.Appearance NO-UNDO.
        appearance5 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance6 AS Infragistics.Win.Appearance NO-UNDO.
        appearance6 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance7 AS Infragistics.Win.Appearance NO-UNDO.
        appearance7 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance8 AS Infragistics.Win.Appearance NO-UNDO.
        appearance8 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance9 AS Infragistics.Win.Appearance NO-UNDO.
        appearance9 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance10 AS Infragistics.Win.Appearance NO-UNDO.
        appearance10 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance11 AS Infragistics.Win.Appearance NO-UNDO.
        appearance11 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance12 AS Infragistics.Win.Appearance NO-UNDO.
        appearance12 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:buttonOk = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonCancel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:pnBotones = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:txMensaje = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:pnGrid = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:grDatos = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:bsDatos = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:pnBotones:SuspendLayout().
        THIS-OBJECT:pnGrid:SuspendLayout().
        CAST(THIS-OBJECT:grDatos, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:bsDatos, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(188, 1).
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
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(263, 1).
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
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:txMensaje).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonOk).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonCancel).
        THIS-OBJECT:pnBotones:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnBotones:Location = NEW System.Drawing.Point(0, 337).
        THIS-OBJECT:pnBotones:Name = "pnBotones".
        THIS-OBJECT:pnBotones:Size = NEW System.Drawing.Size(343, 28).
        THIS-OBJECT:pnBotones:TabIndex = 2.
        /*  */
        /* txMensaje */
        /*  */
        THIS-OBJECT:txMensaje:Location = NEW System.Drawing.Point(3, 3).
        THIS-OBJECT:txMensaje:Name = "txMensaje".
        THIS-OBJECT:txMensaje:ReadOnly = TRUE.
        THIS-OBJECT:txMensaje:Size = NEW System.Drawing.Size(143, 20).
        THIS-OBJECT:txMensaje:TabIndex = 2.
        /*  */
        /* pnGrid */
        /*  */
        THIS-OBJECT:pnGrid:Controls:Add(THIS-OBJECT:grDatos).
        THIS-OBJECT:pnGrid:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnGrid:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnGrid:Name = "pnGrid".
        THIS-OBJECT:pnGrid:Size = NEW System.Drawing.Size(343, 337).
        THIS-OBJECT:pnGrid:TabIndex = 3.
        /*  */
        /* grDatos */
        /*  */
        THIS-OBJECT:grDatos:DataSource = THIS-OBJECT:bsDatos.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:grDatos:DisplayLayout:Appearance = appearance1.
        THIS-OBJECT:grDatos:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grDatos:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:Hidden = TRUE.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:Prompt = " ".
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grDatos:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:grDatos:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:grDatos:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:grDatos:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:grDatos:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:grDatos:DisplayLayout:Override:AllowRowFiltering = Infragistics.Win.DefaultableBoolean:True.
        THIS-OBJECT:grDatos:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:grDatos:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grDatos:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:grDatos:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:grDatos:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:grDatos:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grDatos:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:grDatos:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:grDatos:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:grDatos:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:grDatos:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:grDatos:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:grDatos:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:grDatos:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:grDatos:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:grDatos:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:grDatos:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:grDatos:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:grDatos:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:grDatos:Name = "grDatos".
        THIS-OBJECT:grDatos:Size = NEW System.Drawing.Size(343, 337).
        THIS-OBJECT:grDatos:TabIndex = 0.
        THIS-OBJECT:grDatos:Text = "ultraGrid1".
        /*  */
        /* bsDatos */
        /*  */
        THIS-OBJECT:bsDatos:MaxDataGuess = 0.
        THIS-OBJECT:bsDatos:NoLOBs = FALSE.
        THIS-OBJECT:bsDatos:TableSchema = ?.
        /*  */
        /* BuscadorDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(343, 365).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnBotones).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:FixedDialog.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "BuscadorDialog".
        THIS-OBJECT:ShowInTaskbar = FALSE.
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterParent.
        THIS-OBJECT:Text = "Busqueda de Datos".
        THIS-OBJECT:Shown:Subscribe(THIS-OBJECT:BuscadorDialog_Shown).
        THIS-OBJECT:pnBotones:ResumeLayout(FALSE).
        THIS-OBJECT:pnBotones:PerformLayout().
        THIS-OBJECT:pnGrid:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:grDatos, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:bsDatos, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD. 
 
	METHOD PUBLIC VOID ShowModalDialog(  ):
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD.
END CLASS.
