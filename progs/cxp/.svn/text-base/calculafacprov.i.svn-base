
DEFINE VARIABLE v-saldo_renglon AS DECIMAL.
DEFINE VARIABLE v-aux_importe   AS DECIMAL.

FIND Imputacion  OF {1}Fac_header_prv NO-LOCK.
FIND Proveedor OF {1}Fac_header_prv NO-LOCK.
FIND Familia_proveedor OF Proveedor NO-LOCK.

CREATE {1}Sub_header_prv.
ASSIGN
       {1}Sub_header_prv.nro_proveedor = {1}Fac_header_prv.nro_proveedor
       {1}Sub_header_prv.cdg_empresa   = {1}Fac_header_prv.cdg_empresa
       {1}Sub_header_prv.tip_comprob   = {1}Fac_header_prv.tip_comprob
       {1}Sub_header_prv.prf_comprob   = {1}Fac_header_prv.prf_comprob
       {1}Sub_header_prv.nro_comprob   = {1}Fac_header_prv.nro_comprob
       {1}Sub_header_prv.fecha         = {1}Fac_header_prv.fecha_iva
       {1}Sub_header_prv.nro_cuenta    = Familia_proveedor.nro_cuenta.

{1}Fac_header_prv.imp_neto  = 0.
{1}Fac_header_prv.imp_total = 0.

FOR EACH {1}Fac_detalle_prv EXCLUSIVE-LOCK OF {1}Fac_header_prv, 
           Articulo OF {1}Fac_detalle_prv, Familia_articulo OF Articulo:

    IF {1}Fac_header_prv.contra_recep 
       THEN v-nro_cuenta = Familia_articulo.nro_cuenta_pendte. /* Facturas Pendientes */
       ELSE v-nro_cuenta = Familia_articulo.nro_cuenta_costo.  /* Cuenta de Costo no hay factura */

    {1}Fac_detalle_prv.subtotal_neto = 
        ( IF {1}Fac_detalle_prv.a_granel 
             THEN ROUND( {1}Fac_detalle_prv.precio * {1}Fac_detalle_prv.granel   , 2 )
             ELSE ROUND( {1}Fac_detalle_prv.precio * {1}Fac_detalle_prv.cantidad , 2 ) ).
 
    IF Articulo.sumaneto = 1
       THEN {1}Fac_header_prv.imp_neto = {1}Fac_header_prv.imp_neto + {1}Fac_detalle_prv.subtotal_neto.
 
    {1}Fac_header_prv.imp_total = {1}Fac_header_prv.imp_total + {1}Fac_detalle_prv.subtotal_neto.
 
    IF NOT CAN-FIND(FIRST Entidad_distribucion 
                          WHERE Entidad_distribucion.cdg_empresa = {1}Fac_header_prv.cdg_empresa
                            AND Entidad_distribucion.nro_entidad = {1}Fac_detalle_prv.nro_entidad)
    THEN DO: /* SIN redistribucion automatica */

        FIND {1}Sub_detalle_prv 
             WHERE {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
               AND {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
               AND {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
               AND {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
               AND {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
               AND {1}Sub_detalle_prv.nro_cuenta     = v-nro_cuenta
               AND {1}Sub_detalle_prv.nro_entidad    = {1}Fac_detalle_prv.nro_entidad
               AND {1}Sub_detalle_prv.nro_obra       = {1}Fac_detalle_prv.nro_obra
             EXCLUSIVE-LOCK NO-ERROR.
             
        IF NOT AVAILABLE {1}Sub_detalle_prv 
        THEN DO:
           CREATE {1}Sub_detalle_prv.
           ASSIGN
                  {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                  {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                  {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                  {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                  {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                  {1}Sub_detalle_prv.nro_cuenta     = v-nro_cuenta
                  {1}Sub_detalle_prv.nro_entidad    = {1}Fac_detalle_prv.nro_entidad
                  {1}Sub_detalle_prv.nro_obra       = {1}Fac_detalle_prv.nro_obra
                  {1}Sub_detalle_prv.tipo           = 1.
        END.
    
        {1}Sub_detalle_prv.valor = {1}Sub_detalle_prv.valor + {1}Fac_detalle_prv.subtotal_neto.
    END.
    ELSE DO: /* CON redistribucion automatica */

        v-saldo_renglon = {1}Fac_detalle_prv.subtotal_neto.
        FOR EACH Entidad_distribucion 
            WHERE Entidad_distribucion.cdg_empresa = {1}Fac_header_prv.cdg_empresa
              AND Entidad_distribucion.nro_entidad = {1}Fac_detalle_prv.nro_entidad
                  BREAK BY Entidad_distribucion.nro_entidad:

            FIND {1}Sub_detalle_prv 
                 WHERE {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                   AND {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                   AND {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                   AND {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                   AND {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                   AND {1}Sub_detalle_prv.nro_cuenta     = v-nro_cuenta
                   AND {1}Sub_detalle_prv.nro_entidad    = Entidad_distribucion.nro_entidad-dis
                   AND {1}Sub_detalle_prv.nro_obra       = {1}Fac_detalle_prv.nro_obra
                 EXCLUSIVE-LOCK NO-ERROR.
                 
            IF NOT AVAILABLE {1}Sub_detalle_prv 
            THEN DO:
               CREATE {1}Sub_detalle_prv.
               ASSIGN
                      {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                      {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                      {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                      {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                      {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                      {1}Sub_detalle_prv.nro_cuenta     = v-nro_cuenta
                      {1}Sub_detalle_prv.nro_entidad    = Entidad_distribucion.nro_entidad-dis
                      {1}Sub_detalle_prv.nro_obra       = {1}Fac_detalle_prv.nro_obra
                      {1}Sub_detalle_prv.tipo           = 1.
            END.

            IF LAST-OF(Entidad_distribucion.nro_entidad)
               THEN v-aux_importe = v-saldo_renglon.
               ELSE v-aux_importe = ROUND({1}Fac_detalle_prv.subtotal_neto * Entidad_distribucion.porcentaje / 100.0 ,2).

            {1}Sub_detalle_prv.valor = {1}Sub_detalle_prv.valor + v-aux_importe.
            v-saldo_renglon = v-saldo_renglon - v-aux_importe.
        END.
        
    END.

                    /* Impuestos de cada artículo */

    FOR EACH Articulo-impuesto OF Familia_articulo WHERE Articulo-impuesto.para_compra, 
                Impuesto OF Articulo-impuesto:
 
           FIND  {1}Sub_detalle_prv 
                WHERE {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                  AND {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                  AND {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                  AND {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                  AND {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                  AND {1}Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                  AND {1}Sub_detalle_prv.tipo           = 2
                       EXCLUSIVE-LOCK NO-ERROR.
         
           IF NOT AVAILABLE {1}Sub_detalle_prv 
           THEN DO:
              CREATE {1}Sub_detalle_prv.
              ASSIGN
                     {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                     {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                     {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                     {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                     {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                     {1}Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                     {1}Sub_detalle_prv.tipo           = 2.
           END.

           {1}Sub_detalle_prv.valor = {1}Sub_detalle_prv.valor + 
                                   ROUND({1}Fac_detalle_prv.subtotal_neto *
                                      Articulo-impuesto.tasa / 100 ,2 ).

    END. /* Del detalle de impuestos por artículo */

END.             

                  /* ----------------------------------- */
                  /*    Evaluamos los gastos asociados   */
                  /* ----------------------------------- */

FOR EACH Fac_prv-gasto OF {1}Fac_header_prv, Gasto OF Fac_prv-gasto:

    FIND {1}Sub_detalle_prv
         WHERE {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
           AND {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
           AND {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
           AND {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
           AND {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
           AND {1}Sub_detalle_prv.nro_cuenta     = Gasto.nro_cuenta
         EXCLUSIVE-LOCK NO-ERROR.
         
    IF NOT AVAILABLE {1}Sub_detalle_prv 
    THEN DO:
       CREATE {1}Sub_detalle_prv.
       ASSIGN
              {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
              {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
              {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
              {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
              {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
              {1}Sub_detalle_prv.nro_cuenta     = Gasto.nro_cuenta
              {1}Sub_detalle_prv.tipo           = 1.
    END.

    {1}Sub_detalle_prv.valor    = {1}Sub_detalle_prv.valor    + Fac_prv-gasto.importe.
    {1}Fac_header_prv.imp_neto  = {1}Fac_header_prv.imp_neto  + Fac_prv-gasto.importe.
    {1}Fac_header_prv.imp_total = {1}Fac_header_prv.imp_total + Fac_prv-gasto.importe.

END.             

                  /* ----------------------------------- */
                  /* Calculo automatico de los impuestos */
                  /* ----------------------------------- */

/*  {1}Fac_header_prv.imp_total = {1}Fac_header_prv.imp_neto.  */

FOR EACH Impuesto_condicion OF Condicion_impos 
    WHERE Impuesto_condicion.cdg_empresa = Empresa.cdg_empresa NO-LOCK, 
           Impuesto OF Impuesto_condicion NO-LOCK:

     aux_importe = ROUND({1}Fac_header_prv.imp_neto * Impuesto_condicion.tasa / 100,2).

    IF aux_importe > Impuesto_condicion.valor_minimo
    THEN DO:
        FIND {1}Sub_detalle_prv 
             WHERE {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
               AND {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
               AND {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
               AND {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
               AND {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
               AND {1}Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
             EXCLUSIVE-LOCK NO-ERROR.
             
        IF NOT AVAILABLE {1}Sub_detalle_prv 
        THEN DO:
           CREATE {1}Sub_detalle_prv.
           ASSIGN
                  {1}Sub_detalle_prv.nro_proveedor  = {1}Fac_header_prv.nro_proveedor
                  {1}Sub_detalle_prv.cdg_empresa    = {1}Fac_header_prv.cdg_empresa
                  {1}Sub_detalle_prv.tip_comprob    = {1}Fac_header_prv.tip_comprob
                  {1}Sub_detalle_prv.prf_comprob    = {1}Fac_header_prv.prf_comprob
                  {1}Sub_detalle_prv.nro_comprob    = {1}Fac_header_prv.nro_comprob
                  {1}Sub_detalle_prv.nro_cuenta     = Impuesto.nro_cuenta
                  {1}Sub_detalle_prv.nro_obra       = 0
                  {1}Sub_detalle_prv.tipo           = 2.
        END.
    
        {1}Sub_detalle_prv.valor    = {1}Sub_detalle_prv.valor    +  aux_importe.
        {1}Fac_header_prv.imp_total = {1}Fac_header_prv.imp_total +  aux_importe. 
        IF Impuesto.cdg_impuesto = codigo_iva 
           THEN {1}Fac_header_prv.imp_iva = aux_importe.
    END.      
END.       

{1}Sub_header_prv.imp_total = {1}Fac_header_prv.imp_total.
