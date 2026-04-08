/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULO                                   */
/*                  Ranking de Articulos con o sin detalle de Proveedoress            */
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

DEFINE TEMP-TABLE Rank_articulo
   FIELD nro_articulo        LIKE Articulo.nro_articulo
   FIELD cantidad            LIKE Fac_detalle_prv.cantidad
   FIELD granel              LIKE Fac_detalle_prv.granel
   FIELD subtotal            LIKE Fac_detalle_prv.subtotal_neto
   INDEX por_articulo        IS PRIMARY nro_articulo ASCENDING
   INDEX por_importe subtotal DESCENDING.

DEFINE WORK-TABLE Rank_proveedor
   FIELD nro_articulo LIKE Articulo.nro_articulo
   FIELD nro_proveedor  LIKE Proveedor.nro_proveedor
   FIELD cantidad     LIKE Fac_detalle_prv.cantidad
   FIELD granel       LIKE Fac_detalle_prv.granel
   FIELD subtotal     LIKE Fac_detalle_prv.subtotal_neto.

DEFINE VARIABLE gastado_art     AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE gastado_cli     AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Proveedor".
DEFINE VARIABLE precio_prom_cli LIKE Fac_detalle_prv.precio LABEL "Precio Promedio".
DEFINE VARIABLE precio_prom_art LIKE Fac_detalle_prv.precio LABEL "Precio Promedio".
DEFINE VARIABLE X-Importe       AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE X-Fec_Cotiza    AS DATE.
DEFINE VARIABLE signo           AS INTEGER.
DEFINE VARIABLE v-cod_mon       AS CHARACTER. 
DEFINE VARIABLE v-modo_cotiza   AS CHARACTER. 
DEFINE VARIABLE v-fecha_cotiza  AS DATE. 
DEFINE VARIABLE v-desc_mon      AS CHARACTER FORMAT "X(20)". 
DEFINE VARIABLE que_sector      LIKE Area.cdg_area.

DEFINE VARIABLE tot_cantidad    LIKE Rank_proveedor.cantidad. 
DEFINE VARIABLE tot_granel      LIKE Rank_proveedor.granel  . 
DEFINE VARIABLE tot_subtotal    LIKE Rank_proveedor.subtotal. 

DEFINE VARIABLE tfm_cantidad    LIKE Rank_proveedor.cantidad. 
DEFINE VARIABLE tfm_granel      LIKE Rank_proveedor.granel  . 
DEFINE VARIABLE tfm_subtotal    LIKE Rank_proveedor.subtotal. 

DEFINE VARIABLE tip_cantidad    LIKE Rank_proveedor.cantidad. 
DEFINE VARIABLE tip_granel      LIKE Rank_proveedor.granel  . 
DEFINE VARIABLE tip_subtotal    LIKE Rank_proveedor.subtotal. 

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Total de Compras por Articulo y Proveedor" AT 40 
  "Página:" AT 136 PAGE-NUMBER FORMAT ">>>9" AT 144
  SKIP
  fecha_lis
  "Del" AT 40
  des_fecha
  "al"
  has_fecha
  hora_lis AT 136
  SKIP
  "Importes expresados en :" AT 40
  v-desc_mon 
  SKIP
  "Fitro:" AT 40 
  p-filtro_atributos FORMAT "X(60)"
  SKIP(1)
  "---------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código       Descripción                                               Importe Total     Cant. Total          Granel Total             Precio      " SKIP
  "Articulo     Artículo                                                       Comprado        Comprado               Vendido           Promedio      " SKIP
  "                                                                                                                                                   " SKIP
  "             Código   Razón                                                 Importe Total     Cant. Total          Granel Total             Precio " SKIP
  "           Proveedor  Social                                                    Proveedor       Proveedor             Proveedor           Promedio " SKIP
  "---------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 230 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Articulo.cdg_articulo /* No se muestra, es para identar correctamente */
  Proveedor.cdg_proveedor
  SPACE(1)
  Proveedor.nombre
  SPACE(10)
  Rank_proveedor.subtotal
  Rank_proveedor.cantidad
  Unidad.abrevia
  Rank_proveedor.granel
  Unigranel.abrevia
  precio_prom_cli
  WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-listado-art
  Articulo.cdg_articulo
  Articulo.descripcion
  Articulo.a_granel FORMAT " */  "
  Rank_articulo.subtotal
  Rank_articulo.cantidad
  Unidad.abrevia
  Rank_articulo.granel
  Unigranel.abrevia 
  precio_prom_art
  WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

{fnverificatributos.i}

/*=================================================================================*/
/*                                BLOQUE PRINCIAPL                                 */
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

  {dirprinfile.i}

  FIND Moneda_expresion WHERE Moneda_expresion.cdg_moneda = p-cdg_moneda NO-LOCK.
  
  ASSIGN v-cod_mon  = Moneda_expresion.cdg_moneda             
         v-desc_mon = Moneda_expresion.descripcion.
             
  IF p-ver_cotizacion = 1 
      THEN X-Fec_Cotizar= STRING(X-Fec_Cotiza,"99-99-9999").
      ELSE X-Fec_Cotizar = 'Correspondiente a cada Transacción'.

  FOR EACH Fac_header_prv NO-LOCK
         WHERE Fac_header_prv.cdg_empresa = Empresa.cdg_empresa 
           AND Fac_header_prv.fecha <= has_fecha
           AND Fac_header_prv.fecha >= des_fecha
           AND NOT Fac_header_prv.anulado,
      FIRST Proveedor OF Fac_header_prv 
            WHERE LOOKUP(que_sector, Proveedor.lista_sectores) <> 0 NO-LOCK,
      FIRST Tipocomprobante OF Fac_header_prv NO-LOCK,
      FIRST Imputacion OF Fac_header_prv NO-LOCK,
      FIRST Moneda OF Fac_header_prv NO-LOCK,
            EACH Fac_detalle_prv OF Fac_header_prv NO-LOCK, 
         FIRST Articulo OF Fac_detalle_prv WHERE Articulo.cdg_articulo <= has_codigo
                                         AND Articulo.cdg_articulo >= des_codigo
                                             NO-LOCK:

      IF fncumpleatributos ( Articulo.lista_atributos, p-filtro_atributos )
      THEN DO:
          FIND FIRST Rank_articulo WHERE Rank_articulo.nro_articulo = Articulo.nro_articulo NO-ERROR.
          IF NOT AVAILABLE Rank_articulo
          THEN DO:
              CREATE Rank_articulo.
              ASSIGN Rank_articulo.nro_articulo = Articulo.nro_articulo.
          END.
    
          FIND FIRST Rank_proveedor 
               WHERE Rank_proveedor.nro_proveedor  = Proveedor.nro_proveedor 
                 AND Rank_proveedor.nro_articulo = Fac_detalle_prv.nro_articulo 
                     NO-ERROR.
          IF NOT AVAILABLE Rank_proveedor
          THEN DO:
              CREATE Rank_proveedor.
              ASSIGN Rank_proveedor.nro_proveedor = Proveedor.nro_proveedor. 
                     Rank_proveedor.nro_articulo = Fac_detalle_prv.nro_articulo. 
          END.
    
          IF Tipocomprobante.debita
              THEN signo = -1.
              ELSE signo = 1.
    

          /*
          IF Moneda.es_local
          THEN DO:
              IF Moneda_expresion.es_local
              THEN DO:
                  x-importe = Fac_detalle_prv.subtotal_neto.
              END.
              ELSE DO:
                  RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda, INPUT Moneda_expresion.cdg_moneda, INPUT Fac_header_prv.fecha, INPUT Fac_detalle_prv.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).
                  x-importe = ROUND(Fac_detalle_prv.subtotal_neto / x-cambio,2).
              END.
          END.
          ELSE DO:
              IF Moneda_expresion.es_local
              THEN DO:
                  x-importe = ROUND(Fac_detalle_prv.subtotal_neto * Fac_header_prv.cambio,2).
              END.
              ELSE DO:
                  x-importe = Fac_detalle_prv.subtotal_neto.
              END.
          END.
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

          ASSIGN Rank_articulo.subtotal = Rank_articulo.subtotal + signo * x-importe.
                 Rank_proveedor.subtotal  = Rank_proveedor.subtotal + signo * x-importe.
          
          IF Imputacion.afecta_stock
        /*IF Imputacion.afecta_rendicion*/
          THEN DO:

              IF Tipocomprobante.afecta_stock
              THEN DO:
                  ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle_prv.cantidad
                         Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle_prv.granel.
    
                  ASSIGN Rank_proveedor.cantidad = Rank_proveedor.cantidad + signo * Fac_detalle_prv.cantidad
                         Rank_proveedor.granel   = Rank_proveedor.granel   + signo * Fac_detalle_prv.granel.
              END.

          END.

      END.

  END.               

  ASSIGN tfm_cantidad = 0
         tfm_granel   = 0
         tfm_subtotal = 0
         tip_cantidad = 0
         tip_granel   = 0
         tip_subtotal = 0.

  FOR EACH Rank_articulo 
      WHERE Rank_articulo.subtotal <> 0 OR cero_sino, 
         FIRST Articulo OF Rank_articulo, 
         FIRST Unidad OF Articulo,
         FIRST Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel,
         FIRST Familia_articulo OF Articulo, 
         FIRST Tipo_familiarticulo OF Familia_articulo
       BREAK BY Tipo_familiarticulo.cdg_tipofamilia 
             BY Familia_articulo.cdg_familia 
             BY Articulo.cdg_articulo:

      VIEW FRAME frm-titulo. 

      precio_prom_art = ( IF Articulo.a_granel 
                THEN Rank_articulo.subtotal / Rank_articulo.granel
                ELSE Rank_articulo.subtotal / Rank_articulo.cantidad ).

      DISPLAY Articulo.cdg_articulo
              Articulo.descripcion
              Articulo.a_granel
              Rank_articulo.subtotal
              Rank_articulo.cantidad
              Unidad.abrevia
              Rank_articulo.granel
              Unigranel.abrevia
              precio_prom_art WHEN precio_prom_art <> ?
              WITH FRAME frm-listado-art.
      DOWN WITH FRAME frm-listado-art.

      IF det_sino
      THEN DO:
        
         FOR EACH Rank_proveedor OF Articulo, Proveedor OF Rank_proveedor NO-LOCK BY Proveedor.cdg_proveedor:            
                    
             precio_prom_cli = ( IF Articulo.a_granel 
                                    THEN Rank_proveedor.subtotal / Rank_proveedor.granel
                                    ELSE Rank_proveedor.subtotal / Rank_proveedor.cantidad ).

             DISPLAY Proveedor.cdg_proveedor
                     Proveedor.nombre
                     Rank_proveedor.cantidad
                     Rank_proveedor.granel
                     Rank_proveedor.subtotal
                     precio_prom_cli WHEN precio_prom_cli <> ?
                     WITH FRAME frm-listado-cli.
             DOWN WITH FRAME frm-listado-cli.
         END.

         DOWN 1 WITH FRAME frm-listado-cli.

      END.

      ASSIGN tfm_cantidad = tfm_cantidad + Rank_articulo.cantidad  
             tfm_granel   = tfm_granel   + Rank_articulo.granel    
             tfm_subtotal = tfm_subtotal + Rank_articulo.subtotal .

      IF LAST-OF(Familia_articulo.cdg_familia)
      THEN DO:

          UNDERLINE Articulo.cdg_articulo
                    Articulo.descripcion
                    Articulo.a_granel
                    Rank_articulo.subtotal
                    Rank_articulo.cantidad
                    Unidad.abrevia
                    Rank_articulo.granel
                    Unigranel.abrevia
                    WITH FRAME frm-listado-art.
          DOWN WITH FRAME frm-listado-art.
        
          DISPLAY "Total " + Familia_articulo.dsc_familia @ Articulo.descripcion
                                  tfm_cantidad @ Rank_articulo.cantidad
                                  tfm_granel   @ Rank_articulo.granel  
                                  tfm_subtotal @ Rank_articulo.subtotal
                                  WITH FRAME frm-listado-art.
          DOWN 2 WITH FRAME frm-listado-art.

          ASSIGN tip_cantidad = tip_cantidad + tfm_cantidad   
                 tip_granel   = tip_granel   + tfm_granel     
                 tip_subtotal = tip_subtotal + tfm_subtotal.


          ASSIGN tfm_cantidad = 0
                 tfm_granel   = 0
                 tfm_subtotal = 0.

      END.

      IF LAST-OF(Tipo_familiarticulo.cdg_tipofamilia)
      THEN DO:

          UNDERLINE Articulo.cdg_articulo
                    Articulo.descripcion
                    Articulo.a_granel
                    Rank_articulo.subtotal
                    Rank_articulo.cantidad
                    Unidad.abrevia
                    Rank_articulo.granel
                    Unigranel.abrevia
                    WITH FRAME frm-listado-art.
          DOWN WITH FRAME frm-listado-art.
        
          DISPLAY "Total " + Tipo_familiarticulo.dsc_tipofamilia @ Articulo.descripcion
                                  tip_cantidad @ Rank_articulo.cantidad
                                  tip_granel   @ Rank_articulo.granel  
                                  tip_subtotal @ Rank_articulo.subtotal
                                  WITH FRAME frm-listado-art.
          DOWN 2 WITH FRAME frm-listado-art.

          ASSIGN tip_cantidad = 0
                 tip_granel   = 0
                 tip_subtotal = 0.

      END.

  END.

  ASSIGN tot_cantidad = 0
         tot_granel   = 0
         tot_subtotal = 0.

  FOR EACH Rank_articulo:

      ASSIGN tot_cantidad = tot_cantidad + Rank_articulo.cantidad 
             tot_granel   = tot_granel   + Rank_articulo.granel   
             tot_subtotal = tot_subtotal + Rank_articulo.subtotal .
  END.

  UNDERLINE Articulo.cdg_articulo
            Articulo.descripcion
            Articulo.a_granel
            Rank_articulo.subtotal
            Rank_articulo.cantidad
            Unidad.abrevia
            Rank_articulo.granel
            Unigranel.abrevia
            WITH FRAME frm-listado-art.
  DOWN WITH FRAME frm-listado-art.

  DISPLAY "TOTAL GENERAL" @ Articulo.descripcion
             tot_cantidad @ Rank_articulo.cantidad
             tot_granel   @ Rank_articulo.granel  
             tot_subtotal @ Rank_articulo.subtotal
             WITH FRAME frm-listado-art.
  DOWN WITH FRAME frm-listado-art.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

END PROCEDURE.
