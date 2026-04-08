     /*------------------------------------------------------------------------
    File        : Viewer
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Tue Feb 10 13:04:25 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Infragistics.Documents.Reports.Graphics.*.
USING Infragistics.Documents.Reports.Report.*.
USING Infragistics.Documents.Reports.Report.Table.*.
USING Infragistics.Documents.Reports.Report.Section.*.
USING Infragistics.Documents.Reports.Report.Shapes.*.
USING Infragistics.Documents.Reports.Report.Text.*.
USING Progress.Windows.Form.

CLASS mfvsys.Reporte.ui.Viewer INHERITS Form: 

    DEFINE PRIVATE VARIABLE bsReporte AS Progress.Data.BindingSource NO-UNDO.
    DEFINE PRIVATE VARIABLE btExcel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btPDF AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE columnChooser AS Infragistics.Win.UltraWinGrid.UltraGridColumnChooser NO-UNDO.
    DEFINE PRIVATE VARIABLE btSeleccionarColumnas AS System.Windows.Forms.Button NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE excelExporter AS Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter NO-UNDO.
    DEFINE PRIVATE VARIABLE docExporter AS Infragistics.Win.UltraWinGrid.DocumentExport.UltraGridDocumentExporter NO-UNDO.
    DEFINE PRIVATE VARIABLE grReporte AS Infragistics.Win.UltraWinGrid.UltraGrid NO-UNDO.
    DEFINE PRIVATE VARIABLE pnBotones AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnTop AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE pnGrid AS System.Windows.Forms.Panel NO-UNDO.

    {inc/ttCampo.i "REFERENCE-ONLY"}
    {inc/ttParametro.i}

    DEFINE VARIABLE DatasetHandle AS HANDLE NO-UNDO.

    DEFINE VARIABLE hq AS HANDLE NO-UNDO.
    DEFINE PRIVATE VARIABLE popupControl AS Infragistics.Win.Misc.UltraPopupControlContainer NO-UNDO.

	CONSTRUCTOR PUBLIC Viewer(INPUT hDataset AS HANDLE, INPUT TABLE FOR ttCampo BIND):
		SUPER().
		InitializeComponent().
		ASSIGN DatasetHandle = hDataset.
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC Viewer( ):
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btExcel_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    DEFINE VARIABLE cArchivo AS CHARACTER NO-UNDO.
	    ASSIGN cArchivo = SESSION:TEMP-DIRECTORY + "rep":U + STRING(MTIME) + ".xls":U.
		excelExporter:Export(grReporte, cArchivo).
		System.Diagnostics.Process:Start(cArchivo).
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btSeleccionarColumnas_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		IF popupControl:IsDisplayed THEN
		    popupControl:CLOSE().
		ELSE
		    popupControl:show().
		RETURN.

	END METHOD.

	/*---------------------------------------------- --------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID button1_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        DEFINE VARIABLE reporte  AS Report.
        DEFINE VARIABLE seccion  AS ISection.
        DEFINE VARIABLE cArchivo AS CHARACTER NO-UNDO.

        ASSIGN cArchivo = SESSION:TEMP-DIRECTORY + "rep":U + STRING(MTIME) + ".pdf":U
               Reporte  = NEW Report()
               seccion  = Reporte:AddSection().
        docExporter:Export(grReporte, seccion).
        Reporte:Publish(cArchivo, Infragistics.Documents.Reports.Report.FileFormat:PDF).
        System.Diagnostics.Process:Start(cArchivo).
	END METHOD.

    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
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
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance13 AS Infragistics.Win.Appearance NO-UNDO.
        appearance13 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:buttonOk = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonCancel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:bsReporte = NEW Progress.Data.BindingSource(THIS-OBJECT:components).
        THIS-OBJECT:grReporte = NEW Infragistics.Win.UltraWinGrid.UltraGrid().
        THIS-OBJECT:pnBotones = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:btSeleccionarColumnas = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btPDF = NEW System.Windows.Forms.Button().
        THIS-OBJECT:btExcel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:pnGrid = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:columnChooser = NEW Infragistics.Win.UltraWinGrid.UltraGridColumnChooser().
        THIS-OBJECT:pnTop = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:docExporter = NEW Infragistics.Win.UltraWinGrid.DocumentExport.UltraGridDocumentExporter(THIS-OBJECT:components).
        THIS-OBJECT:excelExporter = NEW Infragistics.Win.UltraWinGrid.ExcelExport.UltraGridExcelExporter(THIS-OBJECT:components).
        THIS-OBJECT:popupControl = NEW Infragistics.Win.Misc.UltraPopupControlContainer(THIS-OBJECT:components).
        CAST(THIS-OBJECT:bsReporte, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:grReporte, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:pnBotones:SuspendLayout().
        THIS-OBJECT:pnGrid:SuspendLayout().
        CAST(THIS-OBJECT:columnChooser, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(535, 1).
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
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(613, 1).
        THIS-OBJECT:buttonCancel:Name = "buttonCancel".
        THIS-OBJECT:buttonCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonCancel:TabIndex = 1.
        THIS-OBJECT:buttonCancel:Text = "Cancelar".
        THIS-OBJECT:buttonCancel:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonCancel:Click:Subscribe(THIS-OBJECT:cancelButton_Click).
        /*  */
        /* bsReporte */
        /*  */
        THIS-OBJECT:bsReporte:MaxDataGuess = 0.
        THIS-OBJECT:bsReporte:NoLOBs = FALSE.
        THIS-OBJECT:bsReporte:TableSchema = ?.
        /*  */
        /* grReporte */
        /*  */
        DEFINE VARIABLE nestedvar2 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar2 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:grReporte:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar2, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:grReporte:DataSource = THIS-OBJECT:bsReporte.
        appearance1:BackColor = System.Drawing.SystemColors:Window.
        appearance1:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:grReporte:DisplayLayout:Appearance = appearance1.
        THIS-OBJECT:grReporte:DisplayLayout:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grReporte:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        appearance2:BackColor = System.Drawing.SystemColors:ActiveBorder.
        appearance2:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance2:BackGradientStyle = Infragistics.Win.GradientStyle:Vertical.
        appearance2:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:Appearance = appearance2.
        appearance3:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:BandLabelAppearance = appearance3.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:BorderStyle = Infragistics.Win.UIElementBorderStyle:Solid.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:Prompt = "Arrastrar una Columna para agrupar ".
        appearance4:BackColor = System.Drawing.SystemColors:ControlLightLight.
        appearance4:BackColor2 = System.Drawing.SystemColors:Control.
        appearance4:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance4:ForeColor = System.Drawing.SystemColors:GrayText.
        THIS-OBJECT:grReporte:DisplayLayout:GroupByBox:PromptAppearance = appearance4.
        THIS-OBJECT:grReporte:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:grReporte:DisplayLayout:MaxRowScrollRegions = 1.
        appearance5:BackColor = System.Drawing.SystemColors:Window.
        appearance5:ForeColor = System.Drawing.SystemColors:ControlText.
        THIS-OBJECT:grReporte:DisplayLayout:Override:ActiveCellAppearance = appearance5.
        appearance6:BackColor = System.Drawing.SystemColors:Highlight.
        appearance6:ForeColor = System.Drawing.SystemColors:HighlightText.
        THIS-OBJECT:grReporte:DisplayLayout:Override:ActiveRowAppearance = appearance6.
        THIS-OBJECT:grReporte:DisplayLayout:Override:AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew:No.
        THIS-OBJECT:grReporte:DisplayLayout:Override:AllowDelete = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:grReporte:DisplayLayout:Override:AllowUpdate = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:grReporte:DisplayLayout:Override:BorderStyleCell = Infragistics.Win.UIElementBorderStyle:Dotted.
        THIS-OBJECT:grReporte:DisplayLayout:Override:BorderStyleRow = Infragistics.Win.UIElementBorderStyle:Dotted.
        appearance7:BackColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CardAreaAppearance = appearance7.
        appearance8:BorderColor = System.Drawing.Color:Silver.
        appearance8:TextTrimming = Infragistics.Win.TextTrimming:EllipsisCharacter.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellAppearance = appearance8.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:grReporte:DisplayLayout:Override:CellPadding = 0.
        appearance9:BackColor = System.Drawing.SystemColors:Control.
        appearance9:BackColor2 = System.Drawing.SystemColors:ControlDark.
        appearance9:BackGradientAlignment = Infragistics.Win.GradientAlignment:Element.
        appearance9:BackGradientStyle = Infragistics.Win.GradientStyle:Horizontal.
        appearance9:BorderColor = System.Drawing.SystemColors:Window.
        THIS-OBJECT:grReporte:DisplayLayout:Override:GroupByRowAppearance = appearance9.
        appearance10:TextHAlignAsString = "Left".
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderAppearance = appearance10.
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:SortMulti.
        THIS-OBJECT:grReporte:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        appearance11:BackColor = System.Drawing.SystemColors:Window.
        appearance11:BorderColor = System.Drawing.Color:Silver.
        THIS-OBJECT:grReporte:DisplayLayout:Override:RowAppearance = appearance11.
        THIS-OBJECT:grReporte:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        appearance12:BackColor = System.Drawing.SystemColors:ControlLight.
        THIS-OBJECT:grReporte:DisplayLayout:Override:TemplateAddRowAppearance = appearance12.
        THIS-OBJECT:grReporte:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:grReporte:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:grReporte:DisplayLayout:ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand:OutlookGroupBy.
        THIS-OBJECT:grReporte:Font = NEW System.Drawing.Font("Microsoft Sans Serif", Progress.Util.CastUtil:ToSingle(8.25), System.Drawing.FontStyle:Regular, System.Drawing.GraphicsUnit:Point, System.Convert:ToByte(0)).
        THIS-OBJECT:grReporte:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:grReporte:Name = "grReporte".
        THIS-OBJECT:grReporte:Size = NEW System.Drawing.Size(691, 574).
        THIS-OBJECT:grReporte:TabIndex = 2.
        THIS-OBJECT:grReporte:Text = "ultraGrid1".
        /*  */
        /* pnBotones */
        /*  */
        THIS-OBJECT:pnBotones:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:btSeleccionarColumnas).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:btPDF).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:btExcel).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonCancel).
        THIS-OBJECT:pnBotones:Controls:Add(THIS-OBJECT:buttonOk).
        THIS-OBJECT:pnBotones:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnBotones:Location = NEW System.Drawing.Point(0, 629).
        THIS-OBJECT:pnBotones:Name = "pnBotones".
        THIS-OBJECT:pnBotones:Size = NEW System.Drawing.Size(695, 29).
        THIS-OBJECT:pnBotones:TabIndex = 3.
        /*  */
        /* btSeleccionarColumnas */
        /*  */
        THIS-OBJECT:btSeleccionarColumnas:Location = NEW System.Drawing.Point(163, 1).
        THIS-OBJECT:btSeleccionarColumnas:Name = "btSeleccionarColumnas".
        THIS-OBJECT:btSeleccionarColumnas:Size = NEW System.Drawing.Size(136, 23).
        THIS-OBJECT:btSeleccionarColumnas:TabIndex = 5.
        THIS-OBJECT:btSeleccionarColumnas:Text = "Seleccionar Columnas".
        THIS-OBJECT:btSeleccionarColumnas:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btSeleccionarColumnas:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btSeleccionarColumnas:Click:Subscribe(THIS-OBJECT:btSeleccionarColumnas_Click).
        /*  */
        /* btPDF */
        /*  */
        THIS-OBJECT:btPDF:Location = NEW System.Drawing.Point(82, 1).
        THIS-OBJECT:btPDF:Name = "btPDF".
        THIS-OBJECT:btPDF:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btPDF:TabIndex = 4.
        THIS-OBJECT:btPDF:Text = "PDF".
        THIS-OBJECT:btPDF:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btPDF:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btPDF:Click:Subscribe(THIS-OBJECT:button1_Click).
        /*  */
        /* btExcel */
        /*  */
        THIS-OBJECT:btExcel:Location = NEW System.Drawing.Point(3, 1).
        THIS-OBJECT:btExcel:Name = "btExcel".
        THIS-OBJECT:btExcel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:btExcel:TabIndex = 3.
        THIS-OBJECT:btExcel:Text = "Excel".
        THIS-OBJECT:btExcel:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btExcel:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btExcel:Click:Subscribe(THIS-OBJECT:btExcel_Click).
        /*  */
        /* pnGrid */
        /*  */
        DEFINE VARIABLE nestedvar3 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar3 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:pnGrid:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar3, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:pnGrid:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnGrid:Controls:Add(THIS-OBJECT:columnChooser).
        THIS-OBJECT:pnGrid:Controls:Add(THIS-OBJECT:grReporte).
        THIS-OBJECT:pnGrid:Location = NEW System.Drawing.Point(0, 48).
        THIS-OBJECT:pnGrid:Name = "pnGrid".
        THIS-OBJECT:pnGrid:Size = NEW System.Drawing.Size(695, 578).
        THIS-OBJECT:pnGrid:TabIndex = 4.
        /*  */
        /* columnChooser */
        /*  */
        appearance13:BackColor = System.Drawing.SystemColors:Window.
        appearance13:BorderColor = System.Drawing.SystemColors:InactiveCaption.
        THIS-OBJECT:columnChooser:DisplayLayout:Appearance = appearance13.
        THIS-OBJECT:columnChooser:DisplayLayout:AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle:ResizeAllColumns.
        THIS-OBJECT:columnChooser:DisplayLayout:CaptionVisible = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:columnChooser:DisplayLayout:MaxColScrollRegions = 1.
        THIS-OBJECT:columnChooser:DisplayLayout:MaxRowScrollRegions = 1.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving:NotAllowed.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:AllowColSizing = Infragistics.Win.UltraWinGrid.AllowColSizing:None.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:AllowRowLayoutCellSizing = Infragistics.Win.UltraWinGrid.RowLayoutSizing:None.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:AllowRowLayoutLabelSizing = Infragistics.Win.UltraWinGrid.RowLayoutSizing:None.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction:RowSelect.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:CellPadding = 2.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:ExpansionIndicator = Infragistics.Win.UltraWinGrid.ShowExpansionIndicator:Never.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction:Select.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:HeaderStyle = Infragistics.Win.HeaderStyle:WindowsXPCommand.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:RowSelectors = Infragistics.Win.DefaultableBoolean:False.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:RowSizing = Infragistics.Win.UltraWinGrid.RowSizing:AutoFixed.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:columnChooser:DisplayLayout:Override:SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType:None.
        THIS-OBJECT:columnChooser:DisplayLayout:RowConnectorStyle = Infragistics.Win.UltraWinGrid.RowConnectorStyle:None.
        THIS-OBJECT:columnChooser:DisplayLayout:ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds:ScrollToFill.
        THIS-OBJECT:columnChooser:DisplayLayout:ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle:Immediate.
        THIS-OBJECT:columnChooser:Location = NEW System.Drawing.Point(389, 266).
        THIS-OBJECT:columnChooser:Name = "columnChooser".
        THIS-OBJECT:columnChooser:Size = NEW System.Drawing.Size(221, 307).
        THIS-OBJECT:columnChooser:SourceGrid = THIS-OBJECT:grReporte.
        THIS-OBJECT:columnChooser:StyleLibraryName = "".
        THIS-OBJECT:columnChooser:StyleSetName = "".
        THIS-OBJECT:columnChooser:TabIndex = 3.
        THIS-OBJECT:columnChooser:Text = "ultraGridColumnChooser1".
        THIS-OBJECT:columnChooser:Visible = FALSE.
        /*  */
        /* pnTop */
        /*  */
        THIS-OBJECT:pnTop:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnTop:Dock = System.Windows.Forms.DockStyle:Top.
        THIS-OBJECT:pnTop:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnTop:Name = "pnTop".
        THIS-OBJECT:pnTop:Size = NEW System.Drawing.Size(695, 44).
        THIS-OBJECT:pnTop:TabIndex = 5.
        /*  */
        /* docExporter */
        /*  */
        THIS-OBJECT:docExporter:AutoSize = Infragistics.Win.UltraWinGrid.DocumentExport.AutoSize:None.
        /*  */
        /* popupControl */
        /*  */
        THIS-OBJECT:popupControl:PopupControl = THIS-OBJECT:columnChooser.
        /*  */
        /* Viewer */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(695, 658).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnTop).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnGrid).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnBotones).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:SizableToolWindow.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "Viewer".
        THIS-OBJECT:ShowInTaskbar = FALSE.
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterParent.
        THIS-OBJECT:Text = "Visor de Reporte".
        THIS-OBJECT:Shown:Subscribe(THIS-OBJECT:Viewer_Shown).
        CAST(THIS-OBJECT:bsReporte, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:grReporte, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:pnBotones:ResumeLayout(FALSE).
        THIS-OBJECT:pnGrid:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:columnChooser, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD. 
 
	METHOD PUBLIC VOID ShowModalDialog(  ):	
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID Viewer_Shown( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
	    DEFINE VARIABLE cWhere   AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iBuffers AS INT64     NO-UNDO.
        DEFINE VARIABLE iBuffer  AS INT64     NO-UNDO.

		IF DatasetHandle NE ? THEN DO:
		    ASSIGN iBuffers = THIS-OBJECT:DatasetHandle:NUM-BUFFERS.

		    CREATE QUERY hq.
		    REPEAT iBuffer = 1 TO iBuffers:
		        ASSIGN cWhere = cWhere + " PRESELECT EACH " + THIS-OBJECT:DatasetHandle:GET-BUFFER-HANDLE(iBuffer):NAME + " NO-LOCK ,".
                hq:ADD-BUFFER(THIS-OBJECT:DatasetHandle:GET-BUFFER-HANDLE(iBuffer)).
		    END.

		    ASSIGN cWhere = TRIM(cWhere, ",":U).
            hq:QUERY-PREPARE(cWhere).
            hq:QUERY-OPEN().

            bsReporte:HANDLE = hq.
            
            FOR EACH ttCampo WHERE ttCampo.Tipo = "HIDDEN":U:
                grReporte:DisplayLayout:Bands[ttCampo.BufferNombre]:Columns[ttCampo.Campo]:hidden = TRUE NO-ERROR.
            END.
		END.
	END METHOD.
END CLASS.
