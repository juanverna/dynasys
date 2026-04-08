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
DEFINE INPUT PARAMETER que_moneda AS CHARACTER.
DEFINE INPUT PARAMETER que_puntos      AS CHARACTER.

/*=================================================================================*/
/*                                  VARIABLES                                      */
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
/*                                  FRAMES                                         */
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

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {DIRPRINFILE.I}

  det_titulo = "Analítico".

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
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CLIENTE.

    act_cliente = ROWID(Cliente).

    ASSIGN debitos   = 0
           creditos  = 0
           saldo     = 0.
     
    hubo_cliente = NO.

    VIEW FRAME frm-titulo-sdo.
                
              /* Recorremos los movimientos acumulando saldo */


    FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                  AND Cta_cte.credito <> Cta_cte.debito
                                  AND Cta_cte.fecha_emision >= des_fecha
                                  AND Cta_cte.fecha_emision <= has_fecha
                                  AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                                 EACH Imputacion OF Cta_cte BY Cta_cte.fecha_emision:
          IF NOT CAN-DO(que_puntos, STRING(cta_cte.prf_comprob,"9999")) THEN NEXT.
          debitos = debitos + Cta_cte.debito.
          creditos = creditos + Cta_cte.credito.
          saldo = saldo + Cta_cte.debito - Cta_cte.credito.
  
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


