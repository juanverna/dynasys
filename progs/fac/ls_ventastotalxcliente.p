/*====================================================================================*/
/*                        ESTADISTICAS POR VENTAS                                     */
/*                  Ranking de Clientes sin detalle de articulos                      */
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

DEFINE VARIABLE v-cod_mon      AS CHARACTER.
DEFINE VARIABLE X-IMPORTE      AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-FEC_COTIZA   AS DATE.
DEFINE VARIABLE X-FEC_COTIZAR   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.    
DEFINE VARIABLE v-desc_mon AS CHARACTER FORMAT "X(20)".

DEFINE VARIABLE gastado_cli AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Cliente".

DEFINE VARIABLE signo     AS INTEGER.
DEFINE VARIABLE v-total   AS DECIMAL.

DEFINE TEMP-TABLE Rank_cliente
   FIELD nro_cliente         LIKE Cliente.nro_cliente
   FIELD importe             LIKE Fac_detalle.subtotal_neto
   INDEX por_cliente         IS PRIMARY nro_cliente ASCENDING
   INDEX por_importe importe DESCENDING.


DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Ventas Totales por Cliente" AT 50
  "Página:" AT 115 PAGE-NUMBER FORMAT ">>>9" AT 123
  SKIP
  fecha_lis
  "del" AT 50
  des_fecha
  "al"
  has_fecha
  hora_lis AT 115
    SKIP
  "Importes expresados en :" AT 50
  v-desc_mon 
  SKIP
  "Fecha de Cotización:" AT 50 
  X-Fec_Cotizar
  SKIP(1)

  "------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Código     Razón                                   Total Comprado                                                             " SKIP
  "Cliente    Social                                        Cliente                                                              " SKIP
  "                                                                                                                              " SKIP
  "------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente AT 2
  SPACE(1)
  Cliente.nom_cliente
  SPACE(2)
  Rank_cliente.importe
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
           AND Fac_header.fecha >= des_fecha
           AND NOT Fac_header.anulado,
      FIRST Cliente OF Fac_header 
          WHERE Cliente.cdg_cliente >= des_codigo
            AND Cliente.cdg_cliente <= has_codigo,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header:
                     
      FIND FIRST Rank_cliente WHERE Rank_cliente.nro_cliente = Cliente.nro_cliente NO-ERROR.
      IF NOT AVAILABLE Rank_cliente
      THEN DO:
          CREATE Rank_cliente.
          ASSIGN Rank_cliente.nro_cliente = Cliente.nro_cliente.
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
                     X-FEC_COTIZAR = 'Correspondiente a cada Transacción'.

            RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_total, OUTPUT X-IMPORTE, OUTPUT X-FEC_COTIZA ).

            IF p-ver_cotizacion = 1 THEN
            X-FEC_COTIZAR= string(X-FEC_COTIZA,"99-99-9999").


      Rank_cliente.importe = Rank_cliente.importe + signo *  X-IMPORTE.

  END.               

  FOR EACH Rank_cliente, Cliente OF Rank_cliente BY Rank_cliente.importe DESCENDING:

  v-total= v-total + Rank_cliente.importe.

      VIEW FRAME frm-titulo. 
      IF Rank_cliente.importe <> 0 OR cero_sino
      THEN DO:
         DISPLAY Cliente.cdg_cliente
                 Cliente.nom_cliente
                 Rank_cliente.importe
                 WITH FRAME frm-listado-cli.
         DOWN WITH FRAME frm-listado-cli.
      END.

  END. 
             
UNDERLINE Rank_cliente.importe WITH FRAME frm-listado-cli.

DISPLAY v-total @ Rank_cliente.importe WITH FRAME frm-listado-cli.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                   INPUT 22 ).

END PROCEDURE.


