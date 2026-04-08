/*====================================================================================*/
/*         VENCIMIENTOS POR COBRAR ENTRE DOS FECHAS DADAS                             */
/*====================================================================================*/

DEFINE INPUT PARAMETER ver_por     AS  INTEGER.
DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_nombre  LIKE Cliente.nom_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_nombre  LIKE Cliente.nom_cliente.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.cdg_moneda.

/*====================================================================================*/
/*                                   VARIABLES                                        */
/*====================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE tot_saldo   AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE por_cod AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom AS INTEGER INITIAL 0.

DEFINE VARIABLE acu_1       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".

DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.
/*====================================================================================*/
/*                                   FRAMES                                           */
/*====================================================================================*/

DEFINE FRAME frm-titulo-sdo HEADER
  que_empresa 
  "Vencimientos a Cobrar" AT 42
  "Pagina:" AT 93 PAGE-NUMBER FORMAT ">>9" AT 101
  SKIP  
  fecha_lis
  "del" AT 42
  des_fecha
  "al"
  has_fecha
  hora_lis AT 93
  SKIP  
  "Importes en" AT 42
  desc_moneda NO-LABEL  
  SKIP(1)
  WITH WIDTH 120 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
  Cliente.cdg_cliente
  SPACE(2)
  Cliente.nom_cliente FORMAT "X(30)"
  SPACE(3)
  saldo
  WITH WIDTH 180 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO.

DEFINE FRAME frm-titulo-mov HEADER
  que_empresa 
  "Vencimientos a Cobrar del" AT 43
  des_fecha
  "al"
  has_fecha
  "Pagina:" AT 115 PAGE-NUMBER FORMAT ">>>>9" AT 122
  SKIP  
  fecha_lis
  "Importes en" AT 43
  desc_moneda NO-LABEL
  hora_lis AT 115
  SKIP(1)
  WITH WIDTH 180 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  Cliente.cdg_cliente COLUMN-LABEL "Código!Cliente"
  Cliente.nom_cliente COLUMN-LABEL "Razón!Social" FORMAT "X(30)"
  Cta_cte.tip_comprob COLUMN-LABEL "Ti-!po"
  Cta_cte.prf_comprob COLUMN-LABEL "Pre-!fijo"
  Cta_cte.nro_comprob COLUMN-LABEL "Número!Comprobte" 
  Imputacion.abrevia COLUMN-LABEL "Con-!cepto"
  Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "N!V"
  Cta_cte.fecha_emision   COLUMN-LABEL "Fecha!Emisión"
  Cta_cte.fecha_vencimiento COLUMN-LABEL "Fecha!Vencimto"
  Cta_cte.debito           COLUMN-LABEL "Importe!Total"
  Cta_cte.credito          COLUMN-LABEL "Importe!Cancelado"
  saldo COLUMN-LABEL "Saldo!Impago"
  WITH WIDTH 180 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
  desc_moneda = Moneda.descripcion.

  {findempresa.i}
  que_empresa = Empresa.nombre.

  acu_1 = 0.

  {dirprinfile.i}  

  {OPQRYCLI.I}
  
  GET FIRST qry_cliente.
  DO WHILE AVAILABLE Cliente:
     RUN LISTAR.
     GET NEXT qry_cliente.
  END.   

     DISPLAY "=============" @ saldo WITH FRAME frm-listado-mov.
     DOWN WITH FRAME frm-listado-mov.
     DISPLAY "TOTAL GRAL." @ Cta_cte.credito
             acu_1         @ saldo 
        WITH FRAME frm-listado-mov.
     DOWN WITH FRAME frm-listado-mov.
     DISPLAY "=============" @ saldo WITH FRAME frm-listado-mov.
     DOWN WITH FRAME frm-listado-mov.
  
  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE LISTAR:

  IF NOT CAN-FIND (FIRST Cta_cte OF Cliente 
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

  FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                AND Cta_cte.credito <> Cta_cte.debito
                                AND Cta_cte.fecha_vencimiento >= des_fecha
                                AND Cta_cte.fecha_vencimiento <= has_fecha
                                AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                               EACH Imputacion OF Cta_cte
                           BREAK BY Cta_cte.nro_cliente:

     credito = credito + Cta_cte.credito.
     debito = debito + Cta_cte.debito.

     saldo = Cta_cte.debito - Cta_cte.credito.
     tot_saldo = tot_saldo + saldo.

     VIEW FRAME frm-titulo-mov.
     
     DISPLAY Cliente.cdg_cliente WHEN FIRST-OF (Cta_cte.nro_cliente)
             Cliente.nom_cliente WHEN FIRST-OF (Cta_cte.nro_cliente)
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
             WITH FRAME frm-listado-mov.

     acu_1 = acu_1 + saldo.
  
     DOWN WITH FRAME frm-listado-mov.

     IF LAST-OF (Cta_cte.nro_cliente)
     THEN DO:
        UNDERLINE Cliente.cdg_cliente
                  Cliente.nom_cliente
                  Cta_cte.tip_comprob
                  Cta_cte.prf_comprob
                  Cta_cte.nro_comprob
                  Imputacion.abrevia
                  Cta_cte.nro_vencimiento
                  Cta_cte.fecha_emision
                  Cta_cte.fecha_vencimiento
                  Cta_cte.debito
                  Cta_cte.credito
                  saldo WITH FRAME frm-listado-mov.
        DISPLAY "Tot.Cliente" @ Cta_cte.credito
                    tot_saldo @ saldo WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.
        UNDERLINE Cliente.cdg_cliente
                  Cliente.nom_cliente
                  Cta_cte.tip_comprob
                  Cta_cte.prf_comprob
                  Cta_cte.nro_comprob
                  Imputacion.abrevia
                  Cta_cte.nro_vencimiento
                  Cta_cte.fecha_emision
                  Cta_cte.fecha_vencimiento
                  Cta_cte.debito
                  Cta_cte.credito
                  saldo WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.
     END.
  END.

END PROCEDURE.

 
