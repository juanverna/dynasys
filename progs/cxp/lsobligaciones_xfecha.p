/*=================================================================================*/
/*         LISTADO DE OBLIGACIONES PENDIENTES POR FECHA DE VENCIMIENTO             */
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
  "Obligaciones Pendientes por Fecha de Vencimiento" AT 48
  "Página:" AT 120 PAGE-NUMBER FORMAT ">>>9" AT 127
  SKIP
  fecha_lis
  "Importes en" AT 48
  desc_moneda NO-LABEL
  hora_lis AT 120
  SKIP(1)
  WITH WIDTH 150 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cta_cte_prv.fecha_vencimiento  COLUMN-LABEL "Venci-!miento"
  que_comprobante                COLUMN-LABEL "Identificación!del comprobante" FORMAT "X(20)" 
  Imputacion.abrevia             COLUMN-LABEL "Con-!cepto"
  Cta_cte_prv.fecha_emision      COLUMN-LABEL "Fecha!Emisión"
  saldo_c                        COLUMN-LABEL "Saldo del!comprobante"
  Cta_cte_prv.fecha_programada   COLUMN-LABEL "Progra-!mada para"
  Cta_cte_prv.imp_programado     COLUMN-LABEL "Importe!Programado"
  Proveedor.cdg_Proveedor        COLUMN-LABEL "Código!Proveedor"
  Proveedor.nombre               COLUMN-LABEL "Razón!Social"
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
            FIRST Proveedor FIELDS(cdg_proveedor nombre) OF Cta_cte_prv WHERE
                  Proveedor.cdg_proveedor >= des_codigo AND
                  proveedor.cdg_proveedor <= has_codigo
                  BREAK BY Cta_cte_prv.fecha_vencimiento 
                        BY Proveedor.cdg_proveedor:
    
        VIEW FRAME frm-titulo.
    
        saldo_c =  Cta_cte_prv.credito - Cta_cte_prv.debito.
        saldo = saldo + saldo_c.
                               
        que_comprobante =   Cta_cte_prv.tip_comprob + " " +
                            STRING(Cta_cte_prv.prf_comprob,"9999") + " " + 
                            STRING(Cta_cte_prv.nro_comprob,"99999999") + " " + 
                            STRING(Cta_cte_prv.nro_vencimiento,"999").                               
                               
        DISPLAY Proveedor.cdg_proveedor 
                Proveedor.nombre        
                que_comprobante
                Imputacion.abrevia
                Cta_cte_prv.fecha_emision
                Cta_cte_prv.fecha_vencimiento
                saldo_c
                Cta_cte_prv.fecha_programada WHEN Cta_cte_prv.programada
                Cta_cte_prv.imp_programado WHEN Cta_cte_prv.programada
                WITH FRAME frm-listado.
    
        DOWN WITH FRAME frm-listado.
    
        IF LAST-OF(Cta_cte_prv.fecha_vencimiento)
        THEN DO:
    
            UNDERLINE Proveedor.cdg_proveedor
                      Proveedor.nombre        
                      que_comprobante
                      Cta_cte_prv.fecha_emision
                      Imputacion.abrevia
                      Cta_cte_prv.fecha_emision
                      Cta_cte_prv.fecha_vencimiento
                      saldo_c
                      WITH FRAME frm-listado.
    
            DISPLAY   saldo @ saldo_c
                      WITH FRAME frm-listado.
            saldo_total = saldo_total + saldo.
            saldo = 0.
            DOWN 2 WITH FRAME frm-listado.
            
        END.    
  END.            
  DOWN 2 WITH FRAME frm-listado.
  DISPLAY "***FIN***" @ Proveedor.cdg_proveedor WITH FRAME frm-listado.

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

