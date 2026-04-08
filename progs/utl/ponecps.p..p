FOR EACH SIC._File WHERE _FILE._Desc BEGINS "TX/" BY _File._File-name:

    DISPLAY _File._File-name.
    /*SUBSTRING(_File._Desc,1,3) = "IMP".*/
