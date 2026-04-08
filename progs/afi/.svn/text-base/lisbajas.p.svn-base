/*=========================================================================================*/
/*              EMITE EL LISTADO DE BAJAS PARA UN DETERMINADO PERIODO DE ALTAS             */
/*=========================================================================================*/
/*
DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.
DEFINE INPUT PARAMETER p-mes_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-ano_imputa       AS INTEGER.
DEFINE INPUT PARAMETER p-fecha_emision    AS DATE.
DEFINE INPUT PARAMETER p-listar_grupos    AS LOGICAL.
DEFINE INPUT PARAMETER p-generar_cupones  AS LOGICAL.
DEFINE INPUT PARAMETER p-lista_tipos      AS CHARACTER.
DEFINE INPUT PARAMETER p-pto_venta        AS INTEGER.
DEFINE INPUT PARAMETER p-id_lote          AS CHARACTER.
*/

DEFINE VARIABLE p-que_empresa      AS CHARACTER INITIAL "R".
DEFINE VARIABLE p-des_vendedor     LIKE Vendedor.cdg_vendedor INITIAL "0001".
DEFINE VARIABLE p-has_vendedor     LIKE Vendedor.cdg_vendedor INITIAL "9999".

DEFINE VARIABLE p-des_fecha        AS DATE.
DEFINE VARIABLE p-has_fecha        AS DATE.
DEFINE VARIABLE p-mes_imputa       AS INTEGER.
DEFINE VARIABLE p-ano_imputa       AS INTEGER.
DEFINE VARIABLE p-fecha_emision    AS DATE.

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

/*DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".*/
DEFINE VARIABLE v-importe                 AS DECIMAL FORMAT ">,>>>,>>9.99"
                                             COLUMN-LABEL "Importe!Neto".
DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Detalle de Bajas por Promotor" AT 37
       "Página:" AT 80 PAGE-NUMBER FORMAT ">>9" AT 88
       SKIP  
       fecha_lis       
       hora_lis AT 80
       SKIP
       titulo_det AT 37  
       SKIP(1)
       WITH WIDTH 135 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_promotor
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan
       Grupofam.cant_capitas
       v-importe
       WITH WIDTH 135 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

FORM
       t-cupones LABEL "Total Bajas"  
       t-pesos   LABEL "Total Pesos"
       WITH WIDTH 135 DOWN FRAME frm-resumen USE-TEXT STREAM-IO SIDE-LABELS.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

FIND Empresa WHERE Empresa.cdg_empresa = p-que_empresa NO-LOCK.
que_empresa = Empresa.nombre.

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("C:\SIC-TEMP\lisbajas.txt") PAGED.

t-cupones = 0.
t-pesos   = 0.
a-cupones = 0.
a-pesos   = 0.
g-cupones = 0.
g-pesos   = 0.

FOR EACH Grupofam 
    WHERE Grupofam.cdg_empresa  = "A"
      AND Grupofam.cdg_estado   = "B"
      AND (Grupofam.tipo_compbte = "R" 
           OR Grupofam.tipo_compbte = "F") 
      AND Grupofam.cdg_promotor >= "4000" /*p-des_vendedor*/
      AND Grupofam.cdg_promotor <= "4999" /*p-has_vendedor*/
      AND  Grupofam.fecha_alta <= DATE("18/8/00") 
      AND  Grupofam.fecha_alta >= DATE("20/7/00")
      AND  Grupofam.fecha_baja <= DATE("30/9/00")
      AND  Grupofam.fecha_baja >= DATE("01/9/00") 
          NO-LOCK BREAK BY Grupofam.cdg_promotor BY Grupofam.cdg_grupofam
          WITH STREAM-IO FONT 2 USE-TEXT WIDTH 132 FRAME frm-listado:

        VIEW FRAME frm-titulo.

    
        IF FIRST-OF(Grupofam.cdg_promotor)
        THEN DO:
            /*
            FIND Vendedor WHERE Vendedor.cdg_vendedor = Grupofam.cdg_promotor NO-LOCK NO-ERROR.
            IF AVAILABLE Vendedor
               THEN titulo_det = Vendedor.cdg_vendedor + " - " + Vendedor.nombre.
               ELSE titulo_det = Grupofam.cdg_promotor + " - " + "?????".
            */   
        END.


        IF Grupofam.tipo_grupo = "G"
        THEN DO:
            FIND FIRST Plan-capita OF Grupofam  
                       WHERE Plan-capita.cant_capitas = Grupofam.cant_capitas 
                             NO-LOCK NO-ERROR.

            IF AVAILABLE Plan-capita
            THEN DO:
                 IF Plan-capita.precio_neto <> 0 
                 THEN DO:
                      v-importe = Plan-capita.precio_neto / 1.105.
                      DISPLAY Grupofam.cdg_promotor
                              Grupofam.cdg_grupofam  
                              Grupofam.nom_grupofam 
                              Grupofam.cdg_plan
                              Grupofam.cant_capitas
                              v-importe
                              WITH FRAME frm-listado.
                      DOWN WITH FRAME frm-listado.          
                      g-cupones = g-cupones + 1.
                      g-pesos   = g-pesos + v-importe.
                 END.     
            END.
            ELSE DO:
                 RUN mostrar_error.
            END.                              
        END.        
        ELSE DO:
        
            IF Grupofam.importe_cuota <> 0
            THEN DO:
                v-importe = Grupofam.importe_cuota / 1.105.
                DISPLAY Grupofam.cdg_promotor
                        Grupofam.cdg_grupofam  
                        Grupofam.nom_grupofam 
                        Grupofam.cant_capitas
                        v-importe
                        WITH FRAME frm-listado.
                DOWN WITH FRAME frm-listado.   

                 a-pesos = a-pesos + v-importe.
                 /*c-cap = c-cap + Grupofam.cant_capitas .*/
                 a-cupones = a-cupones + 1.

            END.
        
        END.

        IF LAST-OF(Grupofam.cdg_promotor)
        THEN DO:
            UNDERLINE
                  Grupofam.cdg_grupofam  
                  Grupofam.nom_grupofam 
                  Grupofam.cdg_plan
                  Grupofam.cant_capitas
                  v-importe
                  WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.          
          
            DISPLAY "Total Grupos"            @ Grupofam.nom_grupofam
                                    g-cupones @ Grupofam.cdg_plan
                                      g-pesos @ v-importe
                                      WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.          
            
            DISPLAY "      Areas" 
                              @ Grupofam.nom_grupofam
                    a-cupones @ Grupofam.cdg_plan
                    a-pesos @ v-importe
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.          
        
            UNDERLINE
                    v-importe
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.                

            DISPLAY a-pesos + g-pesos @ v-importe
                    WITH FRAME frm-listado.
            DOWN 2 WITH FRAME frm-listado.          

            t-pesos   = t-pesos + a-pesos + g-pesos.
            t-cupones = t-cupones + a-cupones + g-cupones.
        
            g-cupones = 0.
            g-pesos   = 0.
            a-cupones = 0.
            a-pesos   = 0.
        
        END.

END.

DISPLAY t-cupones
        t-pesos
        WITH FRAME frm-resumen.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\lisbajas.txt",
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

