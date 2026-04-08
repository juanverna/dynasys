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

DEFINE QUERY qry_convenios     FOR Prepaga_convenio, Convenio.

DEFINE BROWSE brw_convenios QUERY qry_convenios
       DISPLAY Convenio.cdg_convenio
               Convenio.descripcion
       WITH 6 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Convenios que aportan a esta obra social".

DEFINE BUFFER Aporte_empl FOR Concepto.
DEFINE BUFFER Aporte_adic FOR Concepto.

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
    Prepaga.cdg_prepaga          COLON 12  FGCOLOR fe_c BGCOLOR be_c
    Prepaga.nombre               COLON 12  FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.2)    
    Prepaga.cdg_concepto_empl    COLON 12  FGCOLOR fe_c BGCOLOR be_c LABEL "Empleado"
    Aporte_empl.descripcion                FGCOLOR fg_c BGCOLOR bg_c NO-LABEL
    SKIP(0.2)    
    Prepaga.cdg_concepto_adic    COLON 12  FGCOLOR fe_c BGCOLOR be_c LABEL "Adicional"
    Aporte_adic.descripcion                FGCOLOR fg_c BGCOLOR bg_c NO-LABEL
    SKIP(0.2)    
    Prepaga.nro_afiliacion       COLON 12  FGCOLOR fe_c BGCOLOR be_c
    Prepaga.porc_contribucion              FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)    
    brw_convenios AT 14
    SKIP(0.5)

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
   MENU-ITEM Prepagas              LABEL "&Prepagas Por C¢digo".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTPREPG"  "(INPUT 0)"}
{TRIGMENU.I "Prepagas"     "Listados"      "RLPREPAG" }

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


/*--------------------- Tratamiendo del browse de convenios -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     NO
&SCOPED-DEFINE BROWSE           brw_convenios
&SCOPED-DEFINE ACT_REGBROWSE    act_obs_convenio
&SCOPED-DEFINE ULT_REGBROWSE    ult_obs_convenio
&SCOPED-DEFINE TABLA-BRW        Prepaga_Convenio
&SCOPED-DEFINE TABLA-MASTER     Prepaga
&SCOPED-DEFINE ACTREGIS         ACTOSCNV
&SCOPED-DEFINE QRY_BROWSE       qry_convenios
&SCOPED-DEFINE QRY_CONDICION    Prepaga_Convenio OF Prepaga, ~
                                EACH Convenio OF Prepaga_Convenio
&SCOPED-DEFINE MENSAJE-VACIO    NO hay convenios asociados al concepto
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este convenio?

{TRGBROWS.I}

/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Prepaga

       /* -------------- Concepto del Empleado ----------------------*/

&SCOPED-DEFINE TABLA            Concepto
&SCOPED-DEFINE CODIGO-TAB       cdg_concepto
&SCOPED-DEFINE CODIGO-ENT       cdg_concepto_empl
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELCNCEP
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_Prepaga
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          NO
&SCOPED-DEFINE ALTA-MODIF       ACTCNCEP
&SCOPED-DEFINE ULT_REGISTRO     ult_Prepaga
&SCOPED-DEFINE ALT-MOD          YES

{TRIGHELP.I} 

       /* -------------- Concepto Aporte del empleado ----------------------*/

&SCOPED-DEFINE TABLA            Aporte_empl
&SCOPED-DEFINE CODIGO-TAB       cdg_concepto
&SCOPED-DEFINE CODIGO-ENT       cdg_concepto_empl
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELCNCEP
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_concepto
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTCNCEP
&SCOPED-DEFINE ULT_REGISTRO     ult_concepto
&SCOPED-DEFINE ALT-MOD          YES

{TRIGHELP.I} 


       /* -------------- Concepto Adicional del Empleado ----------------------*/

&SCOPED-DEFINE TABLA            Aporte_adic
&SCOPED-DEFINE CODIGO-TAB       cdg_concepto
&SCOPED-DEFINE CODIGO-ENT       cdg_concepto_adic
&SCOPED-DEFINE NOMBRE           descripcion
&SCOPED-DEFINE RUTINA           SELCNCEP
&SCOPED-DEFINE FRAME-INGRESO    frm-entidad
&SCOPED-DEFINE ROWID-TABLA      act_concepto
&SCOPED-DEFINE TRADUCIR         YES
&SCOPED-DEFINE MOSTRAR          YES
&SCOPED-DEFINE ALTA-MODIF       ACTCNCEP
&SCOPED-DEFINE ULT_REGISTRO     ult_concepto
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

     IF ROWID(Prepaga) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "OBRS000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Prepaga.nombre = "" OR 
        INPUT FRAME frm-entidad Prepaga.nombre = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "OBRS001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Prepaga 
                       WHERE Prepaga.cdg_prepaga = INPUT FRAME frm-entidad Prepaga.cdg_prepaga  
                         AND ROWID(Prepaga) <> act_Prepaga )
     THEN DO:
        RUN PONMENSJ.P (INPUT "OBRS002").
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


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

