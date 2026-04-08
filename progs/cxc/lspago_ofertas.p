/*=================================================================================*/
/*        EMITE UN LISTADO DE LOS PEDIDOS DE OFERTA Y SU ESTADO DE CTA CTE         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_vendedor    LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER has_vendedor    LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.

/*=================================================================================*/
/*                                       VARIABLES                                 */
/*=================================================================================*/

DEFINE VARIABLE t-vendido  AS DECIMAL.
DEFINE VARIABLE t-cobrado  AS DECIMAL.
DEFINE VARIABLE e-vendido  AS DECIMAL.
DEFINE VARIABLE e-cobrado  AS DECIMAL.
DEFINE VARIABLE v-vendido  AS DECIMAL.
DEFINE VARIABLE v-cobrado  AS DECIMAL.

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Pedidos de Oferta por Empresa/Vendedor" AT 55
    "Página:" AT 163 PAGE-NUMBER FORMAT ">>9" AT 170
    SKIP  
    fecha_lis
    hora_lis AT 163
    SKIP
    WITH WIDTH 240 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Ped_header.cdg_empresa     COLUMN-LABEL "Código!Empresa"
    Vendedor.nombre            COLUMN-LABEL "Nombre!Vendedor"  
    Ped_header.fecha           COLUMN-LABEL "Fecha!Pedido"
    Cliente.cdg_cliente        COLUMN-LABEL "Código!Cliente"
    Cliente.nom_cliente        COLUMN-LABEL "Nombre!Cliente"
    Ped_header.tip_comprob     COLUMN-LABEL "Ti-!po"     
    Ped_header.prf_comprob     COLUMN-LABEL "Pre-!fijo"      
    Ped_header.nro_comprob     COLUMN-LABEL "Número!Pedido"
    Fac_header.tip_comprob     COLUMN-LABEL "Ti-!po"     
    Fac_header.prf_comprob     COLUMN-LABEL "Pre-!fijo"      
    Fac_header.nro_comprob     COLUMN-LABEL "Número!Factura"          
    Cta_cte.nro_vencimiento    COLUMN-LABEL "Nro.!Ven."
    Cta_cte.debito             COLUMN-LABEL "Importe!Facturado"
    Cta_cte.credito            COLUMN-LABEL "Importe!Cobrado" 
    WITH WIDTH 240 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

que_empresa = "CONSOLIDADO".

{dirprinfile.i}

DO WITH FRAME frm-listado:

    FOR EACH Ped_header 
        WHERE Ped_header.cdg_oferta <> "" 
          AND Ped_header.cdg_estado = "CC"
          AND Ped_header.fecha >= des_fecha
          AND Ped_header.fecha <= has_fecha,
        FIRST Vendedor OF Ped_header WHERE Vendedor.cdg_vendedor >= des_vendedor
                                       AND Vendedor.cdg_vendedor <= has_vendedor, 
        Cliente OF Ped_header,
        FIRST Rem_header WHERE Rem_header.nro_pedido = Ped_header.nro_pedido,
        FIRST Fac_header WHERE Fac_header.nro_remito = Rem_header.nro_remito,
        EACH Cta_cte WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                       AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                       AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
        BREAK BY Ped_header.cdg_empresa
              BY Vendedor.cdg_vendedor
              BY Ped_header.fecha:
    
        VIEW FRAME frm-titulo.
    
        DISPLAY 
               Ped_header.cdg_empresa WHEN FIRST-OF(Ped_header.cdg_empresa)
               Vendedor.nombre        WHEN FIRST-OF(Vendedor.cdg_vendedor)
               Ped_header.fecha       WHEN FIRST-OF(Ped_header.fecha)
               Cliente.cdg_cliente
               Cliente.nom_cliente
               Ped_header.tip_comprob          
               Ped_header.prf_comprob           
               Ped_header.nro_comprob    
               Fac_header.tip_comprob          
               Fac_header.prf_comprob           
               Fac_header.nro_comprob               
               Cta_cte.nro_vencimiento
               Cta_cte.debito
               Cta_cte.credito
               WITH STREAM-IO FRAME frm-listado.
    
        DOWN WITH FRAME frm-listado.
               
        v-vendido = v-vendido + Cta_cte.debito.
        v-cobrado = v-cobrado + Cta_cte.credito.           
        
        IF LAST-OF(Vendedor.cdg_vendedor)
        THEN DO:
        
             UNDERLINE
                Cta_cte.debito
                Cta_cte.credito
                WITH STREAM-IO FRAME frm-listado.
    
             DISPLAY
               "Total"   @ Cliente.nom_cliente
               v-vendido @ Cta_cte.debito
               v-cobrado @ Cta_cte.credito
               WITH STREAM-IO FRAME frm-listado.
    
             DOWN 2 WITH FRAME frm-listado.
    
             e-vendido = e-vendido + v-vendido.
             e-cobrado = e-cobrado + v-cobrado.
    
             v-vendido = 0.
             v-cobrado = 0.
    
        END.
        
        IF LAST-OF(Ped_header.cdg_empresa)
        THEN DO:
             UNDERLINE
                Cta_cte.debito
                Cta_cte.credito
                WITH STREAM-IO FRAME frm-listado.
    
             DISPLAY
               "TOTAL EMPRESA"  @ Cliente.nom_cliente
               e-vendido @ Cta_cte.debito
               e-cobrado @ Cta_cte.credito
               WITH STREAM-IO FRAME frm-listado.
    
             DOWN 2 WITH FRAME frm-listado.
    
             t-vendido = t-vendido + e-vendido.
             t-cobrado = t-cobrado + e-cobrado.
    
             e-vendido = 0.
             e-cobrado = 0.
    
        END.
        
    END.    
    
    UNDERLINE
       Cta_cte.debito
       Cta_cte.credito
       WITH STREAM-IO FRAME frm-listado.
    
    DISPLAY
      "TOTAL GENERAL"  @ Cliente.nom_cliente
      t-vendido @ Cta_cte.debito
      t-cobrado @ Cta_cte.credito
      WITH STREAM-IO FRAME frm-listado.
    
    DOWN WITH FRAME frm-listado.

END.

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida,
                 INPUT 22)
