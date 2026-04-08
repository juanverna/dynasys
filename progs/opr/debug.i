DO:
DEFINE VARIABLE debug AS LOGICAL.
/*debug = DEBUGGER:INITIATE().
        debug = DEBUGGER:SET-BREAK(). */
IF USERID("sic") = "" OR  USERID("sic") = "fernando" OR  USERID("sic") = "ferver" THEN
    DO:
        debug = DEBUGGER:INITIATE().
        debug = DEBUGGER:SET-BREAK().
    END.
END.
