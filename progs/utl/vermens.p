
DEFINE BUFFER b FOR mensaje.
DEFINE VARIABLE desde AS CHARACTER FORMAT "X(4)" LABEL "Grupo".

FORM
    desde 
     WITH FRAME f SIDE-LABELS CENTERED.
       
SET desde 
    WITH FRAME f.

       
FOR EACH Mensaje WHERE cdg_mensaje BEGINS desde:

    DISPLAY Mensaje.cdg_mensaje Mensaje.texto.           

END.           
