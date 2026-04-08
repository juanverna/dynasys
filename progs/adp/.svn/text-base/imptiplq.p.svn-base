/*=================================================================================*/
/*                  IMPRESION DE DATOS DE CONCEPTOS DE HABERES                     */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

FORM 
    SKIP(1)
    Tipo_de_liquidac.cdg_liquid 
    Tipo_de_liquidac.descripcion 
    Tipo_de_liquidac.formula_inicial VIEW-AS EDITOR SIZE 65 BY 4
    Tipo_de_liquidac.formula_final   VIEW-AS EDITOR SIZE 65 BY 4
    Tipo_de_liquidac.observacion     VIEW-AS EDITOR SIZE 65 BY 4
    SKIP(0.2)
    WITH CENTERED SIDE-LABELS 1 COLUMN TITLE "Datos del Tipo de Liquidacion" WIDTH 88
         FRAME frm-entidad STREAM-IO.

FIND Tipo_de_liquidac WHERE ROWID(Tipo_de_liquidac) = act_tipliq NO-LOCK.

OUTPUT TO VALUE(dire_tmp + "imptiplq.txt") PAGED.

DISPLAY 
    Tipo_de_liquidac.cdg_liquid 
    Tipo_de_liquidac.descripcion 
    Tipo_de_liquidac.formula_inicial
    Tipo_de_liquidac.formula_final  
    Tipo_de_liquidac.observacion    
    WITH FRAME frm-entidad USE-TEXT STREAM-IO.
    
OUTPUT CLOSE.    

RUN PROPRINT.P ( INPUT dire_tmp + "imptiplq.txt").