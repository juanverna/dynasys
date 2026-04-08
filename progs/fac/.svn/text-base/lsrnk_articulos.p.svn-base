/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULOS                                  */
/*                  Ranking de Articulos con detalle de Clientes                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Articulo.cdg_articulo.
DEFINE INPUT PARAMETER has_codigo  LIKE Articulo.cdg_articulo.

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

DEFINE VARIABLE gastado_art    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE gastado_cli    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Cliente".
DEFINE VARIABLE precio_prom    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Precio Promedio".
DEFINE VARIABLE v-cod_mon      AS CHARACTER. 
DEFINE VARIABLE signo          AS INTEGER.
DEFINE VARIABLE X-Importe      AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotiza   AS DATE.
DEFINE VARIABLE X-Fec_Cotizar AS CHARACTER FORMAT "x(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.
DEFINE VARIABLE v-desc_mon     AS CHARACTER FORMAT "X(20)".

DEFINE TEMP-TABLE Rank_articulo
   FIELD nro_articulo        LIKE Articulo.nro_articulo
   FIELD cantidad            LIKE Fac_detalle.cantidad
   FIELD granel              LIKE Fac_detalle.granel
   FIELD importe             LIKE Fac_detalle.subtotal_neto
   INDEX por_articulo        IS PRIMARY nro_articulo ASCENDING
   INDEX por_importe importe DESCENDING.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Ranking de Articulos " AT 48
  "Página:" AT 115 PAGE-NUMBER FORMAT ">>>9" AT 123
  SKIP
  fecha_lis
  "Del" AT 48
  des_fecha
  "al"
  has_fecha
  hora_lis AT 115
  SKIP
  "Importes expresados en :" AT 48
  v-desc_mon 
  SKIP
  "Fecha de Cotización:" AT 48 
  X-Fec_Cotizar
  SKIP(1)
  "------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código        Descripción                                 Importe Total   Cant. Total     Granel Total          Precio        " SKIP
  "Articulo      Artículo                                          Vendido       Vendida          Vendido          Promedio      " SKIP
  "                                                                                                                              " SKIP
  "------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-art
 Articulo.cdg_articulo
 Articulo.descripcion
 Articulo.a_granel
 Rank_articulo.importe
 Rank_articulo.cantidad
 Unidad.abrevia
 Rank_articulo.granel
 Unigranel.abrevia
 precio_prom
 WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
           AND Fac_header.fecha >= des_fecha,
      FIRST Cliente OF Fac_header,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header,
            EACH Fac_detalle OF Fac_header, 
         FIRST Articulo OF Fac_detalle WHERE Articulo.cdg_articulo <= has_codigo
                                         AND Articulo.cdg_articulo >= des_codigo:
                     
      FIND FIRST Rank_articulo WHERE Rank_articulo.nro_articulo = Articulo.nro_articulo NO-ERROR.
      IF NOT AVAILABLE Rank_articulo
      THEN DO:
          CREATE Rank_articulo.
          ASSIGN Rank_articulo.nro_articulo = Articulo.nro_articulo.
      END.

      IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.


      FOR EACH moneda                                           
             WHERE moneda.nro_moneda = Fac_header.nro_moneda: 
             v-cod_mon = moneda.cdg_moneda                            
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

      RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza).
           
      IF p-ver_cotizacion = 1 THEN
      X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").

      Rank_articulo.importe = Rank_articulo.importe + signo * X-Importe.

      IF Tipocomprobante.afecta_stock
      THEN DO:
          ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle.cantidad
                 Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle.granel.

      END.
      
  END.               

  FOR EACH Rank_articulo, Articulo OF Rank_articulo,  
       Unidad OF Articulo,
       Unigranel WHERE Unigranel.cdg_umed = Articulo.cdg_ugranel
       BY Rank_articulo.importe DESCENDING:

      VIEW FRAME frm-titulo. 
      IF Rank_articulo.importe <> 0 OR cero_sino
      THEN DO:

         precio_prom = ( IF Articulo.a_granel 
                             THEN Rank_articulo.importe / Rank_articulo.granel
                             ELSE Rank_articulo.importe / Rank_articulo.cantidad ).

         DISPLAY Articulo.cdg_articulo
                 Articulo.descripcion
                 Articulo.a_granel
                 Rank_articulo.importe
                 Rank_articulo.cantidad
                 Unidad.abrevia
                 Rank_articulo.granel
                 Unigranel.abrevia
                 precio_prom
                 WITH FRAME frm-listado-art.
         DOWN WITH FRAME frm-listado-art.
      END.
    END.

  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

