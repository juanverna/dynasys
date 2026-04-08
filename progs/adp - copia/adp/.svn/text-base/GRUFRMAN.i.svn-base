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

DEFINE QUERY qry_dias          FOR Dia_Franco.
DEFINE BROWSE brw_dias QUERY qry_dias
       DISPLAY Dia_Franco.fecha
               Dia_franco.observacion       
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Fecha de Francos".

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
    SPACE(1)
    Grupo_francos.cdg_franco                   COLON 12      FGCOLOR fe_c BGCOLOR be_c
    Grupo_francos.dsc_franco                                 FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)    
    brw_dias     AT ROW  4 COL 10
    SKIP(0.2)
    SPACE(1)

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
   MENU-ITEM Grupos                 LABEL "&Grupos de Francos".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTGRUFR"  "(INPUT 0)"}
{TRIGMENU.I "Grupos"       "Listados"      "RLGRUFRA" }


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

/*--------------------- Tratamiendo del browse de fechas -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     NO
&SCOPED-DEFINE BROWSE           brw_dias
&SCOPED-DEFINE ACT_REGBROWSE    act_dia_franco
&SCOPED-DEFINE ULT_REGBROWSE    ult_dia_franco
&SCOPED-DEFINE TABLA-BRW        Dia_Franco
&SCOPED-DEFINE TABLA-MASTER     Grupo_francos
&SCOPED-DEFINE ACTREGIS         ACTDIAFR
&SCOPED-DEFINE QRY_BROWSE       qry_dias
&SCOPED-DEFINE QRY_CONDICION    Dia_franco OF Grupo_francos
&SCOPED-DEFINE MENSAJE-VACIO    NO hay Dias Franco asociados al Grupo de francos
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Dia?

{TRGBROWS.I}

/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Empleado

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

     IF ROWID(Grupo_francos) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "GFRA000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Grupo_francos.dsc_franco = "" OR 
        INPUT FRAME frm-entidad Grupo_francos.dsc_franco = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "GFRA001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Grupo_francos 
                       WHERE Grupo_francos.cdg_franco = INPUT FRAME frm-entidad Grupo_francos.cdg_franco
                         AND ROWID(Grupo_francos) <> act_Grupo_francos )
     THEN DO:
        RUN PONMENSJ.P (INPUT "GFRA002").
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

