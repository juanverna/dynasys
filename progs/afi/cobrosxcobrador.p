/*=========================================================================================*/
/*              REALIZA LA EMISION DEL LISTADO DE Rec_headerES POR COBRADOR                     */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-has_cobrador     LIKE Cobrador.cdg_cobrador.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lis                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE VARIABLE que_archivo               AS CHARACTER.
DEFINE VARIABLE p_printed                 AS LOGICAL.

DEFINE VARIABLE pto_venta-org             LIKE Rec_header.prf_comprob.
DEFINE VARIABLE cotiza_dolar              AS DECIMAL.
DEFINE VARIABLE codigo_dolar              LIKE Moneda.cdg_moneda.
DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE prox_docum                LIKE Parametro.cdg_parametro.

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-Rec_headeres                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-Rec_headeres                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-Rec_headeres                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Recibos Cobrados por Cobrador" AT 40
       "Página:" AT 93 PAGE-NUMBER FORMAT ">>9" AT 101
       SKIP  
       fecha_lis       
       titulo_lis AT 40
       hora_lis AT 93
       SKIP
       titulo_det AT 40  
       SKIP(1)
       WITH WIDTH 120 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
    
FORM
        Rec_header.cdg_empresa    COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
        Rec_header.tip_comprob    COLUMN-LABEL "Tip!Com" FORMAT "X(3)"
        Rec_header.prf_comprob    COLUMN-LABEL "Pto!Vta" FORMAT "9999"
        Rec_header.nro_comprob    COLUMN-LABEL "Número!Compbte" FORMAT ">>>>>>>9"
        Cliente.cdg_cliente       COLUMN-LABEL "Código!Cliente" FORMAT "X(8)"
        Cliente.nom_cliente       COLUMN-LABEL "Razón!Social"
        Rec_header.fecha          COLUMN-LABEL "Fecha!Alta"
        Rec_header.imp_total      COLUMN-LABEL "Importe!Cobrado" FORMAT "->,>>>,>>9.99"
        WITH WIDTH 120 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

FORM
       t-Rec_headeres LABEL "Total Grupos"  
       t-pesos   LABEL "Total Pesos"
       WITH WIDTH 135 DOWN FRAME frm-resumen USE-TEXT STREAM-IO SIDE-LABELS .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

/*{DIRPRINFILE.I}*/

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").
titulo_lis  = "Emision del " + STRING(p-des_fecha,"99/99/99") + 
              " al " + 
              STRING(p-has_fecha,"99/99/99").

que_archivo = "C:\SIC-TEMP\cobrosxcobrador.txt".

OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

t-Rec_headeres = 0.
t-pesos   = 0.

FOR EACH Cobrador NO-LOCK
    WHERE Cobrador.cdg_cobrador >= p-des_cobrador
      AND Cobrador.cdg_cobrador <= p-has_cobrador 
          WITH FRAME frm-listado :

        VIEW FRAME frm-titulo.
        
        titulo_det = Cobrador.cdg_cobrador + " - " + Cobrador.nom_cobrador.
    
        FOR EACH Rec_header NO-LOCK OF Cobrador 
            WHERE LOOKUP(Rec_header.cdg_empresa,p-que_empresa,",") <> 0
              AND Rec_header.fecha   >= p-des_fecha
              AND Rec_header.fecha   <= p-has_fecha,
                  EACH Cliente NO-LOCK OF Rec_header
                  BREAK BY Rec_header.cdg_empresa 
                        BY Rec_header.fecha
                  WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:
        
            VIEW FRAME frm-titulo.
        
            DISPLAY
                Rec_header.cdg_empresa
                Rec_header.tip_comprob 
                Rec_header.prf_comprob 
                Rec_header.nro_comprob 
                Cliente.cdg_cliente
                Cliente.nom_cliente 
                Rec_header.fecha     COLUMN-LABEL "Fecha!Alta"
                Rec_header.imp_total FORMAT "->>>,>>9.99"
                WITH FRAME frm-listado USE-TEXT STREAM-IO DOWN.
                
            DOWN WITH FRAME frm-listado.
            
            t-pesos   = t-pesos + Rec_header.imp_total.
            t-Rec_headeres = t-Rec_headeres   + 1.
        
        END.
    
        UNDERLINE
            Rec_header.cdg_empresa
            Rec_header.tip_comprob 
            Rec_header.prf_comprob 
            Rec_header.nro_comprob 
            Cliente.cdg_cliente
            Cliente.nom_cliente 
            Rec_header.fecha
            Rec_header.imp_total
            Grupo-domicilio.cdg_zonag
            WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
      
        DISPLAY "Total " + Cobrador.cdg_cobrador
                                          @ Cliente.nom_cliente
                                t-Rec_headeres @ Grupo-domicilio.cdg_zonag
                                  t-pesos @ Rec_header.imp_total
                                  WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
        
        PAGE.

END.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cobrosxcobrador.txt",
                 INPUT 2 ).

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

