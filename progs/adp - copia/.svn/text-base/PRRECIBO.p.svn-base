/*=================================================================================*/
/*                    I M P R E S I O N   D E   R E C I B O S                      */
/*=================================================================================*/

{VRSHARED.I}

DEFINE VARIABLE lis_h LIKE Rcb_detalle.importe COLUMN-LABEL "Haberes".
DEFINE VARIABLE lis_r LIKE Rcb_detalle.importe COLUMN-LABEL "Retenciones".

FORM
  SKIP (0.2)
  SPACE(2)
  Empleado.nro_legajo    LABEL "Empleado"  FGCOLOR fe_c BGCOLOR be_c
  Empleado.nombre        NO-LABEL          FGCOLOR fg_c BGCOLOR bg_c
  SKIP (0.2)
  SPACE(2)
  Liquidacion.sec_liquidacion              FGCOLOR fe_c BGCOLOR be_c
  Liquidacion.descripcion NO-LABEL         FGCOLOR fg_c BGCOLOR bg_c
  Rcb_header.nro_recibo LABEL "N.Recibo"   FGCOLOR fg_c BGCOLOR bg_c  SPACE(1)
  SKIP (0.2)
  SPACE(2)
  Liquidacion.fecha FGCOLOR fg_c BGCOLOR bg_c  
  Rcb_header.a_pagar   FGCOLOR fg_c BGCOLOR bg_c
  Rcb_header.remunerativo FGCOLOR fg_c BGCOLOR bg_c
  SKIP(2)
  WITH CENTERED AT ROW 1 COL 1 FRAME frm-encabezado FONT 8 
       TITLE "Recibos de Pago" STREAM-IO USE-TEXT
       SIDE-LABELS  FGCOLOR f-fg_c BGCOLOR f-bg_c.
       
FORM 
  Concepto.cdg_concepto 
  Concepto.descripcion
  Rcb_detalle.unidades FORMAT "ZZZZZ"
  lis_h
  lis_r
  WITH DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c STREAM-IO USE-TEXT
       TITLE "Conceptos del recibo de pago" FRAME frm-detalle.            
       
/*=================================================================================*/
/*   C O M I E N Z O   D E   L A   T R A N S A C C I O N   D E   I M P R E S I O N */
/*=================================================================================*/

{SETIMPRE.I}

FIND Rcb_header WHERE ROWID(Rcb_header) = act_rcb_head EXCLUSIVE-LOCK NO-ERROR.
FIND Empleado OF Rcb_header NO-LOCK.
FIND Liquidacion OF Rcb_header NO-LOCK.       

OUTPUT TO VALUE(dire_tmp + "prrecibo.txt") PAGED.

DISPLAY Empleado.nro_legajo
        Empleado.nombre
        Liquidacion.sec_liquidacion
        Liquidacion.descripcion
        Liquidacion.fecha
        Rcb_header.nro_recibo
        Rcb_header.a_pagar
        Rcb_header.remunerativo
        WITH FRAME frm-encabezado.

FOR EACH Rcb_detalle OF Rcb_header, Concepto OF Rcb_detalle:

    IF LOOKUP(Concepto.haber_retenc,"H,R") <> 0
    THEN DO:

         lis_h = Rcb_detalle.importe.
         lis_r = Rcb_detalle.importe.

         DISPLAY Concepto.cdg_concepto 
                 Concepto.descripcion
                 Rcb_detalle.unidades FORMAT "ZZZZZ"
                 lis_h WHEN Concepto.haber_retenc = "H" 
                 lis_r WHEN Concepto.haber_retenc = "R"
                 WITH FRAME frm-detalle.

         DOWN    WITH FRAME frm-detalle.
       
    END.     
  
END.          

OUTPUT CLOSE.

RUN PROPRINT.P ( INPUT dire_tmp + "prrecibo.txt" ).

{CODIMPRE.I}
