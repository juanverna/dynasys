/*=====================================================================================*/
/*                  LISTADO DE MOVIMIENTOS Y SALDOS BANCARIOS                          */
/*=====================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha    AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER det_sino     AS LOGICAL.
DEFINE INPUT PARAMETER incluir_cero AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}
{RANGOBCO.I}
{dfvarimp.i}

DEFINE VARIABLE creditos       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Debitos".
DEFINE VARIABLE debitos        AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "S a l d o".
DEFINE VARIABLE v-total_comp   AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE acum_debitos   AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE acum_creditos  AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE acum_saldo     AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE det_titulo     AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE hubo_cuenta    AS LOGICAL.
DEFINE VARIABLE ver_cuenta     AS LOGICAL.
DEFINE VARIABLE desc_moneda    LIKE Moneda.descripcion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa 
  "Cuentas Corrientes - Saldos" AT 23
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis
  det_titulo AT 23 NO-LABEL
  hora_lis AT 68
  SKIP(0.5)
  WITH WIDTH 80 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
  Cuenta_bancaria.cdg_cuenta_ban
  SPACE(2)
  Cuenta_bancaria.denominacion_cta
  SPACE(3)
  saldo
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO.

DEFINE FRAME frm-titulo-mov HEADER
  que_empresa 
  "Cuentas Corrientes Bancarias" AT 40
  "Pagina:" AT 122 PAGE-NUMBER FORMAT ">>9" AT 129
  SKIP  
  fecha_lis
  det_titulo AT 40 NO-LABEL
  hora_lis AT 122
  SKIP(0.5)
  WITH WIDTH 140 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  Cuenta_bancaria.cdg_cuenta_ban
  SPACE(1)
  Cuenta_bancaria.denominacion_cta FORMAT "X(30)"
  SPACE(2)
  Cta_cte_bco.tip_comprob
  SPACE(2)
  Cta_cte_bco.nro_comprob FORMAT "ZZZZZZZZ9"
  SPACE(1)
  Cta_cte_bco.fecha_movimto
  SPACE(1)
  Cta_cte_bco.fecha_efectiva
  SPACE(2)
  Cta_cte_bco.credito
  SPACE(2)
  Cta_cte_bco.debito
  SPACE(2)
  saldo
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO.
         
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

  det_titulo = "Movimientos del " + string(des_fecha)+ " al " + string(has_fecha).
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  /*
  OUTPUT TO VALUE(dire_tmp + "lsmovbco.txt") PAGED.
  */
  
  {dirprinfile.i}

  IF det_sino THEN RUN PONE_CODIGO ( INPUT "CARTA,HORIZONT" ).

  {OPQRYBCO.I}
  
  acum_debitos = 0.
  acum_creditos = 0.
  acum_saldo = 0.
  GET FIRST qry_cuenta.
  DO WHILE AVAILABLE Cuenta_bancaria:
     IF NOT Cuenta_bancaria.ficticia THEN RUN PROCESAR_CUENTA.
     GET NEXT qry_cuenta.
  END.

  IF NOT det_sino
  THEN DO:
     UNDERLINE saldo
               WITH FRAME frm-listado-sdo.
     DISPLAY 
       acum_saldo @ saldo
       WITH FRAME frm-listado-sdo.
     DOWN WITH FRAME frm-listado-sdo.

     UNDERLINE saldo
               WITH FRAME frm-listado-sdo.

     DISPLAY " " @ Cuenta_bancaria.cdg_cuenta_ban WITH FRAME frm-listado-sdo.
  END.            

  ELSE DO:
     UNDERLINE Cta_cte_bco.debito Cta_cte_bco.credito saldo
               WITH FRAME frm-listado-mov.
     DISPLAY 
       acum_debitos @ Cta_cte_bco.debito
       acum_creditos @ Cta_cte_bco.credito
       acum_saldo @ saldo
       WITH FRAME frm-listado-mov.
     DOWN WITH FRAME frm-listado-mov.

     UNDERLINE Cta_cte_bco.debito Cta_cte_bco.credito saldo
               WITH FRAME frm-listado-mov.

     DISPLAY " " @ Cuenta_bancaria.cdg_cuenta_ban WITH FRAME frm-listado-mov.
  END.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CUENTA:

   act_cuenta = ROWID(Cuenta_bancaria).

   ASSIGN debitos   = 0
          creditos  = 0
          saldo     = 0.
        
   IF det_sino /* Con detalle de movimientos */
   THEN DO:
   
        IF NOT CAN-FIND (FIRST Cta_cte_bco OF Cuenta_bancaria 
                         WHERE Cta_cte_bco.fecha_movimto >= des_fecha
                           AND Cta_cte_bco.fecha_movimto <= has_fecha)
           AND NOT incluir_cero THEN RETURN.

        ver_cuenta = NO.

        RUN CALCULAR_SALDO ( INPUT des_fecha, OUTPUT debitos, OUTPUT creditos ).
        saldo = creditos - debitos.

        VIEW FRAME frm-titulo-mov.
        DISPLAY Cuenta_bancaria.cdg_cuenta_ban
                Cuenta_bancaria.denominacion_cta
                " " @ Cta_cte_bco.tip_comprob
                " " @ Cta_cte_bco.nro_comprob
                "Saldo al" @ Cta_cte_bco.fecha_movimto
                (des_fecha - 1) @ Cta_cte_bco.fecha_efectiva
                debitos @ Cta_cte_bco.debito
                creditos @ Cta_cte_bco.credito
                saldo
                WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.

        FOR EACH Cta_cte_bco NO-LOCK OF Cuenta_bancaria 
                 WHERE Cta_cte_bco.fecha_movimto >= des_fecha
                   AND Cta_cte_bco.fecha_movimto <= has_fecha
                   AND NOT Cta_cte_bco.anulado
                   
                       /*,EACH Imputacion NO-LOCK OF Cta_cte_bco*/ 
                       BREAK BY Cta_cte_bco.fecha_movimto
                             BY Cta_cte_bco.tip_comprob
                             BY Cta_cte_bco.prf_comprob
                             BY Cta_cte_bco.nro_comprob:
   
            IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
               THEN debitos = debitos + Cta_cte_bco.debito.
               ELSE creditos = creditos + Cta_cte_bco.credito.
            saldo = creditos - debitos.

            v-total_comp = v-total_comp + Cta_cte_bco.credito - Cta_cte_bco.debito.

                  /* XXX: Comentar este IF si no se desea separar depósitos */

            IF FIRST-OF(Cta_cte_bco.nro_comprob)
            THEN DO:
                 IF Cta_cte_bco.tip_comprob = "DP"
                    THEN RUN INICIAR_COMPROBANTE.
            END.

            RUN LISTAR_MOVIMIENTO.
            
            IF LAST-OF(Cta_cte_bco.nro_comprob)
            THEN DO:
                 IF Cta_cte_bco.tip_comprob = "DP"
                    THEN RUN LISTAR_TOTAL_COMPROBANTE.
                 v-total_comp = 0.
            END.

        END.

        UNDERLINE saldo WITH FRAME frm-listado-mov.
        DOWN 2 WITH FRAME frm-listado-mov.

        acum_debitos = acum_debitos + debitos.
        acum_creditos = acum_creditos + creditos.
        acum_saldo = acum_saldo + saldo.

   END.
   ELSE DO: /* Sin detalle de movimientos */

         RUN CALCULAR_SALDO ( INPUT des_fecha , OUTPUT debitos, OUTPUT creditos ).
         FOR EACH Cta_cte_bco OF Cuenta_bancaria 
             WHERE Cta_cte_bco.fecha_movimto >= des_fecha
               AND Cta_cte_bco.fecha_movimto <= has_fecha
               AND NOT Cta_cte_bco.anulado:

             IF LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
                THEN debitos = debitos + Cta_cte_bco.debito.
                ELSE creditos = creditos + Cta_cte_bco.credito.

         END.

         saldo = saldo + creditos - debitos.

         IF saldo <> 0 OR incluir_cero THEN RUN LISTAR_SALDO.

         acum_debitos = acum_debitos + debitos.
         acum_creditos = acum_creditos + creditos.
         acum_saldo = acum_saldo + saldo.

   END.
      
END PROCEDURE.

PROCEDURE LISTAR_SALDO:

  VIEW FRAME frm-titulo-sdo.
      
  DISPLAY Cuenta_bancaria.cdg_cuenta_ban
          Cuenta_bancaria.denominacion_cta
          saldo
          WITH FRAME frm-listado-sdo.
 
  DOWN WITH FRAME frm-listado-sdo.

END PROCEDURE.


PROCEDURE LISTAR_MOVIMIENTO:

  VIEW FRAME frm-titulo-mov.

  DISPLAY Cuenta_bancaria.cdg_cuenta_ban WHEN ver_cuenta
          Cuenta_bancaria.denominacion_cta      WHEN ver_cuenta
          Cta_cte_bco.tip_comprob
          Cta_cte_bco.nro_comprob
          Cta_cte_bco.fecha_movimto
          Cta_cte_bco.fecha_efectiva
          Cta_cte_bco.debito  WHEN LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) <> 0
          Cta_cte_bco.credito WHEN LOOKUP(Cta_cte_bco.tip_comprob,str_debitan_bco) = 0
          saldo
          WITH FRAME frm-listado-mov.
 
  DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE LISTAR_TOTAL_COMPROBANTE:

  UNDERLINE
          Cta_cte_bco.debito
          Cta_cte_bco.credito
          saldo
          WITH FRAME frm-listado-mov.
          
  DOWN WITH FRAME frm-listado-mov.

  DISPLAY v-total_comp @ Cta_cte_bco.credito
          WITH FRAME frm-listado-mov.
 
  DOWN 2 WITH FRAME frm-listado-mov. /* XXX: Comentar si no se desa separar los depositos */

END PROCEDURE.

PROCEDURE INICIAR_COMPROBANTE:

  DOWN 2 WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE PONER_MONEDA:

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
