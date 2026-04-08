/*=========================================================================================*/
/*            EMITE EL LISTADO DE BAJAS ORDENADO ALFABETICAMENTE                           */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-mes              AS INTEGER.
DEFINE INPUT PARAMETER p-ano              AS INTEGER.

/*=========================================================================================*/
/*                                        VARIABLES                                        */
/*=========================================================================================*/

{vrshared.i "NEW"}
{WGLISTAR.I}

DEFINE VARIABLE fecha_lis                 AS DATE.     
DEFINE VARIABLE hora_lis                  AS CHARACTER.
DEFINE VARIABLE titulo_lst                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE titulo_det                AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa               LIKE Empresa.nombre.

DEFINE VARIABLE v-desde_cumple            AS DATE.
DEFINE VARIABLE v-hasta_cumple            AS DATE.

DEFINE VARIABLE edad                      AS INTEGER.
DEFINE VARIABLE j                         AS INTEGER.
DEFINE VARIABLE t-grupos                  AS INTEGER.
DEFINE VARIABLE t-pesos                   AS DECIMAL.

/*=========================================================================================*/
/*                                        FRAMES                                           */
/*=========================================================================================*/

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Afiliados que cumplen años en un mes dado" AT 40
       "Página:" AT 96 PAGE-NUMBER FORMAT ">>9" AT 102
       SKIP  
       fecha_lis       
       titulo_det AT 40  
       hora_lis AT 96
       SKIP
       titulo_lst AT 40  
       SKIP(1)
       WITH WIDTH 256 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
       Afiliado.cdg_empresa  COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
       Afiliado.cdg_grupofam  
       Afiliado.nom_afiliado 
       Afiliado.cdg_plan     COLUMN-LABEL "Cod!Plan" FORMAT "X(4)"
       Afiliado.fecha_nac COLUMN-LABEL "Fecha!Cumple" 
       edad               COLUMN-LABEL "Edad!Cumple"
       WITH WIDTH 256 DOWN FRAME frm-listado USE-TEXT STREAM-IO.

FUNCTION cumple RETURN INTEGER ( INPUT que_fecha AS DATE ).

   RETURN p-ano - YEAR(que_fecha).

END.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

FIND Empresa WHERE Empresa.cdg_empresa = p-que_empresa NO-LOCK.
que_empresa = Empresa.nombre.

/*{DIRPRINFILE.I}*/

OUTPUT TO VALUE("C:\SIC-TEMP\lscumpleanos.txt") PAGED.

titulo_lst = "Nacimientos " + STRING(v-desde_cumple,"99/99/99") + " al " + STRING(v-hasta_cumple,"99/99/99").

t-grupos = 0.
t-pesos  = 0.

FOR EACH Afiliado
        WHERE Afiliado.cdg_empresa = p-que_empresa
          AND Afiliado.cdg_estado   <> "B"
          AND MONTH(Afiliado.fecha_nac)   = p-mes
              NO-LOCK WITH FRAME A STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.

    edad = cumple(Afiliado.fecha_nac).

    DISPLAY
            Afiliado.cdg_empresa  
            Afiliado.cdg_grupofam  
            Afiliado.nom_afiliado 
            Afiliado.cdg_plan     
            Afiliado.fecha_nac 
            edad
            WITH FRAME frm-listado.
    DOWN WITH FRAME frm-listado.   
    
    t-grupos = t-grupos + 1.
   
END.       


UNDERLINE
    Afiliado.cdg_empresa  
    Afiliado.cdg_grupofam  
    Afiliado.nom_afiliado 
    Afiliado.cdg_plan     
    Afiliado.fecha_nac 
    edad
    WITH FRAME frm-listado.
DOWN WITH FRAME frm-listado.   
DISPLAY "Total Afiliados" @ Afiliado.nom_afiliado 
        t-grupos          @ Afiliado.cdg_plan     
        WITH FRAME frm-listado.

OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\lscumpleanos.txt",
                 INPUT 2 ).

