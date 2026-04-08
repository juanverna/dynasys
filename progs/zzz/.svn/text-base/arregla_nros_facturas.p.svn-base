/* ======================================================================== */
/* este programa arregla los datos para permitir una correcta ejecucion del */
/* proceso de emision del libro del viajante                                */
/* ======================================================================== */

DEFINE BUFFER Remito FOR Rem_header.
DEFINE BUFFER Factura FOR Fac_header.

FOR EACH Empresa:
    FOR EACH Factura WHERE Factura.cdg_empresa = Empresa.cdg_empresa AND Factura.fecha >= 04/20/05:
        /*
        DISPLAY Factura.nro_remito COLUMN-LABEL "N.Remito!en Factura"
                Factura.nro_factura COLUMN-LABEL "N.Factura!en Factura"
            WITH STREAM-IO.
        */    
        
        IF Factura.nro_remito <> 0 
        THEN DO:
            FIND Remito WHERE Remito.nro_remito = Factura.nro_remito.
            Remito.nro_factura = Factura.nro_factura.
            /*
            DISPLAY Remito.nro_remito COLUMN-LABEL "N.Remito!en Remito"
                    Remito.nro_factura COLUMN-LABEL "N.Factura!en Remito".
            */        
        END.
    END.
END.
