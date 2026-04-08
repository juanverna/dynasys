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

DEFINE INPUT  PARAMETER tipos_validos AS CHARACTER.

DEFINE VARIABLE titulo-fun AS CHARACTER FORMAT "X(40)".

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE codigo_salir     AS INTEGER.

DEFINE VARIABLE CD_SALIR         AS INTEGER INITIAL 0.
DEFINE VARIABLE CD_CANCELAR      AS INTEGER INITIAL 1.
DEFINE VARIABLE CD_GRABAR        AS INTEGER INITIAL 2.
DEFINE VARIABLE CD_BAJA          AS INTEGER INITIAL 3.

DEFINE BUTTON btn_SALIR
     LABEL "&Salir":L 
     SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_COPIAR
     LABEL "&Copiar":L 
     SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_CANCEL
     LABEL "Ca&ncelar":L 
     SIZE 10 BY 1 FONT 4.

FORM 
     SKIP(0.5)
     SPACE(5)
     Rqs_header.tip_comprob FGCOLOR fe_c BGCOLOR be_c LABEL "Requisición"
     Rqs_header.nro_comprob FGCOLOR fe_c BGCOLOR be_c NO-LABEL
     Rqs_header.fecha       FGCOLOR fe_c BGCOLOR be_c 
     SKIP(0.5)
     btn_COPIAR AT 1
     btn_CANCEL AT 36
     btn_SALIR AT 69
     WITH FRAME frm-copiar SIDE-LABELS VIEW-AS DIALOG-BOX 
          FGCOLOR d-fg_c BGCOLOR d-bg_c FONT 4 THREE-D KEEP-TAB-ORDER
          TITLE titulo-fun.


ON CHOOSE OF btn_COPIAR IN FRAME frm-copiar
DO:

   codigo_salir = CD_GRABAR.
   APPLY "U1" TO FRAME frm-copiar.
   
END.

ON CHOOSE OF btn_CANCEL IN FRAME frm-copiar
DO:

   codigo_salir = CD_CANCELAR.
   APPLY "U1" TO FRAME frm-copiar.
   
END.

ON CHOOSE OF btn_SALIR IN FRAME frm-copiar
DO:

   codigo_salir = CD_SALIR.
   APPLY "U1" TO FRAME frm-copiar.
  
END.

ON END-ERROR OF FRAME frm-copiar
DO:
  APPLY "CHOOSE" TO btn_salir IN FRAME frm-copiar.
  RETURN NO-APPLY.
END.  

ON RETURN, TAB OF Rqs_header.tip_comprob IN FRAME frm-copiar
DO:

   IF LOOKUP(INPUT FRAME frm-copiar Rqs_header.tip_comprob,tipos_validos) = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.
   
END.   

ON RETURN OF Rqs_header.nro_comprob IN FRAME frm-copiar
DO:

   IF LOOKUP(INPUT FRAME frm-copiar Rqs_header.tip_comprob, tipos_validos) = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   RUN BUSCAR_DOCUMENTO.
   IF hay_error THEN RETURN NO-APPLY.

END.               


ON ".", MOUSE-SELECT-DBLCLICK OF
        Rqs_header.tip_comprob, Rqs_header.nro_comprob IN FRAME frm-copiar
DO:

  RUN SELRETRA.P (OUTPUT ult_Rqs_head).
  IF ult_Rqs_head <> ?
  THEN DO:
     FIND Rqs_header WHERE ROWID(Rqs_header) = ult_Rqs_head NO-LOCK.
     DISPLAY Rqs_header.tip_comprob 
             Rqs_header.nro_comprob 
             WITH FRAME frm-copiar.
     APPLY "RETURN" TO Rqs_header.nro_comprob IN FRAME frm-copiar.
  END.  
  RETURN NO-APPLY.  
  
END.   

/*===================================================================================*/
/*    C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I N G R E S O      */
/*===================================================================================*/

titulo-fun = "Copia de Requisición".

Espera:
REPEAT:
   
   ult_Rqs_head = ?.
   CLEAR FRAME frm-copiar ALL NO-PAUSE.
   ENABLE Rqs_header.tip_comprob
          Rqs_header.nro_comprob
          btn_CANCEL
          btn_SALIR
          WITH FRAME frm-copiar.
   DISABLE btn_COPIAR
          WITH FRAME frm-copiar.
          
   WAIT-FOR U1 OF FRAME frm-copiar.

   IF codigo_salir = CD_SALIR
   THEN DO:
      RUN TOCARSND.P ( INPUT "SOUND\SALIR.WAV").
      UNDO Espera, LEAVE Espera.
   END.
         
   IF codigo_salir = CD_CANCELAR
   THEN DO:
      RUN TOCARSND.P ( INPUT "SOUND\ELIMINAR.WAV").   
      UNDO Espera, NEXT Espera.
   END.

   IF AVAILABLE Rqs_header
   THEN DO:
      ult_Rqs_head = ROWID(Rqs_header).
      LEAVE Espera.
   END.

   RUN PONMENSJ.P ( INPUT "REQU021" ).
   
END.    /* Fin del lazo de espera */

HIDE FRAME frm-copiar NO-PAUSE.

/*===================================================================================*/
/*                            P R O C E D I M I E N T O S                            */
/*===================================================================================*/

PROCEDURE PONER_SESION:

END PROCEDURE.

PROCEDURE BUSCAR_DOCUMENTO:

   hay_error = YES.

   FIND Rqs_header USING FRAME frm-copiar Rqs_header.tip_comprob 
                     AND FRAME frm-copiar Rqs_header.nro_comprob 
                         NO-LOCK NO-ERROR.

   IF NOT AVAILABLE Rqs_header
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS001").
      RETURN.
   END.
  

   IF NOT Rqs_header.es_reposicion
   THEN DO:
      RUN PONMENSJ.P (INPUT "VINV015").
      RETURN.
   END.

   DISPLAY  Rqs_header.fecha
            WITH FRAME frm-copiar.

   ENABLE btn_copiar WITH FRAME frm-copiar. 

   hay_error = NO.
               
END PROCEDURE. 
