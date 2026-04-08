/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULO                                   */
/*                  Ranking de Articulos con o sin detalle de Clientes                */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo       LIKE Cliente.cdg_cliente.

DEFINE INPUT PARAMETER des_fecha        AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER has_fecha        AS DATE LABEL "Hasta Fecha" INITIAL TODAY.

DEFINE INPUT PARAMETER det_sino         AS LOGICAL. 
DEFINE INPUT PARAMETER cero_sino        AS LOGICAL.

DEFINE INPUT PARAMETER p-cdg_moneda     AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion AS INTEGER.
DEFINE INPUT PARAMETER p-fecha          AS DATE.

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
   FIELD cantidad            LIKE Fac_detalle.cantidad
   FIELD granel              LIKE Fac_detalle.granel
   FIELD subtotal            LIKE Fac_detalle.subtotal_neto
   INDEX por_articulo        IS PRIMARY nro_articulo ASCENDING
   INDEX por_importe subtotal DESCENDING.

DEFINE WORK-TABLE Rank_cliente
   FIELD nro_articulo LIKE Articulo.nro_articulo
   FIELD nro_cliente  LIKE Cliente.nro_cliente
   FIELD cantidad     LIKE Fac_detalle.cantidad
   FIELD granel       LIKE Fac_detalle.granel
   FIELD subtotal     LIKE Fac_detalle.subtotal_neto.

DEFINE VARIABLE gastado_art     AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE gastado_cli     AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Cliente".
DEFINE VARIABLE precio_prom_cli LIKE Fac_detalle.precio LABEL "Precio Promedio".
DEFINE VARIABLE precio_prom_art LIKE Fac_detalle.precio LABEL "Precio Promedio".
DEFINE VARIABLE X-Importe       AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE X-Fec_Cotiza    AS DATE.
DEFINE VARIABLE signo           AS INTEGER.
DEFINE VARIABLE v-cod_mon       AS CHARACTER. 
DEFINE VARIABLE v-modo_cotiza   AS CHARACTER. 
DEFINE VARIABLE v-fecha_cotiza  AS DATE. 
DEFINE VARIABLE v-desc_mon      AS CHARACTER FORMAT "X(20)". 
DEFINE VARIABLE que_sector      LIKE Area.cdg_area.

DEFINE VARIABLE tot_cantidad    LIKE Rank_cliente.cantidad. 
DEFINE VARIABLE tot_granel      LIKE Rank_cliente.granel  . 
DEFINE VARIABLE tot_subtotal    LIKE Rank_cliente.subtotal. 

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Total de Ventas por Articulo y Cliente" AT 40 
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
  "Fecha de Cotización:" AT 40 
  X-Fec_Cotizar
  SKIP(1)
  "---------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código       Descripción                                               Importe Total     Cant. Total          Granel Total             Precio      " SKIP
  "Articulo     Artículo                                                        Vendido         Vendida               Vendido           Promedio      " SKIP
  "                                                                                                                                                   " SKIP
  "             Código   Razón                                                 Importe Total     Cant. Total          Granel Total             Precio " SKIP
  "             Cliente  Social                                                      Cliente         Cliente               Cliente           Promedio " SKIP
  "---------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 230 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Articulo.cdg_articulo /* No se muestra, es para identar correctamente */
  Cliente.cdg_cliente
  SPACE(1)
  Cliente.nom_cliente
  SPACE(10)
  Rank_cliente.subtotal
  Rank_cliente.cantidad
  Unidad.abrevia
  Rank_cliente.granel
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

  RUN getparametro_c.p ( INPUT "MDCOTIZA", OUTPUT v-modo_cotiza ).

  FIND Moneda_expresion WHERE Moneda_expresion.cdg_moneda = p-cdg_moneda NO-LOCK.
  
  ASSIGN v-cod_mon  = Moneda_expresion.cdg_moneda             
         v-desc_mon = Moneda_expresion.descripcion.

  FOR EACH Fac_header NO-LOCK
         WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa 
           AND Fac_header.fecha <= has_fecha
           AND Fac_header.fecha >= des_fecha
           AND NOT Fac_header.anulado,
      FIRST Cliente OF Fac_header 
      WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Imputacion OF Fac_header NO-LOCK,
      FIRST Moneda OF Fac_header NO-LOCK,
            EACH Fac_detalle OF Fac_header NO-LOCK, 
         FIRST Articulo OF Fac_detalle WHERE Articulo.cdg_articulo <= has_codigo
                                         AND Articulo.cdg_articulo >= des_codigo NO-LOCK:

      FIND FIRST Rank_articulo WHERE Rank_articulo.nro_articulo = Articulo.nro_articulo NO-ERROR.
      IF NOT AVAILABLE Rank_articulo
      THEN DO:
          CREATE Rank_articulo.
          ASSIGN Rank_articulo.nro_articulo = Articulo.nro_articulo.
      END.

      FIND FIRST Rank_cliente 
           WHERE Rank_cliente.nro_cliente  = Cliente.nro_cliente 
             AND Rank_cliente.nro_articulo = Fac_detalle.nro_articulo 
                 NO-ERROR.
      IF NOT AVAILABLE Rank_cliente
      THEN DO:
          CREATE Rank_cliente.
          ASSIGN Rank_cliente.nro_cliente = Cliente.nro_cliente. 
                 Rank_cliente.nro_articulo = Fac_detalle.nro_articulo. 
      END.

      IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.

      /* --------- ANULADO 22/02/06 CR en Berkes (perdon Von Neuman, pero hay que comer.....)
      IF p-ver_cotizacion = 1 
      THEN DO:  /* Cotizaciones a una fecha dada */
          v-fecha_cotiza = p-fecha. 
          X-Fec_Cotizar= STRING(X-Fec_Cotiza,"99-99-9999").
          RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda, INPUT Moneda_expresion.cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).
      END.
      ELSE DO: /* Cotizaciones de cada a una fecha dada */
          
          RUN cotizar_moneda.p ( INPUT  p-cdg_moneda_reexpresada,
                                 INPUT  Empresa.cdg_empresa, 
                                 INPUT  p-fecha_cotizacion,       
                                 OUTPUT x-cotizacion_reexpresada,  
                                 OUTPUT p-fecha_real_cotizacion ).

          IF v-modo_cotiza = v-dividir
             THEN p-tasa_cambio = x-cotizacion_original / x-cotizacion_reexpresada.
             ELSE p-tasa_cambio = x-cotizacion_reexpresada / x-cotizacion_original.
           
          ASSIGN v-fecha_cotiza = Fac_header.fecha
                 X-Fec_Cotizar = 'Correspondiente a cada Transacción'.
                 x-importe = ROUND(Fac_detalle.subtotal_neto * Fac_header.cambio,2).
      END.
      */

      ASSIGN x-importe              = ROUND(Fac_detalle.subtotal_neto * Fac_header.cambio,2)
             Rank_articulo.subtotal = Rank_articulo.subtotal + signo * x-importe.
             Rank_cliente.subtotal  = Rank_cliente.subtotal + signo * x-importe.
      
      IF Imputacion.afecta_stock
    /*IF Imputacion.afecta_rendicion*/
      THEN DO:
          IF Tipocomprobante.afecta_stock
          THEN DO:
              ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle.cantidad
                     Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle.granel.

              ASSIGN Rank_cliente.cantidad = Rank_cliente.cantidad + signo * Fac_detalle.cantidad
                     Rank_cliente.granel   = Rank_cliente.granel   + signo * Fac_detalle.granel.
          END.
      END.
      
  END.               

  FOR EACH Rank_articulo, Articulo OF Rank_articulo,  
      Unidad OF Articulo,
       Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel
       BY Articulo.cdg_articulo:

      VIEW FRAME frm-titulo. 
      IF Rank_articulo.subtotal <> 0 OR cero_sino
      THEN DO:
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
      END.

      IF det_sino AND ( Rank_articulo.subtotal <> 0 OR cero_sino ) 
      THEN DO:
        
         FOR EACH Rank_cliente OF Articulo, Cliente OF Rank_cliente NO-LOCK BY Cliente.cdg_cliente:            
                    
             precio_prom_cli = ( IF Articulo.a_granel 
                                 THEN Rank_cliente.subtotal / Rank_cliente.granel
                                 ELSE Rank_cliente.subtotal / Rank_cliente.cantidad ).

             DISPLAY Cliente.cdg_cliente
                     Cliente.nom_cliente
                     Rank_cliente.cantidad
                     Rank_cliente.granel
                     Rank_cliente.subtotal
                     precio_prom_cli WHEN precio_prom_cli <> ?
                     WITH FRAME frm-listado-cli.
             DOWN WITH FRAME frm-listado-cli.
         END.

         DOWN 1 WITH FRAME frm-listado-cli.

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
