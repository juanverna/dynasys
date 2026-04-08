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

DEFINE TEMP-TABLE lsresanalitico
    FIELD       cuit LIKE cliente.cuit
    FIELD       cdg_cliente LIKE Cliente.cdg_cliente
    FIELD       nom_cliente LIKE Cliente.nom_cliente
    FIELD       saldo AS DECIMAL FORMAT ">>>>>>>>>>9.99" COLUMN-LABEL "Saldo" LABEL "Saldo".

{findsector.i}
{tt2xls.i}
que_sector = Area.cdg_area.
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

  {DIRPRINFILE.I}

  {OPQRYCLI.I}
  
  acum_debitos = 0.
  acum_creditos = 0.
  acum_saldo = 0.
  GET FIRST qry_cliente.
  DO WHILE AVAILABLE Cliente:
     RUN PROCESAR_CLIENTE.
     GET NEXT qry_cliente.
  END.

RUN pTT2XLS                                                           
    ( INPUT TEMP-TABLE lsresanalitico:DEFAULT-BUFFER-HANDLE,                    
      INPUT "C:\SIC-TEMP\lsresanalitico.XLS",                                            
      INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ).
  MESSAGE "Archivo C:\SIC-TEMP\lsresanalitico.XLS generado" VIEW-AS ALERT-BOX INFORMATION.
  
END PROCEDURE.  

PROCEDURE PROCESAR_CLIENTE.

    act_cliente = ROWID(Cliente).

    ASSIGN debitos   = 0
           creditos  = 0
           saldo     = 0.
     
    hubo_cliente = NO.


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
          CREATE lsresanalitico.
          ASSIGN lsresanalitico.saldo = saldo
               lsresanalitico.cdg_cliente = Cliente.cdg_cliente
               lsresanalitico.nom_cliente = Cliente.nom_cliente
               lsresanalitico.cuit = cliente.cuit.

    END.

    acum_debitos = acum_debitos + debitos.
    acum_creditos = acum_creditos + creditos.
    acum_saldo = acum_saldo + saldo.
 
END PROCEDURE.

PROCEDURE PONER_MONEDA:

    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK. 
    act_moneda = ROWID(Moneda).

END PROCEDURE.


