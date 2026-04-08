/*-----------------------------------------------------------------------------------------------------*/
/*            Procedimientos para atender la configuracion dinamica de la pantalla                     */
/*-----------------------------------------------------------------------------------------------------*/

PROCEDURE START_MOVER:

  IF CAN-QUERY(SELF,"LABELS")
  THEN DO:
     IF SELF:LABELS
     THEN DO:
        wig_label = SELF:SIDE-LABEL-HANDLE.
        wig_label:VISIBLE = NO.
     END.   
  END.   
  SELF:VISIBLE = NO.

END PROCEDURE.

PROCEDURE END_MOVER:

  FIND FIRST Tabulacion WHERE Tabulacion.tab_handle = SELF:HANDLE.
  Tabulacion.tab_x = SELF:X.
  Tabulacion.tab_y = SELF:Y.  
  IF CAN-QUERY(SELF,"LABELS")
  THEN DO:
     IF SELF:LABELS
     THEN DO:
        wig_label:Y = Tabulacion.tab_y.
        wig_label:X = Tabulacion.tab_x - wig_label:WIDTH-PIXELS.
     END.
  END.
  grupo = SELF:PARENT.
  RUN ARREGLAR_TABULACION.
  SELF:VISIBLE = YES.

END PROCEDURE.

PROCEDURE CARGAR_TABULACION:

   DEFINE VARIABLE pp AS INTEGER.
   DEFINE VARIABLE programa_id AS CHARACTER.

   programa_id = PROGRAM-NAME(1).
   pp = INDEX(programa_id, " ").
   programa_id = SUBSTRING(programa_id,pp + 1).
   pp = INDEX(programa_id,".").                
   programa_id = SUBSTRING(programa_id,1,pp) + "SCR".   
   IF SEARCH(programa_id) <> ? 
   THEN DO:
      INPUT FROM VALUE(programa_id).
      REPEAT:
        CREATE Tabulacion.
        IMPORT Tabulacion EXCEPT tab_handle.
      END.        
      INPUT CLOSE.
   END.   
                    /*-------- FRAME PRINCIPAL ------------*/

   FRAME {&FRAME-PRINCIP}:VISIBLE = NO.
   FRAME {&FRAME-PRINCIP}:GRID-SNAP = YES.
   HIDE FRAME {&FRAME-PRINCIP} NO-PAUSE.

   FIND FIRST Tabulacion 
        WHERE Tabulacion.tab_name = "{&FRAME-PRINCIP}" NO-ERROR.
   IF NOT AVAILABLE Tabulacion
   THEN DO:
         /*   pause message "NO encuentra frame PRINCIPAL en tabulacion. Crea y guarda".  */
      CREATE Tabulacion.                                               
      ASSIGN Tabulacion.tab_name  = "{&FRAME-PRINCIP}".
             Tabulacion.tab_x             = FRAME {&FRAME-PRINCIP}:X.               
             Tabulacion.tab_y             = FRAME {&FRAME-PRINCIP}:Y.           
             Tabulacion.tab_bgcolor       = FRAME {&FRAME-PRINCIP}:BGCOLOR.         
             Tabulacion.tab_fgcolor       = FRAME {&FRAME-PRINCIP}:FGCOLOR.         
             Tabulacion.tab_font          = FRAME {&FRAME-PRINCIP}:FONT.            
             Tabulacion.tab_height-pixels = FRAME {&FRAME-PRINCIP}:HEIGHT-PIXELS.   
             Tabulacion.tab_width-pixels  = FRAME {&FRAME-PRINCIP}:WIDTH-PIXELS.    
   END.
   ELSE DO:      
        /*       pause message "Encuentra frame PRINCIPAL en tabulacion. Asigna atributos".*/
             FRAME {&FRAME-PRINCIP}:X               = Tabulacion.tab_x.
             FRAME {&FRAME-PRINCIP}:Y               = Tabulacion.tab_y.
             FRAME {&FRAME-PRINCIP}:BGCOLOR         = Tabulacion.tab_bgcolor.
             FRAME {&FRAME-PRINCIP}:FGCOLOR         = Tabulacion.tab_fgcolor.
             FRAME {&FRAME-PRINCIP}:FONT            = Tabulacion.tab_font.
             FRAME {&FRAME-PRINCIP}:HEIGHT-PIXELS   = Tabulacion.tab_height-pixels.
             FRAME {&FRAME-PRINCIP}:WIDTH-PIXELS    = Tabulacion.tab_width-pixels.
   END.

   grupo = FRAME {&FRAME-PRINCIP}:FIRST-CHILD.
   RUN CARGAR_GRUPO.

                    /*-------- FRAME OBSERVACIONES ------------*/

   FRAME {&FRAME-OBSERV}:VISIBLE = NO.
   HIDE FRAME {&FRAME-OBSERV} NO-PAUSE.

   FIND FIRST Tabulacion 
        WHERE Tabulacion.tab_name = "{&FRAME-OBSERV}" NO-ERROR.
   IF NOT AVAILABLE Tabulacion
   THEN DO:
      CREATE Tabulacion.                                               
      ASSIGN Tabulacion.tab_name          = "{&FRAME-OBSERV}".
             Tabulacion.tab_x             = FRAME {&FRAME-OBSERV}:X.               
             Tabulacion.tab_y             = FRAME {&FRAME-OBSERV}:Y.           
             Tabulacion.tab_bgcolor       = FRAME {&FRAME-OBSERV}:BGCOLOR.         
             Tabulacion.tab_fgcolor       = FRAME {&FRAME-OBSERV}:FGCOLOR.         
             Tabulacion.tab_font          = FRAME {&FRAME-OBSERV}:FONT.            
             Tabulacion.tab_height-pixels = FRAME {&FRAME-OBSERV}:HEIGHT-PIXELS.   
             Tabulacion.tab_width-pixels  = FRAME {&FRAME-OBSERV}:WIDTH-PIXELS.    
   END.
   ELSE DO:      
         /*  FRAME {&FRAME-OBSERV}:X               = Tabulacion.tab_x.
             FRAME {&FRAME-OBSERV}:Y               = Tabulacion.tab_y.  */
             FRAME {&FRAME-OBSERV}:BGCOLOR         = Tabulacion.tab_bgcolor.
             FRAME {&FRAME-OBSERV}:FGCOLOR         = Tabulacion.tab_fgcolor.
             FRAME {&FRAME-OBSERV}:FONT            = Tabulacion.tab_font.
             FRAME {&FRAME-OBSERV}:HEIGHT-PIXELS   = Tabulacion.tab_height-pixels.
             FRAME {&FRAME-OBSERV}:WIDTH-PIXELS    = Tabulacion.tab_width-pixels.
   END.

   grupo = FRAME {&FRAME-OBSERV}:FIRST-CHILD.
   RUN CARGAR_GRUPO.
   
END PROCEDURE.

PROCEDURE CARGAR_GRUPO:

   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF CAN-SET(proximo,"HIDDEN") THEN proximo:HIDDEN = YES.
      proximo = proximo:NEXT-SIBLING.
   END.      
   
   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF CAN-SET(proximo,"HIDDEN") THEN proximo:HIDDEN = YES.
      IF LOOKUP(proximo:TYPE,widgets_mover) <> 0
      THEN DO:              
         FIND FIRST Tabulacion 
              WHERE Tabulacion.tab_table       = proximo:TABLE
                AND Tabulacion.tab_name        = proximo:NAME 
                AND Tabulacion.tab_frame-name  = proximo:FRAME-NAME NO-ERROR.
         IF NOT AVAILABLE Tabulacion
         THEN DO:
          
            CREATE Tabulacion.                                               
            ASSIGN
                   Tabulacion.tab_table       = proximo:TABLE
                   Tabulacion.tab_name        = proximo:NAME 
                   Tabulacion.tab_frame-name  = proximo:FRAME-NAME
                   Tabulacion.tab_handle      = proximo:HANDLE.

            IF CAN-QUERY(proximo,"X")             THEN  Tabulacion.tab_x             = proximo:X.               
            IF CAN-QUERY(proximo,"Y")             THEN  Tabulacion.tab_y             = proximo:Y.            
            IF CAN-QUERY(proximo,"AUTO-RETURN")   THEN  Tabulacion.tab_auto-return   = proximo:AUTO-RETURN.
            IF CAN-QUERY(proximo,"AUTO-ZAP")      THEN  Tabulacion.tab_auto-zap      = proximo:AUTO-ZAP.
            IF CAN-QUERY(proximo,"BLANK")         THEN  Tabulacion.tab_blank         = proximo:BLANK.
            IF CAN-QUERY(proximo,"LABEL")         THEN  Tabulacion.tab_label         = proximo:LABEL.
            IF CAN-QUERY(proximo,"HELP")          THEN  Tabulacion.tab_help          = proximo:HELP.            
            IF CAN-QUERY(proximo,"BGCOLOR")       THEN  Tabulacion.tab_bgcolor       = proximo:BGCOLOR.         
            IF CAN-QUERY(proximo,"FGCOLOR")       THEN  Tabulacion.tab_fgcolor       = proximo:FGCOLOR.         
            IF CAN-QUERY(proximo,"FONT")          THEN  Tabulacion.tab_font          = proximo:FONT.            
            IF CAN-QUERY(proximo,"FORMAT")        THEN  Tabulacion.tab_format        = proximo:FORMAT.          
            IF CAN-QUERY(proximo,"HEIGHT-PIXELS") THEN  Tabulacion.tab_height-pixels = proximo:HEIGHT-PIXELS.   
            IF CAN-QUERY(proximo,"WIDTH-PIXELS")  THEN  Tabulacion.tab_width-pixels  = proximo:WIDTH-PIXELS.    
         END.
         ELSE DO:      

            Tabulacion.tab_handle = proximo:HANDLE.
            IF CAN-SET(proximo,"X")             THEN proximo:X               = Tabulacion.tab_x.
            IF CAN-SET(proximo,"Y")             THEN proximo:Y               = Tabulacion.tab_y.
            IF CAN-SET(proximo,"AUTO-RETURN")   THEN proximo:AUTO-RETURN     = Tabulacion.tab_auto-return.
            IF CAN-SET(proximo,"AUTO-ZAP")      THEN proximo:AUTO-ZAP        = Tabulacion.tab_auto-zap.
            IF CAN-SET(proximo,"BLANK")         THEN proximo:BLANK           = Tabulacion.tab_blank.
            IF CAN-SET(proximo,"HELP")          THEN proximo:HELP            = Tabulacion.tab_help.
            IF CAN-SET(proximo,"BGCOLOR")       THEN proximo:BGCOLOR         = Tabulacion.tab_bgcolor.
            IF CAN-SET(proximo,"FGCOLOR")       THEN proximo:FGCOLOR         = Tabulacion.tab_fgcolor.
            IF CAN-SET(proximo,"FONT")          THEN proximo:FONT            = Tabulacion.tab_font.
            IF CAN-SET(proximo,"FORMAT")        THEN proximo:FORMAT          = Tabulacion.tab_format.
            IF CAN-SET(proximo,"HEIGHT-PIXELS") THEN proximo:HEIGHT-PIXELS   = Tabulacion.tab_height-pixels.
            IF CAN-SET(proximo,"WIDTH-PIXELS")  THEN proximo:WIDTH-PIXELS    = Tabulacion.tab_width-pixels.
            IF CAN-SET(proximo,"LABEL")
            THEN DO:
               IF CAN-QUERY(proximo,"LABELS")
               THEN DO:
                  IF proximo:LABELS 
                  THEN DO:
                     proximo:LABEL = Tabulacion.tab_label.
                  /* IF CAN-QUERY(proximo,"SIDE-LABEL-HANDLE") */ /* Esta sentencia no anda, 
                                                                     devuelve verdura.       */
                     IF LOOKUP(proximo:TYPE,widgets_side_labels) <> 0
                     THEN DO:
                        IF proximo:SIDE-LABEL-HANDLE <> ?   
                        THEN DO:   
                           wig_label             = proximo:SIDE-LABEL-HANDLE.
                           wig_label:Y           = proximo:Y.
                           wig_label:X           = proximo:X - wig_label:WIDTH-PIXELS.   
                        END.
                     END.
                  END.
               END.
               ELSE DO:      
                  IF proximo:LABEL <> ? THEN proximo:LABEL = Tabulacion.tab_label.   
                  IF LOOKUP(proximo:TYPE,widgets_side_labels) <> 0
                  THEN DO:
                     IF proximo:SIDE-LABEL-HANDLE <> ?   
                     THEN DO:   
                        wig_label             = proximo:SIDE-LABEL-HANDLE.
                        wig_label:Y           = proximo:Y.
                        wig_label:X           = proximo:X - wig_label:WIDTH-PIXELS.   
                     END.
                  END.
               END. 
            END.              
         END.  
      END.
      proximo = proximo:NEXT-SIBLING.
   END.   

   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF CAN-SET(proximo,"HIDDEN") THEN proximo:HIDDEN = NO.
      proximo = proximo:NEXT-SIBLING.
   END.      

END PROCEDURE.

PROCEDURE GRABAR_TABULACION:

   DEFINE VARIABLE pp AS INTEGER.
   DEFINE VARIABLE programa_id AS CHARACTER.

   programa_id = PROGRAM-NAME(1).
   pp = INDEX(programa_id, " ").
   programa_id = SUBSTRING(programa_id,pp + 1).
   pp = INDEX(programa_id,".").
   programa_id = SUBSTRING(programa_id,1,pp) + "SCR".

   grupo = FRAME {&FRAME-PRINCIP}:FIRST-CHILD.
   RUN REFRESCAR_TABULACION.
   grupo = FRAME {&FRAME-OBSERV}:FIRST-CHILD.
   RUN REFRESCAR_TABULACION.

   FIND FIRST Tabulacion 
        WHERE Tabulacion.tab_name = "{&FRAME-PRINCIP}" NO-ERROR.
          Tabulacion.tab_x             = FRAME {&FRAME-PRINCIP}:X.               
          Tabulacion.tab_y             = FRAME {&FRAME-PRINCIP}:Y.           
          Tabulacion.tab_bgcolor       = FRAME {&FRAME-PRINCIP}:BGCOLOR.         
          Tabulacion.tab_fgcolor       = FRAME {&FRAME-PRINCIP}:FGCOLOR.         
          Tabulacion.tab_font          = FRAME {&FRAME-PRINCIP}:FONT.            
          Tabulacion.tab_height-pixels = FRAME {&FRAME-PRINCIP}:HEIGHT-PIXELS.   
          Tabulacion.tab_width-pixels  = FRAME {&FRAME-PRINCIP}:WIDTH-PIXELS.    

   FIND FIRST Tabulacion 
        WHERE Tabulacion.tab_name = "{&FRAME-OBSERV}" NO-ERROR.
          Tabulacion.tab_x             = FRAME {&FRAME-OBSERV}:X.               
          Tabulacion.tab_y             = FRAME {&FRAME-OBSERV}:Y.           
          Tabulacion.tab_bgcolor       = FRAME {&FRAME-OBSERV}:BGCOLOR.         
          Tabulacion.tab_fgcolor       = FRAME {&FRAME-OBSERV}:FGCOLOR.         
          Tabulacion.tab_font          = FRAME {&FRAME-OBSERV}:FONT.            
          Tabulacion.tab_height-pixels = FRAME {&FRAME-OBSERV}:HEIGHT-PIXELS.   
          Tabulacion.tab_width-pixels  = FRAME {&FRAME-OBSERV}:WIDTH-PIXELS.    
   
   OUTPUT TO VALUE(programa_id).
   DO TRANSACTION:
      FOR EACH Tabulacion:
          EXPORT Tabulacion EXCEPT tab_handle.
      END.
   END.   
   OUTPUT CLOSE.    

END PROCEDURE.

PROCEDURE REFRESCAR_TABULACION:

   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF LOOKUP(proximo:TYPE,widgets_mover) <> 0
      THEN DO:
         FIND FIRST Tabulacion WHERE Tabulacion.tab_handle = proximo.
         IF CAN-QUERY(proximo,"AUTO-RETURN")   THEN  Tabulacion.tab_auto-return   = proximo:AUTO-RETURN.
         IF CAN-QUERY(proximo,"AUTO-ZAP")      THEN  Tabulacion.tab_auto-zap      = proximo:AUTO-ZAP.
         IF CAN-QUERY(proximo,"BLANK")         THEN  Tabulacion.tab_blank         = proximo:BLANK.
         IF CAN-QUERY(proximo,"LABEL")         THEN  Tabulacion.tab_label         = proximo:LABEL.
         IF CAN-QUERY(proximo,"HELP")          THEN  Tabulacion.tab_help          = proximo:HELP.           
         IF CAN-QUERY(proximo,"BGCOLOR")       THEN  Tabulacion.tab_bgcolor       = proximo:BGCOLOR.  
         IF CAN-QUERY(proximo,"FGCOLOR")       THEN  Tabulacion.tab_fgcolor       = proximo:FGCOLOR.
         IF CAN-QUERY(proximo,"FONT")          THEN  Tabulacion.tab_font          = proximo:FONT.            
         IF CAN-QUERY(proximo,"FORMAT")        THEN  Tabulacion.tab_format        = proximo:FORMAT.         
         IF CAN-QUERY(proximo,"HEIGHT-PIXELS") THEN  Tabulacion.tab_height-pixels = proximo:HEIGHT-PIXELS.  
         IF CAN-QUERY(proximo,"WIDTH-PIXELS")  THEN  Tabulacion.tab_width-pixels  = proximo:WIDTH-PIXELS.   
         IF CAN-QUERY(proximo,"X")             THEN  Tabulacion.tab_x             = proximo:X.              
         IF CAN-QUERY(proximo,"Y")             THEN  Tabulacion.tab_y             = proximo:Y.            
         IF CAN-QUERY(proximo,"LABELS")
         THEN DO:
            IF proximo:LABELS 
            THEN DO:
               proximo:LABEL         = Tabulacion.tab_label.
               wig_label             = proximo:SIDE-LABEL-HANDLE.
               wig_label:VISIBLE     = YES.
               wig_label:Y           = proximo:Y.
               wig_label:X           = proximo:X - wig_label:WIDTH-PIXELS.
            END. 
         END.              
      END.
      proximo = proximo:NEXT-SIBLING.
   END.            

END PROCEDURE.

PROCEDURE BORRAR_VALORES:

   grupo = FRAME {&FRAME-PRINCIP}:FIRST-CHILD.
   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF LOOKUP(proximo:TYPE,widgets_init) <> 0 
      THEN DO:
        IF CAN-SET(proximo,"SCREEN-VALUE") THEN  proximo:SCREEN-VALUE = " ".
      END.
      proximo = proximo:NEXT-SIBLING.
   END.   

END PROCEDURE.

PROCEDURE ARREGLAR_TABULACION:

    anterior = ?.    
    primero = ?.
    FOR EACH Tabulacion WHERE Tabulacion.tab_frame-name = SELF:FRAME-NAME
                          AND CAN-QUERY(Tabulacion.tab_handle,"MOVE-AFTER-TAB-ITEM") 
                           BY Tabulacion.tab_y BY Tabulacion.tab_x:
        IF primero = ?  
        THEN DO:
              primero = Tabulacion.tab_handle.
              grupo:FIRST-TAB-ITEM = primero.
        END.
        ELSE DO:
              como_fue = Tabulacion.tab_handle:MOVE-AFTER(anterior).
        END.   
        anterior = Tabulacion.tab_handle.
        grupo:LAST-TAB-ITEM = anterior.    

    END.
  
END PROCEDURE.            

PROCEDURE CAMBIAR_MODO:

   IF FRAME {&FRAME-OBSERV}:VISIBLE
   THEN DO:
      FRAME {&FRAME-OBSERV}:TITLE = 
         ( IF modo_configurar THEN FRAME {&FRAME-OBSERV}:TITLE + ":Modo Configuracion"
                              ELSE "{&TITULO-OBS}" ).
      FRAME {&FRAME-OBSERV}:VISIBLE = modo_configurar. /* oculta si sale modo */  
      grupo = FRAME {&FRAME-OBSERV}:FIRST-CHILD.
      RUN CAMBIAR_MODO_FRAME.   
      FRAME {&FRAME-OBSERV}:VISIBLE    = YES.
   /* No pueden cambiarse dinamicamente los atributos de las dialog-box's 
      FRAME {&FRAME-OBSERV}:MOVABLE    = modo_configurar.
      FRAME {&FRAME-OBSERV}:RESIZABLE  = modo_configurar.
      FRAME {&FRAME-OBSERV}:SELECTABLE = modo_configurar. */
   END.
   ELSE DO:
      FRAME {&FRAME-PRINCIP}:GRID-VISIBLE = modo_configurar. /* saca-pone grilla */
      FRAME {&FRAME-PRINCIP}:VISIBLE      = modo_configurar. /* oculta si sale modo */  
      grupo = FRAME {&FRAME-PRINCIP}:FIRST-CHILD.
      RUN CAMBIAR_MODO_FRAME.   
      FRAME {&FRAME-PRINCIP}:MOVABLE    = modo_configurar.
      FRAME {&FRAME-PRINCIP}:RESIZABLE  = modo_configurar.
      FRAME {&FRAME-PRINCIP}:SELECTABLE = modo_configurar.
      FRAME {&FRAME-PRINCIP}:VISIBLE    = YES.
   END.
   
END PROCEDURE.

PROCEDURE CAMBIAR_MODO_FRAME:

   proximo = grupo:FIRST-CHILD.
   DO WHILE proximo <> ?:   
      IF LOOKUP(proximo:TYPE,widgets_mover) <> 0
      THEN DO:
          IF CAN-SET(proximo,"MOVABLE")    THEN proximo:MOVABLE    = modo_configurar.
          IF CAN-SET(proximo,"RESIZABLE")  THEN proximo:RESIZABLE  = modo_configurar.
          IF CAN-SET(proximo,"SELECTABLE") THEN proximo:SELECTABLE = modo_configurar.
          IF modo_configurar
          THEN DO:
             proximo:PRIVATE-DATA = STRING(proximo:SENSITIVE).
             IF CAN-SET(proximo,"SENSITIVE") THEN proximo:SENSITIVE = YES.
          END.   
          ELSE DO:
             IF CAN-SET(proximo,"SENSITIVE") THEN proximo:SENSITIVE = (proximo:PRIVATE-DATA = "YES").
          END.   
      END.
      proximo = proximo:NEXT-SIBLING.
   END.   

END PROCEDURE.