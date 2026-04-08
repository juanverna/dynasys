DEFINE VARIABLE v_tabla AS CHARACTER.
DEFINE VARIABLE v_desc  AS CHARACTER FORMAT "X(120)".

{VRSHARED.I}
{VPERSINM.I}

MESSAGE "Esta opcion importa las descripciones de las tablas del sistema " 
        "desde un archivo. Desea continuar?"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO 
        TITLE "Se pide confirmacion" UPDATE sino. 
        
IF sino
THEN DO:

   INPUT FROM VALUE(dire_tmp + "desctabl.txt").
   REPEAT:
       IMPORT v_tabla v_desc.
       FIND _File WHERE _File._file-name = v_tabla EXCLUSIVE-LOCK.
       ASSIGN _File._Desc = v_desc.
   END.          
   INPUT CLOSE.
   MESSAGE "Las descripciones de las tablas del sistema han sido importadas." 
           VIEW-AS ALERT-BOX MESSAGE TITLE "Operacion finalizada".

END.