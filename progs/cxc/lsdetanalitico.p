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
DEFINE INPUT PARAMETER que_puntos      AS CHARACTER.
/*=================================================================================*/
/*                                  VARIABLES Y FRAMES                             */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE QUERY qry_cliente               FOR Cliente.

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
/* DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion. */
DEFINE VARIABLE desc_moneda            AS CHARACTER FORMAT "X(45)".

DEFINE VARIABLE que_sector LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

{WGLISTAR.I}

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
  SKIP(1)
  "---------------------------------------------------------------------------------------------" SKIP
  "Cliente Razón Social                                                                         " SKIP
  "   Identificación del      Fecha de    Fecha de         Importe        Importe        Importe" SKIP
  "      Comprobante          Emisión     Vencimiento      Débitos       Créditos          Saldo" SKIP
  "---------------------------------------------------------------------------------------------" SKIP
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

DEFINE FRAME frm-titulo-mov HEADER
  que_empresa 
  "Cuentas Corrientes - Movimientos" AT 40
  "Pagina:" AT 122 PAGE-NUMBER FORMAT ">>9" AT 129
  SKIP  
  fecha_lis
  det_titulo AT 40 NO-LABEL
  hora_lis AT 122
  SKIP
  "Importes en" AT 40
  desc_moneda NO-LABEL
  SKIP(0.5)
  WITH WIDTH 140 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  SPACE(3)
  Cta_cte.tip_comprob
  Cta_cte.prf_comprob
  Cta_cte.nro_comprob
  Cta_cte.nro_vencimiento FORMAT "99" COLUMN-LABEL "V"
  SPACE(1)
  Imputacion.abrevia
  SPACE(1)
  Cta_cte.fecha_emision
  SPACE(1)
  Cta_cte.fecha_vencimiento
  SPACE(2)
  Cta_cte.debito
  SPACE(2)
  Cta_cte.credito
  SPACE(2)
  saldo
  WITH WIDTH 140 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.
         
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

/*{SETIMPRE.I}*/

que_empresa = Empresa.nombre.

RUN PONER_MONEDA.

RUN LISTAR.


/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.

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


  UNDERLINE Cta_cte.debito Cta_cte.credito saldo
            WITH FRAME frm-listado-mov.
  DISPLAY 
    acum_debitos @ Cta_cte.debito
    acum_creditos @ Cta_cte.credito
    acum_saldo @ saldo
    WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.

  UNDERLINE Cta_cte.debito Cta_cte.credito saldo
            WITH FRAME frm-listado-mov.

  DISPLAY " " @ Cliente.cdg_cliente WITH FRAME frm-listado-mov.
  
  OUTPUT CLOSE.
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

       IF incluir_cero
       THEN DO:

             FIND Vendedor OF Cliente.
             nom-vend = "(" + STRING(Vendedor.cdg_vendedor)+ "  " + SUBSTRING(Vendedor.nombre,1,25) + ")".
             DISPLAY Cliente.cdg_cliente
                     Cliente.nom_cliente
                     nom-vend
                     WITH FRAME frm-listado-sdo.
             DOWN WITH FRAME frm-listado-sdo.
             hubo_cliente = YES.  

       END.

       FOR EACH Cta_cte OF Cliente WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
                                     AND Cta_cte.credito <> Cta_cte.debito
                                     AND Cta_cte.fecha_emision >= des_fecha
                                     AND Cta_cte.fecha_emision <= has_fecha
                                     AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
                                    EACH Imputacion OF Cta_cte BY Cta_cte.fecha_emision:
            IF NOT CAN-DO(que_puntos, STRING(cta_cte.prf_comprob,"9999")) THEN NEXT.
            debitos = debitos + Cta_cte.debito.
            creditos = creditos + Cta_cte.credito.
            saldo = Cta_cte.debito - Cta_cte.credito.
     
            IF NOT hubo_cliente
            THEN DO:

                 FIND Vendedor OF Cliente.
                 nom-vend = "(" + STRING(Vendedor.cdg_vendedor)+ "  " + SUBSTRING(Vendedor.nombre,1,25) + ")".
                 DISPLAY Cliente.cdg_cliente
                         Cliente.nom_cliente
                         nom-vend
                         WITH FRAME frm-listado-sdo.
                 DOWN WITH FRAME frm-listado-sdo.
                 hubo_cliente = YES.  

            END.
            
            RUN LISTAR_MOVIMIENTO.
      
       END.

       IF hubo_cliente
       THEN DO:
            saldo = debitos - creditos.
            UNDERLINE saldo WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.
            DISPLAY saldo WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.

            acum_debitos = acum_debitos + debitos.
            acum_creditos = acum_creditos + creditos.
            acum_saldo = acum_saldo + (debitos - creditos).
       END.   

END PROCEDURE.

PROCEDURE LISTAR_MOVIMIENTO:

    DISPLAY Cta_cte.tip_comprob
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
     
    DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE PONER_MONEDA:

    FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK. 
    act_moneda = ROWID(Moneda).

END PROCEDURE.


