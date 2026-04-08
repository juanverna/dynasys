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

DEFINE VARIABLE ver AS INTEGER LABEL "Ver ==>"
       VIEW-AS RADIO-SET 
       RADIO-BUTTONS "&Cod.Control", 1, "&Listados" , 2.

DEFINE QUERY qry_impresora FOR Ctrl_impresora.
DEFINE QUERY qry_list FOR List_impresora.

DEFINE BROWSE brw_impresora QUERY qry_impresora
       DISPLAY Ctrl_impresora.cdg_funcion Ctrl_impresora.descripcion
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Codigos de Control para esta Impresora".

DEFINE BROWSE brw_list QUERY qry_list
       DISPLAY List_impresora.listado List_impresora.descripcion
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Listados asignados a esta Impresora".


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


    SKIP(0.2)
    SPACE(3)
    Impresora.cdg_impresora FGCOLOR fe_c BGCOLOR be_c
    Impresora.nombre        FGCOLOR fe_c BGCOLOR be_c
    Impresora.puerto        FGCOLOR fe_c BGCOLOR be_c
    brw_impresora AT ROW 2 COL 3     
    SPACE(3) ver
    brw_list      AT ROW 2 COL 3 
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

DEFINE SUB-MENU Reportes
   MENU-ITEM Por_prov               LABEL "&Provincia"
   MENU-ITEM Por_venta              LABEL "Condicion de &Venta"
   MENU-ITEM Por_iva                LABEL "Condicion de &Iva"
   MENU-ITEM Por_vend               LABEL "Ve&ndedor".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Reportes               LABEL "&Reportes".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTEMPLE"  "(INPUT 0)"}
/*
{TRIGMENU.I "Por_prov"     "Cli-Reportes"  "LSCLIPRO"}
{TRIGMENU.I "Por_venta"    "Cli-Reportes"  "LSCLIVTA"}
{TRIGMENU.I "Por_iva"      "Cli-Reportes"  "LSCLIIVA"}
{TRIGMENU.I "Por_vend"     "Cli-Reportes"  "LSCLIVDR"}
*/
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

/*            Cambia el despliegue de los distintos browses en pantalla           */

ON VALUE-CHANGED OF ver IN FRAME frm-entidad
DO:
  IF ver <> 0
  THEN DO:

     ASSIGN ver.

     HIDE brw_impresora IN FRAME frm-entidad.
     HIDE brw_list IN FRAME frm-entidad.

     CASE ver:
        WHEN 1 
        THEN DO:
          OPEN QUERY qry_impresora FOR EACH Ctrl_impresora OF Impresora.
          ENABLE brw_impresora WITH FRAME frm-entidad.
        END.  

        WHEN 2 
        THEN DO:
          OPEN QUERY qry_list FOR EACH List_impresora OF Impresora.
          ENABLE brw_list WITH FRAME frm-entidad.
        END.            

      END CASE.   
   END.
   ELSE DO:
      BELL.
      MESSAGE " No se ha identificado la impresora" 
              VIEW-AS ALERT-BOX ERROR BUTTONS OK
              TITLE "Se ha detectado un error".
      RETURN NO-APPLY.        
   END.           
END.


/*--------------------- Tratamiendo del browse de cod.control-----------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_impresora
&SCOPED-DEFINE ACT_REGBROWSE    act_Ctrl_impresora
&SCOPED-DEFINE ULT_REGBROWSE    ult_Ctrl_impresora
&SCOPED-DEFINE TABLA-BRW        Ctrl_impresora
&SCOPED-DEFINE TABLA-MASTER     Impresora
&SCOPED-DEFINE ACTREGIS         ACTCDCTL
&SCOPED-DEFINE PROC_ACTUALIZAR  PONER_SESION
&SCOPED-DEFINE QRY_BROWSE       qry_impresora
&SCOPED-DEFINE QRY_CONDICION    Ctrl_impresora OF Impresora
&SCOPED-DEFINE MENSAJE-VACIO    NO hay codigos asignados a la impresora
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este codigo?

{TRGBROWS.I}


/*--------------------- Tratamiendo del browse de Listados -------------*/

&SCOPED-DEFINE VER              2
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_list
&SCOPED-DEFINE ACT_REGBROWSE    act_list
&SCOPED-DEFINE ULT_REGBROWSE    ult_list
&SCOPED-DEFINE TABLA-BRW        List_impresora
&SCOPED-DEFINE TABLA-MASTER     Impresora
&SCOPED-DEFINE ACTREGIS         ACTLISTA
&SCOPED-DEFINE PROC_ACTUALIZAR  PONER_SESION
&SCOPED-DEFINE QRY_BROWSE       qry_list
&SCOPED-DEFINE QRY_CONDICION    List_impresora OF Impresora
&SCOPED-DEFINE MENSAJE-VACIO    No hay Listados asignados a esta impresora
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Listado?

{TRGBROWS.I}

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


     IF ROWID(Impresora) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Impresora.nombre = "" OR 
        INPUT FRAME frm-entidad Impresora.nombre = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR001").
        RETURN.
     END.            
     IF CAN-FIND(FIRST Impresora
                       WHERE Impresora.cdg_impresora = INPUT FRAME frm-entidad Impresora.cdg_impresora
                         AND ROWID(Impresora) <> act_impresora )
     THEN DO:
        RUN PONMENSJ.P (INPUT "IMPR002").
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

