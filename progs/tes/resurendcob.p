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

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Resumen de Cobranzas por Fecha" AT 77
       "Página:" AT 157 PAGE-NUMBER FORMAT ">>9" AT 165
       SKIP  
       fecha_lis       
       titulo_det AT 77
       hora_lis AT 157
       SKIP(1)
       WITH WIDTH 170 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Cobrador.cdg_cobrador COLUMN-LABEL "Código!Cobrador"
       Cobrador.nom_cobrador COLUMN-LABEL "Nombre!Cobrador"
       t-cargopesos          COLUMN-LABEL "Cargo!Pesos"
       t-cobradopesos        COLUMN-LABEL "Cobrado!Pesos"
       t-prccobradopesos     COLUMN-LABEL "Pje.!Pesos"
       t-cargocupones        COLUMN-LABEL "Cargo!Recibos"
       t-cobradocupones      COLUMN-LABEL "Cobrado!Recibos"
       t-prccobradocupones   COLUMN-LABEL "Pje.!Recibos"
       t-bajascupones        COLUMN-LABEL "Bajas!Recibos"
       t-bajaspesos          COLUMN-LABEL "Bajas!Pesos"
       t-morascupones        COLUMN-LABEL "Moras!Recibos"
       t-moraspesos          COLUMN-LABEL "Moras!Pesos"
       t-pendicupones        COLUMN-LABEL "Pendiente!Recibos"
       t-pendipesos          COLUMN-LABEL "Pendiente!Pesos"
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

OUTPUT TO VALUE("c:\sic-temp\cargoycobrado.txt") PAGE-SIZE 60.

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
            t-pendicupones            = 0 . 

    FOR EACH Rendicion_hd OF Cobrador 
        WHERE LOOKUP(Rendicion_hd.cdg_empresa,p-que_empresa,",") <> 0
          AND Rendicion_hd.fch_rendicion   >= p-des_fecha
          AND Rendicion_hd.fch_rendicion   <= p-has_fecha
              NO-LOCK:
    
        FOR EACH Comprobante_rendicion OF Rendicion_hd NO-LOCK:
        
            ASSIGN
                  t-cargopesos   = t-cargopesos + Comprobante_rendicion.este_pago.
                  t-cargocupones = t-cargocupones + 1.
            /*      
            CASE Comprobante_rendicion.estado:      
     
                 WHEN "0"
                 THEN DO:
                     t-pendipesos   = t-pendipesos + Comprobante_rendicion.este_pago.
                     t-pendicupones = t-pendicupones + 1.
                 END.
     
                 WHEN "1"
                 THEN DO:
                     t-cobradopesos   = t-cobradopesos + Comprobante_rendicion.este_pago.
                     t-cobradocupones = t-cobradocupones + 1.
                 END.
     
                 WHEN "2"
                 THEN DO:
                     t-moraspesos   = t-moraspesos + Comprobante_rendicion.este_pago.
                     t-morascupones = t-morascupones + 1.
                 END.
     
                 WHEN "3"
                 THEN DO:
                     t-bajaspesos   = t-bajaspesos + Comprobante_rendicion.este_pago.
                     t-bajascupones = t-bajascupones + 1.
                 END.
     
            END CASE.       
            */
     
         END.       
    
    END.
    
    ASSIGN
       t-prccobradopesos = t-cobradopesos / t-cargopesos * 100
       t-prccobradocupones = t-cobradocupones / t-cargocupones * 100.
    
    DISPLAY
            Cobrador.cdg_cobrador
            Cobrador.nom_cobrador
            t-cargopesos
            t-cobradopesos
            t-prccobradopesos
            t-cargocupones
            t-cobradocupones
            t-prccobradocupones
            t-bajascupones
            t-bajaspesos
            t-morascupones
            t-moraspesos
            t-pendicupones
            t-pendipesos
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.          

    g-cargopesos   = g-cargopesos   + t-cargopesos.
    g-cargocupones = g-cargocupones + t-cargocupones.
    
    g-pendipesos   = g-pendipesos   + t-pendipesos.
    g-pendicupones = g-pendicupones + t-pendicupones.

    g-cobradopesos   = g-cobradopesos + t-cobradopesos.
    g-cobradocupones = g-cobradocupones + t-cobradocupones.

    g-moraspesos   = g-moraspesos + t-moraspesos.
    g-morascupones = g-morascupones + t-morascupones.

    g-bajaspesos   = g-bajaspesos + t-bajaspesos.
    g-bajascupones = g-bajascupones + t-bajascupones.

END.


UNDERLINE
        Cobrador.cdg_cobrador
        Cobrador.nom_cobrador
        t-cargopesos
        t-cobradopesos
        t-prccobradopesos
        t-cargocupones
        t-cobradocupones
        t-prccobradocupones
        t-bajascupones
        t-bajaspesos
        t-morascupones
        t-moraspesos
        t-pendicupones
        t-pendipesos
        WITH FRAME frm-listado.

    ASSIGN
       g-prccobradopesos = g-cobradopesos / g-cargopesos * 100
       g-prccobradocupones = g-cobradocupones / g-cargocupones * 100.


DISPLAY
        "Total General" @ Cobrador.nom_cobrador

        g-cargopesos   @ t-cargopesos
        g-cargocupones @ t-cargocupones
        
        g-pendipesos   @ t-pendipesos
        g-pendicupones @ t-pendicupones
    
        g-cobradopesos @ t-cobradopesos
        g-cobradocupones @ t-cobradocupones
    
        g-moraspesos @ t-moraspesos
        g-morascupones @ t-morascupones
    
        g-bajaspesos @ t-bajaspesos
        g-bajascupones @ t-bajascupones

        g-prccobradopesos @ t-prccobradopesos
        g-prccobradocupones @ t-prccobradocupones

        WITH FRAME frm-listado.

UNDERLINE
        Cobrador.cdg_cobrador
        Cobrador.nom_cobrador
        t-cargopesos
        t-cobradopesos
        t-prccobradopesos
        t-cargocupones
        t-cobradocupones
        t-prccobradocupones
        t-bajascupones
        t-bajaspesos
        t-morascupones
        t-moraspesos
        t-pendicupones
        t-pendipesos
        WITH FRAME frm-listado.


OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cargoycobrado.txt",
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

