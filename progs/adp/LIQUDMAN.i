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

DEFINE BUFFER B-Empleado FOR Empleado.
DEFINE BUFFER C-Empleado FOR Empleado.
DEFINE BUFFER B-Rango_liquidacion FOR Rango_liquidacion.

DEFINE QUERY qry_legajos  FOR Rango_liquidacion, C-Empleado, B-Empleado, Tipo_de_liquidac.

DEFINE BROWSE brw_legajos QUERY qry_legajos
       DISPLAY Rango_liquidacion.desde_legajo
               C-Empleado.nombre FORMAT "X(20)"
               ( IF Rango_liquidacion.hasta_legajo <> Rango_liquidacion.desde_legajo
                    THEN STRING(Rango_liquidacion.hasta_legajo,"ZZZZZ9")
                    ELSE " " ) COLUMN-LABEL "Hasta"
               ( IF Rango_liquidacion.hasta_legajo <> Rango_liquidacion.desde_legajo
                    THEN B-Empleado.nombre 
                    ELSE " " ) COLUMN-LABEL "Ap.y Nombre" FORMAT "X(20)"
               Tipo_de_liquidac.cdg_liquid 
               Tipo_de_liquidac.descripcion  FORMAT "X(15)"   
       WITH 12 DOWN NO-UNDERLINE FONT 4 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Rangos de legajos a liquidar con esta liquidacion".

DEFINE BUTTON BTN_TODOS
     LABEL "&Todos":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON BTN_LIQUIDAR
     LABEL "Li&quidar":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON BTN_COPIAR
     LABEL "&Copiar":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE BUTTON BTN_TOTALES
     LABEL "&Ver Totales":L 
     SIZE 10 BY 0.9 FONT 4.

DEFINE RECTANGLE rtn_operaciones
       EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
       SIZE 12 BY 4.2.
     
DEFINE NEW SHARED VARIABLE registro       AS LOGICAL INITIAL NO.
     
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

    SKIP(0.1)    
    Liquidacion.sec_liquidacion  AT ROW 2.81 COL 12 COLON-ALIGNED
          LABEL "Liquidación"
          VIEW-AS FILL-IN 
          SIZE 10 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
    Liquidacion.descripcion   AT ROW 2.81 COL 27 COLON-ALIGNED
          LABEL "Descripción" 
          VIEW-AS FILL-IN 
          SIZE 39 BY .81
          BGCOLOR be_c FGCOLOR fe_c 
    BTN_COPIAR TO 85
    SKIP(0.1)
    Liquidacion.reset_datos  AT ROW 3.81 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    Liquidacion.firme  AT ROW 3.81 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR bg_c FGCOLOR fg_c
    Liquidacion.procesada  AT ROW 3.81 COL 42 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR bg_c FGCOLOR fg_c
    Liquidacion.fecha   AT ROW 3.81 COL 57 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    BTN_TODOS TO 85
    SKIP(0.1)
    Liquidacion.n_periodo   AT ROW 4.81 COL 12 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    Liquidacion.ano   AT ROW 4.81 COL 27 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 5 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    Liquidacion.fecha_liq   AT ROW 4.81 COL 57 COLON-ALIGNED
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    BTN_LIQUIDAR TO 85
    SKIP(0.1)    
    Empleado.nro_legajo    AT ROW 5.81 COL 12 COLON-ALIGNED
          LABEL "Legajo"
          VIEW-AS FILL-IN 
          SIZE 9 BY .81
          BGCOLOR be_c FGCOLOR fe_c
    registro   AT ROW 5.81 COL 27 COLON-ALIGNED
          LABEL "Seguimiento"
          VIEW-AS TOGGLE-BOX 
          SIZE 12 BY .81
          FGCOLOR fe_c

    BTN_TOTALES  TO 85
    brw_legajos  AT ROW 7 COL 1
    rtn_operaciones AT ROW 1 COLUMN 1
       
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

DEFINE SUB-MENU Reportes
   MENU-ITEM Auditoria              LABEL "&Auditoria".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Reportes               LABEL "&Reportes".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTLIQUD"  "(INPUT 0)"}
{TRIGMENU.I "Auditoria"    "Reportes"      "LSAUDLIQ"  "(INPUT ROWID(Liquidacion))"}

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

/*--------------------- Tratamiendo del browse de rangos de legajos -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     NO
&SCOPED-DEFINE BROWSE           brw_legajos
&SCOPED-DEFINE ACT_REGBROWSE    act_rng_legajos
&SCOPED-DEFINE ULT_REGBROWSE    ult_rng_legajos
&SCOPED-DEFINE TABLA-BRW        Rango_liquidacion
&SCOPED-DEFINE TABLA-MASTER     Liquidacion
&SCOPED-DEFINE ACTREGIS         ACTRNGLG
&SCOPED-DEFINE QRY_BROWSE       qry_legajos
&SCOPED-DEFINE QRY_CONDICION    ~
   Rango_liquidacion OF Liquidacion, ~
   FIRST C-Empleado WHERE C-Empleado.nro_legajo = Rango_Liquidacion.desde_legajo, ~
   FIRST B-Empleado WHERE B-Empleado.nro_legajo = Rango_Liquidacion.hasta_legajo, ~
   FIRST Tipo_de_liquidac LEFT OUTER-JOIN OF Rango_Liquidacion ~
   BY C-Empleado.nro_legajo
&SCOPED-DEFINE MENSAJE-VACIO    No hay Rangos de Legajos asociados a la liquidacion
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea eliminar este rango?

{TRGBROWS.I}

/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Liquidacion


       /* -------------- Empleado en Liquidacion para rango ----------------------*/

&SCOPED-DEFINE TABLA            Empleado
&SCOPED-DEFINE CODIGO           nro_legajo
&SCOPED-DEFINE NOMBRE           nombre
&SCOPED-DEFINE RUTINA           SELEMPLE
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_empleado
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          NO
&SCOPED-DEFINE ALTA-MODIF       ACTEMPLE
&SCOPED-DEFINE ULT_REGISTRO     ult_empleado
&SCOPED-DEFINE ALT-MOD          YES

{TRIGSELC.I} 

/*=================== F I N   D E   L O S   H E L P S ======================*/

/*----------------------------------------------------------------------------------*/
/*          ALTAS/CAMBIOS DE REGISTROS ESCLAVOS DE DETALLE Y FIN DEL INGRESO        */
/*----------------------------------------------------------------------------------*/

ON RETURN OF Empleado.nro_legajo IN FRAME frm-entidad
DO:

   IF INPUT Empleado.nro_legajo = 0
   THEN DO:
      sino = YES.
      MESSAGE "Confirme con OK que desea proceder a grabar" 
              VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO 
              TITLE "Confirmacion de la grabacion" UPDATE sino.
      IF sino 
      THEN DO:
         sino_salir = NO.
         sino_cancel = NO.
         APPLY "U1" TO FRAME frm-entidad.
         RETURN NO-APPLY.   
      END.
      ELSE DO:
         RETURN NO-APPLY.
      END.
   END.   
   ELSE DO:
      FIND Empleado USING nro_legajo NO-ERROR.
      IF NOT AVAILABLE Empleado
      THEN DO:
         RUN PONMENSJ.P (INPUT "LIQU005").
      END.
      ELSE DO:
         IF CAN-FIND(FIRST B-Rango_liquidacion OF Liquidacion
                     WHERE B-Rango_liquidacion.desde_legajo <= Empleado.nro_legajo
                       AND B-Rango_liquidacion.hasta_legajo >= Empleado.nro_legajo)
         THEN DO:
            RUN PONMENSJ.P (INPUT "LIQU006").
         END.            
         ELSE DO:
            act_empleado = ROWID(Empleado).
            CREATE Rango_liquidacion.
            ASSIGN 
                Rango_liquidacion.sec_liquidacion = Liquidacion.sec_liquidacion
                Rango_liquidacion.desde_legajo    = Empleado.nro_legajo
                Rango_liquidacion.hasta_legajo    = Empleado.nro_legajo.
            RUN ABRE_QUERY.
         END.                  
      END.
   END.   
   DISPLAY "" @ Empleado.nro_legajo WITH FRAME frm-entidad.
   Empleado.nro_legajo:CURSOR-OFFSET IN FRAME frm-entidad = 1.
   RETURN NO-APPLY.
END.

ON CHOOSE OF BTN_TODOS IN FRAME frm-entidad
DO:

  IF CAN-FIND(FIRST Rango_liquidacion OF Liquidacion)
  THEN DO:
     sino = NO.
     BELL.
     MESSAGE "Existen rangos ya ingresados. Confirme que desea eliminarlos"
             "reemplazandolos por un rango unico que abarque a todos los empleados"
             VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO TITLE "Se pide confirmacion" 
             UPDATE sino.
     IF NOT sino THEN RETURN NO-APPLY.
  END.           

  FOR EACH B-Rango_liquidacion OF Liquidacion EXCLUSIVE-LOCK:
      DELETE B-Rango_liquidacion.
  END.
  
  CREATE Rango_liquidacion.
  ASSIGN Rango_liquidacion.sec_liquidacion = Liquidacion.sec_liquidacion.
  FIND FIRST Empleado USE-INDEX por_legajo.
  Rango_liquidacion.desde_legajo = Empleado.nro_legajo.
  FIND LAST Empleado USE-INDEX por_legajo.   
  Rango_liquidacion.hasta_legajo = Empleado.nro_legajo.
  RUN ABRE_QUERY.
  
END.

ON CHOOSE OF BTN_LIQUIDAR IN FRAME frm-entidad
DO:

  IF NOT CAN-FIND(FIRST Rango_liquidacion OF Liquidacion)
  THEN DO:
     RUN PONMENSJ.P (INPUT "LIQU007").
     RETURN NO-APPLY.
  END.           

  IF Liquidacion.procesada
  THEN DO:
     RUN PONMENSJ.P (INPUT "LIQU008").
     RETURN NO-APPLY.
  END.           

  IF CAN-FIND(FIRST Liquidacion WHERE procesada AND NOT firme)
  THEN DO:
     RUN PONMENSJ.P (INPUT "LIQU009").
     RETURN NO-APPLY.
  END.           

  RUN VALIDAR_REGISTRO.
  IF hay_error THEN RETURN NO-APPLY.

  ASSIGN Liquidacion.sec_liquidacion
         Liquidacion.descripcion
         Liquidacion.fecha
         Liquidacion.reset_datos
         Liquidacion.n_periodo 
         Liquidacion.fecha_liq          
         registro.

  FIND Parametro "DTLPERIO" NO-LOCK.
  FIND Constante WHERE Constante.cdg_constante = Parametro.valor_n EXCLUSIVE-LOCK.
  Constante.valor = Liquidacion.n_periodo.
  RELEASE Constante.

  FIND Parametro "DTLFECHA" NO-LOCK.
  FIND Constante WHERE Constante.cdg_constante = Parametro.valor_n EXCLUSIVE-LOCK.
  Constante.valor = DAY(Liquidacion.fecha_liq) * 10000 +
                    MONTH(Liquidacion.fecha_liq) * 100 +
                    (YEAR(Liquidacion.fecha_liq) MOD 100).
  RELEASE Constante.
     
  RUN LIQUIDAR.P.
  FIND Liquidacion WHERE ROWID(Liquidacion) = act_liquidacion EXCLUSIVE-LOCK.
  DISPLAY Liquidacion.procesada 
          Liquidacion.firme
          WITH FRAME frm-entidad.
  DISABLE Liquidacion.sec_liquidacion
          Liquidacion.descripcion
          Liquidacion.fecha
          Liquidacion.reset_datos
          Liquidacion.n_periodo 
          Liquidacion.fecha_liq 
          Empleado.nro_legajo
          BTN_TODOS
          BTN_LIQUIDAR
          WITH FRAME frm-entidad.

END.

ON CHOOSE OF BTN_COPIAR IN FRAME frm-entidad
DO:

  act_liquidacion = ROWID(Liquidacion).
  RUN COLIQUID.P. 
  RUN PONER_SESION.
  IF ult_liquidacion <> ?
  THEN DO:
     RUN COPIALIQ.P.
     FIND Liquidacion WHERE ROWID(Liquidacion) = act_liquidacion EXCLUSIVE-LOCK.
     DISABLE btn_copiar WITH  FRAME frm-entidad.
     DISPLAY Liquidacion.ano 
             Liquidacion.descripcion 
             Liquidacion.fecha 
             Liquidacion.fecha_liq 
             Liquidacion.n_periodo 
             Liquidacion.reset_datos 
             WITH FRAME frm-entidad.
     RUN ABRE_QUERY.
  END.  
  
END.  


ON CHOOSE OF BTN_TOTALES IN FRAME frm-entidad
DO:

  act_liquidacion = ROWID(Liquidacion).
  RUN VTOTALES.P. 
  
END.  

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

DO WITH FRAME frm-entidad:
   rtn_operaciones:ROW = btn_copiar:ROW - 0.1.
   rtn_operaciones:COLUMN = btn_copiar:COLUMN - 1.
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
&IF {&SECCION} = "VALIDACION"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/


     IF ROWID(Liquidacion) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "LIQU000").
        RETURN.
     END.


     IF Liquidacion.procesada 
     THEN DO:
        hay_error = NO.
        RETURN.
     END.   

     IF INPUT FRAME frm-entidad Liquidacion.descripcion = "" OR 
        INPUT FRAME frm-entidad Liquidacion.descripcion = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "LIQU001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Liquidacion 
                       WHERE Liquidacion.sec_liquidacion = INPUT FRAME frm-entidad Liquidacion.sec_Liquidacion
                         AND ROWID(Liquidacion) <> act_liquidacion )
     THEN DO:
        RUN PONMENSJ.P (INPUT "LIQU002").
        RETURN.
     END.            

     IF INPUT FRAME frm-entidad Liquidacion.n_periodo < 1 OR 
        INPUT FRAME frm-entidad Liquidacion.n_periodo > 12  
     THEN DO:
        RUN PONMENSJ.P (INPUT "LIQU013").
        RETURN.
     END.            

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

PROCEDURE DESHABILITAR_PROCESADA:

  IF Liquidacion.procesada 
  THEN DO:
     DISABLE Liquidacion.sec_liquidacion
             Liquidacion.descripcion
             Liquidacion.fecha
             Liquidacion.reset_datos
             Liquidacion.ano 
             Liquidacion.n_periodo 
             Liquidacion.fecha_liq 
             Empleado.nro_legajo
             BTN_COPIAR
             BTN_TODOS
             BTN_LIQUIDAR
             WITH FRAME frm-entidad.
     ENABLE  BTN_TOTALES
             WITH FRAME frm-entidad.
  END.

END PROCEDURE.

PROCEDURE ABRE_QUERY:

  OPEN QUERY qry_legajos 
       FOR EACH  Rango_liquidacion OF Liquidacion, 
           FIRST C-Empleado WHERE C-Empleado.nro_legajo = Rango_Liquidacion.desde_legajo, 
           FIRST B-Empleado WHERE B-Empleado.nro_legajo = Rango_Liquidacion.hasta_legajo,
           FIRST Tipo_de_liquidac LEFT OUTER-JOIN OF Rango_liquidacion.
                  
END PROCEDURE.                  


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

