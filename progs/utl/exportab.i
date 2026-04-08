/*=================================================================================*/
/*                       EXPORTACION DE TABLAS A ARCHIVOS CSV                      */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE que_archivo AS CHARACTER INITIAL "{&INIT-SALIDA}" LABEL "Salida" FORMAT "X(32)".

DEFINE FRAME frm-rango 
       SKIP(1)
       que_archivo  COLON 10 FGCOLOR fe_c BGCOLOR be_c
       SKIP(1)
       WITH FRAME frm-rango FONT 8 THREE-D FGCOLOR f-fg_c BGCOLOR f-bg_c
            SIDE-LABELS TITLE "{&TITULO-FRM}"
            VIEW-AS DIALOG-BOX.

/*=================================================================================*/
/*                              PROCESO DE EXPORTACION                             */
/*=================================================================================*/

   UPDATE que_archivo
       WITH FRAME frm-rango.

   OUTPUT TO VALUE(que_archivo) PAGE-SIZE 0.
   FOR EACH {&TABLA}:
       EXPORT {&TABLA}.
   END.          
   OUTPUT CLOSE.
   MESSAGE "La Tabla ha sido exportada." 
           VIEW-AS ALERT-BOX MESSAGE TITLE "Operacion finalizada".

/*=================================================================================*/
/*                                    PROCEDIMIENTOS                               */
/*=================================================================================*/



