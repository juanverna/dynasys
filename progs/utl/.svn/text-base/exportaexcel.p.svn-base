/*===============================================================================================*/
/*                    EXPORTA LA TABLA TEMPORAL DE VALORES AL EXCEL                              */
/*===============================================================================================*/

/* Cuando esta rutina termina, el Excel queda abierto. Debe cerrarse manualmente                 */

{tmpexcel.i} /* Definicion de la tabla temporal */

/*===============================================================================================*/
/*                                 PARAMETROS                                                    */
/*===============================================================================================*/

DEFINE INPUT PARAMETER ipcTemplate AS CHARACTER.
DEFINE INPUT PARAMETER TABLE FOR ttReprt.

/*===============================================================================================*/
/*                                 VARIABLES                                                     */
/*===============================================================================================*/

DEFINE VARIABLE chExcelApplication      AS COM-HANDLE.
DEFINE VARIABLE chWorkbook              AS COM-HANDLE.
DEFINE VARIABLE chWorksheet             AS COM-HANDLE.

DEFINE VARIABLE ppass AS CHARACTER NO-UNDO initial "".

DEFINE VARIABLE cDirctr AS CHARACTER NO-UNDO.
/*get-key-value section "Instalacion" key "Directorio" value cDirctr. */

DEFINE VARIABLE cColmn AS CHARACTER NO-UNDO.
DEFINE VARIABLE iFil   AS INTEGER NO-UNDO.

{parlocales.i}

/*===============================================================================================*/
/*                                      PROCESO                                                  */
/*===============================================================================================*/

{findempresa.i}

RUN getparametro_o.p ( INPUT "DIRINPLA", OUTPUT v-observacion).
IF v-observacion <> ?
    THEN cDirctr = v-observacion.
    ELSE cDirctr = "c:\sic-temp\".

IF SUBSTRING(cDirctr,LENGTH(cDirctr),1) <> "\"
    THEN cDirctr = cDirctr + "\".

IF SEARCH(cDirctr + ipcTemplate) = ?
THEN DO: 
    MESSAGE cDirctr + ipcTemplate
        VIEW-AS ALERT-BOX ERROR TITLE "Template no encontrado".
    RETURN.
END.

/* create a new Excel Application object */
CREATE "Excel.Application" chExcelApplication.

/* launch Excel so it is visible to the user */
chExcelApplication:Visible = TRUE.

/* create a new Workbook */
chWorkbook = chExcelApplication:Workbooks:Add(cDirctr + ipcTemplate).

/*===============================================================================================*/
/*                                BLOQUE PRINCIPAL                                              */
/*===============================================================================================*/

FIND FIRST ttReprt NO-LOCK NO-ERROR.
IF NOT AVAILABLE ttReprt THEN RETURN.

FOR EACH ttReprt NO-LOCK:

    /*
    MESSAGE 
        "ttValr      :" ttValr         SKIP
        "ttRango     :" ttRango        SKIP
        "ttRangoColm :" ttRangoColm    SKIP
        "ttRangoFila :" ttRangoFila    SKIP
        "ttOper      :" ttOper         SKIP
        "ttSheet     :" ttSheet        SKIP
        "ttOrden     :" ttOrden        SKIP(1)
        VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "Seguimiento de Excel".
   */     
    
 /* get the active Worksheet */
    CASE ttOper:
        WHEN "Valor" 
        THEN DO:
            chWorkSheet = chExcelApplication:Sheets:Item(ttSheet).
            assign chWorkSheet:Range(ttRango):Value = ttValr.
        END.
        
        WHEN "ColorFondo" 
        THEN DO:
            chWorkSheet = chExcelApplication:Sheets:Item(ttSheet).
            assign chWorkSheet:Range(ttRango):Interior:ColorIndex = int(ttValr).
        END.
        
        WHEN "Copy-Insert" 
        THEN DO:
            NO-RETURN-VALUE chWorkSheet:Range(ttRango):EntireRow:Copy.
            NO-RETURN-VALUE chWorkSheet:Range(ttRango):EntireRow:Insert.
        END.
        
        WHEN "Column-Copy-Insert" 
        THEN DO:
            NO-RETURN-VALUE chWorkSheet:Range(ttRango):EntireColumn:Copy.
            NO-RETURN-VALUE chWorkSheet:Range(ttRango):EntireColumn:Insert.
        END.
        
        WHEN "Select-Sheet"
        THEN DO:
            chWorkSheet = chExcelApplication:Sheets:Item(ttSheet).
            chExcelApplication:Sheets(ttValr):Select.
        END.

        WHEN "Select-Range"
        THEN DO:
            chWorkSheet:Range(ttValr):Select().
        END.

        WHEN "Copy-Selection"
        THEN DO:
            chExcelApplication:Selection:Copy.
        END.

        WHEN "Paste"
        THEN DO:
            chWorkSheet:Paste.
        END.

        WHEN "Rename-Sheet" 
        THEN DO:

            MESSAGE "1" ENTRY(1,ttValr,CHR(1)) SKIP
                    "2" ENTRY(2,ttValr,CHR(1))
                VIEW-AS ALERT-BOX INFO BUTTONS OK.

            chExcelApplication:Sheets(ENTRY(1,ttValr,CHR(1))):Select.
            chExcelApplication:Sheets(ENTRY(1,ttValr,CHR(1))):Name = ENTRY(2,ttValr,CHR(1)).
        END.

        WHEN "Delete" 
        THEN DO:
            NO-RETURN-VALUE chWorkSheet:Range(ttRango):EntireRow:Delete.
        END.
        
        WHEN "Quit" 
        THEN DO:
            NO-RETURN-VALUE chExcelApplication:Quit.
        END.
        
        WHEN "Calculate" 
        THEN DO:
           NO-RETURN-VALUE chWorkSheet:Calculate.
        END.
        
        WHEN "SaveAs" 
        THEN DO:
            NO-RETURN-VALUE chWorkbook:SaveAs( ttValr ,/*fileformat*/,/*password*/ ,ppass, FALSE /*ReadOnly*/ , FALSE /*backup*/, FALSE /*agregar a la lista de recientemente utilizados*/,,).
        /*expresión.SaveAs(Filename, FileFormat, Password, WriteResPassword, ReadOnlyRecommended, CreateBackup,
                          AddToMru, TextCodePage, TextVisualLayout)*/
        END.

        WHEN "Protect" 
        THEN DO:
            NO-RETURN-VALUE chWorkSheet:Protect(ppass).
        /*expresión.Protect(Password, DrawingObjects, Contents, Scenarios, UserInterfaceOnly)*/
        END.
        
        WHEN "Password" 
        THEN DO:
           ppass = ttValr.
        END.
        OTHERWISE MESSAGE "Comando no reconocido" ttOper
                VIEW-AS ALERT-BOX ERROR TITLE "Exportaexcel.p".

    END CASE.

END.

chExcelApplication:Visible = TRUE.

/* release com-handles */
RELEASE OBJECT chExcelApplication.      
RELEASE OBJECT chWorkbook.
RELEASE OBJECT chWorksheet.

/*
        WHEN "Karlitos"
        THEN DO:
            chWorkSheet = chExcelApplication:Sheets:Item(2).
            chExcelApplication:Sheets("Modelo"):Select.
            chWorkSheet:Range("A1:AC8"):Select().
            chExcelApplication:Selection:Copy.
            chWorkSheet = chExcelApplication:Sheets:Item(1).
            chExcelApplication:Sheets("Hoja1"):Select.
            chWorkSheet:Range("A1"):Select().
            chWorkSheet:Paste.
            chExcelApplication:Sheets("Hoja1"):Select.
            chExcelApplication:Sheets("Hoja1"):Name = "SIDUS".
        END.

*/
