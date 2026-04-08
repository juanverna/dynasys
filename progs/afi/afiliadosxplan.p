/*=========================================================================================*/
/*              REALIZA LA EMISION DE LOS CUPONES Y FACTURAS MENSUALES DE SERVICIO         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-desde_alta       AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta       AS DATE.
DEFINE INPUT PARAMETER p-lista_empresas   AS CHARACTER.
DEFINE INPUT PARAMETER p-lista_planes     AS CHARACTER.
DEFINE INPUT PARAMETER p-archivo          AS CHARACTER.

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE v-direccion               AS CHARACTER FORMAT "X(55)".
DEFINE VARIABLE v-fechalta                AS CHARACTER FORMAT "X(8)".

DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.
DEFINE VARIABLE linea                     AS CHARACTER FORMAT "X(156)".

DEFINE VARIABLE v-tip_comprob             LIKE Rec_header.tip_comprob FORMAT "X(3)".
DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".
DEFINE VARIABLE c-afiliados               AS INTEGER FORMAT ">>>>9".

DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE tiplan                    AS INTEGER.

DEFINE VARIABLE a-total                   AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE g-total                   AS INTEGER FORMAT ">>>>9".

DEFINE STREAM Exportacion.

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Afiliados x Plan de Cobertura" AT 57
       "Página:" AT 130 PAGE-NUMBER FORMAT ">>9" AT 139
       SKIP  
       fecha_lis       
       titulo_det AT 57
       hora_lis AT 130
       SKIP
       titulo_lst AT 57  
       SKIP(1)
       WITH WIDTH 190 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Afiliado.cdg_empresa   COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Afiliado.cdg_afiliado  COLUMN-LABEL "Código!Afiliado" FORMAT "X(14)" 
       Afiliado.nom_afiliado  COLUMN-LABEL "Nombre!Afiliado"
       Afiliado.num_carnet    COLUMN-LABEL "Número!Credencial"
       Afiliado.fecha_alta    COLUMN-LABEL "Fecha!de Alta"
       WITH WIDTH 190 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

que_empresa = "".
DO j = 1 TO  NUM-ENTRIES(p-lista_empresas,","):
     FIND Empresa WHERE Empresa.cdg_empresa = ENTRY(j,p-lista_empresas,",") NO-LOCK.
     que_empresa = que_empresa + Empresa.nombre.
     IF j <> NUM-ENTRIES(p-lista_empresas,",") THEN que_empresa = que_empresa + ",".
END.

/*{DIRPRINFILE.I}*/

/*OUTPUT STREAM Exportacion TO VALUE(p-archivo) PAGE-SIZE 0.*/
OUTPUT TO VALUE("c:\sic-temp\afiliadosxplan.txt") PAGED.

FOR EACH Grupofam
        WHERE LOOKUP(Grupofam.cdg_empresa,p-lista_empresas) <> 0
          AND Grupofam.cdg_estado = "A"
          AND CAN-DO(p-lista_planes,Grupofam.cdg_plan)
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BREAK BY Grupofam.cdg_empresa
                            BY Grupofam.cdg_plan
                            BY Grupofam.cdg_grupofam 
                            WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    IF FIRST-OF(Grupofam.cdg_plan)
    THEN DO:
         FIND Plan OF Grupofam NO-LOCK.
         titulo_det = "Plan:" + Plan.cdg_plan + "-" + Plan.dsc_plan.
    END.

    VIEW FRAME frm-titulo.

    FIND Plan OF Grupofam NO-LOCK.

    FOR EACH Afiliado OF Grupofam NO-LOCK 
         WHERE Afiliado.cdg_estado = "A":

        DISPLAY
               Afiliado.cdg_empresa   
               Afiliado.cdg_afiliado  
               Afiliado.nom_afiliado  
               Afiliado.num_carnet    
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.   

        c-afiliados = c-afiliados + 1.

    END. /* De recorrer los afiliados */

    IF LAST-OF(Grupofam.cdg_plan)
    THEN DO:
        UNDERLINE
               Afiliado.cdg_empresa   
               Afiliado.cdg_afiliado  
               Afiliado.nom_afiliado  
               Afiliado.num_carnet    
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
      
        DISPLAY "Total Afiliados"    @ Afiliado.cdg_afiliado
                         c-afiliados @ Afiliado.num_carnet
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        UNDERLINE
               Afiliado.cdg_empresa   
               Afiliado.cdg_afiliado  
               Afiliado.nom_afiliado  
               Afiliado.num_carnet    
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        c-afiliados = 0.
       
        IF NOT LAST(Grupofam.cdg_plan) THEN PAGE.

    END.

END.       
    
OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\afiliadosxplan.txt",
                 INPUT 2 ).

