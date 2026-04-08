/*------------------------------------------------------------------------------------*/
/* TOMA EL RANGO DE LA TABLA QUE DEBE LISARSE                                         */
/*                                                                                    */
/* Definiciones Globales:                                                             */
/* ----------------------                                                             */
/*                                                                                    */
/* TITULO    : Titulo del Listado                                                     */
/* CAMPOS    : Lista de campos a mostrar                                              */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".

{DFVRNEMP.I "NEW"}
{DFVARSEL.I "NEW"}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

DEFINE BUTTON btn_elegir
     LABEL "&Estados":L 
     SIZE 10 BY 1 FONT 4.

FORM 
   SKIP(1)
   SPACE(2) ver_por FGCOLOR fg_c
   SPACE(4) BTN_ELEGIR
   SKIP(0.5)
   SPACE(2) sel_codigos NO-LABEL FGCOLOR fe_c BGCOLOR be_c
   SKIP(0.5)
   {SCRRNEMP.I}
   SKIP(0.5)
   SPACE(2) disp_out FGCOLOR fg_c procesar FGCOLOR fg_c
   SKIP(0.5)
   SPACE(4) BTN_PROCESO SPACE(3) BTN_VERDATOS SPACE(3) BTN_IMPRIMIR 
            SPACE(3) BTN_SALIR
   SKIP(0.1) 
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "{&TITULO-FRAME}" FONT 8 THREE-D.
        
/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "{&ARCHIVO-SALIDA}.txt" "port" }


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
       des_legajo  
       des_nombre
       has_legajo  
       has_nombre.
       
  RUN {&ARCHIVO-SALIDA}.P (INPUT disp_out ).

  IF disp_out = "A" THEN ENABLE btn_verdatos btn_imprimir
                                WITH FRAME frm-rango.

END.  

{HLPRNEMP.I}
{TGBTNELG.I}
{TGPROBAT.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "{&TITULO-WINDOW}".
nom_menu = "REPORTES DE EMPLEADOS".

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

/*
rtn_botones:ROW    IN FRAME frm-rango = btn_PROCESO:ROW    IN FRAME frm-rango - 0.1.
rtn_botones:COLUMN IN FRAME frm-rango = btn_PROCESO:COLUMN IN FRAME frm-rango - 1.
*/
RUN PONER_SESION.

ENABLE ALL EXCEPT btn_verdatos btn_imprimir WITH FRAME frm-rango.

APPLY "U8" TO des_legajo IN FRAME frm-rango.
APPLY "U9" TO has_legajo IN FRAME frm-rango.
ver_por = 1.
APPLY "VALUE-CHANGED" TO ver_por IN FRAME frm-rango.

DISPLAY ver_por
        des_legajo
        has_legajo
        des_nombre
        has_nombre
        disp_out
        procesar
        WITH FRAME frm-rango.   

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.

