DEF VAR c AS INT.
FOR EACH _Field, FIRST _File OF _Field WHERE NOT ( _File._File-name BEGINS "_" OR _File._File-name BEGINS "SYS" ):
    c = c + 1.
END.
DISPLAY c.
