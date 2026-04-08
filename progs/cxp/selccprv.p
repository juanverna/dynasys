/*===========================================================================================*/
/*          CONSULTA DE FACTURAS EN CTA. CTE. POR RANGO DE FECHAS Y POR UN PROVEEDOR         */
/*          SIN PARAMETRO DE SALIDA, SE BUSCAN LOS REGISTROS SELECTADOS                      */
/*===========================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE ancho         AS INTEGER.
DEFINE VARIABLE alto          AS INTEGER.

DEFINE BUTTON btn_elegir
     LABEL "Elegir":L
     SIZE 10 BY 1 FONT 4.

DEFINE BUTTON btn_salir
     LABEL "Cancelar":L
     SIZE 10 BY 1 FONT 4.

DEFINE QUERY qry-ccte FOR Cta_cte_prv, Imputacion SCROLLING.

DEFINE BROWSE brw_ccte QUERY qry-ccte 
       DISPLAY
           Cta_cte_prv.selectado         COLUMN-LABEL "S"
           Cta_cte_prv.tip_comprob       COLUMN-LABEL "Saldo!Compbte"
           Cta_cte_prv.prf_comprob       COLUMN-LABEL "Pto!Vta"
           Cta_cte_prv.nro_comprob       COLUMN-LABEL "Saldo!Compbte" 
           Cta_cte_prv.nro_vencimiento   FORMAT "9" COLUMN-LABEL "N!V"
           Cta_cte_prv.fecha_emision     COLUMN-LABEL "Fecha!Emision"
           Cta_cte_prv.fecha_vencimiento COLUMN-LABEL "Fecha!Vencmto" 
           Cta_cte_prv.imp_total         COLUMN-LABEL "Importe!Comprobte" FORMAT "->,>>>,>>9.99"
           Cta_cte_prv.credito - Cta_cte_prv.debito COLUMN-LABEL "Saldo!Compbte" FORMAT "->,>>>,>>9.99"
           Cta_cte_prv.imp_programado    COLUMN-LABEL "Importe!Programado" FORMAT "->,>>>,>>9.99"
           Cta_cte_prv.cdg_tiporetgan    COLUMN-LABEL "Ac-!tiv"
           Cta_cte_prv.liberada          COLUMN-LABEL "Lib!do."
           Cta_cte_prv.programada        COLUMN-LABEL "Pro!gr."
           WITH NO-UNDERLINE SIZE 77 BY 9 SEPARATORS
           BGCOLOR b-bg_c FGCOLOR b-fg_c FONT 4 
           TITLE "Documentos Pendientes":L.

/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frm-sel
     SKIP(0.2)
     Proveedor.cdg_proveedor LABEL "Proveedor"  COLON 12 FGCOLOR fe_c BGCOLOR be_c
     Proveedor.nombre NO-LABEL FORMAT "X(30)"            FGCOLOR fg_c BGCOLOR bg_c
     SKIP(0.2)
     Moneda.cdg_moneda   FORMAT "X(6)"          COLON 12 FGCOLOR fe_c BGCOLOR be_c
     Moneda.descripcion NO-LABEL FORMAT "X(30)"          FGCOLOR fg_c BGCOLOR bg_c
     SKIP(0.2)
     brw_ccte
     SKIP(0.5)
     btn_elegir AT 1
     btn_salir  AT 37
     WITH 1 DOWN OVERLAY SIDE-LABELS  THREE-D
         AT COL 7 ROW 4  
         BGCOLOR f-bg_c FGCOLOR f-fg_c FONT 4
         TITLE  "Seleccion de Documentos":L
         VIEW-AS DIALOG-BOX.

/* ************************  Control Triggers  ************************ */

ON MOUSE-SELECT-DBLCLICK OF brw_ccte IN FRAME FRM-SEL OR
   RETURN OF brw_ccte IN FRAME FRM-SEL
DO:
  FIND CURRENT Cta_cte_prv EXCLUSIVE-LOCK.
  Cta_cte_prv.selectado = NOT Cta_cte_prv.selectado.
  DISPLAY Cta_cte_prv.selectado WITH BROWSE brw_ccte.
  FIND CURRENT Cta_cte_prv NO-LOCK.
END.

ON CHOOSE OF btn_salir IN FRAME FRM-SEL
DO:
   FOR EACH Cta_cte_prv OF Proveedor EXCLUSIVE-LOCK WHERE Cta_cte_prv.selectado:
      Cta_cte_prv.selectado = NO.
   END.
END.

/* **************************  Main Block  *************************** */

FIND Moneda  WHERE ROWID(Moneda)  = act_moneda NO-LOCK.
FIND Proveedor WHERE ROWID(Proveedor) = act_proveedor NO-LOCK.

ancho = FRAME frm-sel:WIDTH.
alto  = FRAME frm-sel:HEIGHT.

DO WITH FRAME frm-sel:

    btn_elegir:WIDTH   = TRUNCATE ( ancho / 2 , 0) - 0.5.
    btn_salir:WIDTH    = TRUNCATE ( ancho / 2 , 0) - 0.5.
    btn_elegir:COLUMN  = 1.
    btn_salir:COLUMN   = FRAME frm-sel:WIDTH  - btn_salir:WIDTH - 0.5.
    btn_elegir:ROW     = FRAME frm-sel:HEIGHT - btn_elegir:HEIGHT - 0.3.
    btn_salir:ROW      = btn_elegir:ROW.
    
    brw_ccte:NUM-LOCKED-COLUMNS  = 5.
    
    VIEW FRAME frm-sel.
    RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
    
    DISPLAY Proveedor.cdg_proveedor
            Proveedor.nombre
            Moneda.cdg_moneda
            Moneda.descripcion WITH FRAME frm-sel.
    
    ENABLE brw_ccte btn_elegir btn_salir WITH FRAME frm-sel.
    RUN Act_Browse.
    
    WAIT-FOR CHOOSE OF btn_elegir, btn_salir.
    DISABLE ALL WITH FRAME frm-sel.
    HIDE FRAME frm-sel.
    RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").

END.

PROCEDURE Act_Browse:

   OPEN QUERY qry-ccte
     FOR EACH Cta_cte_prv OF Proveedor
        WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda
          AND Cta_cte_prv.debito <> Cta_cte_prv.credito
          AND NOT Cta_cte_prv.imputado
/*        AND Cta_cte_prv.liberada
          AND Cta_cte_prv.programada */,
         EACH Imputacion OF Cta_cte_prv
           BY fecha_vencimiento.

END PROCEDURE.
