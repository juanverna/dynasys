/*=================================================================================*/
/*                                                                                 */
/*                             P A R A M E T R O S                                 */
/*                             -------------------                                 */
/*                                                                                 */
/*                        0 - Altas de movimientos                                 */
/*                        1 - Modificaciones                                       */
/*                        2 - Consulta de movimientos                              */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER modo AS INTEGER.

{VPERCONM.I}

&SCOPED-DEFINE T

&IF DEFINED(USAR-TEMPORARIA) <> 0
&THEN
DEFINE SHARED TEMP-TABLE T-{&TABLA-MASTER} LIKE {&TABLA-MASTER}.
&SCOPED-DEFINE T T-
&ENDIF


CREATE WIDGET-POOL.
DEFINE VARIABLE ESTA-WINDOW      AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE ANTE-WINDOW      AS WIDGET-HANDLE NO-UNDO.

DEFINE VARIABLE titulo-fun       AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE delta_btn        AS DECIMAL INITIAL 0.5.

DEFINE VARIABLE codigo_salir     AS INTEGER.

DEFINE VARIABLE CD_SALIR         AS INTEGER INITIAL 0.
DEFINE VARIABLE CD_CANCELAR      AS INTEGER INITIAL 1.
DEFINE VARIABLE CD_GRABAR        AS INTEGER INITIAL 2.
DEFINE VARIABLE CD_BAJA          AS INTEGER INITIAL 3.

{VRSHARED.I}

DEFINE QUERY {&QRY_BROWSE} FOR {&TABLAS_QUERY}.
DEFINE BROWSE {&BROWSE} QUERY {&QRY_BROWSE}
       DISPLAY {&CAMPOS_BRW}
               WITH 10 DOWN NO-UNDERLINE FONT 4 
               FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
               TITLE "{&TITULO_BRW}".
               
DEFINE BUTTON btn_SALIR
     LABEL "&Salir":L 
     SIZE 2 BY 1 FONT 4.


FORM 
     SKIP
     {&BROWSE}
     SKIP
     btn_SALIR 
     WITH FRAME {&FRAME-MAIN} SIDE-LABELS
          FGCOLOR d-fg_c BGCOLOR d-bg_c FONT 4 THREE-D KEEP-TAB-ORDER.

/*===================================================================================*/
/*                                   T R I G G E R S                                 */
/*===================================================================================*/

ON CHOOSE OF btn_salir IN FRAME {&FRAME-MAIN}
DO:
   codigo_salir = CD_SALIR.
   APPLY "U1" TO FRAME {&FRAME-MAIN}.
  
END.

ON END-ERROR OF FRAME {&FRAME-MAIN}
DO:
  APPLY "CHOOSE" TO btn_salir IN FRAME {&FRAME-MAIN}.
  RETURN NO-APPLY.
END.  

/*===================================================================================*/
/*    C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O      */
/*===================================================================================*/

DO WITH FRAME {&FRAME-MAIN}:

  btn_salir:WIDTH   = FRAME {&FRAME-MAIN}:WIDTH - 1 .
  btn_salir:COLUMN  = 1.

END.

ANTE-WINDOW = CURRENT-WINDOW.
ANTE-WINDOW:SENSITIVE = NO.

CREATE WINDOW ESTA-WINDOW ASSIGN

         TITLE          = "{&TITULO_WIN}"
         RESIZE         = NO
         SCROLL-BARS    = NO
         STATUS-AREA    = NO
         WIDTH-PIXELS   = FRAME {&FRAME-MAIN}:WIDTH-PIXELS
         HEIGHT-PIXELS  = FRAME {&FRAME-MAIN}:HEIGHT-PIXELS
         BGCOLOR        = w-bg_c
         FGCOLOR        = w-fg_c
         MESSAGE-AREA   = NO
         SENSITIVE      = YES
         THREE-D        = YES
         WINDOW-STATE   = 1
         VISIBLE        = NO.

{CENTRWIN.I "ESTA-WINDOW" }.
  
CURRENT-WINDOW = ESTA-WINDOW.

Actualizacion:
REPEAT:

   &IF DEFINED(USAR-TEMPORARIA) <> 0
   &THEN
   FIND FIRST T-{&TABLA-MASTER} EXCLUSIVE-LOCK.
   &ENDIF

   &IF DEFINED(USAR-TEMPORARIA) = 0
   &THEN
   FIND {&TABLA-MASTER}  WHERE ROWID({&TABLA-MASTER})  = {&ACT_MASTER}.
   &ENDIF

   RUN ABRE_QUERY.
   ENABLE {&BROWSE}
          btn_SALIR
          WITH FRAME {&FRAME-MAIN}.

   WAIT-FOR U1 OF FRAME {&FRAME-MAIN}
                  FOCUS {&BROWSE}.

   IF codigo_salir = CD_SALIR  
   THEN DO:
      RUN TOCARSND.P (INPUT "SOUND\ELIMINAR.WAV").
      UNDO Actualizacion, LEAVE Actualizacion.
   END.
        
   LEAVE Actualizacion.

END. /* De actualizacion */

HIDE FRAME {&FRAME-MAIN} NO-PAUSE.
ANTE-WINDOW:SENSITIVE = YES.
DELETE WIDGET ESTA-WINDOW.
CURRENT-WINDOW = ANTE-WINDOW.

/*===================================================================================*/
/*                           P R O C E D I M I E N T O S                             */
/*===================================================================================*/

PROCEDURE PONER_SESION:

END PROCEDURE.

PROCEDURE ABRE_QUERY:

     OPEN QUERY {&QRY_BROWSE} FOR EACH {&QRY_CONDICION}.

END PROCEDURE.
 
&IF DEFINED(PROCESOS)
&THEN

{&PROCESOS}

&ENDIF 
