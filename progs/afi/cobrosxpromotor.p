/*=========================================================================================*/
/*   EMITE EL LISTADO DE COBRANZAS DE PRIMERA CUOTA POR PROMOTOR PARA UNA VIGENCIA DADA    */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-que_mes          AS INTEGER.
DEFINE INPUT PARAMETER p-que_ano          AS INTEGER.
DEFINE INPUT PARAMETER p-lista_tipos      AS CHARACTER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_cob                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE v-importe-debito          AS DECIMAL FORMAT ">,>>>,>>9.99"
                                             COLUMN-LABEL "Importe!Facturado".
DEFINE VARIABLE v-importe-credito         AS DECIMAL FORMAT ">,>>>,>>9.99"
                                             COLUMN-LABEL "Importe!Cobrado".

DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".
DEFINE VARIABLE v-debito                  LIKE Cta_cte.debito.
DEFINE VARIABLE v-credito                 LIKE Cta_cte.credito.

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE nplan                     AS INTEGER.
DEFINE VARIABLE hubo_promotor             AS LOGICAL.

DEFINE VARIABLE pri_cob                   LIKE Cobrador.nro_cobrador.
DEFINE VARIABLE ult_cob                   LIKE Cobrador.nro_cobrador.

DEFINE VARIABLE g-debito                  AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-credito                 AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-cupones                 AS INTEGER EXTENT 2 FORMAT ">>>>9".
DEFINE VARIABLE a-debito                  AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-credito                 AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-cupones                 AS INTEGER EXTENT 2 FORMAT ">>>>9".
DEFINE VARIABLE t-debito                  AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-credito                 AS DECIMAL EXTENT 2 FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-cupones                 AS INTEGER EXTENT 2 FORMAT ">>>>9".
DEFINE VARIABLE x-cupones                 AS INTEGER EXTENT 2 FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Cobranzas por Promotor" AT 52
       "Página:" AT 126 PAGE-NUMBER FORMAT ">>9" AT 134
       SKIP  
       fecha_lis       
       hora_lis AT 126
       SKIP
       titulo_det AT 52  
       SKIP
       titulo_lst AT 52  
       SKIP
       titulo_cob AT 52  
       SKIP(1)
       WITH WIDTH 200 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Grupofam.cdg_promotor COLUMN-LABEL "Cod!Prom" FORMAT "X(4)"
       Grupofam.cdg_empresa COLUMN-LABEL "Cod!Emp" FORMAT "X(3)"
       Grupofam.cdg_grupofam  COLUMN-LABEL "Codigo!Grupo"
       Grupofam.nom_grupofam COLUMN-LABEL "Nombre o!Razon Social"
       Grupofam.cdg_plan COLUMN-LABEL "Cod!Plan" FORMAT "X(3)"
       Grupofam.cant_capitas COLUMN-LABEL "Cant!Cap." FORMAT ">>>>9"
       Grupofam.fecha_alta COLUMN-LABEL "Fecha!Alta"
       Grupofam.tipo_compbte COLUMN-LABEL "Tip!Comp" FORMAT "X(3)"
       Grupofam.tipo_grupo COLUMN-LABEL "Tip!Grp" FORMAT "X(3)"
       Grupofam.num_sucursal COLUMN-LABEL "Cod!Suc" FORMAT "X(3)"
       Grupofam.cdg_estado COLUMN-LABEL "Es-!tado" FORMAT "X(3)"
       v-debito  COLUMN-LABEL "Importe!Facturado"
       v-credito COLUMN-LABEL "Importe!Cobrado"
       Cta_cte.fecha_emision COLUMN-LABEL "Fecha!Factura"
       WITH WIDTH 235 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

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

OUTPUT TO VALUE("C:\SIC-TEMP\cobroxpromotor.txt") PAGED.

titulo_det = "Emisión " + STRING(p-que_mes,"99") + " - " + STRING(p-que_ano,"9999").
titulo_lst = "Altas   " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

FOR EACH Grupofam USE-INDEX por_promotor_baja
        WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
          AND Grupofam.cdg_promotor >= p-des_vendedor
          AND Grupofam.cdg_promotor <= p-has_vendedor 
          AND LOOKUP(Grupofam.tipo_grupo,p-lista_tipos,"|") <> 0
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BREAK BY Grupofam.cdg_promotor 
                            BY Grupofam.cdg_empresa 
                            BY Grupofam.cdg_estado 
                            BY Grupofam.fecha_baja
                            WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.
  
    hubo_promotor = NOT FIRST-OF(Grupofam.cdg_promotor).

    FIND Cliente OF Grupofam NO-LOCK NO-ERROR.
    IF AVAILABLE Cliente
    THEN DO:
        FOR EACH Cta_cte OF Cliente 
             WHERE Cta_cte.tip_comprob BEGINS "F"
               AND Cta_cte.mes >= p-que_mes
               AND Cta_cte.ano <= p-que_ano
                   NO-LOCK:
    
            v-debito  = ROUND(Cta_cte.debito / 1.105,2).
            v-credito = ROUND(Cta_cte.credito / 1.105,2).
                   
            DISPLAY
                    Grupofam.cdg_promotor /*WHEN NOT hubo_promotor */
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
                    v-debito
                    v-credito
                    Cta_cte.fecha_emision WHEN Cta_cte.fecha_emision <> ?
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.   
            hubo_promotor = YES.
    
            IF Grupofam.tipo_grupo = "G"
            THEN DO:
                nplan = IF LOOKUP(SUBSTRING(Grupofam.cdg_plan,1,1),"0,1,2,3,4,5,6,7,8,9",",") = 0 THEN  1 ELSE 2.
                g-debito  [ nplan ] = g-debito  [ nplan ] + v-debito.
                g-credito [ nplan ] = g-credito [ nplan ] + v-credito.
            END.
            ELSE DO:
                nplan = 1.
                a-debito  [ nplan ] = a-debito  [ nplan ] + v-debito.
                a-credito [ nplan ] = a-credito [ nplan ] + v-credito.
            END.
           
            IF Grupofam.tipo_grupo = "G"
            THEN DO:
                g-cupones [ nplan ] = g-cupones [ nplan ] + 1.
            END.
            ELSE DO:
                a-cupones [ nplan ] = a-cupones [ nplan ] + 1.
            END.
    
        END.
    END.
    ELSE DO:
                   
        DISPLAY
                Grupofam.cdg_promotor /*WHEN NOT hubo_promotor */
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
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.   
        hubo_promotor = YES.

    END.

    IF LAST-OF(Grupofam.cdg_promotor)
    THEN DO:
         DO nplan = 1 TO 2:
            IF g-cupones [ nplan ] + a-cupones [ nplan ] <> 0
            THEN DO:
               UNDERLINE
                     Grupofam.cdg_empresa 
                     Grupofam.cdg_promotor
                     Grupofam.cdg_grupofam  
                     Grupofam.nom_grupofam 
                     Grupofam.cdg_plan
                     Grupofam.cant_capitas
                     Grupofam.fecha_alta 
                     Grupofam.tipo_compbte 
                     Grupofam.tipo_grupo 
                     Grupofam.num_sucursal 
                     Grupofam.cdg_estado
                     v-debito
                     v-credito
                     Cta_cte.fecha_emision
                     WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.          
             
               DISPLAY " " @ Grupofam.cdg_empresa 
                       " " @ Grupofam.cdg_promotor
                       " " @ Grupofam.cdg_grupofam  
                       " " @ Grupofam.cant_capitas
                       " " @ Grupofam.fecha_alta 
                       " " @ Grupofam.tipo_compbte 
                       " " @ Grupofam.tipo_grupo 
                       " " @ Grupofam.num_sucursal 
                       " " @ Grupofam.cdg_estado
                       "Total Grupos" + STRING(nplan," 9")
                                 @ Grupofam.nom_grupofam
                       g-cupones [ nplan ] @ Grupofam.cdg_plan
                       g-debito  [ nplan ] @ v-debito
                       g-credito [ nplan ] @ v-credito
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.          
               
               DISPLAY " " @ Grupofam.cdg_empresa 
                       " " @ Grupofam.cdg_promotor
                       " " @ Grupofam.cdg_grupofam  
                       " " @ Grupofam.cant_capitas
                       " " @ Grupofam.fecha_alta 
                       " " @ Grupofam.tipo_compbte 
                       " " @ Grupofam.tipo_grupo 
                       " " @ Grupofam.num_sucursal 
                       " " @ Grupofam.cdg_estado
                       "      Areas" + STRING(nplan," 9")
                                 @ Grupofam.nom_grupofam
                       a-cupones [ nplan ] @ Grupofam.cdg_plan
                       a-debito  [ nplan ] @ v-debito
                       a-credito [ nplan ] @ v-credito
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.          
           
               UNDERLINE
                       Grupofam.cdg_plan
                       v-debito
                       v-credito
                       WITH FRAME frm-listado.
               DOWN WITH FRAME frm-listado.                
       
               x-cupones = a-cupones [ nplan ] + g-cupones [ nplan ].
               DISPLAY x-cupones @ Grupofam.cdg_plan
                       a-debito [ nplan ] + g-debito [ nplan ] @ v-debito
                       a-credito [ nplan ] + g-credito [ nplan ] @ v-credito
                       WITH FRAME frm-listado.
               DOWN 2 WITH FRAME frm-listado.          
           
           END.
   
           t-debito  [ nplan ] = t-debito  [ nplan ] + a-debito  [ nplan ] + g-debito  [ nplan ].
           t-credito [ nplan ] = t-credito [ nplan ] + a-credito [ nplan ] + g-credito [ nplan ].
           t-cupones [ nplan ] = t-cupones [ nplan ] + a-cupones [ nplan ] + g-cupones [ nplan ].
       
        END. /* Del DO */
        g-cupones = 0.
        g-debito  = 0.
        g-credito = 0.
        a-cupones = 0.
        a-debito  = 0.
        a-credito = 0.

    END. /* Del IF */

END.       
    
UNDERLINE
         Grupofam.cdg_promotor
         Grupofam.cdg_grupofam  
         Grupofam.nom_grupofam 
         Grupofam.cdg_plan
         Grupofam.cant_capitas
         Cta_cte.fecha_emision
         v-debito
         v-credito
         WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cobroxpromotor.txt",
                 INPUT 2 ).
