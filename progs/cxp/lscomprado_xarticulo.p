/*=================================================================================*/
/*                    LIQUIDACION DE REMITOS X FECHA                               */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codigo  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER des_fecha   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha   AS DATE FORMAT "99/99/9999".

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante    AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Comprobante".

DEFINE VARIABLE x-a-cantidad       LIKE Fac_detalle_prv.cantidad.
DEFINE VARIABLE x-a-pesos          LIKE Fac_detalle_prv.granel.

DEFINE VARIABLE t-a-cantidad       LIKE Fac_detalle_prv.cantidad.
DEFINE VARIABLE t-a-pesos          LIKE Fac_detalle_prv.subtotal_neto.

DEFINE VARIABLE g-a-cantidad       LIKE Fac_detalle_prv.cantidad.
DEFINE VARIABLE g-a-pesos          LIKE Fac_detalle_prv.granel.

DEFINE VARIABLE v-precio_prom      LIKE Fac_detalle_prv.precio. 

{WGLISTAR.I}
{dfvarimp.i}
{parlocales.i}

DEFINE BUFFER Ugranel FOR Unidad.

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Compras por Artículo" AT 55
    "Página:" AT 122 PAGE-NUMBER FORMAT "9999" AT 129
    SKIP  
    fecha_lis
    "del" AT 55
    des_fecha
    "al"
    has_fecha
    hora_lis AT 122
    SKIP(1)
    "------------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Código       Descripción                                                                                                            " SKIP
    "Artículo     Artículo                                                                                                               " SKIP
    "                                                                                                                                    " SKIP
    "    Fecha      Identificación           Cantidad             Precio         Importe Mo-           Tasa Razón                        " SKIP
    "    Venta      Conmprobante              Vendida           de Venta         Factura Neda        Cambio Social                       " SKIP
    "------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 250 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-articulo
    Articulo.cdg_articulo
    Articulo.descripcion
    Unidad.abrevia           COLUMN-LABEL "Uni-!dad"
    Ugranel.abrevia          COLUMN-LABEL "Uni-!dad"
    WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-facturas
    SPACE(4)
    Fac_header_prv.fecha
    Fac_header_prv.tip_comprob
    Fac_header_prv.prf_comprob
    Fac_header_prv.nro_comprob
    x-a-cantidad
    Unidad.abrevia
    Fac_detalle_prv.precio
    x-a-pesos
    Moneda.abrevia
    Fac_header_prv.cambio
    Proveedor.nombre
    WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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

  que_empresa = Empresa.nombre.
   
  {dirprinfile.i}

  FOR EACH Fac_header_prv 
        WHERE Fac_header_prv.cdg_empresa = Empresa.cdg_empresa
          AND Fac_header_prv.fecha <= has_fecha
          AND Fac_header_prv.fecha >= des_fecha
          AND NOT Fac_header_prv.anulado NO-LOCK,
              FIRST Moneda OF Fac_header_prv NO-LOCK, 
              FIRST Proveedor OF Fac_header_prv NO-LOCK,
              EACH Fac_detalle_prv OF Fac_header_prv NO-LOCK,
          FIRST Articulo OF Fac_detalle_prv
                WHERE Articulo.cdg_articulo <= has_codigo
                  AND Articulo.cdg_articulo >= des_codigo NO-LOCK,
          FIRST Unidad OF Articulo NO-LOCK,
          FIRST Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_umed NO-LOCK,
          FIRST Partida  OF Fac_detalle_prv NO-LOCK
          BREAK BY Articulo.cdg_articulo
                BY Partida.cdg_partida
                BY Fac_header_prv.fecha
                BY Proveedor.cdg_proveedor
                BY Fac_header_prv.tip_comprob 
                BY Fac_header_prv.prf_comprob 
                BY Fac_header_prv.nro_comprob:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Articulo.cdg_articulo)
       THEN DO:
     
           DISPLAY 
                 Articulo.cdg_articulo
                 Articulo.descripcion
                 WITH FRAME frm-articulo.
            DOWN WITH FRAME frm-articulo.

            ASSIGN
                 t-a-cantidad = 0
                 t-a-pesos   = 0.
       END.

       FIND Tipocomprobante OF Fac_header_prv NO-LOCK.
       FIND Imputacion OF Fac_header_prv NO-LOCK.

       ASSIGN x-a-cantidad = Fac_detalle_prv.cantidad * Tipocomprobante.signo
              x-a-pesos = Fac_detalle_prv.subtotal_neto * Fac_header_prv.cambio * Tipocomprobante.signo.

       ASSIGN t-a-pesos    = t-a-pesos    + x-a-pesos. 
       IF Tipocomprobante.afecta_stock
           THEN IF Imputacion.afecta_stock
                THEN ASSIGN t-a-cantidad = t-a-cantidad + x-a-cantidad.

       DISPLAY 
             Fac_header_prv.fecha
             Fac_header_prv.tip_comprob
             Fac_header_prv.prf_comprob
             Fac_header_prv.nro_comprob
             Proveedor.nombre
             x-a-cantidad WHEN Imputacion.afecta_stock
             Unidad.abrevia
             Fac_detalle_prv.precio
             x-a-pesos
             Moneda.abrevia
             Fac_header_prv.cambio
             WITH FRAME frm-facturas.
        DOWN WITH FRAME frm-facturas.

       IF LAST-OF(Articulo.cdg_articulo)
       THEN DO:

           v-precio_prom = t-a-pesos / t-a-cantidad.

           UNDERLINE 
                 x-a-cantidad
                 Fac_detalle_prv.precio
                 x-a-pesos
                 WITH FRAME frm-facturas.

           DISPLAY
                 t-a-cantidad @ x-a-cantidad
                 Unidad.abrevia
                 t-a-pesos   @ x-a-pesos
                 WITH FRAME frm-facturas.

           IF v-precio_prom <> ?
               THEN DISPLAY v-precio_prom @ Fac_detalle_prv.precio
                            WITH FRAME frm-facturas.

           DOWN 2 WITH FRAME frm-facturas.

           ASSIGN
                 g-a-cantidad = g-a-cantidad + t-a-cantidad
                 g-a-pesos   = g-a-pesos   + t-a-pesos
                 t-a-cantidad = 0
                 t-a-pesos   = 0.

       END.

  END.   

  UNDERLINE 
         Fac_detalle_prv.cantidad
         Fac_detalle_prv.subtotal_neto
         WITH FRAME frm-facturas.
  DISPLAY
         g-a-cantidad @ Fac_detalle_prv.cantidad
         Unidad.abrevia
         g-a-pesos   @ Fac_detalle_prv.subtotal_neto
         WITH FRAME frm-facturas.
    
  DOWN 2 WITH FRAME frm-facturas.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.
