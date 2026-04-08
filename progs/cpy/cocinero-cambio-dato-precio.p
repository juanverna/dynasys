
/* cambia precio dato-precio */
/*OUTPUT TO c:\temp\dato-precio.d.
FOR EACH dato-precio:
EXPORT dato-precio.
        end.
        OUTPUT CLOSE.
        end.*/
FOR EACH dato-precio:
    DELETE dato-precio.
END.

INPUT FROM c:\temp\dato-precio.d NO-ECHO.
REPEAT:
    INSERT dato-precio.
    IMPORT dato-precio .
END.
        
DEFINE VAR r AS INt.
DEFINE VAR tt AS DECIMAL.
DEFINE VAR p AS char  INITIAL
    "880,1060,755,910,695,840,660,550,650,780,640,770,625,750,460,560,380,460,275,330,185,215,165,195,115,140,90,110".

REPEAT r = 1 TO NUM-ENTRIES( p ) BY 2:
    tt = DECIMAL( ENTRY( r  ,p)).
    DISPLAY tt.
    FOR EACH dato-precio :
            IF dato-precio.PrecioCli = tt THEN dato-precio.PrecioCli = DECIMAL( ENTRY( r + 1 ,p)).
            IF dato-precio.PrecioNor = tt THEN dato-precio.PrecioNor = DECIMAL( ENTRY( r + 1 ,p)).
            IF dato-precio.PrecioUrg = tt THEN dato-precio.PrecioUrg = DECIMAL( ENTRY( r + 1 ,p)).
            IF dato-precio.ptramo = tt THEN dato-precio.ptramo = DECIMAL( ENTRY( r + 1 ,p)).
    END.
END.
