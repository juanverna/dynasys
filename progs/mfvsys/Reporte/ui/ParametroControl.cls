 /*------------------------------------------------------------------------
    File        : ParametroControl
    Purpose     :
    Syntax      :
    Description :
    Author(s)   : Marcelo Ferrante
    Created     : Wed Feb 11 10:30:29 BRST 2015
    Notes       :
  ----------------------------------------------------------------------*/
USING Progress.Lang.*.
USING Progress.Util.EnumHelper.
USING Progress.Windows.UserControl.
USING Infragistics.Win.UltraWinEditors.UltraTextEditor.
USING System.Windows.Forms.Label.
USING System.Windows.Forms.ComboBox.
USING System.Windows.Forms.CheckBox.
USING System.Windows.Forms.DialogResult.
USING System.Windows.Forms.NumericUpDown.
USING System.Windows.Forms.DateTimePicker.
USING Infragistics.Win.UltraWinEditors.EditorButton.
USING mfvsys.Reporte.ui.BuscadorDialog.
USING mfvsys.Common.BasicKeyNameElement.

CLASS mfvsys.Reporte.ui.ParametroControl INHERITS UserControl FINAL:
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE pnPanel    AS System.Windows.Forms.Panel       NO-UNDO.

    DEFINE VARIABLE cTipo   AS CHARACTER       NO-UNDO.
    DEFINE VARIABLE lb      AS LABEL           NO-UNDO.
    DEFINE VARIABLE texto   AS UltraTextEditor NO-UNDO.
    DEFINE VARIABLE chBox   AS CheckBox        NO-UNDO.
    DEFINE VARIABLE Fecha   AS DateTimePicker  NO-UNDO.
    DEFINE VARIABLE Numero  AS NumericUpDown   NO-UNDO.
    DEFINE VARIABLE Boton   AS EditorButton    NO-UNDO.
    DEFINE VARIABLE combo   AS System.Windows.Forms.ComboBox        NO-UNDO.

    DEFINE PUBLIC PROPERTY Valor               AS CHARACTER NO-UNDO GET. PRIVATE SET.
    DEFINE PUBLIC PROPERTY Buscador            AS LOGICAL   NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY BuscadorTabla       AS CHARACTER NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY BuscadorCampoID     AS CHARACTER NO-UNDO GET. SET.
    DEFINE PUBLIC PROPERTY BuscadorCampoNombre AS CHARACTER NO-UNDO GET. SET.

	CONSTRUCTOR PUBLIC ParametroControl(INPUT hBuffer AS HANDLE):
	    DEFINE VARIABLE cComboItems AS CHARACTER           NO-UNDO.
	    DEFINE VARIABLE iItems      AS INT64               NO-UNDO.
	    DEFINE VARIABLE iItem       AS INT64               NO-UNDO.
	    DEFINE VARIABLE itemClass   AS BasicKeyNameElement NO-UNDO.

        SUPER().
        InitializeComponent().
        ASSIGN lb           = NEW LABEL()
               lb:TEXT      = hBuffer:BUFFER-FIELD ("EtiquetaParametro":U):BUFFER-VALUE() + ":":U
               lb:TextAlign = System.Drawing.ContentAlignment:MiddleRight
               lb:WIDTH     = INTEGER(THIS-OBJECT:Size:Width / 2)
               lb:Left      = 1.
        pnPanel:Controls:Add(lb).

        ASSIGN cTipo = STRING(hBuffer:BUFFER-FIELD ("DataType":U):BUFFER-VALUE()).

        /*Si es un combo-box creamos el combo y asignamos los items que esta
          en el campo ReporteParametro.ValoresCombo*/
        IF STRING(hBuffer:BUFFER-FIELD ("ViewAs":U):BUFFER-VALUE()) BEGINS "Combo":U THEN DO:
            ASSIGN combo               = NEW System.Windows.Forms.ComboBox()
                   combo:Name          = STRING("Texto")
                   combo:VISIBLE       = TRUE
                   combo:LEFT          = lb:WIDTH + 1
                   combo:WIDTH         = THIS-OBJECT:ClientSize:Width - combo:LEFT
                   combo:DropDownStyle = System.Windows.Forms.ComboBoxStyle:DropDownList
                   cComboItems         = STRING(hBuffer:BUFFER-FIELD ("ValoresCombo":U):BUFFER-VALUE())
                   iItems              = NUM-ENTRIES(cComboItems, CHR(1)).

            combo:SelectedIndexChanged:Subscribe(THIS-OBJECT:combo_SelectedIndexChanged).
            REPEAT iItem = 1 TO iItems BY 2:
                itemClass = NEW BasickeyNameElement(ENTRY(iItem, cComboItems, CHR(1)), ENTRY(iItem + 1, cComboItems, CHR(1))).
                combo:Items:Add(itemClass).
            END.
            pnPanel:Controls:Add(combo).
        END.
        ELSE DO :
        CASE cTipo.
            WHEN "CHAR":U OR WHEN "CHARACTER":U THEN DO:
                ASSIGN texto         = NEW UltraTextEditor()
                       texto:Name    = STRING("Texto")
                       texto:VISIBLE = TRUE
                       texto:LEFT    = lb:WIDTH + 1
                       texto:WIDTH   = THIS-OBJECT:ClientSize:Width - texto:Left.

                IF hBuffer:BUFFER-FIELD ("Buscador":U):BUFFER-VALUE() = TRUE THEN DO:
                    ASSIGN boton          = NEW EditorButton()
                           boton:TEXT     = "...":U
                           texto:ReadOnly = TRUE.
                    texto:ButtonsRight:Add(boton).
                    texto:EditorButtonClick:Subscribe(THIS-OBJECT:buscador_EditorButtonClick).
                END.
                ELSE DO:
                    ASSIGN texto:ReadOnly = FALSE.
                    texto:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                END.
                pnPanel:Controls:Add(texto).
            END.
            WHEN "INT":U OR WHEN "INTEGER":U OR WHEN "INT64":U THEN DO:
                ASSIGN numero         = NEW NumericUpDown()
                       numero:Name    = STRING("numero")
                       numero:VISIBLE = TRUE
                       numero:LEFT    = lb:WIDTH + 1.
                numero:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(numero).
            END.
            WHEN "DECIMAL":U THEN DO:
                ASSIGN numero               = NEW NumericUpDown()
                       numero:Name          = STRING("numero")
                       numero:VISIBLE       = TRUE
                       numero:LEFT          = lb:WIDTH + 1
                       numero:DecimalPlaces = LENGTH(SUBSTRING(hBuffer:BUFFER-FIELD ("Formato":U):BUFFER-VALUE(), INDEX(hBuffer:BUFFER-FIELD ("Formato":U):BUFFER-VALUE(), ".") + 1)).
                numero:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(numero).
            END.
            WHEN "DATE":U THEN DO:
                ASSIGN fecha         = NEW DateTimePicker()
                       fecha:Name    = STRING("fecha")
                       fecha:VISIBLE = TRUE
                       fecha:LEFT    = lb:WIDTH + 1
                       fecha:FORMAT  = System.Windows.Forms.DateTimePickerFormat:Short.
                fecha:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(fecha).
            END.
            WHEN "DATETIME":U OR WHEN "DATETIME-TZ":U THEN DO:
                ASSIGN fecha              = NEW DateTimePicker()
                       fecha:Name         = STRING("fecha")
                       fecha:VISIBLE      = TRUE
                       fecha:LEFT         = lb:WIDTH + 1
                       fecha:FORMAT       = System.Windows.Forms.DateTimePickerFormat:Custom
                       fecha:CustomFormat = "dd/MM/yyyy hh:mm":U.
                fecha:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(fecha).

            END.
            WHEN "TIME":U THEN DO:
                ASSIGN fecha         = NEW DateTimePicker()
                       fecha:Name    = STRING("fecha")
                       fecha:VISIBLE = TRUE
                       fecha:LEFT    = lb:WIDTH + 1
                       fecha:FORMAT  = System.Windows.Forms.DateTimePickerFormat:Time.
                fecha:ValueChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(fecha).
            END.
            WHEN "LOGICAL":U THEN DO:
                ASSIGN chBox              = NEW CheckBox()
                       chBox:Name         = STRING("chbox")
                       chBox:VISIBLE      = TRUE
                       chBox:LEFT         = lb:WIDTH + 1.
                chBox:CheckedChanged:Subscribe(THIS-OBJECT:parametro_ValueChanged).
                pnPanel:Controls:Add(chBox).
            END.
        END CASE.
        END.
        THIS-OBJECT:ComponentsCollection:ADD(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END CONSTRUCTOR.


	METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:pnPanel = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* pnPanel */
        /*  */
        THIS-OBJECT:pnPanel:Dock = System.Windows.Forms.DockStyle:Fill.
        THIS-OBJECT:pnPanel:Location = NEW System.Drawing.Point(0, 0).
        THIS-OBJECT:pnPanel:Name = "pnPanel".
        THIS-OBJECT:pnPanel:Size = NEW System.Drawing.Size(314, 25).
        THIS-OBJECT:pnPanel:TabIndex = 0.
        /*  */
        /* ParametroControl */
        /*  */
        THIS-OBJECT:AutoScaleDimensions = NEW System.Drawing.SizeF(Progress.Util.CastUtil:ToSingle(6), Progress.Util.CastUtil:ToSingle(13)).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnPanel).
        THIS-OBJECT:Name = "ParametroControl".
        THIS-OBJECT:Size = NEW System.Drawing.Size(314, 25).
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
	METHOD PRIVATE VOID combo_SelectedIndexChanged( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		ASSIGN THIS-OBJECT:Valor = CAST(combo:SelectedItem, mfvsys.Common.BasicKeyNameElement):elementKey.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID parametro_ValueChanged(INPUT sender AS System.Object, INPUT e AS System.EventArgs):
		CASE cTipo:
            WHEN "CHAR":U OR WHEN "CHARACTER":U THEN
                ASSIGN Valor = texto:TEXT. 
            WHEN "INT":U OR WHEN "INTEGER":U OR WHEN "INT64":U OR WHEN "DECIMAL":U THEN 
                ASSIGN Valor = STRING(numero:VALUE).
            WHEN "DATE":U THEN
                ASSIGN Valor = STRING(fecha:Value, "99/99/99":U).
            WHEN "DATETIME":U OR WHEN "DATETIME-TZ":U THEN
                ASSIGN Valor = STRING(fecha:value).
            WHEN "TIME":U THEN
                ASSIGN Valor = STRING(MTIME(fecha:VALUE) / 1000, "HH:MM":U).
            WHEN "LOGICAL":U THEN
                ASSIGN Valor = STRING(chBox:CHECKED).
        END CASE.
	END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	@VisualDesigner.
	METHOD PRIVATE VOID buscador_EditorButtonClick( INPUT sender AS System.Object, INPUT e AS Infragistics.Win.UltraWinEditors.EditorButtonEventArgs ):
		DEFINE VARIABLE buscadorClass  AS BuscadorDialog NO-UNDO.
		DEFINE VARIABLE enDialogResult AS DialogResult   NO-UNDO.

		ASSIGN buscadorClass = NEW BuscadorDialog(INPUT THIS-OBJECT:BuscadorTabla, INPUT THIS-OBJECT:BuscadorCampoID, INPUT THIS-OBJECT:BuscadorCampoNombre).
		WAIT-FOR buscadorClass:ShowDialog() SET enDialogResult.
		IF EnumHelper:AreEqual (INPUT enDialogResult, INPUT DialogResult:OK) THEN DO:
		    ASSIGN THIS-OBJECT:Valor = buscadorClass:Codigo
		           texto:TEXT        = buscadorClass:Nombre.
		END.
	END METHOD.

	DESTRUCTOR PUBLIC ParametroControl ( ):

	END DESTRUCTOR.
END CLASS.