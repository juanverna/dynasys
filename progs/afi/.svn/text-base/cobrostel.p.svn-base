/*=========================================================================================*/
/*   EMITE EL LISTADO DE COBRANZAS DE PRIMERA CUOTA POR PROMOTOR PARA UNA VIGENCIA DADA    */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-has_vendedor     LIKE Vendedor.cdg_vendedor.
DEFINE INPUT PARAMETER p-des_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-has_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-desde_emision    AS DATE.
DEFINE INPUT PARAMETER p-hasta_emision    AS DATE.
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

DEFINE VARIABLE j                         AS INTEGER.

DEFINE VARIABLE pri_cob                   LIKE Cobrador.nro_cobrador.
DEFINE VARIABLE ult_cob                   LIKE Cobrador.nro_cobrador.

DEFINE VARIABLE g-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-debito                  AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-credito                 AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-cupones                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE x-cupones                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Cobranzas de Primera Cuota por Promotor (Telemarketing) " AT 37
       "Página:" AT 113 PAGE-NUMBER FORMAT ">>9" AT 121
       SKIP  
       fecha_lis       
       hora_lis AT 113
       SKIP
       titulo_det AT 37  
       SKIP
       titulo_lst AT 37  
       SKIP
       titulo_cob AT 37  
       SKIP(1)
       WITH WIDTH 135 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

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
       Cta_cte.credito COLUMN-LABEL "Importe!Cobrado"
       Cta_cte.fecha_emision COLUMN-LABEL "Fecha!Cobro"
       Cta_cte.ano COLUMN-LABEL "Año!Imp" FORMAT "9999"
       Cta_cte.mes COLUMN-LABEL "Mes!Imp" FORMAT "99"
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

titulo_det = "Emisión " + STRING(p-desde_emision,"99/99/99") + " al " + STRING(p-hasta_emision,"99/99/99").
titulo_lst = "Altas   " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").

fecha_lis = TODAY.
hora_lis = STRING(TIME,"HH:MM:SS").

FIND Cobrador WHERE Cobrador.cdg_cobrador = p-des_cobrador NO-LOCK.
pri_cob = Cobrador.nro_cobrador.
titulo_cob = "Cobradores " + Cobrador.cdg_cobrador + " al ".

FIND Cobrador WHERE Cobrador.cdg_cobrador = p-has_cobrador NO-LOCK.
ult_cob = Cobrador.nro_cobrador.
titulo_cob = titulo_cob + Cobrador.cdg_cobrador.

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

    FIND Cliente OF Grupofam NO-LOCK NO-ERROR.
    IF AVAILABLE Cliente
    THEN DO:
        FOR EACH Cta_cte OF Cliente 
             WHERE Cta_cte.tip_comprob BEGINS "R"
               AND Cta_cte.fecha_emision >= p-desde_emision
               AND Cta_cte.fecha_emision <= p-hasta_emision
               AND Cta_cte.nro_cobrador <= ult_cob
               AND Cta_cte.nro_cobrador >= pri_cob
                   NO-LOCK:
                   
            DISPLAY
                    Grupofam.cdg_promotor /*WHEN FIRST-OF(Grupofam.cdg_promotor)*/
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
                    Cta_cte.credito
                    Cta_cte.fecha_emision WHEN Cta_cte.fecha_emision <> ?
                    Cta_cte.ano
                    Cta_cte.mes
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.   
    
            IF Grupofam.tipo_grupo = "G"
            THEN DO:
                g-debito  = g-debito   + Cta_cte.debito.
                g-credito = g-credito  + Cta_cte.credito.
            END.
            ELSE DO:
                a-debito  = a-debito   + Cta_cte.debito.
                a-credito = a-credito  + Cta_cte.credito.
            END.
           
            IF Grupofam.tipo_grupo = "G"
            THEN DO:
                g-cupones = g-cupones  + 1.
            END.
            ELSE DO:
                a-cupones = a-cupones  + 1.
            END.
    
        END.
    END.

    IF LAST-OF(Grupofam.cdg_promotor)
    THEN DO:
         IF g-cupones + a-cupones  <> 0
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
                  Cta_cte.credito
                  Cta_cte.fecha_emision
                  Cta_cte.ano
                  Cta_cte.mes
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
                    "Total Grupos"
                              @ Grupofam.nom_grupofam
                    g-cupones @ Grupofam.cdg_plan
                    g-credito @ Cta_cte.credito
                    " "       @ Cta_cte.ano
                    " "       @ Cta_cte.mes
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
                    "      Areas" 
                              @ Grupofam.nom_grupofam
                    a-cupones @ Grupofam.cdg_plan
                    a-credito @ Cta_cte.credito
                    " "       @ Cta_cte.ano
                    " "       @ Cta_cte.mes
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.          
        
            UNDERLINE
                    Grupofam.cdg_plan
                    Cta_cte.credito
                    WITH FRAME frm-listado.
            DOWN WITH FRAME frm-listado.                
    
            x-cupones = a-cupones + g-cupones.
            DISPLAY x-cupones @ Grupofam.cdg_plan
                    a-credito + g-credito @ Cta_cte.credito
                    WITH FRAME frm-listado.
            DOWN 2 WITH FRAME frm-listado.          
        
        END.

        t-debito  = t-debito  + a-debito  + g-debito.
        t-credito = t-credito + a-credito + g-credito.
        t-cupones = t-cupones + a-cupones + g-cupones.
    
        g-cupones = 0.
        g-debito  = 0.
        g-credito = 0.
        a-cupones = 0.
        a-debito  = 0.
        a-credito = 0.

    END.

END.       
    
UNDERLINE
         Grupofam.cdg_promotor
         Grupofam.cdg_grupofam  
         Grupofam.nom_grupofam 
         Grupofam.cdg_plan
         Grupofam.cant_capitas
         Cta_cte.fecha_emision
         Cta_cte.credito
         Cta_cte.ano
         Cta_cte.mes
         WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.          

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\cobroxpromotor.txt",
                 INPUT 2 ).

