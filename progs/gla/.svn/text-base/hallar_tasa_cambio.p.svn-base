/* ======================================================================================================= */    
/* DADAS DOS MONEDAS, HALLA LA TASA DE CAMBIO ENTRE ELLAS EN BASE A LA QUE TIENE CON LA MONEDA REFERENCIA  */
/* EL RESULTADO SE EXPRESA EN LA CANTIDAD DE UNIDADES DE DESTINO POR CADA UNIDAD DE LA MONEDA DE ORIGEN    */
/* ======================================================================================================= */    

    DEFINE INPUT  PARAMETER p-nro_moneda_origen  LIKE Moneda.nro_moneda.
    DEFINE INPUT  PARAMETER p-nro_moneda_destino LIKE Moneda.nro_moneda.
    DEFINE INPUT  PARAMETER p-cdg_empresa        LIKE Empresa.cdg_empresa.
    DEFINE INPUT  PARAMETER p-fecha_cambio       LIKE Cotizacion.fch_cotizacion.
    DEFINE OUTPUT PARAMETER p-tasa_cambio        LIKE Cotizacion.cambio.

    /* ---------------------------------------------------------------------- */
    /*           Variables locales del proceso de cotizacion                  */
    /* ---------------------------------------------------------------------- */

    DEFINE VARIABLE  x-cotiza_origen    LIKE Cotizacion.cambio.
    DEFINE VARIABLE  x-cotiza_destino   LIKE Cotizacion.cambio.
    DEFINE VARIABLE  x-fecha_cotizacion LIKE Cotizacion.fch_cotizacion.

    /* ---------------------------------------------------------------------- */
    /*                                Proceso                                 */
    /* ---------------------------------------------------------------------- */

    FIND Moneda WHERE Moneda.nro_moneda = p-nro_moneda_origen NO-LOCK.
    IF Moneda.es_referencia
         THEN x-cotiza_origen = 1.
         ELSE RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda  , 
                                      INPUT   p-cdg_empresa      , 
                                      INPUT   p-fecha_cambio     , 
                                      OUTPUT  x-cotiza_origen    , 
                                      OUTPUT  x-fecha_cotizacion ).


    FIND Moneda WHERE Moneda.nro_moneda = p-nro_moneda_destino NO-LOCK.
    IF Moneda.es_referencia
         THEN x-cotiza_destino = 1.
         ELSE RUN cotizar_moneda.p  ( INPUT   Moneda.cdg_moneda  , 
                                      INPUT   p-cdg_empresa      , 
                                      INPUT   p-fecha_cambio     , 
                                      OUTPUT  x-cotiza_destino    , 
                                      OUTPUT  x-fecha_cotizacion ).

    p-tasa_cambio = x-cotiza_destino / x-cotiza_origen.
