/*=================================================================================================*/
/*             GENERA UN ARCHIVO EXCEL CON LAS VENTAS DE UN PERIODO DETERMINADO                    */
/*=================================================================================================*/

DEFINE INPUT PARAMETER des_vendedor     LIKE Vendedor.cdg_vendedor. 
DEFINE INPUT PARAMETER has_vendedor     LIKE Vendedor.cdg_vendedor. 
DEFINE INPUT PARAMETER des_codart       LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart       LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER lista_empresas   AS CHARACTER.
DEFINE INPUT PARAMETER arch_salida      AS CHARACTER.

/*=================================================================================================*/
/*                                          VARIABLES                                              */
/*=================================================================================================*/

{vrshared.i "new"}

DEFINE VARIABLE x-importe     LIKE Fac_detalle.subtotal_neto FORMAT "->>>>>>>>9.99".
DEFINE VARIABLE x-cmarginal   LIKE Fac_detalle.subtotal_neto FORMAT "->>>>>>>>9.99".
DEFINE VARIABLE x-cantidad    LIKE Fac_detalle.cantidad FORMAT "->>>>>>>>9".
DEFINE VARIABLE x-costo       LIKE Fac_detalle.subtotal_neto FORMAT "->>>>>>>>9.99".

DEFINE VARIABLE signo         AS INTEGER.
DEFINE VARIABLE tiempo        AS INTEGER.
DEFINE STREAM Ventas.
DEFINE VAR cont AS INTEGER.

/*=================================================================================================*/
/*                                       BLOQUE PRINCIPAL                                          */
/*=================================================================================================*/

SESSION:NUMERIC-FORMAT = "AMERICAN".

tiempo = ETIME(YES).

OUTPUT STREAM Ventas TO VALUE(arch_salida).
EXPORT STREAM Ventas DELIMITER ";"
    "Empresa" "Comp" "Anno" "Mes" "Dia" "Cliente" "Razón" "Tipo" "Localidad" "provin" "Vendedor" "Familia"
    "Marca" "Articulo" "Descripcion articulo" "Cantidad" "Importe" "C.Marginal".
cont = 0.
FOR EACH Fac_header 
    WHERE Fac_header.fecha <= has_fecha
      AND Fac_header.fecha >= des_fecha
      AND LOOKUP(Fac_header.cdg_empresa,lista_empresas) <> 0
      AND NOT Fac_header.anulado, 
    FIRST Cliente OF Fac_header NO-LOCK,
    FIRST Vendedor OF Cliente 
          WHERE Vendedor.cdg_vendedor <= has_vendedor
            AND Vendedor.cdg_vendedor >= des_vendedor,    
    FIRST Entidad OF Cliente NO-LOCK,
    FIRST Tipo_cliente OF Cliente NO-LOCK,
    FIRST Domicilio OF Fac_header NO-LOCK,
    FIRST Tipocomprobante OF Fac_header NO-LOCK,
    EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle, Familia_articulo OF Articulo, Tipo_articulo OF Articulo, Marca_comercial OF articulo:

        signo       = IF Tipocomprobante.debita THEN 1 ELSE ( -1 ).    
        
        IF fac_header.cdg_empresa = "F" THEN DO:
            IF Fac_header.tip_comprob = "DR" THEN
            x-importe   = (Fac_detalle.subtotal_neto * signo).
            ELSE
            x-importe   = (Fac_detalle.subtotal_neto * 1.21 * signo). 
        END.
        
        ELSE DO: 
            x-importe   = (Fac_detalle.subtotal_neto * signo).

        END.

        x-cantidad  = IF Tipocomprobante.afecta_stock THEN Fac_detalle.cantidad * signo ELSE 0.
        x-costo     = Fac_detalle.cantidad * Fac_detalle.costo * signo.
        x-cmarginal = (ABS(x-importe) - ABS(x-costo)) * signo.
cont = cont + 1.


        EXPORT STREAM Ventas DELIMITER ";"
   
               Fac_header.cdg_empresa 
               Fac_header.tip_comprob
               YEAR(Fac_header.fecha)
               MONTH(Fac_header.fecha)
               DAY(Fac_header.fecha)
               Cliente.cdg_cliente 
               Cliente.nom_cliente
               Tipo_cliente.dsc_tipoclie
               Cliente.localidad
               Cliente.cdg_provincia
               Vendedor.cdg_vendedor
               Tipo_articulo.dsc_tipoart
               marca_comercial.dsc_marcacom
               Articulo.cdg_articulo 
               string(Articulo.descripcion) FORMAT "x(30)" 
               x-cantidad 
               x-importe
               x-cmarginal.
             
END.

OUTPUT STREAM Ventas CLOSE.
tiempo = ETIME(NO).
MESSAGE "Termino en " tiempo / 1000 " segundos." VIEW-AS ALERT-BOX MESSAGE.
