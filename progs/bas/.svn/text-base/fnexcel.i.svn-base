/*=================================================================================*/
/*            FUNCIONES Y VARIABLES PARA EXPORTACION A EXCEL                       */
/*=================================================================================*/

{tmpexcel.i} /* Definicion de la tabla temporal para exportar datos a Excel */

DEFINE VARIABLE orden AS INTEGER NO-UNDO INITIAL 0.

FUNCTION axcol RETURNS CHARACTER ( INPUT i-fila AS INTEGER, INPUT i-columna AS INTEGER ).
    DEFINE VARIABLE aux AS CHARACTER.

    IF i-columna <> 0 
    THEN DO:
        IF 64 + i-columna <= ASC("Z")
            THEN aux = CHR( 64 + i-columna ). 
            ELSE aux = "A" + CHR( 64 + i-columna - ( ASC("Z") - 64 )). 
    END.
    ELSE DO: 
        aux = "".
    END.
    aux = aux + STRING(i-fila).

    RETURN aux.

END FUNCTION.  

FUNCTION ax RETURNS INTEGER (INPUT Valr AS CHARACTER, RangoFila AS INTEGER, RangoColm AS INTEGER, Sheet AS INTEGER,Oper AS CHARACTER).
    orden = orden + 1.
    CREATE ttReprt.
    ASSIGN 
        ttValr = Valr
        ttRango     = axcol(RangoFila,RangoColm)
        ttRangoColm = RangoColm
        ttRangoFila = RangoFila
        ttSheet = Sheet
        ttOper = Oper
        ttorden = orden.
    RETURN ?.
END FUNCTION.  

FUNCTION Nom2Num RETURNS INTEGER (INPUT p-nombre_columna AS CHARACTER).

    FIND ttDefcolumnas WHERE ttDefcolumnas.ttnombre_columna = p-nombre_columna NO-ERROR.
    IF AVAILABLE ttDefcolumnas
    THEN DO:
        RETURN ttDefcolumnas.ttnumero_columna.
    END.
    ELSE DO:
        MESSAGE "No hallada la columna con label" p-nombre_columna
            VIEW-AS ALERT-BOX INFO TITLE "fnexcel.i".
        RETURN 20.
    END.
        

END FUNCTION.  


