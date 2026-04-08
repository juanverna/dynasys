/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULO                                   */
/*                  Ranking de Articulos con o sin detalle de Clientes                */
/*====================================================================================*/

DEFINE INPUT PARAMETER  que_codigo           LIKE Articulo.cdg_articulo.

DEFINE INPUT PARAMETER  des_fecha            AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER  has_fecha            AS DATE LABEL "Hasta Fecha" INITIAL TODAY.
                                            
DEFINE INPUT PARAMETER  det_sino             AS LOGICAL. 
DEFINE INPUT PARAMETER  cero_sino            AS LOGICAL.
                                            
DEFINE INPUT PARAMETER  p-cdg_moneda         AS CHARACTER.
DEFINE INPUT PARAMETER  p-ver_cotizacion     AS INTEGER.
DEFINE INPUT PARAMETER  p-fecha              AS DATE.
                                            
DEFINE INPUT PARAMETER  p-filtro_atributos   AS CHARACTER.

DEFINE OUTPUT PARAMETER p-tot_cantidad       LIKE Fac_detalle.cantidad.     
DEFINE OUTPUT PARAMETER p-tot_granel         LIKE Fac_detalle.granel.       
DEFINE OUTPUT PARAMETER p-tot_subtotal       LIKE Fac_detalle.subtotal_neto.



/*====================================================================================*/
/*                  VARIABLES, FRAMES Y TABLAS TEMPORALES                             */
/*====================================================================================*/

DEFINE BUFFER Moneda_expresion FOR Moneda.

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

DEFINE VARIABLE tot_cantidad    LIKE Fac_detalle.cantidad. 
DEFINE VARIABLE tot_granel      LIKE Fac_detalle.granel  . 
DEFINE VARIABLE tot_subtotal    LIKE Fac_detalle.subtotal_neto. 
DEFINE VARIABLE suma_intangible AS LOGICAL NO-UNDO.
DEFINE VARIABLE suma_tangible AS LOGICAL NO-UNDO.

{fnverificatributos.i}

/*=================================================================================*/
/*                                BLOQUE PRINCIAPL                                 */
/*=================================================================================*/

{findempresa.i}

{findsector.i}
que_sector = Area.cdg_area.

RUN listar.

RETURN.

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE listar:

  FIND Moneda_expresion WHERE Moneda_expresion.cdg_moneda = p-cdg_moneda NO-LOCK.
  FIND Articulo WHERE Articulo.cdg_articulo = que_codigo NO-LOCK.

  ASSIGN tot_cantidad = 0
         tot_granel   = 0
         tot_subtotal = 0.
  
  FOR EACH Fac_detalle OF Articulo NO-LOCK,
      EACH Fac_header NO-LOCK OF Fac_detalle
         WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa 
           AND Fac_header.fecha <= has_fecha
           AND Fac_header.fecha >= des_fecha
           AND NOT Fac_header.anulado,
      FIRST Cliente OF Fac_header 
            WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Imputacion OF Fac_header NO-LOCK,
      FIRST Moneda OF Fac_header NO-LOCK:

      IF fncumpleatributos ( Articulo.lista_atributos, p-filtro_atributos ) 
      THEN DO:

          IF Tipocomprobante.debita
              THEN signo = 1.
              ELSE signo = -1.


          IF p-ver_cotizacion = 1 
               THEN RUN reexpresar_importe.p ( INPUT Moneda.cdg_moneda, 
                                               INPUT Moneda_expresion.cdg_moneda, 
                                               INPUT x-fec_cotiza, 
                                               INPUT Fac_detalle.subtotal_neto, 
                                               OUTPUT x-importe, 
                                               OUTPUT x-fec_cotiza ).


               ELSE x-importe = Fac_detalle.subtotal_neto * Fac_header.cambio.         

          ASSIGN tot_subtotal = tot_subtotal + signo * x-importe.
          RUN getparametro_l.p(INPUT "SUMAINT", OUTPUT suma_intangible ).
          RUN getparametro_l.p(INPUT "SUMATAN", OUTPUT suma_tangible ).
          IF ( Imputacion.afecta_stock AND suma_tangible ) OR ( NOT Imputacion.afecta_stock AND suma_intangible )
        /*IF Imputacion.afecta_rendicion*/
          THEN DO:

              IF Tipocomprobante.afecta_stock
              THEN DO:
                  ASSIGN tot_cantidad = tot_cantidad + signo * Fac_detalle.cantidad
                         tot_granel   = tot_granel   + signo * Fac_detalle.granel.
              END.

          END.

      END.

  END.               

  ASSIGN p-tot_cantidad = tot_cantidad 
         p-tot_granel   = tot_granel   
         p-tot_subtotal = tot_subtotal.

  
END PROCEDURE.
