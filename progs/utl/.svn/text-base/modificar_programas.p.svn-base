/*===================================================================================*/
/*            Edita todos los fuentes de un determinado directorio                   */
/*===================================================================================*/

{DEFMODULS.I}

DEFINE NEW SHARED VARIABLE MENU-WINDOW  AS WIDGET-HANDLE NO-UNDO.
DEFINE VARIABLE rc          AS INTEGER.
DEFINE VARIABLE t_archs     AS INTEGER.
DEFINE VARIABLE t_tiempo    AS INTEGER.
DEFINE VARIABLE tiempo      AS INTEGER.
DEFINE VARIABLE n_archs     AS INTEGER.
DEFINE VARIABLE j           AS INTEGER.
DEFINE VARIABLE x           AS CHARACTER.
DEFINE VARIABLE ext         AS CHARACTER.
DEFINE VARIABLE prg         AS CHARACTER.
DEFINE VARIABLE que_dir     AS CHARACTER.
DEFINE VARIABLE que_camino  AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE que_tipo    AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE que_archivo AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_mensaje AS CHARACTER FORMAT "X(65)".
DEFINE VARIABLE dir_instal  AS CHARACTER INITIAL ".\" FORMAT "X(12)".
DEFINE VARIABLE v-fecha     AS DATE.

DEFINE TEMP-TABLE T-Cambios
    FIELD old_string AS CHARACTER
    FIELD new_string AS CHARACTER.

DEFINE STREAM Compilacion.

DEFINE FRAME aa 
  que_archivo NO-LABEL
  WITH DOWN FONT 8 USE-TEXT.

DEFINE BUTTON BTN_TODOS
     LABEL "&Todos":L 
     SIZE 14 BY 0.9 FONT 4.

FORM   SKIP(0.3) 
       dir_instal LABEL "Instalacion" FGCOLOR 0 BGCOLOR 15
       SKIP(0.3)
       accionar 
       SKIP(0.3)
       btn_todos AT ROW 14 COL 30
       WITH FRAME bbb THREE-D 1 COLUMN SIDE-LABELS KEEP-TAB-ORDER
            FGCOLOR 0 BGCOLOR 8  VIEW-AS DIALOG-BOX FONT 4
            TITLE "Indique directorios a considerar y el reemplazo a efectuar".

ON CHOOSE OF btn_todos IN FRAME bbb
DO:

   DO j = 1 TO {&NT_MODULOS}:
      accionar [ j ] = NOT accionar [ j ].
   END.
   DISPLAY accionar WITH FRAME bbb.
END.      

/*===================================================================================*/
/*                           BLOQUE PRINCIPAL                                        */
/*===================================================================================*/

RUN cargar_tabla_edicion.p ( INPUT "\\milenium\progress\wrk\directorios.txt",
                             OUTPUT TABLE T-cambios).

/*=================================================================================*/
/*                             P A R A M E T R O S                                 */
/*=================================================================================*/

CREATE WINDOW MENU-WINDOW ASSIGN

         TITLE              = "Proceso de modificación"
         RESIZE             = YES
         SCROLL-BARS        = NO
         STATUS-AREA        = YES
         MAX-WIDTH-PIXELS   = SESSION:WIDTH-PIXELS
         MAX-HEIGHT-PIXELS  = SESSION:HEIGHT-PIXELS
         WIDTH-PIXELS       = SESSION:WIDTH-PIXELS 
         HEIGHT-PIXELS      = SESSION:HEIGHT-PIXELS - 10
         BGCOLOR            = ?
         FGCOLOR            = ?
         MESSAGE-AREA       = NO
         SENSITIVE          = YES
         THREE-D            = YES
         WINDOW-STATE       = 1
         VISIBLE            = YES.

ASSIGN CURRENT-WINDOW = MENU-WINDOW.         

UPDATE accionar 
       WITH FRAME bbb.

OUTPUT STREAM Compilacion TO TERMINAL.

DO j = 1  to {&NT_MODULOS} WITH FRAME aa:

  IF accionar [ j ] 
  THEN DO:

     que_dir = dir_instal + directorios [ j ].
     INPUT FROM OS-DIR(que_dir).     
     OUTPUT TO VALUE(que_dir + "\EDICION.LOG").

     n_archs = 0.
     tiempo = TIME.                                                       
     v-fecha = TODAY.
     que_mensaje = "Comienza " + STRING(tiempo,"HH:MM:SS") + " " + STRING(v-fecha).
     REPEAT:
        IMPORT que_archivo que_camino que_tipo.
        IF NUM-ENTRIES(que_archivo,".") > 1
        THEN DO:
           ext = ENTRY(2,que_archivo,".").
           IF  LOOKUP(ext,"P,I,W") <> 0
           THEN DO:

              n_archs = n_archs + 1.

              RUN editar_un_archivo.p ( INPUT que_archivo , 
                                        INPUT TABLE T-Cambios,
                                        OUTPUT rc ).
              PAUSE 0.
              DISPLAY STREAM Compilacion que_camino n_archs WITH FRAME f-log NO-LABEL.

           END.   

        END.
     END.      

     tiempo = TIME - tiempo.     
     que_mensaje = "Termina " + STRING(TIME,"HH:MM:SS") + " (" +
                    STRING(n_archs,"ZZ9") + " archivos " + STRING(tiempo,"HH:MM:SS") +
                    " horas )" .


  END.   

END.
