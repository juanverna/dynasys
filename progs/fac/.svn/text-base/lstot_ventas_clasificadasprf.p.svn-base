/*====================================================================================*/
/*                        ESTADISTICAS POR ARTICULO                                   */
/*                  Ranking de Articulos con o sin detalle de Clientes                */
/*====================================================================================*/

DEFINE INPUT PARAMETER primer_nodo          AS CHARACTER. 

DEFINE INPUT PARAMETER p-des_fecha          AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER p-has_fecha          AS DATE LABEL "Hasta Fecha" INITIAL TODAY.
                                      
DEFINE INPUT PARAMETER p-prfs               AS CHARACTER INITIAL "*".

DEFINE INPUT PARAMETER p-cdg_moneda         AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion     AS INTEGER.
DEFINE INPUT PARAMETER p-fecha              AS DATE.
                                            
DEFINE INPUT PARAMETER p-filtro_atributos   AS CHARACTER.

DEFINE OUTPUT PARAMETER xfile AS CHAR NO-UNDO.
DEFINE INPUT PARAMETER modo AS INT NO-UNDO.
/*1 genera dataset xml 2 genera xls*/
/*{crystal_dyna.p}*/
/*=================================================================================*/
/*                                 VARIABLES                                       */
/*=================================================================================*/

DEFINE VARIABLE c-linea            AS INTEGER.
DEFINE VARIABLE v-linea_subtotal   AS INTEGER.
{tt2xls.i}
{tmplistadoventasprf.i}

DEFINE VARIABLE l-saldo_acreed     LIKE Asn_detalle.debito FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_deudor     LIKE Asn_detalle.debito FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_per        LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_per  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_per LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-saldo_tot        LIKE Asn_detalle.debito LABEL "Saldo" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_debitos_tot  LIKE Asn_detalle.debito LABEL "Acum.debitos" FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE l-acm_creditos_tot LIKE Asn_detalle.credito LABEL "Acum.creditos" FORMAT "->>,>>>,>>9.99".

DEFINE VARIABLE que_subclase AS CHARACTER.
DEFINE VARIABLE que_archivo  AS CHARACTER.

DEFINE BUFFER   Clase  FOR Clase_de_articulo.
DEFINE BUFFER Subclase FOR Clase_de_articulo.

DEFINE VARIABLE v-filtro AS CHARACTER.
DEFINE VARIABLE v-params AS CHARACTER.

DEFINE DATASET dset FOR T-Listado.
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}

FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
FIND FIRST Clase WHERE Clase.cdg_subclase = primer_nodo NO-LOCK.
           
EMPTY TEMP-TABLE T-Listado.

RUN recorrer_clasificacion_ventasprf.p ( INPUT p-des_fecha,
                                      INPUT p-has_fecha,
                                      INPUT p-prfs, /*lista de punto de ventas*/
                                      INPUT p-cdg_moneda,
                                      INPUT p-ver_cotizacion,
                                      INPUT p-fecha,
                                      INPUT p-filtro_atributos,
                                      INPUT ROWID(Clase), 
                                      INPUT 0,
                                      INPUT-OUTPUT c-linea,
                                      OUTPUT v-linea_subtotal,
                                      INPUT-OUTPUT TABLE T-Listado).
IF modo = 1 THEN DO:
    xfile = "c:\sic-temp\estadisticasprf.xml".
    DATASET dset:WRITE-XML ("FILE", xfile, TRUE,
                                         ?,"",YES,YES).
END.
ELSE IF modo = 2 THEN DO:
    xfile = "c:\sic-temp\estadisticasprf.xls".
    RUN pTT2XLS                                                                
     ( INPUT TEMP-TABLE T-Listado:DEFAULT-BUFFER-HANDLE,                         
       INPUT xfile,                                                 
       INPUT 'PageSetup:PrintGridlines=Y|PageSetup:PrintTitleRows=$1:$1' ).
END.
