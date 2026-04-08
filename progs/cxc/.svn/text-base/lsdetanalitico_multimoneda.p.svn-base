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

/*=================================================================================*/
/*                                  VARIABLES Y FRAMES                             */
/*=================================================================================*/

{VRSHARED.I}
{FINDEMPRESA.I}
{dfvarimp.i}

DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE QUERY qry_cliente               FOR Cliente.

DEFINE VARIABLE creditos               AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Débito!Original".
DEFINE VARIABLE debitos                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Crédito!Original".
DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo!Original".

DEFINE VARIABLE acum_debitos           AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_creditos          AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE acum_saldo             AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE nom-vend               AS CHARACTER.
DEFINE VARIABLE hubo_cliente           AS LOGICAL.
DEFINE VARIABLE ver_cliente            AS LOGICAL.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE v-cdg_moneda           AS CHARACTER.
DEFINE VARIABLE debitos_rex            AS DECIMAL  FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Débito!Reexpresado".
DEFINE VARIABLE creditos_rex           AS DECIMAL  FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Crédito!Reexpresado".
DEFINE VARIABLE saldo_rex              AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo!Reexpresado".

DEFINE VARIABLE que_sector             LIKE Area.cdg_area.

{WGLISTAR.I}

DEFINE FRAME frm-titulo-sdo HEADER
    que_empresa 
    "Cuentas Corrientes - Movimientos Reexpresados" AT 50
    "Página:" AT 143 PAGE-NUMBER FORMAT ">>>9" AT 152
    SKIP
    fecha_lis
    det_titulo AT 50 NO-LABEL
    hora_lis AT 143
    SKIP
    "Importes en" AT 50
    desc_moneda NO-LABEL
    SKIP(1)
    "---------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP       
    "Cliente Razón Social                                                                                                                                     " SKIP
    "  Identificación del        Fecha de  Fecha de    Moneda       Tasa       Débitos      Créditos      Saldo           Débitos      Créditos          Saldo" SKIP
    "     Comprobante            Emisión   Vencimiento Origen     Cambio      M.Origen      M.Origen      M.Origen    Reexpresado   Reexpresado    Reexpresado" SKIP           
    "---------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP (1)
    WITH WIDTH 196 FRAME frm-titulo-sdo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-sdo
    Cliente.cdg_cliente
    SPACE(2)
    Cliente.nom_cliente 
    SPACE(3)
    nom-vend 
    SPACE(2)
    saldo 
    WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-sdo USE-TEXT STREAM-IO NO-LABEL.

DEFINE FRAME frm-titulo-mov HEADER
    que_empresa 
    "Cuentas Corrientes - Movimientos Reexpresados" AT 40
    "Pagina:" AT 122 PAGE-NUMBER FORMAT ">>9" AT 129
    SKIP  
    fecha_lis
    det_titulo AT 40 NO-LABEL
    hora_lis AT 122
    SKIP
    "Importes en" AT 40
    desc_moneda NO-LABEL
    SKIP(1)
    WITH WIDTH 140 FRAME frm-titulo-mov TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
    SPACE(3)
    Cta_cte.tip_comprob
    Cta_cte.prf_comprob
    Cta_cte.nro_comprob FORMAT "ZZZZZ9"
    Cta_cte.nro_vencimiento FORMAT "9" COLUMN-LABEL "V"
    Imputacion.abrevia
    Cta_cte.fecha_emision
    Cta_cte.fecha_vencimiento
    Moneda.abrevia
    Cta_cte.cambio
    Cta_cte.debito
    Cta_cte.credito
    saldo
    debitos_rex
    creditos_rex
    saldo_rex
    WITH WIDTH 180 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-LABEL.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

/*{SETIMPRE.I}*/

{findempresa.i}
que_empresa = Empresa.nombre.

{findsector.i}
que_sector = Area.cdg_area.

/* RUN getparametro.p (  INPUT  "DFMONEDA",                 */
/*                       OUTPUT v-valor_c,                  */
/*                       OUTPUT v-valor_d,                  */
/*                       OUTPUT v-valor_l,                  */
/*                       OUTPUT v-valor_n,                  */
/*                       OUTPUT v-observacion ).            */
/* FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK. */
/* act_moneda = ROWID(Moneda).                              */
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
    
    UNDERLINE debitos_rex Cta_cte.credito saldo
            WITH FRAME frm-listado-mov.
    DISPLAY acum_debitos @ Cta_cte.debito
            acum_creditos @ Cta_cte.credito
            acum_saldo @ saldo
            WITH FRAME frm-listado-mov.

    DOWN WITH FRAME frm-listado-mov.
    
    UNDERLINE debitos_rex creditos_rex saldo
            WITH FRAME frm-listado-mov.
    
    DISPLAY " " @ Cliente.cdg_cliente WITH FRAME frm-listado-mov.
    
    OUTPUT CLOSE.
    RUN veresult.w ( INPUT arch_salida, INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE PROCESAR_CLIENTE.

       act_cliente = ROWID(Cliente).

       ASSIGN debitos       = 0
              creditos      = 0
              saldo         = 0
              debitos_rex   = 0
              creditos_rex  = 0
              saldo_rex     = 0.
        
       hubo_cliente = NO.

       VIEW FRAME frm-titulo-sdo.
                   
                       /* Recorremos los movimientos acumulando saldo */

       FOR EACH Cta_cte OF Cliente WHERE Cta_cte.credito <> Cta_cte.debito
                                     AND Cta_cte.fecha_emision >= des_fecha
                                     AND Cta_cte.fecha_emision <= has_fecha
                                     AND Cta_cte.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
                                         Moneda OF Cta_cte NO-LOCK,
                                    EACH Imputacion OF Cta_cte NO-LOCK BREAK BY Moneda.cdg_moneda BY Cta_cte.fecha_emision:

            debitos_rex = Cta_cte.debito * Cta_cte.cambio.
            creditos_rex = Cta_cte.credito * Cta_cte.cambio.
            saldo_rex = saldo_rex + debitos_rex - creditos_rex.

            debitos = debitos + Cta_cte.debito.
            creditos = creditos + Cta_cte.credito.
            saldo = saldo + Cta_cte.debito - Cta_cte.credito.
         
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

            IF LAST-OF (Moneda.cdg_moneda)
            THEN DO:
                UNDERLINE saldo saldo_rex WITH FRAME frm-listado-mov.
                DOWN WITH FRAME frm-listado-mov.
                DISPLAY saldo saldo_rex WITH FRAME frm-listado-mov.
                DOWN 1 WITH FRAME frm-listado-mov.

                acum_debitos = acum_debitos + debitos.
                acum_creditos = acum_creditos + creditos.
                acum_saldo = acum_saldo + (debitos - creditos).

            END.
      
       END.

       IF hubo_cliente
       THEN DO:
            saldo = debitos - creditos. 
            UNDERLINE saldo saldo_rex WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.

            DISPLAY saldo saldo_rex WITH FRAME frm-listado-mov.
            DOWN WITH FRAME frm-listado-mov.

            ASSIGN debitos       = 0
                   creditos      = 0
                   saldo         = 0
                   debitos_rex   = 0
                   creditos_rex  = 0
                   saldo_rex     = 0.

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
            Moneda.abrevia
            Cta_cte.cambio  
            Cta_cte.debito  WHEN Cta_cte.debito <> 0
            Cta_cte.credito WHEN Cta_cte.credito <> 0
            saldo
            debitos_rex     WHEN debitos_rex <> 0
            creditos_rex    WHEN creditos_rex <> 0
            saldo_rex
            WITH FRAME frm-listado-mov.
     
    DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

PROCEDURE PONER_MONEDA:
   FIND Moneda WHERE Moneda.es_local = TRUE NO-LOCK.
    act_moneda   = ROWID(Moneda).
    v-cdg_moneda = Moneda.cdg_moneda.
END PROCEDURE.


