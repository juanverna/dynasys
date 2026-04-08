/* =========================================================================== */
/* CONSULTA DE DOCUMENTOS RELACIONADOS A UN PROVEEDOR ESPECIFICO O NO          */
/* PARAMETRO DE SALIDA, APUNTA AL REMITO SELECCIONADO                          */
/* =========================================================================== */

DEFINE INPUT-OUTPUT PARAMETER que_encabezado AS ROWID.
 
{VRSHARED.I }

DEFINE BUTTON btn_elegir  
     LABEL "Elegir":L 
     SIZE 3 BY 1 FONT 4.
     
DEFINE BUTTON btn_salir  
     LABEL "Cancelar":L 
     SIZE 3 BY 1 FONT 4.

DEFINE VARIABLE por_proveedor AS INTEGER LABEL "Por Proveedor"
     VIEW-AS RADIO-SET HORIZONTAL RADIO-BUTTONS "NO",  0 , "SI", 1
     INITIAL 0.

DEFINE VARIABLE dde_fch AS DATE LABEL "Desde Fecha" FGCOLOR fg_c.
DEFINE VARIABLE hta_fch AS DATE LABEL "Hasta Fecha" INITIAL TODAY FGCOLOR fg_c.
DEFINE VARIABLE cli_ant AS ROWID.

DEFINE BUFFER B-Proveedor FOR Proveedor.
DEFINE QUERY qry_documentos FOR {&TABLA-DOC}, B-Proveedor SCROLLING.

DEFINE BROWSE brw_documentos QUERY qry_documentos DISPLAY
      {&TABLA-DOC}.fecha       
      {&TABLA-DOC}.tip_comprob       
      &IF DEFINED(PREFIJO) <> 0
      &THEN
      {&TABLA-DOC}.prf_comprob 
      &ENDIF
      {&TABLA-DOC}.nro_comprob 
      B-Proveedor.nombre /*FORMAT "X(30)"*/
      {&OTROS-CAMPOS}
      WITH NO-UNDERLINE 7 DOWN SEPARATORS
         BGCOLOR 11 FGCOLOR 9 FONT 4
         TITLE BGCOLOR 4 FGCOLOR 14 "{&TITULO-BRW}":L.

/* =========================================================================== */
/*                                  FRAMES                                     */
/* =========================================================================== */

FORM
     por_proveedor             COLON 14                FGCOLOR 0
     SKIP(0.1)
     Proveedor.cdg_proveedor   COLON 14                FGCOLOR 9 BGCOLOR 15
     Proveedor.nombre                  NO-LABEL        FGCOLOR 15 BGCOLOR 8
     SKIP(0.1)
     dde_fch                   COLON 14                FGCOLOR 12 BGCOLOR 14
     hta_fch AT 26                                     FGCOLOR 12 BGCOLOR 14
     SKIP(0.1)
     brw_documentos
     SKIP(0.1)
     btn_elegir AT 1
     SPACE(0)
     btn_salir  
     WITH FRAME frm-sel SIDE-LABELS 
         AT COL 10 ROW 5
         BGCOLOR 8 FGCOLOR 0 FONT 4 THREE-D
         TITLE BGCOLOR 7 FGCOLOR 8 "Seleccion de {&TITULO-BRW}":L
         VIEW-AS DIALOG-BOX.
         
/* =========================================================================== */
/*                                  TRIGGES                                    */
/* =========================================================================== */

ON MOUSE-SELECT-DBLCLICK OF brw_documentos IN FRAME FRM-SEL OR
   RETURN OF brw_documentos IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn_elegir.
END.

ON CHOOSE OF btn_elegir IN FRAME FRM-SEL
DO:
  que_encabezado = ROWID({&TABLA-DOC}).
  APPLY "CHOOSE" TO btn_salir.
END.

ON ENTRY OF Proveedor.cdg_proveedor
DO:
   cli_ant = ROWID(Proveedor).
END.

ON VALUE-CHANGED OF por_proveedor
DO:
   ASSIGN por_proveedor.
   IF por_proveedor = 1 
   THEN DO:
      Proveedor.cdg_proveedor:SENSITIVE = YES.
   END.
   ELSE DO:
      Proveedor.cdg_proveedor:SENSITIVE = NO.
      cli_ant = ?.
   END.
   RUN Act_Browse.
END.

{TRGFECHA.I "dde_fch" "FRM-SEL" "RUN Act_Browse."}
{TRGFECHA.I "hta_fch" "FRM-SEL" "RUN Act_Browse."}


        /* -------------------- Proveedor ------------*/

&SCOPED-DEFINE TABLA            Proveedor
&SCOPED-DEFINE CODIGO           cdg_proveedor
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELPROVE
&SCOPED-DEFINE FRAME-INGRESO    frm-sel
&SCOPED-DEFINE ROWID-TABLA      act_proveedor
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          Act_Browse
&SCOPED-DEFINE ALTA-MODIF       ACTPROVE
&SCOPED-DEFINE ULT_REGISTRO     ult_proveedor
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I}


/* =========================================================================== */
/*                        BLOQUE PRINCIPAL                                     */
/* =========================================================================== */

btn_elegir:WIDTH = FRAME frm-sel:WIDTH / 2 - 1.0.
btn_salir:WIDTH = btn_elegir:WIDTH.
btn_salir:COLUMN = btn_elegir:COLUMN + btn_elegir:WIDTH.

ASSIGN 
  que_encabezado = ?.
  dde_fch = today - ( day(today) - 1).

VIEW FRAME frm-sel.
DISPLAY dde_fch hta_fch WITH FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
ENABLE ALL EXCEPT Proveedor.nombre WITH FRAME frm-sel.
Proveedor.cdg_proveedor:SENSITIVE = NO.
cli_ant = ?.
RUN Act_Browse.
WAIT-FOR CHOOSE OF btn_elegir, btn_salir FOCUS Proveedor.cdg_proveedor.
DISABLE ALL WITH FRAME frm-sel.
HIDE FRAME frm-sel.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").

/* =========================================================================== */
/*                                PROCEDIMIENTOS                               */
/* =========================================================================== */

PROCEDURE Act_Browse:

   ASSIGN FRAME frm-sel
          por_proveedor
          dde_fch
          hta_fch.

   IF por_proveedor = 1
   THEN DO:
    IF NOT AVAILABLE Proveedor THEN RETURN.
    IF cli_ant = ROWID(Proveedor) THEN RETURN.
    OPEN QUERY qry_documentos FOR EACH {&TABLA-DOC} OF Proveedor
                        WHERE {&TABLA-DOC}.fecha >= dde_fch AND
                              {&TABLA-DOC}.fecha <= hta_fch 
                              &IF DEFINED(COND_DOCUMEN)
                              &THEN
                                  AND {&COND_DOCUMEN}
                              &ENDIF    
                                   ,FIRST B-Proveedor OF {&TABLA-DOC}.
   END.
   ELSE DO:
      OPEN QUERY qry_documentos FOR EACH {&TABLA-DOC}
                          WHERE {&TABLA-DOC}.fecha >= dde_fch AND
                                {&TABLA-DOC}.fecha <= hta_fch
                              &IF DEFINED(COND_DOCUMEN)
                              &THEN
                                  AND {&COND_DOCUMEN}
                              &ENDIF    
                                    ,FIRST B-Proveedor OF {&TABLA-DOC}.
   END.

END PROCEDURE.
