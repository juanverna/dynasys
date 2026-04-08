/*------------------------------------------------------------------------------------*/
/* Listados Varios de la tabla Articulo                                                */
/*                                                                                    */
/* Definiciones Globales:                                                             */
/* ----------------------                                                             */
/*                                                                                    */
/* TITULO    : Titulo del Listado                                                     */
/* CAMPOS    : Lista de campos a mostrar                                              */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}

DEFINE VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "&Codigo",  1 , "&Descripcion", 2 INITIAL 1.
DEFINE VARIABLE disp_out  AS CHARACTER LABEL "Dirigido a" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Archivo",  "A", "Impresora", "I" INITIAL "A".
DEFINE VARIABLE procesar  AS CHARACTER LABEL "Proceso" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Local",  "L", "Batch", "B" INITIAL "L".
DEFINE VARIABLE des_codigo LIKE Articulo.cdg_articulo  LABEL "Desde Articulo".
DEFINE VARIABLE has_codigo LIKE Articulo.cdg_articulo  LABEL "Hasta Articulo".
DEFINE VARIABLE des_nombre LIKE Articulo.descripcion.
DEFINE VARIABLE has_nombre LIKE Articulo.descripcion.

DEFINE VARIABLE sel_codigos AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE sel_nombres AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE todos       AS LOGICAL.     
DEFINE VARIABLE j           AS INTEGER.     
DEFINE VARIABLE fecha_lis   AS DATE.     
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(40)" INITIAL "{&TITULO}".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

DEFINE BUTTON btn_elegir
     LABEL "&Estados":L 
     SIZE 10 BY 1 FONT 10.

FORM 
   SKIP(1)
   SPACE(2) ver_por FGCOLOR fg_c
   SKIP(0.5)
   SPACE(2) des_codigo FGCOLOR fe_c BGCOLOR be_c
            des_nombre FGCOLOR fe_c BGCOLOR be_c NO-LABEL SPACE(2)
   SKIP(0.2)
   SPACE(2) has_codigo FGCOLOR fe_c BGCOLOR be_c
            has_nombre FGCOLOR fe_c BGCOLOR be_c NO-LABEL SPACE(2)
   SKIP(0.5)
   SPACE(2) disp_out FGCOLOR fg_c procesar FGCOLOR fg_c
   SKIP(0.5)
   SPACE(4) BTN_PROCESO SPACE(3) BTN_VERDATOS SPACE(3) BTN_IMPRIMIR 
            SPACE(3) BTN_SALIR
   SKIP(0.1) 
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "{&TITULO-FRAME}" FONT 8 THREE-D.
        
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  titulo_lst AT 40
  "Pagina:" AT 120 PAGE-NUMBER FORMAT ">9" AT 128
  SKIP  
  fecha_lis       
  titulo_det AT 40  
  hora_lis AT 120
  SKIP(1)
  WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       {&CAMPOS}
       WITH WIDTH 131 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "{&ARCHIVO-SALIDA}" "port" }

&SCOPED-DEFINE VACIO           ""

/*================================= HELPS DEL RANGO =================================*/

&SCOPED-DEFINE FRAME-INGRESO   frm-rango
&SCOPED-DEFINE EVENTO          U8
&SCOPED-DEFINE TABLA           Articulo
&SCOPED-DEFINE CODIGO          cdg_articulo
&SCOPED-DEFINE NOMBRE          descripcion
&SCOPED-DEFINE VAR-CODIGO      des_codigo
&SCOPED-DEFINE VAR-NOMBRE      des_nombre
&SCOPED-DEFINE RUTINA          SELARTIC
&SCOPED-DEFINE ROWID-TABLA     act_Articulo
&SCOPED-DEFINE INDICE          cdg_articulo
&SCOPED-DEFINE ALFABETICO      alfabetico

{TRIGRANG.I}

&SCOPED-DEFINE FRAME-INGRESO   frm-rango
&SCOPED-DEFINE EVENTO          U9
&SCOPED-DEFINE TABLA           Articulo
&SCOPED-DEFINE CODIGO          cdg_articulo
&SCOPED-DEFINE NOMBRE          descripcion
&SCOPED-DEFINE VAR-CODIGO      has_codigo
&SCOPED-DEFINE VAR-NOMBRE      has_nombre
&SCOPED-DEFINE RUTINA          SELARTIC
&SCOPED-DEFINE ROWID-TABLA     act_Articulo
&SCOPED-DEFINE INDICE          cdg_articulo
&SCOPED-DEFINE ALFABETICO      alfabetico

{TRIGRANG.I}

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
       des_codigo  des_nombre
       has_codigo  has_nombre.
       
  IF NUM-ENTRIES(sel_nombres) = 0 THEN todos = YES.
                                  ELSE todos = NO.
         

  titulo_det = "***".

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  IF disp_out = "A" THEN OUTPUT TO VALUE( dire_tmp + "{&ARCHIVO-SALIDA}") PAGED.
                    ELSE OUTPUT TO VALUE(port) PAGED. 

  {&SETEAR-IMPRESORA}
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codigo
                         AND Articulo.cdg_articulo <= has_codigo
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.descripcion >= des_nombre
                         AND Articulo.descripcion <= has_nombre
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_Articulos.
  DO WHILE AVAILABLE Articulo:
     VIEW FRAME frm-titulo.
     DISPLAY {&CAMPOS}
          WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.          
     GET NEXT qry_Articulos.
  END.
  
  UNDERLINE {&CAMPOS}
       WITH FRAME frm-listado.
  DOWN 1 WITH FRAME frm-listado.          

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  IF disp_out = "A" THEN ENABLE btn_verdatos btn_imprimir
                                WITH FRAME frm-rango.

END.  

{TGPROBAT.I}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "{&TITULO-WINDOW}".
nom_menu = "REPORTES DE ARTICULOS".

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
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

{CODIMPRE.I}
