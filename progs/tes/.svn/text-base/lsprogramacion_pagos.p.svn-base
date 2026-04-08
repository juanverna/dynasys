/*=================================================================================*/
/*                            LISTADO DE PROGRAMACION DE PAGOS                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha   AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER ver_pagos   AS INTEGER.
DEFINE INPUT PARAMETER rid_moneda  AS ROWID.

/*=================================================================================*/
/*                               VARIABLES Y FRAMES                                */
/*=================================================================================*/

{VRSHARED.I }
{dfvarimp.i }

DEFINE VARIABLE todos          AS   INTEGER INITIAL 0.
DEFINE VARIABLE con_p          AS   INTEGER INITIAL 1.
DEFINE VARIABLE sin_p          AS   INTEGER INITIAL 2.
DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Importe".
DEFINE VARIABLE t_programado   AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Programado".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(45)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(45)".
DEFINE VARIABLE que_Proveedor  LIKE Proveedor.cdg_Proveedor.
DEFINE VARIABLE que_nombre     LIKE Proveedor.nombre.

DEFINE QUERY qry_movimiento   FOR Cta_cte_prv, Imputacion, Proveedor.

DEFINE FRAME frm-titulo HEADER
       que_empresa FORMAT "X(25)"
       titulo-f AT 35
       "Página:" AT 99 PAGE-NUMBER FORMAT ">9" AT 106 SKIP
       fecha_lis
       titulo-2 AT 35
       hora_lis AT 99
       SKIP(1)
       WITH WIDTH 120 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Proveedor.cdg_proveedor
       Proveedor.nombre FORMAT "X(20)"
       Cta_cte_prv.tip_comprob
       Cta_cte_prv.prf_comprob FORMAT "ZZZ9"
       Cta_cte_prv.nro_comprob FORMAT "ZZZZZZZ9"
       Cta_cte_prv.nro_vencimiento COLUMN-LABEL "Ven"
       Imputacion.abrevia
       Cta_cte_prv.fecha_vencimiento
       saldo
       Cta_cte_prv.imp_programado
       Cta_cte_prv.fecha_programada
       Cta_cte_prv.programada
       WITH WIDTH 125 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                            BLOQUE PRINCIPAL                                     */
/*=================================================================================*/

{FINDEMPRESA.I}

que_empresa = Empresa.nombre.

FIND Moneda WHERE ROWID(Moneda) = rid_moneda NO-LOCK.
titulo-2 = "Comprende del " + STRING(des_fecha,"99/99/9999") + 
           " al " + STRING(has_fecha,"99/99/9999").

{dirprinfile.i}
RUN ABRE_QUERY.
RUN LISTAR_ANALITICO.
OUTPUT CLOSE.
RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

/*=================================================================================*/
/*                                 PROCEDIMIENTOS                                  */
/*=================================================================================*/

PROCEDURE LISTAR_ANALITICO:

   GET FIRST qry_movimiento.
   DO WHILE AVAILABLE Cta_cte_prv WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       DISPLAY   
           Proveedor.cdg_proveedor
           Proveedor.nombre
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia
           Cta_cte_prv.fecha_vencimiento
           ( Cta_cte_prv.credito - Cta_cte_prv.debito ) @ saldo
           Cta_cte_prv.imp_programado
           Cta_cte_prv.fecha_programada
           Cta_cte_prv.programada
           WITH FRAME frm-listado.

       debitos = debitos + Cta_cte_prv.debito.
       creditos = creditos + Cta_cte_prv.credito.
       t_programado = t_programado + Cta_cte_prv.imp_programado.
           
       DOWN WITH FRAME frm-listado.
       GET NEXT qry_movimiento.

   END.

   UNDERLINE 
           Proveedor.cdg_proveedor
           Proveedor.nombre
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia
           Cta_cte_prv.fecha_vencimiento
           saldo
           Cta_cte_prv.imp_programado
           Cta_cte_prv.fecha_programada
           Cta_cte_prv.programada
           WITH FRAME frm-listado.
           
   saldo = creditos - debitos.
   DISPLAY saldo
           t_programado @ Cta_cte_prv.imp_programado
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   
END PROCEDURE.      

PROCEDURE ABRE_QUERY:

  CASE ver_pagos:
    WHEN todos
    THEN DO:
        titulo-f = "Pagos programados o no por fecha de vencimiento".
        OPEN QUERY qry_movimiento
             FOR EACH Cta_cte_prv
                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                  AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                  AND Cta_cte_prv.debito < Cta_cte_prv.credito
                  AND Cta_cte_prv.fecha_vencimiento <= has_fecha
                  AND Cta_cte_prv.fecha_vencimiento >= des_fecha,
                FIRST Imputacion OF Cta_cte_prv, FIRST Proveedor OF Cta_cte_prv
                   BY Proveedor.nombre
                   BY Cta_cte_prv.fecha_vencimiento.
    END.
    WHEN con_p
    THEN DO:
        titulo-f = "Pagos programados por fecha de pago".
        OPEN QUERY qry_movimiento
             FOR EACH Cta_cte_prv
                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                  AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                  AND Cta_cte_prv.debito < Cta_cte_prv.credito
                  AND Cta_cte_prv.fecha_programada <= has_fecha
                  AND Cta_cte_prv.fecha_programada >= des_fecha
                  AND Cta_cte_prv.programada,
                FIRST Imputacion OF Cta_cte_prv, FIRST Proveedor OF Cta_cte_prv
                   BY Proveedor.nombre
                   BY Cta_cte_prv.fecha_programada.

    END.
    WHEN sin_p
    THEN DO:
        titulo-f = "Pagos s/programar por fecha de vencimiento".
        OPEN QUERY qry_movimiento
             FOR EACH Cta_cte_prv
                WHERE Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa
                  AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
                  AND Cta_cte_prv.debito < Cta_cte_prv.credito
                  AND Cta_cte_prv.fecha_vencimiento <= has_fecha
                  AND Cta_cte_prv.fecha_vencimiento >= des_fecha
                  AND NOT Cta_cte_prv.programada,
                FIRST Imputacion OF Cta_cte_prv, FIRST Proveedor OF Cta_cte_prv
                   BY Proveedor.nombre
                   BY Cta_cte_prv.fecha_vencimiento.

    END.
    otherwise message "pagos manda fruta" view-as alert-box message.
  END CASE.

  
END PROCEDURE.

