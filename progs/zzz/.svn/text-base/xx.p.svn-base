{xprint.i}

    DEFINE VARIABLE justi AS CHARACTER.
    DEFINE VARIABLE justi2 AS CHARACTER.

    OUTPUT TO "c:\sic-temp\prunumero.xpr".

    PUT UNFORMATTED "<PREVIEW=70>".

    PUT UNFORMATTED "<OPORTRAIT><Title=Impresion de facturas><UNITS=mm><|2>".
    PUT UNFORMATTED "<FORMAT=Letter>".
    PUT UNFORMATTED "<AT=14,18><#1>".

    justi = RightJustify(TRIM("131234.11"), 'CourierNew,12', 2.0).
    /*RUN  pasamilimetros ( INPUT-OUTPUT justi ).*/
    /*PUT UNFORMATTED "<=#1><AT=+10,+10>" +  justi.*/
    PUT UNFORMATTED "<=#1><AT=+10,+90><DECIMAL=+0>" + STRING(32569847.12).
    
    justi2 = RightJustify(TRIM("8.56"), 'CourierNew,12', 2.0).
    /*RUN  pasamilimetros ( INPUT-OUTPUT justi2 ).*/
    /*MESSAGE justi justi2  
        VIEW-AS ALERT-BOX INFO BUTTONS OK.
    PUT UNFORMATTED "<=#1><AT=+14,+10>" +  justi2.*/
    PUT UNFORMATTED "<=#1><AT=+14,+90><DECIMAL=+0>" + STRING(8.98).

    /*PUT UNFORMATTED "<=#1>" +  RightJustify(TRIM("131234.56"), 'CourierNew,12', 1.0).*/

    OUTPUT CLOSE .

    FILE-INFO:File-NAME = "c:\sic-temp\prunumero.xpr".
    
    RUN printFile( FILE-INFO:FULL-PATHNAME).

PROCEDURE pasamilimetros:

    DEFINE INPUT-OUTPUT PARAMETER p-ajuste     AS CHARACTER.

    DEFINE VARIABLE i-pos-punto  AS INTEGER.
    DEFINE VARIABLE i-pos-cierre AS INTEGER.
    
    DEFINE VARIABLE c-desplaza   AS CHARACTER.
    DEFINE VARIABLE d-desplaza   AS DECIMAL DECIMALS 10.
    
    i-pos-punto = INDEX(p-ajuste,".").
    i-pos-cierre = INDEX(p-ajuste,">").
    c-desplaza = SUBSTRING(p-ajuste,i-pos-punto , i-pos-cierre - i-pos-punto ).
    d-desplaza = DECIMAL(c-desplaza) * 25.4.
    p-ajuste = REPLACE(p-ajuste,c-desplaza,STRING(d-desplaza)).

END PROCEDURE
