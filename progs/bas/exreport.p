/* ============================================================================================== 

  run aderb/_printrb.p 
  ( 
    R-library:screen-value,    /* RB-REPORT-LIBRARY      The name of the report library */
    R-Report:screen-value,     /* RB-REPORT-NAME         The name of the report  */
    cConnect,                  /* RB-DB-CONNECTION Progress style connection parms "-db sports -N DDE" */
    cInclude,                  /* RB-INCLUDE-RECORDS     S - saved, O - Override, E - Ignore, ? - Prompt  */
    E-Filter:screen-value,     /* RB-FILTER              Filter/Where expression */
    R-Memo:screen-value,       /* RB-MEMO-FILE           Memo file spec. */
    cPrinter,                  /* RB-PRINT-DESTINATION   "D" -Display on Screen, "A" -Ascii File "?" -Prompt " " -Printer */
    R-Printer,                 /* RB-PRINTER-NAME          */
    "",                        /* RB-PRINTER-PORT          */
    R-OutputFile:screen-value, /* RB-OUTPUT-FILE         Output file spec. */
    iCopies,                   /* RB-NUMBER-COPIES       Number of copies to print */
    iBegPage,                  /* RB-BEGIN-PAGE          Begining page number */
    iEndPage,                  /* RB-END-PAGE            Ending page number */
    FALSE,                     /* RB-TEST-PATTERN        */
    R-Report:screen-value      /* RB-WINDOW-TITLE        Title for the report */
    lDispError,                /* RB-DISPLAY-ERRORS      Display Error ? TRUE/FALSE */
    lStatus,                   /* RB-DISPLAY-STATUS      Status ? TRUE/FALSE */
    TRUE,                      /* RB-NOWAIT */
    ""                         /* OTHER-PARAMETERS XXX=YYY~nZZZ=WWW */
   ).
   ============================================================================================== */

DEFINE INPUT PARAMETER P-nom_library AS CHARACTER. /* Librería desde la que se ejecuta */
DEFINE INPUT PARAMETER P-nom_reporte AS CHARACTER. /* Nombre del reporte a ejecutar    */
DEFINE INPUT PARAMETER P-filtro      AS CHARACTER. /* Filtro de registros a imponer    */
DEFINE INPUT PARAMETER P-destino     AS CHARACTER. /* Salida de datos    (ver cPrinter)*/
DEFINE INPUT PARAMETER P-impresora   AS CHARACTER. /* Nombre de la cola de impresion   */
DEFINE INPUT PARAMETER P-parametros  AS CHARACTER. /* Parametros del reporte           */

DEFINE VARIABLE i-base AS INTEGER.

DEFINE VARIABLE E-Filter AS Character 
     VIEW-AS EDITOR NO-WORD-WRAP SCROLLBAR-HORIZONTAL SCROLLBAR-VERTICAL
     SIZE 49.43 BY 2.42.

DEFINE VARIABLE F-NumberCopies AS Integer FORMAT "->>,>>9":U INITIAL 0 
     LABEL "Numero de Copias" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE F-Password AS Character FORMAT "X(256)":U 
     LABEL "Password" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.

DEFINE VARIABLE F-User AS Character FORMAT "X(256)":U 
     LABEL "Usuario" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.

DEFINE VARIABLE R-Database AS Character FORMAT "X(256)":U 
     LABEL "Parms. Conexion" 
     VIEW-AS FILL-IN 
     SIZE 41.72 BY 1.

DEFINE VARIABLE R-Include AS Integer INITIAL 0 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Usar Filtro",1,
          "Especificar Filtro",2,
          "Incluir Todos",3,
          "Requerir",4
          SIZE 23 BY 2.75.

DEFINE VARIABLE R-Library AS Character FORMAT "X(256)":U 
     LABEL "Libreria" 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1.

DEFINE VARIABLE R-Memo AS Character FORMAT "X(256)":U 
     LABEL "Archivo Memo" 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1.

DEFINE VARIABLE R-OutputFile AS Character FORMAT "X(256)":U 
     LABEL "Arhivo" 
     VIEW-AS FILL-IN 
     SIZE 39 BY 1.

DEFINE VARIABLE R-PageBeg AS Integer FORMAT "->>,>>9":U INITIAL 0 
     LABEL "De Pagina" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE R-PageEnd AS Integer FORMAT "->>,>>9":U INITIAL 0 
     LABEL "A Pagina" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1.

DEFINE VARIABLE R-Report AS Character FORMAT "X(256)":U 
     LABEL "Reporte" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","" 
     SIZE 60 BY 1.

DEFINE VARIABLE RS-Printer AS Integer INITIAL 0 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Pantalla",1,
          "Impresora",2,
          "Archivo",3
          SIZE 12 BY 2.25.

DEFINE VARIABLE T-Batch AS Logical INITIAL no 
     LABEL "Mostrar Errores en Pantalla":L 
     VIEW-AS TOGGLE-BOX
     SIZE 31 BY .75.

DEFINE VARIABLE T-Status AS Logical INITIAL no 
     LABEL "Mostrar Dialogo de Printer":L 
     VIEW-AS TOGGLE-BOX
     SIZE 28.57 BY .75.

DEFINE VARIABLE cPrinter   AS CHAR    NO-UNDO.
DEFINE VARIABLE iCopies    AS INTEGER NO-UNDO.
DEFINE VARIABLE iBegPage   AS INTEGER NO-UNDO.
DEFINE VARIABLE iEndPage   AS INTEGER NO-UNDO.
DEFINE VARIABLE lDispError AS LOGICAL NO-UNDO.
DEFINE VARIABLE lStatus    AS LOGICAL NO-UNDO.
DEFINE VARIABLE cInclude   AS CHAR    NO-UNDO.
DEFINE VARIABLE cConnect   AS CHAR    NO-UNDO.
DEFINE VARIABLE par-connec AS CHAR    NO-UNDO.
DEFINE VARIABLE j          AS INTEGER NO-UNDO.
DEFINE VARIABLE R-Printer  AS CHAR    NO-UNDO.

ASSIGN
  cPrinter   = P-destino
  R-Printer  = P-impresora
  iCopies    = 1
  iBegPage   = 1
  iEndPage   = ?
  lDispError = TRUE
  lStatus    = YES
  cInclude   = "?"
      R-Memo = ""
R-OutputFile = ""  .

  /*  Armamos el string de coneccion a la base de datos  */

  REPEAT i-base = 1 TO NUM-DBS:
         RUN ARMAR_CONECCION ( INPUT LDBNAME(i-base),
                               OUTPUT par-connec).
         cConnect  = cConnect + " " + par-connec.
  END.

  if (F-Password > "") then cConnect = cConnect + " -P " + F-Password.
    
ASSIGN

   R-library = P-nom_library
   R-Report  = P-nom_reporte 
   E-Filter  = P-Filtro
   cInclude  = IF E-Filter = "" THEN "S" ELSE "O".
   
  run _printrb.p (
             R-library, 
             R-Report, 
             cConnect,
             cInclude,
             E-Filter,
             R-Memo,
             cPrinter,
             R-Printer, 
             "", 
             R-OutputFile,
             iCopies,
             iBegPage,
             iEndPage,
             FALSE,
             R-Report,
             lDispError,
             lStatus,
             FALSE,
             P-Parametros
             ).

/*===========================================================================================*/
/*                                     PROCEDIMIENTOS                                        */
/*===========================================================================================*/

PROCEDURE ARMAR_CONECCION:

  DEFINE INPUT PARAMETER nombre_base AS CHARACTER.
  DEFINE OUTPUT PARAMETER como_conectar AS CHARACTER.

  DEFINE VARIABLE par-conecc AS CHARACTER.

  par-connec = DBPARAM(nombre_base).
  como_conectar  = "".
  DO j = 1 TO NUM-ENTRIES(par-connec,","):
     como_conectar = como_conectar + ENTRY(j,par-connec) + " ". 
  END.

END PROCEDURE.
