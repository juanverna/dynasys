FOR EACH Opg_header 
    WHERE Opg_header.fecha = TODAY - 1 AND Opg_header.tip_comprob = "OP",
          Proveedor OF Opg_header, 
          EACH Caj_detalle WHERE Caj_detalle.nro_transaccion = Opg_header.nro_transaccion,
          Rubro OF Caj_detalle
          BREAK BY Opg_header.nro_comprob:

    DISPLAY Opg_header.tip_comprob WHEN FIRST-OF(Opg_header.nro_comprob)
            Opg_header.nro_comprob WHEN FIRST-OF(Opg_header.nro_comprob)
            Proveedor.nombre       WHEN FIRST-OF(Opg_header.nro_comprob)
            Rubro.abrevia 
            Caj_detalle.importe
            WITH FONT 2 USE-TEXT.
    IF LAST-OF(Opg_header.nro_comprob)
    THEN DO:
        UNDERLINE Opg_header.tip_comprob WHEN FIRST-OF(Opg_header.nro_comprob)
                  Opg_header.nro_comprob WHEN FIRST-OF(Opg_header.nro_comprob)
                  Proveedor.nombre       WHEN FIRST-OF(Opg_header.nro_comprob)
                  Rubro.abrevia 
                  Caj_detalle.importe
                  WITH FONT 2 USE-TEXT.
    
       DISPLAY Opg_header.imp_total @  Caj_detalle.importe.
       DOWN 2.
   END.
END.       
