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
/*                                  VARIABLES                                      */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}
{WGLISTAR.I}

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

DEFINE QUERY qry_proveedor FOR Proveedor.

/*=================================================================================*/
/*                                  FRAMES                                         */
/*=================================================================================*/


DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa FORMAT "X(32)"
  "Cuentas Corrientes - Saldos" AT 35
  "Página:" AT 90 PAGE-NUMBER FORMAT ">>9" AT 98
  SKIP
  fecha_lis
  det_titulo AT 35 NO-LABEL
  hora_lis AT 90
  SKIP
  "Importes en" AT 35
  desc_moneda NO-LABEL
    "Provincias: " AT 35
  v-des_provincia NO-LABEL
  " - "
  v-has_provincia NO-LABEL

    SKIP(1)
    "------------------------------------------------------------------------------------------------------" SKIP
    "Código        Razón                                         Provincia                          Importe" SKIP
    "Proveedor     Social                                                                             Saldo" SKIP
    "------------------------------------------------------------------------------------------------------" SKIP
    WITH WIDTH 132 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

  DEFINE FRAME frm-listado-sdo
    Proveedor.cdg_proveedor
    SPACE(6)
    Proveedor.nombre
    SPACE(6)
    Provincia.nombre
    SPACE(14)
    saldo 
    WITH WIDTH 132 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO NO-LABEL.

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


  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre
            Provincia.nombre
            saldo
            WITH FRAME frm-listado-sdo.
  DISPLAY 
         acum_saldo @ saldo
         WITH FRAME frm-listado-sdo.
  DOWN WITH FRAME frm-listado-sdo.

  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre
            Provincia.nombre
            saldo
            WITH FRAME frm-listado-sdo.

  DISPLAY " " @ Proveedor.cdg_proveedor WITH FRAME frm-listado-sdo.
  
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


    FOR EACH Cta_cte_prv OF Proveedor WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                                        AND Cta_cte_prv.credito <> Cta_cte_prv.debito
                                        AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa,
                                       EACH Imputacion OF Cta_cte_prv BY Cta_cte_prv.fecha_emision:
  
          debitos = debitos + Cta_cte_prv.debito.
          creditos = creditos + Cta_cte_prv.credito.
          saldo = saldo + Cta_cte_prv.credito - Cta_cte_prv.debito.
  
    END.

    IF incluir_cero OR saldo <> 0
    THEN DO:

          DISPLAY Proveedor.cdg_proveedor
                  Proveedor.nombre
                  Provincia.nombre
                  saldo
                  WITH FRAME frm-listado-sdo.
          DOWN WITH FRAME frm-listado-sdo.

    END.

    acum_debitos = acum_debitos + debitos.
    acum_creditos = acum_creditos + creditos.
    acum_saldo = acum_saldo + saldo.
 
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
