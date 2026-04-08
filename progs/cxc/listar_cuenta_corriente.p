/*=================================================================================*/
/*           EMITE EL LISTADO DE LA FICHA DE CUENTA CORRIENTE                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_cliente AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER ficha       AS INTEGER.
DEFINE INPUT PARAMETER que_moneda  LIKE Moneda.nro_moneda.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.
DEFINE VARIABLE debitos        AS   DECIMAL FORMAT "->,>>>,>>>,>>9.99" LABEL "Débitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT "->,>>>,>>>,>>9.99" LABEL "Créditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".

DEFINE VARIABLE que_cliente    LIKE Cliente.cdg_cliente.
DEFINE VARIABLE que_nombre     LIKE Cliente.nom_cliente.

{dfvarimp.i}
{parlocales.i}

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       titulo-f AT 47
       "Página:" AT 125 PAGE-NUMBER FORMAT ">9" AT 132 
       SKIP
       fecha_lis 
       titulo-2 AT 47 
       hora_lis AT 125
       SKIP(1)
       que_Cliente  AT 47
       que_nombre
       SKIP(1)
       WITH WIDTH 300 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       Cta_cte.tip_comprob
       Cta_cte.prf_comprob
       Cta_cte.nro_comprob
       Cta_cte.nro_vencimiento
       Imputacion.abrevia           
       Cta_cte.fecha_emision
       Cta_cte.mes
       Cta_cte.ano
       Cta_cte.fecha_vencimiento
       Cta_cte.debito  FORMAT "->,>>>,>>>,>>9.99"
       Cta_cte.credito FORMAT "->,>>>,>>>,>>9.99"
       Cta_cte.cambio         COLUMN-LABEL "Valor!Cambio"
       Cta_cte.cambio_dolar   COLUMN-LABEL "Valor!Dólar"
       Cta_cte.clausula_dolar FORMAT "Si/No"
       Cta_cte.es_difcambio   FORMAT "Si/No"
       saldo
       Cta_cte.leyenda
       WITH WIDTH 300 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                        B L O Q U E   P R I N C I P A L                          */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.

FIND Cliente WHERE ROWID(Cliente) = rid_cliente.
FIND Moneda WHERE Moneda.nro_moneda = que_moneda.
ASSIGN que_Cliente = Cliente.cdg_Cliente.
       que_nombre =  Cliente.nom_cliente.

{dirprinfile.i}

CASE ficha:
     WHEN his THEN RUN LISTAR_HISTORICO.
     WHEN anl THEN RUN LISTAR_ANALITICO.
     WHEN ven THEN RUN LISTAR_VENCIDO.
END.     

OUTPUT CLOSE.

RUN veresult.w ( INPUT arch_salida, 
                 INPUT 22).

/*=================================================================================*/
/*                                PROCEDIMIENTOS                                   */
/*=================================================================================*/

PROCEDURE CALCULAR_EI:

   DEFINE OUTPUT PARAMETER tot_debitogr AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   /* Busca por Movimiento desde principio de mes a la fecha */

   FOR EACH Cta_cte OF Cliente 
       WHERE Cta_cte.fecha_emision < des_fecha
         AND Cta_cte.nro_moneda = Moneda.nro_moneda
         AND Cta_cte.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
             FIRST Tipocomprobante OF Cta_cte NO-LOCK:

      IF Tipocomprobante.debita
         THEN tot_debitogr  = tot_debitogr + Cta_cte.debito.
         ELSE tot_creditogr = tot_creditogr + Cta_cte.credito.
      
   END.

END PROCEDURE.

PROCEDURE LISTAR_HISTORICO:

   titulo-f = "Movimientos de Cuenta Corriente".
   titulo-2 = STRING(des_fecha) +  " - " + STRING(has_fecha) + " - " + Moneda.descripcion.

   RUN CALCULAR_EI ( OUTPUT debitos, OUTPUT creditos ).
   saldo = debitos - creditos.

   FOR EACH Cta_cte OF Cliente 
       WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
         AND Cta_cte.fecha_emision >= des_fecha 
         AND Cta_cte.fecha_emision <= has_fecha
         AND Cta_cte.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
             FIRST Tipocomprobante OF Cta_cte NO-LOCK,
             FIRST Imputacion OF Cta_cte NO-LOCK
                   BREAK BY Cta_cte.fecha_emision WITH FRAME frm-listado:
       
       VIEW FRAME frm-titulo.
       IF FIRST(Cta_cte.fecha_emision)
       THEN DO:
          DISPLAY "S.In." @ Imputacion.abrevia
             des_fecha @ Cta_cte.fecha_emision
             debitos   @ Cta_cte.debito
             creditos  @ Cta_cte.credito
             saldo
             WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
       END.             

       IF Tipocomprobante.debita
          THEN debitos = debitos + Cta_cte.debito.
          ELSE creditos = creditos + Cta_cte.credito.

       saldo = debitos - creditos.

       DISPLAY   
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.fecha_vencimiento
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.debito  WHEN Tipocomprobante.debita
           Cta_cte.credito WHEN NOT Tipocomprobante.debita
           saldo
           Cta_cte.leyenda
           WITH FRAME frm-listado.
              
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.fecha_vencimiento
           Cta_cte.debito
           Cta_cte.credito
           saldo
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.leyenda
           WITH FRAME frm-listado.
           
   saldo = debitos - creditos.
   DISPLAY "Saldo"  @ Cta_cte.fecha_vencimiento
           debitos  @ Cta_cte.debito
           creditos @ Cta_cte.credito
           saldo
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   
END PROCEDURE.   

PROCEDURE LISTAR_ANALITICO:

   titulo-f = "Composición analítica de saldos".
   titulo-2 = "Valores expresados en " + Moneda.descripcion.

   FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.nro_moneda = Moneda.nro_moneda
        AND Cta_cte.debito <> Cta_cte.credito
        AND Cta_cte.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
            FIRST Imputacion OF Cta_cte NO-LOCK
                  BY Cta_cte.fecha_vencimiento WITH FRAME frm-listado: 

       debitos = debitos + Cta_cte.debito.
       creditos = creditos + Cta_cte.credito.
    
       saldo = debitos - creditos.

       VIEW FRAME frm-titulo.
       DISPLAY   
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.fecha_vencimiento
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.debito  WHEN Cta_cte.debito <> 0
           Cta_cte.credito WHEN Cta_cte.credito <> 0
           saldo
           WITH FRAME frm-listado.

           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.fecha_vencimiento
           Cta_cte.debito
           Cta_cte.credito
           saldo
           WITH FRAME frm-listado.
           
   saldo = debitos - creditos.
   DISPLAY debitos  @ Cta_cte.debito
           creditos @ Cta_cte.credito
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   DISPLAY "Saldo"  @ Cta_cte.fecha_vencimiento
           saldo    @ Cta_cte.debito
           WITH FRAME frm-listado.

   
END PROCEDURE.      

PROCEDURE LISTAR_VENCIDO:

   titulo-f = "Deuda vencida a la fecha".
   titulo-2 = "Vencimientos al " + STRING(has_fecha) + " - " + Moneda.descripcion.

   FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.fecha_vencimiento <= has_fecha
        AND Cta_cte.debito <> Cta_cte.credito
        AND Cta_cte.cdg_empresa = Empresa.cdg_empresa NO-LOCK,
            FIRST Imputacion OF Cta_cte NO-LOCK
         BY Cta_cte.fecha_vencimiento WITH FRAME frm-listado: 

       debitos = debitos + Cta_cte.debito.
       creditos = creditos + Cta_cte.credito.

       saldo = debitos - creditos. 

       VIEW FRAME frm-titulo.
       DISPLAY   
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.fecha_vencimiento
           Cta_cte.debito  WHEN Cta_cte.debito <> 0
           Cta_cte.credito WHEN Cta_cte.credito <> 0
           saldo
           WITH FRAME frm-listado.

           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.mes
           Cta_cte.ano
           Cta_cte.cambio        
           Cta_cte.cambio_dolar  
           Cta_cte.clausula_dolar
           Cta_cte.es_difcambio  
           Cta_cte.fecha_vencimiento
           Cta_cte.debito
           Cta_cte.credito
           saldo
           WITH FRAME frm-listado.
           
   saldo = debitos - creditos.
   DISPLAY debitos  @ Cta_cte.debito
           creditos @ Cta_cte.credito
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   DISPLAY "Saldo"  @ Cta_cte.fecha_vencimiento
           saldo    @ Cta_cte.debito
           WITH FRAME frm-listado.

   
END PROCEDURE.      

 
