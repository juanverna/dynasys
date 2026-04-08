/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*               DEFINICIONES LOCALES:VARIABLES, FRAMES, Y SUBMENUES               */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "DEFINICIONES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL LABEL "Emitir remito".
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir".

DEFINE NEW SHARED VARIABLE rid_fcomercial AS ROWID.

DEFINE VARIABLE cntrl_deuda    AS LOGICAL.
DEFINE VARIABLE saldo_cc       AS DECIMAL.
DEFINE VARIABLE saldo_ccv      AS DECIMAL.
DEFINE VARIABLE tot_valores    AS DECIMAL.
DEFINE VARIABLE tot_remitos    AS DECIMAL.
DEFINE VARIABLE tot_pedidos    AS DECIMAL.
DEFINE VARIABLE tot_credito    AS DECIMAL.
DEFINE VARIABLE dis_credito    AS DECIMAL.
DEFINE VARIABLE cant_rech      AS INTEGER.

DEFINE VARIABLE cotiza_dolar   AS DECIMAL.
DEFINE VARIABLE codigo_dolar   LIKE Moneda.cdg_moneda.

DEFINE BUFFER B-Rem_detalle_prv FOR Rem_detalle_prv.

DEFINE TEMP-TABLE T-Sub_header_inv   LIKE Sub_header_inv.
DEFINE TEMP-TABLE T-Sub_detalle_inv  LIKE Sub_detalle_inv.

DEFINE VARIABLE ant_proveedor    AS ROWID.
DEFINE VARIABLE v-tip_comprob    LIKE T-Rem_header_prv.tip_comprob.
DEFINE VARIABLE prox_docum       LIKE Parametro.cdg_parametro.

DEFINE BUTTON btn_documentos
     LABEL "&Docmtos.":L 
     SIZE 17 BY 0.9 FONT 4.
              
DEFINE BUTTON btn_embarque
     LABEL "&Embarque":L 
     SIZE 17 BY 0.9 FONT 4.

DEFINE BUTTON btn_bonificacion
     LABEL "&Bonif.":L 
     SIZE 17 BY 0.9 FONT 4.

DEFINE BUTTON btn_copiar
     LABEL "&Copiar":L 
     SIZE 17 BY 0.9 FONT 4.

DEFINE BUTTON btn_facturar
     LABEL "&Facturar":L 
     SIZE 17 BY 0.9 FONT 4.

DEFINE BUTTON btn_ncopias
     LABEL "&N.Copias":L 
     SIZE 17 BY 0.9 FONT 4.

DEFINE RECTANGLE rtn_pantallas
       EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
       SIZE 17.5 BY 5.1.

DEFINE BUTTON btn_baja 
     LABEL "&Anular" 
     SIZE 17 BY 1.12.

DEFINE BUTTON btn_cancel 
     LABEL "&Cancelar" 
     SIZE 17 BY 1.12.

DEFINE BUTTON btn_emitir 
     LABEL "&Emitir" 
     SIZE 17 BY 1.12.

DEFINE BUTTON btn_grabar 
     LABEL "&Grabar" 
     SIZE 17 BY 1.12.

DEFINE BUTTON btn_observ 
     LABEL "&Leyenda" 
     SIZE 17 BY 1.12.

DEFINE BUTTON btn_salir DEFAULT 
     LABEL "&Salir" 
     SIZE 17 BY 1.12
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 17 BY 1.88.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 109 BY 1.62.

DEFINE FRAME frm-documento
     btn_grabar AT ROW 1.81 COL 5
     btn_cancel AT ROW 1.81 COL 23
     btn_baja AT ROW 1.81 COL 41
     btn_observ AT ROW 1.81 COL 59
     btn_emitir AT ROW 1.81 COL 77
     btn_salir AT ROW 1.81 COL 95
     T-Rem_header_prv.tip_comprob AT ROW 3.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     T-Rem_header_prv.prf_comprob AT ROW 3.81 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     T-Rem_header_prv.nro_comprob AT ROW 3.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     T-Rem_header_prv.fecha AT ROW 3.81 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     ver  AT ROW 3.71 COL 97 COLON-ALIGNED
          VIEW-AS RADIO-SET VERTICAL
          SIZE 11 BY 1.32
          NO-LABEL FGCOLOR fg_c
     RECT-1 AT ROW 3.42 COL 95

     Proveedor.cdg_proveedor AT ROW 4.81 COL 14 COLON-ALIGNED
          LABEL "Pro&veedor"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Proveedor.nombre AT ROW 4.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81 
          FGCOLOR fg_c BGCOLOR bg_c 

     Domicilio_prv.nro_domicilio AT ROW 5.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Domicilio_prv.nombre AT ROW 5.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     Condicion_venta.cdg_cndventa AT ROW 6.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Condicion_venta.descripcion AT ROW 6.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     T-Rem_header_prv.cdg_lista AT ROW 7.81 COL 14 COLON-ALIGNED
          LABEL "&Lista"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Lista_Precios.descripcion AT ROW 7.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     Moneda.cdg_moneda AT ROW 8.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Moneda.descripcion AT ROW 8.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     T-Rem_header_prv.cambio AT ROW 9.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     T-Rem_header_prv.cambio_dolar AT ROW 9.81 COL 54 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c

     T-Rem_header_prv.cdg_planta AT ROW 10.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Planta.nombre_planta AT ROW 10.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c

     T-Rem_header_prv.cdg_imputacion AT ROW 11.81 COL 14 COLON-ALIGNED
          LABEL "Imputación"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Imputacion.dsc_imputacion AT ROW 11.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     T-Rem_header_prv.sin_cargo AT ROW 12.81 COL 16
          VIEW-AS TOGGLE-BOX
          SIZE 12 BY .81
          FGCOLOR fe_c
     T-Rem_header_prv.anulado AT ROW 12.81 COL 31
          VIEW-AS TOGGLE-BOX
          SIZE 8 BY .81
          FGCOLOR fe_c
     T-Rem_header_prv.estado AT ROW 12.81 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 3 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     T-Rem_header_prv.conformado AT ROW 12.81 COL 66 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 3 BY .81
          FGCOLOR fe_c BGCOLOR be_c

     Fac_header_prv.tip_comprob AT ROW 13.81 COL 14 COLON-ALIGNED LABEL "Factura"
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Fac_header_prv.prf_comprob AT ROW 13.81 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Fac_header_prv.nro_comprob AT ROW 13.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c

     btn_documentos                   AT COLUMN 1 ROW 1
     btn_embarque                     AT COLUMN 1 ROW 1
     btn_bonificacion                 AT COLUMN 1 ROW 1
     btn_copiar                       AT COLUMN 1 ROW 1
     btn_facturar                     AT COLUMN 1 ROW 1
     rtn_pantallas                    AT COLUMN 1 ROW 1
     RECT-2 AT ROW 1.54 COL 4

    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 114.29 BY 19.15
         FONT 4
         DEFAULT-BUTTON btn_salir.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                           FRAME PRINCIPAL DEL DOCUMENTO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FRAME_PPAL"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                                      MENUES                                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "MENUES"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

DEFINE SUB-MENU Archivo
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE SUB-MENU Devoluciones
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones".

DEFINE SUB-MENU Ctacte
   MENU-ITEM Consultas              LABEL "Co&nsulta de movimientos".

DEFINE NEW SHARED MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Devoluciones           LABEL "&Devoluciones"
   SUB-MENU  Ctacte                 LABEL "&Cta.Cte.".

{TRIGMENU.I "Consultas"    "Devoluciones"  "ABMAEDVP"  "(INPUT 1)" }
{TRIGMENU.I "Consultas"    "Ctacte"       "CNSCCPRO"  "(INPUT 1)"}

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                          TRIGGERS PARTICULARES DEL CASO                         */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "TRIGGERS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

ON RETURN, TAB OF T-Rem_header_prv.nro_comprob IN FRAME frm-documento
DO:

  IF AVAILABLE T-Rem_header_prv AND modo = MD_ALTA
  THEN ASSIGN 
         T-Rem_header_prv.tip_comprob
         T-Rem_header_prv.prf_comprob
         T-Rem_header_prv.nro_comprob.

   IF LOOKUP(INPUT FRAME frm-documento T-Rem_header_prv.tip_comprob, {&TIPOS_VALIDOS}) = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.

   IF modo <> MD_ALTA
   THEN DO:
      RUN BUSCAR_DOCUMENTO.
      IF hay_error THEN RETURN NO-APPLY.
   END.
   ELSE DO:
      IF NOT AVAILABLE Proveedor
      THEN DO:
         RUN PONMENSJ.P (INPUT "RPRV010").
         RETURN NO-APPLY.
      END.
      ELSE DO:
         IF CAN-FIND( FIRST Rem_header_prv 
                            WHERE Rem_header_prv.nro_proveedor = Proveedor.nro_proveedor
                              AND Rem_header_prv.tip_comprob = INPUT T-Rem_header_prv.tip_comprob 
                              AND Rem_header_prv.prf_comprob = INPUT T-Rem_header_prv.prf_comprob
                              AND Rem_header_prv.nro_comprob = INPUT T-Rem_header_prv.nro_comprob
                              AND ROWID(Rem_header_prv) <> act_rpr_head)
         THEN DO:
            RUN PONMENSJ.P (INPUT "DOCS011").
            RETURN NO-APPLY.
         END.
         ELSE DO:
            ASSIGN  T-Rem_header_prv.tip_comprob
                    T-Rem_header_prv.prf_comprob
                    T-Rem_header_prv.nro_comprob.

         END.                

      END.   

   END.

END.               


/*----------------------------- Domicilio_prvs --------------------------------------*/

ON ".", MOUSE-SELECT-DBLCLICK OF Domicilio_prv.nro_domicilio  IN FRAME frm-documento
DO:
  RUN HELP_DOMICILIO.
  RETURN NO-APPLY.
END.   

ON RETURN, TAB OF Domicilio_prv.nro_domicilio  IN FRAME frm-documento
DO:
   
   RUN TRAER_DOMICILIO.
   IF hay_error THEN RETURN NO-APPLY.

END.

/*------------------- FLIP FLOP de Sin Cargo entre N y S -----------------------------------

ON SHIFT-F6 ANYWHERE
DO:
  IF T-Rem_header_prv.sin_cargo:SENSITIVE IN FRAME frm-documento = YES
  THEN DO:
     RUN TOCARSND.P ( INPUT "SOUND\CLICK.WAV").
     T-Rem_header_prv.sin_cargo = NOT T-Rem_header_prv.sin_cargo.
     DISPLAY T-Rem_header_prv.sin_cargo WITH FRAME frm-documento.
  END.
  ELSE DO:
     RUN TOCARSND.P ( INPUT "SOUND\DING.WAV").
  END.     
END.

ON VALUE-CHANGED OF T-Rem_header_prv.sin_cargo IN FRAME frm-documento
DO:
  RUN TOCARSND.P ( INPUT "SOUND\CLICK.WAV").
  ASSIGN T-Rem_header_prv.sin_cargo.
  IF T-Rem_header_prv.sin_cargo
  THEN DO:
     emitir_factura = NO.
  END.
END.

--------------------------------------------------------------------------------*/

ON SHIFT-F7 ANYWHERE
DO:
   RUN VER_FACTURA.
END.                    

ON "-" OF Articulo.cdg_articulo IN FRAME frm-detalle
DO:
  RUN SELFCMER.P ( OUTPUT ult_fcomercial , INPUT YES ).
  IF ult_fcomercial <> ?
  THEN DO:
     rid_fcomercial = ult_fcomercial.
     FIND FComercial WHERE ROWID(FComercial) = ult_fcomercial NO-LOCK.
     FIND Articulo OF Fcomercial NO-LOCK.
     DISPLAY Articulo.cdg_articulo WITH FRAME frm-detalle.
     APPLY "RETURN" TO Articulo.cdg_articulo IN FRAME frm-detalle.
     RETURN NO-APPLY.
  END.
END.

/*=============================  HELPS ===============================================*/

&SCOPED-DEFINE ENTIDAD          T-Rem_header_prv

/*
{HLPCNDIV.I "cdg_condiva"     "frm-documento" "YES" "YES"}  /* Condicion de Iva       */
{HLPPVCIA.I "cdg_provincia"   "frm-documento" "YES" "YES"}  /* Provincia              */
{HLPACTIV.I ""                "frm-documento" "YES" "YES"}  /* Actividad del proveedor*/
{HLPLPREC.I "cdg_lista"       "frm-documento" "YES" "YES"}  /* Lista de precios       */
{HLPPLAZO.I ""                "frm-documento" "YES" "YES"}  /* Plazo de pago          */
*/

{HLPPROVE.I ""                "frm-documento" "YES" "NO" }  /* Proveedores            */
{HLPARTIC.I ""                "frm-detalle"   "NO"  "NO" }  /* Articulos              */
{HLPCNVEN.I ""                "frm-documento" "YES" "YES"}  /* Condicion de venta     */
{HLPMONED.I "cdg_moneda"      "frm-documento" "YES" "YES"}  /* Moneda de un documento */
{HLPPLANT.I "cdg_planta"      "frm-documento" "YES" "YES"}  /* Planta de elaboracion  */
{HLPCONCP.I "cdg_imputacion"  "frm-documento" "YES" "YES"}  /* Imputacion             */

/*===============================  FIN DE LOS HELPS ==================================*/

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCESO DE INICIALIZACION DEL PROGRAMA                     */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

RUN INICIAR_DOCUMENTO.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                       PROCESO A EJECUTAR ANTES DE VALIDAR                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "ANT-VALIDAR"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

            ASSIGN T-Rem_header_prv.conformado.
               
&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCESO A EJECUTAR DESPUES DE VALIDAR                      */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "DES-VALIDAR"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/
       
&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                      PROCEDIMIENTOS PARTICULARES DEL CASO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCEDIMIENTOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

PROCEDURE RESTAR_RENGLON:

END PROCEDURE.

PROCEDURE SUMAR_RENGLON:

END PROCEDURE.

PROCEDURE VALIDAR_DOCUMENTO:

  hubo_error = YES.

  IF ROWID(T-Rem_header_prv) = ?
  THEN DO:
     RUN PONMENSJ.P (INPUT "REMI007").
     RETURN.
  END.

  IF NOT CAN-FIND(FIRST {&TABLA_DETALLE} OF  T-Rem_header_prv)
  THEN DO:
     RUN PONMENSJ.P (INPUT "REMI005").
     RETURN.
  END.

  {IFNOTAVA.I "Proveedor" "REMI010"}
/*  {IFNOTAVA.I "Condicion_impos" "REMI008"}*/

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

  IF T-Rem_header_prv.ultima_linea = 0 THEN RETURN.

  IF AVAILABLE T-Sub_header_inv 
  THEN DO:
     DELETE T-Sub_header_inv.
     FOR EACH T-Sub_detalle_inv:
         DELETE T-Sub_detalle_inv.
     END.    
  END.

  {CALCRPRO.I "T-" }

  IF FRAME frm-detalle:VISIBLE THEN DISPLAY T-Rem_header_prv.imp_total 
                                            WITH FRAME frm-detalle.

END PROCEDURE.

PROCEDURE TRAER_PROVEEDOR:

  IF ROWID(Proveedor) = ant_proveedor
     THEN RETURN.

  RUN PONER_PROVEEDOR.

END PROCEDURE.

PROCEDURE PONER_PROVEEDOR:

  /*
  FIND Provincia OF Proveedor NO-LOCK.
  act_provincia = ROWID(Provincia).
  */

  FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.
  act_cndventa = ROWID(Condicion_venta).
  
  /*
  FIND Lista_precio WHERE Lista_precio.cdg_lista = Proveedor.dfl_lista NO-LOCK.
  act_lista = ROWID(Lista_precio).
  */
  
  FIND Condicion_impos   OF Proveedor NO-LOCK.
  act_condiva = ROWID(Condicion_impos).
  v-tip_comprob = "DV".

/*DISABLE T-Rem_header_prv.cdg_condiva WITH FRAME frm-documento.*/

  ASSIGN
      T-Rem_header_prv.cdg_condiva          = Condicion_impos.cdg_condiva
      T-Rem_header_prv.nro_cndventa         = Condicion_venta.nro_cndventa
  /*  T-Rem_header_prv.cdg_lista            = Lista_precio.cdg_lista */
      T-Rem_header_prv.nro_proveedor          = Proveedor.nro_proveedor
      act_proveedor = ROWID(Proveedor).
  
  /*
  MESSAGE "Falta signar descuentos por proveedor y condicion de venta"
           view-as alert-box message title "Mensaje de desarrollo".
  */
  
  DISPLAY  Proveedor.cdg_proveedor 
           Proveedor.nombre
/*         T-Rem_header_prv.cdg_condiva
           Condicion_impos.texto_iva 
           T-Rem_header_prv.cdg_lista
           Lista_precio.descripcion */
           Condicion_venta.cdg_cndventa
           Condicion_venta.descripcion
           WITH FRAME frm-documento.
           
   ENABLE
        T-Rem_header_prv.tip_comprob
        T-Rem_header_prv.prf_comprob
        T-Rem_header_prv.nro_comprob
        Proveedor.cdg_proveedor
        Condicion_venta.cdg_cndventa
  /*    T-Rem_header_prv.cdg_lista*/
        BTN_GRABAR
        BTN_CANCEL
        WITH FRAME frm-documento.
     
   FIND Domicilio_prv OF Proveedor NO-LOCK NO-ERROR.
   IF AVAILABLE Domicilio_prv
   THEN DO:
      DISPLAY Domicilio_prv.nro_domicilio
              Domicilio_prv.nombre
              WITH FRAME frm-documento.
      DISABLE Domicilio_prv.nro_domicilio WITH FRAME frm-documento.      
      T-Rem_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio.
   END.
   ELSE DO:
      DISPLAY " " @ Domicilio_prv.nro_domicilio WITH FRAME frm-documento.
      ENABLE Domicilio_prv.nro_domicilio WITH FRAME frm-documento.
   END.   

   DISABLE Fac_header_prv.tip_comprob
           Fac_header_prv.prf_comprob
           Fac_header_prv.nro_comprob
           WITH FRAME frm-documento.
      
   RUN CALCULOS.   

   MENU-ITEM Consultas:SENSITIVE IN SUB-MENU Ctacte = YES.

   no_aplicar = YES.
   APPLY "ENTRY" TO T-Rem_header_prv.tip_comprob IN FRAME frm-documento.
   
END PROCEDURE.                      

PROCEDURE HELP_DOMICILIO:

  RUN SELDOMIC.P (INPUT act_proveedor , OUTPUT act_domic).
  IF act_domic <> ?
  THEN DO:
     FIND Domicilio_prv WHERE ROWID(Domicilio_prv) = act_domic NO-LOCK.
     DISPLAY Domicilio_prv.nro_domicilio WITH FRAME frm-documento.
     APPLY "RETURN" TO Domicilio_prv.nro_domicilio IN FRAME frm-documento.
  END.  

END PROCEDURE.

PROCEDURE TRAER_DOMICILIO:

   hay_error = YES.

   FIND Domicilio_prv WHERE 
        Domicilio_prv.nro_domicilio = INPUT FRAME frm-documento Domicilio_prv.nro_domicilio AND 
        Domicilio_prv.nro_proveedor   = Proveedor.nro_proveedor NO-LOCK NO-ERROR. 
        
   IF NOT AVAILABLE Domicilio_prv
   THEN DO:
      RUN PONMENSJ.P (INPUT "FACT006").
      RETURN.
   END.
   ELSE DO:
      RUN PONER_DOMICILIO.
   END.

   hay_error = NO.

END.

PROCEDURE PONER_DOMICILIO:

  T-Rem_header_prv.nro_domicilio = Domicilio_prv.nro_domicilio.
  
  DISPLAY  Domicilio_prv.nombre
           WITH FRAME frm-documento.
  ENABLE   Domicilio_prv.nro_domicilio
           WITH FRAME frm-documento.
           
END PROCEDURE.                      

PROCEDURE ASIGNAR_DETALLE:

     /* 
     FIND FIRST Articulo_precio OF Articulo 
          WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista NO-LOCK NO-ERROR. 
     IF AVAILABLE Articulo_precio THEN Rem_detalle_prv.precio = Articulo_precio.precio.
                                  ELSE Rem_detalle_prv.precio = Articulo.costo.
     */

END PROCEDURE.


PROCEDURE ASIGNAR_CNDVENTA:

   T-Rem_header_prv.nro_cndventa = Condicion_venta.nro_cndventa.
   MESSAGE "Falta asignar las bonificaciones por condicion de venta"
                   VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje de desarrollo".

   RUN CALCULOS.

END PROCEDURE.

PROCEDURE ASIGNAR_IMPUTACION:

   ASSIGN FRAME frm-documento T-Rem_header_prv.cdg_imputacion.
   FIND Cuenta OF Imputacion NO-LOCK.
   T-Rem_header_prv.cta_cte      = Cuenta.cta_cte.

END PROCEDURE.

PROCEDURE ASIGNAR_LISTA:

   FOR EACH B-Rem_detalle_prv OF T-Rem_header_prv, EACH Articulo OF B-Rem_detalle_prv:
       FIND FIRST Articulo_precio OF Articulo 
            WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista NO-LOCK NO-ERROR. 
       IF AVAILABLE Articulo_precio THEN B-Rem_detalle_prv.precio = Articulo_precio.precio.
                                    ELSE B-Rem_detalle_prv.precio = Articulo.costo.
   END.
   
   RUN CALCULOS.
       
END PROCEDURE.

PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.

   IF T-Rem_header_prv.anulado AND T-Rem_header_prv.origen = "A"
   THEN DO:
      RUN PONMENSJ.P (INPUT "REMI017").
      RETURN.
   END.   

   FIND Proveedor            OF T-Rem_header_prv NO-LOCK NO-ERROR.
   FIND Condicion_venta      OF T-Rem_header_prv NO-LOCK.
   FIND Moneda               OF T-Rem_header_prv NO-LOCK.
   FIND Planta               OF T-Rem_header_prv NO-LOCK NO-ERROR.
   FIND Deposito             OF T-Rem_header_prv NO-LOCK NO-ERROR.
   FIND Imputacion           OF T-Rem_header_prv NO-LOCK.
   FIND Condicion_impos      OF T-Rem_header_prv NO-LOCK.
   act_condiva = ROWID(Condicion_impos).
   v-tip_comprob = "DV".
   
   FIND FIRST Domicilio_prv OF Proveedor 
        WHERE Domicilio_prv.nro_domicilio = T-Rem_header_prv.nro_domicilio NO-LOCK.
        
   IF T-Rem_header_prv.nro_facprov <> 0
      THEN FIND FIRST Fac_header_prv WHERE Fac_header_prv.nro_facprov = T-Rem_header_prv.nro_facprov NO-LOCK.

   DISPLAY
        T-Rem_header_prv.tip_comprob 
        T-Rem_header_prv.prf_comprob
        T-Rem_header_prv.nro_comprob 
        T-Rem_header_prv.fecha 
        T-Rem_header_prv.estado
        T-Rem_header_prv.anulado
        T-Rem_header_prv.conformado
        Proveedor.cdg_proveedor           WHEN AVAILABLE Proveedor
        Proveedor.nombre                WHEN AVAILABLE Proveedor
        Domicilio_prv.nro_domicilio       WHEN AVAILABLE Domicilio_prv
        Domicilio_prv.nombre              WHEN AVAILABLE Domicilio_prv
        Condicion_venta.cdg_cndventa
        Condicion_venta.descripcion
        Moneda.cdg_moneda
        Moneda.descripcion
        T-Rem_header_prv.cambio
        T-Rem_header_prv.cambio_dolar
        T-Rem_header_prv.cdg_imputacion     WHEN AVAILABLE Imputacion
        Imputacion.dsc_imputacion           WHEN AVAILABLE Imputacion
        T-Rem_header_prv.sin_cargo
        Fac_header_prv.tip_comprob          WHEN T-Rem_header_prv.nro_facprov <> 0
        Fac_header_prv.prf_comprob          WHEN T-Rem_header_prv.nro_facprov <> 0
        Fac_header_prv.nro_comprob          WHEN T-Rem_header_prv.nro_facprov <> 0
        WITH FRAME frm-documento.

   IF LOOKUP(T-Rem_header_prv.estado,"E,P,A") = 0
   THEN ENABLE T-Rem_header_prv.fecha
               Proveedor.cdg_proveedor           WHEN modo <> MD_GENERADO
               Condicion_venta.cdg_cndventa 
               Moneda.cdg_moneda         WHEN modo <> MD_GENERADO
               T-Rem_header_prv.cambio             WHEN modo <> MD_GENERADO  
               T-Rem_header_prv.cambio_dolar       WHEN modo <> MD_GENERADO
               T-Rem_header_prv.conformado         WHEN NOT T-Rem_header_prv.conformado
               btn_documentos
               btn_embarque  
               btn_bonificacion
               btn_facturar                  WHEN modo <> MD_GENERADO
               WITH FRAME frm-documento.
   ELSE ENABLE T-Rem_header_prv.conformado         WHEN NOT T-Rem_header_prv.conformado AND T-Rem_header_prv.estado = "E"
               btn_documentos
               btn_embarque  
               btn_facturar                  WHEN modo <> MD_GENERADO
               WITH FRAME frm-documento.

   OPEN QUERY qry-detalle FOR EACH Rem_detalle_prv OF T-Rem_header_prv,
                              EACH Articulo    OF Rem_detalle_prv.

   hay_error = NO.
   act_Rem_head = ROWID(T-Rem_header_prv).
   /*IF T-Rem_header_prv.nro_comprob:SENSITIVE THEN APPLY "TAB" TO T-Rem_header_prv.nro_comprob.*/

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

   IF T-Rem_header_prv.estado = "P"
   THEN DO:
      RUN PONMENSJ.P (INPUT "REMI016" ).
      RETURN.      
   END.
   
   RUN ANUREMPV.P ( OUTPUT puede_anular ).

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

     RUN getparametro.p (  INPUT  "NFDEVPRV",
                           OUTPUT v-valor_c,
                           OUTPUT v-valor_d,
                           OUTPUT v-valor_l,
                           OUTPUT v-valor_n,
                           OUTPUT v-observacion ).
 
     RUN VALUE("PRDVP" + STRING(v-valor_n, "999") + ".P") (INPUT ROWID(Rem_header_prv)).

END PROCEDURE.

PROCEDURE VER_FACTURA:

  IF T-Rem_header_prv.nro_facprov = 0
  THEN DO:
     RUN PONMENSJ.P (INPUT "REMI018").
     RETURN.
  END.
  ELSE DO:
     FIND Fac_header_prv 
          WHERE Fac_header_prv.nro_facprov = T-Rem_header_prv.nro_facprov NO-LOCK.
     act_fpr_head = ROWID(Fac_header_prv).
     HIDE FRAME frm-documento NO-PAUSE.
     RUN ABMAEFPR.P (INPUT 1).
     RUN PONER_SESION.
     VIEW FRAME frm-documento.
  END.

END PROCEDURE.

PROCEDURE INICIAR_DOCUMENTO:

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
 
   FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
   act_caja = ROWID(Caja).

   RUN getparametro.p (  INPUT  "CNTDEUDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   cntrl_deuda = v-valor_l.

   RUN getparametro.p (  INPUT  "CDGDOLAR",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   codigo_dolar = v-valor_c.
   FIND Moneda WHERE Moneda.cdg_moneda = codigo_dolar NO-LOCK.
   cotiza_dolar = Moneda.cambio.

   RUN getparametro.p (  INPUT  "DFMONEDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
   act_moneda = ROWID(Moneda).

   RUN getparametro.p (  INPUT  "DFDEPOSI",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_n NO-LOCK.
   act_deposito = ROWID(Deposito).

   RUN getparametro.p (  INPUT  "DFCNRPRV",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n 
                         NO-LOCK.
   FIND Cuenta OF Imputacion NO-LOCK.
   act_imputacion = ROWID(Imputacion).
   act_cuenta = ROWID(Cuenta).

   DO WITH FRAME frm-documento:
   
        btn_documentos:ROW    = Domicilio_prv.nro_domicilio:ROW. 
        btn_embarque:ROW      = btn_documentos:ROW  + 1.
        btn_bonificacion:ROW  = btn_embarque:ROW  + 1.
        btn_copiar:ROW        = btn_bonificacion:ROW  + 1.
        btn_facturar:ROW      = btn_copiar:ROW  + 1.
     /* btn_ncopias:ROW       = btn_facturar:ROW  + 3.*/
           
        btn_documentos:COLUMN    = 95.
        btn_embarque:COLUMN      = 95.
        btn_bonificacion:COLUMN  = 95.
        btn_copiar:COLUMN        = 95.
        btn_facturar:COLUMN      = 95.
     /* btn_ncopias:COLUMN       = 95. */
     
        rtn_pantallas:ROW     = btn_documentos:ROW  - 0.10.
        rtn_pantallas:COLUMN  = btn_documentos:COLUMN  - 0.25.

   END.

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*               DEFINICIONES LOCALES:VARIABLES, FRAMES, Y SUBMENUES               */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "LISTA_CAMPOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

{&A-TABLA}Rem_header_prv.anulado           = {&DE-TABLA}Rem_header_prv.anulado
{&A-TABLA}Rem_header_prv.cambio            = {&DE-TABLA}Rem_header_prv.cambio
{&A-TABLA}Rem_header_prv.cambio_dolar      = {&DE-TABLA}Rem_header_prv.cambio_dolar
{&A-TABLA}Rem_header_prv.cdg_condiva       = {&DE-TABLA}Rem_header_prv.cdg_condiva
{&A-TABLA}Rem_header_prv.cdg_consignatario = {&DE-TABLA}Rem_header_prv.cdg_consignatario
{&A-TABLA}Rem_header_prv.cdg_deposito      = {&DE-TABLA}Rem_header_prv.cdg_deposito
{&A-TABLA}Rem_header_prv.cdg_empresa       = {&DE-TABLA}Rem_header_prv.cdg_empresa
{&A-TABLA}Rem_header_prv.cdg_estado        = {&DE-TABLA}Rem_header_prv.cdg_estado
{&A-TABLA}Rem_header_prv.cdg_formapago     = {&DE-TABLA}Rem_header_prv.cdg_formapago
{&A-TABLA}Rem_header_prv.cdg_imputacion    = {&DE-TABLA}Rem_header_prv.cdg_imputacion
{&A-TABLA}Rem_header_prv.cdg_lista         = {&DE-TABLA}Rem_header_prv.cdg_lista
{&A-TABLA}Rem_header_prv.cdg_planta        = {&DE-TABLA}Rem_header_prv.cdg_planta
{&A-TABLA}Rem_header_prv.cdg_postal        = {&DE-TABLA}Rem_header_prv.cdg_postal
{&A-TABLA}Rem_header_prv.cdg_provincia     = {&DE-TABLA}Rem_header_prv.cdg_provincia
{&A-TABLA}Rem_header_prv.nro_area          = {&DE-TABLA}Rem_header_prv.nro_area
{&A-TABLA}Rem_header_prv.cdg_solicitante   = {&DE-TABLA}Rem_header_prv.cdg_solicitante
{&A-TABLA}Rem_header_prv.cdg_zonag         = {&DE-TABLA}Rem_header_prv.cdg_zonag
{&A-TABLA}Rem_header_prv.comision          = {&DE-TABLA}Rem_header_prv.comision
{&A-TABLA}Rem_header_prv.conformado        = {&DE-TABLA}Rem_header_prv.conformado
{&A-TABLA}Rem_header_prv.cta_cte           = {&DE-TABLA}Rem_header_prv.cta_cte
{&A-TABLA}Rem_header_prv.cuit              = {&DE-TABLA}Rem_header_prv.cuit
{&A-TABLA}Rem_header_prv.direccion         = {&DE-TABLA}Rem_header_prv.direccion
{&A-TABLA}Rem_header_prv.estado            = {&DE-TABLA}Rem_header_prv.estado
{&A-TABLA}Rem_header_prv.fecha             = {&DE-TABLA}Rem_header_prv.fecha
{&A-TABLA}Rem_header_prv.fecha_carga       = {&DE-TABLA}Rem_header_prv.fecha_carga
{&A-TABLA}Rem_header_prv.fecha_embarque    = {&DE-TABLA}Rem_header_prv.fecha_embarque
{&A-TABLA}Rem_header_prv.imp_neto          = {&DE-TABLA}Rem_header_prv.imp_neto
{&A-TABLA}Rem_header_prv.imp_total         = {&DE-TABLA}Rem_header_prv.imp_total
{&A-TABLA}Rem_header_prv.leyenda           = {&DE-TABLA}Rem_header_prv.leyenda
{&A-TABLA}Rem_header_prv.localidad         = {&DE-TABLA}Rem_header_prv.localidad
{&A-TABLA}Rem_header_prv.modificado        = {&DE-TABLA}Rem_header_prv.modificado
{&A-TABLA}Rem_header_prv.nombre            = {&DE-TABLA}Rem_header_prv.nombre
{&A-TABLA}Rem_header_prv.nro_cndventa      = {&DE-TABLA}Rem_header_prv.nro_cndventa
{&A-TABLA}Rem_header_prv.nro_comprador     = {&DE-TABLA}Rem_header_prv.nro_comprador
{&A-TABLA}Rem_header_prv.nro_comprob       = {&DE-TABLA}Rem_header_prv.nro_comprob
{&A-TABLA}Rem_header_prv.nro_domicilio     = {&DE-TABLA}Rem_header_prv.nro_domicilio
{&A-TABLA}Rem_header_prv.nro_entidad       = {&DE-TABLA}Rem_header_prv.nro_entidad
{&A-TABLA}Rem_header_prv.nro_facprov       = {&DE-TABLA}Rem_header_prv.nro_facprov
{&A-TABLA}Rem_header_prv.nro_leyenda       = {&DE-TABLA}Rem_header_prv.nro_leyenda
{&A-TABLA}Rem_header_prv.nro_moneda        = {&DE-TABLA}Rem_header_prv.nro_moneda
{&A-TABLA}Rem_header_prv.nro_plazo         = {&DE-TABLA}Rem_header_prv.nro_plazo
{&A-TABLA}Rem_header_prv.nro_proveedor     = {&DE-TABLA}Rem_header_prv.nro_proveedor
{&A-TABLA}Rem_header_prv.nro_remprov       = {&DE-TABLA}Rem_header_prv.nro_remprov
{&A-TABLA}Rem_header_prv.nro_usuario       = {&DE-TABLA}Rem_header_prv.nro_usuario
{&A-TABLA}Rem_header_prv.org_estado        = {&DE-TABLA}Rem_header_prv.org_estado
{&A-TABLA}Rem_header_prv.origen            = {&DE-TABLA}Rem_header_prv.origen
{&A-TABLA}Rem_header_prv.prf_comprob       = {&DE-TABLA}Rem_header_prv.prf_comprob
{&A-TABLA}Rem_header_prv.proc_estad        = {&DE-TABLA}Rem_header_prv.proc_estad
{&A-TABLA}Rem_header_prv.sin_cargo         = {&DE-TABLA}Rem_header_prv.sin_cargo
{&A-TABLA}Rem_header_prv.tip_comprob       = {&DE-TABLA}Rem_header_prv.tip_comprob
{&A-TABLA}Rem_header_prv.transportista     = {&DE-TABLA}Rem_header_prv.transportista
{&A-TABLA}Rem_header_prv.ultima_linea      = {&DE-TABLA}Rem_header_prv.ultima_linea
{&A-TABLA}Rem_header_prv.version           = {&DE-TABLA}Rem_header_prv.version


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
