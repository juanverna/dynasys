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
       VIEW-AS RADIO-SET HORIZONTAL 
       RADIO-BUTTONS "&Horarios", 1, "&Novs." , 2, "&Conceptos" , 3,
                     "&Fams.", 4, "&Datos.Liq." , 5, "&Recibos" , 6.

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
    Destino.cdg_destino         COLON 20 FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)    
    SPACE(1)
    Destino.nombre              COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.direccion           COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.cdg_postal          COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.localidad           COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.provincia           COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.telefono            COLON 20 FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)    
    SPACE(1)
    Destino.zona                COLON 20 FGCOLOR fe_c BGCOLOR be_c 
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
   MENU-ITEM Destinos               LABEL "&Destinos".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTDESTI"  "(INPUT 0)"}
{TRIGMENU.I "Destinos"     "Listados"      "RLDESTIN"}

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

     IF ROWID(Destino) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "DESTI000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Destino.nombre = "" OR 
        INPUT FRAME frm-entidad Destino.nombre = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "DESTI001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Destino 
                       WHERE Destino.cdg_destino = INPUT FRAME frm-entidad Destino.cdg_destino
                         AND ROWID(Destino) <> act_Destino )
     THEN DO:
        RUN PONMENSJ.P (INPUT "DESTI002").
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

