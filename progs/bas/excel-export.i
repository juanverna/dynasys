&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Include 
/*------------------------------------------------------------------------
    File        : 
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     :
    Notes       :
  ----------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Include
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: INCLUDE-ONLY
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Include ASSIGN
         HEIGHT             = 15
         WIDTH              = 60.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Include 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE excel-export Include 
PROCEDURE excel-export :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*def input parameter p-browse as handle no-undo.
RUN excel-export2( p-browse , 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1').
END PROCEDURE.*/
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   def input parameter p-browse as handle no-undo.
   def var h-excel as com-handle no-undo.
   def var h-book as com-handle no-undo.
   def var h-sheet as com-handle no-undo.
   def var v-item as char no-undo.
   def var v-alpha as char extent 52 no-undo init ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","x","y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","Ax","Ay","AZ"].
   def var i as int no-undo.
   def var v-line as int no-undo.
   def var v-qu as log no-undo.
   def var v-handle as handle no-undo.
   DEF VAR opt AS LOGICAL NO-UNDO.
   v-qu = session:set-wait-state("General").
   CREATE "Excel.Application" h-Excel.
   h-book = h-Excel:Workbooks:Add().
   h-Sheet = h-Excel:Sheets:Item(1).
   
   do i = 1 to p-browse:num-columns:
      v-handle = p-browse:get-browse-column(i).
      v-item = v-alpha[i] + "1".
      h-sheet:range(v-item):value = v-handle:label.
   end.
   v-line = 1.
   sacar_excel:
   repeat:
      READKEY PAUSE 0.
      IF LASTKEY = 27 THEN DO:
          MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
          IF opt THEN DO:
              LEAVE sacar_excel.
          END.
              
      END.
      if v-line = 1 then 
         v-qu = p-browse:select-row(1).
      else v-qu = p-browse:select-next-row().
      if v-qu = no then leave.
      v-line = v-line + 1.
      do i = 1 to p-browse:num-columns:
          READKEY PAUSE 0.
          IF LASTKEY = 27 THEN DO:
              MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
              IF opt THEN DO:
                  LEAVE sacar_excel.
              END.
          END.
         v-handle = p-browse:get-browse-column(i).
         v-item = v-alpha[i] + string(v-line).
         if v-handle:data-type begins "dec" then assign
            h-sheet:range(v-item):value = dec(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0.00"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         else if v-handle:data-type begins "int" then assign
            h-sheet:range(v-item):value = int(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         ELSE IF v-handle:data-type begins "date" then assign 
            h-sheet:range(v-item):value = substring(v-handle:screen-value,4,2) + "/" + substring(v-handle:screen-value,1,2) + "/" + substring(v-handle:screen-value,7,4).
            
         else h-sheet:range(v-item):value = v-handle:screen-value.
end.
   end.

   do i = 1 to p-browse:num-columns:
      v-qu = h-sheet:Columns(i):AutoFit.
   end.
   h-excel:visible = yes.
   release object h-sheet no-error.
   release object h-book no-error.
   release object h-excel no-error.
   v-qu = session:set-wait-state("").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE excel-export-ori Include 
PROCEDURE excel-export-ori :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   def input parameter p-browse as handle no-undo.
   def var h-excel as com-handle no-undo.
   def var h-book as com-handle no-undo.
   def var h-sheet as com-handle no-undo.
   def var v-item as char no-undo.
   def var v-alpha as char extent 52 no-undo init ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","x","y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","Ax","Ay","AZ"].
   def var i as int no-undo.
   def var v-line as int no-undo.
   def var v-qu as log no-undo.
   def var v-handle as handle no-undo.
   DEF VAR opt AS LOGICAL NO-UNDO.
   v-qu = session:set-wait-state("General").
   CREATE "Excel.Application" h-Excel.
   h-book = h-Excel:Workbooks:Add().
   h-Sheet = h-Excel:Sheets:Item(1).
   
   do i = 1 to p-browse:num-columns:
      v-handle = p-browse:get-browse-column(i).
      v-item = v-alpha[i] + "1".
      h-sheet:range(v-item):value = v-handle:label.
   end.
   v-line = 1.
   sacar_excel:
   repeat:
      READKEY PAUSE 0.
      IF LASTKEY = 27 THEN DO:
          MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
          IF opt THEN DO:
              LEAVE sacar_excel.
          END.
              
      END.
      if v-line = 1 then 
         v-qu = p-browse:select-row(1).
      else v-qu = p-browse:select-next-row().
      if v-qu = no then leave.
      v-line = v-line + 1.
      do i = 1 to p-browse:num-columns:
          READKEY PAUSE 0.
          IF LASTKEY = 27 THEN DO:
              MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
              IF opt THEN DO:
                  LEAVE sacar_excel.
              END.
          END.
         v-handle = p-browse:get-browse-column(i).
         v-item = v-alpha[i] + string(v-line).
         if v-handle:data-type begins "dec" then assign
            h-sheet:range(v-item):value = dec(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0.00"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         else if v-handle:data-type begins "int" then assign
            h-sheet:range(v-item):value = int(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         ELSE IF v-handle:data-type begins "date" then assign 
            h-sheet:range(v-item):value = substring(v-handle:screen-value,4,2) + "/" + substring(v-handle:screen-value,1,2) + "/" + substring(v-handle:screen-value,7,4).
            
         else h-sheet:range(v-item):value = v-handle:screen-value.
end.
   end.

   do i = 1 to p-browse:num-columns:
      v-qu = h-sheet:Columns(i):AutoFit.
   end.
   h-excel:visible = yes.
   release object h-sheet no-error.
   release object h-book no-error.
   release object h-excel no-error.
   v-qu = session:set-wait-state("").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE excel-export2 Include 
PROCEDURE excel-export2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1'  
------------------------------------------------------------------------------*/

   def input parameter p-browse as handle no-undo.
   DEFINE INPUT PARAMETER picProperties     AS CHARACTER                 NO-UNDO.
   def var h-excel as com-handle no-undo.
   def var h-book as com-handle no-undo.
   def var h-sheet as com-handle no-undo.
   def var v-item as char no-undo.
   def var v-alpha as char extent 52 no-undo init ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","x","y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","Ax","Ay","AZ"].
   def var i as int no-undo.
   def var v-line as int no-undo.
   def var v-qu as log no-undo.
   def var v-handle as handle no-undo.
   DEF VAR opt AS LOGICAL NO-UNDO.
   v-qu = session:set-wait-state("General").
   CREATE "Excel.Application" h-Excel.
   h-book = h-Excel:Workbooks:Add().
   h-Sheet = h-Excel:Sheets:Item(1).
   
 DEFINE VARIABLE iPropNo                  AS INTEGER                   NO-UNDO.
 DEFINE VARIABLE cPropEntry               AS CHARACTER                 NO-UNDO.
 DEFINE VARIABLE iPos                     AS INTEGER                   NO-UNDO.
DEFINE VARIABLE cPropName                AS CHARACTER                 NO-UNDO.
 DEFINE VARIABLE cPropValue               AS CHARACTER                 NO-UNDO.
 DEFINE VARIABLE cFontName                AS CHARACTER                 NO-UNDO.
 DEFINE VARIABLE iFontSize                AS INTEGER                   NO-UNDO.

   
  /*--- set the excel properties ---*/
  DO iPropNo = 1 TO NUM-ENTRIES(picProperties, '|'):

    ASSIGN
      cPropEntry = ENTRY(iPropNo, picProperties, '|')
      iPos       = INDEX(cPropEntry, '=')
      cPropName  = SUBSTRING(cPropEntry, 1, iPos - 1)
      cPropValue = IF iPos > 0 THEN SUBSTRING(cPropEntry, iPos + 1) ELSE ''.

    CASE cPropName:
      WHEN 'Font:Name' THEN ASSIGN cFontName = cPropValue.
      WHEN 'Font:Size' THEN ASSIGN iFontSize = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:Orientation' THEN
        h-sheet:PageSetup:Orientation = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:Zoom' THEN
        h-sheet:PageSetup:Zoom = cPropValue.
      WHEN 'PageSetup:PrintGridlines' THEN
        h-sheet:PageSetup:PrintGridlines = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:PrintTitleRows' THEN
        h-sheet:PageSetup:PrintTitleRows = cPropValue.
      WHEN 'PageSetup:PrintTitleColumns' THEN
        h-sheet:PageSetup:PrintTitleColumns = cPropValue.
      WHEN 'PageSetup:LeftHeader' THEN
        h-sheet:PageSetup:LeftHeader = cPropValue.
      WHEN 'PageSetup:CenterHeader' THEN
        h-sheet:PageSetup:CenterHeader = cPropValue.
      WHEN 'PageSetup:RightHeader' THEN
        h-sheet:PageSetup:RightHeader = cPropValue.
      WHEN 'PageSetup:LeftFooter' THEN
        h-sheet:PageSetup:LeftFooter = cPropValue.
      WHEN 'PageSetup:CenterFooter' THEN
        h-sheet:PageSetup:CenterFooter = cPropValue.
      WHEN 'PageSetup:RightFooter' THEN
        h-sheet:PageSetup:RightFooter = cPropValue.
      WHEN 'PageSetup:CenterHorizontally' THEN
        h-sheet:PageSetup:CenterHorizontally = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:CenterVertically' THEN
        h-sheet:PageSetup:CenterVertically = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:FitToPagesWide' THEN
        h-sheet:PageSetup:FitToPagesWide = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:FitToPagesTall' THEN
        h-sheet:PageSetup:FitToPagesTall = INTEGER(cPropValue) NO-ERROR.
      WHEN 'Visible' THEN
        h-sheet:Visible = CAN-DO('YES,TRUE,Y,T',cPropValue).
    END CASE. /* cPropName */

  END. /* DO iPropNo = 1 TO NUM-ENTRIES(picProperties): */

  IF cFontName = '' THEN
    ASSIGN cFontName = "Arial Narrow".

  h-sheet:Rows("1:1"):Font:Bold = TRUE.
  h-sheet:Rows("2:2"):Activate.
  h-excel:ActiveWindow:FreezePanes = TRUE.

   do i = 1 to p-browse:num-columns:
      v-handle = p-browse:get-browse-column(i).
      v-item = v-alpha[i] + "1".
      h-sheet:range(v-item):value = v-handle:label.
    h-sheet:Range(v-item):Value = v-handle:BUFFER-FIELD(i):LABEL.
    h-sheet:Columns(v-alpha[i]):Font:Name = cFontName.
    IF iFontSize > 0 THEN
      h-sheet:Columns(v-alpha[i]):Font:Size = iFontSize.
    IF v-handle:BUFFER-FIELD(i):DATA-TYPE = "DECIMAL" THEN
      h-sheet:Columns(v-alpha[i]):Cells:NumberFormat = "######0,00".
    ELSE IF v-handle:BUFFER-FIELD(i):DATA-TYPE = "CHARACTER" THEN
      h-sheet:Columns(v-alpha[i]):Cells:NumberFormat = "@".
   end.
   v-line = 1.
   sacar_excel:
   repeat:
      READKEY PAUSE 0.
      IF LASTKEY = 27 THEN DO:
          MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
          IF opt THEN DO:
              LEAVE sacar_excel.
          END.
              
      END.
      if v-line = 1 then 
         v-qu = p-browse:select-row(1).
      else v-qu = p-browse:select-next-row().
      if v-qu = no then leave.
      v-line = v-line + 1.
      do i = 1 to p-browse:num-columns:
          READKEY PAUSE 0.
          IF LASTKEY = 27 THEN DO:
              MESSAGE "Quiere cancelar la emision del excel" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO SET opt.
              IF opt THEN DO:
                  LEAVE sacar_excel.
              END.
          END.
         v-handle = p-browse:get-browse-column(i).
         v-item = v-alpha[i] + string(v-line).
         if v-handle:data-type begins "dec" then assign
            h-sheet:range(v-item):value = dec(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0.00"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         else if v-handle:data-type begins "int" then assign
            h-sheet:range(v-item):value = int(v-handle:screen-value)
            h-sheet:range(v-item):Numberformat = "########0"
            h-sheet:range(v-item):HorizontalAlignment = -4152.
         ELSE IF v-handle:data-type begins "date" then assign 
            h-sheet:range(v-item):value = substring(v-handle:screen-value,4,2) + "/" + substring(v-handle:screen-value,1,2) + "/" + substring(v-handle:screen-value,7,4).
            
         else h-sheet:range(v-item):value = v-handle:screen-value.
end.
   end.

   do i = 1 to p-browse:num-columns:
      v-qu = h-sheet:Columns(i):AutoFit.
   end.
   h-excel:visible = yes.
   release object h-sheet no-error.
   release object h-book no-error.
   release object h-excel no-error.
   v-qu = session:set-wait-state("").
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE tt2xls Include 
PROCEDURE tt2xls :
/*------------------------------------------------------------------------------
Purpose: Create a new Excel File based on a Static Temp-Table
Notes  : picProperties parameter is name-value-pair with pipe '|' delimiter
------------------------------------------------------------------------------*/

  /*--- parameter definitions ---*/
  DEFINE INPUT PARAMETER pihTT             AS HANDLE                    NO-UNDO.
  DEFINE INPUT PARAMETER picExcelFileName  AS CHARACTER                 NO-UNDO.
  DEFINE INPUT PARAMETER picProperties     AS CHARACTER                 NO-UNDO.

  /*--- local variable definitions ---*/
  DEFINE VARIABLE cColList                 AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cRange                   AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cRow                     AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cPropEntry               AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cPropName                AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cPropValue               AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE cFontName                AS CHARACTER                 NO-UNDO.
  DEFINE VARIABLE chExcelApplication       AS COM-HANDLE                NO-UNDO.
  DEFINE VARIABLE chWorkbook               AS COM-HANDLE                NO-UNDO.
  DEFINE VARIABLE chWorkSheet              AS COM-HANDLE                NO-UNDO.
  DEFINE VARIABLE hqTT                     AS HANDLE                    NO-UNDO.
  DEFINE VARIABLE iRow                     AS INTEGER                   NO-UNDO.
  DEFINE VARIABLE iCol                     AS INTEGER                   NO-UNDO.
  DEFINE VARIABLE iPropNo                  AS INTEGER                   NO-UNDO.
  DEFINE VARIABLE iPos                     AS INTEGER                   NO-UNDO.
  DEFINE VARIABLE iFontSize                AS INTEGER                   NO-UNDO.

  /*--- validations ---*/
  IF NOT VALID-HANDLE(pihTT) THEN
    RETURN.

  /*--- create a new excel file ---*/
  CREATE "Excel.Application" chExcelApplication.
  chExcelApplication:Visible = FALSE.
  chWorkbook = chExcelApplication:Workbooks:Add().
  chWorkSheet = chExcelApplication:Sheets:Item(1).
  chWorkSheet:Name = pihTT:NAME.


  /*--- set the excel properties ---*/
  DO iPropNo = 1 TO NUM-ENTRIES(picProperties, '|'):

    ASSIGN
      cPropEntry = ENTRY(iPropNo, picProperties, '|')
      iPos       = INDEX(cPropEntry, '=')
      cPropName  = SUBSTRING(cPropEntry, 1, iPos - 1)
      cPropValue = IF iPos > 0 THEN SUBSTRING(cPropEntry, iPos + 1) ELSE ''.

    CASE cPropName:
      WHEN 'Font:Name' THEN ASSIGN cFontName = cPropValue.
      WHEN 'Font:Size' THEN ASSIGN iFontSize = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:Orientation' THEN
        chWorkSheet:PageSetup:Orientation = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:Zoom' THEN
        chWorkSheet:PageSetup:Zoom = cPropValue.
      WHEN 'PageSetup:PrintGridlines' THEN
        chWorkSheet:PageSetup:PrintGridlines = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:PrintTitleRows' THEN
        chWorkSheet:PageSetup:PrintTitleRows = cPropValue.
      WHEN 'PageSetup:PrintTitleColumns' THEN
        chWorkSheet:PageSetup:PrintTitleColumns = cPropValue.
      WHEN 'PageSetup:LeftHeader' THEN
        chWorkSheet:PageSetup:LeftHeader = cPropValue.
      WHEN 'PageSetup:CenterHeader' THEN
        chWorkSheet:PageSetup:CenterHeader = cPropValue.
      WHEN 'PageSetup:RightHeader' THEN
        chWorkSheet:PageSetup:RightHeader = cPropValue.
      WHEN 'PageSetup:LeftFooter' THEN
        chWorkSheet:PageSetup:LeftFooter = cPropValue.
      WHEN 'PageSetup:CenterFooter' THEN
        chWorkSheet:PageSetup:CenterFooter = cPropValue.
      WHEN 'PageSetup:RightFooter' THEN
        chWorkSheet:PageSetup:RightFooter = cPropValue.
      WHEN 'PageSetup:CenterHorizontally' THEN
        chWorkSheet:PageSetup:CenterHorizontally = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:CenterVertically' THEN
        chWorkSheet:PageSetup:CenterVertically = CAN-DO('YES,TRUE,Y,T',cPropValue).
      WHEN 'PageSetup:FitToPagesWide' THEN
        chWorkSheet:PageSetup:FitToPagesWide = INTEGER(cPropValue) NO-ERROR.
      WHEN 'PageSetup:FitToPagesTall' THEN
        chWorkSheet:PageSetup:FitToPagesTall = INTEGER(cPropValue) NO-ERROR.
      WHEN 'Visible' THEN
        chExcelApplication:Visible = CAN-DO('YES,TRUE,Y,T',cPropValue).
    END CASE. /* cPropName */

  END. /* DO iPropNo = 1 TO NUM-ENTRIES(picProperties): */

  IF cFontName = '' THEN
    ASSIGN cFontName = "Arial Narrow".

  
  /*--- set the column attributes for the Worksheet ---*/
  ASSIGN cColList = 'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'
                  + ',AA,AB,AC,AD,AE,AF,AG,AH,AI,AJ,AK,AL,AM'
                  + ',AN,AO,AP,AQ,AR,AS,AT,AU,AV,AW,AX,AY,AZ'
                  + ',BA,BB,BC,BD,BE,BF,BG,BH,BI,BJ,BK,BL,BM'
                  + ',BN,BO,BP,BQ,BR,BS,BT,BU,BV,BW,BX,BY,BZ'
                  + ',CA,CB,CC,CD,CE,CF,CG,CH,CI,CJ,CK,CL,CM'
                  + ',CN,CO,CP,CQ,CR,CS,CT,CU,CV,CW,CX,CY,CZ'
                  + ',DA,DB,DC,DD,DE,DF,DG,DH,DI,DJ,DK,DL,DM'
                  + ',DN,DO,DP,DQ,DR,DS,DT,DU,DV,DW,DX,DY,DZ'
                  + ',EA,EB,EC,ED,EE,EF,EG,EH,EI,EJ,EK,EL,EM'
                  + ',EN,EO,EP,EQ,ER,ES,ET,EU,EV,EW,EX,EY,EZ'
                  + ',FA,FB,FC,FD,FE,FF,FG,FH,FI,FJ,FK,FL,FM'
                  + ',FN,FO,FP,FQ,FR,FS,FT,FU,FV,FW,FX,FY,FZ'
                  + ',GA,GB,GC,GD,GE,GF,GG,GH,GI,GJ,GK,GL,GM'
                  + ',GN,GO,GP,GQ,GR,GS,GT,GU,GV,GW,GX,GY,GZ'.
             
  chWorkSheet:Rows("1:1"):Font:Bold = TRUE.
  chWorkSheet:Rows("2:2"):Activate.
  chExcelApplication:ActiveWindow:FreezePanes = TRUE.

  DO iCol = 1 TO pihTT:NUM-FIELDS:
    chWorkSheet:Range(ENTRY(iCol,cColList) + "1"):Value = pihTT:BUFFER-FIELD(iCol):LABEL.
    chWorkSheet:Columns(ENTRY(iCol,cColList)):Font:Name = cFontName.
    IF iFontSize > 0 THEN
      chWorkSheet:Columns(ENTRY(iCol,cColList)):Font:Size = iFontSize.
    IF pihTT:BUFFER-FIELD(iCol):DATA-TYPE = "DECIMAL" THEN
      chWorkSheet:Columns(ENTRY(iCol,cColList)):Cells:NumberFormat = "######0,00".
    ELSE IF pihTT:BUFFER-FIELD(iCol):DATA-TYPE = "CHARACTER" THEN
      chWorkSheet:Columns(ENTRY(iCol,cColList)):Cells:NumberFormat = "@".
  END. /* DO iCol = 1 TO pihTT:NUM-FIELDS: */


  /*--- set the query ---*/
  CREATE QUERY hqTT.
  hqTT:SET-BUFFERS(pihTT).
  hqTT:QUERY-PREPARE("FOR EACH " + pihTT:NAME).
  hqTT:QUERY-OPEN.

  ASSIGN iRow = 1.
  REPEAT:
    hqTT:GET-NEXT.
    IF hqTT:QUERY-OFF-END THEN LEAVE.
    ASSIGN iRow = iRow + 1
           cRow = STRING(iRow).
    DO iCol = 1 TO pihTT:NUM-FIELDS:
      chWorkSheet:Range(ENTRY(iCol,cColList) + cRow):Value = pihTT:BUFFER-FIELD(iCol):BUFFER-VALUE.
    END.
  END. /* REPEAT: */

  hqTT:QUERY-CLOSE.
  DELETE OBJECT hqTT.


  /*--- set the column width automatically ---*/
  DO iCol = 1 TO pihTT:NUM-FIELDS:
    chWorkSheet:Columns(ENTRY(iCol,cColList)):AutoFit().
  END. /* DO iCol = 1 TO pihTT:NUM-FIELDS: */


  /*--- save the result file in excel format ---*/
  IF picExcelFileName > '' THEN DO:
    chWorkBook:SaveCopyAs(picExcelFileName).
    chWorkBook:Close(NO).
    chExcelApplication:Quit().
  END.

  RELEASE OBJECT chExcelApplication NO-ERROR.
  RELEASE OBJECT chWorkbook NO-ERROR.
  RELEASE OBJECT chWorksheet NO-ERROR.


END PROCEDURE. /* pTT2XLS */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

