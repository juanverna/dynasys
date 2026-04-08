
/*=================================================================================*/
/*                           PARAMETROS Y DEFINICIONES                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER  que_archivo AS CHARACTER.
DEFINE INPUT PARAMETER  old_string  AS CHARACTER.
DEFINE INPUT PARAMETER  new_string  AS CHARACTER.
DEFINE OUTPUT PARAMETER hubo_cambio AS LOGICAL.

DEFINE VARIABLE aux_archivo AS CHARACTER.
DEFINE VARIABLE puso_ok     AS LOGICAL.
DEFINE VARIABLE titulo_ed   AS CHARACTER.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE n_reem      AS INTEGER.

{VRSHARED.I}
/*{VPERSINM.I}*/

DEFINE VARIABLE resultados AS CHARACTER
                VIEW-AS EDITOR /*SIZE-PIXELS 620 BY 360 */ SIZE 70 BY 10
                        SCROLLBAR-VERTICAL SCROLLBAR-HORIZONTAL LARGE.

FORM
   resultados  FONT 11
   WITH FRAME frm-resultados WIDTH 90 NO-LABEL CENTERED FONT 11
   TITLE titulo_ed.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

FRAME frm-resultados:WIDTH-PIXELS  = CURRENT-WINDOW:WIDTH-PIXELS.
FRAME frm-resultados:HEIGHT-PIXELS = CURRENT-WINDOW:HEIGHT-PIXELS.
resultados:WIDTH-PIXELS  = FRAME frm-resultados:WIDTH-PIXELS - 2.
resultados:HEIGHT-PIXELS = FRAME frm-resultados:HEIGHT-PIXELS - 23.

titulo_ed = "Resultado de la ultima ejecucion. Archivo:" + que_archivo.
como_fue = resultados:READ-FILE(que_archivo) IN FRAME frm-resultados.
IF como_fue
THEN DO:
   
   hubo_cambio = NO.
   n_reem = NUM-ENTRIES(old_string).
   DO j = 1 TO n_reem:
      como_fue = resultados:REPLACE(ENTRY(j,old_string),ENTRY(j,new_string),8) IN FRAME frm-resultados.
      IF como_fue THEN hubo_cambio = YES.
   END.   
   que_archivo = SEARCH(que_archivo).
   IF hubo_cambio THEN como_fue = resultados:SAVE-FILE(que_archivo) IN FRAME frm-resultados.
   RETURN.

END.
ELSE DO:
   BELL.
   MESSAGE "No pudo cargarse el archivo"
       VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
END.
