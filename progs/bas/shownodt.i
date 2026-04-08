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
     WITH FRAME {&FRAME-MAIN} SIDE-LABELS VIEW-AS DIALOG-BOX
          FGCOLOR d-fg_c BGCOLOR d-bg_c FONT 4 THREE-D KEEP-TAB-ORDER
          WIDTH 90 TITLE "{&TITULO_WIN}".

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

  btn_salir:WIDTH   = FRAME {&FRAME-MAIN}:WIDTH - 2 .

END.


Actualizacion:
REPEAT:

   FIND {&TABLA-MASTER}  WHERE ROWID({&TABLA-MASTER})  = {&ACT_MASTER} NO-LOCK.

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
