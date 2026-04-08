/*=================================================================================*/
/*  MUESTRA EL PRIMER Y ULTIMO CLIENTE DE UNA ZONA DE CODIGOS DE CLIENTE           */
/*=================================================================================*/

DEFINE VARIABLE que_zona AS CHARACTER FORMAT "X(1)" LABEL "Zona".
DEFINE VARIABLE primero  LIKE Cliente.cdg_cliente LABEL "Primero".
DEFINE VARIABLE ultimo   LIKE Cliente.cdg_cliente LABEL "Ultimo".

FORM
  que_zona SKIP
  primero SPACE(8) SKIP
  ultimo SKIP
  WITH FRAME f-frame VIEW-AS DIALOG-BOX THREE-D FONT 4 SIDE-LABELS TITLE "Oprimir Esc para otra zona"
       1 COLUMN.

FRAME f-frame:TITLE = "Indique Zona a consultar".

UPDATE que_zona WITH FRAME f-frame.

FIND FIRST Cliente WHERE Cliente.cdg_cliente BEGINS que_zona.
primero = Cliente.cdg_cliente.

FIND LAST Cliente WHERE Cliente.cdg_cliente BEGINS que_zona.
ultimo = Cliente.cdg_cliente.

FRAME f-frame:TITLE = "Oprima Esc para otra zona".

UPDATE primero ultimo WITH FRAME f-frame.
