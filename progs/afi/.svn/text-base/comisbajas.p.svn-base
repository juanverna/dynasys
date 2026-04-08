/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-desde_baja       AS DATE.
DEFINE INPUT PARAMETER p-hasta_baja       AS DATE.
DEFINE INPUT PARAMETER p-lista_tipos      AS CHARACTER.
DEFINE INPUT PARAMETER p-id_lote          AS CHARACTER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE v-importe                 AS DECIMAL FORMAT ">,>>>,>>9.99"
                                             COLUMN-LABEL "Importe!Neto".

DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE j                         AS INTEGER.

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Bajas de Grupos Familiares por Promotor" AT 37
       "Página:" AT 80 PAGE-NUMBER FORMAT ">>9" AT 88
       SKIP  
       fecha_lis       
       hora_lis AT 80
       SKIP
       titulo_det AT 37  
       SKIP
       titulo_lst AT 37  
       SKIP(1)
       WITH WIDTH 135 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_promotor
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan
       Grupofam.cant_capitas
       v-importe
       WITH WIDTH 135 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO  NUM-ENTRIES(p-que_empresa,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-que_empresa,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-que_empresa,",") THEN que_empresa = que_empresa + ",".
END.

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("C:\SIC-TEMP\comisbajas.txt") PAGED.

titulo_det = "Bajas " + STRING(p-desde_baja,"99/99/99") + " al " + STRING(p-hasta_baja,"99/99/99").
titulo_lst = "Altas " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").

FOR EACH Grupofam USE-INDEX por_promotor_baja
        WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
            /*  Grupofam.cdg_empresa  = p-que_empresa */
          AND Grupofam.cdg_estado   = "B"
          AND Grupofam.cdg_promotor >= p-des_vendedor
          AND Grupofam.cdg_promotor <= p-has_vendedor 
          /*
          AND (Grupofam.tipo_compbte = "R" 
               OR Grupofam.tipo_compbte = "F") 
          */     
          AND LOOKUP(Grupofam.tipo_grupo,p-lista_tipos,"|") <> 0
          AND Grupofam.fecha_baja   >= p-desde_baja
          AND Grupofam.fecha_baja   <= p-hasta_baja
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BREAK BY Grupofam.cdg_promotor 
                            BY Grupofam.cdg_empresa 
                            BY Grupofam.cdg_estado 
                            BY Grupofam.fecha_baja
                            WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

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
    
UNDERLINE
         Grupofam.cdg_promotor
         Grupofam.cdg_grupofam  
         Grupofam.nom_grupofam 
         Grupofam.cdg_plan
         Grupofam.cant_capitas
         v-importe
         WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          


OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\comisbajas.txt",
                 INPUT 2 ).

