  /* Additional fields beyond the data fields which are a standard part of
     the RowObject Temp-Table definition. Included into data.i and into
     all browsers and other objects which use the Temp-Table definition. */

   FIELD RowNum   AS INTEGER
   FIELD RowIdent AS CHARACTER
   FIELD RowMod   AS CHARACTER INIT "":U    
   INDEX RowNum   IS PRIMARY RowNum /* Not UNIQUE because copied for pre-mod */
   INDEX RowMod   RowMod
   INDEX RowIdent RowIdent
   {&rowobjindex}

