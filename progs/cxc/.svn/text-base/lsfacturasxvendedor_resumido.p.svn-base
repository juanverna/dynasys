/*=================================================================================*/
/*                            FACTURACION POR VENDEDOR                             */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo       LIKE vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_codigo       LIKE vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha        AS DATE.
DEFINE INPUT PARAMETER has_fecha        AS DATE.
DEFINE INPUT PARAMETER que_moneda       LIKE Moneda.cdg_moneda.

/*=================================================================================*/
/*                            VARIABLES Y FRAMES                                   */
/*=================================================================================*/

{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE t-credito   AS DECIMAL.
DEFINE VARIABLE t-debito    AS DECIMAL.

DEFINE VARIABLE linpag  AS INTEGER INITIAL 60.

DEFINE VARIABLE tit_vendedor AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE VARIABLE v-total_empresa      AS DECIMAL.
DEFINE VARIABLE v-total_vendedor     AS DECIMAL.

DEFINE VARIABLE v-totrc_empresa      AS DECIMAL.
DEFINE VARIABLE v-totrc_vendedor     AS DECIMAL.

DEFINE VARIABLE creditos             AS DECIMAL.
DEFINE VARIABLE debitos              AS DECIMAL.

DEFINE VARIABLE acum-creditos             AS DECIMAL.
DEFINE VARIABLE acum-debitos              AS DECIMAL.
DEFINE VARIABLE acum-empresa              AS DECIMAL.

DEFINE VARIABLE v-imp_recibo         LIKE Cta_cte.debito COLUMN-LABEL "Importe!Recibo".
DEFINE VARIABLE que_sector           LIKE Area.cdg_area.
{findsector.i}
que_sector = Area.cdg_area.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa AT 1
  "Total de Ventas resumidas por Vendedor." AT 38
  "Página:" AT 110 PAGE-NUMBER FORMAT ">>9" AT 117
  SKIP  
  fecha_lis AT 1
  
  hora_lis AT 110
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

    {findempresa.i} 
    que_empresa = Empresa.nombre.

    {dirprinfile.i} 

    FOR EACH Vendedor WHERE Vendedor.cdg_vendedor <= has_codigo
                        AND Vendedor.cdg_vendedor >= des_codigo NO-LOCK, 
        EACH Cliente NO-LOCK OF Vendedor
        WHERE LOOKUP(que_sector, Cliente.lista_sectores) <> 0, 
            EACH Cta_cte NO-LOCK OF Cliente 
                WHERE LOOKUP(Cta_cte.cdg_empresa,v-lista_empresas) <> 0
                AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa)
                  AND Cta_cte.fecha_emision >= des_fecha
                  AND Cta_cte.fecha_emision <= has_fecha 
                 BREAK BY Vendedor.cdg_vendedor BY Cta_cte.cdg_empresa BY Cta_cte.fecha_emision:

        VIEW FRAME frm-titulo.

        tit_vendedor = STRING(Vendedor.cdg_vendedor) + "-" + Vendedor.nombre.
          
        v-imp_recibo = 0.

        IF Cta_cte.tip_comprob BEGINS "F" OR Cta_cte.tip_comprob BEGINS "D"
        THEN DO:
            v-total_empresa = v-total_empresa + Cta_cte.debito.
            acum-debitos = acum-debitos + Cta_cte.debito.
        END.
        ELSE DO:
            IF Cta_cte.tip_comprob BEGINS "R"
            THEN DO:
                v-totrc_empresa = v-totrc_empresa + Cta_cte.credito.
                v-imp_recibo = Cta_cte.credito.
                acum-creditos = acum-creditos + Cta_cte.credito.
            END.
            ELSE DO:
                v-total_empresa = v-total_empresa - Cta_cte.credito.
               
            END.
        END.

/*         DISPLAY Cta_cte.fecha_emision                                                                                                          */
/*                 Cliente.cdg_cliente                                                                                                            */
/*                 Cliente.nom_cliente                                                                                                            */
/*                 Cta_cte.tip_comprob                                                                                                            */
/*                 Cta_cte.prf_comprob                                                                                                            */
/*                 Cta_cte.nro_comprob                                                                                                            */
/*                 Cta_cte.debito WHEN ( Cta_cte.tip_comprob BEGINS "F" OR Cta_cte.tip_comprob BEGINS "D" )                                       */
/*                 Cta_cte.credito WHEN NOT ( Cta_cte.tip_comprob BEGINS "F" OR Cta_cte.tip_comprob BEGINS "D" OR Cta_cte.tip_comprob BEGINS "R") */
/*                 v-imp_recibo WHEN ( Cta_cte.tip_comprob BEGINS "R")                                                                            */
/*             WITH FRAME frm-listado.                                                                                                            */
/*         DOWN WITH FRAME frm-listado.  */

        IF FIRST-OF(Vendedor.cdg_vendedor) 
            THEN DISPLAY  tit_vendedor COLUMN-LABEL "Vendedor"
                          WITH FRAME frm-listado.

        IF LAST-OF(Cta_cte.cdg_empresa)
        THEN DO:
            FIND Empresa OF Cta_cte NO-LOCK.
/*             UNDERLINE Cta_cte.debito Cta_cte.credito v-imp_recibo */
/*                       WITH FRAME frm-listado.                     */
            

            DISPLAY  "Subtotal " + Empresa.nombre @ Cliente.nom_cliente
                     v-total_empresa @ Cta_cte.debito
                     v-totrc_empresa @ v-imp_recibo
                      WITH FRAME frm-listado.
            DOWN 2 WITH FRAME frm-listado.
            v-total_vendedor = v-total_vendedor + v-total_empresa.
            v-totrc_vendedor = v-totrc_vendedor + v-totrc_empresa.
            v-total_empresa = 0.          
            v-totrc_empresa = 0.          
            
        END.
        

        IF LAST-OF(Vendedor.cdg_vendedor)
        THEN DO:
            UNDERLINE Cta_cte.debito Cta_cte.credito v-imp_recibo
                      WITH FRAME frm-listado.

            DISPLAY  "TOTAL " + Vendedor.nombre @ Cliente.nom_cliente
                     v-total_vendedor @ Cta_cte.debito
                     v-totrc_vendedor @ v-imp_recibo
                      WITH FRAME frm-listado.
            DOWN 2 WITH FRAME frm-listado.
            v-total_vendedor = 0.          
            v-totrc_vendedor = 0.          

/*             IF NOT LAST(Vendedor.cdg_vendedor) THEN PAGE. */
        END.
    
    END.
    UNDERLINE Cta_cte.debito Cta_cte.credito v-imp_recibo
                      WITH FRAME frm-listado.

    DISPLAY "TOTAL ZONAS "  @ Cliente.nom_cliente
            acum-debitos @ Cta_cte.debito
            acum-creditos @ v-imp_recibo WITH FRAME frm-listado.
    OUTPUT CLOSE.
    RUN veresult.w ( INPUT arch_salida,
                     INPUT 22).

END PROCEDURE.

