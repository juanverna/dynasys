/*=================================================================================*/
/*                REPORTA LAS DESCRIPCIONES DE CADA TABLA POR MODULO               */
/*=================================================================================*/

DEFINE VARIABLE que_archivo AS CHARACTER.
que_archivo = "c:\sic-temp\lisdstab.txt".

OUTPUT TO  VALUE(que_archivo) PAGED.
FOR EACH SIC._File WHERE NOT _FILE._File-Name BEGINS "_" AND NOT _FILE._File-Name BEGINS "SYS" BY _File._Desc:
    DISPLAY _FILE._File-Name _File._Desc 
            WITH FONT 8 USE-TEXT width 132 STREAM-IO.
END.    
OUTPUT CLOSE.
RUN veresult.w ( INPUT "c:\sic-temp\lisdstab.txt", INPUT 22 ).

