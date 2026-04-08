/*----------------------------------------------------------------------------------------------------------*/
/*   PRODUCE UN LISTADO DE TODAS LAS FACTURAS DE COMPRA QUE NO SON DE SILKEY Y QUE TIENEN FECHAS DISTINTAS  */
/*----------------------------------------------------------------------------------------------------------*/
DEFINE VARIABLE t-iva LIKE Fac_header_prv.imp_iva.
DEFINE FRAME frm
    Fac_header_prv.cdg_empresa 
    Fac_header_prv.tip_comprob 
    Fac_header_prv.prf_comprob 
    Fac_header_prv.nro_comprob 
    Fac_header_prv.fecha 
    Fac_header_prv.fecha_iva 
    Fac_header_prv.imp_total 
    Fac_header_prv.imp_iva 
    Proveedor.cdg_proveedor
    WITH STREAM-IO WIDTH 132 FRAME frm DOWN.
OUTPUT TO "c:\sic-temp\lisiva.txt" PAGE-SIZE 72.

DO WITH FRAME frm:

    FOR EACH Fac_header_prv WHERE MONTH(Fac_header_prv.fecha) <> MONTH(Fac_header_prv.fecha_iva), 
        FIRST Proveedor OF Fac_header_prv WHERE Proveedor.cdg_proveedor <> "1P",
        FIRST Sub_header_prv OF Fac_header_prv WHERE (Sub_header_prv.fecha <> Fac_header_prv.fecha_iva OR 
                                                     Sub_header_prv.fecha = ?):

        
        DISPLAY 
            Fac_header_prv.cdg_empresa 
            Fac_header_prv.tip_comprob 
            Fac_header_prv.prf_comprob 
            Fac_header_prv.nro_comprob 
            Fac_header_prv.fecha 
            Fac_header_prv.fecha_iva 
            Fac_header_prv.imp_total 
            Fac_header_prv.imp_iva 
            Proveedor.cdg_proveedor
            sub_header_prv.fecha 
            WITH STREAM-IO WIDTH 132 FRAME frm.
        DOWN WITH FRAME frm.
    
        t-iva = t-iva + Fac_header_prv.imp_iva.
    
    END.
    
    UNDERLINE Fac_header_prv.imp_iva
        WITH FRAME frm.
    DISPLAY t-iva @ Fac_header_prv.imp_iva
        WITH FRAME frm.
END.
