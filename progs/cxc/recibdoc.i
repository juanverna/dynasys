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

DEFINE BUFFER B-Rec_detalle FOR Rec_detalle.
DEFINE BUFFER B-Cta_cte FOR Cta_cte.

DEFINE WORK-TABLE Aux_header_vta  LIKE Sub_header_vta.
DEFINE WORK-TABLE Aux_detalle_vta LIKE Sub_detalle_vta.

DEFINE VARIABLE ant_cliente   LIKE Cliente.cdg_cliente.
DEFINE VARIABLE v-tip_comprob LIKE Rec_header.tip_comprob.

DEFINE VARIABLE st_seleccionado AS CHARACTER.

DEFINE VARIABLE saldo_cc       AS DECIMAL.
DEFINE VARIABLE saldo_ccv      AS DECIMAL.
DEFINE VARIABLE saldo_final    AS DECIMAL.

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

DEFINE BUTTON btn_vervalores 
     LABEL "&Ver Valores" 
     SIZE 25 BY 0.9.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 16 BY 1.88.

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
     Rec_header.tip_comprob AT ROW 3.58 COL 14 COLON-ALIGNED
          LABEL "Comprobante"
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Rec_header.prf_comprob AT ROW 3.58 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Rec_header.nro_comprob AT ROW 3.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Rec_header.fecha AT ROW 3.58 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.estado AT ROW 3.58 COL 69 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 3 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.anulado AT ROW 3.58 COL 75
          VIEW-AS TOGGLE-BOX
          SIZE 11.14 BY .77
     Rec_header.tipo_pago AT ROW 3.69 COL 96 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Cancelacion", 1,
                    "A Imputar", 2
          SIZE 14 BY 1.35
     Cliente.cdg_cliente AT ROW 4.58 COL 14 COLON-ALIGNED
          LABEL "Cliente"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cliente.nom_cliente AT ROW 4.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Moneda.cdg_moneda AT ROW 5.58 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Moneda.descripcion AT ROW 5.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.cambio AT ROW 5.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 15 FGCOLOR 9 

     Domicilio.nro_domicilio  AT ROW 6.58 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
          LABEL "&Domicilio"
     Domicilio.nombre  AT ROW 6.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
          
     Provincia.cdg_provincia  AT ROW 7.58 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
          LABEL "&Provincia"     
     Provincia.nombre   AT ROW 7.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
     Cobrador.cdg_cobrador AT ROW 8.58 COL 14 COLON-ALIGNED
          LABEL "Cobrador"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cobrador.nom_cobrador AT ROW 8.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.cdg_imputacion AT ROW 9.58 COL 14 COLON-ALIGNED
          LABEL "Imputacion"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Imputacion.dsc_imputacion AT ROW 9.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Cta_cte.tip_comprob AT ROW 10.58 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte.prf_comprob AT ROW 10.58 COL 22 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 6.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte.nro_comprob AT ROW 10.58 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Cta_cte.nro_vencimiento AT ROW 10.58 COL 41 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR 15 FGCOLOR 9 
     btn_vervalores     

     Rec_header.mes  AT ROW 6.58 COL 94 COLON-ALIGNED 
          LABEL "&Período"
          VIEW-AS FILL-IN 
          SIZE 6.00 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Rec_header.ano  AT ROW 6.58 COL 101 COLON-ALIGNED 
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7.72 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Rec_header.nro_rendicion  AT ROW 7.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 15 FGCOLOR 9 
     Rec_header.imp_bruto AT ROW 8.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.imp_neto AT ROW 9.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.imp_total AT ROW 10.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.imp_pesos AT ROW 11.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     Rec_header.imp_difcambio AT ROW 12.58 COL 94 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 7 FGCOLOR 15 
     saldo_cc  AT ROW 13.58 COL 94 COLON-ALIGNED
          LABEL "Saldo C.C."
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 9 FGCOLOR 15 
     saldo_final AT ROW 14.58 COL 94 COLON-ALIGNED
          LABEL "Saldo Final"
          VIEW-AS FILL-IN 
          SIZE 14.72 BY .81
          BGCOLOR 9 FGCOLOR 15 
     brw-detalle AT ROW 12 COL 16
     RECT-1 AT ROW 3.42 COL 95
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
          
/* ------------------------------------------------------------------------
                              S U B M E N U E S 
   ------------------------------------------------------------------------  */

DEFINE SUB-MENU Archivo
   MENU-ITEM Salir                  LABEL "&Salir".

DEFINE SUB-MENU Recibos
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones".

DEFINE SUB-MENU Ctacte
   MENU-ITEM Consultas              LABEL "Co&nsulta de movimientos"
   MENU-ITEM Estado                 LABEL "&Estado crediticio".

DEFINE SUB-MENU Caja
   MENU-ITEM Movimientos            LABEL "&Movimientos".
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones".
   MENU-ITEM List_mov               LABEL "&Listado de Movimientos".
   MENU-ITEM List_cta               LABEL "&Resumen por Cuentas".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Recibos                LABEL "&Recibos"
   SUB-MENU  Ctacte                 LABEL "&Cta.Cte."
   SUB-MENU  Caja                   LABEL "Ca&ja".

{TRIGMENU.I "Consultas"    "Recibos"    "ABMAEREC"  "(INPUT 1)" }

{TRIGMENU.I "Consultas"    "Ctacte"     "CNSCCCLI"   "(INPUT 1)"}
{TRIGMENU.I "Estado"       "Ctacte"     "VERSTCRE"   "(INPUT 1)"}


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

ON RETURN, TAB OF Rec_header.tip_comprob IN FRAME frm-documento
DO:

   Rec_header.tip_comprob:SCREEN-VALUE IN FRAME frm-documento =
   CAPS(Rec_header.tip_comprob:SCREEN-VALUE IN FRAME frm-documento).

   IF LOOKUP(INPUT FRAME frm-documento Rec_header.tip_comprob, {&TIPOS_VALIDOS}) = 0 
   THEN DO:
      RUN PONMENSJ.P (INPUT "DOCS010").
      RETURN NO-APPLY.
   END.
END.   


ON RETURN, TAB OF Rec_header.nro_comprob IN FRAME frm-documento
DO:

  IF AVAILABLE Rec_header AND modo = MD_ALTA
  THEN ASSIGN 
         Rec_header.tip_comprob
         Rec_header.prf_comprob
         Rec_header.nro_comprob.

   IF LOOKUP(INPUT FRAME frm-documento Rec_header.tip_comprob, {&TIPOS_VALIDOS}) = 0 
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
      IF NOT AVAILABLE Cliente
      THEN DO:
         RUN PONMENSJ.P (INPUT "FAPR010").
         RETURN NO-APPLY.
      END.
      ELSE DO:
         IF CAN-FIND( FIRST Rec_header 
                            WHERE Rec_header.tip_comprob = INPUT Rec_header.tip_comprob 
                              AND Rec_header.prf_comprob = INPUT Rec_header.prf_comprob
                              AND Rec_header.nro_comprob = INPUT Rec_header.nro_comprob
                              AND Rec_header.cdg_empresa = Empresa.cdg_empresa
                              AND ROWID(Rec_header) <> act_rec_head)
         THEN DO:
            RUN PONMENSJ.P (INPUT "DOCS011").
            RETURN NO-APPLY.
         END.
         ELSE DO:
            ASSIGN  Rec_header.tip_comprob
                    Rec_header.prf_comprob
                    Rec_header.nro_comprob.

         END.                

      END.   

   END.

END.               


ON VALUE-CHANGED OF Rec_header.tipo_pago IN FRAME frm-documento
DO:

  ASSIGN FRAME frm-documento Rec_header.tipo_pago.
  IF Rec_header.tipo_pago = 2 
  THEN DO:    
     RUN HABILITAR_TOTAL.
  END.
  ELSE DO:
     RUN HABILITAR_CTACTE.
  END.     
  DISPLAY " " @ Rec_header.imp_total
          " " @ Cta_cte.tip_comprob
          " " @ Cta_cte.prf_comprob
          " " @ Cta_cte.nro_comprob
          " " @ Cta_cte.nro_vencimiento
          WITH FRAME frm-documento.
  
END.

ON ".", MOUSE-SELECT-DBLCLICK,MOUSE-MENU-DOWN
        OF Cta_cte.tip_comprob IN FRAME frm-documento,
        Cta_cte.prf_comprob IN FRAME frm-documento,
        Cta_cte.nro_comprob IN FRAME frm-documento,
        Cta_cte.nro_vencimiento IN FRAME frm-documento
DO:

  RUN d-selectacte.w ( INPUT ROWID(Cliente), 
                       INPUT ROWID(Moneda) ).

  FOR EACH B-Cta_cte OF Cliente WHERE B-Cta_cte.user-id-sel = st_seleccionado EXCLUSIVE-LOCK:

     DISPLAY B-Cta_cte.tip_comprob @ Cta_cte.tip_comprob
             B-Cta_cte.prf_comprob @ Cta_cte.prf_comprob
             B-Cta_cte.nro_comprob @ Cta_cte.nro_comprob
             B-Cta_cte.nro_vencimiento @ Cta_cte.nro_vencimiento 
             WITH FRAME frm-documento.

     APPLY "RETURN" TO Cta_cte.nro_vencimiento IN FRAME frm-documento.
     ASSIGN 
        B-Cta_cte.selectado = NO
        B-Cta_cte.user-id-sel = "".
  END.
  RETURN NO-APPLY.

END.   

ON RETURN, TAB OF Cta_cte.nro_vencimiento  IN FRAME frm-documento
DO:

   IF INPUT Cta_cte.nro_vencimiento = 0                      /* Pone vencimiento en 1 */
      THEN Cta_cte.nro_vencimiento:SCREEN-VALUE = STRING(1). /* si no se indico nada  */
      
   FIND Cta_cte WHERE Cta_cte.cdg_empresa = Empresa.cdg_empresa
        USING Cta_cte.tip_comprob
          AND Cta_cte.prf_comprob
          AND Cta_cte.nro_comprob
          AND Cta_cte.nro_vencimiento 
              EXCLUSIVE-LOCK NO-WAIT NO-ERROR.

   IF NOT AVAILABLE Cta_cte
   THEN DO:
      IF LOCKED Cta_cte
      THEN DO:
         RUN PONMENSJ.P (INPUT "RECB009").
         RETURN NO-APPLY.
      END.
      ELSE DO:
         RUN PONMENSJ.P (INPUT "RECB001").
         RETURN NO-APPLY.
      END.   
   END.

   IF Cta_cte.cdg_empresa <> Empresa.cdg_empresa
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB012").
      RETURN NO-APPLY.
   END.

   IF Cta_cte.nro_cliente <> Cliente.nro_cliente
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB002").
      RETURN NO-APPLY.
   END.

   IF Cta_cte.credito = Cta_cte.debito
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB003").
      RETURN NO-APPLY.
   END.

   IF CAN-FIND(FIRST Rec_detalle OF Rec_header
                     WHERE Rec_detalle.tip_cancela     = INPUT Cta_cte.tip_comprob
                       AND Rec_detalle.prf_cancela     = INPUT Cta_cte.prf_comprob
                       AND Rec_detalle.nro_cancela     = INPUT Cta_cte.nro_comprob
                       AND Rec_detalle.nro_vencimiento = INPUT Cta_cte.nro_vencimiento)
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB004").
      RETURN NO-APPLY.
   END.
   
   IF Cta_cte.imputado
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB006").
      RETURN NO-APPLY.
   END.
   
   IF Cta_cte.nro_moneda <> Moneda.nro_moneda
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB007").
      RETURN NO-APPLY.
   END.
   
   act_ctacte = ROWID(Cta_cte).
   Cta_cte.imputado = YES.
   RUN CREAR_DETALLE.
   DISPLAY " " @ Cta_cte.tip_comprob
           " " @ Cta_cte.prf_comprob
           " " @ Cta_cte.nro_comprob
           " " @ Cta_cte.nro_vencimiento
           WITH FRAME frm-documento.
   APPLY "ENTRY" TO Cta_cte.tip_comprob  IN FRAME frm-documento.
   RETURN NO-APPLY.
      
END.

ON LEAVE OF Rec_header.imp_total IN FRAME frm-documento
DO:
  ASSIGN FRAME frm-documento Rec_header.imp_total.
  RUN CALCULOS.
END.

ON LEAVE OF Rec_header.cambio IN FRAME frm-documento
DO:
  ASSIGN FRAME frm-documento Rec_header.cambio.
  RUN CALCULOS.
END.

ON LEAVE OF Rec_header.nro_rendicion IN FRAME frm-documento
DO:
  ASSIGN FRAME frm-documento Rec_header.nro_rendicion.
END.

ON CHOOSE OF btn_vervalores
DO:

  IF Rec_header.nro_transaccion = 0
  THEN DO:
     RUN PONMENSJ.P (INPUT "RECB014").
     RETURN NO-APPLY.      
  END.
  ELSE DO:
     FIND Caj_header WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK.
     act_caj_head = ROWID(Caj_header).
     HIDE FRAME frm-documento NO-PAUSE.
     RUN ALTMCAJA.P (INPUT 2).
     RUN PONER_SESION.
     VIEW FRAME frm-documento.
  END.
  
END.                    

/*=============================  HELPS  ==============================================*/

&SCOPED-DEFINE ENTIDAD          Rec_header

{HLPCLIEN.I ""                "frm-documento" "YES" "NO" }  /* Clientes               */
{HLPMONED.I "cdg_moneda"      "frm-documento" "YES" "YES"}  /* Moneda de un documento */
{HLPCONCP.I "cdg_imputacion"  "frm-documento" "YES" "YES"}  /* Imputacion             */
{HLPCOBRA.I ""                "frm-documento" "YES" "YES"}  /* Cobrador               */

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

   RUN getparametro.p (  INPUT  "DFMONEDA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   FIND Moneda WHERE Moneda.cdg_moneda = v-valor_c NO-LOCK.
   act_moneda = ROWID(Moneda).

   RUN getparametro.p (  INPUT  "DFNROCAJ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
 
   FIND Caja WHERE Caja.cdg_caja = v-valor_n NO-LOCK.
   act_caja = ROWID(Caja).

   RUN getparametro.p (  INPUT  "DFCNCCTE",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
   FIND Cuenta OF Imputacion NO-LOCK.
   act_imputacion = ROWID(Imputacion).
   act_cuenta = ROWID(Cuenta).
   
   st_seleccionado = "UU-" + USERID("SIC").

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

            ASSIGN FRAME frm-documento
                   Rec_header.ano
                   Rec_header.mes.
                   
            RUN VALIDAR_DOCUMENTO.
            IF hubo_error THEN NEXT Espera.            

            IF Rec_header.imp_total <> 0
            THEN DO:
               IF NOT AVAILABLE Caj_header
               THEN DO:
                  CREATE Caj_header.
                  ASSIGN 
                      Caj_header.fecha           = TODAY
                      Caj_header.hora            = TIME
                      Caj_header.nro_cliente     = Rec_header.nro_cliente
                      Caj_header.cdg_empresa     = Rec_header.cdg_empresa
                      Caj_header.tip_comprob     = Rec_header.tip_comprob
                      Caj_header.prf_comprob     = Rec_header.prf_comprob
                      Caj_header.nro_comprob     = Rec_header.nro_comprob
                      Caj_header.ultima_linea    = 0
                      Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
                      Caj_header.importe         = Rec_header.imp_pesos + 
                                                   Rec_header.imp_difcambio
                      Caj_header.emitir          = NO
                      Caj_header.cdg_caja        = Caja.cdg_caja
                      Caj_header.nro_cuenta      = Cuenta.nro_cuenta
                      Caj_header.observacion     = Cliente.cdg_cliente + 
                                                   "-" + Cliente.nom_cliente
                      Caj_header.tipo_mov        = "I"
                      Rec_header.nro_transaccion = Caj_header.nro_transaccion.
               END.
               ELSE DO:
                  FIND CURRENT Caj_header EXCLUSIVE-LOCK.
                  ASSIGN 
                      Caj_header.nro_cliente     = Rec_header.nro_cliente
                      Caj_header.tip_comprob     = Rec_header.tip_comprob
                      Caj_header.importe         = Rec_header.imp_pesos + 
                                                   Rec_header.imp_difcambio.
               END.   
               
               act_caj_head = ROWID(Caj_header).
               HIDE FRAME frm-documento NO-PAUSE.
               RUN ALTMCAJA.P (INPUT 1).
               RUN PONER_SESION.
               VIEW FRAME frm-documento.
               FIND Caj_header WHERE ROWID(Caj_header) = act_caj_head.
               IF Caj_header.importe <> Caj_header.ingreso THEN NEXT Espera.
            END.

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

     FIND CURRENT Caj_header EXCLUSIVE-LOCK.
     ASSIGN 
          Caj_header.cdg_empresa = Rec_header.cdg_empresa
          Caj_header.tip_comprob = Rec_header.tip_comprob
          Caj_header.prf_comprob = Rec_header.prf_comprob
          Caj_header.nro_comprob = Rec_header.nro_comprob.

     RUN EMIMCAJA.P ( INPUT ROWID(Caj_header) ).
   /*RUN ACUMCAJA.P ( INPUT "A" , input rowid(caj_header) ).*/

        
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

  IF NOT CAN-FIND(FIRST Rec_detalle OF  Rec_header) AND Rec_header.tipo_pago = 1
  THEN DO:
     RUN PONMENSJ.P (INPUT "RECB008").
     RETURN.
  END.

  IF Rec_header.imp_total < 0
  THEN DO:
     RUN PONMENSJ.P (INPUT "RECB007").
     RETURN.
  END.

  IF Rec_header.nro_rendicion <> 0
  THEN DO:
    IF NOT CAN-FIND(FIRST Rendicion_hd 
                          WHERE Rendicion_hd.nro_rendicion = Rec_header.nro_rendicion
                            AND Rendicion_hd.cdg_empresa = Rec_header.cdg_empresa)
    THEN DO:
       RUN PONMENSJ.P (INPUT "RECB013").
       RETURN.
    END.
  END.

{IFNOTAVA.I "Cliente" "RECB011"}
{IFNOTEXS.I "Moneda" "cdg_moneda" "frm-documento" "Moneda" "cdg_moneda" "RECB009" }
/*{IFNOTEXS.I "Cobrador" "cdg_cobrador" "frm-documento" "Cobrador" "cdg_cobrador" "RECB010" }*/
{IFNOTAVA.I "Cobrador" "RECB010" }

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

  IF Rec_header.ultima_linea = 0 AND Rec_header.tipo_pago = 1
     THEN RETURN.

  IF AVAILABLE Aux_header_vta 
  THEN DO:
     DELETE Aux_header_vta.
     FOR EACH Aux_detalle_vta:
         DELETE Aux_detalle_vta.
     END.    
  END.

  {CALCREPG.I }

  saldo_final = saldo_cc - Rec_header.imp_bruto.
  DISPLAY Rec_header.imp_bruto 
          Rec_header.imp_total 
          Rec_header.imp_pesos
          Rec_header.imp_difcambio
          saldo_final
          WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE TRAER_CLIENTE:

  IF NOT CAN-DO(Cliente.lista_empresas,Empresa.cdg_empresa)
  THEN DO:
        RUN PONMENSJ.P ( INPUT "CLIE050" ).
        no_aplicar = YES.
        RETURN.
  END.
  ELSE DO:
        FIND FIRST Domicilio OF CLiente NO-LOCK.
        FIND Provincia OF Domicilio NO-LOCK.
        ASSIGN FRAME frm-documento Rec_header.tipo_pago.
        ASSIGN Rec_header.nro_cliente       = Cliente.nro_cliente
               Rec_header.cdg_condiva       = Cliente.cdg_condiva
               Rec_header.cdg_provincia     = Domicilio.cdg_provincia
               act_cliente = ROWID(Cliente).
        
        RUN versaldocc.p ( INPUT ROWID(Cliente),
                           INPUT Rec_header.fecha,
                           OUTPUT saldo_cc,
                           OUTPUT saldo_ccv).

        DISPLAY  Cliente.cdg_cliente 
                 Cliente.nom_cliente
                 saldo_cc
                 WITH FRAME frm-documento.

        FIND Condicion_impos OF Cliente NO-LOCK.
        v-tip_comprob = "R" + Condicion_impos.tipo_factura.
        
        IF Rec_header.tipo_pago = 2 
        THEN DO:
           RUN HABILITAR_TOTAL.
           ENABLE
              Cliente.cdg_cliente
              Rec_header.imp_total
              WITH FRAME frm-documento.
        END.
        ELSE DO:
           RUN HABILITAR_CTACTE.
           ENABLE
              Cliente.cdg_cliente
              Cta_cte.tip_comprob
              Cta_cte.prf_comprob
              Cta_cte.nro_comprob
              Cta_cte.nro_vencimiento
              WITH FRAME frm-documento.
        END.     
           
        ENABLE
              Rec_header.tip_comprob 
              Rec_header.prf_comprob 
              Rec_header.nro_comprob 
              BTN_GRABAR
              BTN_CANCEL
              BTN_SALIR
              WITH FRAME frm-documento.
      
        DISABLE Rec_header.tipo_pago
                 WITH FRAME frm-documento.
           
        RUN CALCULOS.   
      
        MENU-ITEM Consultas:SENSITIVE IN SUB-MENU Ctacte = YES.
        MENU-ITEM Estado:SENSITIVE IN SUB-MENU Ctacte = YES.
      
        Rec_header.tip_comprob:SCREEN-VALUE IN FRAME frm-documento = v-tip_comprob.
      
        no_aplicar = YES.
        APPLY "ENTRY" TO  Rec_header.prf_comprob IN FRAME frm-documento.

  END.

END PROCEDURE.                      

PROCEDURE ASIGNAR_MONEDA:

   Rec_header.nro_moneda = Moneda.nro_moneda.
   Rec_header.cambio     = Moneda.cambio.
   DISPLAY Rec_header.cambio 
           WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE ASIGNAR_COBRADOR:

   Rec_header.nro_cobrador = Cobrador.nro_cobrador.

END PROCEDURE.

PROCEDURE ASIGNAR_IMPUTACION:

   ASSIGN FRAME frm-documento Rec_header.cdg_imputacion.
   FIND Cuenta OF Imputacion NO-LOCK.

END PROCEDURE.


PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.

   IF Rec_header.anulado AND Rec_header.origen = "A"
   THEN DO:
      RUN PONMENSJ.P (INPUT "RECB017").
      RETURN.
   END.   

   FIND Cliente      OF Rec_header NO-LOCK NO-ERROR.
   FIND Imputacion   OF Rec_header NO-LOCK.
   FIND Cobrador     OF Rec_header NO-LOCK.
   FIND Moneda       OF Rec_header NO-LOCK.
  
   DISPLAY
        Rec_header.tip_comprob 
        Rec_header.prf_comprob 
        Rec_header.nro_comprob 
        Rec_header.fecha 
        Rec_header.estado
        Rec_header.anulado
        Cliente.cdg_cliente WHEN AVAILABLE Cliente
        Cliente.nom_cliente
        Moneda.cdg_moneda
        Moneda.descripcion
        Cobrador.cdg_cobrador 
        Cobrador.nom_cobrador 
        Rec_header.cdg_imputacion 
        Imputacion.dsc_imputacion 
        Rec_header.cambio
        Rec_header.imp_bruto
        Rec_header.imp_total
        Rec_header.imp_pesos
        Rec_header.imp_difcambio
        Rec_header.tipo_pago
        Rec_header.mes
        Rec_header.ano
        Rec_header.nro_rendicion
        brw-detalle
        WITH FRAME frm-documento.
       
   OPEN QUERY qry-detalle 
        FOR EACH Rec_detalle OF Rec_header,
            EACH Cta_cte  WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                            and Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                            AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                            AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                            AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento.

   ENABLE brw-detalle btn_OBSERV btn_emitir btn_baja btn_vervalores
          WITH FRAME frm-documento.
   hay_error = NO.
   act_rec_head = ROWID(Rec_header).
   APPLY "TAB" TO Rec_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

   DO TRANSACTION:

        FIND Caj_header 
             WHERE Caj_header.tip_comprob = Rec_header.tip_comprob 
             AND   Caj_header.prf_comprob = Rec_header.prf_comprob
             AND   Caj_header.nro_comprob = Rec_header.nro_comprob NO-LOCK.
      
        act_caj_head = ROWID(Caj_header).     
        RUN ANULCAJA.P ( OUTPUT puede_anular ).
        IF NOT puede_anular 
        THEN DO:
           RUN PONMENSJ.P (INPUT "RECB005").
           RETURN.
        END.   
      
        FOR EACH Rec_detalle OF Rec_header:
        
            FIND Cta_cte WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                           AND Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                           AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                           AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                           AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                           EXCLUSIVE-LOCK.
                         
            IF CAN-DO(str_debitan,Cta_cte.tip_comprob)
               THEN Cta_cte.credito = Cta_cte.credito - Rec_detalle.importe.
               ELSE Cta_cte.debito  = Cta_cte.debito  + Rec_detalle.importe.
      
        END.
      
        FIND Sub_header_vta 
             WHERE Sub_header_vta.cdg_empresa = Rec_header.cdg_empresa 
               AND Sub_header_vta.tip_comprob = Rec_header.tip_comprob
               AND Sub_header_vta.prf_comprob = Rec_header.prf_comprob 
               AND Sub_header_vta.nro_comprob = Rec_header.nro_comprob 
                   EXCLUSIVE-LOCK NO-ERROR.

        FOR EACH Cta_cte 
             WHERE Cta_cte.nro_comprob = Rec_header.nro_comprob 
             AND   Cta_cte.prf_comprob = Rec_header.prf_comprob
             AND   Cta_cte.tip_comprob = Rec_header.tip_comprob
             AND   Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                   EXCLUSIVE-LOCK:       

                act_ctacte = ROWID(Cta_cte).
              /*RUN ACUMCCTE.P (INPUT "B").*/
                DELETE Cta_cte.
        END.      
        Rec_header.anulado = YES.

   END. /* De la transaccion */

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

    CASE Rec_header.tip_comprob:
       WHEN "RA" 
         THEN DO:
            RUN getparametro.p (  INPUT  "NFRECIBA",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).

            RUN VALUE("PRRCA" + STRING(v-valor_n, "999") + ".P") (INPUT ROWID(Rec_header)).
         END.   
       WHEN "RB"
         THEN DO:
            RUN getparametro.p (  INPUT  "NFRECIBB",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).

            RUN VALUE("PRRCB" + STRING(v-valor_n, "999") + ".P") (INPUT ROWID(Rec_header)).
         END.   
       WHEN "CA"
         THEN DO:
            RUN getparametro.p (  INPUT  "NFCREDIA",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).
            RUN VALUE("PRCRA" + STRING(v-valor_n, "999") + ".P") (INPUT ROWID(Rec_header)).
         END.   
       WHEN "CB"
         THEN DO:
            RUN getparametro.p (  INPUT  "NFCREDIB",
                                  OUTPUT v-valor_c,
                                  OUTPUT v-valor_d,
                                  OUTPUT v-valor_l,
                                  OUTPUT v-valor_n,
                                  OUTPUT v-observacion ).
            RUN VALUE("PRCRB" + STRING(v-valor_n, "999") + ".P") (INPUT ROWID(Rec_header)).
         END.   
    END CASE.
    
END PROCEDURE.

PROCEDURE HABILITAR_TOTAL:

  ASSIGN
     Rec_header.imp_total:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte.tip_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte.prf_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte.nro_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte.nro_vencimiento:BGCOLOR IN FRAME frm-documento = bg_c.
     Rec_header.imp_total:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte.tip_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte.prf_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte.nro_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte.nro_vencimiento:FGCOLOR IN FRAME frm-documento = fg_c.

END PROCEDURE.

PROCEDURE HABILITAR_CTACTE:

  ASSIGN
     Rec_header.imp_total:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte.tip_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte.prf_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte.nro_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte.nro_vencimiento:BGCOLOR IN FRAME frm-documento = be_c.
     Rec_header.imp_total:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte.tip_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte.prf_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte.nro_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte.nro_vencimiento:FGCOLOR IN FRAME frm-documento = fe_c.

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
