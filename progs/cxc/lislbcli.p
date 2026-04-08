/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_Cliente AS ROWID.
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
DEFINE VARIABLE que_Cliente  LIKE Cliente.cdg_Cliente.
DEFINE VARIABLE que_nombre     LIKE Cliente.nom_cliente.

DEFINE FRAME frm-titulo HEADER
       que_empresa 
       titulo-f AT 28
       "Pagina:" AT 70 PAGE-NUMBER FORMAT ">9" AT 77 
       SKIP(1)
       que_Cliente  AT 28
       que_nombre
       SKIP(1)
       WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO USE-TEXT.
  
DEFINE FRAME frm-listado
       SPACE(3)
       Cta_cte.tip_comprob
       Cta_cte.prf_comprob
       Cta_cte.nro_comprob
       Cta_cte.nro_vencimiento
       Imputacion.abrevia           
       Cta_cte.fecha_emision
       Cta_cte.fecha_vencimiento
       Cta_cte.debito 
       Cta_cte.credito 
       Cta_cte.liberada
       WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

que_empresa = Empresa.nombre.

{SETIMPRE.I}

FIND Cliente WHERE ROWID(Cliente) = rid_Cliente.
FIND Moneda WHERE ROWID(Moneda) = act_moneda.

que_Cliente = Cliente.cdg_Cliente.
que_nombre =  Cliente.nom_cliente.
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

   FOR EACH Cta_cte OF Cliente 
      WHERE Cta_cte.debito <> Cta_cte.credito
        AND Cta_cte.cdg_empresa = Empresa.cdg_empresa,
       EACH Imputacion OF Cta_cte
         BY Cta_cte.fecha_vencimiento WITH FRAME frm-listado: 

       VIEW FRAME frm-titulo.
       DISPLAY   
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.fecha_vencimiento
           Cta_cte.debito  WHEN Cta_cte.debito <> 0
           Cta_cte.credito WHEN Cta_cte.credito <> 0
           Cta_cte.liberada                                            
           WITH FRAME frm-listado.

       debitos = debitos + Cta_cte.debito.
       creditos = creditos + Cta_cte.credito.
           
       DOWN WITH FRAME frm-listado.

   END.

   UNDERLINE 
           Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Imputacion.abrevia           
           Cta_cte.fecha_emision
           Cta_cte.fecha_vencimiento
           Cta_cte.debito
           Cta_cte.credito
           Cta_cte.liberada
           WITH FRAME frm-listado.
           
   saldo = debitos - creditos.
   DISPLAY debitos  @ Cta_cte.debito
           creditos @ Cta_cte.credito
           WITH FRAME frm-listado.
   DOWN WITH FRAME frm-listado.
   DISPLAY "Total"  @ Cta_cte.fecha_vencimiento
           saldo    @ Cta_cte.debito
           WITH FRAME frm-listado.

   
END PROCEDURE.      

{CODIMPRE.I}
