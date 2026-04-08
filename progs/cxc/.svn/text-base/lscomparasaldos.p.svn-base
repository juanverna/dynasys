/*====================================================================================*/
/*              LISTADO COMPARATIVO DE SALDOS HISTORICOS Y ANALITICOS                 */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo     LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo     LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_nombre     LIKE Cliente.nom_cliente.
DEFINE INPUT PARAMETER has_nombre     LIKE Cliente.nom_cliente.
DEFINE INPUT PARAMETER ver_por        AS INTEGER.
DEFINE INPUT PARAMETER que_moneda     LIKE Moneda.cdg_moneda. 
DEFINE INPUT PARAMETER incluir_cero   AS LOGICAL.

/*====================================================================================*/
/*                              VARIABLES LOCALES                                     */
/*====================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE creditos              AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE debitos               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo                 AS DECIMAL.
DEFINE VARIABLE saldo_historico       AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo His.".
DEFINE VARIABLE saldo_analitico       AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo Anl.".
DEFINE VARIABLE saldo_diferencia      AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Diferencia".

DEFINE VARIABLE por_cod               AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom               AS INTEGER INITIAL 0.

DEFINE VARIABLE det_titulo            AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE desc_moneda           LIKE Moneda.descripcion.

DEFINE VARIABLE que_sector            LIKE Area.cdg_area.

/*====================================================================================*/
/*                                     FRAMES                                         */
/*====================================================================================*/

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Comparación de Saldos" AT 37
    "Página:" AT 82 PAGE-NUMBER FORMAT ">>9" AT 90
    SKIP
    fecha_lis
    det_titulo AT 37 NO-LABEL
    hora_lis AT 90
    SKIP
    "Importes en" AT 37
    desc_moneda NO-LABEL
    SKIP(1)
    WITH WIDTH 120 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Cliente.cdg_Cliente
    Cliente.nom_cliente
    saldo_historico
    saldo_analitico
    saldo_diferencia
    /*
    Rec_header.tip_comprob 
    Rec_header.prf_comprob 
    Rec_header.nro_comprob
    Rec_header.imp_total
    Rec_header.fecha
    */
    WITH WIDTH 220 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
{findsector.i}
que_sector = Area.cdg_area.

FIND Moneda WHERE Moneda.cdg_moneda = "PE" NO-LOCK.

RUN LISTAR.


/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.
  det_titulo = "Históricos vs Analíticos".

  {dirprinfile.i &LIN-PAG 84}

  {OPQRYCLI.I}
  
  GET FIRST qry_Cliente.
  DO WHILE AVAILABLE Cliente:
     VIEW FRAME frm-titulo.
     RUN PROCESAR.
     IF saldo_historico <> saldo_analitico OR incluir_cero
     THEN DO:
          DISPLAY Cliente.cdg_Cliente
                  Cliente.nom_cliente
                  saldo_historico
                  saldo_analitico
                  saldo_diferencia
                  WITH FRAME frm-listado.     
          /*
          FOR EACH Rec_header OF Cliente WHERE Rec_header.tipo_pago = 2 AND Rec_header.anulado:
              DISPLAY Rec_header.tip_comprob 
                      Rec_header.prf_comprob 
                      Rec_header.nro_comprob
                      Rec_header.imp_total
                      Rec_header.fecha
                      WITH FRAME frm-listado.     
              DOWN WITH FRAME frm-listado. 
          END.
          */
          DOWN WITH FRAME frm-listado. 
     END.             
     GET NEXT qry_Cliente.
  END.   

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.


END PROCEDURE.

PROCEDURE PROCESAR:
   saldo_diferencia = 0.
   RUN CALCULAR_HISTORICO.
   saldo_historico = saldo.

   RUN CALCULAR_ANALITICO.
   saldo_analitico = saldo.

   saldo_diferencia = saldo_analitico - saldo_historico.
   

END PROCEDURE.


PROCEDURE CALCULAR_HISTORICO:

   debitos = 0.
   creditos = 0.

   FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
        AND Cta_cte.cdg_empresa = Empresa.cdg_empresa:

       IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
       THEN DO:
            debitos  = debitos + Cta_cte.debito.
       END.     
       ELSE DO:
            creditos = creditos + Cta_cte.credito.
       END.     

   END.
   
   saldo = debitos - creditos.

END PROCEDURE.

PROCEDURE CALCULAR_ANALITICO:

   debitos = 0.
   creditos = 0.
   
   FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
        AND Cta_cte.cdg_empresa = Empresa.cdg_empresa      
        AND Cta_cte.debito <> Cta_cte.credito:

        debitos  = debitos + Cta_cte.debito.
        creditos = creditos + Cta_cte.credito.

   END.

   saldo = debitos - creditos.

END PROCEDURE.

