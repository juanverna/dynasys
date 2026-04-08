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

DEFINE VARIABLE que_fecha AS DATE.
DEFINE VARIABLE chr_fecha AS CHARACTER.

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
  Ciclo.nro_ciclo       LABEL "Ciclo"       COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Ciclo.descripcion     NO-LABEL               AT 22 FGCOLOR fe_c BGCOLOR be_c
  Ciclo.activo                                 AT 40 FGCOLOR fe_c BGCOLOR be_c
  Ciclo.actual                                 AT 55 FGCOLOR fg_c BGCOLOR bg_c
  SKIP(0.1)
  Ciclo.fecha_desde                         COLON 14 FGCOLOR fe_c BGCOLOR be_c
  Ciclo.fecha_hasta                         COLON 40 FGCOLOR fe_c BGCOLOR be_c
  SKIP(0.1)
  Ciclo.dias                                COLON 14 FGCOLOR fe_c BGCOLOR be_c
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

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTCICLO"  "(INPUT 0)"}

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

ON LEAVE OF Ciclo.fecha_desde, Ciclo.fecha_hasta IN FRAME frm-entidad
DO:

   chr_fecha = INPUT FRAME frm-entidad Ciclo.fecha_desde.
   que_fecha = DATE(chr_fecha) NO-ERROR.
   IF NOT ERROR-STATUS:ERROR
   THEN DO:
      chr_fecha = INPUT FRAME frm-entidad Ciclo.fecha_hasta.
      que_fecha = DATE(chr_fecha) NO-ERROR.
      IF NOT ERROR-STATUS:ERROR
      THEN DO:
         ASSIGN FRAME frm-entidad Ciclo.fecha_desde 
                  Ciclo.fecha_hasta.
         RUN CALCULAR_DIAS.
         DISPLAY Ciclo.dias WITH FRAME frm-entidad.
      END.
   END.

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

  IF ROWID(Ciclo) = ?
  THEN DO:
     RUN PONMENSJ.P ( INPUT "CICL001").
     RETURN.
  END.
  
  IF INPUT FRAME frm-entidad Ciclo.fecha_desde > 
     INPUT FRAME frm-entidad Ciclo.fecha_hasta
  THEN DO:
     RUN PONMENSJ.P ( INPUT "CICL002").
     RETURN.
  END.
  
  IF CAN-FIND(FIRST B-Ciclo  WHERE B-Ciclo.nro_ciclo < Ciclo.nro_ciclo 
                               AND B-Ciclo.fecha_hasta >= INPUT FRAME frm-entidad Ciclo.fecha_desde)
  THEN DO:
     RUN PONMENSJ.P ( INPUT "CICL003").
     RETURN.
  END.
  
  IF CAN-FIND(FIRST B-Ciclo  
                    WHERE B-Ciclo.nro_ciclo > Ciclo.nro_ciclo 
                      AND B-Ciclo.fecha_desde <= INPUT FRAME frm-entidad Ciclo.fecha_hasta)
  THEN DO:
     RUN PONMENSJ.P ( INPUT "CICL004").
     RETURN.
  END.
  
  IF INPUT FRAME frm-entidad Ciclo.dias <= 0
  THEN DO:
     RUN PONMENSJ.P ( INPUT "CICL005").
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


PROCEDURE CALCULAR_DIAS:

     Ciclo.dias = 0.
     que_fecha = Ciclo.fecha_desde.
     REPEAT WHILE que_fecha <= Ciclo.fecha_hasta:

         IF WEEKDAY(que_fecha) <> 1 AND 
            WEEKDAY(que_fecha) <> 7 AND
            NOT CAN-FIND(FIRST Feriado WHERE Feriado.fecha = que_fecha)
                THEN Ciclo.dias = Ciclo.dias + 1.
                
         que_fecha = que_fecha + 1.

     END.
         
END PROCEDURE.         


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

