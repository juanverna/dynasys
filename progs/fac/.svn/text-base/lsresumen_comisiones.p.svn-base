/*=================================================================================*/
/*                    LIQUIDACION DE COMISIONES POR VENTAS                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo        LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo        LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha-venta   AS DATE.
DEFINE INPUT PARAMETER has_fecha-venta   AS DATE.
DEFINE INPUT PARAMETER des_fecha-cobro   AS DATE.
DEFINE INPUT PARAMETER has_fecha-cobro   AS DATE.
DEFINE INPUT PARAMETER que_moneda        LIKE Moneda.cdg_moneda.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE t-fam-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-fam-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-ven-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-gen-importe-vendido    AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-importe-cobrado    AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-fam-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-fam-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-ven-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-ven-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE t-gen-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE t-gen-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE a-fam-comision-vendido   AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE a-fam-comision-cobrado   AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE d-comision-vendido       AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Comisión!Ventas".
DEFINE VARIABLE d-comision-cobrado       AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Comisión!Cobranzas".

DEFINE VARIABLE i-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE d-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE d-vendido                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Facturado".
DEFINE VARIABLE r-cobrado                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Cobrado".
DEFINE VARIABLE r-vendido                AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Total!Facturado".
DEFINE VARIABLE v-prc_ventas             AS DECIMAL FORMAT ">>9.9999" DECIMALS 4.
DEFINE VARIABLE v-prc_cobranzas          AS DECIMAL FORMAT ">>9.9999" DECIMALS 4.
DEFINE VARIABLE v-minimo_ventas          AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-minimo_cobranzas       AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE signo                    AS DECIMAL.
DEFINE VARIABLE ant_fecha-venta                AS DATE.

DEFINE VARIABLE que_comprobante          AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!Comprobante".
DEFINE VARIABLE tit_vendedor             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda              LIKE Moneda.descripcion.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Resumen de Liquidación de Comisiones" AT 46
    "Página:" AT 129 PAGE-NUMBER FORMAT "9999" AT 136
    SKIP  
    fecha_lis
    "Ventas......:" AT 46
    des_fecha-venta
    "al"
    has_fecha-venta
    desc_moneda NO-LABEL  
    hora_lis AT 129
    SKIP
    "Cobranzas...:" AT 46
    des_fecha-cobro
    "al"
    has_fecha-cobro
    SKIP (1)
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-detalle
    Vendedor.cdg_vendedor COLUMN-LABEL "Código!Vendedor"
    Vendedor.nombre       COLUMN-LABEL "Nombre!Vendedor" 
    Familia_articulo.cdg_familia COLUMN-LABEL "Código!Familia"
    Familia_articulo.dsc_familia COLUMN-LABEL "Descripción!Familia" FORMAT "X(25)"
    d-vendido
    d-comision-vendido
    d-cobrado
    d-comision-cobrado
    WITH WIDTH 270 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = "en " + Moneda.descripcion.
  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  FOR EACH Vendedor 
      WHERE Vendedor.cdg_vendedor <= has_codigo
        AND Vendedor.cdg_vendedor >= des_codigo,
        EACH Fac_header OF Vendedor 
             WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
               AND Fac_header.nro_moneda = Moneda.nro_moneda
               AND Fac_header.fecha <= has_fecha-venta
               AND Fac_header.fecha >= des_fecha-venta
               AND NOT Fac_header.anulado,
               EACH Fac_detalle OF Fac_header,
               FIRST Articulo OF Fac_detalle,
               FIRST Familia_articulo OF Articulo
               BREAK BY Vendedor.cdg_vendedor
                     BY Familia_articulo.cdg_familia
                     BY Fac_header.fecha
                     BY Fac_header.tip_comprob
                     BY Fac_header.prf_comprob
                     BY Fac_header.nro_comprob:
       
       VIEW FRAME frm-titulo.
       
                  /* ---------------------------------------------------------------- */
                  /* Hallamos el total cobrado para este documento y fijamos el signo */
                  /* ---------------------------------------------------------------- */
       
       IF FIRST-OF(Fac_header.nro_comprob)
       THEN DO:
            RUN sumar_cobrado.p ( INPUT ROWID(Fac_header),
                                  INPUT des_fecha-cobro,
                                  INPUT has_fecha-cobro,
                                  OUTPUT i-cobrado,
                                  OUTPUT signo).
       END.
         
                  /* ---------------------------------------------------------------- */
                  /* Expresamos el total vendido para este item de factura en funcion */
                  /* del signo. Calculamos el importe cobrado prorrateando el total   */
                  /* cobrado contra el total de la factura.                           */
                  /* ---------------------------------------------------------------- */
         
       r-vendido  = Fac_detalle.subtotal_neto * signo.
       r-cobrado  = IF i-cobrado = Fac_header.imp_total 
                       THEN r-vendido 
                       ELSE ROUND(r-vendido * i-cobrado / Fac_header.imp_total, 2 ). 

       d-vendido  = d-vendido + r-vendido.
       d-cobrado  = d-cobrado + r-cobrado. 

       t-fam-importe-vendido = t-fam-importe-vendido + r-vendido.
       t-fam-importe-cobrado = t-fam-importe-cobrado + r-cobrado.

       a-fam-comision-vendido = t-fam-comision-vendido.
       a-fam-comision-cobrado = t-fam-comision-cobrado.

       FIND FIRST Vendedor_escala OF Vendedor
            WHERE Vendedor_escala.cdg_empresa    = Fac_header.cdg_empresa 
              AND Vendedor_escala.nro_familia    = Familia_articulo.nro_familia
              AND Vendedor_escala.desde_fecha    <= has_fecha-venta
              AND Vendedor_escala.hasta_fecha    >= des_fecha-venta
              AND Vendedor_escala.desde_importe  <= t-fam-importe-vendido
              AND Vendedor_escala.hasta_importe  >= t-fam-importe-vendido
                  NO-LOCK NO-ERROR.
        
       IF AVAILABLE Vendedor_escala
       THEN DO:
            ASSIGN
                   t-fam-comision-vendido = Vendedor_escala.minimo_ventas + 
                                            ROUND( ( t-fam-importe-vendido - Vendedor_escala.desde_importe ) * Vendedor_escala.prc_ventas / 100,2)
                   v-prc_ventas           = Vendedor_escala.prc_ventas
                   v-minimo_ventas        = Vendedor_escala.minimo_ventas

                   t-fam-comision-cobrado = Vendedor_escala.minimo_cobranzas + 
                                            ROUND( ( t-fam-importe-cobrado - Vendedor_escala.desde_importe ) * Vendedor_escala.prc_cobranzas / 100,2)
                   v-prc_cobranzas        = Vendedor_escala.prc_cobranzas
                   v-minimo_cobranzas     = Vendedor_escala.minimo_cobranzas.
       END.
       ELSE DO:
            ASSIGN
                   t-fam-comision-vendido = ?
                   v-prc_ventas           = 0
                   v-minimo_ventas        = 0

                   t-fam-comision-cobrado = ?
                   v-prc_cobranzas        = 0
                   v-minimo_cobranzas     = 0.
       END.

       d-comision-vendido = t-fam-comision-vendido - a-fam-comision-vendido.
       d-comision-cobrado = t-fam-comision-cobrado - a-fam-comision-cobrado.

       IF LAST-OF(Fac_header.nro_comprob) 
       THEN DO:
            ASSIGN
                d-vendido           = 0 
                d-comision-vendido  = 0
                d-cobrado           = 0
                d-comision-cobrado  = 0.
       END.
       
       IF LAST-OF(Familia_articulo.cdg_familia)
       THEN DO:
            DISPLAY
                Vendedor.cdg_vendedor  /*WHEN FIRST-OF(Vendedor.cdg_vendedor)*/
                Vendedor.nombre        /*WHEN FIRST-OF(Vendedor.cdg_vendedor)*/
                Familia_articulo.cdg_familia
                Familia_articulo.dsc_familia
                t-fam-importe-vendido  @ d-vendido
                t-fam-importe-cobrado  @ d-cobrado
                t-fam-comision-vendido @ d-comision-vendido
                t-fam-comision-cobrado @ d-comision-cobrado
                WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.

            ASSIGN
                t-ven-importe-vendido  = t-ven-importe-vendido + t-fam-importe-vendido
                t-ven-importe-cobrado  = t-ven-importe-cobrado + t-fam-importe-cobrado
                t-ven-comision-vendido = t-ven-comision-vendido + t-fam-comision-vendido 
                t-ven-comision-cobrado = t-ven-comision-cobrado + t-fam-comision-cobrado
                t-fam-importe-vendido  = 0
                t-fam-importe-cobrado  = 0
                a-fam-comision-vendido = 0
                a-fam-comision-cobrado = 0.

       END.        

       IF LAST-OF(Vendedor.cdg_vendedor)
       THEN DO:
            UNDERLINE
                d-vendido
                d-comision-vendido
                d-cobrado
                d-comision-cobrado
                WITH FRAME frm-detalle.
            DISPLAY
                t-ven-importe-vendido @ d-vendido
                t-ven-importe-cobrado @ d-cobrado
                t-ven-comision-vendido @ d-comision-vendido
                t-ven-comision-cobrado @ d-comision-cobrado
                WITH FRAME frm-detalle.

            DOWN 2 WITH FRAME frm-detalle.
            
            ASSIGN
                t-gen-importe-vendido = t-gen-importe-vendido + t-ven-importe-vendido
                t-gen-importe-cobrado = t-gen-importe-cobrado + t-ven-importe-cobrado
                t-ven-importe-vendido = 0
                t-ven-importe-cobrado = 0

                t-gen-comision-vendido = t-gen-comision-vendido + t-ven-comision-vendido 
                t-gen-comision-cobrado = t-gen-comision-cobrado + t-ven-comision-cobrado
                t-ven-comision-vendido = 0
                t-ven-comision-cobrado = 0.
       END.        

  END.   

  UNDERLINE
        d-vendido
        d-comision-vendido
        d-cobrado
        d-comision-cobrado
        WITH FRAME frm-detalle.
  DISPLAY
        "Total General" @ Vendedor.nombre
        t-gen-importe-vendido @ d-vendido
        t-gen-importe-cobrado @ d-cobrado
        t-gen-comision-vendido @ d-comision-vendido
        t-gen-comision-cobrado @ d-comision-cobrado
        WITH FRAME frm-detalle.
    
  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE hallar_comision:

    DEFINE INPUT PARAMETER   p-importe AS DECIMAL.
    DEFINE OUTPUT PARAMETER  p-minimio-ventas AS DECIMAL.
    DEFINE OUTPUT PARAMETER  p-prc-ventastasa    AS DECIMAL.

    FIND FIRST Vendedor_escala OF Vendedor
         WHERE Vendedor_escala.cdg_empresa    = Fac_header.cdg_empresa 
           AND Vendedor_escala.nro_familia    = Familia_articulo.nro_familia
           AND Vendedor_escala.desde_fecha    <= has_fecha-venta
           AND Vendedor_escala.hasta_fecha    >= des_fecha-venta
           AND Vendedor_escala.desde_importe  <= p-importe
           AND Vendedor_escala.hasta_importe  >= p-importe
               NO-LOCK NO-ERROR.
    
    IF AVAILABLE Vendedor_escala
    THEN DO:
         ASSIGN
                t-fam-comision-vendido = Vendedor_escala.minimo_ventas + 
                                         ROUND( ( t-fam-importe-vendido - Vendedor_escala.minimo_ventas ) * Vendedor_escala.prc_ventas / 100,2)
                t-fam-comision-cobrado = Vendedor_escala.minimo_cobranzas +
                                         ROUND( ( t-fam-importe-cobrado - Vendedor_escala.minimo_cobranzas ) * Vendedor_escala.prc_cobranzas / 100,2)
                v-prc_ventas           = Vendedor_escala.prc_ventas
                v-prc_cobranzas        = Vendedor_escala.prc_cobranzas
                v-minimo_ventas        = Vendedor_escala.minimo_ventas
                v-minimo_cobranzas     = Vendedor_escala.minimo_cobranzas.

    END.
    ELSE DO:
         ASSIGN
                t-fam-comision-vendido = ?
                t-fam-comision-cobrado = ?
                v-prc_ventas           = 0
                v-prc_cobranzas        = 0
                v-minimo_ventas        = 0
                v-minimo_cobranzas     = 0.

    END.

END PROCEDURE.
