/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

/**/
{VRSHARED.I}
{VPERSINM.I}
/**/

DEFINE VARIABLE que_empresa     LIKE Empresa.nombre.
DEFINE VARIABLE que_parametro   LIKE Parametro.cdg_parametro.
DEFINE VARIABLE tipos_validos   AS CHARACTER LABEL "Tipos de formulario".
DEFINE VARIABLE tip_forma       AS CHARACTER LABEL "Tipo de formulario".
DEFINE VARIABLE mensaje         AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE des_forma       AS INTEGER LABEL "Desde Formulario".
DEFINE VARIABLE has_forma       AS INTEGER LABEL "Hasta Formulario".

DEFINE VARIABLE j               AS INTEGER.


DEFINE BUTTON btn_proceso
     LABEL "&Procesar":L
     SIZE 15 BY 1 FONT 6.

DEFINE BUTTON btn_salir
     LABEL "&Salir":L
     SIZE 15 BY 1 FONT 6.

FORM
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE FGCOLOR 14 BGCOLOR 4 "Aguarde un momento por favor"
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 4.

FORM

   pto_venta AT ROW 3.00 COL 30 COLON-ALIGNED
      LABEL "Punto de venta"
      FORMAT "9999"
      VIEW-AS FILL-IN 
      SIZE 12 BY 1
      BGCOLOR 15 FGCOLOR 9 
   
   tip_forma AT ROW 4.50 COL 30 COLON-ALIGNED
      VIEW-AS FILL-IN 
      SIZE 12 BY 1
      BGCOLOR 15 FGCOLOR 9 

   des_forma  AT ROW 6.00 COL 30 COLON-ALIGNED
      FORMAT "99999999"
      VIEW-AS FILL-IN 
      SIZE 12 BY 1
      BGCOLOR 15 FGCOLOR 9 

   has_forma  AT ROW 7.50 COL 30 COLON-ALIGNED
      FORMAT "99999999"
      VIEW-AS FILL-IN 
      SIZE 12 BY 1
      BGCOLOR 15 FGCOLOR 9 

   SKIP(1)
   SPACE(5) BTN_PROCESO  SPACE(20) BTN_SALIR SPACE(5) SKIP(1)
   WITH FRAME frm-rango SIDE-LABELS CENTERED ROW 3 FGCOLOR 0 /*f-fg_c*/ BGCOLOR 8 /*f-bg_c*/
        VIEW-AS DIALOG-BOX THREE-D TITLE "Anulacion de formularios de O/Pago" FONT 6.

/*=================================================================================*/
/*                      T R I G G E R S    D E    U S U A R I O                    */
/*=================================================================================*/

ON RETURN OF tip_forma IN FRAME frm-rango
DO:

  ASSIGN tip_forma.
  tip_forma = CAPS(tip_forma).
  DISPLAY tip_forma WITH FRAME frm-rango.
  tipos_validos = "OP".

  IF LOOKUP(tip_forma,tipos_validos) = 0
  THEN DO:
     RUN PONMENSJ.P (INPUT "ANUL000").
     RETURN NO-APPLY.
  END.

END.


ON CHOOSE OF btn_proceso
DO:

    DO TRANSACTION:
     
        ASSIGN tip_forma pto_venta des_forma has_forma.
        mensaje = "Procesando ...".
        DISPLAY mensaje WITH FRAME frm-espere.
   
        FOR EACH Opg_header 
           WHERE Opg_header.cdg_empresa = Empresa.cdg_empresa
             AND Opg_header.tip_comprob = tip_forma
             AND Opg_header.prf_comprob = pto_venta
             AND Opg_header.nro_comprob >= des_forma
             AND Opg_header.nro_comprob <= has_forma:
       
             FOR EACH Opg_detalle OF Opg_header:
                 DELETE Opg_detalle.
             END.
            
             FIND Caj_header
                 WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion
                       EXCLUSIVE-LOCK.
                
             FOR EACH Caj_detalle OF Caj_header:
                 
                 DELETE Caj_detalle.
              
             END.    
   
             DELETE Caj_header.
                
             DELETE Opg_header.
        
        END.      
   
        FIND Parametro 
             WHERE Parametro.cdg_parametro = "PROXNOPG" 
               AND Parametro.cdg_empresa   = Empresa.cdg_empresa
                   EXCLUSIVE-LOCK.
   
        Parametro.valor_n = des_forma.
   
        RELEASE Parametro.
        PAUSE 0.
        HIDE FRAME frm-espere.
        DISPLAY tip_forma des_forma has_forma
               WITH FRAME frm-rango.
     
        DISABLE BTN_PROCESO WITH FRAME frm-rango.

    END.

END.

ON LEAVE OF pto_venta IN FRAME frm-rango
DO:
   FIND Punto-venta 
        WHERE Punto-venta.cdg_puntovta = INPUT FRAME frm-rango pto_venta
              NO-LOCK NO-ERROR.
   IF AVAILABLE Punto-venta
   THEN DO:
        ASSIGN pto_venta.
   END.
   ELSE DO:
        MESSAGE "No existe el punto de venta indicado!!!" VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
   END.
END.   

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "Retroceder Anulación de Ordenes de Pago".
nom_menu = "CXP".

DISPLAY
       pto_venta tip_forma des_forma has_forma
       WITH FRAME frm-rango.

ENABLE ALL WITH FRAME frm-rango.

WAIT-FOR CHOOSE OF btn_salir.
HIDE FRAME frm-rango NO-PAUSE.
