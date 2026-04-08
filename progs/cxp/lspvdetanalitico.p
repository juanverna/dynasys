/*=================================================================================*/
/*             LISTADO DE SALDOS ANALITICOS CON O SIN MOVIMIENTOS                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_nombre      LIKE Proveedor.nombre. 
DEFINE INPUT PARAMETER has_nombre      LIKE Proveedor.nombre. 
DEFINE INPUT PARAMETER que_moneda      LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER ver_por         AS INTEGER.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.
DEFINE INPUT PARAMETER incluir_cero    AS LOGICAL.
DEFINE INPUT PARAMETER arrastrar_saldo AS LOGICAL.
DEFINE INPUT PARAMETER des_provincia   LIKE Provincia.cdg_provincia.
DEFINE INPUT PARAMETER has_provincia   LIKE Provincia.cdg_provincia.


/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.

DEFINE VARIABLE creditos               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Débitos".
DEFINE VARIABLE debitos                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Créditos".
DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".

DEFINE VARIABLE acum_debitos           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_creditos          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_saldo             AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE nom-vend               AS CHARACTER.
DEFINE VARIABLE hubo_proveedor         AS LOGICAL.
DEFINE VARIABLE ver_proveedor          AS LOGICAL.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE v-des_provincia        AS CHARACTER.
DEFINE VARIABLE v-has_provincia        AS CHARACTER.

{WGLISTAR.I}
{vrshared.i}
{FINDEMPRESA.I}
{dfvarimp.i}

/*=================================================================================*/
/*                           QUERYS Y FRAMES                                       */
/*=================================================================================*/

DEFINE QUERY qry_proveedor FOR Proveedor.

DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa FORMAT "X(32)"
  "Cuentas Corrientes - Movimientos" AT 35
  "Página:" AT 83 PAGE-NUMBER FORMAT ">>9" AT 91
  SKIP
  fecha_lis
  det_titulo AT 35 NO-LABEL
  hora_lis AT 83
  SKIP
  "Importes en" AT 35
  desc_moneda NO-LABEL
  "Provincias: " AT 35
  v-des_provincia NO-LABEL
  " - "
  v-has_provincia NO-LABEL
  SKIP(1)
  "-------------------------------------------------------------------------------------------------" SKIP
  "Proveedor Razón Social                                                                           " SKIP
  "   Identificación del        Fecha de    Fecha de           Importe        Importe        Importe" SKIP
  "      Comprobante            Emisión     Vencimiento        Débitos       Créditos          Saldo" SKIP
  "-------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 120 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
  Proveedor.cdg_proveedor
  SPACE(2)
  Proveedor.nombre FORMAT "X(35)"
  SPACE(3)
  Provincia.nombre 
  SPACE(3)
  saldo 
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-titulo-mov HEADER
  que_empresa 
  "Cuentas Corrientes - Movimientos" AT 40
  "Página:" AT 122 PAGE-NUMBER FORMAT ">>9" AT 129
  SKIP  
  fecha_lis
  det_titulo AT 40 NO-LABEL
  hora_lis AT 122
  SKIP
  "Importes en" AT 40
  desc_moneda NO-LABEL
  SKIP
  "Provincias: " AT 40
  v-des_provincia NO-LABEL
  " - "
  v-has_provincia NO-LABEL
  SKIP(0.5)
  WITH WIDTH 140 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  SPACE(3)
  Cta_cte_prv.tip_comprob
  Cta_cte_prv.prf_comprob
  Cta_cte_prv.nro_comprob
  Cta_cte_prv.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
  SPACE(1)
  Imputacion.abrevia
  SPACE(1)
  Cta_cte_prv.fecha_emision
  SPACE(4)
  Cta_cte_prv.fecha_vencimiento
  SPACE(3)
  Cta_cte_prv.debito
  SPACE(2)
  Cta_cte_prv.credito
  SPACE(2)
  saldo
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.
         
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.
FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
FIND Provincia WHERE Provincia.cdg_provincia = des_provincia NO-ERROR.
IF AVAILABLE Provincia THEN v-des_provincia = Provincia.nombre.
FIND Provincia WHERE Provincia.cdg_provincia = has_provincia NO-ERROR.
IF AVAILABLE Provincia THEN v-has_provincia = Provincia.nombre.

RUN LISTAR.


/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.

  {dirprinfile.i}

  det_titulo = "Analítico".

  {OPQRYPRV.I}
  
  acum_debitos = 0.
  acum_creditos = 0.
  acum_saldo = 0.
  GET FIRST qry_proveedor.
  DO WHILE AVAILABLE Proveedor:
     FIND FIRST Domicilio_prv OF Proveedor 
         WHERE Domicilio_prv.cdg_provincia >= des_provincia 
         AND Domicilio_prv.cdg_provincia <= has_provincia NO-ERROR.
     IF AVAILABLE Domicilio_prv THEN DO:
     FIND Provincia OF Domicilio_prv.
     RUN procesar_proveedor.
     END.
     GET NEXT qry_proveedor.
  END.

  UNDERLINE Cta_cte_prv.debito Cta_cte_prv.credito saldo
            WITH FRAME frm-listado-mov.
  DISPLAY 
    acum_debitos @ Cta_cte_prv.debito
    acum_creditos @ Cta_cte_prv.credito
    acum_saldo @ saldo
    WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.

  UNDERLINE Cta_cte_prv.debito Cta_cte_prv.credito saldo
            WITH FRAME frm-listado-mov.

  DISPLAY " " @ Proveedor.cdg_proveedor WITH FRAME frm-listado-mov.
  
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE procesar_proveedor:
       ASSIGN debitos   = 0
              creditos  = 0
              saldo     = 0.
        
       hubo_proveedor = NO.

       VIEW FRAME frm-titulo-sdo.
                   
                       /* Recorremos los movimientos acumulando saldo */

       IF incluir_cero
       THEN DO:

             DISPLAY Proveedor.cdg_proveedor
                     Proveedor.nombre
                     Provincia.nombre
                     WITH FRAME frm-listado-sdo.
             DOWN WITH FRAME frm-listado-sdo.
             hubo_proveedor = YES.  

       END.

       FOR EACH Cta_cte_prv OF Proveedor WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                                           AND Cta_cte_prv.credito <> Cta_cte_prv.debito
                                           AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa,
                                           EACH Imputacion OF Cta_cte_prv BY fecha_emision:
     
            debitos = debitos + Cta_cte_prv.debito.
            creditos = creditos + Cta_cte_prv.credito.
            saldo = saldo + Cta_cte_prv.credito - Cta_cte_prv.debito.
     
            IF NOT hubo_proveedor
            THEN DO:

                 DISPLAY Proveedor.cdg_proveedor
                         Proveedor.nombre
                         Provincia.nombre
                         WITH FRAME frm-listado-sdo.
                 DOWN WITH FRAME frm-listado-sdo.
                 hubo_proveedor = YES.  

            END.
            
            RUN LISTAR_MOVIMIENTO.
      
       END.

       IF hubo_proveedor
       THEN DO:
            UNDERLINE saldo WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.
            acum_debitos = acum_debitos + debitos.
            acum_creditos = acum_creditos + creditos.
            acum_saldo = acum_saldo + (creditos - debitos).
       END.   

END PROCEDURE.

PROCEDURE LISTAR_MOVIMIENTO:

    DISPLAY Cta_cte_prv.tip_comprob
            Cta_cte_prv.prf_comprob
            Cta_cte_prv.nro_comprob
            Imputacion.abrevia
            Cta_cte_prv.nro_vencimiento
            Cta_cte_prv.fecha_emision
            Cta_cte_prv.fecha_vencimiento
            Cta_cte_prv.debito    WHEN Cta_cte_prv.debito  <> 0
            Cta_cte_prv.credito   WHEN Cta_cte_prv.credito <> 0
            saldo
            WITH FRAME frm-listado-mov.
     
    DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE CALCULAR_SALDO:

   DEFINE INPUT  PARAMETER a_que_fecha   AS DATE.
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Cta_cte_prv OF Proveedor 
       WHERE Cta_cte_prv.fecha_emision < a_que_fecha
         AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
         AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa:

      IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
         THEN tot_debitogr  = tot_debitogr + Cta_cte_prv.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte_prv.credito.

   END.

END PROCEDURE.
