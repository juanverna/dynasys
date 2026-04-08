/*=================================================================================*/
/*  LISTA TODOS LOS COMPROBANTES SALDADOS ENTRE 2 FECHAS PARA UNA MONEDA           */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_codigo  LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.cdg_moneda.

/*=================================================================================*/
/*                              VARIABLES Y FRAMES                                 */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}
{WGLISTAR.I}

DEFINE VARIABLE total_pagado       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99".
DEFINE VARIABLE que_comprob        AS CHARACTER FORMAT "X(19)".
DEFINE VARIABLE que_ordenpago      AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE desc_moneda        LIKE Moneda.descripcion.

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Pagos por Proveedor Efectuados del " AT 40
  des_fecha
  "al"
  has_fecha
  "Página:" AT 111 PAGE-NUMBER FORMAT ">>9" AT 118
  SKIP
  fecha_lis
  "Importes en" AT 40
  desc_moneda NO-LABEL
  hora_lis AT 111
  SKIP(1)
  WITH WIDTH 130 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Proveedor.cdg_Proveedor       COLUMN-LABEL "Código!Proveedor"
  Proveedor.nombre              COLUMN-LABEL "Razón!Social"
  Opg_header.fecha              COLUMN-LABEL "Fecha!Pago"
  que_ordenpago                 COLUMN-LABEL "Identificación!de la O/Pago"
  que_comprob                   COLUMN-LABEL "Identificación!del comprobante"
  Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Venci-!miento"
  Opg_detalle.importe           COLUMN-LABEL "Importe!Pagado"
  WITH WIDTH 170 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


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

  {dirprinfile.i}
  
  OPEN QUERY qry_proveedor 
        FOR EACH Proveedor NO-LOCK WHERE Proveedor.cdg_proveedor >= des_codigo
             AND Proveedor.cdg_proveedor <= has_codigo
             AND Proveedor.titular_oxp_sino = FALSE
              BY Proveedor.cdg_proveedor.  
  GET FIRST qry_proveedor.
  DO WHILE AVAILABLE Proveedor:
     VIEW FRAME frm-titulo.
     RUN LISTAR.
     GET NEXT qry_proveedor.
  END.   

  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22).

END PROCEDURE.

PROCEDURE LISTAR:

    total_pagado = 0.

    FOR EACH Opg_header OF Proveedor 
      WHERE Opg_header.cdg_empresa = Empresa.cdg_empresa
        AND NOT Opg_header.anulado
        AND Opg_header.fecha <= has_fecha 
        AND Opg_header.fecha >= des_fecha,
        EACH Opg_detalle OF Opg_header, 
        FIRST Cta_cte_prv 
             WHERE Cta_cte_prv.nro_proveedor   = Opg_header.nro_proveedor
               AND Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
               AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
               AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
               AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela
               AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
               BREAK BY Opg_header.fecha       
                     BY Opg_header.nro_comprob:

        que_ordenpago = Opg_header.tip_comprob + " " + 
                        STRING(Opg_header.prf_comprob,"9999")  + " " + 
                        STRING(Opg_header.nro_comprob,"ZZZZZZZZ").

        que_comprob = Cta_cte_prv.tip_comprob + " " + 
                      STRING(Cta_cte_prv.prf_comprob,"9999")  + " " + 
                      STRING(Cta_cte_prv.nro_comprob,"ZZZZZZZZ") + " " + 
                      STRING(Cta_cte_prv.nro_vencimiento,"Z9").
        DISPLAY
                Proveedor.cdg_Proveedor  WHEN FIRST(Opg_header.fecha)
                Proveedor.nombre         WHEN FIRST(Opg_header.fecha)
                Opg_header.fecha         WHEN FIRST-OF(Opg_header.fecha)
                que_ordenpago            WHEN FIRST-OF(Opg_header.nro_comprob)
                que_comprob
                Cta_cte_prv.fecha_vencimiento
                Opg_detalle.importe
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.

        total_pagado = total_pagado + Opg_detalle.importe.
        
        IF LAST(Opg_header.nro_comprob)
        THEN DO:
            UNDERLINE
                Proveedor.cdg_Proveedor
                Proveedor.nombre 
                Opg_header.fecha
                que_ordenpago
                que_comprob
                Cta_cte_prv.fecha_vencimiento
                Opg_detalle.importe
                WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.
            DISPLAY
                total_pagado @ Opg_detalle.importe
                WITH FRAME frm-listado.
            DOWN 2 WITH FRAME frm-listado.
        END.

    END.

END PROCEDURE.
