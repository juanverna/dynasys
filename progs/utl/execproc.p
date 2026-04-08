/*=================================================================================*/
/*              E J E C U T A   U N   P R O G R A M A   E X T E R N O              */
/*=================================================================================*/

{VRSHARED.I}   
{VPERSINM.I}

DEFINE NEW SHARED VARIABLE MAIN-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE ESTA-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE ANTE-WINDOW  AS WIDGET-HANDLE NO-UNDO.

DEFINE VARIABLE que AS CHARACTER LABEL "Proceso" FORMAT "X(40)".

FORM 
   SKIP(1)
   SPACE(3) que FGCOLOR fe_c BGCOLOR be_c SPACE(3)
   SKIP(1)
   WITH FRAME frm-run FGCOLOR f-fg_c BGCOLOR f-bg_c FONT 8 THREE-D
        SIDE-LABELS TITLE "Indique Proceso a ejecutar y oprima <ENTER>" VIEW-AS DIALOG-BOX.

DEFINE SUB-MENU Archivo
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo".

/*=================================================================================*/
/*                               T R I G G E R S                                   */
/*=================================================================================*/

ON CHOOSE OF MENU-ITEM Salir
DO:
   APPLY "U1" TO que IN FRAME frm-run.
END.

ON ESCAPE OF que IN FRAME frm-run
DO:
   APPLY "U1" TO que IN FRAME frm-run.
   RETURN NO-APPLY.
END.
        
ON RETURN OF que IN FRAME frm-run
DO:

   ASSIGN que.

   IF SEARCH(que) = ?
   THEN DO:
        MESSAGE "El procedimiento indicado no ha sido hallado"
                VIEW-AS ALERT-BOX ERROR TITLE "Error: XXXX000".
        UNDO, RETRY.        
   END.
   ELSE DO:
        DISABLE ALL WITH FRAME frm-run.
        HIDE FRAME frm-run.
        RUN VALUE(que).   
        VIEW FRAME frm-run.
        ENABLE ALL WITH FRAME frm-run.
   END.     
   
END.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

ANTE-WINDOW = CURRENT-WINDOW.
ANTE-WINDOW:SENSITIVE = NO.

nom_funcion = "Ejecucion de procedimientos".
nom_menu    = "UTILIDADES".
{findempresa.i}   
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion + " - " + Usuario.cdg_usuario.

CREATE WINDOW ESTA-WINDOW ASSIGN

         TITLE          = titulo_w
         RESIZE         = YES
         SCROLL-BARS    = NO
         STATUS-AREA    = YES
         MAX-WIDTH-PIXELS   = SESSION:WIDTH-PIXELS
         MAX-HEIGHT-PIXELS  = SESSION:HEIGHT-PIXELS
         WIDTH-PIXELS       = SESSION:WIDTH-PIXELS /* - 10*/
         HEIGHT-PIXELS      = SESSION:HEIGHT-PIXELS /*- 80*/
         BGCOLOR        = w-bg_c
         FGCOLOR        = w-fg_c
         MENUBAR        = MENU Principal:HANDLE
         MESSAGE-AREA   = NO
         SENSITIVE      = YES
         THREE-D        = YES
         WINDOW-STATE   = 1
         VISIBLE        = YES.


CURRENT-WINDOW = ESTA-WINDOW.
MENU Principal:SENSITIVE = YES.
ENABLE ALL WITH FRAME  frm-run.
WAIT-FOR U1 OF que IN FRAME frm-run.
HIDE FRAME frm-run.

ANTE-WINDOW:SENSITIVE = YES.
DELETE WIDGET ESTA-WINDOW.
CURRENT-WINDOW = ANTE-WINDOW.

