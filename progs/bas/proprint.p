/*========================================================================================*/
/*     IMPRIME UN ARCHIVO CON UN FONT FIJO Y UNA ORIENTACION FIJA DE IMPRESORA            */
/*========================================================================================*/

DEFINE INPUT PARAMETER p_file AS CHARACTER.

DEFINE VARIABLE p_printed AS LOGICAL.
RUN _osprint.p ( INPUT  CURRENT-WINDOW:HANDLE,
                 INPUT  p_file,
                 INPUT  9,
                 INPUT  0,
                 INPUT  56,
                 INPUT  0,
                 OUTPUT  p_Printed ).
