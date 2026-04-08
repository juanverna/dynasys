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

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE VARIABLE ncopias             AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.

DEFINE VARIABLE st_seleccionado AS CHARACTER.

DEFINE BUFFER B-Opg_detalle FOR Opg_detalle.
DEFINE BUFFER B-Cta_cte_prv FOR Cta_cte_prv.

DEFINE WORK-TABLE Aux_header  LIKE Sub_header_prv.
DEFINE WORK-TABLE Aux_detalle LIKE Sub_detalle_prv.

DEFINE VARIABLE ant_proveedor   AS ROWID.
DEFINE VARIABLE v-tip_comprob LIKE Opg_header.tip_comprob.

DEFINE VARIABLE importe_anterior  LIKE Caj_detalle.importe.

DEFINE BUTTON btn_valores
     LABEL "Valores":L 
     SIZE 15 BY 0.81 FONT 4.

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
     Opg_header.tip_comprob AT ROW 3.75 COL 14 COLON-ALIGNED
          LABEL "&O/Pago" 
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Opg_header.prf_comprob AT ROW 3.81 COL 22 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
     Opg_header.nro_comprob  AT ROW 3.81 COL 30 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Opg_header.fecha  AT ROW 3.81 COL 60 COLON-ALIGNED
          LABEL "Fe&cha" 
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Opg_header.tipo_pago AT ROW 3.69 COL 83 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL
          RADIO-BUTTONS 
                    "Cancelacion", 1,
                    "A Imputar", 2
          SIZE 14 BY 1.35

     Opg_header.anulado AT ROW 3.81 COL 99 COLON-ALIGNED FGCOLOR fg_c BGCOLOR bg_c

     Proveedor.cdg_proveedor  AT ROW 4.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
          LABEL "&Prov."
     Proveedor.nombre  AT ROW 4.81 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
          NO-LABEL  

     Condicion_impos.cdg_condiva   AT ROW 5.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Condicion_impos.texto_iva  AT ROW 5.81 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
          NO-LABEL  
     Opg_header.imp_total AT ROW 5.81 COL 80.5 COLON-ALIGNED 
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     Opg_header.estado  AT ROW 5.69 COL 100 NO-LABEL
          VIEW-AS RADIO-SET VERTICAL 
          RADIO-BUTTONS 
                     "Emitida", "E", 
                     "Pendiente", ""
          SIZE 14 BY 1.35


     Imputacion.cdg_imputacion   AT ROW 6.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
          LABEL "Conce&pto"
     Imputacion.dsc_imputacion  AT ROW 6.81 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
          NO-LABEL   
     Opg_header.imp_bruto AT ROW 6.81 COL 80.5 COLON-ALIGNED 
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 

     Moneda.cdg_moneda   AT ROW 7.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
          LABEL "&Moneda"
     Moneda.descripcion  AT ROW 7.81 COL 30 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
          NO-LABEL   

     Opg_header.cdg_tiporetgan  AT ROW 8.81 COL 14 COLON-ALIGNED
          LABEL "&Actividad"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          FGCOLOR fe_c BGCOLOR be_c
     Tipo_actividad.nom_tipactiv  AT ROW 8.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          FGCOLOR fg_c BGCOLOR bg_c 
     btn_valores AT ROW 8.81 COL 82.5

     Cta_cte_prv.tip_comprob AT ROW 9.81 COL 14 COLON-ALIGNED
          LABEL "&Aplicacion" 
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Cta_cte_prv.prf_comprob AT ROW 9.81 COL 22 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 7 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Cta_cte_prv.nro_comprob AT ROW 9.81 COL 30 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Cta_cte_prv.nro_vencimiento AT ROW 9.81 COL 40 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     brw-detalle AT ROW 11 COL 16
     RECT-1 AT ROW 3.42 COL 82
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

DEFINE SUB-MENU Tablas
   MENU-ITEM Proveedors             LABEL "&Proveedores"
   MENU-ITEM Articulos              LABEL "&Articulos"
   MENU-ITEM Condiven               LABEL "Condiciones de V&enta".

DEFINE SUB-MENU Pagos
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones"
   MENU-ITEM Reportes               LABEL "&Reportes".

DEFINE SUB-MENU Ctacte
   MENU-ITEM Consultas              LABEL "Co&nsultas"
   MENU-ITEM Creditos               LABEL "&Creditos".
   MENU-ITEM Debitos                LABEL "&D‚bitos".
   
DEFINE SUB-MENU Caja
   MENU-ITEM Movimientos            LABEL "&Movimientos".
   MENU-ITEM Consultas              LABEL "&Consultas/Anulaciones".
   MENU-ITEM List_mov               LABEL "&Listado de Movimientos".
   MENU-ITEM List_cta               LABEL "&Resumen por Cuentas".

DEFINE MENU  Principal MENUBAR
   MENU-ITEM Salir                  LABEL "&Salir"
   SUB-MENU  Tablas                 LABEL "&Tablas"
   SUB-MENU  Pagos                  LABEL "&Pagos"
   SUB-MENU  Ctacte                 LABEL "&Cta.Cte."
   SUB-MENU  Caja                   LABEL "Ca&ja".

{TRIGMENU.I "Proveedors"   "Tablas"      "ACTCLIEN"   "(INPUT 0)"}
{TRIGMENU.I "Condiven"     "Tablas"      "ACBRWCVN"   "(INPUT 0)"}

{TRIGMENU.I "Consultas"    "Pagos"       "ABMAEOPG"   "(INPUT 1)"}

{TRIGMENU.I "Movimientos"  "Caja"        "ALTMCAJA"   "(INPUT 0)"}
{TRIGMENU.I "Consultas"    "Caja"        "ACTCAJA" }
{TRIGMENU.I "List_mov"     "Caja"        "LSCAJMOV"}
{TRIGMENU.I "List_cta"     "Caja"        "LSCAJCTA"}          

{TRIGMENU.I "Consultas"    "Ctacte"      "CNSCCPRO" "(INPUT 0)"}

{TRIGMENU.I "Creditos"     "Ctacte"      "ABMAECRP" "(INPUT 0)"}
{TRIGMENU.I "Debitos"      "Ctacte"      "ABMAEDPV" "(INPUT 0)"}

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

ON VALUE-CHANGED OF Opg_header.tipo_pago IN FRAME frm-documento
DO:

  ASSIGN FRAME frm-documento Opg_header.tipo_pago.
  IF Opg_header.tipo_pago = 2 
  THEN DO:    
     RUN HABILITAR_TOTAL.
  END.
  ELSE DO:
     RUN HABILITAR_CTACTE.
  END.     
  DISPLAY " " @ Opg_header.imp_total
          " " @ Cta_cte_prv.tip_comprob
          " " @ Cta_cte_prv.prf_comprob
          " " @ Cta_cte_prv.nro_comprob
          " " @ Cta_cte_prv.nro_vencimiento
          WITH FRAME frm-documento.
  
END.

ON LEAVE OF Opg_header.imp_total IN FRAME frm-documento
DO:
  ASSIGN FRAME frm-documento Opg_header.imp_total.
  RUN CALCULOS.
END.


ON VALUE-CHANGED OF Opg_header.estado IN FRAME frm-documento
DO:
  ASSIGN Opg_header.estado.
END.  


ON ".", MOUSE-SELECT-DBLCLICK OF Cta_cte_prv.tip_comprob IN FRAME frm-documento,
                                 Cta_cte_prv.prf_comprob IN FRAME frm-documento,
                                 Cta_cte_prv.nro_comprob IN FRAME frm-documento,
                                 Cta_cte_prv.nro_vencimiento IN FRAME frm-documento
DO:

  RUN d-selectaprv.w ( INPUT ROWID(Proveedor), 
                       INPUT ROWID(Moneda),
                       INPUT st_seleccionado ).

  FOR EACH B-Cta_cte_prv OF Proveedor WHERE B-Cta_cte_prv.user-id-sel = st_seleccionado:

     DISPLAY B-Cta_cte_prv.tip_comprob @ Cta_cte_prv.tip_comprob
             B-Cta_cte_prv.prf_comprob @ Cta_cte_prv.prf_comprob     
             B-Cta_cte_prv.nro_comprob @ Cta_cte_prv.nro_comprob
             B-Cta_cte_prv.nro_vencimiento @ Cta_cte_prv.nro_vencimiento 
             WITH FRAME frm-documento.

     APPLY "RETURN" TO Cta_cte_prv.nro_vencimiento IN FRAME frm-documento.

     B-Cta_cte_prv.selectado = NO.
  END.
  RETURN NO-APPLY.
END.   

ON RETURN, TAB OF Cta_cte_prv.nro_vencimiento  IN FRAME frm-documento
DO:

   FIND Cta_cte_prv WHERE Cta_cte_prv.nro_proveedor = Proveedor.nro_proveedor 
                      AND Cta_cte_prv.cdg_empresa   = Empresa.cdg_empresa
                    USING Cta_cte_prv.tip_comprob 
                      AND Cta_cte_prv.prf_comprob 
                      AND Cta_cte_prv.nro_comprob 
                      AND Cta_cte_prv.nro_vencimiento 
                          EXCLUSIVE-LOCK NO-ERROR.

   IF NOT AVAILABLE Cta_cte_prv
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG001").
      RETURN NO-APPLY.
   END.

   IF Cta_cte_prv.nro_proveedor <> Proveedor.nro_proveedor
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG002").
      RETURN NO-APPLY.
   END.

   IF Cta_cte_prv.credito = Cta_cte_prv.debito
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG003").
      RETURN NO-APPLY.
   END.

   IF CAN-FIND(FIRST Opg_detalle OF Opg_header
                            WHERE Cta_Cte_prv.tip_comprob = Opg_detalle.tip_cancela
                              AND Cta_Cte_prv.prf_comprob = Opg_detalle.prf_cancela
                              AND Cta_Cte_prv.nro_comprob = Opg_detalle.nro_cancela
                              AND Cta_Cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento)
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG004").
      RETURN NO-APPLY.
   END.
   
   IF Cta_cte_prv.imputado
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG006").
      RETURN NO-APPLY.
   END.

   IF NOT Cta_cte_prv.liberada AND LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG007").
      RETURN NO-APPLY.
   END.
   
   IF NOT Cta_cte_prv.programada AND LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG008").
      RETURN NO-APPLY.
   END.
   
   IF Cta_cte_prv.cdg_tiporetgan <> Tipo_actividad.cdg_tiporetgan
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG011").
      RETURN NO-APPLY.
   END.
         
   act_ctacte = ROWID(Cta_cte_prv).
   Cta_cte_prv.imputado = YES.
   RUN CREAR_DETALLE.
   DISPLAY " " @ Cta_cte_prv.tip_comprob
           " " @ Cta_cte_prv.prf_comprob
           " " @ Cta_cte_prv.nro_comprob
           " " @ Cta_cte_prv.nro_vencimiento
           WITH FRAME frm-documento.
   APPLY "ENTRY" TO Cta_cte_prv.tip_comprob  IN FRAME frm-documento.
   RETURN NO-APPLY.
      
END.

ON CHOOSE OF btn_valores IN FRAME frm-documento
DO:

  IF Opg_header.nro_transaccion = 0
  THEN DO:
     RUN PONMENSJ.P (INPUT "OPAG014").
     RETURN NO-APPLY.      
  END.
  ELSE DO:
     FIND Caj_header WHERE Caj_header.nro_transaccion = Opg_header.nro_transaccion NO-LOCK.
     act_caj_head = ROWID(Caj_header).
     HIDE FRAME frm-documento NO-PAUSE.
     RUN ALTMCAJA.P (INPUT 2).
     RUN PONER_SESION.
     VIEW FRAME frm-documento.
  END.
  
END.                    

        /* -------------------- Proveedor ------------*/

&SCOPED-DEFINE TABLA            Proveedor
&SCOPED-DEFINE CODIGO           cdg_proveedor
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELPROVE
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_proveedor
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          TRAER_proveedor
&SCOPED-DEFINE ALTA-MODIF       ACTPROVE
&SCOPED-DEFINE ULT_REGISTRO     ult_proveedor
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I}

        /* -------------------- Condicion de iva ------------*/

&SCOPED-DEFINE TABLA            Condicion_impos
&SCOPED-DEFINE CODIGO           cdg_condiva
&SCOPED-DEFINE NOMBRE           texto_iva
&SCOPED-DEFINE RUTINA           SELCNDIV
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_condiva
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          ASIGNAR_CONDIVA
&SCOPED-DEFINE ALTA-MODIF       ACTCNDIV
&SCOPED-DEFINE ULT_REGISTRO     ult_condiva
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 

        /* -------------------- Concepto del documento ------------------*/

&SCOPED-DEFINE TABLA            Imputacion
&SCOPED-DEFINE CODIGO           cdg_imputacion
&SCOPED-DEFINE NOMBRE           dsc_imputacion
&SCOPED-DEFINE RUTINA           SELCNDOC
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_concepto
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          ASIGNAR_IMPUTACION
&SCOPED-DEFINE ALTA-MODIF       ACTCNDOC
&SCOPED-DEFINE ULT_REGISTRO     ult_concepto
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 


        /* -------------------- Moneda del documento ------------------*/

&SCOPED-DEFINE TABLA            Moneda
&SCOPED-DEFINE CODIGO           cdg_moneda
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELMONED
&SCOPED-DEFINE FRAME-INGRESO    frm-documento
&SCOPED-DEFINE ROWID-TABLA      act_moneda
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE PROCESO          ASIGNAR_MONEDA
&SCOPED-DEFINE ALTA-MODIF       ACBRWMND
&SCOPED-DEFINE ULT_REGISTRO     ult_moneda
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 

&SCOPED-DEFINE ENTIDAD          Opg_header
{HLPACTIV.I ""                "frm-documento" "YES" "YES"}  /* Actividad del proveedor*/

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

/*---------------- Depende del Proveedor-------------------------------------------*/

RUN getparametro.p (  INPUT  "DFCNCOMP",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

FIND Imputacion WHERE Imputacion.cdg_imputacion = v-valor_n NO-LOCK.
FIND Cuenta OF Imputacion NO-LOCK.
act_imputacion = ROWID(Imputacion).
act_cuenta = ROWID(Cuenta).
/*---------------------------------------------------------------------------------*/

st_seleccionado = "OPG-" + USERID("SIC").

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

            IF NOT Opg_header.anulado
            THEN DO:

               IF NOT AVAILABLE Caj_header
               THEN DO:
                  RUN CREAR_CAJA.
               END.
               ELSE DO:
                  ASSIGN 
                      Caj_header.nro_cuenta      = Cuenta.nro_cuenta
                      Caj_header.nro_proveedor   = Opg_header.nro_proveedor
                      Caj_header.cdg_empresa     = Opg_header.cdg_empresa
                      Caj_header.tip_comprob     = Opg_header.tip_comprob
                      Caj_header.importe         = Opg_header.imp_total.
               END.   
               
               RUN calcular_retenciones.p ( INPUT ROWID(Opg_header) ).               
               act_caj_head = ROWID(Caj_header).
               HIDE FRAME frm-documento NO-PAUSE.
               RUN ALTMCAJA.P (INPUT 1).
               RUN PONER_SESION.
               VIEW FRAME frm-documento.
               FIND Caj_header WHERE ROWID(Caj_header) = act_caj_head EXCLUSIVE-LOCK.
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

     ASSIGN
        Caj_header.cdg_empresa = Opg_header.cdg_empresa
        Caj_header.tip_comprob = Opg_header.tip_comprob
        Caj_header.prf_comprob = Opg_header.prf_comprob
        Caj_header.nro_comprob = Opg_header.nro_comprob.

     RUN EMIMCAJA.P ( INPUT ROWID(Caj_header) ).
     RUN ACUMCAJA.P ( INPUT "A",input rowid(caj_header) ).

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

     Opg_header.imp_bruto = Opg_header.imp_bruto - Opg_detalle.importe.
     Opg_header.imp_total = Opg_header.imp_total - Opg_detalle.importe -
                            Opg_detalle.descuento.
             
END PROCEDURE.

PROCEDURE SUMAR_RENGLON:

     Opg_header.imp_bruto = Opg_header.imp_bruto + Opg_detalle.importe.
     Opg_header.imp_total = Opg_header.imp_total + Opg_detalle.importe +
                            Opg_detalle.descuento.

END PROCEDURE.

PROCEDURE VALIDAR_DOCUMENTO:

  hubo_error = YES.

  IF ROWID(Opg_header) = ?
  THEN DO:
     RUN PONMENSJ.P (INPUT "OPAG007").
     RETURN.
  END.

  IF NOT CAN-FIND(FIRST Opg_detalle OF  Opg_header) AND
     Opg_header.tipo_pago = 1
  THEN DO:
     RUN PONMENSJ.P (INPUT "OPAG005").
     RETURN.
  END.

  {IFNOTAVA.I "Proveedor" "OPAG010"}
  {IFNOTAVA.I "Condicion_impos" "OPAG009"}

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

  IF Opg_header.ultima_linea = 0 THEN RETURN.

  IF AVAILABLE Aux_header 
  THEN DO:
     DELETE Aux_header.
     FOR EACH Aux_detalle:
         DELETE Aux_detalle.
     END.    
  END.

  {CALCOPAG.I }

  DISPLAY Opg_header.imp_total 
          Opg_header.imp_bruto
          WITH FRAME frm-documento.

END PROCEDURE.

PROCEDURE TRAER_PROVEEDOR:

  IF ROWID(Proveedor) = ant_proveedor
     THEN RETURN.

  RUN PONER_PROVEEDOR.

END PROCEDURE.

PROCEDURE PONER_PROVEEDOR:

  FIND FIRST Domicilio_prv OF Proveedor NO-LOCK.
  FIND Provincia OF Domicilio_prv NO-LOCK.
  act_provincia = ROWID(Provincia).

  FIND Familia_proveedor OF Proveedor NO-LOCK.
  FIND Imputacion WHERE Imputacion.cdg_imputacion = Familia_proveedor.cdg_imputapagos NO-LOCK.
  FIND Cuenta OF Imputacion NO-LOCK.
  act_imputacion = ROWID(Imputacion).
  act_cuenta = ROWID(Cuenta).

  FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.
  act_cndventa = ROWID(Condicion_venta).
  
  FIND Condicion_impos   OF Proveedor NO-LOCK.
  act_condiva = ROWID(Condicion_impos).

  DISABLE Condicion_impos.cdg_condiva WITH FRAME frm-documento.

  RUN ASIGNAR_IMPUTACION.

  ASSIGN
        Opg_header.cdg_condiva     = Condicion_impos.cdg_condiva
        Opg_header.nro_proveedor   = Proveedor.nro_proveedor
        act_proveedor              = ROWID(Proveedor).

  DISPLAY  Proveedor.cdg_proveedor 
           Proveedor.nombre
           Condicion_impos.cdg_condiva
           Condicion_impos.texto_iva
           Imputacion.cdg_imputacion
           Imputacion.dsc_imputacion
           WITH FRAME frm-documento.

  IF Opg_header.tipo_pago = 2 
  THEN DO:
     RUN HABILITAR_TOTAL.
     ENABLE
        Proveedor.cdg_proveedor
        Opg_header.imp_total
        WITH FRAME frm-documento.
  END.
  ELSE DO:
     RUN HABILITAR_CTACTE.
     ENABLE
        Proveedor.cdg_proveedor
        Cta_cte_prv.tip_comprob
        Cta_cte_prv.prf_comprob
        Cta_cte_prv.nro_comprob
        Cta_cte_prv.nro_vencimiento
        WITH FRAME frm-documento.
  END.     

  FIND Actividad_proveedor OF Proveedor NO-LOCK NO-ERROR.
  IF AVAILABLE Actividad_proveedor
  THEN DO:
     FIND Tipo_actividad OF Actividad_proveedor NO-LOCK.
     act_tipactiv = ROWID(Actividad_proveedor).      
     ASSIGN  Opg_header.cdg_tiporetgan  = Tipo_actividad.cdg_tiporetgan.
     DISPLAY Opg_header.cdg_tiporetgan
             Tipo_actividad.nom_tipactiv
             WITH FRAME frm-documento.
     DISABLE Opg_header.cdg_tiporetgan WITH FRAME frm-documento.      
  END.
  ELSE DO:  /* No hay ninguna o hay mas de una */
     ASSIGN  Opg_header.cdg_tiporetgan = "0".
     DISPLAY " " @ Opg_header.cdg_tiporetgan
             " " @ Tipo_actividad.nom_tipactiv
             WITH FRAME frm-documento.
     ENABLE Opg_header.cdg_tiporetgan WITH FRAME frm-documento.
  END.   

  DISABLE Opg_header.tipo_pago
          WITH FRAME frm-documento.
           
  ENABLE
        BTN_GRABAR
        BTN_CANCEL
        BTN_SALIR
        WITH FRAME frm-documento.
     
  RUN CALCULOS.   

END PROCEDURE.                      

PROCEDURE ASIGNAR_PROVINCIA:

   Opg_header.cdg_provincia = Provincia.cdg_provincia.

END PROCEDURE.

PROCEDURE ASIGNAR_CONDIVA:

   Opg_header.cdg_condiva = Condicion_impos.cdg_condiva.

END PROCEDURE.

PROCEDURE ASIGNAR_IMPUTACION:

   FIND Cuenta OF Imputacion NO-LOCK.
   act_cuenta = ROWID(Cuenta).
   Opg_header.cdg_imputacion = Imputacion.cdg_imputacion.

END PROCEDURE.

PROCEDURE ASIGNAR_MONEDA:

   Opg_header.nro_moneda = Moneda.nro_moneda.

END PROCEDURE.

PROCEDURE ASIGNAR_ACTIVIDAD:

    IF NOT CAN-FIND(FIRST Actividad_proveedor OF Proveedor 
                          WHERE Actividad_proveedor.cdg_tiporetgan = Tipo_actividad.cdg_tiporetgan)
    THEN DO:
       no_aplicar = YES.
       RUN PONMENSJ.P ( INPUT "FAPR025").
       RETURN.
    END.   

    Opg_header.cdg_tiporetgan = Tipo_actividad.cdg_tiporetgan.

END PROCEDURE.


PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.

   IF Opg_header.anulado AND Opg_header.origen = "A"
   THEN DO:
      RUN PONMENSJ.P (INPUT "OPAG017").
      RETURN.
   END.   

   FIND Proveedor       OF Opg_header NO-LOCK NO-ERROR.
   FIND Tipo_actividad  OF Opg_header NO-LOCK.
   FIND Imputacion      OF Opg_header NO-LOCK.
   FIND Moneda          OF Opg_header NO-LOCK.
   FIND Condicion_impos OF Opg_header NO-LOCK.
   act_condiva = ROWID(Condicion_impos).
   
   DISPLAY
        Opg_header.tip_comprob 
        Opg_header.nro_comprob 
        Opg_header.fecha 
        Opg_header.estado
        Opg_header.tipo_pago
        Opg_header.anulado
        Proveedor.cdg_proveedor WHEN AVAILABLE Proveedor
        Proveedor.nombre        WHEN AVAILABLE Proveedor
        Condicion_impos.cdg_condiva 
        Condicion_impos.texto_iva 
        Imputacion.cdg_imputacion
        Imputacion.dsc_imputacion
        Moneda.cdg_moneda
        Moneda.descripcion
        Opg_header.cdg_tiporetgan 
        Tipo_actividad.nom_tipactiv
        Opg_header.imp_total
        Opg_header.imp_bruto
        brw-detalle
        WITH FRAME frm-documento.
       
   OPEN QUERY qry-detalle 
        FOR EACH Opg_detalle OF Opg_header,
            EACH Cta_cte_prv  WHERE Cta_cte_prv.cdg_empresa = Opg_header.cdg_empresa
                                AND Cta_cte_prv.tip_comprob = Opg_detalle.tip_cancela
                                AND Cta_cte_prv.prf_comprob = Opg_detalle.prf_cancela
                                AND Cta_cte_prv.nro_comprob = Opg_detalle.nro_cancela
                                AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                                AND Cta_cte_prv.nro_proveedor = Opg_header.nro_proveedor.

   ENABLE brw-detalle 
          btn_OBSERV 
          btn_baja
          btn_valores 
          WITH FRAME frm-documento.
   hay_error = NO.
   act_Opg_head = ROWID(Opg_header).
   APPLY "TAB" TO Opg_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

    DO TRANSACTION:

        FIND Caj_header 
             WHERE Caj_header.cdg_empresa = Opg_header.cdg_empresa
               AND Caj_header.nro_comprob = Opg_header.nro_comprob 
               AND Caj_header.prf_comprob = Opg_header.prf_comprob 
               AND Caj_header.tip_comprob = Opg_header.tip_comprob.
        act_caj_head = ROWID(Caj_header).     
        RUN ANULCAJA.P ( OUTPUT puede_anular ).
        IF NOT puede_anular 
        THEN DO:
           RUN PONMENSJ.P (INPUT "OPAG005").
           RETURN.
        END.   
      
        FOR EACH Opg_detalle OF Opg_header:
        
            FIND Cta_cte_prv WHERE Cta_cte_prv.cdg_empresa     = Opg_header.cdg_empresa
                               AND Cta_cte_prv.tip_comprob     = Opg_detalle.tip_cancela
                               AND Cta_cte_prv.prf_comprob     = Opg_detalle.prf_cancela
                               AND Cta_cte_prv.nro_comprob     = Opg_detalle.nro_cancela
                               AND Cta_cte_prv.nro_vencimiento = Opg_detalle.nro_vencimiento
                               AND Cta_cte_prv.nro_proveedor   = Opg_header.nro_proveedor
                                   EXCLUSIVE-LOCK.
                         
       /* Modificamos los importes. Si es una OP o una NC, el Opg_detalle.importe es < 0 */
                    
            IF LOOKUP(Cta_cte_prv.tip_comprob,str_debitan_prv) <> 0
               THEN DO:
                    Cta_cte_prv.credito = Cta_cte_prv.credito + Opg_detalle.importe.
               END.
               ELSE DO:
                    Cta_cte_prv.debito  = Cta_cte_prv.debito  - Opg_detalle.importe.
               END.
            
            Cta_cte_prv.user-id-sel = "".   
      
        END.
      
        FIND Sub_header_prv 
             WHERE Sub_header_prv.nro_comprob   = Opg_header.nro_comprob 
             AND   Sub_header_prv.prf_comprob   = Opg_header.prf_comprob
             AND   Sub_header_prv.tip_comprob   = Opg_header.tip_comprob
             AND   Sub_header_prv.cdg_empresa   = Opg_header.cdg_empresa
             AND   Sub_header_prv.nro_proveedor = Opg_header.nro_proveedor
                   EXCLUSIVE-LOCK NO-ERROR.       
      
        IF AVAILABLE Sub_header_prv THEN Sub_header_prv.anulado = YES.
      
        FOR EACH Cta_cte_prv 
             WHERE Cta_cte_prv.nro_comprob   = Opg_header.nro_comprob 
             AND   Cta_cte_prv.prf_comprob   = Opg_header.prf_comprob
             AND   Cta_cte_prv.tip_comprob   = Opg_header.tip_comprob
             AND   Cta_cte_prv.cdg_empresa   = Opg_header.cdg_empresa
             AND   Cta_cte_prv.nro_proveedor = Opg_header.nro_proveedor       
                   EXCLUSIVE-LOCK:       
    
              act_ctacte_prv = ROWID(Cta_cte_prv).
              RUN ACUMCCPV.P (INPUT "B").
              RUN ACUMPAGO.P (INPUT "B").
              DELETE Cta_cte_prv.
    
        END.      

        FOR EACH Aplicacion_pagos_prv
            WHERE   Aplicacion_pagos_prv.nro_proveedor    = Opg_header.nro_proveedor
              AND   Aplicacion_pagos_prv.cdg_empresa      = Opg_header.cdg_empresa
              AND   Aplicacion_pagos_prv.tip_comprob      = Opg_header.tip_comprob
              AND   Aplicacion_pagos_prv.prf_comprob      = Opg_header.prf_comprob
              AND   Aplicacion_pagos_prv.nro_comprob      = Opg_header.nro_comprob
                    EXCLUSIVE-LOCK:

              DELETE Aplicacion_pagos_prv.

        END.
      
        Opg_header.anulado = YES.
    END.

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

   RUN getparametro.p (  INPUT  "NFORDPAG",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   que_rutina = "PROPG" + STRING(v-valor_n, "999") + ".P".

   RUN getparametro.p (  INPUT  "NCOPIAOP",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   ncopias = v-valor_n.

   RUN getparametro.p (  INPUT  "OPAGHOJA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   DO j = 1 TO ncopias:
      IF v-valor_l
      THEN DO:
         MESSAGE "Por Favor, coloque formulario en la impresora para" 
                 + " imprimir copia de O/Pago Nro.:" + STRING(j,"9")
                 VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresion".
      END.           

      RUN VALUE(que_rutina) (INPUT ROWID(Opg_header)).

   END.
     
END PROCEDURE.

PROCEDURE CREAR_CAJA:

   CREATE Caj_header.
   ASSIGN 
          Caj_header.fecha           = TODAY
          Caj_header.hora            = TIME
          Caj_header.nro_proveedor   = Opg_header.nro_proveedor
          Caj_header.cdg_empresa     = Opg_header.cdg_empresa
          Caj_header.tip_comprob     = Opg_header.tip_comprob
          Caj_header.nro_comprob     = Opg_header.nro_comprob
          Caj_header.ultima_linea    = 0
          Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
          Caj_header.importe         = Opg_header.imp_total
          Caj_header.emitir          = NO
          Caj_header.cdg_caja        = Caja.cdg_caja
          Caj_header.nro_cuenta      = Cuenta.nro_cuenta
          Caj_header.nro_proveedor   = Proveedor.nro_proveedor
          Caj_header.observacion     = STRING(Proveedor.cdg_proveedor,"99999") + 
                                       "-" + Proveedor.nombre
          Caj_header.tipo_mov        = "E"
          Opg_header.nro_transaccion = Caj_header.nro_transaccion.
          
END PROCEDURE.

PROCEDURE HABILITAR_TOTAL:

  ASSIGN
     Opg_header.imp_total:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte_prv.tip_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte_prv.prf_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte_prv.nro_comprob:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte_prv.nro_vencimiento:BGCOLOR IN FRAME frm-documento = bg_c.
     Opg_header.imp_total:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte_prv.tip_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte_prv.prf_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte_prv.nro_comprob:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte_prv.nro_vencimiento:FGCOLOR IN FRAME frm-documento = fg_c.

END PROCEDURE.

PROCEDURE HABILITAR_CTACTE:

  ASSIGN
     Opg_header.imp_total:BGCOLOR IN FRAME frm-documento = bg_c.
     Cta_cte_prv.tip_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte_prv.prf_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte_prv.nro_comprob:BGCOLOR IN FRAME frm-documento = be_c.
     Cta_cte_prv.nro_vencimiento:BGCOLOR IN FRAME frm-documento = be_c.
     Opg_header.imp_total:FGCOLOR IN FRAME frm-documento = fg_c.
     Cta_cte_prv.tip_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte_prv.prf_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte_prv.nro_comprob:FGCOLOR IN FRAME frm-documento = fe_c.
     Cta_cte_prv.nro_vencimiento:FGCOLOR IN FRAME frm-documento = fe_c.

END PROCEDURE.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
