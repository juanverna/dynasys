/*------------------------------------------------------------------------------------*/
/* Listados Varios de la tabla Empleado                                                */
/*                                                                                    */
/* Definiciones Globales:                                                             */
/* ----------------------                                                             */
/*                                                                                    */
/* TITULO    : Titulo del Listado                                                     */
/* POR_LABEL : Label que identifica al corte (por Ejemplo "Provincia")                */
/* POR_TABLA : Nombre de la Tabla del corte (por Ejemplo "Provincia")                 */
/* POR_CAMPO : Nombre del Campo de Corte (por Ejemplo "cdg_provincia")                */
/* CLI_CAMPO : Nombre del Campo de Corte en la Tabla EmpleadoS (por si NO igual anter.)*/
/* LISTADO   : Form del cuerpo del Listado                                            */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}

DEFINE VARIABLE port AS CHARACTER INITIAL "LPT1".

DEFINE VARIABLE ver_por AS INTEGER LABEL "Ordenado Por" VIEW-AS RADIO-SET 
                HORIZONTAL RADIO-BUTTONS "Codigo",  1 , "Nombre", 0 INITIAL 0.
DEFINE VARIABLE des_empleado AS CHARACTER LABEL "Desde Empleado"
                               FORMAT "X(25)" INITIAL "    ".
DEFINE VARIABLE has_empleado AS CHARACTER LABEL "Hasta Empleado"
                               FORMAT "X(25)" INITIAL "ZZZZZZZZZZ".
DEFINE VARIABLE des_campo   LIKE {&POR_TABLA}.{&POR_CAMPO} LABEL "Desde {&POR_LABEL}".
DEFINE VARIABLE has_campo   LIKE {&POR_TABLA}.{&POR_CAMPO} LABEL "Hasta {&POR_LABEL}".

DEFINE VARIABLE pri_campo   LIKE {&POR_TABLA}.{&POR_CAMPO}.
DEFINE VARIABLE ult_campo   LIKE {&POR_TABLA}.{&POR_CAMPO}.

DEFINE VARIABLE fecha_lis AS DATE.
DEFINE VARIABLE hora_lis  AS CHARACTER.
DEFINE VARIABLE mensaje   AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE mrd       AS INTEGER.
DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE VARIABLE resultados AS CHARACTER 
                VIEW-AS EDITOR LARGE INNER-CHARS 86 INNER-LINES 25 
                        SCROLLBAR-VERTICAL SCROLLBAR-HORIZONTAL.

DEFINE BUTTON btn_proceso
     LABEL "&Procesar":L
     SIZE 10 BY 1.
     
DEFINE BUTTON btn_salir
     LABEL "&Salir":L
     SIZE 10 BY 1.
     
DEFINE BUTTON btn_imprimir
     LABEL "&Imprimir":L
     SIZE 10 BY 1.

DEFINE BUTTON btn_verdatos
     LABEL "&Ver":L
     SIZE 10 BY 1.

DEFINE MENU resultados-menu TITLE "Operaciones con archivo"
   MENU-ITEM Letras  LABEL "&Fonts"
   MENU-ITEM Imprime LABEL "&Imprimir".

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE FGCOLOR 14 BGCOLOR 4 "Aguarde un momento por favor" 
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.

FORM 
   SKIP(1)
   SPACE(2) ver_por FGCOLOR fg_c
   SKIP(1)
   SPACE(2) des_empleado FGCOLOR fg_c
   SKIP
   SPACE(2) has_empleado FGCOLOR fg_c
   SKIP(1)
   SPACE(2) des_campo FGCOLOR fg_c
   SKIP
   SPACE(2) has_campo FGCOLOR fg_c
   SKIP(1)
   SPACE(1) BTN_PROCESO SPACE(1) BTN_VERDATOS SPACE(1) BTN_IMPRIMIR 
            SPACE(1) BTN_SALIR SPACE(1)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Listado de Empleados {&TITULO}" FONT 8.
        
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Empleados {&TITULO}" AT 52
  "Pagina:" AT 122 PAGE-NUMBER FORMAT ">9" AT 130
  SKIP  
  fecha_lis   
  hora_lis AT 122
  SKIP(1)
  WITH WIDTH 136 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
       {&LISTADO}
       WITH WIDTH 136 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

FORM 
   resultados  FONT 8
   WITH FRAME frm-resultados WIDTH 88 NO-LABEL CENTERED 
   TITLE "Haga DOBLE CLICK para salir --- " .

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

ON ESCAPE OF resultados IN FRAME frm-resultados
DO:
   APPLY "MOUSE-SELECT-DBLCLICK" TO resultados IN FRAME frm-resultados.
   RETURN NO-APPLY.
END.

ON CHOOSE OF MENU-ITEM Letras IN MENU resultados-menu
DO:
  RUN QUEFONT.P ( 11 ).
END.     

ON CHOOSE OF MENU-ITEM Imprime IN MENU resultados-menu OR
   CHOOSE OF btn_IMPRIMIR IN FRAME frm-rango
DO:
  RUN PRINFILE.P ( INPUT "lsclient.txt", INPUT port ).
END.  


ON RETURN, TAB OF des_empleado IN FRAME frm-rango
DO:
   ASSIGN des_empleado.
   IF ver_por = 1
   THEN DO:
      mrd = INTEGER(des_empleado) NO-ERROR.
      IF ERROR-STATUS:ERROR = TRUE
      THEN DO:
         BELL.
         ASSIGN des_empleado = "1".
         DISPLAY des_empleado WITH FRAME frm-rango.
         RETURN NO-APPLY.
      END.
   END.
   IF ver_por = 1 AND INTEGER(des_empleado) = 0 THEN des_empleado = "1".
   DISPLAY des_empleado WITH FRAME frm-rango.
   IF ( ver_por = 0 AND des_empleado > has_empleado )
      OR ( ver_por = 1 AND INTEGER(des_empleado) > INTEGER(has_empleado) )
   THEN DO:
      BELL.
      ASSIGN des_empleado = "".
      DISPLAY des_empleado WITH FRAME frm-rango.
      RETURN NO-APPLY.
   END.
END.

ON RETURN, TAB OF has_empleado IN FRAME frm-rango
DO:
   ASSIGN has_empleado.
   IF ver_por = 1
   THEN DO:
      mrd = INTEGER(has_empleado) NO-ERROR.
      IF ERROR-STATUS:ERROR = TRUE
      THEN DO:
         BELL.
         ASSIGN has_empleado = "9999".
         DISPLAY has_empleado WITH FRAME frm-rango.
         RETURN NO-APPLY.
      END.
   END.
   DISPLAY has_empleado WITH FRAME frm-rango.
   IF ( ver_por = 0 AND des_empleado > has_empleado )
      OR ( ver_por = 1 AND INTEGER(des_empleado) > INTEGER(has_empleado) )
   THEN DO:
      BELL.
      ASSIGN has_empleado = "".
      DISPLAY has_empleado WITH FRAME frm-rango.
      RETURN NO-APPLY.
   END.
END.

ON VALUE-CHANGED OF ver_por IN FRAME frm-rango
DO:
   ASSIGN ver_por.

   IF ver_por = 0 THEN ASSIGN des_empleado = ""
                              has_empleado = "ZZZZZZZZZZ".
                  ELSE ASSIGN des_empleado = "1"
                              has_empleado = "9999".

   DISPLAY des_empleado
           has_empleado
           WITH FRAME frm-rango.
END.

ON RETURN, TAB OF des_campo IN FRAME frm-rango
DO:
   ASSIGN des_campo.
   IF des_campo > has_campo
   THEN DO:
      BELL.
      ASSIGN des_campo = pri_campo.
      DISPLAY des_campo WITH FRAME frm-rango.
      RETURN NO-APPLY.
   END.
   DISPLAY des_campo WITH FRAME frm-rango.
END.

ON RETURN, TAB OF has_campo IN FRAME frm-rango
DO:
   ASSIGN has_campo.
   IF has_campo < des_campo
   THEN DO:
      BELL.
      ASSIGN has_campo = ult_campo.
      DISPLAY has_campo WITH FRAME frm-rango.
      RETURN NO-APPLY.
   END.
   DISPLAY has_campo WITH FRAME frm-rango.
END.

ON CHOOSE OF btn_verdatos
DO:
  como_fue = resultados:READ-FILE("lsclient.txt") IN FRAME frm-resultados.
  resultados:FONT = 8.
  IF como_fue
  THEN DO:
     HIDE FRAME frm-rango NO-PAUSE.
     ENABLE ALL WITH FRAME  frm-resultados.
     WAIT-FOR MOUSE-SELECT-DBLCLICK OF resultados 
             IN FRAME frm-resultados FOCUS resultados.
     HIDE FRAME frm-resultados.
     DISPLAY ver_por
             des_empleado  has_empleado
             des_campo    has_campo
             WITH FRAME frm-rango.   
     ENABLE ALL WITH FRAME frm-rango.
  END.
  ELSE DO:
     BELL.
     MESSAGE "No pudo cargarse el archivo" 
        VIEW-AS ALERT-BOX WARNING BUTTONS OK TITLE "Aviso".
  END.
END.   

ON CHOOSE OF btn_proceso
DO:

  ASSIGN
    ver_por
    des_empleado
    has_empleado
    des_campo
    has_campo.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO "lsclient.txt" PAGED.
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.cdg_empleado >= INTEGER(des_empleado)
                        AND Empleado.cdg_empleado <= INTEGER(has_empleado)
                        AND Empleado.{&CLI_CAMPO} >= des_campo
                        AND Empleado.{&CLI_CAMPO} <= has_campo
                   BREAK BY Empleado.{&CLI_CAMPO} 
                         BY Empleado.cdg_empleado WITH FRAME frm-listado:

        ultimo = LAST-OF(Empleado.{&CLI_CAMPO}).
        RUN LISTAR ( INPUT ultimo ).

     END.
  END.
  ELSE DO:
     FOR EACH Empleado WHERE Empleado.nombre >= des_empleado
                        AND Empleado.nombre <= has_empleado
                        AND Empleado.{&CLI_CAMPO} >= des_campo
                        AND Empleado.{&CLI_CAMPO} <= has_campo
                   BREAK BY Empleado.{&CLI_CAMPO} 
                         BY Empleado.nombre WITH FRAME frm-listado:

        ultimo = LAST-OF(Empleado.{&CLI_CAMPO}).
        RUN LISTAR ( INPUT ultimo ).

     END.
  END.
  
  UNDERLINE {&LISTADO}
       WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  DISPLAY ver_por
          des_empleado
          has_empleado
          des_campo
          has_campo
     WITH FRAME frm-rango.   
     
  ENABLE ALL WITH FRAME frm-rango.

END.  

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Empleados".
nom_menu = "EmpleadoS".

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
titulo_w = Empresa.nombre + "   " + nom_menu + " -- " + nom_funcion.
que_empresa = Empresa.nombre.

FIND FIRST {&POR_TABLA} NO-LOCK NO-ERROR.
des_campo = {&POR_TABLA}.{&POR_CAMPO}.

FIND LAST {&POR_TABLA} NO-LOCK NO-ERROR.
has_campo = {&POR_TABLA}.{&POR_CAMPO}.
  
ASSIGN des_campo
       has_campo
       pri_campo = des_campo
       ult_campo = has_campo.  
  
ASSIGN resultados:POPUP-MENU = MENU resultados-menu:HANDLE.

RUN PONER_SESION.

DISPLAY 
    ver_por
    des_empleado
    has_empleado
    des_campo
    has_campo
    WITH FRAME frm-rango.   
    
ENABLE ALL WITH FRAME frm-rango.

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.


PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.


PROCEDURE LISTAR:
  DEFINE INPUT PARAMETER es_ultimo AS LOGICAL.
   
  FIND {&POR_TABLA} WHERE {&POR_TABLA}.{&POR_CAMPO} = Empleado.{&CLI_CAMPO} NO-LOCK NO-ERROR.
         
  VIEW FRAME frm-titulo.
      
  DISPLAY {&LISTADO}
     WITH FRAME frm-listado. 
     
  DOWN WITH FRAME frm-listado.

  IF es_ultimo
  THEN DO:
     UNDERLINE {&LISTADO}
     WITH FRAME frm-listado. 
  END.   

END PROCEDURE.

{CODIMPRE.I}
