/*=================================================================================*/
/*                                                                                 */
/*                            P A R A M E T R O S                                  */
/*                            -------------------                                  */
/*                                                                                 */
/*                     act_registro = ROWID del registro seleccionado              */
/*                     ALT_MOD      = Habilitadas SI o NO las funciones de ALTAS y */
/*                                    modificaciones de registros                  */
/*                                                                                 */
/*  Desde todos los programas se llama a este con parametro ALT_MOD = NO           */
/*  por no poder hacer modal la window de este los demas programas por otro medio  */
/*  que no sea declararlas como DIALOG-BOX, con lo cual su comportamiento modal no */
/*  es dinamico sino estatico y fijado al compilar.                                */
/*                                                                                 */
/*  Respecto del registro accedido, el parametro act_registro se devuelve con el   */
/*  ROWID de la seleccion. Si no la hay, este vuelve con valor ?                   */
/*                                                                                 */
/*=================================================================================*/

DEFINE input-OUTPUT PARAMETER act_registro AS ROWID.
DEFINE INPUT-OUTPUT  PARAMETER ALT-MOD      AS LOGICAL.

/*{VPERSINM.I}*/

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

/*{VRSHARED.I}*/

DEFINE VARIABLE que_item      AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_tecla     AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE des_registro  AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE p_letra       AS INTEGER.
DEFINE VARIABLE que_char      AS INTEGER.
DEFINE VARIABLE ldes          AS INTEGER.
DEFINE VARIABLE ancho         AS INTEGER.
DEFINE VARIABLE alto          AS INTEGER.

DEFINE BUTTON btn_elegir  
     LABEL "&Elegir":L 
     SIZE 2 BY 1 FONT 4.
     
DEFINE BUTTON btn_salir  
     LABEL "&Cancelar":L 
     SIZE 2 BY 1 FONT 4.

     
DEFINE VARIABLE sel_registro AS CHARACTER
     VIEW-AS FILL-IN SIZE 2 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE QUERY brw_registro FOR {&TABLA} FIELD( {&CODIGO} {&NOMBRE} {&OTROS-CAMPOS} ) SCROLLING.

DEFINE BROWSE brw_registro 
       QUERY  brw_registro 
       DISPLAY 
              {&TABLA}.{&CODIGO}
              &IF DEFINED(FORMATO-CODIGO)
              &THEN 
                 FORMAT {&FORMATO-CODIGO}
              &ENDIF    
              {&TABLA}.{&NOMBRE}           
              &IF DEFINED(FORMATO-NOMBRE)
              &THEN 
                 FORMAT {&FORMATO-NOMBRE}
              &ENDIF    
              &IF DEFINED(OTROS-CAMPOS)
              &THEN 
                  {&OTROS-CAMPOS}
              &ENDIF    
       WITH NO-LABELS NO-UNDERLINE 10 DOWN 
              FGCOLOR 9 BGCOLOR 15 FONT 4
              TITLE "{&TITULO-BROWSE}":L.


/*-------------------------------------------------------------------------*/
/*                                F R A M E S                              */
/*-------------------------------------------------------------------------*/

FORM 
     sel_registro      AT ROW 1 COL 1 HELP "{&AYUDA}" NO-LABEL
     brw_registro      AT ROW 2 COL 1 SKIP(0.3)
     btn_elegir SPACE(0)       
     btn_salir SKIP(0.3)        
     WITH 1 DOWN OVERLAY SIDE-LABELS CENTERED THREE-D FRAME frm-sel
          BGCOLOR 8 FGCOLOR 0 /*FONT 4*/ TITLE "{&TITULO-FRAME}"
          VIEW-AS DIALOG-BOX /*WIDTH 45*/.

/*-------------------------------------------------------------------------*/
/*                             T R I G G E R S                             */
/*-------------------------------------------------------------------------*/

ON ANY-KEY OF sel_registro IN FRAME FRM-SEL
DO:

  ldes = LENGTH(des_registro).
  que_char = LASTKEY.
  IF KEYFUNCTION(que_char) = "GO" 
  THEN DO:
    APPLY "RETURN" TO SELF.
    RETURN NO-APPLY.
  END.  
  
  IF KEYFUNCTION(que_char) = "TAB" 
  THEN DO:
     APPLY "TAB" TO SELF.
     RETURN NO-APPLY.
  END.
     
  IF KEYFUNCTION(que_char) = "END-ERROR" 
  THEN DO:
     APPLY "END-ERROR" TO SELF.
     RETURN NO-APPLY.
  END.

  IF que_char = 1091    /* ALT-C */
  THEN DO:
     APPLY "CHOOSE" TO btn_salir IN FRAME FRM-SEL.
     RETURN NO-APPLY.
  END.

  IF que_char = 1093    /* ALT-E */
  THEN DO:
     APPLY "CHOOSE" TO btn_elegir IN FRAME FRM-SEL.
     RETURN NO-APPLY.
  END.

  que_tecla = CAPS(CHR(que_char)).
  p_letra = INDEX("ABCDEFGHIJKLMN¥OPQRSTUVWXYZ0123456789., ",que_tecla).
  
  IF p_letra <> 0
  THEN DO:
    des_registro = des_registro + que_tecla.
    ldes = ldes + 1.
  END.  
  ELSE
    IF KEYFUNCTION(que_char) = "BACKSPACE" 
    THEN DO:
       des_registro = substring(des_registro,1,ldes - 1).
       ldes = ldes - 1.
    END.   
    ELSE DO:
       BELL.
    END.
 
  OPEN QUERY brw_registro
       FOR EACH {&TABLA} 
       WHERE 
           {&TABLA}.{&NOMBRE} BEGINS des_registro 
           &IF DEFINED(CONDICION)
           &THEN 
              AND {&CONDICION}
           &ENDIF
           BY {&TABLA}.{&NOMBRE}.
  sel_registro:SCREEN-VALUE IN FRAME frm-sel = des_registro.
  IF ldes >= 0 THEN
     sel_registro:CURSOR-OFFSET IN FRAME frm-sel = ldes + 1.

  RETURN NO-APPLY.
END.

ON RETURN OF sel_registro OR
   MOUSE-SELECT-DBLCLICK OF brw_registro OR
   RETURN OF brw_registro
   IN FRAME FRM-SEL
DO:
  APPLY "CHOOSE" TO btn_elegir.
END.

ON CHOOSE OF btn_elegir IN FRAME FRM-SEL
DO:
  act_registro = ROWID({&TABLA}).
END.  

ON CHOOSE OF btn_salir IN FRAME FRM-SEL
DO:
  act_registro = ?.
END.  

ON END-ERROR ANYWHERE
DO:
  APPLY "CHOOSE" TO btn_SALIR IN FRAME FRM-SEL.
  RETURN NO-APPLY.
END.  

/*---------------------------------------------------------------------------------*/
/*                      COMIENZA EL BLOQUE PRINCIPAL                               */
/*---------------------------------------------------------------------------------*/

{findempresa.i}

PAUSE 0 BEFORE-HIDE.

ASSIGN 
  sel_registro   = ""
  des_registro   = ""
  act_registro   = ?.
/*
ancho = BROWSE brw_registro:WIDTH.
alto  = FRAME  frm-sel:HEIGHT.
*/

ancho = FRAME frm-sel:WIDTH.
alto  = FRAME frm-sel:HEIGHT.

DO WITH FRAME frm-sel:

   sel_registro:WIDTH  = ancho - 2.0.
   sel_registro:HEIGHT = 1.
   sel_registro:FORMAT = "X(" + STRING(ancho - 2.0) + ")".

   btn_elegir:WIDTH    = TRUNCATE ( ( ancho - 1 ) / 2 , 0).
   btn_salir:WIDTH     = TRUNCATE ( ( ancho - 1 ) / 2 , 0).
   btn_elegir:COLUMN   = 1.
   btn_salir:COLUMN    = FRAME frm-sel:WIDTH  - btn_salir:WIDTH - 0.5.
   btn_elegir:ROW      = FRAME frm-sel:HEIGHT - btn_elegir:HEIGHT - 0.6.
   btn_salir:ROW       = FRAME frm-sel:HEIGHT - btn_salir:HEIGHT - 0.6.

END.

&IF DEFINED(PROCESO_INIT)
&THEN 
 {&PROCESO_INIT}
&ENDIF

VIEW FRAME frm-sel.
OPEN QUERY brw_registro
     FOR EACH {&TABLA} 
     WHERE 
         {&TABLA}.{&NOMBRE} BEGINS des_registro 
         &IF DEFINED(CONDICION)
         &THEN 
            AND {&CONDICION}
         &ENDIF
         BY {&TABLA}.{&NOMBRE}.
         
RUN TOCARSND.P ( INPUT "SOUND\ABREHELP.WAV").
/*
IF ALT-MOD = YES THEN ENABLE ALL WITH FRAME frm-sel.
                 ELSE ENABLE ALL EXCEPT btn_cambios btn_altas WITH FRAME frm-sel.
*/                 
ENABLE ALL WITH FRAME frm-sel.
WAIT-FOR CHOOSE OF btn_elegir, btn_salir IN FRAME frm-sel FOCUS sel_registro.
RUN TOCARSND.P ( INPUT "SOUND\CIERHELP.WAV").
 
