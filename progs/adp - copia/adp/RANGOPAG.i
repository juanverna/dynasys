/*------------------------------------------------------------------------------------*/
/* Toma datos de rango para listado de pagos                                          */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}
{DFVRNEMP.I "NEW"}
 
DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".
DEFINE VARIABLE emit_list  AS LOGICAL LABEL "Emitir Listado" VIEW-AS TOGGLE-BOX INITIAL YES. 
DEFINE VARIABLE emit_pago  AS LOGICAL LABEL "Emitir Pagos"   VIEW-AS TOGGLE-BOX INITIAL NO. 
DEFINE VARIABLE unif_pago  AS INTEGER.
DEFINE VARIABLE banco_ant  LIKE Banco.cdg_banco.

DEFINE NEW SHARED VARIABLE sel_codigos AS CHARACTER FORMAT "X(60)".
DEFINE NEW SHARED VARIABLE sel_nombres AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE VARIABLE fecha_pago  AS DATE LABEL "Fecha de Pago".
DEFINE VARIABLE has_fecha   AS DATE LABEL "A Fecha" INITIAL TODAY.

{WGLISTAR.I}

DEFINE BUTTON btn_elegir
     LABEL "&Estados":L 
     SIZE 10 BY 1 FONT 4.

FORM 
   SKIP(1)
   ver_por FGCOLOR fg_c COLON 15
   SPACE(4) BTN_ELEGIR
   SKIP(0.5) SPACE(2)
   sel_codigos NO-LABEL FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.5)
   {SCRRNEMP.I}
   SKIP(0.5)
   has_fecha     COLON 15 
      VIEW-AS FILL-IN 
      SIZE 9 BY .75
      BGCOLOR be_c FGCOLOR fe_c 
   emit_list     FGCOLOR fg_c
   emit_pago     FGCOLOR fg_c   
   SKIP(0.2)
   fecha_pago     COLON 15 
      VIEW-AS FILL-IN 
      SIZE 9 BY .75
      BGCOLOR be_c FGCOLOR fe_c 
   SKIP(0.2)
   disp_out   FGCOLOR fg_c COLON 15
   SKIP(0.2)
   procesar   FGCOLOR fg_c COLON 15
   SKIP(0.5)
   SPACE(4) BTN_PROCESO SPACE(3) BTN_VERDATOS SPACE(3) BTN_IMPRIMIR 
            SPACE(3) BTN_SALIR
   SKIP(0.1) 
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "{&TITULO-FRAME}" FONT 8 THREE-D.
        

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "{&ARCHIVO}.txt" "port" }

{HLPRNEMP.I}

ON VALUE-CHANGED OF ver_por IN FRAME frm-rango
DO:
   ASSIGN ver_por.
   
   IF ver_por = 1 
   THEN DO:  
      DISPLAY " " @ des_nombre
              " " @ has_nombre
              WITH FRAME frm-rango.                      
      DISABLE des_nombre
              has_nombre
              WITH FRAME frm-rango.   
      ENABLE  des_legajo
              has_legajo
              WITH FRAME frm-rango.
   END.
   ELSE DO:
      DISPLAY " " @ des_legajo
              " " @ has_legajo
              WITH FRAME frm-rango.                      
      DISABLE des_legajo
              has_legajo
              WITH FRAME frm-rango.   
      ENABLE  des_nombre
              has_nombre
              WITH FRAME frm-rango.
   END.
              
END.

ON CHOOSE OF btn_proceso
DO:

  ASSIGN
       ver_por 
       emit_list 
       emit_pago 
       fecha_pago
       des_legajo  
       des_nombre
       has_legajo  
       has_nombre
       has_fecha.

  RUN {&ARCHIVO}.P ( INPUT emit_list, 
                     INPUT emit_pago, 
                     INPUT fecha_pago,
                     INPUT has_fecha,   
                     INPUT disp_out).

  IF disp_out = "A" THEN ENABLE btn_verdatos btn_imprimir
                                WITH FRAME frm-rango.

END.  

{TGBTNELG.I}
{TGPROBAT.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Reportes".
nom_menu = "PAGOS".

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

RUN PONER_SESION.

ENABLE ALL /* EXCEPT btn_verdatos btn_imprimir */ WITH FRAME frm-rango.

fecha_pago = TODAY.
APPLY "U8" TO des_legajo IN FRAME frm-rango.
APPLY "U9" TO has_legajo IN FRAME frm-rango.
ver_por = 1.
APPLY "VALUE-CHANGED" TO ver_por IN FRAME frm-rango.

FIND FIRST Estado WHERE Estado.cdg_estado = "AA" NO-LOCK.
sel_nombres = Estado.descripcion.
RUN CVNOMCOD.P ( INPUT sel_nombres, OUTPUT sel_codigos ).

DISPLAY ver_por emit_list emit_pago
        des_legajo
        has_legajo
        des_nombre
        has_nombre
        disp_out
        procesar
        has_fecha
        fecha_pago 
        sel_codigos
        WITH FRAME frm-rango.   

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

