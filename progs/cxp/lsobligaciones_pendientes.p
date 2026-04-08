/*=================================================================================*/
/*             LISTADO DE SALDOS ANALITICOS CON O SIN MOVIMIENTOS                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo      LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER que_moneda      LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER ver_por         AS INTEGER.
DEFINE INPUT PARAMETER des_fecha       AS DATE.
DEFINE INPUT PARAMETER has_fecha       AS DATE.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}

DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".
DEFINE VARIABLE saldo_c                AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".
DEFINE VARIABLE saldo_total            AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".

DEFINE VARIABLE que_comprobante        AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Obligaciones Pendientes por Proveedor" AT 52
  "Página:" AT 127 PAGE-NUMBER FORMAT ">>>9" AT 134
  SKIP
  fecha_lis
  "Importes en" AT 52
  desc_moneda NO-LABEL
  hora_lis AT 127
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Proveedor.cdg_Proveedor        COLUMN-LABEL "Código!Proveedor"
  Proveedor.nombre               COLUMN-LABEL "Razón!Social"
  que_comprobante                COLUMN-LABEL "Identificación!del comprobante" FORMAT "X(20)" 
  Imputacion.abrevia             COLUMN-LABEL "Con-!cepto"
  Cta_cte_prv.fecha_emision      COLUMN-LABEL "Fecha!Emisión"
  Cta_cte_prv.fecha_vencimiento  COLUMN-LABEL "Venci-!miento"
  Cta_cte_prv.debito             
  Cta_cte_prv.credito
  saldo_c                        COLUMN-LABEL "Saldo del!comprobante"
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.

RUN LISTAR.

/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.

  {dirprinfile.i}

  FOR EACH Cta_cte_prv 
      WHERE Cta_cte_prv.fecha_vencimiento <= has_fecha 
        AND Cta_cte_prv.fecha_vencimiento >= des_fecha
        AND Cta_cte_prv.debito <> Cta_cte_prv.credito,
            FIRST Imputacion FIELDS(abrevia) OF Cta_cte_prv,
            FIRST Proveedor FIELDS(cdg_proveedor nombre) OF Cta_cte_prv
                  BREAK BY Proveedor.cdg_proveedor 
                        BY Cta_cte_prv.fecha_vencimiento:
    
        VIEW FRAME frm-titulo.
    
        saldo_c =  Cta_cte_prv.credito - Cta_cte_prv.debito.
        saldo = saldo + saldo_c.
                               
        que_comprobante =   Cta_cte_prv.tip_comprob + " " +
                            STRING(Cta_cte_prv.prf_comprob,"9999") + " " + 
                            STRING(Cta_cte_prv.nro_comprob,"99999999") + " " + 
                            STRING(Cta_cte_prv.nro_vencimiento,"999").                               
                               
        DISPLAY Proveedor.cdg_proveedor WHEN FIRST-OF(Proveedor.cdg_proveedor)
                Proveedor.nombre        WHEN FIRST-OF(Proveedor.cdg_proveedor)
                que_comprobante
                Imputacion.abrevia
                Cta_cte_prv.fecha_emision
                Cta_cte_prv.fecha_vencimiento
                Cta_cte_prv.debito      WHEN Cta_cte_prv.debito <> 0
                Cta_cte_prv.credito     WHEN Cta_cte_prv.credito <> 0
                saldo_c
                WITH FRAME frm-listado.
    
        DOWN WITH FRAME frm-listado.
    
        IF LAST-OF(Proveedor.cdg_proveedor)
        THEN DO:
    
            UNDERLINE Proveedor.cdg_proveedor
                      Proveedor.nombre        
                      que_comprobante
                      Cta_cte_prv.fecha_emision
                      Imputacion.abrevia
                      Cta_cte_prv.fecha_emision
                      Cta_cte_prv.fecha_vencimiento
                      Cta_cte_prv.debito
                      Cta_cte_prv.credito
                      saldo_c
                      WITH FRAME frm-listado.
    
            DISPLAY   saldo @ saldo_c
                      WITH FRAME frm-listado.
            saldo_total = saldo_total + saldo.
            saldo = 0.
            DOWN 2 WITH FRAME frm-listado.
            
        END.    
        
  END.            

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

