/*====================================================================================*/
/*                        ESTADISTICAS POR CLIENTE                                    */
/*                  Ranking de Clientes con o sin detalle de articulos                */
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

DEFINE VARIABLE gastado_art    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot.Articulo".
DEFINE VARIABLE gastado_cli    AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Cliente".
DEFINE VARIABLE precio_prom    LIKE Fac_detalle.precio LABEL "Precio Promedio".
DEFINE VARIABLE signo          AS INTEGER.
DEFINE VARIABLE v-cod_mon      AS CHARACTER.
DEFINE VARIABLE X-Importe      AS DECIMAL.
DEFINE VARIABLE X-Fec_Cotiza   AS DATE.
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.    
DEFINE VARIABLE v-desc_mon     AS CHARACTER FORMAT "X(20)".

DEFINE TEMP-TABLE Rank_cliente
   FIELD nro_cliente         LIKE Cliente.nro_cliente
   FIELD importe             LIKE Fac_detalle.subtotal_neto
   INDEX por_cliente         IS PRIMARY nro_cliente ASCENDING
   INDEX por_importe importe DESCENDING.

DEFINE WORK-TABLE Rank_articulo
   FIELD nro_cliente  LIKE Cliente.nro_cliente
   FIELD nro_articulo LIKE Articulo.nro_articulo
   FIELD cantidad     LIKE Fac_detalle.cantidad
   FIELD granel       LIKE Fac_detalle.granel
   FIELD subtotal     LIKE Fac_detalle.subtotal_neto.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Total de Ventas por Cliente y Articulo" AT 40
  "Página:" AT 115 PAGE-NUMBER FORMAT ">>>9" AT 123
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
  "------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Razón                                   Total Comprado                                                             " SKIP
  "Cliente    Social                                        Cliente                                                              " SKIP
  "                                                                                                                              " SKIP
  "    Código      Descripción                                           Total            Total               Total        Precio" SKIP
  "    Articulo    Artículo                                           Unidades           Granel             Vendido      Promedio" SKIP
  "------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  SPACE(1)
  Cliente.nom_cliente
  SPACE(2)
  Rank_cliente.importe
  WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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
      FIRST Cliente OF Fac_header 
          WHERE Cliente.cdg_cliente >= des_codigo
            AND Cliente.cdg_cliente <= has_codigo,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header,
            EACH Fac_detalle OF Fac_header, FIRST Articulo OF Fac_detalle:
                     
      FIND FIRST Rank_cliente WHERE Rank_cliente.nro_cliente = Cliente.nro_cliente NO-ERROR.
      IF NOT AVAILABLE Rank_cliente
      THEN DO:
          CREATE Rank_cliente.
          ASSIGN Rank_cliente.nro_cliente = Cliente.nro_cliente.
      END.

      FIND FIRST Rank_articulo 
           WHERE Rank_articulo.nro_cliente = Cliente.nro_cliente 
             AND Rank_articulo.nro_articulo = Fac_detalle.nro_articulo 
                 NO-ERROR.
      IF NOT AVAILABLE Rank_articulo
      THEN DO:
          CREATE Rank_articulo.
          ASSIGN Rank_articulo.nro_cliente = Cliente.nro_cliente. 
                 Rank_articulo.nro_articulo = Fac_detalle.nro_articulo. 
      END.

      IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.

         FIND Moneda OF Fac_header NO-LOCK. 
         v-cod_mon = Moneda.cdg_moneda.

         FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
         v-desc_mon = Moneda.descripcion.

         IF p-ver_cotizacion = 1 THEN
            v-fecha_cotiza = p-fecha.
         ELSE
             ASSIGN v-fecha_cotiza = Fac_header.fecha
                    X-Fec_Cotizar = 'Correspondiente a cada Transacción'.

         RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_detalle.subtotal_neto, OUTPUT X-Importe, OUTPUT X-Fec_Cotiza ).

         IF p-ver_cotizacion = 1 
             THEN X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").

         Rank_cliente.importe   = Rank_cliente.importe + signo * X-Importe.
         Rank_articulo.subtotal = Rank_articulo.subtotal + signo * X-Importe.



         IF Imputacion.afecta_stock
      THEN DO:
          ASSIGN Rank_articulo.cantidad = Rank_articulo.cantidad + signo * Fac_detalle.cantidad
                 Rank_articulo.granel   = Rank_articulo.granel   + signo * Fac_detalle.granel.

      END.
      
  END.               

  FOR EACH Rank_cliente, Cliente OF Rank_cliente BY Cliente.cdg_cliente:

      VIEW FRAME frm-titulo. 
      IF Rank_cliente.importe <> 0 OR cero_sino
      THEN DO:
         DISPLAY Cliente.cdg_cliente
                 Cliente.nom_cliente
                 Rank_cliente.importe
                 WITH FRAME frm-listado-cli.
         DOWN WITH FRAME frm-listado-cli.
      END.

      IF (det_sino AND ( Rank_cliente.importe <> 0 OR cero_sino )) OR TRUE
      THEN DO:
        
         FOR EACH Rank_articulo OF Cliente, Articulo OF Rank_articulo, Unidad OF Articulo,
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


