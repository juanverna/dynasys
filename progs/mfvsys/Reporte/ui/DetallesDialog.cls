 /*------------------------------------------------------------------------
    File        : DetallesDialog
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Mon Apr 13 11:05:13 BRT 2015
    Notes       : 
  ----------------------------------------------------------------------*/
USING Progress.Windows.Form.

CLASS mfvsys.Reporte.ui.DetallesDialog INHERITS Form   : 
	DEFINE PRIVATE VARIABLE components AS System.ComponentModel.IContainer NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonOk AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE buttonCancel AS System.Windows.Forms.Button NO-UNDO.
    DEFINE PRIVATE VARIABLE lbComentarios AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCodigo AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCreadoFecha AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbCreado AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE lbNombre AS System.Windows.Forms.Label NO-UNDO.
    DEFINE PRIVATE VARIABLE pnBotones AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE txCodigo AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txComentario AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txFechaCreado AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE txCreadopor AS System.Windows.Forms.TextBox NO-UNDO.
    DEFINE PRIVATE VARIABLE pnCreacion AS System.Windows.Forms.Panel NO-UNDO.
    DEFINE PRIVATE VARIABLE txNombre AS System.Windows.Forms.TextBox NO-UNDO.

    DEFINE PUBLIC PROPERTY Modificado AS LOGICAL NO-UNDO
    GET:
        RETURN txNombre:MODIFIED OR txComentario:MODIFIED.
    END GET. PRIVATE SET.

    DEFINE PUBLIC PROPERTY Nombre AS CHARACTER NO-UNDO
    GET:
        RETURN txNombre:TEXT.
    END GET.
    SET(INPUT nuevo AS CHARACTER):
        ASSIGN txNombre:TEXT = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Comentarios AS CHARACTER NO-UNDO
    GET:
        RETURN txComentario:TEXT.
    END GET.
    SET(INPUT nuevo AS CHARACTER):
        ASSIGN txComentario:TEXT = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Codigo AS CHARACTER NO-UNDO GET.
    SET(INPUT nuevo AS CHARACTER):
        IF INT64(nuevo) < 1 THEN
            ASSIGN txCodigo:TEXT = "<Nuevo>":U.
        ELSE
            ASSIGN txCodigo:TEXT = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Usuario AS CHARACTER NO-UNDO GET.
    SET (INPUT nuevo AS CHARACTER):
        ASSIGN txCreadopor:TEXT = nuevo.
    END.

    DEFINE PUBLIC PROPERTY Fecha AS DATETIME NO-UNDO GET.
    SET (INPUT nuevo AS DATETIME):
        ASSIGN txFechaCreado:text = STRING(nuevo, "99/99/9999 hh:mm").
    END.

	CONSTRUCTOR PUBLIC DetallesDialog( ):
		SUPER().
		InitializeComponent ( ).
		CATCH e AS Progress.Lang.Error:
			UNDO, THROW e.
		END CATCH.		
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC DetallesDialog():
		IF VALID-OBJECT(components) THEN DO:
			CAST(components, System.IDisposable):Dispose().
		END.
	END DESTRUCTOR.	

    METHOD PRIVATE VOID okButton_Click (sender AS System.Object, e AS System.EventArgs):
        IF txNombre:text = "":U THEN DO:
            RUN mensaje.p (INPUT "Reporte", "Se debe Ingresar el Nombre del Reporte", "", "ERROR").
            RETURN.
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
        THIS-OBJECT:pnCreacion = NEW System.Windows.Forms.Panel().
        THIS-OBJECT:txFechaCreado = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbCreadoFecha = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txCreadopor = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbCreado = NEW System.Windows.Forms.Label().
        THIS-OBJECT:lbNombre = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txNombre = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbComentarios = NEW System.Windows.Forms.Label().
        THIS-OBJECT:txComentario = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:txCodigo = NEW System.Windows.Forms.TextBox().
        THIS-OBJECT:lbCodigo = NEW System.Windows.Forms.Label().
        THIS-OBJECT:pnBotones:SuspendLayout().
        THIS-OBJECT:pnCreacion:SuspendLayout().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* buttonOk */
        /*  */
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = System.Windows.Forms.AnchorStyles:Bottom.
        THIS-OBJECT:buttonOk:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:buttonOk:Location = NEW System.Drawing.Point(205, 1).
        THIS-OBJECT:buttonOk:Name = "buttonOk".
        THIS-OBJECT:buttonOk:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonOk:TabIndex = 3.
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
        THIS-OBJECT:buttonCancel:Location = NEW System.Drawing.Point(280, 1).
        THIS-OBJECT:buttonCancel:Name = "buttonCancel".
        THIS-OBJECT:buttonCancel:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:buttonCancel:TabIndex = 4.
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
        THIS-OBJECT:pnBotones:Location = NEW System.Drawing.Point(0, 196).
        THIS-OBJECT:pnBotones:Name = "pnBotones".
        THIS-OBJECT:pnBotones:Size = NEW System.Drawing.Size(361, 28).
        THIS-OBJECT:pnBotones:TabIndex = 2.
        /*  */
        /* pnCreacion */
        /*  */
        THIS-OBJECT:pnCreacion:BorderStyle = System.Windows.Forms.BorderStyle:Fixed3D.
        THIS-OBJECT:pnCreacion:Controls:Add(THIS-OBJECT:txFechaCreado).
        THIS-OBJECT:pnCreacion:Controls:Add(THIS-OBJECT:lbCreadoFecha).
        THIS-OBJECT:pnCreacion:Controls:Add(THIS-OBJECT:txCreadopor).
        THIS-OBJECT:pnCreacion:Controls:Add(THIS-OBJECT:lbCreado).
        THIS-OBJECT:pnCreacion:Dock = System.Windows.Forms.DockStyle:Bottom.
        THIS-OBJECT:pnCreacion:Location = NEW System.Drawing.Point(0, 164).
        THIS-OBJECT:pnCreacion:Name = "pnCreacion".
        THIS-OBJECT:pnCreacion:Size = NEW System.Drawing.Size(361, 32).
        THIS-OBJECT:pnCreacion:TabIndex = 3.
        /*  */
        /* txFechaCreado */
        /*  */
        THIS-OBJECT:txFechaCreado:Location = NEW System.Drawing.Point(223, 6).
        THIS-OBJECT:txFechaCreado:Name = "txFechaCreado".
        THIS-OBJECT:txFechaCreado:ReadOnly = TRUE.
        THIS-OBJECT:txFechaCreado:Size = NEW System.Drawing.Size(132, 20).
        THIS-OBJECT:txFechaCreado:TabIndex = 3.
        THIS-OBJECT:txFechaCreado:TabStop = FALSE.
        /*  */
        /* lbCreadoFecha */
        /*  */
        THIS-OBJECT:lbCreadoFecha:Location = NEW System.Drawing.Point(176, 6).
        THIS-OBJECT:lbCreadoFecha:Name = "lbCreadoFecha".
        THIS-OBJECT:lbCreadoFecha:Size = NEW System.Drawing.Size(43, 19).
        THIS-OBJECT:lbCreadoFecha:TabIndex = 2.
        THIS-OBJECT:lbCreadoFecha:Text = "Fecha:".
        THIS-OBJECT:lbCreadoFecha:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCreadoFecha:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txCreadopor */
        /*  */
        THIS-OBJECT:txCreadopor:Location = NEW System.Drawing.Point(73, 6).
        THIS-OBJECT:txCreadopor:Name = "txCreadopor".
        THIS-OBJECT:txCreadopor:ReadOnly = TRUE.
        THIS-OBJECT:txCreadopor:Size = NEW System.Drawing.Size(100, 20).
        THIS-OBJECT:txCreadopor:TabIndex = 1.
        THIS-OBJECT:txCreadopor:TabStop = FALSE.
        /*  */
        /* lbCreado */
        /*  */
        THIS-OBJECT:lbCreado:Location = NEW System.Drawing.Point(3, 6).
        THIS-OBJECT:lbCreado:Name = "lbCreado".
        THIS-OBJECT:lbCreado:Size = NEW System.Drawing.Size(64, 19).
        THIS-OBJECT:lbCreado:TabIndex = 0.
        THIS-OBJECT:lbCreado:Text = "Creado por:".
        THIS-OBJECT:lbCreado:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCreado:UseCompatibleTextRendering = TRUE.
        /*  */
        /* lbNombre */
        /*  */
        THIS-OBJECT:lbNombre:Location = NEW System.Drawing.Point(33, 26).
        THIS-OBJECT:lbNombre:Name = "lbNombre".
        THIS-OBJECT:lbNombre:Size = NEW System.Drawing.Size(49, 23).
        THIS-OBJECT:lbNombre:TabIndex = 4.
        THIS-OBJECT:lbNombre:Text = "Nombre:".
        THIS-OBJECT:lbNombre:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbNombre:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txNombre */
        /*  */
        THIS-OBJECT:txNombre:Location = NEW System.Drawing.Point(87, 28).
        THIS-OBJECT:txNombre:Name = "txNombre".
        THIS-OBJECT:txNombre:Size = NEW System.Drawing.Size(262, 20).
        THIS-OBJECT:txNombre:TabIndex = 1.
        /*  */
        /* lbComentarios */
        /*  */
        THIS-OBJECT:lbComentarios:Location = NEW System.Drawing.Point(10, 51).
        THIS-OBJECT:lbComentarios:Name = "lbComentarios".
        THIS-OBJECT:lbComentarios:Size = NEW System.Drawing.Size(72, 23).
        THIS-OBJECT:lbComentarios:TabIndex = 6.
        THIS-OBJECT:lbComentarios:Text = "Comentarios:".
        THIS-OBJECT:lbComentarios:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbComentarios:UseCompatibleTextRendering = TRUE.
        /*  */
        /* txComentario */
        /*  */
        THIS-OBJECT:txComentario:Location = NEW System.Drawing.Point(87, 58).
        THIS-OBJECT:txComentario:Multiline = TRUE.
        THIS-OBJECT:txComentario:Name = "txComentario".
        THIS-OBJECT:txComentario:Size = NEW System.Drawing.Size(262, 99).
        THIS-OBJECT:txComentario:TabIndex = 2.
        /*  */
        /* txCodigo */
        /*  */
        THIS-OBJECT:txCodigo:Location = NEW System.Drawing.Point(88, 4).
        THIS-OBJECT:txCodigo:Name = "txCodigo".
        THIS-OBJECT:txCodigo:ReadOnly = TRUE.
        THIS-OBJECT:txCodigo:Size = NEW System.Drawing.Size(69, 20).
        THIS-OBJECT:txCodigo:TabIndex = 9.
        THIS-OBJECT:txCodigo:TabStop = FALSE.
        /*  */
        /* lbCodigo */
        /*  */
        THIS-OBJECT:lbCodigo:Location = NEW System.Drawing.Point(34, 2).
        THIS-OBJECT:lbCodigo:Name = "lbCodigo".
        THIS-OBJECT:lbCodigo:Size = NEW System.Drawing.Size(49, 23).
        THIS-OBJECT:lbCodigo:TabIndex = 8.
        THIS-OBJECT:lbCodigo:Text = "Codigo:".
        THIS-OBJECT:lbCodigo:TextAlign = System.Drawing.ContentAlignment:MiddleRight.
        THIS-OBJECT:lbCodigo:UseCompatibleTextRendering = TRUE.
        /*  */
        /* DetallesDialog */
        /*  */
        THIS-OBJECT:AcceptButton = THIS-OBJECT:buttonOk.
        THIS-OBJECT:CancelButton = THIS-OBJECT:buttonCancel.
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(361, 224).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txCodigo).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lbCodigo).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txComentario).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lbComentarios).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:txNombre).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:lbNombre).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnCreacion).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:pnBotones).
        THIS-OBJECT:FormBorderStyle = System.Windows.Forms.FormBorderStyle:FixedDialog.
        THIS-OBJECT:MaximizeBox = FALSE.
        THIS-OBJECT:MinimizeBox = FALSE.
        THIS-OBJECT:Name = "DetallesDialog".
        THIS-OBJECT:ShowInTaskbar = FALSE.
        THIS-OBJECT:StartPosition = System.Windows.Forms.FormStartPosition:CenterScreen.
        THIS-OBJECT:Text = "Detalles del Reporte".
        THIS-OBJECT:pnBotones:ResumeLayout(FALSE).
        THIS-OBJECT:pnCreacion:ResumeLayout(FALSE).
        THIS-OBJECT:pnCreacion:PerformLayout().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
	END METHOD. 

	METHOD PUBLIC VOID ShowModalDialog(  ):
		WAIT-FOR THIS-OBJECT:ShowDialog().
	END METHOD. 
END CLASS.
