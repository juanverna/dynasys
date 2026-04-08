/*=================================================================================*/
/*                    VENCIMIENTOS PENDIENTES POR VENDEDOR                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER has_codigo  LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_nombre  LIKE Vendedor.nombre.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  AS ROWID.

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE tot_vendr   AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE tot_saldo   AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

DEFINE VARIABLE acu_1       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE fecha_lis AS DATE.
DEFINE VARIABLE hora_lis  AS CHARACTER.
DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Saldos Pendientes por Vendedor" AT 38
  "Pagina:" AT 90 PAGE-NUMBER FORMAT ">>9" AT 98
  SKIP  
  fecha_lis
  "del" AT 40
  des_fecha
  "al"
  has_fecha
  desc_moneda NO-LABEL  
  hora_lis AT 90
  SKIP (1) 
  tit_vendedor AT 40
  SKIP(1)
  "----------------------------------------------------------------------------------------------------" SKIP
  "Código     Razón                                               Saldo                                " SKIP
  "Cliente    Social                                          Pendiente                                " SKIP
  "----------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-cli
  Cliente.cdg_cliente
  SPACE(3)
  Cliente.nom_cliente 
  SPACE(4)
  saldo COLUMN-LABEL "Saldo" FORMAT "->,>>>,>>9.99"
  WITH WIDTH 130 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda 1.
  desc_moneda = "en " + Moneda.descripcion.

  que_empresa = Empresa.nombre.

  acu_1 = 0.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  OUTPUT TO VALUE (dire_tmp + "lspenvensal.txt") PAGED PAGE-SIZE 72.
 
  {OPQRYVND.I}
  
  GET FIRST qry_vendedor.
  DO WHILE AVAILABLE Vendedor:
     RUN LISTAR.
     GET NEXT qry_vendedor.
  END.   

  DISPLAY "=============" @ saldo WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  DISPLAY "TOTAL GRAL." @ Cta_cte.credito
          acu_1         @ saldo 
     WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  DISPLAY "=============" @ saldo WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.
  
  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE LISTAR:

  tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre.

  IF NOT CAN-FIND (FIRST Cta_cte OF Vendedor 
                   WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                     AND Cta_cte.credito <> Cta_cte.debito
                     AND Cta_cte.fecha_vencimiento >= des_fecha
                     AND Cta_cte.fecha_vencimiento <= has_fecha
                     AND Cta_cte.cdg_empresa = Empresa.cdg_empresa)
     THEN RETURN.

  ASSIGN debito  = 0
         credito = 0
         saldo   = 0
         tot_saldo = 0.

  FOR EACH Cta_cte OF Vendedor NO-LOCK
     WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
       AND Cta_cte.credito <> Cta_cte.debito
       AND Cta_cte.fecha_vencimiento >= des_fecha
       AND Cta_cte.fecha_vencimiento <= has_fecha
       AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
      EACH Imputacion OF Cta_cte, FIRST Cliente OF Cta_cte
           BREAK BY Cta_cte.nro_cliente:

        VIEW FRAME frm-titulo.

        credito = credito + Cta_cte.credito.
        debito = debito + Cta_cte.debito.

        saldo = Cta_cte.debito - Cta_cte.credito.
        tot_saldo = tot_saldo + saldo.

        acu_1 = acu_1 + saldo.
  
        IF LAST-OF (Cta_cte.nro_cliente)
        THEN DO:
            DISPLAY Cliente.cdg_cliente
                    Cliente.nom_cliente
                    saldo 
                    WITH FRAME frm-listado-cli.
           DOWN 1 WITH FRAME frm-listado-cli.
           tot_vendr = tot_vendr + tot_saldo.
           tot_saldo = 0.

        END.
  END.
   
  PAGE.

END PROCEDURE.

{CODIMPRE.I}
 
