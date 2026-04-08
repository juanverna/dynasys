/*=========================================================================================*/
/*            EMITE EL LISTADO DE BAJAS POR PROMOTOR PARA UNA VIGENCIA DADA                */
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

DEFINE VARIABLE v-debito                  LIKE Cta_cte.debito.
DEFINE VARIABLE v-credito                  LIKE Cta_cte.credito.

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
DEFINE VARIABLE tiplan                    AS INTEGER.
DEFINE VARIABLE primero                   AS LOGICAL.

DEFINE VARIABLE g-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE g-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.
DEFINE VARIABLE a-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE a-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.
DEFINE VARIABLE t-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE t-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99" EXTENT 2.
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9" EXTENT 2.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Bajas de Grupos Familiares por Promotor" AT 80
       "Página:" AT 174 PAGE-NUMBER FORMAT ">>9" AT 182
       SKIP  
       fecha_lis       
       titulo_det AT 80  
       hora_lis AT 174
       SKIP
       titulo_lst AT 80  
       SKIP(1)
       WITH WIDTH 190 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_promotor COLUMN-LABEL "Cod!Prom" FORMAT "X(4)"
       Grupofam.cdg_empresa  COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Grupofam.cdg_grupofam  
       Grupofam.nom_grupofam 
       Grupofam.cdg_plan     COLUMN-LABEL "Cod!Plan" FORMAT "X(4)"
       Grupofam.cant_capitas
       Grupofam.fecha_alta 
       Grupofam.tipo_compbte COLUMN-LABEL "Tip!Com"
       Grupofam.tipo_grupo   COLUMN-LABEL "G!A"
       Grupofam.num_sucursal COLUMN-LABEL "Cod!Suc" FORMAT "X(4)"
       Grupofam.cdg_estado   COLUMN-LABEL "Cod!Est"
       Grupofam.fecha_baja   COLUMN-LABEL "Fecha!Baja"
       Cta_cte.tip_comprob   COLUMN-LABEL "Tip!Com"
       Cta_cte.prf_comprob   COLUMN-LABEL "Pto!Vta"
       Cta_cte.nro_comprob   COLUMN-LABEL "Número!Comprob"
       Imputacion.abrevia    COLUMN-LABEL "Con-!cepto"
       v-debito              COLUMN-LABEL "Importe!Facturado"
       v-credito             COLUMN-LABEL "Importe!Cobrado"
       Cta_cte.fecha_emision COLUMN-LABEL "Fecha de!Emision"
       Cta_cte.ano           COLUMN-LABEL "Año!Imp"
       Cta_cte.mes           COLUMN-LABEL "Mes!Imp"
       WITH WIDTH 190 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

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

OUTPUT TO VALUE("C:\SIC-TEMP\bajasxpromotor.txt") PAGED.

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

    primero = FIRST-OF(Grupofam.cdg_promotor).

    tiplan = IF INDEX("0123456789",SUBSTRING(Grupofam.cdg_plan,1,1)) <> 0 THEN 2 ELSE 1.

    FIND Cliente OF Grupofam NO-LOCK.
    FOR EACH Cta_cte NO-LOCK OF Cliente 
         WHERE LOOKUP(Cta_cte.tip_comprob,"FA,FB,FC,FK,RA,RB,RC,RK") <> 0
           AND Cta_cte.fecha_emision >= p-desde_baja
           AND Cta_cte.fecha_emision <= p-hasta_baja,
               FIRST Imputacion OF Cta_cte
                     BREAK BY Cta_cte.nro_cliente 
                           BY Cta_cte.fecha_emision:

        /*
        v-debito  = MAXIMUM(Cta_cte.debito  - Cta_cte.imp_iva,0).
        v-credito = MAXIMUM(Cta_cte.credito - Cta_cte.imp_iva,0).
        */

        v-debito  = ROUND(Cta_cte.debito  / 1.105 ,2). 
        v-credito = ROUND(Cta_cte.credito / 1.105 ,2).
        
        DISPLAY
                Grupofam.cdg_promotor WHEN primero
                Grupofam.cdg_empresa  WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.cdg_grupofam WHEN FIRST-OF(Cta_cte.nro_cliente) 
                Grupofam.nom_grupofam WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.cdg_plan     WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.cant_capitas WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.fecha_alta   WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.tipo_compbte WHEN FIRST-OF(Cta_cte.nro_cliente) 
                Grupofam.tipo_grupo   WHEN FIRST-OF(Cta_cte.nro_cliente)
                Grupofam.num_sucursal WHEN FIRST-OF(Cta_cte.nro_cliente) 
                Grupofam.cdg_estado   WHEN FIRST-OF(Cta_cte.nro_cliente) 
                Grupofam.fecha_baja   WHEN FIRST-OF(Cta_cte.nro_cliente)
                Cta_cte.tip_comprob
                Cta_cte.prf_comprob
                Cta_cte.nro_comprob
                Imputacion.abrevia
                v-debito        WHEN SUBSTRING(Cta_cte.tip_comprob,1,1) = "F"
                v-credito       WHEN SUBSTRING(Cta_cte.tip_comprob,1,1) = "R"
                Cta_cte.fecha_emision 
                Cta_cte.ano
                Cta_cte.mes
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.   

        primero = NO.

        IF Grupofam.tipo_grupo = "G"
        THEN DO:

            CASE SUBSTRING(Cta_cte.tip_comprob,1,1):
                WHEN "F" THEN g-debito  [ tiplan ] = g-debito  [ tiplan ] + v-debito.
                WHEN "R" THEN g-credito [ tiplan ] = g-credito [ tiplan ] + v-credito.
            END CASE.

        END.
        ELSE DO:

            CASE SUBSTRING(Cta_cte.tip_comprob,1,1):
                WHEN "F" THEN g-debito  [ tiplan ] = g-debito  [ tiplan ] + v-debito.
                WHEN "R" THEN g-credito [ tiplan ] = g-credito [ tiplan ] + v-credito.
            END CASE.

        END.
       
        IF FIRST-OF(Cta_cte.nro_cliente)
        THEN DO:
            IF Grupofam.tipo_grupo = "G"
            THEN DO:
                g-cupones [ tiplan ] = g-cupones [ tiplan ]  + 1.
            END.
            ELSE DO:
                a-cupones [ tiplan ] = a-cupones [ tiplan ]  + 1.
            END.
        END.

    END. /* De recorrer la cuenta corriente */

    IF LAST-OF(Grupofam.cdg_promotor)
    THEN DO:
        UNDERLINE
              Grupofam.cdg_promotor 
              Grupofam.cdg_empresa  
              Grupofam.cdg_grupofam  
              Grupofam.nom_grupofam 
              Grupofam.cdg_plan     
              Grupofam.cant_capitas 
              Grupofam.fecha_alta   
              Grupofam.tipo_compbte  
              Grupofam.tipo_grupo   
              Grupofam.num_sucursal  
              Grupofam.cdg_estado    
              Grupofam.fecha_baja
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Imputacion.abrevia
              v-debito 
              v-credito
              Cta_cte.fecha_emision
              Cta_cte.ano
              Cta_cte.mes
              WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
      
        DISPLAY "Total Grupos Blanco"    @ Grupofam.nom_grupofam
                         g-cupones [ 1 ] @ Grupofam.cdg_plan
                         g-debito  [ 1 ] @ v-debito
                         g-credito  [ 1 ] @ v-credito
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
        DISPLAY "Total Grupos Dorado"    @ Grupofam.nom_grupofam
                         g-cupones [ 2 ] @ Grupofam.cdg_plan
                         g-debito  [ 2 ] @ v-debito
                         g-credito  [ 2 ] @ v-credito
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        
        DISPLAY "      Areas  Blanco"    @ Grupofam.nom_grupofam
                    a-cupones [ 1 ] @ Grupofam.cdg_plan
                     a-debito [ 1 ] @ v-debito
                    a-credito  [ 1 ] @ v-credito
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        DISPLAY "      Areas  Dorado"    @ Grupofam.nom_grupofam
                    a-cupones [ 2 ] @ Grupofam.cdg_plan
                     a-debito [ 2 ] @ v-debito
                    a-credito  [ 2 ] @ v-credito
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
    
        UNDERLINE
              Grupofam.cdg_promotor 
              Grupofam.cdg_empresa  
              Grupofam.cdg_grupofam  
              Grupofam.nom_grupofam 
              Grupofam.cdg_plan     
              Grupofam.cant_capitas 
              Grupofam.fecha_alta   
              Grupofam.tipo_compbte  
              Grupofam.tipo_grupo   
              Grupofam.num_sucursal  
              Grupofam.cdg_estado    
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Imputacion.abrevia
              v-debito
              v-credito
              Cta_cte.fecha_emision
              Cta_cte.ano
              Cta_cte.mes
              WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        DISPLAY a-debito [ 1 ] + g-debito [ 1 ] +
                a-debito [ 2 ] + g-debito [ 2 ] @ v-debito
                a-credito [ 1 ] + g-credito [ 1 ] +
                a-credito [ 2 ] + g-credito [ 2 ] @ v-credito
                WITH FRAME frm-listado.
        DOWN 2 WITH FRAME frm-listado.          

        DO tiplan = 1 TO 2:
        
            t-debito [ tiplan ]  = t-debito [ tiplan ] + a-debito [ tiplan ] + g-debito [ tiplan ].
            t-credito [ tiplan ] = t-credito [ tiplan ] + a-credito [ tiplan ] + g-credito [ tiplan ].
            t-cupones [ tiplan ] = t-cupones [ tiplan ] + a-cupones [ tiplan ] + g-cupones [ tiplan ].
        
            g-cupones [ tiplan ] = 0.
            g-debito [ tiplan ]  = 0.
            g-credito [ tiplan ] = 0.
            a-cupones [ tiplan ] = 0.
            a-debito [ tiplan ]  = 0.
            a-credito [ tiplan ] = 0.
        
        END.
    
    END.
END.       
    
UNDERLINE
    Grupofam.cdg_promotor 
    Grupofam.cdg_empresa  
    Grupofam.cdg_grupofam  
    Grupofam.nom_grupofam 
    Grupofam.cdg_plan     
    Grupofam.cant_capitas 
    Grupofam.fecha_alta   
    Grupofam.tipo_compbte  
    Grupofam.tipo_grupo   
    Grupofam.num_sucursal  
    Grupofam.cdg_estado    
    Cta_cte.tip_comprob
    Cta_cte.prf_comprob
    Cta_cte.nro_comprob
    Imputacion.abrevia
    v-debito
    v-credito
    Cta_cte.fecha_emision
    Cta_cte.ano
    Cta_cte.mes
    WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
  
DISPLAY "Total General Blanco"    @ Grupofam.nom_grupofam
            t-cupones [ 1 ] @ Grupofam.cdg_plan
             t-debito [ 1 ] @ v-debito
             t-credito [ 1 ] @ v-credito
        WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          
DISPLAY "Total General Dorado"    @ Grupofam.nom_grupofam
            t-cupones [ 2 ] @ Grupofam.cdg_plan
             t-debito [ 2 ] @ v-debito
             t-credito [ 2 ] @ v-credito
        WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

UNDERLINE
    Grupofam.cdg_promotor 
    Grupofam.cdg_empresa  
    Grupofam.cdg_grupofam  
    Grupofam.nom_grupofam 
    Grupofam.cdg_plan     
    Grupofam.cant_capitas 
    Grupofam.fecha_alta   
    Grupofam.tipo_compbte  
    Grupofam.tipo_grupo   
    Grupofam.num_sucursal  
    Grupofam.cdg_estado    
    Cta_cte.tip_comprob
    Cta_cte.prf_comprob
    Cta_cte.nro_comprob
    Imputacion.abrevia
    v-debito
    v-credito
    Cta_cte.fecha_emision
    Cta_cte.ano
    Cta_cte.mes
    WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

DISPLAY "       Total General"        @ Grupofam.nom_grupofam
    t-cupones [ 1 ] + t-cupones [ 2 ] @ Grupofam.cdg_plan
    t-debito [ 1 ]  + t-debito [ 2 ]  @ v-debito
    t-credito [ 1 ]  + t-credito [ 2 ]  @ v-credito
            WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\bajasxpromotor.txt",
                 INPUT 2 ).

