/*=================================================================================*/
/*                  IMPRESION DE DATOS DE CONCEPTOS DE HABERES                     */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

FORM 
    SKIP(1)
    Concepto.cdg_concepto    
    Concepto.descripcion     
    Concepto.abreviatura     
    Concepto.cdg_sumador         
    Concepto.unidad          
    Concepto.haber_retenc 
    Concepto.obligatorio  
    Concepto.salario_fliar
    Concepto.temporario   
    Concepto.cdg_totalizador  LABEL "Totalizador"
    Concepto.formula         VIEW-AS EDITOR SIZE 65 BY 4
    SKIP(0.2)
    WITH CENTERED SIDE-LABELS 1 COLUMN TITLE "Datos del Concepto" WIDTH 88
         FRAME frm-entidad STREAM-IO.

FIND Concepto WHERE ROWID(Concepto) = act_concepto NO-LOCK.

OUTPUT TO VALUE(dire_tmp + "impcncep.txt") PAGED.

DISPLAY 
    Concepto.cdg_concepto
    Concepto.descripcion 
    Concepto.abreviatura 
    Concepto.cdg_sumador                                
    Concepto.unidad                                 
    Concepto.formula
    Concepto.haber_retenc 
    Concepto.obligatorio                            
    Concepto.salario_fliar 
    Concepto.temporario         
    Concepto.cdg_totalizador 
    WITH FRAME frm-entidad USE-TEXT STREAM-IO.
    
OUTPUT CLOSE.    

RUN PROPRINT.P ( INPUT dire_tmp + "impcncep.txt").