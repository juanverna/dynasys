/*=================================================================================*/
/*             LISTADO DE SALDOS ANALITICOS CON O SIN MOVIMIENTOS                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Cliente.cdg_cliente  LABEL "Desde Cliente".
DEFINE INPUT PARAMETER has_codigo      LIKE Cliente.cdg_cliente  LABEL "Desde Cliente".
DEFINE INPUT PARAMETER des_nombre      LIKE Cliente.nom_cliente. 
DEFINE INPUT PARAMETER has_nombre      LIKE Cliente.nom_cliente. 
DEFINE INPUT PARAMETER ver_por         AS INTEGER.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.
DEFINE INPUT PARAMETER incluir_cero    AS LOGICAL.
DEFINE INPUT PARAMETER arrastrar_saldo AS LOGICAL.
DEFINE INPUT PARAMETER que_moneda      AS CHARACTER.
DEFINE INPUT PARAMETER que_puntos AS CHARACTER.


/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}
{WGLISTAR.I}

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE QUERY qry_cliente FOR Cliente.

DEFINE VARIABLE creditos               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Débitos".
DEFINE VARIABLE debitos                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Créditos".
DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".

DEFINE VARIABLE acum_debitos           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_creditos          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_saldo             AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE nom-vend               AS CHARACTER.
DEFINE VARIABLE hubo_cliente           AS LOGICAL.
DEFINE VARIABLE ver_cliente            AS LOGICAL.
DEFINE VARIABLE desc_moneda            AS CHARACTER FORMAT "X(45)".

DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.
/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa FORMAT "X(32)"
  "Cuentas Corrientes - Saldos" AT 35
  "Página:" AT 84 PAGE-NUMBER FORMAT ">>9" AT 92
  SKIP
  fecha_lis
  det_titulo AT 35 NO-LABEL
  hora_lis AT 84
  SKIP
  "Importes en" AT 35
  desc_moneda NO-LABEL
  SKIP(1)
  "----------------------------------------------------------------------------------------------" SKIP
  "Cliente   Razón Social                          Vendedor                                 Saldo" SKIP
  "----------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 96 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
  Cliente.cdg_cliente
  SPACE(2)
  Cliente.nom_cliente FORMAT "X(35)"
  SPACE(3)
  nom-vend FORMAT "X(31)"
  SPACE(2)
  saldo 
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.

RUN PONER_MONEDA.

RUN LISTAR.


/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.
  IF arrastrar_saldo 
     THEN  desc_moneda = desc_moneda + " - CON arrastre de saldos".
     ELSE  desc_moneda = desc_moneda + " - SIN arrastre de saldos".

  {dirprinfile.i}

  det_titulo = "Histórico del " + STRING(des_fecha)+ " al " + STRING(has_fecha).

  {OPQRYCLI.I}
  
  acum_debitos = 0.
  acum_creditos = 0.
  acum_saldo = 0.
  GET FIRST qry_cliente.
  DO WHILE AVAILABLE Cliente:
     RUN PROCESAR_CLIENTE.
     GET NEXT qry_cliente.
  END.


  UNDERLINE Cliente.cdg_cliente
            Cliente.nom_cliente
            nom-vend
            saldo
            WITH FRAME frm-listado-sdo.
  DISPLAY 
         acum_saldo @ saldo
         WITH FRAME frm-listado-sdo.
  DOWN WITH FRAME frm-listado-sdo.

  UNDERLINE Cliente.cdg_cliente
            Cliente.nom_cliente
            nom-vend
            saldo
            WITH FRAME frm-listado-sdo.

  DISPLAY " " @ Cliente.cdg_cliente WITH FRAME frm-listado-sdo.
  
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CLIENTE:

    act_cliente = ROWID(Cliente).

    ASSIGN debitos   = 0
           creditos  = 0
           saldo     = 0.
     
    hubo_cliente = NO.

    VIEW FRAME frm-titulo-sdo.
                
              /* Recorremos los movimientos acumulando saldo */

    IF arrastrar_saldo 
    THEN DO:
         RUN CALCULAR_SALDO ( INPUT des_fecha, OUTPUT debitos, OUTPUT creditos ).
         saldo = debitos - creditos.
    END.
    ELSE DO:     
         saldo = 0.
    END.   

    FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                  AND Cta_cte.fecha_emision >= des_fecha
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                                 EACH Imputacion OF Cta_cte  BREAK BY Cta_cte.fecha_emision:
            IF NOT CAN-DO(que_puntos, STRING(cta_cte.prf_comprob,"9999")) THEN NEXT.
            IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
            THEN DO:
                 debitos = debitos + Cta_cte.debito.
                 saldo = saldo + Cta_cte.debito.
            END.                 
            ELSE DO:
                 creditos = creditos + Cta_cte.credito.
                 saldo = saldo - Cta_cte.credito.
            END.                 
  
    END.

    IF incluir_cero OR saldo <> 0
    THEN DO:

          FIND Vendedor OF Cliente.
          nom-vend = "(" + STRING(Vendedor.cdg_vendedor)+ "  " + SUBSTRING(Vendedor.nombre,1,25) + ")".
          DISPLAY Cliente.cdg_cliente
                  Cliente.nom_cliente
                  nom-vend
                  saldo
                  WITH FRAME frm-listado-sdo.
          DOWN WITH FRAME frm-listado-sdo.

    END.

    acum_debitos = acum_debitos + debitos.
    acum_creditos = acum_creditos + creditos.
    acum_saldo = acum_saldo + saldo.
 
END PROCEDURE.

PROCEDURE PONER_MONEDA:

FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
act_moneda = ROWID(Moneda).

END PROCEDURE.


PROCEDURE CALCULAR_SALDO:

   DEFINE INPUT  PARAMETER a_que_fecha   AS DATE.
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Cta_cte OF Cliente 
       WHERE Cta_cte.fecha_emision < a_que_fecha
         AND Cta_cte.nro_moneda = Moneda.nro_moneda
         AND Cta_cte.cdg_empresa = Empresa.cdg_empresa:
      IF NOT CAN-DO(que_puntos, STRING(cta_cte.prf_comprob,"9999")) THEN NEXT.
      IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
         THEN tot_debitogr  = tot_debitogr + Cta_cte.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte.credito.

   END.

END PROCEDURE.

 
