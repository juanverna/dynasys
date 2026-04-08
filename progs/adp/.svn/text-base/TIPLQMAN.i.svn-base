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

DEFINE VARIABLE rc_sintax AS INTEGER.
DEFINE VARIABLE palabra   AS CHARACTER.
DEFINE VARIABLE caracter  AS CHARACTER.

DEFINE VARIABLE ver AS INTEGER LABEL "Ver ==>"
       VIEW-AS RADIO-SET HORIZONTAL 
       RADIO-BUTTONS  "&Conceptos", 1, "&Estados", 2, "Con&venios" , 3, "&Fórmulas" , 4
                      INITIAL 1.

DEFINE QUERY qry_conceptos FOR Concepto_liquidacion, Concepto.
DEFINE BROWSE brw_conceptos QUERY qry_conceptos
       DISPLAY Concepto.cdg_concepto
               Concepto.descripcion
       WITH 12 DOWN NO-UNDERLINE FONT 4 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Conceptos que se liquidan para esta liquidacion".

DEFINE QUERY qry_estados FOR Estado_liquidacion, Estado.
DEFINE BROWSE brw_estados QUERY qry_estados
       DISPLAY Estado.cdg_estado
               Estado.descripcion
       WITH 12 DOWN NO-UNDERLINE FONT 4 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Estados que se incluyen en esta liquidacion".

DEFINE QUERY qry_convenios FOR Convenio-liquidacion, Convenio.
DEFINE BROWSE brw_convenios QUERY qry_convenios
       DISPLAY Convenio.cdg_convenio
               Convenio.descripcion
       WITH 12 DOWN NO-UNDERLINE FONT 4 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Convenios que se liquidan para esta liquidacion".


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

    Tipo_de_liquidac.cdg_liquid    AT ROW 2.75 COL 12 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Tipo_de_liquidac.descripcion    AT ROW 2.75 COL 34 COLON-ALIGNED
          LABEL "Descripción" 
          VIEW-AS FILL-IN 
          SIZE 38 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Tipo_de_liquidac.formula_inicial    AT ROW 3.75 COL 12 COLON-ALIGNED
          VIEW-AS EDITOR 
          SIZE 60 BY 5
          BGCOLOR be_c FGCOLOR fe_c 
    Tipo_de_liquidac.formula_final    AT ROW 8.75 COL 12 COLON-ALIGNED
          VIEW-AS EDITOR 
          SIZE 60 BY 5
          BGCOLOR be_c FGCOLOR fe_c 
    SKIP(0.5)    
    ver COLON 12    
    SKIP                                  
    brw_conceptos     AT ROW  2 COL 25        
    brw_estados       AT ROW  2 COL 25    
    brw_convenios     AT ROW  2 COL 25    
    SKIP(2)

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
   MENU-ITEM TipLiq                 LABEL "&Tipos de Liquidaci¢n".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTTIPLQ"  "(INPUT 0)"}
{TRIGMENU.I "TipLiq"       "Listados"      "RLTIPLIQ"}

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

     {&ESCONDER-BROWSES} 

     CASE ver:

        WHEN 1 
        THEN DO:
          brw_conceptos:VISIBLE = YES.
          OPEN QUERY qry_conceptos FOR EACH Concepto_liquidacion OF Tipo_de_liquidac, ~
                                       EACH Concepto OF Concepto_liquidacion.
          ENABLE brw_conceptos WITH FRAME frm-entidad.       
        END.  

        WHEN 2 
        THEN DO:
          brw_estados:VISIBLE = YES.
          OPEN QUERY qry_estados   FOR EACH Estado_liquidacion OF Tipo_de_liquidac, ~
                                       EACH Estado OF Estado_liquidacion.
          ENABLE brw_estados WITH FRAME frm-entidad.       
        END.  

        WHEN 3 
        THEN DO:
          brw_convenios:VISIBLE = YES.
          OPEN QUERY qry_convenios   FOR EACH Convenio-liquidacion OF Tipo_de_liquidac, ~
                                       EACH Convenio OF Convenio-liquidacion.
          ENABLE brw_convenios WITH FRAME frm-entidad.       
        END.  


      END CASE.   

   END.
   ELSE DO:
      BELL.
      MESSAGE " No se ha identificado la liquidacion" 
              VIEW-AS ALERT-BOX ERROR BUTTONS OK
              TITLE "Se ha detectado un error".
      RETURN NO-APPLY.        
   END.           
END.


/*--------------------- Tratamiendo del browse de Conceptos -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_conceptos
&SCOPED-DEFINE ACT_REGBROWSE    act_cnc_liquid
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnc_liquid
&SCOPED-DEFINE TABLA-BRW        Concepto_Liquidacion
&SCOPED-DEFINE TABLA-MASTER     Tipo_de_liquidac
&SCOPED-DEFINE ACTREGIS         ACTLQCNP
&SCOPED-DEFINE QRY_BROWSE       qry_conceptos
&SCOPED-DEFINE QRY_CONDICION    Concepto_Liquidacion OF Tipo_de_liquidac, ~
                                EACH Concepto OF Concepto_Liquidacion
&SCOPED-DEFINE MENSAJE-VACIO    NO hay Conceptos asociados a la liquidacion
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Concepto?

{TRGBROWS.I}


/*--------------------- Tratamiendo del browse de Estados -------------*/

&SCOPED-DEFINE VER              2
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_estados
&SCOPED-DEFINE ACT_REGBROWSE    act_est_liquid
&SCOPED-DEFINE ULT_REGBROWSE    ult_est_liquid
&SCOPED-DEFINE TABLA-BRW        Estado_Liquidacion
&SCOPED-DEFINE TABLA-MASTER     Tipo_de_liquidac
&SCOPED-DEFINE ACTREGIS         ACTLQEST
&SCOPED-DEFINE QRY_BROWSE       qry_estados
&SCOPED-DEFINE QRY_CONDICION    Estado_liquidacion OF Tipo_de_liquidac, ~
                                EACH Estado OF Estado_liquidacion
&SCOPED-DEFINE MENSAJE-VACIO    NO hay Estados asociados a la liquidacion
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Estado?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de Convenios -------------*/

&SCOPED-DEFINE VER              3
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_convenios
&SCOPED-DEFINE ACT_REGBROWSE    act_cnv_liquid
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnv_liquid
&SCOPED-DEFINE TABLA-BRW        Convenio-Liquidacion
&SCOPED-DEFINE TABLA-MASTER     Tipo_de_liquidac
&SCOPED-DEFINE ACTREGIS         ACTLQCNV
&SCOPED-DEFINE QRY_BROWSE       qry_convenios
&SCOPED-DEFINE QRY_CONDICION    Convenio-liquidacion OF Tipo_de_liquidac, ~
                                EACH Convenio OF Convenio-liquidacion
&SCOPED-DEFINE MENSAJE-VACIO    NO hay Convenios Asociados a la liquidacion
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este Convenio?

{TRGBROWS.I}


/*============================= H E L P S =======================================*/


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

     IF ROWID(Tipo_de_liquidac) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "TIPL000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Tipo_de_liquidac.descripcion = "" OR 
        INPUT FRAME frm-entidad Tipo_de_liquidac.descripcion = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "TIPL001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Tipo_de_liquidac 
                       WHERE Tipo_de_liquidac.cdg_liquid = INPUT FRAME frm-entidad Tipo_de_liquidac.cdg_liquid  
                         AND ROWID(Tipo_de_liquidac) <> act_tipliq )
     THEN DO:
        RUN PONMENSJ.P (INPUT "TIPL002").
        RETURN.
     END.            

     RUN VRSINTAX.P ( INPUT FRAME frm-entidad Tipo_de_liquidac.formula_inicial,
                      OUTPUT rc_sintax, 
                      OUTPUT palabra, 
                      OUTPUT caracter).
     IF rc_sintax > 1 
     THEN DO:
        RUN PONMENSJ.P (INPUT "TIPL003").
        RETURN.
     END.            

     RUN VRSINTAX.P ( INPUT FRAME frm-entidad Tipo_de_liquidac.formula_final,
                      OUTPUT rc_sintax, 
                      OUTPUT palabra, 
                      OUTPUT caracter).
     IF rc_sintax > 1 
     THEN DO:
        RUN PONMENSJ.P (INPUT "TIPL004").
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

