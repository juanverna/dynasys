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

  SKIP(0.5)    
  SPACE(1)
  Tarea.cdg_tarea        COLON 14 FGCOLOR fe_c BGCOLOR be_c
  SKIP(0.2)
  Tarea.dsc_tarea        COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.carac_id                  FGCOLOR fe_c BGCOLOR be_c
  SKIP(0.2)
  Tarea.tipo_tarea       COLON 14 FGCOLOR fg_c 
  SKIP(0.2)
  Tarea.horas2           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp2           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas3           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp3           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas4           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp4           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas5           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp5           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas6           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp6           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas7           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp7           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
  SKIP(0.2)
  Tarea.horas1           COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Tarea.hcomp1           COLON 44 FGCOLOR fe_c BGCOLOR be_c 
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

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos".

DEFINE SUB-MENU Listados
   MENU-ITEM Tareas                 LABEL "&Tareas Por C¢digo".
      
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos".
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTTAREA"  "(INPUT 0)"}
{TRIGMENU.I "Tareas"       "Listados"      "RLTAREAS" }


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

     IF ROWID(Tarea) = ?
     THEN DO:
        RUN PONMENSJ.P ( INPUT "TARE000").
        RETURN.
     END.
  
     IF INPUT FRAME frm-entidad Tarea.dsc_tarea = "" OR 
        INPUT FRAME frm-entidad Tarea.dsc_tarea = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "TARE001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Tarea 
                       WHERE Tarea.cdg_tarea = INPUT FRAME frm-entidad Tarea.cdg_tarea  
                         AND ROWID(Tarea) <> act_tarea )
     THEN DO:
        RUN PONMENSJ.P (INPUT "TARE002").
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

