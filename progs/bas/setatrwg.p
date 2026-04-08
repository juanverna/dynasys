
/*=================================================================================*/
/*                                   VARIABLES Y FRAMES                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_widget AS WIDGET-HANDLE.
DEFINE VARIABLE        wig_label  AS WIDGET-HANDLE.

DEFINE VARIABLE var_auto-return          AS LOGICAL                    LABEL "AutoReturn".
DEFINE VARIABLE var_auto-zap             AS LOGICAL                    LABEL "AutoZap".
DEFINE VARIABLE var_blank                AS LOGICAL                    LABEL "Secreto".
DEFINE VARIABLE var_label                AS CHARACTER FORMAT "X(25)"   LABEL "Label".
DEFINE VARIABLE var_help                 AS CHARACTER FORMAT "X(35)"   LABEL "Help".
DEFINE VARIABLE var_bgcolor              AS INTEGER   FORMAT "Z9"      LABEL "Fondo".
DEFINE VARIABLE var_fgcolor              AS INTEGER   FORMAT "Z9"      LABEL "Escritura".
DEFINE VARIABLE var_font                 AS INTEGER   FORMAT "Z9"      LABEL "Font".
DEFINE VARIABLE var_format               AS CHARACTER                  LABEL "Formato".
DEFINE VARIABLE var_height-pixels        AS INTEGER   FORMAT "ZZ9"     LABEL "Alto".
DEFINE VARIABLE var_width-pixels         AS INTEGER   FORMAT "ZZ9"     LABEL "Ancho".
DEFINE VARIABLE var_x                    AS INTEGER   FORMAT "ZZZ9"    LABEL "X".
DEFINE VARIABLE var_y                    AS INTEGER   FORMAT "ZZZ9"    LABEL "Y".

DEFINE VARIABLE rec_color                AS CHARACTER.
DEFINE VARIABLE widget_tipo              AS CHARACTER  LABEL "Tipo".
DEFINE VARIABLE widget_nombre            AS CHARACTER  LABEL "Campo" FORMAT "X(15)".
DEFINE VARIABLE widget_tabla             AS CHARACTER  LABEL "Tabla" FORMAT "X(15)".

DEFINE BUTTON btn_grabar
     LABEL "&Grabar":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON btn_salir
     LABEL "&Salir":L 
     SIZE 10 BY 0.9 FONT 4.


DEFINE FRAME frm-atributos

       SKIP(0.5)             
       SPACE(3)
       widget_tipo            FGCOLOR 4 BGCOLOR 15 SPACE(2)
       widget_tabla           FGCOLOR 4 BGCOLOR 15 SPACE(2)
       widget_nombre          FGCOLOR 4 BGCOLOR 15
       SKIP(0.5) 
       SPACE(7)  var_auto-return                       FGCOLOR 4 VIEW-AS TOGGLE-BOX SPACE(2)
                 var_auto-zap                          FGCOLOR 4 VIEW-AS TOGGLE-BOX SPACE(2)
                 var_blank                             FGCOLOR 4 VIEW-AS TOGGLE-BOX
       SKIP(0.2) var_format                            COLON 10 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_label                             COLON 10 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_help                              COLON 10 FGCOLOR 4 BGCOLOR 15
       SKIP(0.4) SPACE (10) "Colores de pantalla y fuentes"
       SKIP(0.2) var_bgcolor                           COLON 10 FGCOLOR 4 BGCOLOR 15   
                 var_fgcolor                                    FGCOLOR 4 BGCOLOR 15
                 var_font                                       FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) rec_color NO-LABEL                    COLON 10
       SKIP(0.4) SPACE (15) "Posicion y tama¤o"
       SKIP(0.2) var_height-pixels                     COLON 10 FGCOLOR 4 BGCOLOR 15
                 var_x                                 COLON 30 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_width-pixels                      COLON 10 FGCOLOR 4 BGCOLOR 15
                 var_y                                 COLON 30 FGCOLOR 4 BGCOLOR 15   
       SKIP(0.5) btn_grabar SPACE(40) btn_salir
       
       WITH SIDE-LABELS FONT 4 CENTERED VIEW-AS DIALOG-BOX TITLE "Atributos del elemento seleccionado"
            FRAME frm-atributos FGCOLOR 14 BGCOLOR 7 THREE-D KEEP-TAB-ORDER.

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/
            

ON RETURN OF var_fgcolor IN FRAME frm-atributos
DO:            
   ASSIGN var_fgcolor.
   rec_color:FGCOLOR IN FRAME frm-atributos = var_fgcolor.
END.   

ON RETURN OF var_bgcolor IN FRAME frm-atributos
DO:            
   ASSIGN var_bgcolor.
   rec_color:BGCOLOR IN FRAME frm-atributos = var_bgcolor.
END.   

ON RETURN OF var_font IN FRAME frm-atributos
DO:            
   ASSIGN var_font.
   rec_color:FONT IN FRAME frm-atributos = var_font.
END.   

ON CHOOSE OF btn_grabar IN FRAME frm-atributos
DO:

   ASSIGN
     var_auto-return
     var_auto-zap   
     var_blank      
     var_label      
     var_help       
     var_bgcolor    
     var_fgcolor    
     var_font       
     var_format     
     var_height-pixels
     var_width-pixels 
     var_x            
     var_y.

   IF var_x <> que_widget:X OR
      var_y <> que_widget:Y
   THEN DO:   
      IF CAN-QUERY(que_widget,"LABELS")
      THEN DO:
         IF que_widget:LABELS
         THEN DO:
            wig_label = que_widget:SIDE-LABEL-HANDLE. 
            wig_label:Y = var_y.                       
            wig_label:X = var_x - wig_label:WIDTH-PIXELS.
         END.
      END.
   END.  

   IF CAN-SET(que_widget,"X")             THEN que_widget:X               = var_x.
   IF CAN-SET(que_widget,"Y")             THEN que_widget:Y               = var_y.
   IF CAN-SET(que_widget,"AUTO-RETURN")   THEN que_widget:AUTO-RETURN     = var_auto-return.
   IF CAN-SET(que_widget,"AUTO-ZAP")      THEN que_widget:AUTO-ZAP        = var_auto-zap.
   IF CAN-SET(que_widget,"BLANK")         THEN que_widget:BLANK           = var_blank.
   IF CAN-SET(que_widget,"HELP")          THEN que_widget:HELP            = var_help.
   IF CAN-SET(que_widget,"BGCOLOR")       THEN que_widget:BGCOLOR         = var_bgcolor.
   IF CAN-SET(que_widget,"FGCOLOR")       THEN que_widget:FGCOLOR         = var_fgcolor.
   IF CAN-SET(que_widget,"FONT")          THEN que_widget:FONT            = var_font.
   IF CAN-SET(que_widget,"FORMAT")        THEN que_widget:FORMAT          = var_format.
   IF CAN-SET(que_widget,"HEIGHT-PIXELS") THEN que_widget:HEIGHT-PIXELS   = var_height-pixels.
   IF CAN-SET(que_widget,"WIDTH-PIXELS")  THEN que_widget:WIDTH-PIXELS    = var_width-pixels.
   IF CAN-SET(que_widget,"LABEL")
   THEN DO:
      IF CAN-QUERY(que_widget,"LABELS")
      THEN DO:
         IF que_widget:LABELS THEN que_widget:LABEL      = var_label.           
      END.
      ELSE DO:
        que_widget:LABEL      = var_label.      
      END.
   END.     
      
   APPLY "CHOOSE" TO btn_salir.
   
END.   

/*=================================================================================*/
/*                                    CUERPO PRINCIPAL                             */
/*=================================================================================*/



IF CAN-QUERY(que_widget,"AUTO-RETURN")   THEN    var_auto-return   = que_widget:AUTO-RETURN.
IF CAN-QUERY(que_widget,"AUTO-ZAP")      THEN    var_auto-zap      = que_widget:AUTO-ZAP.
IF CAN-QUERY(que_widget,"BLANK")         THEN    var_blank         = que_widget:BLANK.    
IF CAN-QUERY(que_widget,"LABEL")         THEN    var_label         = que_widget:LABEL.
IF CAN-QUERY(que_widget,"HELP")          THEN    var_help          = que_widget:HELP.            
IF CAN-QUERY(que_widget,"BGCOLOR")       THEN    var_bgcolor       = que_widget:BGCOLOR.         
IF CAN-QUERY(que_widget,"FGCOLOR")       THEN    var_fgcolor       = que_widget:FGCOLOR.         
IF CAN-QUERY(que_widget,"FONT")          THEN    var_font          = que_widget:FONT.            
IF CAN-QUERY(que_widget,"FORMAT")        THEN    var_format        = que_widget:FORMAT.          
IF CAN-QUERY(que_widget,"HEIGHT-PIXELS") THEN    var_height-pixels = que_widget:HEIGHT-PIXELS.   
IF CAN-QUERY(que_widget,"WIDTH-PIXELS")  THEN    var_width-pixels  = que_widget:WIDTH-PIXELS.    
IF CAN-QUERY(que_widget,"X")             THEN    var_x             = que_widget:X.               
IF CAN-QUERY(que_widget,"Y")             THEN    var_y             = que_widget:Y.

rec_color:FGCOLOR IN FRAME frm-atributos = var_fgcolor.
rec_color:BGCOLOR IN FRAME frm-atributos = var_bgcolor.
rec_color:FONT    IN FRAME frm-atributos = var_font.
rec_color = "MUESTRA".

IF CAN-QUERY(que_widget,"TYPE")  THEN widget_tipo   = que_widget:TYPE.
IF CAN-QUERY(que_widget,"TABLE") THEN widget_tabla  = que_widget:TABLE.
IF CAN-QUERY(que_widget,"NAME")  THEN widget_nombre = que_widget:NAME.
   
DISPLAY 
     widget_tipo                WHEN CAN-QUERY(que_widget,"TYPE")
     widget_tabla               WHEN CAN-QUERY(que_widget,"TABLE")
     widget_nombre              WHEN CAN-QUERY(que_widget,"NAME")
     var_auto-return            WHEN CAN-QUERY(que_widget,"AUTO-RETURN")
     var_auto-zap               WHEN CAN-QUERY(que_widget,"AUTO-ZAP")
     var_blank                  WHEN CAN-QUERY(que_widget,"BLANK")
     var_label                  WHEN CAN-QUERY(que_widget,"LABEL")
     var_help                   WHEN CAN-QUERY(que_widget,"HELP")
     var_bgcolor                WHEN CAN-QUERY(que_widget,"BGCOLOR")
     var_fgcolor                WHEN CAN-QUERY(que_widget,"FGCOLOR")
     var_font                   WHEN CAN-QUERY(que_widget,"FONT")
     var_format                 WHEN CAN-QUERY(que_widget,"FORMAT")
     var_height-pixels          WHEN CAN-QUERY(que_widget,"HEIGHT-PIXELS")
     var_width-pixels           WHEN CAN-QUERY(que_widget,"WIDTH-PIXELS")
     var_x                      WHEN CAN-QUERY(que_widget,"X")
     var_y                      WHEN CAN-QUERY(que_widget,"Y")
     rec_color 

     WITH FRAME frm-atributos.

ENABLE 
     var_auto-return            WHEN CAN-SET(que_widget,"AUTO-RETURN")
     var_auto-zap               WHEN CAN-SET(que_widget,"AUTO-ZAP")
     var_blank                  WHEN CAN-SET(que_widget,"BLANK")
     var_label                  WHEN CAN-SET(que_widget,"LABEL")
     var_help                   WHEN CAN-SET(que_widget,"HELP")
     var_bgcolor                WHEN CAN-SET(que_widget,"BGCOLOR")
     var_fgcolor                WHEN CAN-SET(que_widget,"FGCOLOR")
     var_font                   WHEN CAN-SET(que_widget,"FONT")
     var_format                 WHEN CAN-SET(que_widget,"FORMAT")
     var_height-pixels          WHEN CAN-SET(que_widget,"HEIGHT-PIXELS")
     var_width-pixels           WHEN CAN-SET(que_widget,"WIDTH-PIXELS")
     var_x                      WHEN CAN-SET(que_widget,"X")
     var_y                      WHEN CAN-SET(que_widget,"Y")
     btn_grabar btn_salir
     WITH FRAME frm-atributos.

WAIT-FOR CHOOSE OF btn_salir IN FRAME frm-atributos.


