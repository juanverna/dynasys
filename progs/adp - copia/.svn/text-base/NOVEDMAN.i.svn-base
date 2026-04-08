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

DEFINE VARIABLE ver AS INTEGER LABEL "Ver"
       VIEW-AS RADIO-SET VERTICAL
       RADIO-BUTTONS "&Conceptos", 1, "&Datos" , 2, "&Estados", 3.

DEFINE QUERY qry_conceptos  FOR Accion_concepto, Concepto.
DEFINE QUERY qry_datosliq   FOR Accion_dato, Tit_dat_liquid.
DEFINE QUERY qry_estados    FOR Novedad_Estado, Estado.

DEFINE BROWSE brw_conceptos QUERY qry_conceptos 
       DISPLAY Concepto.cdg_concepto 
               Concepto.descripcion FORMAT "X(15)"
               Accion_concepto.op_concepto
               Accion_concepto.cant_liq
               Accion_concepto.cdg_datliq
               Accion_concepto.desde_valor 
               Accion_concepto.hasta_valor
       WITH 10 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Operaciones con Conceptos Optativos".

DEFINE BROWSE brw_datosliq QUERY qry_datosliq 
       DISPLAY Tit_dat_liquid.cdg_datliq 
               Tit_dat_liquid.descripcion
               Accion_dato.op_dato 
               Accion_dato.op_valor 
               Accion_dato.valor_fijo
       WITH 10 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Operaciones con Datos de liquidacion".

DEFINE BROWSE brw_estados QUERY qry_estados 
       DISPLAY Estado.cdg_estado
               Estado.descripcion  
       WITH 10 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Estados que pueden recibir esta novedad".


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
    SPACE(2)
    Novedad.cdg_novedad                   FGCOLOR fe_c BGCOLOR be_c COLON 12
    Novedad.descripcion                   FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.2)
    Novedad.cdg_estado_nov                FGCOLOR fe_c BGCOLOR be_c COLON 12
    Estado.descripcion                    FGCOLOR fg_c BGCOLOR bg_c NO-LABEL
    Novedad.carac_id                      FGCOLOR fe_c BGCOLOR be_c    
    SKIP(0.1)    
    SPACE(2)
    Novedad.valor_defecto                 FGCOLOR fe_c BGCOLOR be_c COLON 12
    Novedad.unidad                        FGCOLOR fe_c BGCOLOR be_c
    Novedad.abreviatura                   FGCOLOR fe_c BGCOLOR be_c    
    SKIP(0.1)
    SPACE(2)
    ver            AT ROW 3 COL 70
    brw_conceptos  AT ROW 6 COL 2
    brw_datosliq   AT ROW 6 COL 2
    brw_estados    AT ROW 6 COL 2
    SKIP(0.1)
       
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

DEFINE SUB-MENU Listados
   MENU-ITEM Novedades              LABEL "&Novedades Por C¢digo"
   MENU-ITEM Acciones               LABEL "&Accion de Novedades".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTNOVED"  "(INPUT 0)"}
{TRIGMENU.I "Novedades"    "Listados"      "RLCODNOV" }
{TRIGMENU.I "Acciones"     "Listados"      "RLACCION" }

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

ON VALUE-CHANGED OF ver IN FRAME frm-entidad
DO:
  IF ver <> 0
  THEN DO:
  
     ASSIGN ver.

     brw_conceptos:VISIBLE = NO.
     brw_datosliq:VISIBLE = NO. 
     brw_estados:VISIBLE = NO. 

     CASE ver:

        WHEN 1 
        THEN DO:
          brw_conceptos:VISIBLE = YES.
          OPEN QUERY qry_conceptos FOR EACH Accion_concepto OF Novedad, 
                                       EACH Concepto OF Accion_concepto.
          ENABLE brw_conceptos WITH FRAME frm-entidad.
        END.            

        WHEN 2 
        THEN DO:
          brw_datosliq:VISIBLE = YES.
          OPEN QUERY qry_datosliq FOR EACH Accion_dato OF Novedad, ~
                                      EACH Tit_dat_liquid OF Accion_dato.
          ENABLE brw_datosliq WITH FRAME frm-entidad.
        END.            

        WHEN 3 
        THEN DO:
          brw_estados:VISIBLE = YES.
          OPEN QUERY qry_estados FOR EACH Novedad_estado OF Novedad, ~
                                      EACH Estado OF Novedad_estado.
          ENABLE brw_estados WITH FRAME frm-entidad.
        END.            

      END CASE.   

   END.
   ELSE DO:
      BELL.
      MESSAGE " No se ha identificado el Empleado" 
              VIEW-AS ALERT-BOX ERROR BUTTONS OK
              TITLE "Se ha detectado un error".
      RETURN NO-APPLY.        
   END.           
END.

/*--------------------- Tratamiendo del browse de conceptos -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_conceptos
&SCOPED-DEFINE ACT_REGBROWSE    act_acc_concepto
&SCOPED-DEFINE ULT_REGBROWSE    ult_acc_concepto
&SCOPED-DEFINE TABLA-BRW        Accion_concepto
&SCOPED-DEFINE TABLA-MASTER     Novedad
&SCOPED-DEFINE ACTREGIS         ACTACCNC
&SCOPED-DEFINE QRY_BROWSE       qry_conceptos 
&SCOPED-DEFINE QRY_CONDICION    Accion_concepto OF Novedad, ~
                                EACH Concepto OF Accion_concepto
&SCOPED-DEFINE MENSAJE-VACIO    No hay Acciones de Conceptos asignadas a la Novedad
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea eliminar esta accion?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de datos de liq. -------------*/

&SCOPED-DEFINE VER              2
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_datosliq
&SCOPED-DEFINE ACT_REGBROWSE    act_acc_dato
&SCOPED-DEFINE ULT_REGBROWSE    ult_acc_dato
&SCOPED-DEFINE TABLA-BRW        Accion_dato
&SCOPED-DEFINE TABLA-MASTER     Novedad
&SCOPED-DEFINE ACTREGIS         ACTACDTL
&SCOPED-DEFINE QRY_BROWSE       qry_datosliq
&SCOPED-DEFINE QRY_CONDICION    Accion_dato OF Novedad, ~
                                EACH Tit_dat_liquid OF Accion_dato
&SCOPED-DEFINE MENSAJE-VACIO    No hay Acciones de datos asignadas a la Novedad
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea eliminar esta accion de dato?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de estados -------------*/


&SCOPED-DEFINE VER              3
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_estados
&SCOPED-DEFINE ACT_REGBROWSE    act_nov_estado
&SCOPED-DEFINE ULT_REGBROWSE    ult_nov_estado
&SCOPED-DEFINE TABLA-BRW        Novedad_estado
&SCOPED-DEFINE TABLA-MASTER     Novedad
&SCOPED-DEFINE ACTREGIS         ACTNOVST
&SCOPED-DEFINE QRY_BROWSE       qry_estados
&SCOPED-DEFINE QRY_CONDICION    Novedad_estado OF Novedad, ~
                                EACH Estado OF Novedad_estado
&SCOPED-DEFINE MENSAJE-VACIO    No hay Estados de empleados asociados a la Novedad
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este estado?

{TRGBROWS.I}

/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Novedad
       
&SCOPED-DEFINE TABLA            Estado
&SCOPED-DEFINE CODIGO-TAB       cdg_estado
&SCOPED-DEFINE CODIGO-ENT       cdg_estado_nov
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELESTAD
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_estado
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACBRWEST
&SCOPED-DEFINE ULT_REGISTRO     ult_estado
&SCOPED-DEFINE ALT-MOD          YES

{TRIGHELP.I} 

/*=================== F I N   D E   L O S   H E L P S ======================*/
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

     IF ROWID(Novedad) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "NOVE000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Novedad.descripcion = "" OR 
        INPUT FRAME frm-entidad Novedad.descripcion = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "NOVE001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Novedad 
                       WHERE Novedad.cdg_novedad = INPUT FRAME frm-entidad Novedad.cdg_novedad
                         AND ROWID(Novedad) <> act_Novedad )
     THEN DO:
        RUN PONMENSJ.P (INPUT "NOVE002").
        RETURN.
     END.            

     {IFNOTEXS.I "Estado" "cdg_estado" "frm-entidad" "Novedad" "cdg_estado" "NOVE003"}


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

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

