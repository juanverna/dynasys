/*=================================================================================*/
/*                            DOCUMENTOS X COBRADOR                                */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER has_codigo    LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER des_fecha     AS DATE.
DEFINE INPUT PARAMETER has_fecha     AS DATE.
DEFINE INPUT PARAMETER que_comprobs  AS CHARACTER.
DEFINE INPUT PARAMETER v-consolidado AS LOGICAL.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE tvn_saldo            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tvn_debito           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tvn_credito          AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE tot_saldo            AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_debito           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_credito          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".

DEFINE VARIABLE credito              AS DECIMAL.
DEFINE VARIABLE debito               AS DECIMAL.

DEFINE VARIABLE ver_por              AS INTEGER INITIAL 1.
DEFINE VARIABLE por_cod              AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom              AS INTEGER INITIAL 0.

DEFINE VARIABLE acu_1                AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE tit_cobrador         AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE desc_moneda          LIKE Moneda.descripcion.

{WGLISTAR.I}

/*=================================================================================*/
/*                                     FRAMES                                      */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Comprobantes por Cobrador" AT 58
  "Pagina:" AT 134 PAGE-NUMBER FORMAT ">>9" AT 142
  SKIP  
  fecha_lis
  "del" AT 40
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 134
  SKIP (1) 
  tit_cobrador AT 58
  SKIP(1)
  "------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Cod Identificacion del Con-  N Fecha de   Fecha de      Importe de    Importe de     Saldo del Código     Razón                                 "
  "Emp Comprobante        cepto V Emision    Vencimiento      Débitos      Créditos   Comprobante Cliente    Social                                "
  "------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 210 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.


DEFINE FRAME frm-listado-mov
  Cta_cte.cdg_empresa FORMAT "X(3)" 
  Cta_cte.tip_comprob
  Cta_cte.prf_comprob
  Cta_cte.nro_comprob
  SPACE(2)
  Imputacion.abrevia COLUMN-LABEL "Concep"
  SPACE(1)
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
  Cta_cte.fecha_emision
  Cta_cte.fecha_vencimiento
  Cta_cte.debito  FORMAT "->,>>>,>>9.99"
  Cta_cte.credito FORMAT "->,>>>,>>9.99"
  saldo COLUMN-LABEL "Saldo" FORMAT "->,>>>,>>9.99"
  Cliente.cdg_cliente
  Cliente.nom_cliente 
  WITH WIDTH 210 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda 1.
  desc_moneda = "en " + Moneda.descripcion.

  que_empresa = IF v-consolidado THEN "CONSOLIDADO" ELSE Empresa.nombre.

  acu_1 = 0.

  {dirprinfile.i}

  OPEN QUERY qry_cobrador 
       FOR EACH Cobrador NO-LOCK WHERE Cobrador.cdg_cobrador >= des_codigo
            AND Cobrador.cdg_cobrador <= has_codigo
             BY Cobrador.cdg_cobrador.
  
  GET FIRST qry_cobrador.
  DO WHILE AVAILABLE Cobrador:
     RUN LISTAR.
     GET NEXT qry_cobrador.
     IF AVAILABLE Cobrador THEN PAGE.
  END.   

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

PROCEDURE LISTAR:

  tit_cobrador = STRING(Cobrador.cdg_cobrador) + "-" + Cobrador.nom_cobrador.

  IF NOT CAN-FIND (FIRST Cta_cte OF Cobrador 
                   WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                     AND CAN-DO(str_debitan,que_comprobs)
                 /*  AND Cta_cte.credito <> Cta_cte.debito */
                     AND Cta_cte.fecha_emision >= des_fecha
                     AND Cta_cte.fecha_emision <= has_fecha
                     AND (Cta_cte.cdg_empresa = Empresa.cdg_empresa OR v-consolidado))
     THEN RETURN.

  ASSIGN debito  = 0
         credito = 0
         saldo   = 0
         tot_saldo = 0
         tot_debito = 0
         tot_credito = 0.

  FOR EACH Cta_cte OF Cobrador NO-LOCK
     WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
       AND CAN-DO(str_debitan,que_comprobs)
    /* AND Cta_cte.credito <> Cta_cte.debito */
       AND Cta_cte.fecha_emision >= des_fecha
       AND Cta_cte.fecha_emision <= has_fecha
       AND (Cta_cte.cdg_empresa = Empresa.cdg_empresa OR v-consolidado),
      EACH Imputacion OF Cta_cte, FIRST Cliente OF Cta_cte
           BREAK BY Cta_cte.cdg_empresa BY Cta_cte.fecha_emision:

        tot_credito = tot_credito + Cta_cte.credito.
        tot_debito = tot_debito + Cta_cte.debito.

        saldo = Cta_cte.debito - Cta_cte.credito.
        tot_saldo = tot_saldo + saldo.

        VIEW FRAME frm-titulo.
        
        DISPLAY Cta_cte.cdg_empresa
                Cta_cte.tip_comprob
                Cta_cte.prf_comprob
                Cta_cte.nro_comprob
                Imputacion.abrevia
                Cta_cte.nro_vencimiento
                Cta_cte.fecha_emision
                Cta_cte.fecha_vencimiento
                Cta_cte.debito
                Cta_cte.credito
                saldo
                Cliente.cdg_cliente
                Cliente.nom_cliente
                WITH FRAME frm-listado-mov.

        DOWN WITH FRAME frm-listado-mov.

        IF LAST-OF (Cta_cte.cdg_empresa)
        THEN DO:
           UNDERLINE Cta_cte.cdg_empresa
                     Cta_cte.tip_comprob
                     Cta_cte.prf_comprob
                     Cta_cte.nro_comprob
                     Imputacion.abrevia
                     Cta_cte.nro_vencimiento
                     Cta_cte.fecha_emision
                     Cta_cte.fecha_vencimiento
                     Cta_cte.debito
                     Cta_cte.credito
                     saldo 
                     Cliente.cdg_cliente
                     Cliente.nom_cliente
                     WITH FRAME frm-listado-mov.
           DISPLAY   tot_credito @ Cta_cte.credito
                     tot_debito @ Cta_cte.debito
                     tot_saldo @ saldo 
                     WITH FRAME frm-listado-mov.
           DOWN 2 WITH FRAME frm-listado-mov.
           tvn_saldo = tvn_saldo + tot_saldo.
           tvn_debito = tvn_debito + tot_debito.
           tvn_credito = tvn_credito + tot_credito.
           tot_saldo = 0.
           tot_debito = 0.
           tot_credito = 0.

        END.
  END.

  DISPLAY "=============" @ saldo 
          "=============" @ Cta_cte.debito 
          "=============" @ Cta_cte.credito 
          WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  DISPLAY tvn_debito    @ Cta_cte.debito 
          tvn_credito   @ Cta_cte.credito 
          tvn_saldo     @ saldo 
     WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.
  DISPLAY "=============" @ saldo 
          "=============" @ Cta_cte.debito 
          "=============" @ Cta_cte.credito 
          WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.


