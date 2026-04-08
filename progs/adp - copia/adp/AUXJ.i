            IF j > nt_cols 
            THEN DO:
               display empleado.nro_legajo
                       novedad.cdg_novedad
                       sel_codigos format "x(30)"
                       parte.valor
                       j
                       with 1 column side-labels three-d frame aaa
                 view-as dialog-box title "error de columna".
               enable all with frame aaa.
               wait-for f2 of frame aaa.
            end.