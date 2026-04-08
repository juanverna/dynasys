/*===================================================================================*/
/*            Genera los programas de inicialización de las tablas de SIC            */
/*===================================================================================*/

{DEFMODULS.I}

DEFINE NEW SHARED VARIABLE MENU-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE k           AS INTEGER.
DEFINE VARIABLE n_archs     AS INTEGER.
DEFINE VARIABLE tiempo      AS INTEGER.

DEFINE VARIABLE t_archs     AS INTEGER.
DEFINE VARIABLE t_tiempo    AS INTEGER.

DEFINE VARIABLE fecha       AS DATE.

DEFINE VARIABLE tipo_tabla AS CHARACTER VIEW-AS RADIO-SET VERTICAL 
                                        RADIO-BUTTONS "Transacciones","TX",
                                                      "Maestros","MA",
                                                      "Todas","SY"
                                        LABEL "Inicializar".
                                                      
DEFINE VARIABLE que_salida  AS CHARACTER INITIAL ".\UTL\CREMA.I" LABEL "Salida" FORMAT "X(30)".

DEFINE VARIABLE dir_instal  AS CHARACTER INITIAL ".\" FORMAT "X(30)".
DEFINE VARIABLE x           AS CHARACTER.
DEFINE VARIABLE ext         AS CHARACTER.
DEFINE VARIABLE prg         AS CHARACTER.
DEFINE VARIABLE que_dir     AS CHARACTER.
DEFINE VARIABLE que_archivo AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_camino  AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE que_tipo    AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE sub_desc    AS CHARACTER.
DEFINE VARIABLE sub_mod     AS CHARACTER.
DEFINE VARIABLE linea       AS CHARACTER FORMAT "X(80)".

{VRSHARED.I "NEW"}

DEFINE WORK-TABLE X-Modulo
  FIELD sigla AS CHAR
  FIELD numero AS INTEGER.

FORM
   _File._Desc LABEL "Desc." SKIP
   _FILE._File-Name LABEL "Archivo"
   WITH FRAME aaa SIDE-LABEL STREAM-IO USE-TEXT WIDTH 90.


DEFINE BUTTON BTN_TODOS
     LABEL "&Todos":L 
     SIZE 14 BY 0.9 FONT 6.

FORM   SKIP(0.3) 
       dir_instal LABEL "Instalación" FGCOLOR 0 BGCOLOR 15 
       SKIP
       que_salida  FGCOLOR fe_c BGCOLOR be_c space(3)
       SKIP(0.3)
       accionar 
       SKIP(0.3)
       btn_todos AT ROW 14 COL 30
       tipo_tabla AT ROW 3.5 COL 30 FGCOLOR fg_c NO-LABEL
       SKIP(1)
       WITH FRAME bbb THREE-D  SIDE-LABELS FONT 4
            FGCOLOR 0 BGCOLOR 8  VIEW-AS DIALOG-BOX 
            TITLE "Generar Programa de Inicialización".

ON CHOOSE OF btn_todos IN FRAME bbb
DO:

   DO j = 1 TO {&NT_MODULOS}:
      accionar [ j ] = NOT accionar [ j ].
   END.
   DISPLAY accionar WITH FRAME bbb.
END.      

/*===================================================================================*/
/*                               BLOQUE PRINCIPAL                                    */
/*===================================================================================*/

FIND FIRST Usuario.
act_usuario = ROWID(Usuario).

FIND FIRST EMPRESA.
act_empresa = ROWID(EMPRESA).
/*
RUN CARPARAM.P.
accionar = NO.
*/
CREATE WINDOW MENU-WINDOW ASSIGN

         TITLE              = "Proceso de compilación"
         RESIZE             = YES
         SCROLL-BARS        = NO
         STATUS-AREA        = YES
         MAX-WIDTH-PIXELS   = SESSION:WIDTH-PIXELS
         MAX-HEIGHT-PIXELS  = SESSION:HEIGHT-PIXELS
         WIDTH-PIXELS       = SESSION:WIDTH-PIXELS 
         HEIGHT-PIXELS      = SESSION:HEIGHT-PIXELS - 10
         BGCOLOR            = w-bg_c 
         FGCOLOR            = w-fg_c
         MESSAGE-AREA       = NO
         SENSITIVE          = YES
         THREE-D            = YES
         WINDOW-STATE       = 1
         VISIBLE            = YES.

ASSIGN CURRENT-WINDOW = MENU-WINDOW.         

UPDATE dir_instal
       accionar 
       btn_todos
       tipo_tabla
       que_salida
       WITH FRAME bbb THREE-D 1 COLUMN SIDE-LABELS 
            FGCOLOR 0 BGCOLOR 8  VIEW-AS DIALOG-BOX FONT 4
            TITLE "Generar Programa de Inicializacion".

DO j = 1  to {&NT_MODULOS}:

   CREATE X-Modulo.
   ASSIGN X-Modulo.sigla = directorios [ j ]
          X-Modulo.numero = j.

END.

OUTPUT TO  VALUE(que_salida).
FOR EACH SIC._File WHERE NOT _FILE._File-Name BEGINS "_" AND NOT _FILE._File-Name BEGINS "SY" BY _File._File-name:

    sub_mod  = SUBSTRING(_File._Desc,1,3).
    FIND FIRST X-Modulo WHERE X-Modulo.sigla = sub_mod NO-ERROR.
    IF NOT AVAILABLE X-Modulo 
    THEN DO:
         DISPLAY _File._Desc
                 _FILE._File-Name
                 WITH FRAME aaa.
    END.
    ELSE DO:     
         IF accionar [ X-Modulo.numero ]
         THEN DO:
              sub_desc = SUBSTRING(_File._Desc,5,2).
              CASE tipo_tabla:
                   WHEN "TX" THEN IF sub_desc = "TX" THEN RUN GRABAR_RUN.
                   WHEN "MA" THEN IF LOOKUP(sub_desc,"TX,MA",",") <> 0 THEN RUN GRABAR_RUN.
                   WHEN "SY" THEN RUN GRABAR_RUN.
              END CASE.
         END. 
    END.     
END.

FOR EACH SIC._File WHERE NOT _FILE._File-Name BEGINS "_" BY _File._File-name:

    sub_mod  = SUBSTRING(_File._Desc,1,3).
    FIND FIRST X-Modulo WHERE X-Modulo.sigla = sub_mod NO-ERROR.
    IF NOT AVAILABLE X-Modulo 
    THEN DO:
         DISPLAY _File._Desc
                 _FILE._File-Name
                 WITH FRAME aaa.
    END.
    ELSE DO:     
         IF accionar [ X-Modulo.numero ]
         THEN DO:
              sub_desc = SUBSTRING(_File._Desc,5,2).
              CASE tipo_tabla:
                   WHEN "TX" THEN IF sub_desc = "TX" THEN RUN GRABAR_PROC.
                   WHEN "MA" THEN IF LOOKUP(sub_desc,"TX,MA",",") <> 0 THEN RUN GRABAR_PROC.
                   WHEN "SY" THEN RUN GRABAR_PROC.
              END CASE.
         END.
    END. 
END.    

OUTPUT CLOSE.
     
MESSAGE "Proceso Finalizado"
         VIEW-AS ALERT-BOX MESSAGE.
         
/*=================================================================================*/
/*                                    PROCEDIMIENTOS                               */
/*=================================================================================*/

PROCEDURE GRABAR_RUN:

   linea = "~{" + "RUNCREMA.I " + "~"" + _File._File-name + "~"" + "~}".
   PUT linea SKIP.

END PROCEDURE.   


PROCEDURE GRABAR_PROC:

   linea = "~{" + "DEFPROCD.I " + "~"" + _File._File-name + "~"" + "~}".
   PUT linea SKIP.

END PROCEDURE.   
         
