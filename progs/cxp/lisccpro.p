/*=================================================================================*/
/*        IMPRIME LA FICHA DE CUENTA CORRIENTE DE UN PROVEEDOR                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_proveedor AS ROWID.
DEFINE INPUT PARAMETER des_fecha     AS DATE.
DEFINE INPUT PARAMETER has_fecha     AS DATE.
DEFINE INPUT PARAMETER ficha         AS INTEGER.
DEFINE INPUT PARAMETER que_moneda    LIKE Moneda.nro_moneda.

/*=================================================================================*/
/*                     VARIABLES, FRAMES, Y SUBMENUES                              */
/*=================================================================================*/

DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.
DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Créditos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Débitos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE que_Proveedor  LIKE Proveedor.cdg_Proveedor.
DEFINE VARIABLE que_nombre     LIKE Proveedor.nombre.

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       titulo-f AT 38
       "Pagina:" AT 85 PAGE-NUMBER FORMAT ">9" AT 92 
       SKIP
       fecha_lis 
       titulo-2 AT 38 
       hora_lis AT 85
       SKIP(1)
       que_Proveedor  AT 38
       que_nombre
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       SPACE(3)
       Cta_cte_prv.tip_comprob
       Cta_cte_prv.prf_comprob
       Cta_cte_prv.nro_comprob
       Cta_cte_prv.nro_vencimiento
       Imputacion.abrevia           
       Cta_cte_prv.fecha_emision
       Cta_cte_prv.fecha_vencimiento
       Cta_cte_prv.debito 
       Cta_cte_prv.credito 
       saldo
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                           BLOQUE PRINCIPAL                                      */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Proveedor WHERE ROWID(Proveedor) = rid_Proveedor NO-LOCK.
FIND Moneda WHERE Moneda.nro_moneda = que_moneda NO-LOCK.

que_proveedor = Proveedor.cdg_Proveedor.
que_nombre =  Proveedor.nombre.

{dirprinfile.i}

CASE ficha:
     WHEN his THEN RUN LISTAR_HISTORICO.
     WHEN anl THEN RUN LISTAR_ANALITICO.
     WHEN ven THEN RUN LISTAR_VENCIDO.
END.     

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida, INPUT 22).

/*=================================================================================*/
/*                           PROCEDIMIENTOS                                        */
/*=================================================================================*/

PROCEDURE CALCULAR_EI:

   DEFINE OUTPUT PARAMETER tot_debitogr AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento desde principio de mes a la fecha */
   FOR EACH Cta_cte_prv OF Proveedor 
       WHERE Cta_cte_prv.fecha_emision < des_fecha
         AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
         AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
       FIRST Tipocomprobante OF Cta_cte_prv NO-LOCK:

      IF Tipocomprobante.debita
         THEN tot_debitogr  = tot_debitogr + Cta_cte_prv.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte_prv.credito.
      
   END.

END.

PROCEDURE LISTAR_HISTORICO:

   titulo-f = "Movimientos de Cuenta Corriente".
   titulo-2 = STRING(des_fecha) +  " - " + STRING(has_fecha) + 
              " - " + Moneda.descripcion.
   
   RUN CALCULAR_EI ( OUTPUT debitos, OUTPUT creditos ).
   saldo =  creditos - debitos.

   FOR EACH Cta_cte_prv OF Proveedor 
       WHERE Cta_cte_prv.fecha_emision >= des_fecha 
         AND Cta_cte_prv.fecha_emision <= has_fecha
         AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
         AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
        FIRST Imputacion OF Cta_cte_prv NO-LOCK,
        FIRST Tipocomprobante OF Cta_cte_prv NO-LOCK 
          BREAK BY Cta_cte_prv.fecha_emision WITH FRAME frm-listado:

       VIEW FRAME frm-titulo.
       IF FIRST(fecha_emision)
       THEN DO:
          DISPLAY "S.In." @ Imputacion.abrevia
                des_fecha @ Cta_cte_prv.fecha_emision
                debitos   @ Cta_cte_prv.debito
                creditos  @ Cta_cte_prv.credito
                saldo     
                WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
       END.             

       IF Tipocomprobante.debita
          THEN debitos = debitos + Cta_cte_prv.debito.
          ELSE creditos = creditos + Cta_cte_prv.credito.

       saldo =  creditos - debitos.

       DISPLAY   
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob       WHEN Cta_cte_prv.tip_comprob <> "SI"
           Cta_cte_prv.nro_comprob       WHEN Cta_cte_prv.tip_comprob <> "SI"
           Cta_cte_prv.nro_vencimiento   WHEN Cta_cte_prv.tip_comprob <> "SI"
           Imputacion.abrevia            WHEN Cta_cte_prv.tip_comprob <> "SI"
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento WHEN Cta_cte_prv.tip_comprob <> "SI"
           Cta_cte_prv.debito            WHEN Tipocomprobante.debita
           Cta_cte_prv.credito           WHEN NOT Tipocomprobante.debita
           saldo
           WITH FRAME frm-listado.
              
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           saldo
           WITH FRAME frm-listado.
           
   saldo =  creditos - debitos.

   UNDERLINE 
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           saldo
           WITH FRAME frm-listado.
   DISPLAY "Saldo"  @ Cta_cte_prv.fecha_vencimiento
           saldo    
           WITH FRAME frm-listado.
   
END PROCEDURE.   

PROCEDURE LISTAR_ANALITICO:

   titulo-f = "Composición analítica de saldos".
   titulo-2 = "Vencimientos al " + STRING(has_fecha) + " - " + Moneda.descripcion.

   FOR EACH Cta_cte_prv OF Proveedor 
      WHERE Cta_cte_prv.debito <> Cta_cte_prv.credito
        AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda NO-LOCK,
       FIRST Imputacion OF Cta_cte_prv NO-LOCK,
       FIRST Tipocomprobante OF Cta_cte_prv NO-LOCK 
         BY Cta_cte_prv.fecha_vencimiento WITH FRAME frm-listado: 

       saldo = Cta_cte_prv.credito - Cta_cte_prv.debito.

       VIEW FRAME frm-titulo.
       DISPLAY   
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito  WHEN Cta_cte_prv.debito <> 0
           Cta_cte_prv.credito WHEN Cta_cte_prv.credito <> 0
           saldo
           WITH FRAME frm-listado.

       debitos = debitos + Cta_cte_prv.debito.
       creditos = creditos + Cta_cte_prv.credito.

       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           saldo
           WITH FRAME frm-listado.
           
   saldo =  creditos - debitos.

   UNDERLINE 
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           saldo
           WITH FRAME frm-listado.
   DISPLAY "Saldo"  @ Cta_cte_prv.fecha_vencimiento
           saldo    
           WITH FRAME frm-listado.

END PROCEDURE.      

PROCEDURE LISTAR_VENCIDO:

   titulo-f = "Obligaciones vencidas a la fecha".
   titulo-2 = "Vencimientos al " + STRING(has_fecha) + " - " + Moneda.descripcion.

   FOR EACH Cta_cte_prv OF Proveedor 
      WHERE Cta_cte_prv.fecha_vencimiento <= has_fecha
        AND Cta_cte_prv.debito <> Cta_cte_prv.credito
        AND Cta_cte_prv.nro_moneda = Moneda.nro_moneda
        AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
       FIRST Imputacion OF Cta_cte_prv NO-LOCK,
       FIRST Tipocomprobante OF Cta_cte_prv NO-LOCK 
         BY Cta_cte_prv.fecha_vencimiento WITH FRAME frm-listado: 

       VIEW FRAME frm-titulo.
       DISPLAY   
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito  WHEN Cta_cte_prv.debito <> 0
           Cta_cte_prv.credito WHEN Cta_cte_prv.credito <> 0
           WITH FRAME frm-listado.

       debitos = debitos + Cta_cte_prv.debito.
       creditos = creditos + Cta_cte_prv.credito.

       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte_prv.tip_comprob
           Cta_cte_prv.prf_comprob
           Cta_cte_prv.nro_comprob
           Cta_cte_prv.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte_prv.fecha_emision
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           WITH FRAME frm-listado.
           
   saldo =  creditos - debitos.
   
   UNDERLINE 
           Cta_cte_prv.fecha_vencimiento
           Cta_cte_prv.debito
           Cta_cte_prv.credito
           saldo
           WITH FRAME frm-listado.
   DISPLAY "Saldo"  @ Cta_cte_prv.fecha_vencimiento
           saldo    
           WITH FRAME frm-listado.

   
END PROCEDURE.
