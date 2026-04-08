DEFINE VAR token AS CHAR FORMAT "X(40)" NO-UNDO.
DEFINE VAR sign AS CHAR FORMAT "X(40)"  no-undo.
{VRSHARED.I NEW}

RUN faceletoken.p ("0064", OUTPUT token, OUTPUT sign).
DISPLAY token sign.
 
