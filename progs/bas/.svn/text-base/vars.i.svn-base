
/*=================================================================================*/
/*                                   VARIABLES Y FRAMES                            */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_widget AS WIDGET-HANDLE.

DEFINE VARIABLE var_auto-return          AS LOGICAL                    LABEL "AutoReturn".
DEFINE VARIABLE var_auto-zap             AS LOGICAL                    LABEL "AutoZap".
DEFINE VARIABLE var_blank                AS LOGICAL                    LABEL "Secreto".
DEFINE VARIABLE var_label                AS CHARACTER FORMAT "X(25)"   LABEL "Label".
DEFINE VARIABLE var_help                 AS CHARACTER FORMAT "X(35)"   LABEL "Help".
DEFINE VARIABLE var_bgcolor              AS INTEGER   FORMAT "Z9"      LABEL "Color fondo".
DEFINE VARIABLE var_fgcolor              AS INTEGER   FORMAT "Z9"      LABEL "Color escritura".
DEFINE VARIABLE var_font                 AS INTEGER   FORMAT "Z9"      LABEL "Font".
DEFINE VARIABLE var_format               AS CHARACTER                  LABEL "Formato".
DEFINE VARIABLE var_height-pixels        AS INTEGER   FORMAT "ZZ9"     LABEL "Alto".
DEFINE VARIABLE var_width-pixels         AS INTEGER   FORMAT "ZZ9"     LABEL "Ancho".
DEFINE VARIABLE var_x                    AS DECIMAL   FORMAT "ZZZ9.99" LABEL "X".
DEFINE VARIABLE var_y                    AS DECIMAL   FORMAT "ZZZ9.99" LABEL "Y".

DEFINE VARIABLE rec_color                AS CHARACTER.

DEFINE BUTTON btn_grabar
     LABEL "&Grabar":L 
     SIZE 10 BY 0.9 FONT 10.
DEFINE BUTTON btn_salir
     LABEL "&Salir":L 
     SIZE 10 BY 0.9 FONT 10.


DEFINE FRAME frm-atributos

       SKIP(0.2) var_auto-return                       COLON 15 FGCOLOR 4 VIEW-AS TOGGLE-BOX
       SKIP(0.2) var_auto-zap                          COLON 15 FGCOLOR 4 VIEW-AS TOGGLE-BOX
       SKIP(0.2) var_blank                             COLON 15 FGCOLOR 4 VIEW-AS TOGGLE-BOX
       SKIP(0.2) var_label                             COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_help                              COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_bgcolor                           COLON 15 FGCOLOR 4 BGCOLOR 15   
       SKIP(0.2) var_fgcolor                           COLON 15 FGCOLOR 4 BGCOLOR 15
                 rec_color NO-LABEL
       SKIP(0.2) var_font                              COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_format                            COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_height-pixels                     COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_width-pixels                      COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_x                                 COLON 15 FGCOLOR 4 BGCOLOR 15
       SKIP(0.2) var_y                                 COLON 15 FGCOLOR 4 BGCOLOR 15   
       SKIP(0.5) btn_grabar SPACE(30) btn_salir
       
       WITH SIDE-LABELS FONT 8 CENTERED VIEW-AS DIALOG-BOX TITLE "Atributos del elemento seleccionado"
            FRAME frm-atributos FGCOLOR 14 BGCOLOR 7 THREE-D.

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

   ASSIGN
     que_widget:AUTO-RETURN     = var_auto-return
     que_widget:AUTO-ZAP        = var_auto-zap   
     que_widget:BLANK           = var_blank      
     que_widget:LABEL           = var_label      
     que_widget:HELP            = var_help       
     que_widget:BGCOLOR         = var_bgcolor    
     que_widget:FGCOLOR         = var_fgcolor    
     que_widget:FONT            = var_font       
     que_widget:FORMAT          = var_format     
     que_widget:HEIGHT-PIXELS   = var_height-pixels
     que_widget:WIDTH-PIXELS    = var_width-pixels 
     que_widget:X               = var_x            
     que_widget:Y               = var_y.

   APPLY "CHOOSE" TO btn_salir.
   
END.   

/*=================================================================================*/
/*                                    CUERPO PRINCIPAL                             */
/*=================================================================================*/


rec_color:FGCOLOR IN FRAME frm-atributos = var_fgcolor.
rec_color:BGCOLOR IN FRAME frm-atributos = var_bgcolor.
rec_color = "MUESTRA".

ASSIGN
    var_auto-return   = que_widget:AUTO-RETURN    
    var_auto-zap      = que_widget:AUTO-ZAP        
    var_blank         = que_widget:BLANK           
    var_label         = que_widget:LABEL           
    var_help          = que_widget:HELP            
    var_bgcolor       = que_widget:BGCOLOR         
    var_fgcolor       = que_widget:FGCOLOR         
    var_font          = que_widget:FONT            
    var_format        = que_widget:FORMAT          
    var_height-pixels = que_widget:HEIGHT-PIXELS   
    var_width-pixels  = que_widget:WIDTH-PIXELS    
    var_x             = que_widget:X               
    var_y             = que_widget:Y.

   
DISPLAY rec_color WITH FRAME frm-atributos.
ENABLE ALL EXCEPT rec_color WITH FRAME frm-atributos.
WAIT-FOR CHOOSE OF btn_salir IN FRAME frm-atributos.
            