/*=================================================================================*/
/*                              FACTURAS POR FECHA                                 */
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

DEFINE VARIABLE v-acum_total   AS DECIMAL   FORMAT "->>,>>>,>>9.99". 
DEFINE VARIABLE v-comprobante  AS CHARACTER FORMAT "x(16)".
DEFINE VARIABLE v-imptot       AS DECIMAL   FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE signo          AS INTEGER.
DEFINE VARIABLE v-cod_mon      AS CHARACTER.
DEFINE VARIABLE X-Importe      AS DECIMAL   FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-Fec_Cotiza   AS DATE.
DEFINE VARIABLE X-Fec_Cotizar  AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.    
DEFINE VARIABLE v-desc_mon     AS CHARACTER FORMAT "X(20)".

{vrshared.i}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Detalle de Facturas por Cliente" AT 38
    "Página:" AT 92 PAGE-NUMBER FORMAT "9999" AT 99
    SKIP  
    fecha_lis
    "del" AT 38
    des_fecha
    "al"
    has_fecha
    hora_lis AT 92
    SKIP
    "Importes expresados en :" AT 38
    v-desc_mon
    SKIP
    "Fecha de Cotización:" AT 38 
    X-Fec_Cotizar
    SKIP(1) 

    WITH WIDTH 180 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Cliente.cdg_cliente 
    Cliente.nom_cliente
    Fac_header.fecha 
    v-comprobante       FORMAT "X(20)" COLUMN-LABEL "Comprobante"
    v-cod_mon           FORMAT "X(05)" COLUMN-LABEL "Moneda!Trans."
    v-imptot            FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Importe Total"
    WITH WIDTH 170 DOWN CENTERED USE-TEXT STREAM-IO.

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
          WHERE Cliente.cdg_cliente >= des_codigo
            AND Cliente.cdg_cliente <= has_codigo,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header
      BREAK BY Cliente.cdg_cliente 
                BY Fac_header.fecha
                BY Fac_header.nro_factura:

       VIEW FRAME frm-titulo.

         IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.

         FOR EACH Moneda                                           
            WHERE moneda.nro_moneda = Fac_header.nro_moneda. 
                  v-cod_mon = moneda.cdg_moneda                            
            NO-ERROR.                                  
         END.                                                  

         FOR EACH Moneda 
           WHERE moneda.cdg_moneda = p-cdg_moneda.
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

         v-imptot = signo * X-Importe.
         v-acum_total = v-acum_total + v-imptot.
               
        v-comprobante = Fac_header.tip_comprob + " " + 
                          STRING(Fac_header.prf_comprob,"9999") + " " +
                          STRING(Fac_header.nro_comprob,"99999999"). 
         

       DISPLAY Cliente.cdg_cliente WHEN FIRST-OF(Cliente.cdg_cliente)          
               Cliente.nom_cliente WHEN FIRST-OF(Cliente.cdg_cliente)         
               Fac_header.fecha
               v-comprobante
               v-cod_mon
               v-imptot
               WITH FRAME frm-listado.
       DOWN WITH FRAME frm-listado.
       
       IF LAST-OF(Cliente.cdg_cliente)
           THEN DO:
                UNDERLINE v-imptot
                          WITH FRAME frm-listado.
                DISPLAY "Total Facturado"               @ v-comprobante
                         v-acum_total                   @ v-imptot

                         WITH FRAME frm-listado.
                DOWN 2 WITH FRAME frm-listado.

                v-acum_total = 0.
                
       END. 
  END.   
                           
OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  
