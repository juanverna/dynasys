/*=================================================================================*/
/* CREA EL MENU DINAMICO EN BASE A LA DESCRIPCIÓN Y LO ASOCIA A LA CURRENT-WINDOW  */
/*=================================================================================*/

DEFINE INPUT PARAMETER menu_desc   AS CHARACTER      NO-UNDO.
DEFINE INPUT PARAMETER par_handle  AS WIDGET-HANDLE  NO-UNDO.
DEFINE INPUT PARAMETER main_del    AS CHARACTER      NO-UNDO. /* Delimiter char */
DEFINE INPUT PARAMETER detail_del  AS CHARACTER      NO-UNDO. /* Delimiter char */

DEFINE VARIABLE i                  AS INTEGER        NO-UNDO INIT 1.
DEFINE VARIABLE j                  AS INTEGER        NO-UNDO.
DEFINE VARIABLE num_items          AS INTEGER        NO-UNDO.
  
DEFINE VARIABLE next_level         AS INTEGER        NO-UNDO.
DEFINE VARIABLE next_entry         AS CHARACTER      NO-UNDO.
DEFINE VARIABLE next_label         AS CHARACTER      NO-UNDO.
DEFINE VARIABLE main_entry         AS CHARACTER      NO-UNDO.
DEFINE VARIABLE main_label         AS CHARACTER      NO-UNDO.
DEFINE VARIABLE flags              AS CHARACTER      NO-UNDO INIT ",R,S,D,C,U,DC,DU,CD,UD".
DEFINE VARIABLE flag               AS CHARACTER      NO-UNDO.
DEFINE VARIABLE mh                 AS WIDGET-HANDLE  NO-UNDO.
DEFINE VARIABLE mb                 AS WIDGET-HANDLE  NO-UNDO.
DEFINE VARIABLE pgm                AS CHARACTER      NO-UNDO.
DEFINE VARIABLE lbl                AS CHARACTER      NO-UNDO.

/*
message "Menu:" menu_desc SKIP
        "Main Del" main_del SKIP
        "Detail Del:" detail_del SKIP
        VIEW-AS ALERT-BOX MESSAGE TITLE "crear_Treemenu.p".
*/        

num_items = NUM-ENTRIES(menu_desc,main_del).

CREATE MENU mb ASSIGN POPUP-ONLY = (par_handle:type <> "Window").

RUN crear ( INPUT 1, INPUT mb ).

IF par_handle:TYPE = "Window" 
   THEN par_handle:MENU-BAR   = mb.
   ELSE par_handle:POPUP-MENU = mb.

PROCEDURE CREAR:

  DEFINE INPUT PARAMETER level   AS INTEGER       NO-UNDO.
  DEFINE INPUT PARAMETER mparent AS WIDGET-HANDLE NO-UNDO.
  
  REPEAT WHILE i <= num_items:
    ASSIGN main_entry = ENTRY(i, menu_desc , main_del).
    IF NUM-ENTRIES(main_entry,detail_del) <= 1
       THEN main_entry = main_entry + detail_del + "  ".
    IF NUM-ENTRIES(main_entry,detail_del) = 2
       THEN main_entry = main_entry + detail_del + "".
    
    ASSIGN main_label = ENTRY(1, main_entry, detail_del)
           flag       = ENTRY(2,main_entry,detail_del)
           lbl        = TRIM(substr(main_label,level))
           i          = i + 1.

    IF NOT CAN-DO(flags,TRIM(flag)) 
    THEN DO:
      MESSAGE "Bad flags in Menu ENTRY """ +
              main_entry + """. Flag =" flag + "."
              "Should be one of" SUBSTR(flags,2) "or blank."
              VIEW-AS ALERT-BOX MESSAGE BUTTONS OK.
    END.
    IF i <= num_items 
    THEN DO:
      ASSIGN next_entry = ENTRY(i, menu_desc, main_del)
             next_label = ENTRY(1, next_entry, detail_del)
             next_level = 2 + LENGTH(next_label) -
                              LENGTH(trim(next_label + "X","-")).
    END.
    ELSE next_level = level - 1.
    IF next_level = level + 1 
    THEN DO:
      CREATE SUB-MENU mh 
      ASSIGN
          PARENT    = mparent
          LABEL     = lbl
          SENSITIVE = (INDEX(flag,"D") = 0).
      /* message lbl view-as alert-box.*/
      RUN CREAR ( INPUT next_level, INPUT mh).
      IF /*i > num_items or*/ next_level < level THEN RETURN.
    END.
    ELSE DO:
      j = INDEX(flag,"R").
      IF j = 0 THEN j = - INDEX(flag,"S").
      IF j <> 0 THEN DO:
        CREATE menu-item mh 
        ASSIGN
            PARENT    = mparent
            SUBTYPE   = (IF j > 0 THEN "RULE" ELSE "SKIP").
      END.
      ELSE DO:
        IF ENTRY(3,main_entry,detail_del) = "" 
        THEN DO:
          pgm = lbl.
          j = INDEX(pgm,"&").
          IF j > 0 THEN substr(pgm,j,1) = "".
          pgm = LC(pgm).
        END.
        ELSE pgm = ENTRY(3,main_entry,detail_del).
        CREATE menu-item mh 
            ASSIGN
                PARENT     = mparent
                SENSITIVE  = (INDEX(flag,"D") = 0)
                LABEL      = lbl
            TRIGGERS:
              /* on choose persistent run value(pgm). */
              ON CHOOSE PERSISTENT RUN lanzador.p ( INPUT pgm, INPUT CURRENT-WINDOW:HANDLE).
            END.
        j = INDEX(flag,"C").
        IF j = 0 THEN j = - INDEX(flag,"U").
        IF j <> 0 THEN DO:
          ASSIGN mh:TOGGLE-BOX = YES
                 mh:CHECKED    = (j > 0).
        END.
      END.
      IF      next_level = level THEN NEXT.
      ELSE IF next_level < level THEN RETURN.
      ELSE DO:
        MESSAGE "Menu syntax error found in ENTRY """ +
                main_entry + """ or """ + next_entry + """"
                VIEW-AS ALERT-BOX MESSAGE BUTTONS ok.
      END.
    END.
  END.
END.

PROCEDURE CORRIDA: 

   DEFINE INPUT PARAMETER pgm AS CHARACTER.
   DISABLE ALL.
   RUN VALUE(pgm). 
   ENABLE ALL.

END.
