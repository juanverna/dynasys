 
 /*------------------------------------------------------------------------
    File        : ParametroWhereControl
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Wed Apr 15 19:30:01 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.UserControl.
USING Progress.Util.StringHelper.
USING mfvsys.Reporte.ui.IWhereParent.

CLASS mfvsys.Reporte.ui.ParametroWhereControl INHERITS UserControl: 
    DEFINE PRIVATE VARIABLE btAgregar AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE btBorrar AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE coAndOr AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE coCampos AS System.Windows.Forms.ComboBox NO-UNDO.
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE coOperador AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE popupParametros AS Infragistics.Win.Misc.UltraPopupControlContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE grParamPredef AS System.Windows.Forms.GroupBox NO-UNDO.
    DEFINE PRIVATE VARIABLE coPredef AS System.Windows.Forms.ComboBox NO-UNDO.
    DEFINE PRIVATE VARIABLE toolTip1 AS System.Windows.Forms.ToolTip NO-UNDO.
    DEFINE PRIVATE VARIABLE txParIzquierda AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE txParDerecho AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
    DEFINE PRIVATE VARIABLE txValor AS Infragistics.Win.UltraWinEditors.UltraTextEditor NO-UNDO.
 
    DEFINE PRIVATE VARIABLE WherePadre AS IWhereParent NO-UNDO.
    DEFINE PUBLIC PROPERTY Orden AS INT64 NO-UNDO GET.
    SET(INPUT nuevo AS INT64):
        Orden = nuevo.
        IF nuevo = 10 THEN
            ASSIGN btBorrar:ENABLED = FALSE.
    END SET.

    DEFINE PUBLIC PROPERTY ParentesisIzquierdo AS CHARACTER NO-UNDO
    GET:
        RETURN txParIzquierda:TEXT.
    END GET.

    DEFINE PUBLIC PROPERTY ParentesisDerecho AS CHARACTER NO-UNDO
    GET:
        RETURN txParDerecho:TEXT.
    END GET.

    DEFINE PUBLIC PROPERTY NombreCampo AS CHARACTER NO-UNDO
    GET:
        RETURN CAST(coCampos:SelectedItem, mfvsys.Common.BasicKeyNameElement):elementName.
    END GET.

    DEFINE PUBLIC PROPERTY Operador AS CHARACTER NO-UNDO
    GET:
        RETURN coOperador:SelectedItem:ToString().
    END GET.

    DEFINE PUBLIC PROPERTY Valor AS CHARACTER NO-UNDO
    GET:
        RETURN txValor:TEXT.
    END GET.

    DEFINE PUBLIC PROPERTY Condicion AS CHARACTER NO-UNDO
    GET:
        RETURN coAndOr:SelectedItem:ToString().
    END GET.

	CONSTRUCTOR PUBLIC ParametroWhereControl(INPUT padre AS IWhereParent):
        SUPER().
        ASSIGN THIS-OBJECT:WherePadre = padre.
        InitializeComponent().
        btAgregar:ENABLED = FALSE.
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END CONSTRUCTOR.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID btAgregar_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		WherePadre:AgregarParametro().
		btAgregar:ENABLED = FALSE.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID coAndOr_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        ASSIGN btAgregar:ENABLED = NOT Progress.Util.StringHelper:Equals(coAndOr:SelectedItem:ToString(), "":U).		
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID coPredef_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
        IF coPredef:SelectedIndex NE -1 THEN DO:
            IF Progress.Util.StringHelper:Equals(coPredef:SelectedItem:ToString(), "<Manual>":U) THEN DO:
                ASSIGN txValor:ReadOnly = FALSE.
            END.
            ELSE IF Progress.Util.StringHelper:Equals(coPredef:SelectedItem:ToString(), "<Runtime>":U) THEN DO:
                ASSIGN txValor:ReadOnly = TRUE
                       txValor:TEXT     = "<Runtime>":U.
            END.
            ELSE DO:
                ASSIGN txValor:ReadOnly = TRUE
                       txValor:TEXT     = "%":U + coPredef:SelectedItem:ToString().
            END.
        END.
        popupParametros:Close().
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	METHOD PUBLIC VOID HabilitaAgregar():
	    btAgregar:ENABLED = TRUE.
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CargarCampos(INPUT campos AS System.Object EXTENT):
        coCampos:Items:AddRange(campos).
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CargarParametros(INPUT params AS System.Object EXTENT):
        coPredef:Items:Add("<Manual>").
        coPredef:Items:Add("<Runtime>").
        coPredef:Items:AddRange(params).
    END METHOD.

	METHOD PRIVATE VOID InitializeComponent():
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:components = NEW System.ComponentModel.Container().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE editorButton1 AS Infragistics.Win.UltraWinEditors.EditorButton NO-UNDO.
        editorButton1 = NEW Infragistics.Win.UltraWinEditors.EditorButton("borra").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE editorButton2 AS Infragistics.Win.UltraWinEditors.EditorButton NO-UNDO.
        editorButton2 = NEW Infragistics.Win.UltraWinEditors.EditorButton("agrega").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance1 AS Infragistics.Win.Appearance NO-UNDO.
        appearance1 = NEW Infragistics.Win.Appearance().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE editorButton3 AS Infragistics.Win.UltraWinEditors.EditorButton NO-UNDO.
        editorButton3 = NEW Infragistics.Win.UltraWinEditors.EditorButton("agrega").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE editorButton4 AS Infragistics.Win.UltraWinEditors.EditorButton NO-UNDO.
        editorButton4 = NEW Infragistics.Win.UltraWinEditors.EditorButton("borra").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE resources AS Progress.Util.ResourceManager NO-UNDO.
        resources = NEW Progress.Util.ResourceManager("mfvsys.Reporte.ui.ParametroWhereControl").
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE editorButton5 AS Infragistics.Win.UltraWinEditors.EditorButton NO-UNDO.
        editorButton5 = NEW Infragistics.Win.UltraWinEditors.EditorButton().
        @VisualDesigner.FormMember (NeedsInitialize="true").
        DEFINE VARIABLE appearance2 AS Infragistics.Win.Appearance NO-UNDO.
        appearance2 = NEW Infragistics.Win.Appearance().
        THIS-OBJECT:txParDerecho = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:txParIzquierda = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:btBorrar = NEW System.Windows.Forms.Button().
        THIS-OBJECT:coAndOr = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:btAgregar = NEW System.Windows.Forms.Button().
        THIS-OBJECT:toolTip1 = NEW System.Windows.Forms.ToolTip(THIS-OBJECT:components).
        THIS-OBJECT:txValor = NEW Infragistics.Win.UltraWinEditors.UltraTextEditor().
        THIS-OBJECT:coCampos = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:coOperador = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:grParamPredef = NEW System.Windows.Forms.GroupBox().
        THIS-OBJECT:coPredef = NEW System.Windows.Forms.ComboBox().
        THIS-OBJECT:popupParametros = NEW Infragistics.Win.Misc.UltraPopupControlContainer(THIS-OBJECT:components).
        CAST(THIS-OBJECT:txParDerecho, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txParIzquierda, System.ComponentModel.ISupportInitialize):BeginInit().
        CAST(THIS-OBJECT:txValor, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:grParamPredef:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* txParDerecho */
        /*  */
        editorButton1:Key = "borra".
        editorButton1:Text = "-".
        editorButton2:Key = "agrega".
        editorButton2:Text = "+".
        THIS-OBJECT:txParDerecho:ButtonsRight:Add(editorButton1).
        THIS-OBJECT:txParDerecho:ButtonsRight:Add(editorButton2).
        THIS-OBJECT:txParDerecho:Location = NEW System.Drawing.Point(372, 3).
        THIS-OBJECT:txParDerecho:Name = "txParDerecho".
        THIS-OBJECT:txParDerecho:ReadOnly = TRUE.
        THIS-OBJECT:txParDerecho:Size = NEW System.Drawing.Size(60, 21).
        THIS-OBJECT:txParDerecho:TabIndex = 3.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:txParDerecho, "Parentesis a la Derecha").
        THIS-OBJECT:txParDerecho:EditorButtonClick:Subscribe(THIS-OBJECT:txParDerecho_EditorButtonClick).
        /*  */
        /* txParIzquierda */
        /*  */
        appearance1:TextHAlignAsString = "Right".
        THIS-OBJECT:txParIzquierda:Appearance = appearance1.
        editorButton3:Key = "agrega".
        editorButton3:Text = "+".
        editorButton4:Key = "borra".
        editorButton4:Text = "-".
        THIS-OBJECT:txParIzquierda:ButtonsLeft:Add(editorButton3).
        THIS-OBJECT:txParIzquierda:ButtonsLeft:Add(editorButton4).
        THIS-OBJECT:txParIzquierda:Location = NEW System.Drawing.Point(3, 3).
        THIS-OBJECT:txParIzquierda:Name = "txParIzquierda".
        THIS-OBJECT:txParIzquierda:ReadOnly = TRUE.
        THIS-OBJECT:txParIzquierda:RightToLeft = System.Windows.Forms.RightToLeft:No.
        THIS-OBJECT:txParIzquierda:Size = NEW System.Drawing.Size(60, 21).
        THIS-OBJECT:txParIzquierda:TabIndex = 4.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:txParIzquierda, "Parentesis a la Izquierda").
        THIS-OBJECT:txParIzquierda:EditorButtonClick:Subscribe(THIS-OBJECT:txParIzquierda_EditorButtonClick).
        /*  */
        /* btBorrar */
        /*  */
        THIS-OBJECT:btBorrar:FlatStyle = System.Windows.Forms.FlatStyle:Flat.
        THIS-OBJECT:btBorrar:Image = CAST(resources:GetObject("btBorrar.Image"), System.Drawing.Image).
        THIS-OBJECT:btBorrar:Location = NEW System.Drawing.Point(509, 1).
        THIS-OBJECT:btBorrar:Name = "btBorrar".
        THIS-OBJECT:btBorrar:Size = NEW System.Drawing.Size(20, 25).
        THIS-OBJECT:btBorrar:TabIndex = 7.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:btBorrar, "Borra la Condicion actual").
        THIS-OBJECT:btBorrar:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btBorrar:UseVisualStyleBackColor = TRUE.
        /*  */
        /* coAndOr */
        /*  */
        THIS-OBJECT:coAndOr:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:coAndOr:FormattingEnabled = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar0 AS System.Object EXTENT 3 NO-UNDO.
        arrayvar0[1] = "".
        arrayvar0[2] = "AND".
        arrayvar0[3] = "OR".
        THIS-OBJECT:coAndOr:Items:AddRange(arrayvar0).
        THIS-OBJECT:coAndOr:Location = NEW System.Drawing.Point(436, 3).
        THIS-OBJECT:coAndOr:Name = "coAndOr".
        THIS-OBJECT:coAndOr:Size = NEW System.Drawing.Size(56, 21).
        THIS-OBJECT:coAndOr:TabIndex = 8.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:coAndOr, "Selecciona condicion AND/OR").
        THIS-OBJECT:coAndOr:SelectedIndexChanged:Subscribe(THIS-OBJECT:coAndOr_SelectedIndexChanged).
        /*  */
        /* btAgregar */
        /*  */
        THIS-OBJECT:btAgregar:FlatStyle = System.Windows.Forms.FlatStyle:Flat.
        THIS-OBJECT:btAgregar:Image = CAST(resources:GetObject("btAgregar.Image"), System.Drawing.Image).
        THIS-OBJECT:btAgregar:Location = NEW System.Drawing.Point(494, 1).
        THIS-OBJECT:btAgregar:Name = "btAgregar".
        THIS-OBJECT:btAgregar:Size = NEW System.Drawing.Size(17, 25).
        THIS-OBJECT:btAgregar:TabIndex = 9.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:btAgregar, "Agrega Condicion").
        THIS-OBJECT:btAgregar:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:btAgregar:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:btAgregar:Click:Subscribe(THIS-OBJECT:btAgregar_Click).
        /*  */
        /* txValor */
        /*  */
        appearance2:Image = CAST(resources:GetObject("appearance2.Image"), System.Object).
        editorButton5:Appearance = appearance2.
        THIS-OBJECT:txValor:ButtonsRight:Add(editorButton5).
        THIS-OBJECT:txValor:Location = NEW System.Drawing.Point(254, 2).
        THIS-OBJECT:txValor:Name = "txValor".
        THIS-OBJECT:txValor:Size = NEW System.Drawing.Size(112, 21).
        THIS-OBJECT:txValor:TabIndex = 12.
        THIS-OBJECT:toolTip1:SetToolTip(THIS-OBJECT:txValor, "Campos Predefinidos").
        THIS-OBJECT:txValor:EditorButtonClick:Subscribe(THIS-OBJECT:txValor_EditorButtonClick).
        /*  */
        /* coCampos */
        /*  */
        THIS-OBJECT:coCampos:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:coCampos:FormattingEnabled = TRUE.
        THIS-OBJECT:coCampos:Location = NEW System.Drawing.Point(69, 3).
        THIS-OBJECT:coCampos:Name = "coCampos".
        THIS-OBJECT:coCampos:Size = NEW System.Drawing.Size(121, 21).
        THIS-OBJECT:coCampos:Sorted = TRUE.
        THIS-OBJECT:coCampos:TabIndex = 10.
        /*  */
        /* coOperador */
        /*  */
        THIS-OBJECT:coOperador:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:coOperador:FormattingEnabled = TRUE.
        @VisualDesigner.FormMember (NeedsInitialize="false", InitializeArray="true").
        DEFINE VARIABLE arrayvar1 AS System.Object EXTENT 7 NO-UNDO.
        arrayvar1[1] = "=".
        arrayvar1[2] = "<>".
        arrayvar1[3] = "<".
        arrayvar1[4] = ">".
        arrayvar1[5] = "<=".
        arrayvar1[6] = ">=".
        arrayvar1[7] = "Begins".
        THIS-OBJECT:coOperador:Items:AddRange(arrayvar1).
        THIS-OBJECT:coOperador:Location = NEW System.Drawing.Point(196, 3).
        THIS-OBJECT:coOperador:Name = "coOperador".
        THIS-OBJECT:coOperador:Size = NEW System.Drawing.Size(52, 21).
        THIS-OBJECT:coOperador:TabIndex = 11.
        /*  */
        /* grParamPredef */
        /*  */
        THIS-OBJECT:grParamPredef:Controls:Add(THIS-OBJECT:coPredef).
        THIS-OBJECT:grParamPredef:Location = NEW System.Drawing.Point(196, 14).
        THIS-OBJECT:grParamPredef:Name = "grParamPredef".
        THIS-OBJECT:grParamPredef:Size = NEW System.Drawing.Size(170, 43).
        THIS-OBJECT:grParamPredef:TabIndex = 13.
        THIS-OBJECT:grParamPredef:TabStop = FALSE.
        THIS-OBJECT:grParamPredef:Text = "Parametros".
        THIS-OBJECT:grParamPredef:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:grParamPredef:Visible = FALSE.
        /*  */
        /* coPredef */
        /*  */
        THIS-OBJECT:coPredef:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList.
        THIS-OBJECT:coPredef:FormattingEnabled = TRUE.
        THIS-OBJECT:coPredef:Location = NEW System.Drawing.Point(6, 16).
        THIS-OBJECT:coPredef:Name = "coPredef".
        THIS-OBJECT:coPredef:Size = NEW System.Drawing.Size(158, 21).
        THIS-OBJECT:coPredef:TabIndex = 0.
        THIS-OBJECT:coPredef:SelectedIndexChanged:Subscribe(THIS-OBJECT:coPredef_SelectedIndexChanged).
        /*  */
        /* popupParametros */
        /*  */
        THIS-OBJECT:popupParametros:PopupControl = THIS-OBJECT:grParamPredef.
        /*  */
        /* ParametroWhereControl */
        /*  */
        THIS-OBJECT:AutoScaleDimensions = NEW System.Drawing.SizeF(Progress.Util.CastUtil:ToSingle(6), Progress.Util.CastUtil:ToSingle(13)).
        THIS-OBJECT:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:Controls:Add(THIS-OBJECT:grParamPredef).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txValor).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:coOperador).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:coCampos).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btAgregar).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:coAndOr).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:btBorrar).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txParIzquierda).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txParDerecho).
        THIS-OBJECT:Name = "ParametroWhereControl".
        THIS-OBJECT:Size = NEW System.Drawing.Size(530, 28).
        CAST(THIS-OBJECT:txParDerecho, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txParIzquierda, System.ComponentModel.ISupportInitialize):EndInit().
        CAST(THIS-OBJECT:txValor, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:grParamPredef:ResumeLayout(FALSE).
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID txParDerecho_EditorButtonClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinEditors.EditorButtonEventArgs ):
        IF e:BUTTON:Key = "agrega":U THEN
            ASSIGN txParDerecho:TEXT = txParDerecho:TEXT + ")":U.
        ELSE IF txParDerecho:TEXT NE "":U THEN
            ASSIGN SUBSTRING(txParDerecho:TEXT, 1, 1) = "":U. 
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID txParIzquierda_EditorButtonClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinEditors.EditorButtonEventArgs ):
		IF e:BUTTON:Key = "agrega":U THEN
		    ASSIGN txParIzquierda:TEXT = txParIzquierda:TEXT + "(":U.
		ELSE IF txParIzquierda:TEXT NE "":U THEN
		    ASSIGN SUBSTRING(txParIzquierda:TEXT, 1, 1) = "":U. 
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID txValor_EditorButtonClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinEditors.EditorButtonEventArgs ):
		popupParametros:Show().
	END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC FINAL CHARACTER GenerarString():
        DEFINE VARIABLE cCampo AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cValor AS CHARACTER NO-UNDO.

        ASSIGN cCampo = CAST(coCampos:SelectedItem, mfvsys.Common.BasicKeyNameElement):elementName.

        IF Progress.Util.StringHelper:Equals(coPredef:SelectedItem:ToString(), "<Manual>":U) THEN
            ASSIGN cValor = (IF CAST(coCampos:SelectedItem, mfvsys.Common.BasicKeyNameElement):elementKey BEGINS "CHAR":U THEN QUOTER(txValor:TEXT) ELSE txValor:TEXT).
        ELSE
            ASSIGN cValor = txValor:TEXT.

        RETURN txParIzquierda:TEXT + " " + cCampo + " " + coOperador:Text + " " + cValor + " " + txParDerecho:TEXT + coAndOr:SelectedItem:ToString().
    END METHOD.

	DESTRUCTOR PUBLIC ParametroWhereControl ( ):
	END DESTRUCTOR.
END CLASS.