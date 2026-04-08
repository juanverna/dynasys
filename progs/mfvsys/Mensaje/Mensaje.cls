 
 /*------------------------------------------------------------------------
    File        : Mensaje
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : Marcelo Ferrante
    Created     : Sun Feb 15 14:27:37 BRST 2015
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING mfvsys.Mensaje.*.
USING System.Windows.Forms.MessageBoxIcon.
USING Infragistics.Win.UltraMessageBox.MessageBoxControl.

CLASS mfvsys.Mensaje.Mensaje INHERITS MessageBoxControl:

    DEFINE PUBLIC PROPERTY Titulo AS CHARACTER GET.
    SET (INPUT nuevo AS CHARACTER):
        ASSIGN Titulo = nuevo
               THIS-OBJECT:MessageBoxInfo:Caption = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Texto AS CHARACTER GET.
    SET (INPUT nuevo AS CHARACTER):
        Texto = nuevo.
        THIS-OBJECT:MessageBoxInfo:TextFormatted = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Pie AS CHARACTER GET.
    SET (INPUT nuevo AS CHARACTER):
        ASSIGN pie = nuevo
               THIS-OBJECT:MessageBoxInfo:FooterFormatted = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Icono AS System.Windows.Forms.MessageBoxIcon NO-UNDO GET.
    SET (INPUT nuevo AS System.Windows.Forms.MessageBoxIcon):
        ASSIGN Icono = nuevo
               THIS-OBJECT:MessageBoxInfo:Icon = nuevo.
    END SET.

    DEFINE PUBLIC PROPERTY Tipo AS CHARACTER NO-UNDO GET.
    SET (INPUT nuevo AS CHARACTER):
        ASSIGN Tipo = nuevo.
        CASE nuevo:
            WHEN "Warning":U THEN ASSIGN THIS-OBJECT:Icono  = MessageBoxIcon:Warning.
            WHEN "Error":U THEN ASSIGN THIS-OBJECT:Icono    = MessageBoxIcon:Error.
            WHEN "Question":U THEN ASSIGN THIS-OBJECT:Icono = MessageBoxIcon:Question.
            OTHERWISE
                ASSIGN THIS-OBJECT:Icono = MessageBoxIcon:Information.
        END CASE.
    END SET.

    DEFINE PUBLIC PROPERTY Botones AS CHARACTER NO-UNDO GET.
    SET (INPUT nuevo AS CHARACTER):
        ASSIGN Botones = nuevo.
        CASE nuevo:
            WHEN "AbortRetryIgnore":U THEN ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:AbortRetryIgnore.
            WHEN "OKCancel":U         THEN ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:OKCancel.
            WHEN "RetryCancel":U      THEN ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:RetryCancel.
            WHEN "YesNo":U            THEN ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:YesNo.
            WHEN "YesNoCancel":U      THEN ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:YesNoCancel.
            OTHERWISE DO:
                 ASSIGN THIS-OBJECT:MessageBoxInfo:Buttons = System.Windows.Forms.MessageBoxButtons:OK.
            END.
        END CASE.
    END SET.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC System.Windows.Forms.DialogResult mostrarMensaje():
        DEFINE VARIABLE man AS Infragistics.Win.UltraMessageBox.UltraMessageBoxManager NO-UNDO.
        man = NEW Infragistics.Win.UltraMessageBox.UltraMessageBoxManager().
        RETURN man:ShowMessageBox(THIS-OBJECT:MessageBoxInfo).
    END METHOD.

	CONSTRUCTOR PUBLIC Mensaje ():
		SUPER ().
	END CONSTRUCTOR.
END CLASS.
