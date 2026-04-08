/*============================================================================================*/
/*                MUESTRA LOS PARAMETROS DE CONEXION DE LA/LAS BASE/S ACTUAL/ES               */
/*============================================================================================*/


DEFINE VARIABLE i-base AS INTEGER.
DEFINE VARIABLE cConnect   AS CHAR    NO-UNDO.
DEFINE VARIABLE par-connec AS CHAR    NO-UNDO FORMAT "X(70)".
DEFINE VARIABLE lista AS CHARACTER VIEW-AS SELECTION-LIST INNER-CHARS 70 INNER-LINES 15.
DEFINE VARIABLE x     AS CHARACTER VIEW-AS EDITOR SIZE 60 BY 5.
DEFINE VARIABLE j     AS INTEGER.
DEFINE VARIABLE ok    AS LOGICAL.

FORM
 lista FGCOLOR 0 BGCOLOR 15 NO-LABEL
 WITH FRAME a NO-LABEL THREE-D TITLE "Parametros de Conección... Oprima F2 para continuar"
 VIEW-AS DIALOG-BOX.

REPEAT i-base = 1 TO NUM-DBS:
         RUN ARMAR_CONECCION ( INPUT LDBNAME(i-base),
                               OUTPUT par-connec).
         ok = lista:ADD-LAST(par-connec).
END.

lista:DELIMITER = ",".
DISPLAY lista WITH FRAME a.
ENABLE lista WITH FRAME a. 
WAIT-FOR F2 OF FRAME a.
HIDE FRAME a NO-PAUSE. 

PROCEDURE ARMAR_CONECCION:

  DEFINE INPUT PARAMETER nombre_base AS CHARACTER.
  DEFINE OUTPUT PARAMETER como_conectar AS CHARACTER.

  DEFINE VARIABLE par-conecc AS CHARACTER.
  DEFINE VARIABLE j          AS INTEGER.

  par-connec = DBPARAM(nombre_base).
  como_conectar  = "".
  DO j = 1 TO NUM-ENTRIES(par-connec,","):
     como_conectar = como_conectar + ENTRY(j,par-connec) + ",". 
  END.

END PROCEDURE.
