/*=================================================================================*/
/*           TOMA EL RANGO PARA EL LISTADO DE UNA TABLA EN FORMA GENERAL           */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".

{DFVRANGO.I "NEW"}

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

FORM 
   SKIP(1)
   SPACE(2) ver_por FGCOLOR fg_c
   SKIP(0.5)
   {SCRRANGO.I}
   SKIP(0.5)
   SPACE(2) disp_out FGCOLOR fg_c procesar FGCOLOR fg_c
   SKIP(0.5)
   SPACE(4) BTN_PROCESO SPACE(3) BTN_VERDATOS SPACE(3) BTN_IMPRIMIR 
            SPACE(3) BTN_SALIR
   SKIP(0.1) 
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Indique el rango a listar y el ordenamiento del mismo" FONT 8 THREE-D.
        
/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "ls{&ARCHIVO-ID}.txt" "port" }


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
      ENABLE  des_codigo
              has_codigo
              WITH FRAME frm-rango.
   END.
   ELSE DO:
      DISPLAY " " @ des_codigo
              " " @ has_codigo
              WITH FRAME frm-rango.                      
      DISABLE des_codigo
              has_codigo
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
       des_codigo  
       des_nombre
       has_codigo  
       has_nombre.
       
  RUN LS{&ARCHIVO-ID}.P (INPUT disp_out ).

  IF disp_out = "A" THEN ENABLE btn_verdatos btn_imprimir
                                WITH FRAME frm-rango.

END.  

/*================================= HELPS DEL RANGO ===============================*/

&SCOPED-DEFINE FRAME-INGRESO   frm-rango

&SCOPED-DEFINE EVENTO          U8
&SCOPED-DEFINE VAR-CODIGO      des_codigo
&SCOPED-DEFINE VAR-NOMBRE      des_nombre

{TRIGRANG.I}

&SCOPED-DEFINE EVENTO          U9
&SCOPED-DEFINE VAR-CODIGO      has_codigo
&SCOPED-DEFINE VAR-NOMBRE      has_nombre

{TRIGRANG.I}

/*========================== FIN DE LOS HELPS DEL RANGO ============================*/

{TGPROBAT.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "{&TITULO-WINDOW}".
nom_menu = "{&NOMBRE-MENU}".

titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

RUN PONER_SESION.

ENABLE ALL EXCEPT btn_verdatos btn_imprimir WITH FRAME frm-rango.

APPLY "U8" TO des_codigo IN FRAME frm-rango.
APPLY "U9" TO has_codigo IN FRAME frm-rango.
ver_por = 1.
APPLY "VALUE-CHANGED" TO ver_por IN FRAME frm-rango.

DISPLAY ver_por
        des_codigo
        has_codigo
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

