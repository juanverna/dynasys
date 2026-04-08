/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULO                                   */
/*                  Ranking de Articulos con o sin detalle de Clientes                */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.

DEFINE INPUT PARAMETER des_fecha   AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER has_fecha   AS DATE LABEL "Hasta Fecha" INITIAL TODAY.

DEFINE INPUT PARAMETER det_sino AS LOGICAL. 
DEFINE INPUT PARAMETER cero_sino AS LOGICAL.

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

DEFINE VARIABLE tot_cant_articulo AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE precio_prom LIKE Fac_detalle.precio LABEL "Precio Promedio".
DEFINE VARIABLE X-Importe AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE X-Fec_Cotiza   AS DATE.
DEFINE VARIABLE signo     AS INTEGER.
DEFINE VARIABLE v-cod_mon AS CHARACTER. 
DEFINE VARIABLE v-fecha_cotiza AS DATE. 
DEFINE VARIABLE v-desc_mon AS CHARACTER FORMAT "X(20)". 
DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

DEFINE TEMP-TABLE Rank_articulo
   FIELD nro_articulo        LIKE Articulo.nro_articulo
   FIELD nro_partida         LIKE Partida.nro_partida
   FIELD cantidad            LIKE Fac_detalle.cantidad
   FIELD granel              LIKE Fac_detalle.granel
   FIELD importe             LIKE Fac_detalle.subtotal_neto
   INDEX por_articulo        IS PRIMARY nro_articulo nro_partida ASCENDING
   INDEX por_importe importe DESCENDING.


DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Total de Ventas por Partida y Cliente" AT 40 
  "Página:" AT 97 PAGE-NUMBER FORMAT ">>>9" AT 105
  SKIP
  fecha_lis
  "Del" AT 40
  des_fecha
  "al"
  has_fecha
  hora_lis AT 115
  SKIP
  "Importes expresados en :" AT 40
  v-desc_mon 
  SKIP
  "Fecha de Cotización:" AT 40 
  X-Fec_Cotizar
  SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-listado-art
  Articulo.cdg_articulo
  Articulo.descripcion
  Partida.cdg_partida    COLUMN-LABEL "Còdigo!Partida" 
  Rank_articulo.cantidad COLUMN-LABEL "Total!Unidades"
  Articulo.cdg_umed      COLUMN-LABEL "Unidad!Articulo"
  Rank_articulo.importe  COLUMN-LABEL "Total!Importe"
  WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                                BLOQUE PRINCIAPL                                 */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

RUN listar.
RETURN.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE listar:

  {dirprinfile.i}

  FOR EACH Fac_header
         WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa 
           AND Fac_header.fecha <= has_fecha
           AND Fac_header.fecha >= des_fecha USE-INDEX por_fecha,
      FIRST Cliente OF Fac_header
      WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header,
      FIRST Moneda OF Fac_header,
            EACH Fac_detalle OF Fac_header, 
         FIRST Articulo OF Fac_detalle WHERE Articulo.cdg_articulo <= has_codigo
                                         AND Articulo.cdg_articulo >= des_codigo:
                     
      FIND FIRST Rank_articulo 
          WHERE Rank_articulo.nro_articulo = Fac_detalle.nro_articulo 
            AND Rank_articulo.nro_partida  = Fac_detalle.nro_partida
                NO-ERROR.
      IF NOT AVAILABLE Rank_articulo
      THEN DO:
          CREATE Rank_articulo.
          ASSIGN Rank_articulo.nro_articulo = Fac_detalle.nro_articulo 
                 Rank_articulo.nro_partida  = Fac_detalle.nro_partida.

      END.

      IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.

      ASSIGN v-cod_mon = moneda.cdg_moneda             
             v-desc_mon = moneda.descripcion.

      /*
      IF p-ver_cotizacion = 1 THEN
         v-fecha_cotiza = p-fecha. 
      ELSE
         ASSIGN v-fecha_cotiza = Fac_header.fecha
                X-Fec_Cotizar = 'Correspondiente a cada Transacción'.

      RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).
      IF p-ver_cotizacion = 1 THEN
      X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").
      */
      Rank_articulo.importe = Rank_articulo.importe + signo * Fac_detalle.subtotal_neto.
      
      IF Imputacion.afecta_stock
      THEN DO:
          IF Tipocomprobante.afecta_stock
          THEN DO:
              ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle.cantidad
                     Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle.granel.
          END.
      END.
      
  END.               

  FOR EACH Rank_articulo WHERE Rank_articulo.importe <> 0 OR cero_sino, 
      Articulo OF Rank_articulo,  
      Unidad OF Articulo,
       Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel, Partida OF Rank_articulo
       BREAK BY Articulo.cdg_articulo BY Partida.cdg_partida:

      VIEW FRAME frm-titulo. 
      DISPLAY Articulo.cdg_articulo  WHEN FIRST-OF(Articulo.cdg_articulo)
              Articulo.descripcion   WHEN FIRST-OF(Articulo.cdg_articulo)
              Articulo.cdg_umed         WHEN FIRST-OF(Articulo.cdg_articulo)
              Partida.cdg_partida
              Rank_articulo.importe
              Rank_articulo.cantidad
              WITH FRAME frm-listado-art.
      DOWN WITH FRAME frm-listado-art.

      tot_cant_articulo = tot_cant_articulo + Rank_articulo.cantidad.
      IF LAST-OF(Articulo.cdg_articulo)
      THEN DO:
          UNDERLINE Articulo.cdg_articulo  
                    Articulo.descripcion   
                    Partida.cdg_partida
                    Rank_articulo.importe
                    Rank_articulo.cantidad
                    Articulo.cdg_umed         
                    WITH FRAME frm-listado-art.
          DISPLAY tot_cant_articulo @ Rank_articulo.cantidad
                   WITH FRAME frm-listado-art.
          DOWN 2 WITH FRAME frm-listado-art.
          tot_cant_articulo = 0.
      END.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

END PROCEDURE.
