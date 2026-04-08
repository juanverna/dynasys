/*=================================================================================*/
/*                              FACTURAS POR FECHA                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER det_sino AS LOGICAL. 
DEFINE INPUT PARAMETER cero_sino AS LOGICAL.
DEFINE INPUT PARAMETER p-cdg_moneda     AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion AS INTEGER.
DEFINE INPUT PARAMETER p-fecha          AS DATE.
/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE X-Precio        AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Importe       AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE X-Fec_Cotiza    AS DATE.
DEFINE VARIABLE signo           AS INTEGER.
DEFINE VARIABLE v-cod_mon       AS CHARACTER. 
DEFINE VARIABLE v-fecha_cotiza  AS DATE. 
DEFINE VARIABLE v-desc_mon      AS CHARACTER FORMAT "X(20)". 

DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

DEFINE BUFFER Ugranel FOR Unidad.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Facturas por Fecha" AT 55
    "Página:" AT 140 PAGE-NUMBER FORMAT "9999" AT 147
    SKIP  
    fecha_lis
    "del" AT 55
    des_fecha
    "al"
    has_fecha
    hora_lis AT 140
    SKIP
    "Importes expresados en :" AT 55
    v-desc_mon 
    SKIP
    "Fecha de Cotización:" AT 55 
    X-Fec_Cotizar
    SKIP(1) 
    "------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Fecha      Identificación   Código   Razón                                           Importe                                                          " SKIP
    "Remito     del comprobante  Cliente  Social                                            Total                                                          " SKIP
    "                          Código     Descripción                              Código        Cantidad           Kilaje             Precio      Subtotal" SKIP
    "                          Artículo   Artículo                                 Partida       Facturada       Facturado           Unitario          Neto" SKIP
    "------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Fac_header.fecha
    que_comprobante
    Cliente.cdg_cliente
    Cliente.nom_cliente
    Fac_header.imp_total
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-detalle
    SPACE(26)
    Articulo.cdg_articulo
    Articulo.descripcion
    Partida.cdg_partida
    Fac_detalle.cantidad
    Unidad.abrevia
    Fac_detalle.granel
    Ugranel.abrevia
    Fac_detalle.precio
    Fac_detalle.subtotal_neto
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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

  FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
          AND Fac_header.fecha <= has_fecha
          AND Fac_header.fecha >= des_fecha
          AND NOT Fac_header.anulado,
              FIRST Cliente OF Fac_header
              WHERE Cliente.cdg_cliente <= has_codigo
                AND Cliente.cdg_cliente >= des_codigo
                AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0,
              FIRST Imputacion OF Fac_header,
          EACH Fac_detalle OF Fac_header,
          FIRST Articulo OF Fac_detalle,
          FIRST Partida  OF Fac_detalle
          BREAK BY Fac_header.fecha
                BY Cliente.cdg_cliente
                BY Fac_header.tip_comprob
                BY Fac_header.prf_comprob
                BY Fac_header.nro_comprob
                BY Articulo.cdg_articulo
                BY Partida.cdg_partida:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Fac_header.nro_comprob)
       THEN DO:
            que_comprobante = Fac_header.tip_comprob + " " + 
                              STRING(Fac_header.prf_comprob,"9999") + " " +
                              STRING(Fac_header.nro_comprob,"99999999").

       FOR EACH moneda 
       WHERE moneda.nro_moneda = Fac_header.nro_moneda:
       ASSIGN v-cod_mon = moneda.cdg_moneda             
       NO-ERROR.
       END.
      
      FOR EACH moneda 
           WHERE moneda.cdg_moneda = p-cdg_moneda:
           ASSIGN v-desc_mon = moneda.descripcion             
           NO-ERROR.
      END.


      IF p-ver_cotizacion = 1 THEN
         v-fecha_cotiza = p-fecha. 
      ELSE
         ASSIGN v-fecha_cotiza = Fac_header.fecha
                X-Fec_Cotizar = 'Correspondiente a cada Transacción'.


      RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_total, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).

      IF p-ver_cotizacion = 1 THEN
      X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").


            DISPLAY Fac_header.fecha             WHEN FIRST-OF(Fac_header.fecha)
                    que_comprobante              
                    Cliente.cdg_cliente          
                    Cliente.nom_cliente          
                    X-Importe @ Fac_header.imp_total
                    WITH FRAME frm-listado.
         /* DOWN WITH FRAME frm-listado. */

       END.

       FIND Unidad OF Articulo NO-LOCK.
       FIND Ugranel WHERE Ugranel.cdg_umed = Articulo.cdg_ugranel NO-LOCK.
       
       RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.precio, OUTPUT X-Precio, OUTPUT X-Fec_Cotiza ).

       RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).



       DISPLAY Articulo.cdg_articulo
               Articulo.descripcion
               Partida.cdg_partida
               Fac_detalle.cantidad              WHEN Imputacion.afecta_stock
               Unidad.abrevia                    WHEN Imputacion.afecta_stock
               Fac_detalle.granel                WHEN Imputacion.afecta_stock
               Ugranel.abrevia                   WHEN Imputacion.afecta_stock
               X-Precio @ Fac_detalle.precio    /*  WHEN Imputacion.afecta_stock */
               X-Importe @ Fac_detalle.subtotal_neto
               WITH FRAME frm-detalle.
       DOWN WITH FRAME frm-detalle.

       IF LAST-OF(Fac_header.nro_comprob)
       THEN DO:
            UNDERLINE Fac_detalle.subtotal_neto
                      WITH FRAME frm-detalle.


            RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).
            
            DISPLAY "Neto"     @ Fac_detalle.precio
                    X-Importe  @ Fac_detalle.subtotal_neto
                    WITH FRAME frm-detalle.
            DOWN WITH FRAME frm-detalle.
         
            /* DOWN WITH FRAME frm-listado. */

       END.


  END.   

  OUTPUT CLOSE.

END PROCEDURE.  

