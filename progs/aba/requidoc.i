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

DEFINE NEW SHARED VARIABLE emitir_ocompra  AS LOGICAL LABEL "Emitir Requisici¢n".
DEFINE NEW SHARED VARIABLE hubo_cambio     AS LOGICAL.
DEFINE NEW SHARED VARIABLE rid_header      AS ROWID.
DEFINE NEW SHARED VARIABLE rid_fcomercial  AS ROWID.

DEFINE VARIABLE tg_handle            AS HANDLE.

DEFINE VARIABLE cntrl_deuda          AS LOGICAL.
DEFINE VARIABLE hay_det_pendientes   AS LOGICAL.
DEFINE VARIABLE hay_ent_pendientes   AS LOGICAL.
DEFINE VARIABLE saldo_cc             AS DECIMAL.
DEFINE VARIABLE saldo_ccv            AS DECIMAL.
DEFINE VARIABLE cotiza_dolar         AS DECIMAL.
DEFINE VARIABLE tot_valores          AS DECIMAL.
DEFINE VARIABLE tot_remitos          AS DECIMAL.
DEFINE VARIABLE tot_ocompras         AS DECIMAL.
DEFINE VARIABLE tot_credito          AS DECIMAL.
DEFINE VARIABLE dis_credito          AS DECIMAL.
DEFINE VARIABLE cant_rech            AS INTEGER.     

DEFINE VARIABLE tipos_validos  AS CHARACTER.
DEFINE VARIABLE mensaje        AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE codigo_dolar  LIKE Moneda.cdg_moneda.

DEFINE BUFFER B-T-Rqs_header       FOR T-Rqs_header.
DEFINE BUFFER B-Rqs_detalle      FOR Rqs_detalle.
DEFINE BUFFER Deposito-rep         FOR Deposito.

DEFINE WORK-TABLE T-Sub_header_prv  LIKE Sub_header_prv.
DEFINE WORK-TABLE T-Sub_detalle_prv LIKE Sub_detalle_prv.

DEFINE VARIABLE ant_area   AS ROWID.
DEFINE VARIABLE v-tip_comprob LIKE T-Rqs_header.tip_comprob INITIAL "PI".

DEFINE VARIABLE que_tipo      LIKE T-Rqs_header.tip_comprob.
DEFINE VARIABLE que_numero    LIKE T-Rqs_header.nro_comprob.

DEFINE BUTTON btn_embarque
     LABEL "&Embarque":L 
     SIZE 17 BY 1.12 FONT 4.

DEFINE BUTTON btn_copiar
     LABEL "&Copiar":L 
     SIZE 17 BY 1.12 FONT 4.

DEFINE BUTTON btn_novedad
     LABEL "No&vedades":L 
     SIZE 17 BY 1.12 FONT 4.

DEFINE BUTTON btn_ncopias
     LABEL "&N.Copias":L 
     SIZE 17 BY 1.12 FONT 4.

FORM 
     mensaje NO-LABEL
     WITH FRAME frm-espere OVERLAY
          TITLE "Aguarde un momento por favor" FONT 8
          CENTERED ROW 7 FGCOLOR 14 BGCOLOR 1.

DEFINE RECTANGLE rtn_pantallas
       EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
       SIZE 17.5 BY 3.2.

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
     T-Rqs_header.tip_comprob AT ROW 3.81 COL 14 COLON-ALIGNED
          LABEL "Pedido"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.nro_comprob AT ROW 3.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 9.72 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.fecha AT ROW 3.81 COL 47 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.version AT ROW 3.81 COL 67 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     ver  AT ROW 3.71 COL 97 COLON-ALIGNED
          VIEW-AS RADIO-SET VERTICAL
          SIZE 11 BY 1.32
          NO-LABEL FGCOLOR fg_c
     RECT-1 AT ROW 3.42 COL 95
     Area.cdg_area AT ROW 4.81 COL 14 COLON-ALIGNED
          LABEL "Area"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Area.denominacion AT ROW 4.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.prioridad AT ROW 4.81 COL 85 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c 

     T-Rqs_header.cdg_solicitante AT ROW 5.81 COL 14 COLON-ALIGNED
          LABEL "Solicitante"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Solicitante.nombre AT ROW 5.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.es_reposicion AT ROW 5.81 COL 79 COLON-ALIGNED NO-LABEL
          VIEW-AS TOGGLE-BOX 
          SIZE 10 BY .81
          FGCOLOR fg_c 

     T-Rqs_header.cdg_deposito AT ROW 6.81 COL 14 COLON-ALIGNED
          LABEL "Depósito"
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Deposito.nombre AT ROW 6.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.anulado AT ROW 6.81 COL 79 COLON-ALIGNED NO-LABEL
          VIEW-AS TOGGLE-BOX 
          SIZE 10 BY .81
          FGCOLOR fg_c 

     T-Rqs_header.cdg_deposito-rep AT ROW 7.81 COL 14 COLON-ALIGNED
          LABEL "Reponer Dep."
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Deposito-rep.nombre AT ROW 7.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 

     T-Rqs_header.cdg_estado AT ROW 8.81 COL 14 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 15 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     Estado_pedido.descripcion AT ROW 8.81 COL 30 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 42 BY .81
          BGCOLOR bg_c FGCOLOR fg_c 

     SKIP(0.0)
     btn_ncopias AT ROW 1 COL 1
     btn_novedad AT ROW 1 COL 1
     btn_copiar  AT ROW 1 COL 1
     rtn_pantallas  AT COLUMN 1 ROW 1     
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
/*
     T-Rqs_header.tip_comprob AT ROW 2.81 COL 12 COLON-ALIGNED
          LABEL "Requisición"
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.nro_comprob AT ROW 2.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 10.22 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.fecha AT ROW 2.75 COL 36 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 11 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.version AT ROW 2.75 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     ver NO-LABEL FGCOLOR fg_c          
     Area.cdg_area AT ROW 3.75 COL 12 COLON-ALIGNED
          LABEL "Area"
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     Area.denominacion AT ROW 3.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.prioridad AT ROW 3.75 COL 59 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     T-Rqs_header.cdg_solicitante AT ROW 4.75 COL 12 COLON-ALIGNED
          LABEL "Solicitante"
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     Solicitante.nombre AT ROW 4.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.es_reposicion AT ROW 4.75 COL 59 COLON-ALIGNED NO-LABEL
          VIEW-AS TOGGLE-BOX 
          SIZE 10 BY .75
          FGCOLOR fg_c 
     btn_ncopias AT ROW 3.75 COL 66
     btn_novedad AT ROW 4.75 COL 66
     btn_copiar AT ROW 5.75 COL 66
     T-Rqs_header.cdg_deposito AT ROW 5.75 COL 12 COLON-ALIGNED
          LABEL "Depósito"
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     Deposito.nombre AT ROW 5.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.anulado AT ROW 5.75 COL 59 COLON-ALIGNED NO-LABEL
          VIEW-AS TOGGLE-BOX 
          SIZE 10 BY .75
          FGCOLOR fg_c 
     T-Rqs_header.cdg_deposito-rep AT ROW 6.75 COL 12 COLON-ALIGNED
          LABEL "Reponer Dep."
          VIEW-AS FILL-IN 
          SIZE 5 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     Deposito-rep.nombre AT ROW 6.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
     T-Rqs_header.cdg_estado AT ROW 7.75 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5.11 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
     Estado_pedido.descripcion AT ROW 7.75 COL 18 COLON-ALIGNED NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
*/
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

DEFINE NEW SHARED MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo".

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

/* ------------------------ Modificacion de Requisici¢n ------------------------------*/

RUN TGBDREQU.P PERSISTENT SET tg_handle.

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

/*                      Marca reposicion o no                                       */ 

ON VALUE-CHANGED OF T-Rqs_header.es_reposicion IN FRAME frm-documento
DO:
  IF INPUT T-Rqs_header.es_reposicion 
  THEN DO:
       ENABLE T-Rqs_header.cdg_deposito-rep
               WITH FRAME frm-documento.

  END.
  ELSE DO:
       DISABLE T-Rqs_header.cdg_deposito-rep
               WITH FRAME frm-documento.
       DISPLAY " " @ T-Rqs_header.cdg_deposito-rep
               " " @ Deposito-rep.nombre
               WITH FRAME frm-documento.
       RELEASE Deposito-rep.        
  END.
END.  


/*                      Copias por area                                        */ 

ON CHOOSE OF BTN_NCOPIAS IN FRAME frm-documento
DO:
  act_rqs_head = ROWID(T-Rqs_header).
  RUN ACTNCREQ.P. 
  RUN PONER_SESION.
  APPLY "VALUE-CHANGED" TO ver IN FRAME frm-documento.  
END.

/*                      Novedades de Requisici¢n                                  */ 

ON CHOOSE OF btn_novedad IN FRAME frm-documento
DO:
  act_rqs_head = ROWID(T-Rqs_header).
  RUN SHWNVRQS.P ( INPUT modo ). 
  RUN PONER_SESION.
  APPLY "VALUE-CHANGED" TO ver IN FRAME frm-documento.  
END.

/*                              Copiar un Requisici¢n                                */ 

ON CHOOSE OF BTN_COPIAR IN FRAME frm-documento
DO:
  RUN COPIAR_REQUIS.
END.

ON VALUE-CHANGED OF ver IN FRAME frm-documento
DO:
  IF NOT AVAILABLE Area 
  THEN DO:
       ver:SCREEN-VALUE IN FRAME frm-documento = "2".
       RUN PONMENSJ.P ( INPUT "REQU019").
       RETURN NO-APPLY.
  END.

  IF NOT AVAILABLE Deposito 
  THEN DO:
       ver:SCREEN-VALUE IN FRAME frm-documento = "2".
       RUN PONMENSJ.P ( INPUT "REQU020").
       RETURN NO-APPLY.
  END.

  RUN DATOS_DETALLE.

END.  


/*=============================  HELPS ===============================================*/

&SCOPED-DEFINE ENTIDAD          T-Rqs_header

{HLPSECT2.I ""                "frm-documento" "YES" "NO" }  /* Area                 */
{HLPARTIC.I ""                "frm-detalle"   "NO"  "NO" }  /* Articulos              */
{HLPDEPED.I "cdg_deposito"    "frm-documento" "YES" "YES"}  /* Deposito               */
{HLPDPREP.I "cdg_deposito-rep" "frm-documento" "YES" "YES"}  /* Deposito de reposicion */
{HLPSOLIC.I "cdg_solicitante" "frm-documento" "YES" "YES"}  /* Solicitante            */
/*
{HLPCOMPR.I ""                "frm-documento" "YES" "YES"}  /* Comprador              */
*/
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

      RUN FINAL_REQUIS.
       
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

  IF NOT CAN-FIND(FIRST Rqs_detalle OF  T-Rqs_header)
  THEN DO:
     RUN PONMENSJ.P (INPUT "REQU001").
     RETURN.
  END.

   ASSIGN FRAME frm-documento 
     T-Rqs_header.fecha
     T-Rqs_header.cdg_deposito
     T-Rqs_header.cdg_deposito-rep
     T-Rqs_header.cdg_solicitante
     T-Rqs_header.prioridad
     T-Rqs_header.es_reposicion.

 {IFNOTAVA.I "Area" "REQU002" }
 {IFNOTEXS.I "Solicitante" "cdg_solicitante" "frm-documento" "T-Rqs_header" "cdg_solicitante" "REQU004" }
 {IFNOTEXS.I "Deposito" "cdg_deposito" "frm-documento" "T-Rqs_header" "cdg_deposito" "REQU005" }
 /*{IFNOTAVA.I "Comprador" "REQU010" }*/


  IF T-Rqs_header.es_reposicion
  THEN DO:
      IF T-Rqs_header.cdg_deposito = T-Rqs_header.cdg_deposito-rep
      THEN DO:
           RUN PONMENSJ.P ( INPUT "REQU015" ).
           RETURN.
      END.
      ELSE DO: 
      {IFNOTEXS.I "Deposito-rep" "cdg_deposito" "frm-documento" "T-Rqs_header" "cdg_deposito-rep" "REQU014" }
      END.
  END.
 
  IF T-Rqs_header.prioridad <> 10  AND
     T-Rqs_header.prioridad <> 20  AND
     T-Rqs_header.prioridad <> 30
  THEN DO:
     RUN PONMENSJ.P (INPUT "REQU011").
     RETURN.
  END.

  IF Deposito.recibe_pedidos <> "S"
  THEN DO:
       RUN PONMENSJ.P (INPUT "DEPO005").
       RETURN.
  END.

  IF AVAILABLE Deposito-rep
  THEN DO:
       IF NOT CAN-FIND(FIRST Sector-deposito OF Area 
                        WHERE Sector-deposito.cdg_deposito = Deposito-rep.cdg_deposito
                          AND Sector-deposito.modo_relacion = "A")
       THEN DO:
            RUN PONMENSJ.P (INPUT "DEPO006").
            RETURN.
       END.
  END.     

  hubo_error = NO.

END PROCEDURE.

PROCEDURE CALCULOS:

END PROCEDURE.

PROCEDURE PONER_DEPOSITO:

    IF Deposito.recibe_pedidos <> "S"
    THEN DO:
         no_aplicar = YES.
         RUN PONMENSJ.P (INPUT "DEPO005").
         RETURN.
    END.

END PROCEDURE.

PROCEDURE PONER_DEPOSITO_REP:

    IF NOT CAN-FIND(FIRST Sector-deposito OF Area 
                          WHERE Sector-deposito.cdg_deposito = Deposito-rep.cdg_deposito
                            AND Sector-deposito.modo_relacion = "A")
    THEN DO:
         no_aplicar = YES.
         RUN PONMENSJ.P (INPUT "DEPO006").
         RETURN.
    END.

END PROCEDURE.

PROCEDURE TRAER_SECTOR:

  IF ROWID(Area) = ant_area
     THEN RETURN.

  RUN PONER_SECTOR.

END PROCEDURE.

PROCEDURE PONER_SECTOR:

  ASSIGN
      T-Rqs_header.nro_area  = Area.nro_area
      act_area = ROWID(Area).
  
  DISPLAY  Area.cdg_area
           Area.denominacion                 
           WITH FRAME frm-documento.
           
   ENABLE
        Area.cdg_area  WHEN NOT T-Rqs_header.anulado
        T-Rqs_header.cdg_solicitante WHEN NOT T-Rqs_header.anulado
        T-Rqs_header.es_reposicion WHEN NOT T-Rqs_header.anulado
        T-Rqs_header.cdg_deposito WHEN NOT T-Rqs_header.anulado
        BTN_GRABAR
        BTN_CANCEL
        WITH FRAME frm-documento.
     
END PROCEDURE.                      

PROCEDURE ASIGNAR_DETALLE:

/*
     FIND FIRST Articulo_precio OF Articulo 
          WHERE Articulo_precio.cdg_lista = Lista_precio.cdg_lista NO-LOCK NO-ERROR. 
     IF AVAILABLE Articulo_precio THEN Rqs_detalle.precio = Articulo_precio.precio.
                                  ELSE Rqs_detalle.precio = Articulo.precio.
*/
     DISABLE btn_copiar WITH FRAME frm-documento.

     hubo_cambio = YES.

END PROCEDURE.

PROCEDURE ASIGNAR_IMPUTACION:

    FIND Cuenta OF Imputacion NO-LOCK.
       
END PROCEDURE.


PROCEDURE TRAER_DOCUMENTO:

   hay_error = YES.
   /*
   IF T-Rqs_header.anulado AND T-Rqs_header.origen = "A"
   THEN DO:
      RUN PONMENSJ.P (INPUT "REQU017").
      RETURN.
   END.   
   */
   FIND Area              OF T-Rqs_header NO-LOCK.
   FIND Deposito          OF T-Rqs_header NO-LOCK.
   FIND Solicitante       OF T-Rqs_header NO-LOCK.   
   FIND Estado_pedido     OF T-Rqs_header NO-LOCK NO-ERROR.
   IF T-Rqs_header.es_reposicion
      THEN FIND Deposito-rep  WHERE Deposito-rep.cdg_deposito = T-Rqs_header.cdg_deposito-rep NO-LOCK.

   DISPLAY

        T-Rqs_header.tip_comprob 
        T-Rqs_header.nro_comprob 
        T-Rqs_header.version
        T-Rqs_header.fecha 
        T-Rqs_header.prioridad 
        T-Rqs_header.es_reposicion 
        T-Rqs_header.cdg_estado
        T-Rqs_header.anulado
        Estado_pedido.descripcion WHEN AVAILABLE Estado_pedido

        Area.cdg_area
        Area.denominacion

        T-Rqs_header.cdg_deposito-rep WHEN T-Rqs_header.es_reposicion
        Deposito-rep.nombre WHEN T-Rqs_header.es_reposicion

        T-Rqs_header.cdg_deposito
        Deposito.nombre

        T-Rqs_header.cdg_solicitante
        Solicitante.nombre
           
        WITH FRAME frm-documento.
        
   DISABLE btn_copiar WITH FRAME frm-documento.
   ENABLE  btn_novedad WITH FRAME frm-documento.
   hay_error = NO.
   act_rqs_head = ROWID(T-Rqs_header).
   IF T-Rqs_header.nro_comprob:SENSITIVE THEN APPLY "TAB" TO T-Rqs_header.nro_comprob.

END PROCEDURE.

PROCEDURE ANULAR_DOCUMENTO:

         message "VA A ANULAR. FALTA DEFINIR HASTA CUANDO ESTA OPERACION ES POSIBLE (ESTADOS)" 
                  view-as alert-box message TITLE "MENSAJE DE DESARROLLO".

  FOR EACH Rqs_detalle OF T-Rqs_header EXCLUSIVE-LOCK:
      Rqs_detalle.cdg_estado =  "ZZ".
  END.    
  FOR EACH Rqs_detalle_ent OF T-Rqs_header EXCLUSIVE-LOCK:
      Rqs_detalle_ent.cdg_estado =  "ZZ".
  END.    

  T-Rqs_header.anulado = YES.
  T-Rqs_header.cdg_estado = "ZZ".

  RUN GRABAR_DOCUMENTO.

  puede_anular = YES.

END PROCEDURE.

PROCEDURE REIMPRIMIR_DOCUMENTO:

     FIND Parametro "NFREQUIS" NO-LOCK NO-ERROR.
     RUN VALUE("PRRQS" + STRING(Parametro.valor_n, "999") + ".P") (INPUT ROWID(T-Rqs_header)).

END PROCEDURE.

PROCEDURE COPIAR_REQUIS:

  act_rqs_head = ROWID(T-Rqs_header).
  RUN COREQUIS.P ( INPUT tipos_validos ). 
  RUN PONER_SESION.
  IF ult_rqs_head <> ?
  THEN DO:
     RUN COPIARQS.P.
     RUN TRAER_DOCUMENTO.
     DISABLE btn_copiar WITH  FRAME frm-documento.
  END.  
  
END PROCEDURE.

PROCEDURE INICIAR_DOCUMENTO:

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
   FIND Deposito WHERE Deposito.cdg_deposito = v-valor_n 
                       NO-LOCK.
   act_deposito = ROWID(Deposito).

   RUN getparametro.p (  INPUT  "DFCNRMPV",
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

      btn_copiar:ROW        = T-Rqs_header.cdg_solicitante:ROW. 
      btn_novedad:ROW       = btn_copiar:ROW  + 1.
      btn_ncopias:ROW       = btn_novedad:ROW  + 1.
      
      btn_copiar:COLUMN     = 95.
      btn_novedad:COLUMN    = 95.
      btn_ncopias:COLUMN    = 95. 

      rtn_pantallas:ROW        = btn_copiar:ROW  - 0.10.
      rtn_pantallas:COLUMN     = btn_copiar:COLUMN  - 0.25.

   END.

   tipos_validos = "PI".

END PROCEDURE.

PROCEDURE INICIAR_CICLO:

   act_area  = ?.
   ult_area  = ?.
   act_articulo = ?.
   ult_articulo = ?.
   FIND Moneda WHERE ROWID(Moneda) = act_moneda NO-LOCK. 
   hubo_cambio = NO.

END PROCEDURE.

PROCEDURE BORRAR_DETALLE:

    /*
    FOR EACH Especificacion_detalle OF Rqs_detalle EXCLUSIVE-LOCK:
        DELETE Especificacion_detalle.
    END. 
    */
    
    hubo_cambio = YES.

END PROCEDURE.

PROCEDURE FINAL_REQUIS:

  IF hubo_cambio THEN T-Rqs_header.version = T-Rqs_header.version + 1.

END PROCEDURE.

PROCEDURE VER_PENDIENTES:

  /*
  RELEASE T-Rqs_header.
  IF hubo_cambio AND modo <> 0 THEN RUN EMIREQUIS.P.
  */

END PROCEDURE.

PROCEDURE LIBERA_TABLAS:

    RELEASE Area.          
    RELEASE Articulo.         
    RELEASE Consignatario.    
    RELEASE Estado_pedido.   
    RELEASE Solicitante.

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


{&A-TABLA}Rqs_header.anulado          = {&DE-TABLA}Rqs_header.anulado
{&A-TABLA}Rqs_header.cambio           = {&DE-TABLA}Rqs_header.cambio
{&A-TABLA}Rqs_header.cambio_dolar     = {&DE-TABLA}Rqs_header.cambio_dolar
{&A-TABLA}Rqs_header.cdg_deposito     = {&DE-TABLA}Rqs_header.cdg_deposito
{&A-TABLA}Rqs_header.cdg_deposito-rep = {&DE-TABLA}Rqs_header.cdg_deposito-rep
{&A-TABLA}Rqs_header.cdg_empresa      = {&DE-TABLA}Rqs_header.cdg_empresa
{&A-TABLA}Rqs_header.cdg_estado       = {&DE-TABLA}Rqs_header.cdg_estado
{&A-TABLA}Rqs_header.nro_area         = {&DE-TABLA}Rqs_header.nro_area
{&A-TABLA}Rqs_header.cdg_solicitante  = {&DE-TABLA}Rqs_header.cdg_solicitante
{&A-TABLA}Rqs_header.cumplido         = {&DE-TABLA}Rqs_header.cumplido
{&A-TABLA}Rqs_header.estado           = {&DE-TABLA}Rqs_header.estado
{&A-TABLA}Rqs_header.es_reposicion    = {&DE-TABLA}Rqs_header.es_reposicion
{&A-TABLA}Rqs_header.fecha            = {&DE-TABLA}Rqs_header.fecha
{&A-TABLA}Rqs_header.imp_neto         = {&DE-TABLA}Rqs_header.imp_neto
{&A-TABLA}Rqs_header.imp_total        = {&DE-TABLA}Rqs_header.imp_total
{&A-TABLA}Rqs_header.leyenda          = {&DE-TABLA}Rqs_header.leyenda
{&A-TABLA}Rqs_header.modificado       = {&DE-TABLA}Rqs_header.modificado
{&A-TABLA}Rqs_header.nro_comprador    = {&DE-TABLA}Rqs_header.nro_comprador
{&A-TABLA}Rqs_header.nro_comprob      = {&DE-TABLA}Rqs_header.nro_comprob
{&A-TABLA}Rqs_header.nro_entidad      = {&DE-TABLA}Rqs_header.nro_entidad
{&A-TABLA}Rqs_header.nro_moneda       = {&DE-TABLA}Rqs_header.nro_moneda
{&A-TABLA}Rqs_header.nro_ocompra      = {&DE-TABLA}Rqs_header.nro_ocompra
{&A-TABLA}Rqs_header.nro_requisicion  = {&DE-TABLA}Rqs_header.nro_requisicion
{&A-TABLA}Rqs_header.nro_usuario      = {&DE-TABLA}Rqs_header.nro_usuario
{&A-TABLA}Rqs_header.org_estado       = {&DE-TABLA}Rqs_header.org_estado
{&A-TABLA}Rqs_header.origen           = {&DE-TABLA}Rqs_header.origen
{&A-TABLA}Rqs_header.sin_cargo        = {&DE-TABLA}Rqs_header.sin_cargo
{&A-TABLA}Rqs_header.tip_comprob      = {&DE-TABLA}Rqs_header.tip_comprob
{&A-TABLA}Rqs_header.ultima_linea     = {&DE-TABLA}Rqs_header.ultima_linea
{&A-TABLA}Rqs_header.version          = {&DE-TABLA}Rqs_header.version

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
