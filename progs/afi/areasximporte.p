/*=========================================================================================*/
/*              REALIZA LA EMISION DEL LISTADO DE AREAS POR IMPORTE                        */
/*=========================================================================================*/

DEFINE INPUT PARAMETER p-que_empresa      AS CHARACTER.
DEFINE INPUT PARAMETER p-des_cobrador     LIKE Cobrador.cdg_cobrador.
DEFINE INPUT PARAMETER p-has_cobrador     LIKE Cobrador.cdg_cobrador.

DEFINE INPUT PARAMETER p-des_fecha        AS DATE.
DEFINE INPUT PARAMETER p-has_fecha        AS DATE.

DEFINE INPUT PARAMETER p-des_importe      AS DECIMAL.
DEFINE INPUT PARAMETER p-has_importe      AS DECIMAL.

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

DEFINE VARIABLE v-tipo_compbte            LIKE Grupofam.tipo_compbte FORMAT "X(2)".

DEFINE VARIABLE g-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE g-Grupofames                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE a-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE a-Grupofames                 AS INTEGER FORMAT ">>>>9".
DEFINE VARIABLE t-pesos                   AS DECIMAL FORMAT ">,>>>,>>9.99".
DEFINE VARIABLE t-Grupofames                 AS INTEGER FORMAT ">>>>9".

DEFINE FRAME frm-titulo HEADER
       que_empresa
       "Areas Protegidas por Cobrador e Importe" AT 37
       "Página:" AT 123 PAGE-NUMBER FORMAT ">>9" AT 131
       SKIP  
       fecha_lis       
       titulo_lis AT 37
       hora_lis AT 123
       SKIP
       titulo_det AT 37  
       SKIP(1)
       WITH WIDTH 160 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.
    
FORM
        Grupofam.cdg_empresa    COLUMN-LABEL "Cod!Emp" FORMAT "X(1)"
        Grupofam.cdg_grupofam 
        Grupofam.nom_grupofam 
        Grupofam.fecha_alta     COLUMN-LABEL "Fecha!Alta"
        Grupofam.cdg_plan       COLUMN-LABEL "Código!Plan"
        Grupofam.importe_cuota  FORMAT "->>>,>>9.99"
        WITH WIDTH 160 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

FORM
       t-Grupofames LABEL "Total Grupos"  
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
titulo_lis  = "Altas del " + STRING(p-des_fecha,"99/99/99") + " al " + 
              STRING(p-has_fecha,"99/99/99").
titulo_det  = "Importes de " + STRING(p-des_importe,">,>>>,>>9.99") + " a " + STRING(p-has_importe,">,>>>,>>9.99").
que_archivo = "C:\SIC-TEMP\areasximporte.txt".

OUTPUT TO VALUE(que_archivo) PAGE-SIZE 72.

t-Grupofames = 0.
t-pesos   = 0.

FOR EACH Grupofam NO-LOCK 
    WHERE LOOKUP(Grupofam.cdg_empresa,p-que_empresa,",") <> 0
      AND Grupofam.cdg_cobrador >= p-des_cobrador
      AND Grupofam.cdg_cobrador <= p-has_cobrador
      AND Grupofam.fecha_alta   >= p-des_fecha
      AND Grupofam.fecha_alta   <= p-has_fecha
      AND Grupofam.tipo_grupo = "A"
      AND Grupofam.importe_cuota <= p-has_importe
      AND Grupofam.importe_cuota >= p-des_importe
      AND Grupofam.cdg_estado = "A"
          BREAK BY Grupofam.cdg_empresa 
                BY Grupofam.cdg_grupofam
          WITH FRAME frm-listado STREAM-IO FONT 2 USE-TEXT WIDTH 132:

    VIEW FRAME frm-titulo.

    DISPLAY
        Grupofam.cdg_empresa   WHEN FIRST-OF(Grupofam.cdg_empresa)
        Grupofam.cdg_grupofam 
        Grupofam.nom_grupofam 
        Grupofam.fecha_alta 
        Grupofam.importe_cuota
        Grupofam.cdg_plan
        WITH FRAME frm-listado USE-TEXT STREAM-IO DOWN.
        
    DOWN WITH FRAME frm-listado.
    
    t-pesos   = t-pesos + Grupofam.importe_cuota.
    t-Grupofames = t-Grupofames   + 1.

END.
    
UNDERLINE
    Grupofam.cdg_empresa   
    Grupofam.cdg_grupofam 
    Grupofam.nom_grupofam 
    Grupofam.fecha_alta 
    Grupofam.importe_cuota
    Grupofam.cdg_plan
    WITH FRAME frm-listado.

DOWN WITH FRAME frm-listado.          
  
DISPLAY t-pesos @ Grupofam.importe_cuota
        t-grupofames @ Grupofam.cdg_grupofam  
        WITH FRAME frm-listado.

DOWN WITH FRAME frm-listado.          
  
OUTPUT CLOSE.

RUN VERESULT.W ( INPUT "c:\sic-temp\areasximporte.txt",
                 INPUT 2 ).

/*=========================================================================================*/
/*                           P R O C E D I M I E N T O S                                   */
/*=========================================================================================*/

