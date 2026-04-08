/*====================================================================================*/
/*           IMPRIME UNA CARTA DE RECLAMO DE DEUDA PARA UN CLIENTE ESPECIFICO         */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_fecha   AS DATE.
DEFINE INPUT PARAMETER has_fecha   AS DATE.
DEFINE INPUT PARAMETER lista_empresas AS CHARACTER FORMAT "X(35)".


/*====================================================================================*/
/*                                    VARIABLES                                       */
/*====================================================================================*/

DEFINE VARIABLE cempresa    LIKE Empresa.cdg_empresa INITIAL "M".

{VPERSINM.I}
{VRSHARED.I "NEW"}

DEFINE VARIABLE v-lugar-y-fecha     AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-firma             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-cargo             AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE v-por-empresa       AS CHARACTER FORMAT "X(60)".


DEFINE VARIABLE tot_saldo   AS DECIMAL.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-Z,ZZZ,ZZ9.99" LABEL "Tot. Deuda".
DEFINE VARIABLE credito     AS DECIMAL.
DEFINE VARIABLE debito      AS DECIMAL.

DEFINE VARIABLE fecha_lis   AS DATE.
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE que_archivo AS CHARACTER.
DEFINE VARIABLE que_cuenta  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE ultimo      AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE desc_moneda LIKE Moneda.descripcion.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.
DEFINE BUFFER B-Rec_header FOR Rec_header.
/*====================================================================================*/
/*                                    FRAMES                                          */
/*====================================================================================*/


DEFINE FRAME frm-listado
  Rec_detalle.tip_cancela
  SPACE(1)
  Rec_detalle.prf_cancela
  SPACE(1)
  Rec_detalle.nro_cancela FORMAT "ZZZZZZZ9"
  SPACE(1)
  Cta_cte.fecha_emision
  SPACE(1)
  Rec_detalle.importe
  WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO
       NO-LABEL.

/*====================================================================================*/
/*                                 BLOQUE PRINCIPAL                                   */
/*====================================================================================*/

/*{findempresa.i}*/

FIND Empresa WHERE Empresa.cdg_empresa = cempresa.

que_archivo = dire_tmp + "resdedua.txt".
OUTPUT TO VALUE(que_archivo) PAGE-SIZE 0. 

FOR EACH Rec_header WHERE Rec_header.fecha >= des_fecha
                      AND Rec_header.fecha <= has_fecha
                      AND Rec_header.cdg_empresa = Empresa.cdg_empresa
                      AND Rec_header.imp_total >= 10000
                       BY Rec_header.fecha:
    FIND Cliente OF Rec_header.

    PUT "NEWMEMO ORDEN:" SKIP "~{".  
    PUT "Pago: "
        SPACE(1)        
        Rec_header.fecha
        SPACE(3)
        Rec_header.tip_comprob
        SPACE(1)
        Rec_header.prf_comprob
        SPACE(1)
        Rec_header.nro_comprob
        SPACE(1)
        Rec_header.imp_total SKIP.
    PUT "~}" SKIP.
    
    PUT "NEWMEMO PAGO:" SKIP "~{".  
    FOR EACH Rec_detalle OF Rec_header:
        FIND Cta_cte OF Cliente WHERE Cta_cte.tip_comprob     = Rec_detalle.tip_cancela
                                  AND Cta_cte.prf_comprob     = Rec_detalle.prf_cancela
                                  AND Cta_cte.nro_comprob     = Rec_detalle.nro_cancela
                                  AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento NO-ERROR. 
        PUT   Cta_cte.fecha_emision
              SPACE(3)
              Rec_detalle.tip_cancela
              SPACE(1)
              Rec_detalle.prf_cancela FORMAT "9999"
              "-"
              Rec_detalle.nro_cancela FORMAT "99999999"
              SPACE(1)
              Rec_detalle.importe FORMAT "$ >>>,>>>,>>9.99 " SKIP.
     END.
     PUT "~}" SKIP.
END.

OUTPUT CLOSE.

OS-COPY    VALUE(".\prl\modelo-reclamo.memo") VALUE(".\prl\rg151.memo").
OS-APPEND  VALUE(que_archivo)                 VALUE(".\prl\rg151.memo").

   /* Levanta los parametros y los mueve a variables */

/* {CARGATEXTOS.I "'RECLLYFE'" "v-lugar-y-fecha"} */
/* {CARGATEXTOS.I "'RECLFIRM'" "v-firma"}         */
/* {CARGATEXTOS.I "'RECLCARG'" "v-cargo"}         */
/* {CARGATEXTOS.I "'RECLPEMP'" "v-por-empresa"}   */

v-params = "p-empresa=" + Empresa.nombre + "~n" +
           "p-lugar-y-fecha=" + v-lugar-y-fecha + "~n" +
           "p-firma=" + v-firma + "~n" +
           "p-cargo=" + v-cargo + "~n" +
           "p-por-empresa=" + v-por-empresa + "~n".

v-filtro = "Cliente.cdg_cliente = '" + Cliente.cdg_cliente + "'" + 
           " AND Domicilio.nro_domicilio = 1".

RUN exreport.p (  INPUT  ".\prl\sic.prl",            /* Librería desde la que se ejecuta */
                  INPUT "RG 151",          /* Nombre del reporte a ejecutar    */
                  INPUT  v-filtro,                   /* Filtro de registros a imponer    */
                  INPUT  "D",                        /* Salida de datos    (ver cPrinter)*/
                  INPUT  "",                         /* Impresora de destino del listado */
                  INPUT  v-params                    /* Parametros de Ejecucion          */
               )   

