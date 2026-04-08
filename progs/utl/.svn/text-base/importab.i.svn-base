/*=================================================================================*/
/*                REPORTA LAS DESCRIPCIONES DE CADA TABLA POR MODULO               */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE TEMP-TABLE T-{&TABLA} LIKE {&TABLA}.

DEFINE VARIABLE tipo_valida AS CHARACTER VIEW-AS RADIO-SET VERTICAL
       RADIO-BUTTONS "Reemplazar enteramente una tabla por la otra","R",
                     "Agregar registros nuevos. Actualizar existentes","A",
                     "S¢lo agregar registros nuevos","N"
       INITIAL "N".

DEFINE VARIABLE tit_modo AS CHARACTER FORMAT "X(30)" INITIAL "Modo de Actualizacion".
                                                      
DEFINE VARIABLE que_archivo AS CHARACTER INITIAL "{&INIT-ENTRADA}" LABEL "Input" FORMAT "X(32)".
DEFINE VARIABLE sub_desc    AS CHARACTER.
DEFINE VARIABLE linea       AS CHARACTER FORMAT "X(80)".

DEFINE FRAME frm-rango 
       SKIP(1)
       tit_modo      AT 20 FGCOLOR fe_c NO-LABEL VIEW-AS TEXT
       SKIP(0.5)
       tipo_valida   COLON 10 NO-LABEL
       SKIP(1)
       que_archivo  COLON 10 FGCOLOR fe_c BGCOLOR be_c
       SKIP(1)
       WITH FRAME frm-rango FONT 8 THREE-D FGCOLOR f-fg_c BGCOLOR f-bg_c
            SIDE-LABELS TITLE "{&TITULO-FRM}"
            VIEW-AS DIALOG-BOX.

/*=================================================================================*/
/*                REPORTA LAS DESCRIPCIONES DE CADA TABLA POR MODULO               */
/*=================================================================================*/

DISPLAY tit_modo tipo_valida que_archivo
       WITH FRAME frm-rango.
       
UPDATE tipo_valida que_archivo
       WITH FRAME frm-rango.

IF tipo_valida = "R"
THEN DO:
     FOR EACH {&TABLA} EXCLUSIVE-LOCK:
         DELETE {&TABLA}.
     END.
END.         

INPUT FROM VALUE(que_archivo).
REPEAT:

    CASE tipo_valida:

         WHEN "R" 
         THEN DO:
              CREATE {&TABLA}.
              IMPORT {&TABLA}.         
         END.

         WHEN "A" 
         THEN DO:
              CREATE T-{&TABLA}.
              IMPORT T-{&TABLA}.
              FIND FIRST {&TABLA} WHERE {&TABLA}.{&CODIGO} = T-{&TABLA}.{&CODIGO} EXCLUSIVE-LOCK NO-ERROR.
              IF NOT AVAILABLE {&TABLA} 
                 THEN CREATE {&TABLA}.
              ASSIGN 
                     {&ASIGNAR-TABLA}.
         END.

         WHEN "N" 
         THEN DO:
              CREATE T-{&TABLA}.
              IMPORT T-{&TABLA}.
              FIND FIRST {&TABLA} WHERE {&TABLA}.{&CODIGO} = T-{&TABLA}.{&CODIGO} EXCLUSIVE-LOCK NO-ERROR.
              IF NOT AVAILABLE {&TABLA} 
              THEN DO:
                 CREATE {&TABLA}.
                 ASSIGN 
                     {&ASIGNAR-TABLA}.
              END.          
         END.


    END CASE.

END.    
INPUT CLOSE.
   MESSAGE "La Tabla ha sido importada." 
           VIEW-AS ALERT-BOX MESSAGE TITLE "Operacion finalizada".

/*=================================================================================*/
/*                                    PROCEDIMIENTOS                               */
/*=================================================================================*/



