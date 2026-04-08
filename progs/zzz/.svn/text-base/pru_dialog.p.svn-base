DEF VAR x-carpeta_inicial AS CHAR FORMAT "X(40)".
DEF VAR x-icono           AS CHAR FORMAT "X(40)".
DEF VAR puso_ok           AS LOGICAL.

REPEAT:

    UPDATE x-carpeta_inicial.
          
    SYSTEM-DIALOG GET-FILE x-icono
          FILTERS "Mapas de Bits (*.BMP)" "*.bmp",
    	          "Mapas de Bits (*.bmp)" "*.bmp"
          INITIAL-FILTER 1
        /*ASK-OVERWRITE 
          CREATE-TEST-FILE*/
          MUST-EXIST
          DEFAULT-EXTENSION ".bmp"
          INITIAL-DIR x-carpeta_inicial
          RETURN-TO-START-DIR
        /*SAVE-AS*/
          TITLE "Seleccione el archivo de imagen" 
          USE-FILENAME
          UPDATE puso_ok.

    MESSAGE x-icono SKIP puso_ok
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
END.

