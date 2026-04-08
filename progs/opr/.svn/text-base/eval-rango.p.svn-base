/*evaluador de v-crango.w*/
/*se utilizarara como evaluador logico si cumple devuelve 1 sino 0 */
define input parameter nroE as int no-undo.
DEFINE INPUT PARAMETER fecha AS DATE NO-UNDO.
DEFINE INPUT PARAMETER ss AS character NO-UNDO.
DEFINE OUTPUT PARAMETER v AS DECIMAL NO-UNDO.
DEFINE OUTPUT PARAMETER esdesborde AS LOGICAL NO-UNDO.
DEFINE OUTPUT PARAMETER vmobs AS CHAR NO-UNDO.
DEFINE VAR I AS INT NO-UNDO.
DEFINE VAR j AS INT NO-UNDO.
i = DAY(fecha).


v = int( i >= int( ENTRY( 1 , ss , "|" )) AND i <= int( ENTRY( 2 , ss , "|" ))).
/*es desborde es un decreciente para ambos lados del rango*/
IF v <> 1 THEN DO:
        esdesborde = TRUE.
        IF i < int( ENTRY( 1 , ss , "|" )) THEN DO:
            j = int( ENTRY( 1 , ss , "|" )) - i.
            IF  j <= 5 THEN do: 
                v  = 1.00 - DECIMAL( j ) * 0.20.
                vmobs = "DRG[" + ss + "<->" + string( - j , "-99" ) + "]".
            END.
        END.
        IF i > int( ENTRY( 2 , ss , "|" )) THEN DO:
            j = i - int( ENTRY( 2 , ss , "|" )).
            IF  j <= 5 THEN do:
               v  = 1.00 - DECIMAL( j ) * 0.20.
               vmobs = "DRG[" + ss + "<->" + string( j , "99" ) + "]".
            END.
        END.            
        
    END.
ELSE esdesborde = FALSE.
