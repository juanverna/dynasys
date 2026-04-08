/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_Proveedor AS ROWID.
DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.

{VPERSINM.I}
{VRSHARED.I}

DEFINE VARIABLE his            AS   INTEGER INITIAL 0.
DEFINE VARIABLE anl            AS   INTEGER INITIAL 1.
DEFINE VARIABLE ven            AS   INTEGER INITIAL 2.
DEFINE VARIABLE debitos        AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Debitos".
DEFINE VARIABLE creditos       AS   DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Creditos".
DEFINE VARIABLE saldo          AS   DECIMAL FORMAT "->,>>>,>>9.99" LABEL "Saldo".
DEFINE VARIABLE titulo-f       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE titulo-2       AS   CHARACTER FORMAT "X(35)".
DEFINE VARIABLE hora_lis       AS   CHARACTER.
DEFINE VARIABLE fecha_lis      AS   DATE.
DEFINE VARIABLE que_empresa    LIKE Empresa.nombre.
DEFINE VARIABLE que_Proveedor  LIKE Proveedor.cdg_Proveedor.
DEFINE VARIABLE que_nombre     LIKE Proveedor.nombre.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP(1)
       que_Proveedor  AT 28
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
       Cta_cte_prv.liberada
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Proveedor WHERE ROWID(Proveedor) = rid_Proveedor.
FIND Moneda WHERE ROWID(Moneda) = act_moneda.

que_Proveedor = Proveedor.cdg_Proveedor.
que_nombre =  Proveedor.nombre.
fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

OUTPUT TO VALUE(dire_tmp + "lislbpro.txt") PAGED.
RUN LISTAR_ANALITICO.
OUTPUT CLOSE.
RUN veresult.w ( INPUT dire_tmp + "lislbpro.txt", INPUT 8).

/*=================================================================================*/
/*                           PROCEDIMIENTOS                                        */
/*=================================================================================*/

PROCEDURE LISTAR_ANALITICO:

   titulo-f = "Detalle de pagos Liberados/Retenidos".

   FOR EACH Cta_cte_prv OF Proveedor 
      WHERE Cta_cte_prv.debito <> Cta_cte_prv.credito,
       EACH Imputacion OF Cta_cte_prv
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
           Cta_cte_prv.liberada                                            
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
           Cta_cte_prv.liberada
           WITH FRAME frm-listado.
           
   saldo = debitos - creditos.
   DISPLAY debitos  @ Cta_cte_prv.debito
           creditos @ Cta_cte_prv.credito
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   DISPLAY "Total"  @ Cta_cte_prv.fecha_vencimiento
           saldo    @ Cta_cte_prv.debito
           WITH FRAME frm-listado.

   
END PROCEDURE.      

{CODIMPRE.I}
