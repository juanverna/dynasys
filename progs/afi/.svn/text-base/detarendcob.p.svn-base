/*=========================================================================================*/
/*              REALIZA LA EMISION DEL LISTADO DE RESUMEN DE RENDICIONES                   */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-has_cobrador     LIKE Cobrador.cdg_cobrador.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.

DEFINE VARIABLE j                         AS INTEGER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE VARIABLE pto_venta-org             LIKE Rec_header.prf_comprob.
DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE prox_docum                LIKE Parametro.cdg_parametro.

DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE t-cargopesos              AS DECIMAL FORMAT ">,>>>,>>9.99". 
DEFINE VARIABLE t-cobradopesos            AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-prccobradopesos         AS DECIMAL FORMAT ">>9.99".
DEFINE VARIABLE t-bajaspesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-moraspesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-pendipesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-prccobradocupones       AS DECIMAL FORMAT ">>9.99".

DEFINE VARIABLE t-cargocupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-cobradocupones          AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-bajascupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-morascupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pendicupones            AS INTEGER FORMAT ">>>>9". 

DEFINE VARIABLE g-cargopesos              AS DECIMAL FORMAT ">,>>>,>>9.99". 
DEFINE VARIABLE g-cobradopesos            AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-prccobradopesos         AS DECIMAL FORMAT ">>9.99".
DEFINE VARIABLE g-bajaspesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-moraspesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-pendipesos              AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-prccobradocupones       AS DECIMAL FORMAT ">>9.99".

DEFINE VARIABLE g-cargocupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-cobradocupones          AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-bajascupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-morascupones            AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-pendicupones            AS INTEGER FORMAT ">>>>9". 

DEFINE VARIABLE hubo_cob                  AS LOGICAL. 


DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Resumen de Cobranzas por Fecha" AT 57
       "Página:" AT 119 PAGE-NUMBER FORMAT ">>9" AT 127
       SKIP  
       fecha_lis       
       titulo_det AT 57
       hora_lis AT 119
       SKIP(1)
       WITH WIDTH 170 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Cobrador.cdg_cobrador COLUMN-LABEL "Código!Cobrador"
       Cobrador.nom_cobrador COLUMN-LABEL "Nombre!Cobrador"
       Rendicion_hd.cdg_empresa COLUMN-LABEL "Código!Empresa"
       Rendicion_hd.fch_rendicion COLUMN-LABEL "Fecha!Rendicion"
       Rendicion_hd.nro_rendicion COLUMN-LABEL "Número!Rendición"
       Rendicion_hd.abierta COLUMN-LABEL "Abierta!Si/No" 
       Rendicion_hd.tipo COLUMN-LABEL "Tipo!Rend"
       Rendicion_hd.cant_recibos COLUMN-LABEL "Cantidad!Recibos"
       Rendicion_hd.imp_imputado COLUMN-LABEL "Importe!Imputado"
       Rendicion_hd.imp_rendicion COLUMN-LABEL "Importe!Rendicion"
       Rendicion_hd.st_tesoreria COLUMN-LABEL "Teso-!rería"
       
/*
       t-cargopesos          COLUMN-LABEL "Cargo!Pesos"
       t-cobradopesos        COLUMN-LABEL "Cobrado!Pesos"
       t-prccobradopesos     COLUMN-LABEL "Pje.!Pesos"
       t-cargocupones        COLUMN-LABEL "Cargo!Cupones"
       t-cobradocupones      COLUMN-LABEL "Cobrado!Cupones"
       t-prccobradocupones   COLUMN-LABEL "Pje.!Cupones"
       t-bajascupones        COLUMN-LABEL "Bajas!Cupones"
       t-bajaspesos          COLUMN-LABEL "Bajas!Pesos"
       t-morascupones        COLUMN-LABEL "Moras!Cupones"
       t-moraspesos          COLUMN-LABEL "Moras!Pesos"
       t-pendicupones        COLUMN-LABEL "Pendiente!Cupones"
       t-pendipesos          COLUMN-LABEL "Pendiente!Pesos"
*/
       WITH WIDTH 256 DOWN FRAME frm-listado STREAM-IO.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

titulo_det  = "Rendiciones del " + 
              STRING(p-des_fecha,"99/99/99") + 
              " al " + 
              STRING(p-has_fecha,"99/99/99").

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("c:\sic-temp\detarendcob.txt") PAGE-SIZE 84.

FOR EACH Cobrador NO-LOCK
    WHERE Cobrador.cdg_cobrador >= p-des_cobrador
      AND Cobrador.cdg_cobrador <= p-has_cobrador 
          WITH FRAME frm-listado:

    VIEW FRAME frm-titulo.
    
    ASSIGN 
            t-cargopesos              = 0.0
            t-cobradopesos            = 0.0
            t-prccobradopesos         = 0.0
            t-bajaspesos              = 0.0
            t-moraspesos              = 0.0
            t-pendipesos              = 0.0
           
            t-cargocupones            = 0
            t-cobradocupones          = 0
            t-prccobradocupones       = 0
            t-bajascupones            = 0
            t-morascupones            = 0
            t-pendicupones            = 0. 

    hubo_cob = NO.

    FOR EACH Rendicion_hd OF Cobrador 
        WHERE LOOKUP(Rendicion_hd.cdg_empresa,p-que_empresa,",") <> 0
          AND Rendicion_hd.fch_rendicion   >= p-des_fecha
          AND Rendicion_hd.fch_rendicion   <= p-has_fecha
              NO-LOCK:
    
            DISPLAY
                Cobrador.cdg_cobrador WHEN NOT hubo_cob
                Cobrador.nom_cobrador WHEN NOT hubo_cob
                Rendicion_hd.cdg_empresa
                Rendicion_hd.fch_rendicion
                Rendicion_hd.nro_rendicion
                Rendicion_hd.abierta
                Rendicion_hd.tipo
                Rendicion_hd.cant_recibos
                Rendicion_hd.imp_imputado
                Rendicion_hd.imp_rendicion
                Rendicion_hd.st_tesoreria
                WITH FRAME frm-listado.

            DOWN WITH FRAME frm-listado.          

            hubo_cob = YES.
     
    END.

    UNDERLINE
        Cobrador.cdg_cobrador
        Cobrador.nom_cobrador
        Rendicion_hd.cdg_empresa
        Rendicion_hd.fch_rendicion
        Rendicion_hd.nro_rendicion
        Rendicion_hd.abierta 
        Rendicion_hd.tipo 
        Rendicion_hd.cant_recibos
        Rendicion_hd.imp_imputado
        Rendicion_hd.imp_rendicion
        Rendicion_hd.st_tesoreria
        WITH FRAME frm-listado.
    
    DOWN 1 WITH FRAME frm-listado.          

END.



OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\detarendcob.txt",
                 INPUT 2 ).

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

PROCEDURE mostrar_error:

    PUT Grupofam.cdg_grupofam  " "
        Grupofam.nom_grupofam " "
        Grupofam.cdg_plan  " "
        Grupofam.cant_capitas SKIP. 

END PROCEDURE.

