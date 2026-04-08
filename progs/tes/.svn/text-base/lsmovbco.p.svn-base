/*=====================================================================================*/
/*                  LISTADO DE MOVIMIENTOS Y SALDOS BANCARIOS                          */
/*=====================================================================================*/

DEFINE INPUT PARAMETER que_cuenta       LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE INPUT PARAMETER des_fecha        AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha        AS DATE FORMAT "99/99/9999".

/*-------------------------------------------------------------------------------------*/
/*                               VARIABLES Y FRAMES                                    */
/*-------------------------------------------------------------------------------------*/

{dfvarimp.i}
{wglistar.i}
{vrshared.i "new"}

DEFINE VARIABLE que_comprob             AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE creditos                AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Debitos".
DEFINE VARIABLE debitos                 AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Creditos".
DEFINE VARIABLE saldo                   AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "S a l d o".
DEFINE VARIABLE v-total_comp            AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE acum_debitos            AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE acum_creditos           AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE acum_saldo              AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE chr_cuenta              AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE det_titulo              AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE hubo_cuenta             AS LOGICAL.
DEFINE VARIABLE ver_cuenta              AS LOGICAL.
DEFINE VARIABLE desc_moneda             LIKE Moneda.descripcion.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Movimientos Bancarios por Cuenta" AT 50
  "Página:" AT 88 PAGE-NUMBER FORMAT "99999" AT 96
  SKIP
  fecha_lis
  det_titulo AT 50 NO-LABEL
  hora_lis AT 96
  chr_cuenta AT 50
  WITH WIDTH 180 DOWN CENTERED FRAME frm-titulo USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
  que_comprob                  COLUMN-LABEL "Número de!Comprobante"
  Cta_cte_bco.fecha_movimto    
  Cta_cte_bco.fecha_efectiva   
  Cta_cte_bco.credito
  Cta_cte_bco.debito
  saldo                        COLUMN-LABEL "Importe!Saldo"
  Cta_cte_bco.leyenda
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
         
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

RUN LISTAR.

/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  acum_debitos = 0.
  acum_creditos = 0.
  acum_saldo = 0.

  {dirprinfile.i}

  FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = que_cuenta NO-LOCK.
  RUN PROCESAR_CUENTA.

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CUENTA:

    ASSIGN debitos   = 0
           creditos  = 0
           saldo     = 0.
        
    chr_cuenta = Cuenta_bancaria.cdg_cuenta_ban + "-" + Cuenta_bancaria.denominacion_cta.
    det_titulo = "Movimientos del " + string(des_fecha)+ " al " + string(has_fecha).

    RUN CALCULAR_SALDO ( INPUT des_fecha, OUTPUT debitos, OUTPUT creditos ).
    saldo = creditos - debitos.

    FOR EACH Cta_cte_bco NO-LOCK OF Cuenta_bancaria 
             WHERE Cta_cte_bco.fecha_movimto >= des_fecha
               AND Cta_cte_bco.fecha_movimto <= has_fecha
               AND NOT Cta_cte_bco.anulado
                   BREAK BY Cta_cte_bco.fecha_movimto
                         BY Cta_cte_bco.tip_comprob
                         BY Cta_cte_bco.prf_comprob
                         BY Cta_cte_bco.nro_comprob:
   
        VIEW FRAME frm-titulo.

        IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
           THEN debitos = debitos + Cta_cte_bco.debito.
           ELSE creditos = creditos + Cta_cte_bco.credito.
        saldo = creditos - debitos.

        que_comprob = Cta_cte_bco.tip_comprob + " " + 
                     STRING(Cta_cte_bco.prf_comprob,"9999") + " " + 
                     STRING(Cta_cte_bco.nro_comprob,"99999999").

        DISPLAY que_comprob
                Cta_cte_bco.fecha_movimto
                Cta_cte_bco.fecha_efectiva
                Cta_cte_bco.debito  WHEN LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
                Cta_cte_bco.credito WHEN LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) = 0
                saldo
                WITH FRAME frm-listado.
       
        DOWN WITH FRAME frm-listado.

    END.            

    UNDERLINE saldo WITH FRAME frm-listado.
    DOWN 2 WITH FRAME frm-listado.

    acum_debitos = acum_debitos + debitos.
    acum_creditos = acum_creditos + creditos.
    acum_saldo = acum_saldo + saldo.

END PROCEDURE.

PROCEDURE CALCULAR_SALDO:

   DEFINE INPUT  PARAMETER a_que_fecha   AS DATE FORMAT "99/99/9999".
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Cta_cte_bco OF Cuenta_bancaria 
       WHERE Cta_cte_bco.fecha_movimto < a_que_fecha
         AND NOT Cta_cte_bco.anulado:

      IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
         THEN tot_debitogr  = tot_debitogr + Cta_cte_bco.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte_bco.credito.

   END.

END PROCEDURE.
