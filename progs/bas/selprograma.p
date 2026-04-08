/*========================================================================================*/
/*               MUESTRA UNA VENTANA QUE PERMITE SELECCIONAR UN ARCHIVO                   */
/*========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER v-archivo    AS CHARACTER.
DEFINE INPUT        PARAMETER v-directorio AS CHARACTER.
DEFINE INPUT  PARAMETER absoluto           AS LOGICAL.
DEFINE OUTPUT PARAMETER puso_ok            AS LOGICAL.

SYSTEM-DIALOG GET-FILE v-archivo
      FILTERS "Programas(*.W,*.P)" "*.w,*.p"
      INITIAL-FILTER 1
      MUST-EXIST 
      DEFAULT-EXTENSION ".w"
      INITIAL-DIR ".\" + v-directorio 
      RETURN-TO-START-DIR 
      TITLE "Seleccione el archivo a ejecutar" 
      USE-FILENAME
      UPDATE puso_ok.

IF puso_ok 
   THEN IF SEARCH(ENTRY(NUM-ENTRIES(v-archivo,"\"),v-archivo,"\")) <> ? AND NOT absoluto
           THEN DO:
                v-archivo = ENTRY(NUM-ENTRIES(v-archivo,"\"),v-archivo,"\").
           END.
