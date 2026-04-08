/*=========================================================================================*/
/*                    EMITE EL LISTADO DE GRUPOS POR CENTRO MEDICO                         */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa       AS CHARACTER.
DEFINE INPUT PARAMETER p-des_centromed     LIKE Centromedico.centro_medico.
DEFINE INPUT PARAMETER p-has_centromed     LIKE Centromedico.centro_medico.
DEFINE INPUT PARAMETER p-desde_alta        AS DATE.
DEFINE INPUT PARAMETER p-hasta_alta        AS DATE.

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
DEFINE VARIABLE tiplan                    AS INTEGER.
DEFINE VARIABLE primero                   AS LOGICAL.

DEFINE VARIABLE c-afiliados               AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Grupos Familiares por Centro Médico" AT 80
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
       Afiliado.cdg_empresa   COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Afiliado.cdg_afiliado  COLUMN-LABEL "Código!Afiliado" FORMAT "X(14)" 
       Afiliado.nom_afiliado  COLUMN-LABEL "Nombre!Afiliado"
       Afiliado.num_carnet    COLUMN-LABEL "Número!Carnet"
       Plan.dsc_plan          COLUMN-LABEL "Plan de !Cobertura"
       Afiliado.fecha_alta    COLUMN-LABEL "Fecha!de Alta"
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

OUTPUT TO VALUE("C:\SIC-TEMP\centros_medicos.txt") PAGED.

titulo_lst = "Altas " + STRING(p-desde_alta,"99/99/99") + " al " + STRING(p-hasta_alta,"99/99/99").

FOR EACH Grupofam USE-INDEX por_centro
        WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
          AND Grupofam.cdg_estado   = "A"
          AND Grupofam.centro_medico >= p-des_centromed
          AND Grupofam.centro_medico <= p-has_centromed 
          AND Grupofam.fecha_alta   >= p-desde_alta
          AND Grupofam.fecha_alta   <= p-hasta_alta
              NO-LOCK BREAK BY Grupofam.centro_medico 
                            BY Grupofam.cdg_estado 
                            BY Grupofam.cdg_empresa 
                            WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    IF FIRST-OF(Grupofam.centro_medico)
    THEN DO:
         FIND Centromedico OF Grupofam NO-LOCK.
         titulo_det = "Centro:" + Centromedico.centro_medico + "-" + Centromedico.nombre_centro.
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
               Plan.dsc_plan      
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.   

        c-afiliados = c-afiliados + 1.

    END. /* De recorrer los afiliados */

    IF LAST-OF(Grupofam.centro_medico)
    THEN DO:
        UNDERLINE
               Afiliado.cdg_empresa   
               Afiliado.cdg_afiliado  
               Afiliado.nom_afiliado  
               Afiliado.num_carnet    
               Plan.dsc_plan      
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          
      
        DISPLAY "Total Afiliados"    @ Afiliado.cdg_afiliado
                         c-afiliados @ Plan.dsc_plan
                WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        UNDERLINE
               Afiliado.cdg_empresa   
               Afiliado.cdg_afiliado  
               Afiliado.nom_afiliado  
               Afiliado.num_carnet    
               Plan.dsc_plan      
               Afiliado.fecha_alta    
               WITH FRAME frm-listado.
        DOWN WITH FRAME frm-listado.          

        c-afiliados = 0.
       
        IF NOT LAST(Grupofam.centro_medico) THEN PAGE.

    END.

END.       
    
OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\centros_medicos.txt",
                 INPUT 2 ).

