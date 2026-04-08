 /*------------------------------------------------------------------------
    File        : SeleccionDireccionDialog
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Fri Mar 20 20:15:40 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Progress.Windows.Form.
USING mfvsys.Common.BasicKeyNameElement.

CLASS mfvsys.Geoloc.Forms.SeleccionDireccionDialog INHERITS Form   : 

	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE lsDirecciones AS System.Windows.Forms.ListBox NO-UNDO.
    DEFINE PRIVATE VARIABLE panel1 AS System.Windows.Forms.Panel NO-UNDO.
/*    DEFINE PRIVATE VARIABLE prg AS Infragistics.Win.UltraWinProgressBar.UltraProgressBar NO-UNDO. */
    DEFINE PRIVATE VARIABLE webBrowser AS System.Windows.Forms.WebBrowser NO-UNDO.
    DEFINE PRIVATE VARIABLE splitContainer1 AS System.Windows.Forms.SplitContainer NO-UNDO.

    DEFINE PUBLIC PROPERTY Seleccion AS INT64 NO-UNDO GET. SET.
    {inc/ttlocations.i}

	CONSTRUCTOR PUBLIC SeleccionDireccionDialog(INPUT TABLE ttLocations):
		SUPER().
		InitializeComponent().
		FOR EACH ttLocations NO-LOCK BY ttLocations.Orden:
            THIS-OBJECT:lsDirecciones:items:Add(NEW mfvsys.Common.BasicKeyNameElement(STRING(ttLocations.Orden), STRING(ttLocations.Orden + 1) + " - " + ttLocations.Descripcion /*ttLocations.Calle + " " + ttLocations.Numero + " " + ttLocations.Partido + " " + ttLocations.Provincia*/)).
        END.
                DEFINE VARIABLE curl AS System.URI NO-UNDO.
        DEFINE VARIABLE cArchivo AS CHARACTER NO-UNDO.

        /*prg:VISIBLE = TRUE.
        prg:MINIMUM = -5.
        prg:VALUE = 1.*/
        ASSIGN cArchivo = SESSION:TEMP-DIRECTORY + "listado.html".
        RUN mfvsys/Geoloc/Html/genlistado.p (INPUT cArchivo, INPUT TABLE ttLocations BY-REFERENCE).
        ASSIGN FILE-INFO:FILE-NAME = cArchivo
               curl                = NEW System.URI("file://" + FILE-INFO:FULL-PATHNAME).
               /*prg:MAXIMUM = 100.
               prg:BringToFront().*/
               webBrowser:url = curl.
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC SeleccionDireccionDialog():
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.	

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID lsDirecciones_MouseDoubleClick( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.MouseEventArgs ):
		IF lsDirecciones:SelectedIndex NE -1 THEN DO:
		    seleccionar().
		    THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Ok.
            THIS-OBJECT:Close().
        END.
	END METHOD.

    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
        seleccionar().
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Ok.
		THIS-OBJECT:Close(). 
	END METHOD.

	METHOD PRIVATE VOID cancelButton_Click (sender AS System.Object, e AS System.EventArgs):
		THIS-OBJECT:DialogResult = System.Windows.Forms.DialogResult:Cancel.
		THIS-OBJECT:Close().
	END METHOD.

	METHOD PRIVATE VOID InitializeComponent():

		/* NOTE: The following method is automatically generated.
		   
		   We strongly suggest that the contents of this method only be modified using the 
		   Visual Designer to avoid any incompatible modifications.
		   
		   Modifying the contents of this method using a code editor will invalidate any support for this file. */
		
        THIS-OBJECT:buttonOk = NEW System.Windows.Forms.Button().
        THIS-OBJECT:buttonCancel = NEW System.Windows.Forms.Button().
        THIS-OBJECT:panel1 = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:splitContainer1 = NEW System.Windows.Forms.SplitContainer().
        THIS-OBJECT:lsDirecciones = NEW System.Windows.Forms.ListBox().
        /*THIS-OBJECT:prg = NEW Infragistics.Win.UltraWinProgressBar.UltraProgressBar().*/
        THIS-OBJECT:webBrowser = NEW System.Windows.Forms.WebBrowser().
        THIS-OBJECT:panel1:SuspendLayout().
        CAST(THIS-OBJECT:splitContainer1, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:splitContainer1:Panel1:SuspendLayout().
        THIS-OBJECT:splitContainer1:Panel2:SuspendLayout().
        THIS-OBJECT:splitContainer1:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(684, 3).
        THIS-OBJECT:buttonOk:Name = "buttonOk".
        THIS-OBJECT:buttonOk:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonOk:TabIndex = 0.
        THIS-OBJECT:buttonOk:Text = "Seleccionar".
        THIS-OBJECT:buttonOk:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonOk:Click:Subscribe(THIS-OBJECT:okButton_Click).
        /*  */
        /* buttonCancel */
        /*  */
        DEFINE VARIABLE nestedvar1 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar1 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonCancel:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar1, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonCancel:DialogResult = System.Windows.Forms.DialogResult:Cancel.
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(768, 3).
        THIS-OBJECT:buttonCancel:Name = "buttonCancel".
        THIS-OBJECT:buttonCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonCancel:TabIndex = 1.
        THIS-OBJECT:buttonCancel:Text = "Cancelar".
        THIS-OBJECT:buttonCancel:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:buttonCancel:Click:Subscribe(THIS-OBJECT:cancelButton_Click).
        /*  */
        /* panel1 */
        /*  */
        THIS-OBJECT:panel1:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:panel1:Controls:Add(THIS-OBJECT:buttonCancel).
        THIS-OBJECT:panel1:Controls:Add(THIS-OBJECT:buttonOk).
        THIS-OBJECT:panel1:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:panel1:Location = NEW System.Drawing.Point(0, 568).
        THIS-OBJECT:panel1:Name = "panel1".
        THIS-OBJECT:panel1:Size = NEW System.Drawing.Size(848, 32).
        THIS-OBJECT:panel1:TabIndex = 2.
        /*  */
        /* splitContainer1 */
        /*  */
        THIS-OBJECT:splitContainer1:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:splitContainer1:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:splitContainer1:Name = "splitContainer1".
        /*  */
        /* splitContainer1.Panel1 */
        /*  */
        THIS-OBJECT:splitContainer1:Panel1:Controls:Add(THIS-OBJECT:lsDirecciones).
        /*  */
        /* splitContainer1.Panel2 */
        /*  */
        /*THIS-OBJECT:splitContainer1:Panel2:Controls:Add(THIS-OBJECT:prg).*/
        THIS-OBJECT:splitContainer1:Panel2:Controls:Add(THIS-OBJECT:webBrowser).
        THIS-OBJECT:splitContainer1:Size = NEW System.Drawing.Size(848, 568).
        THIS-OBJECT:splitContainer1:SplitterDistance = 282.
        THIS-OBJECT:splitContainer1:TabIndex = 3.
        /*  */
        /* lsDirecciones */
        /*  */
        THIS-OBJECT:lsDirecciones:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:lsDirecciones:FormattingEnabled = TRUE.
        THIS-OBJECT:lsDirecciones:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:lsDirecciones:Name = "lsDirecciones".
        THIS-OBJECT:lsDirecciones:Size = NEW System.Drawing.Size(282, 568).
        THIS-OBJECT:lsDirecciones:TabIndex = 0.
        THIS-OBJECT:lsDirecciones:MouseDoubleClick:Subscribe(THIS-OBJECT:lsDirecciones_MouseDoubleClick).
        /*  */
        /* prg */
        /*  */
        /*THIS-OBJECT:prg:Location = NEW System.Drawing.Point(144, 245).
        THIS-OBJECT:prg:Name = "prg".
        THIS-OBJECT:prg:Size = NEW System.Drawing.Size(262, 23).
        THIS-OBJECT:prg:TabIndex = 1.
        THIS-OBJECT:prg:Text = "[Formatted]".*/
        /*  */
        /* webBrowser */
        /*  */
        THIS-OBJECT:webBrowser:AllowWebBrowserDrop = FALSE.
        THIS-OBJECT:webBrowser:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:webBrowser:IsWebBrowserContextMenuEnabled = FALSE.
        THIS-OBJECT:webBrowser:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:webBrowser:MinimumSize = NEW System.Drawing.Size(20, 20).
        THIS-OBJECT:webBrowser:Name = "webBrowser".
        THIS-OBJECT:webBrowser:ScriptErrorsSuppressed = TRUE.
        THIS-OBJECT:webBrowser:Size = NEW System.Drawing.Size(562, 568).
        THIS-OBJECT:webBrowser:TabIndex = 0.
        THIS-OBJECT:webBrowser:Url = NEW System.Uri("", System.UriKind:Relative).
        THIS-OBJECT:webBrowser:DocumentCompleted:Subscribe(THIS-OBJECT:webBrowser_DocumentCompleted).
        THIS-OBJECT:webBrowser:ProgressChanged:Subscribe(THIS-OBJECT:webBrowser_ProgressChanged).
        /*  */
        /* SeleccionDireccionDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(848, 600).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:splitContainer1).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:panel1).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:SizableToolWindow.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "SeleccionDireccionDialog".
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterScreen.
        THIS-OBJECT:Text = "Seleccion de Direcciones".
        THIS-OBJECT:panel1:ResumeLayout(FALSE).
        THIS-OBJECT:splitContainer1:Panel1:ResumeLayout(FALSE).
        THIS-OBJECT:splitContainer1:Panel2:ResumeLayout(FALSE).
        CAST(THIS-OBJECT:splitContainer1, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:splitContainer1:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD. 

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID seleccionar():
		ASSIGN Seleccion = INT64(CAST(lsDirecciones:SelectedItem, BasicKeyNameElement):elementKey).
	END METHOD.

	METHOD PUBLIC VOID ShowModalDialog(  ):
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
    METHOD PRIVATE VOID webBrowser_DocumentCompleted( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.WebBrowserDocumentCompletedEventArgs ):
        /*prg:VISIBLE = FALSE. */
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID webBrowser_ProgressChanged( INPUT sender AS System.Object, INPUT e AS System.Windows.Forms.WebBrowserProgressChangedEventArgs ):
        IF e:CurrentProgress NE -1 THEN DO:
	        /*prg:VALUE = e:CurrentProgress / 100.
	        prg:Invalidate().
	        prg:Refresh().*/
	    END.
	END METHOD.
END CLASS.
