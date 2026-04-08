/*========================================================================================*/
/*               MUESTRA UNA VENTANA QUE PERMITE SELECCIONAR UN ARCHIVO                   */
/*========================================================================================*/

DEFINE INPUT-OUTPUT PARAMETER v-archivo AS CHARACTER FORMAT "X(50)".
DEFINE OUTPUT PARAMETER puso_ok         AS LOGICAL.

SYSTEM-DIALOG GET-FILE v-archivo
      FILTERS "Delimitados por Comas (*.CSV)" "*.csv",
	      "Archivos texto (*.txt)" "*.txt"
      INITIAL-FILTER 1
      ASK-OVERWRITE 
      CREATE-TEST-FILE
      DEFAULT-EXTENSION ".csv"
      INITIAL-DIR "c:\tempdsp" 
      RETURN-TO-START-DIR 
      SAVE-AS
      TITLE "Seleccione el archivo de salida" 
      USE-FILENAME
      UPDATE puso_ok.
