/*=================================================================================*/
/*                              FACTURAS POR FECHA SIN DETALLE                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo       LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo       LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER det_sino         AS LOGICAL. 
DEFINE INPUT PARAMETER cero_sino        AS LOGICAL.
DEFINE INPUT PARAMETER p-cdg_moneda     AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion AS INTEGER.
DEFINE INPUT PARAMETER p-fecha          AS DATE.
/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

DEFINE VARIABLE que_factura     AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE que_remito      AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE X-Precio        AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEFINE VARIABLE X-Importe       AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEFINE VARIABLE X-Neto          AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEFINE VARIABLE X-Iva           AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotizar   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE X-Fec_Cotiza    AS DATE.
DEFINE VARIABLE signo           AS INTEGER.
DEFINE VARIABLE v-cod_mon       AS CHARACTER. 
DEFINE VARIABLE v-fecha_cotiza  AS DATE. 
DEFINE VARIABLE v-desc_mon      AS CHARACTER FORMAT "X(20)". 

DEFINE VARIABLE v-cantfact      AS INTEGER.
DEFINE VARIABLE v-totneto       AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEFINE VARIABLE v-totiva        AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE v-otroscons     AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE v-total         AS DECIMAL FORMAT ">>,>>>,>>9.99".

DEFINE BUFFER Ugranel FOR Unidad.

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Facturación por Fecha" AT 55
    "Página:" AT 164 PAGE-NUMBER FORMAT "9999" AT 171
    SKIP  
    fecha_lis
    "del" AT 55
    des_fecha
    "al"
    has_fecha
    hora_lis AT 164
    SKIP
    "Importes expresados en :" AT 55
    v-desc_mon 
    SKIP
    "Fecha de Cotización:" AT 55 
    X-Fec_Cotizar
    SKIP(1) 
    "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
    "Fecha    Identificación   Identificación   Código   Razón                     Domicilio                 Localidad                 Neto          IVA        Otros       Importe" SKIP
    "Factura  de la Factura    del Remito       Cliente  Social                                                                                             Conceptos         Total" SKIP
    "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
    WITH WIDTH 210 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Fac_header.fecha     FORMAT "99/99/99"
    que_factura
    que_remito
    Cliente.cdg_cliente
    Cliente.nom_cliente  FORMAT "X(25)"
    Domicilio.direccion  FORMAT "X(25)"
    Domicilio.localidad  FORMAT "X(16)"
    Fac_header.imp_neto  FORMAT ">>,>>>,>>9.99"
    Fac_header.imp_iva   FORMAT ">,>>>,>>9.99"
    v-otroscons
    Fac_header.imp_total FORMAT ">>,>>>,>>9.99"
    WITH WIDTH 210 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL.

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
                AND Cliente.cdg_cliente >= des_codigo,
              FIRST Imputacion OF Fac_header,
              FIRST Domicilio OF Fac_header,
              FIRST Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito
          BREAK BY Fac_header.fecha
                BY Cliente.cdg_cliente
                BY Fac_header.tip_comprob
                BY Fac_header.prf_comprob
                BY Fac_header.nro_comprob
                BY Fac_header.nro_factura:

       VIEW FRAME frm-titulo.

       IF FIRST-OF(Fac_header.nro_comprob)
       THEN DO:
            que_factura = Fac_header.tip_comprob + " " + 
                          STRING(Fac_header.prf_comprob,"9999") + " " +
                          STRING(Fac_header.nro_comprob,"99999999").
            
            que_remito  = Rem_header.tip_comprob + " " + 
                          STRING(Rem_header.prf_comprob,"9999") + " " +
                          STRING(Rem_header.nro_comprob,"99999999").

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
      RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_neto, OUTPUT X-Neto, OUTPUT X-Fec_Cotiza ).
      RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_iva, OUTPUT X-Iva, OUTPUT X-Fec_Cotiza ).

      IF p-ver_cotizacion = 1 THEN
      X-Fec_Cotizar= string(X-Fec_Cotiza,"99-99-9999").

      v-cantfact = v-cantfact + 1.
      v-totneto  = v-totneto + X-Neto.
      v-totiva   = v-totiva + X-Iva.
      v-total    = v-total + X-Importe.

            DISPLAY Fac_header.fecha WHEN FIRST-OF(Fac_header.fecha)
                    que_factura
                    que_remito
                    Cliente.cdg_cliente          
                    Cliente.nom_cliente
                    Domicilio.direccion
                    Domicilio.localidad
                    X-Neto    @ Fac_header.imp_neto
                    X-Iva     @ Fac_header.imp_iva
                    X-Importe - X-Iva - X-Neto @ v-otroscons
                    X-Importe @ Fac_header.imp_total
                    WITH FRAME frm-listado.

            DOWN WITH FRAME frm-listado.

       END.

  END. 

  DISPLAY SKIP(1).

  DISPLAY
      "-------------" @ Fac_header.imp_neto
      "------------"  @ Fac_header.imp_iva
      "------------"  @ v-otroscons
      "=============" @ Fac_header.imp_total
      WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.

  DISPLAY
      "Cantidad Facturas: " + STRING(v-cantfact) @ Domicilio.direccion
      "Totales: "  @ Domicilio.localidad
      v-totneto    @ Fac_header.imp_neto
      v-totiva     @ Fac_header.imp_iva
      v-total - v-totneto - v-totiva @ v-otroscons
      v-total      @ Fac_header.imp_total
      WITH FRAME frm-listado.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

