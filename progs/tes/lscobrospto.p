/*=================================================================================*/
/*   EMITE UN LISTADO CON TODAS LAS COBRANZAS REGISTRADAS EN UN RANGO DE FECHAS    */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_caja    LIKE Caja.cdg_caja.
DEFINE INPUT PARAMETER des_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha   LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER des_punto   AS integer.
DEFINE INPUT-OUTPUT PARAMETER xfile AS CHAR.
{findempresa.i}
DEFINE TEMP-TABLE liquida
    FIELD fecha AS DATE
    FIELD rendicion   LIKE Caj_header.nro_comprob
    FIELD tip_comprob LIKE comprobante_rendicion.tip_comprob
    FIELD prf_comprob LIKE comprobante_rendicion.prf_comprob
    FIELD nro_comprob LIKE comprobante_rendicion.nro_comprob
    FIELD importefac LIKE fac_header.imp_total
    FIELD fechafac LIKE fac_header.fecha
    FIELD importe AS DECIMAL.
DEFINE TEMP-TABLE Parametros LIKE punto-venta
    FIELD prf   AS int
    FIELD des_fecha   AS DATE LABEL "Desde Fecha"
    FIELD has_fecha   AS DATE LABEL "Hasta Fecha" .
    

DEFINE DATASET dset FOR parametros, liquida.
    FIND punto-venta WHERE punto-venta.cdg_puntovta = des_punto NO-LOCK NO-error.
    IF NOT AVAILABLE punto-venta THEN RETURN. 
    CREATE parametros.
    BUFFER-COPY punto-venta TO parametros.
    ASSIGN parametros.prf = des_punto
        parametros.des_fecha = des_fecha
        parametros.has_fecha = has_fecha.
FIND caja WHERE caja.cdg_caja = que_caja NO-LOCK NO-ERROR.
IF NOT AVAILABLE caja  THEN RETURN.
FOR EACH  Caj_header OF Caja
      WHERE Caj_header.fecha >= des_fecha 
        AND   Caj_header.fecha <= has_fecha
        AND Caj_header.estado <> "A" 
        AND Caj_header.tipo_mov = "I"
        AND Caj_header.tip_comprob BEGINS "R", EACH rendicion_hd NO-LOCK OF caj_header,
        EACH comprobante_rendicion OF rendicion_hd WHERE comprobante_rendicion.prf_comprob = des_punto
        BREAK BY(Caj_header.fecha) BY Caj_header.nro_transaccion:
        FIND fac_header OF comprobante_rendicion NO-ERROR.
      CREATE liquida.
      ASSIGN 
          liquida.fecha = Caj_header.fecha
          liquida.rendicion = Caj_header.nro_comprob
          liquida.importe =  comprobante_rendicion.este_pago
          liquida.tip_comprob = comprobante_rendicion.tip_comprob
          liquida.prf_comprob = comprobante_rendicion.prf_comprob
          liquida.nro_comprob = comprobante_rendicion.nro_comprob
          liquida.fechafac = fac_header.fecha
          liquida.importefac = fac_header.imp_total.
END.
IF xfile = "" THEN DO:
    xfile = SUBST('&1/cr-' + userid("sic") + ".xml" , SESSION:TEMP-DIRECTORY).
    xfile = REPLACE(xfile,"/","\").
END.
DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).



