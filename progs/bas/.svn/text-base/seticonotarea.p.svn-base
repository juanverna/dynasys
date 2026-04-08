/*===================================================================================================*/
/*                  CAMBIA EL ICONO Y EL TITULOS ASOCIADOS A LA SESION EN EL TASK MANAGER            */
/*===================================================================================================*/

/*===================================================================================================*/
/*                                           PARAMETROS                                              */
/*===================================================================================================*/

DEFINE INPUT PARAMETER p-titulo     AS CHARACTER.
DEFINE INPUT PARAMETER p-fileiconos AS CHARACTER.

/*===================================================================================================*/
/*                                           VARIABLES                                               */
/*===================================================================================================*/

&Scoped-Define WM_GETICON 127
&Scoped-Define WM_SETICON 128
/* WM_SETICON / WM_GETICON Type Codes */
&Scoped-Define ICON_SMALL 0
&Scoped-Define ICON_BIG 1
/* some GetWindow() Constants */
&Scoped-Define GW_OWNER 4
DEFINE VARIABLE hParent   AS INTEGER NO-UNDO.
DEFINE VARIABLE hOwner    AS INTEGER NO-UNDO.
DEFINE VARIABLE i_ApiStat AS INTEGER NO-UNDO.
DEFINE VARIABLE hIcon     AS INTEGER NO-UNDO.

/*===================================================================================================*/
/*                                         BLOQUE PRINCIPAL                                          */
/*===================================================================================================*/

/* find the hidden owner window */
RUN GetParent (DEFAULT-WINDOW:HWND, OUTPUT hParent).
RUN GetWindow (hParent, {&GW_OWNER}, OUTPUT hOwner).
/* change the title: */
RUN SetWindowTextA (hOwner, p-titulo).
/* change the icon: */
RUN ExtractIconA (0, SEARCH(p-fileiconos), 0, OUTPUT hIcon).   
IF hIcon > 0 THEN DO:
   RUN SendMessageA( hOwner, {&WM_SETICON}, {&ICON_BIG},   hIcon, OUTPUT i_ApiStat ).
   RUN SendMessageA( hOwner, {&WM_SETICON}, {&ICON_SMALL}, hIcon, OUTPUT i_ApiStat ).
END.      

/*===================================================================================================*/
/*                                 PROCESOS DE ACCESO A LA API                                       */
/*===================================================================================================*/

/* ----------- API definitions: ----------------------- */
PROCEDURE SetWindowTextA EXTERNAL "user32.dll" :
  DEFINE INPUT PARAMETER HWND AS LONG.
  DEFINE INPUT PARAMETER txt  AS CHARACTER.
END PROCEDURE.
PROCEDURE SendMessageA EXTERNAL "USER32.DLL":
  DEFINE INPUT  PARAMETER h_Widget    AS LONG.
  DEFINE INPUT  PARAMETER i_Message   AS LONG.
  DEFINE INPUT  PARAMETER i_wParam    AS LONG.
  DEFINE INPUT  PARAMETER i_lParam    AS LONG.
  DEFINE RETURN PARAMETER i_ApiStatus AS LONG.
END PROCEDURE.
PROCEDURE GetWindow EXTERNAL "user32.dll" :
  DEFINE INPUT PARAMETER  HWND      AS LONG.
  DEFINE INPUT PARAMETER  uCmd      AS LONG.
  DEFINE RETURN PARAMETER hwndOther AS LONG.
END PROCEDURE.
PROCEDURE GetParent EXTERNAL "user32.dll" :
  DEFINE INPUT PARAMETER  hwndChild  AS LONG.
  DEFINE RETURN PARAMETER hwndParent AS LONG.
END PROCEDURE.
PROCEDURE ExtractIconA EXTERNAL "shell32.dll":
  DEFINE INPUT  PARAMETER hInst           AS LONG.
  DEFINE INPUT  PARAMETER lpszExeFileName AS CHARACTER.
  DEFINE INPUT  PARAMETER nIconIndex      AS LONG.
  DEFINE RETURN PARAMETER i_Return        AS LONG.
END PROCEDURE
