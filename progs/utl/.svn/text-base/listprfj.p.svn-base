DEFINE VARIABLE ch AS CHAR FORMAT "X(12)".
FORM 
   _File._file-name 
   _File._Desc 
   WITH FONT 8 USE-TEXT NO-LABELS FRAME a DOWN WIDTH 120.

OUTPUT TO "A" PAGE-SIZE 0.
FOR EACH _File WHERE NOT _File._file-name BEGINS "_" BY  _File._Desc WITH FRAME a:
    DISPLAY _File._file-name _File._Desc .
    DOWN.
END.          
OUTPUT CLOSE.
