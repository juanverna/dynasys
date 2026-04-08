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

{VAREXCEL.I}

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                       FRAMES PARTICULARES DE CADA LISTADO                       */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FRAMES"
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
/*                   INCIALIZACION DEL PROCESAMIENTO DEL REPORTE                   */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-PROCESO"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

ON CHOOSE OF btn_verdatos
DO:
   DDE EXECUTE sys   COMMAND "[apl.restablecer()]".   
   DDE ADVISE sheet START ITEM "L1C3".
END.
   
ON DDE-NOTIFY OF FRAME frm-rango
DO:   
   DDE GET sheet TARGET sty ITEM "L1C3".
   MESSAGE "Retornamos a Modulo de Liquidacion" 
      VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje del sistema".
   DDE ADVISE sheet STOP ITEM "L1C3".       
   DDE EXECUTE sys   COMMAND "[apl.minimizar()]".   
END.

/*---------------------------------------------------------------------------------*/

   RUN WinExec (INPUT "Excel /e", INPUT 2).  /* 1=normal 2=minimizado */
   excelon = TRUE.

   DDE INITIATE sys FRAME FRAME frm-rango:HANDLE 
      APPLICATION "Excel" TOPIC "System" NO-ERROR. 

   IF sys = 0 THEN
   DO:
      MESSAGE "La Aplicacion Excel no se halla disponible. Por favor, Ingrese al"
               "ADMINISTRADOR DE PROGRAMAS y seleccione el icono Server Excel" 
               "para iniciar dicha tarea. Luego regrese a esta aplicacion"
               "y vuelva a seleccionar esta funcion. Gracias."
               VIEW-AS ALERT-BOX ERROR BUTTONS OK TITLE "ERROR DE SISTEMA".
      RETURN.
   END.

   DDE EXECUTE sys COMMAND "[abrir(~"empleado~";;~"FALSO~")]". 
   DDE INITIATE sheet FRAME FRAME frm-rango:HANDLE APPLICATION "Excel" TOPIC "Hoja1". 
      
   DDE SEND sheet SOURCE "Legajo"         ITEM "L2C1".
   DDE SEND sheet SOURCE "Nombre"         ITEM "L2C2".
   DDE SEND sheet SOURCE "Concepto"       ITEM "L2C3".
   DDE SEND sheet SOURCE "H/R"            ITEM "L2C4".
   DDE SEND sheet SOURCE "Unidades"       ITEM "L2C5".
   DDE SEND sheet SOURCE "Importe"        ITEM "L2C6".
      
                        /* ---  LAZO DE PROCESO --- */
                         
  hora2 = TIME.

  fili = 2.
  coli = 0.

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    INICIALIZACION DEL PROCESO DE CADA EMPLEADO                  */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-EMPLEADO"
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
/*                    INICIALIZACION DEL PROCESO DE CADA RECIBO                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "INICIAR-RECIBO"
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
/*                             PROCESO DE CADA RECIBO                              */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCESAR-RECIBO"
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
/*                    INICIALIZACION DEL PROCESO DE CADA CONCEPTO                  */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "PROCESAR-CONCEPTO"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

        
        fili = fili + 1.
        coli = 0.
        
        {DDESEND.I "STRING(Empleado.nro_legajo)"}
        {DDESEND.I "Empleado.nombre"}
        {DDESEND.I "STRING(Concepto.cdg_concepto)"}
        {DDESEND.I "Concepto.haber_retenc"}
        {DDESEND.I "STRING(Rcb_detalle.unidades)"}
        IF Concepto.haber_retenc = "H"
        THEN DO:
           {DDESEND.I "STRING(Rcb_detalle.importe)"}
        END.
        ELSE DO:
           {DDESEND.I "STRING(Rcb_detalle.importe * ( -1 ) )"}
        END.   

&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    FINALIZACION DEL PROCESO DE LOS CONCEPTOS                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-CONCEPTOS"
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
/*                    FINALIZACION DEL PROCESO DE CADA RECIBO                      */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-RECIBOS"
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
/*                    FINALIZACION DEL PROCESO DE CADA EMPLEADO                    */
/*                                                                                 */
/*=================================================================================*/
/*                                                                                 */
&IF {&SECCION} = "FIN-EMPLEADOS"
&THEN
/*                                                                                 */
/*---------------------------------------------------------------------------------*/

 nregs = fili - 2.
 DDE SEND sheet SOURCE STRING(nregs) ITEM "L1C1".
 DDE SEND sheet SOURCE "Registros" ITEM "L1C2".
 DDE EXECUTE sys COMMAND "[EJECUTAR(~"Armar_planilla~";~"FALSO~")]".  
 
 hora3  = TIME.
 tiempo = hora3 - hora2.
 DISPLAY tiempo nregs 
         WITH frame frm-rango.
 
&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/

/*=================================================================================*/
/*                                                                                 */
/*                      C O M I E N Z O   D E   S E C C I O N                      */
/*                                                                                 */
/*                    PROCEDIMIENTOS PARTICULARES DE CADA CASO                     */
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












