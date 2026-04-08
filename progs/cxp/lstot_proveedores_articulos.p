/*====================================================================================*/
/*                        ESTADISTICAS POR PROVEEDOR                                  */
/*                  Ranking de Proveedors con o sin detalle de articulos                */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo           LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo           LIKE Proveedor.cdg_proveedor.

DEFINE INPUT PARAMETER des_fecha            AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER has_fecha            AS DATE LABEL "Hasta Fecha" INITIAL TODAY.

DEFINE INPUT PARAMETER det_sino             AS LOGICAL. 
DEFINE INPUT PARAMETER cero_sino            AS LOGICAL.

DEFINE INPUT PARAMETER p-cdg_moneda         AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion     AS INTEGER.
DEFINE INPUT PARAMETER p-fecha              AS DATE.

DEFINE INPUT PARAMETER p-filtro_atributos   AS CHARACTER.

/*====================================================================================*/
/*                  VARIABLES, FRAMES Y TABLAS TEMPORALES                             */
/*====================================================================================*/

{DFVARIMP.I}
{WGLISTAR.I}
{parlocales.i}

DEFINE BUFFER Unigranel FOR Unidad.
DEFINE BUFFER Moneda_Expresion FOR Moneda.

DEFINE VARIABLE gastado_art    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE gastado_cli    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Proveedor".
DEFINE VARIABLE precio_prom    LIKE Fac_detalle_prv.precio LABEL "Precio Promedio".
DEFINE VARIABLE signo          AS INTEGER.
DEFINE VARIABLE v-cod_mon      AS CHARACTER.
DEFINE VARIABLE X-Importe      AS DECIMAL.
DEFINE VARIABLE X-Fec_Cotiza   AS DATE.
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.    
DEFINE VARIABLE v-desc_mon     AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE que_sector           LIKE Area.cdg_area.

DEFINE TEMP-TABLE Rank_proveedor
   FIELD nro_proveedor         LIKE Proveedor.nro_proveedor
   FIELD importe             LIKE Fac_detalle_prv.subtotal_neto
   INDEX por_proveedor         IS PRIMARY nro_proveedor ASCENDING
   INDEX por_importe importe DESCENDING.

DEFINE WORK-TABLE Rank_articulo
   FIELD nro_proveedor  LIKE Proveedor.nro_proveedor
   FIELD nro_articulo LIKE Articulo.nro_articulo
   FIELD cantidad     LIKE Fac_detalle_prv.cantidad
   FIELD granel       LIKE Fac_detalle_prv.granel
   FIELD subtotal     LIKE Fac_detalle_prv.subtotal_neto.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Total de Compras por Proveedor y Articulo" AT 52
  "Página:" AT 138 PAGE-NUMBER FORMAT ">>>9" AT 146
  SKIP
  fecha_lis
  "Del" AT 52
  des_fecha
  "al"
  has_fecha
  hora_lis AT 138
  SKIP
  "Importes expresados en :" AT 52
  v-desc_mon 
  SKIP
  "Fecha de Cotización:" AT 52 
  X-Fec_Cotizar
  SKIP(1)
  "-----------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Razón                                   Total Comprado                                                                                    " SKIP
  "Proveedor  Social                                      Proveedor                                                                                     " SKIP
  "                                                                                                                                                     " SKIP
  "    Código        Descripción                                                     Total                 Total                  Total           Precio" SKIP
  "    Articulo      Artículo                                                     Unidades                Granel               Comprado         Promedio" SKIP
  "-----------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 230 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Proveedor.cdg_proveedor
  SPACE(1)
  Proveedor.nombre
  SPACE(2)
  Rank_proveedor.importe
  WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-art
  SPACE(4)
  Articulo.cdg_articulo
  SPACE(2)
  Articulo.descripcion
  Articulo.a_granel FORMAT " */  "
  Rank_articulo.cantidad
  Unidad.abrevia
  Rank_articulo.granel
  Unigranel.abrevia
  Rank_articulo.subtotal
  precio_prom
  WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

{fnverificatributos.i}

/*=================================================================================*/
/*                                BLOQUE PRINCIPAL                                 */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

{findsector.i}
que_sector = Area.cdg_area.

RUN listar.
RETURN.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE listar:


  FIND Moneda_expresion WHERE Moneda_expresion.cdg_moneda = p-cdg_moneda NO-LOCK.

  ASSIGN v-cod_mon  = Moneda_expresion.cdg_moneda             
         v-desc_mon = Moneda_expresion.descripcion.

  IF p-ver_cotizacion = 1 
      THEN X-Fec_Cotizar= STRING(X-Fec_Cotiza,"99-99-9999").
      ELSE X-Fec_Cotizar = 'Correspondiente a cada Transacción'.

  {dirprinfile.i}

  FOR EACH Fac_header_prv
      WHERE Fac_header_prv.cdg_empresa = Empresa.cdg_empresa 
        AND Fac_header_prv.fecha <= has_fecha
        AND Fac_header_prv.fecha >= des_fecha
        AND NOT Fac_header_prv.anulado NO-LOCK,
      FIRST Proveedor OF Fac_header_prv 
          WHERE Proveedor.cdg_proveedor >= des_codigo
            AND Proveedor.cdg_proveedor <= has_codigo
            AND LOOKUP(que_sector, Proveedor.lista_sectores) <> 0 NO-LOCK,
      FIRST Tipocomprobante OF Fac_header_prv NO-LOCK,
      FIRST Moneda OF Fac_header_prv NO-LOCK,
      FIRST Imputacion OF Fac_header_prv NO-LOCK,
            EACH Fac_detalle_prv OF Fac_header_prv NO-LOCK,
                 FIRST Articulo OF Fac_detalle_prv NO-LOCK:

      IF fncumpleatributos ( Articulo.lista_atributos, p-filtro_atributos )
      THEN DO:


          FIND FIRST Rank_proveedor WHERE Rank_proveedor.nro_proveedor = Proveedor.nro_proveedor NO-ERROR.
          IF NOT AVAILABLE Rank_proveedor
          THEN DO:
              CREATE Rank_proveedor.
              ASSIGN Rank_proveedor.nro_proveedor = Proveedor.nro_proveedor.
          END.
    
          FIND FIRST Rank_articulo 
               WHERE Rank_articulo.nro_proveedor = Proveedor.nro_proveedor 
                 AND Rank_articulo.nro_articulo = Fac_detalle_prv.nro_articulo 
                     NO-ERROR.
          IF NOT AVAILABLE Rank_articulo
          THEN DO:
              CREATE Rank_articulo.
              ASSIGN Rank_articulo.nro_proveedor = Proveedor.nro_proveedor. 
                     Rank_articulo.nro_articulo = Fac_detalle_prv.nro_articulo. 
          END.
    
          IF Tipocomprobante.debita
              THEN signo = -1.
              ELSE signo = 1.
/*    
         FIND Moneda OF Fac_header_prv NO-LOCK. 
         v-cod_mon = Moneda.cdg_moneda.

         FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
         v-desc_mon = Moneda.descripcion.

         IF p-ver_cotizacion = 1 THEN
            v-fecha_cotiza = p-fecha.
         ELSE
             ASSIGN v-fecha_cotiza = Fac_header_prv.fecha
                    X-Fec_Cotizar = 'Correspondiente a cada Transacción'.

         RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle_prv.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).

         IF p-ver_cotizacion = 1 
             THEN X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").
             
*/
         IF p-ver_cotizacion = 1 
             THEN RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda, 
                                             INPUT Moneda_expresion.cdg_moneda, 
                                             INPUT x-fec_cotiza, 
                                             INPUT Fac_detalle_prv.subtotal_neto, 
                                             OUTPUT x-importe, 
                                             OUTPUT x-fec_cotiza ).

             ELSE RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda, 
                                             INPUT Moneda_expresion.cdg_moneda, 
                                             INPUT Fac_header_prv.fecha, 
                                             INPUT Fac_detalle_prv.subtotal_neto, 
                                             OUTPUT x-importe, 
                                             OUTPUT x-fec_cotiza ).

         Rank_proveedor.importe   = Rank_proveedor.importe + signo * X-Importe.
         Rank_articulo.subtotal = Rank_articulo.subtotal + signo * X-Importe.

       /*IF Imputacion.afecta_stock*/
         IF Imputacion.afecta_rendicion
         THEN DO:
             /*
             IF Tipocomprobante.afecta_stock
             THEN DO:
             */
                 ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle_prv.cantidad
                        Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle_prv.granel.
             /*
             END.
             */
         END.
      END.

  END.               

  FOR EACH Rank_proveedor, Proveedor OF Rank_proveedor BY Proveedor.cdg_proveedor:

      VIEW FRAME frm-titulo. 
      IF Rank_proveedor.importe <> 0 OR cero_sino
      THEN DO:
         DISPLAY Proveedor.cdg_proveedor
                 Proveedor.nombre
                 Rank_proveedor.importe
                 WITH FRAME frm-listado-cli.
         DOWN WITH FRAME frm-listado-cli.
      END.

      IF (det_sino AND ( Rank_proveedor.importe <> 0 OR cero_sino )) OR TRUE
      THEN DO:
        
         FOR EACH Rank_articulo OF Proveedor, Articulo OF Rank_articulo, Unidad OF Articulo,
             Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel BY Articulo.cdg_articulo DESCENDING:            
                    
             precio_prom = ( IF Articulo.a_granel 
                                 THEN Rank_articulo.subtotal / Rank_articulo.granel
                                 ELSE Rank_articulo.subtotal / Rank_articulo.cantidad ).

             DISPLAY Articulo.cdg_articulo
                     Articulo.descripcion
                     Articulo.a_granel
                     Rank_articulo.cantidad
                     Unidad.abrevia
                     Rank_articulo.granel
                     Unigranel.abrevia
                     Rank_articulo.subtotal
                     precio_prom WHEN precio_prom <> ?
                     WITH FRAME frm-listado-art.
             DOWN WITH FRAME frm-listado-art.
         END.

         DOWN 1 WITH FRAME frm-listado-art.

      END.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

END PROCEDURE.


