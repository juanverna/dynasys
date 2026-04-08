DEF VAR dd AS DATE NO-UNDO.
DEF VAR hh AS DATE NO-UNDO.
dd = 6/1/2006.
OUTPUT TO "c:\datos.cvs".
FOR EACH fac_header WHERE fecha >= dd :
    FIND fac_detalle OF fac_header.
    FIND articulo OF fac_detalle.
    FIND tipo_articulo OF articulo.
        
    EXPORT DELIMITER "|" Fac_header.cdg_administrador 
        Fac_header.codigo_cliente 
        fac_header.direccion
        Fac_header.nombre
        Fac_header.imp_total
        Tipo_articulo.cdg_tipoart.
END.
