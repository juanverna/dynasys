DEFINE VARIABLE resultado AS INTEGER.

PROCEDURE FindWindowA EXTERNAL "user32.dll":
    DEFINE INPUT PARAMETER lpClassName AS CHARACTER.
    DEFINE INPUT PARAMETER lpWindowName AS CHARACTER.
    DEFINE RETURN PARAMETER resultado AS LONG.
END PROCEDURE.    

RUN FindWindowA("ProMainWin", "Progress", OUTPUT resultado ).
DISPLAY Resultado.
