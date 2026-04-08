/*------------------------------------------------------------------------------------*/
/* Listados Varios de la tabla CLIENTE                                                */
/*                                                                                    */
/* Definiciones Globales:                                                             */
/* ----------------------                                                             */
/*                                                                                    */
/* TITULO    : Titulo del Listado                                                     */
/* POR_LABEL : Label que identifica al corte (por Ejemplo "Provincia")                */
/* POR_TABLA : Nombre de la Tabla del corte (por Ejemplo "Provincia")                 */
/* POR_CAMPO : Nombre del Campo de Corte (por Ejemplo "cdg_provincia")                */
/* CLI_CAMPO : Nombre del Campo de Corte en la Tabla CLIENTES (por si NO igual anter.)*/
/* LISTADO   : Form del cuerpo del Listado                                            */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

{VRSHARED.I}                    
{VPERSINM.I }

{RANGOCLI.I "NEW" }

DEFINE VARIABLE des_campo   LIKE {&POR_TABLA}.{&POR_CAMPO} LABEL "Desde {&POR_LABEL}".
DEFINE VARIABLE has_campo   LIKE {&POR_TABLA}.{&POR_CAMPO} LABEL "Hasta {&POR_LABEL}".

DEFINE VARIABLE pri_campo   LIKE {&POR_TABLA}.{&POR_CAMPO}.
DEFINE VARIABLE ult_campo   LIKE {&POR_TABLA}.{&POR_CAMPO}.

DEFINE VARIABLE fecha_lis AS DATE.
DEFINE VARIABLE hora_lis  AS CHARACTER.
DEFINE VARIABLE ultimo    AS LOGICAL.
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

FORM 
   SKIP(1)
   {SCRNGCLI.I }
   SPACE(2) des_campo COLON 17 FGCOLOR fe_c BGCOLOR be_c 
   SKIP
   SPACE(2) has_campo COLON 17 FGCOLOR fe_c BGCOLOR be_c  
   SKIP(1)
   SPACE(1) BTN_PROCESO SPACE(1) BTN_VERDATOS SPACE(1) BTN_IMPRIMIR 
            SPACE(1) BTN_SALIR SPACE(1)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 2 FGCOLOR f-fg_c BGCOLOR f-bg_c
        TITLE "Listado de Clientes {&TITULO}" FONT 4 THREE-D KEEP-TAB-ORDER.
        
DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Clientes {&TITULO}" AT 52
  "Pagina:" AT 122 PAGE-NUMBER FORMAT ">9" AT 130
  SKIP  
  fecha_lis   
  hora_lis AT 122
  SKIP(1)
  WITH WIDTH 136 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
       {&LISTADO}
       WITH WIDTH 136 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.


/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

{TGRESULT.I "lsclient.txt" port } 

{VERRANGO.I }

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

ON CHOOSE OF btn_proceso
DO:

  ASSIGN
    ver_por
    des_codigo
    has_codigo 
    des_nombre
    has_nombre 
    des_campo
    has_campo.

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO VALUE( dire_tmp + "lsclient.txt" ) PAGED.
 
  IF ver_por = 1
  THEN DO:
     FOR EACH Cliente WHERE Cliente.cdg_cliente  >= des_codigo
                        AND Cliente.cdg_cliente  <= has_codigo
                        AND Cliente.{&CLI_CAMPO} >= des_campo
                        AND Cliente.{&CLI_CAMPO} <= has_campo
                   BREAK BY Cliente.{&CLI_CAMPO} 
                         BY Cliente.cdg_cliente WITH FRAME frm-listado:

        ultimo = LAST-OF(Cliente.{&CLI_CAMPO}).
        RUN LISTAR ( INPUT ultimo ).

     END.
  END.
  ELSE DO:
     FOR EACH Cliente WHERE Cliente.nom_cliente       >= des_nombre
                        AND Cliente.nom_cliente       <= has_nombre
                        AND Cliente.{&CLI_CAMPO} >= des_campo
                        AND Cliente.{&CLI_CAMPO} <= has_campo
                   BREAK BY Cliente.{&CLI_CAMPO} 
                         BY Cliente.nom_cliente WITH FRAME frm-listado:

        ultimo = LAST-OF(Cliente.{&CLI_CAMPO}).
        RUN LISTAR ( INPUT ultimo ).

     END.
  END.
  
  UNDERLINE {&LISTADO}
       WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  DISPLAY ver_por
          des_codigo
          has_codigo
          des_campo
          has_campo
     WITH FRAME frm-rango.   
     
  ENABLE ALL EXCEPT 
          des_codigo 
          has_codigo
          des_nombre
          has_nombre 
          WITH FRAME frm-rango.

END.  

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Listado de Clientes".
nom_menu = "CLIENTES".

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
  
RUN PONER_SESION.

  DISPLAY ver_por
          des_codigo
          has_codigo
          des_campo
          has_campo
     WITH FRAME frm-rango.   
     
  ENABLE ALL EXCEPT 
          des_codigo 
          has_codigo
          des_nombre
          has_nombre 
          WITH FRAME frm-rango.

APPLY "VALUE-CHANGED" TO ver_por IN FRAME frm-rango.   

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE PONER_SESION.

  CURRENT-WINDOW:TITLE   = titulo_w.

END PROCEDURE.


PROCEDURE LISTAR:
  DEFINE INPUT PARAMETER es_ultimo AS LOGICAL.
   
  FIND {&POR_TABLA} WHERE {&POR_TABLA}.{&POR_CAMPO} = Cliente.{&CLI_CAMPO} NO-LOCK NO-ERROR.
         
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
