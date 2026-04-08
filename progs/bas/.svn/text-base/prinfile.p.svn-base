DEFINE INPUT PARAMETER que_archivo AS CHARACTER.
DEFINE INPUT PARAMETER puerto AS CHARACTER.

{VPERSINM.I}

DEFINE VARIABLE linea AS CHARACTER FORMAT "X(250)".
DEFINE VARIABLE mensaje AS CHARACTER FORMAT "X(40)" 
                        INITIAL "Enviando listado a impresion ...".
DEFINE STREAM Impreso.

FORM 
  linea FONT 8 SKIP
  WITH FRAME a 
       WIDTH 256 NO-LABEL USE-TEXT STREAM-IO DOWN.

FORM
  mensaje FONT 8
  WITH FRAME espere NO-LABEL FGCOLOR 14 BGCOLOR 4 
       VIEW-AS DIALOG-BOX TITLE "Aguarde un momento por favor".
  
DISPLAY mensaje WITH FRAME espere.

RUN PROPRINT.P ( INPUT que_archivo ).

HIDE FRAME espere NO-PAUSE.
 