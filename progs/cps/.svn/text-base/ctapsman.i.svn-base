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
       RADIO-BUTTONS "&Acumulados", 1, "&Sumarizaci¢n" , 2.

DEFINE VARIABLE este_ejercicio AS INTEGER LABEL "Ejercic. A¤o" FORMAT "9999".

{DFVELEGR.I}

DEFINE QUERY qry_acumulados FOR Acumulado_ctapsp.
DEFINE BROWSE brw_acumulados QUERY qry_acumulados 
       DISPLAY Acumulado_ctapsp.ano
               Acumulado_ctapsp.mes             
               Acumulado_ctapsp.tot_debitos   FORMAT "->>,>>>,>>9.99"
               Acumulado_ctapsp.tot_creditos  FORMAT "->>,>>>,>>9.99"
               Acumulado_ctapsp.saldo_periodo FORMAT "->>,>>>,>>9.99"
               Acumulado_ctapsp.saldo_total   FORMAT "->>,>>>,>>9.99"
       WITH 8 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Acumulado de d‚bitos y cr‚ditos para cada per¡odo".

DEFINE QUERY qry_sumariza FOR Sumariza_psp, Cuenta.
DEFINE BROWSE brw_sumariza QUERY qry_sumariza 
       DISPLAY Cuenta.cdg_cuenta
               Cuenta.nombre_cta
       WITH 8 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
               TITLE "Cuentas controladas".

DEFINE BUTTON BTN_CLASE
     LABEL "&Clasificar":L 
     SIZE 15 BY 0.9 FONT 4.

{DEFVRMXP.I}

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
    Ctapsp.cdg_ctapsp        COLON 12                        FGCOLOR fe_c BGCOLOR be_c 
    Ctapsp.nombre_cps                                        FGCOLOR fe_c BGCOLOR be_c 
    SKIP(0.1)
    Ctapsp.grupo_pat         COLON 12 LABEL "Gr.Patr."       FGCOLOR fe_c 
    Ctapsp.unidades                      VIEW-AS TOGGLE-BOX  FGCOLOR fe_c
    SKIP(0.1)    
    Ctapsp.cdg_subclase      COLON 12 LABEL "Clasif."        FGCOLOR fe_c BGCOLOR be_c FORMAT "X(54)"
    BTN_CLASE
    SKIP(0.1)    
    Ctapsp.entidades_validas COLON 12                        FGCOLOR fe_c BGCOLOR be_c FORMAT "X(54)"
    BTN_ELEGIR
    SKIP(0.1)
    Ctapsp.fecha_alta        COLON 12                        FGCOLOR fe_c BGCOLOR be_c
    Ctapsp.fecha_baja                                        FGCOLOR fe_c BGCOLOR be_c
    este_ejercicio                                           FGCOLOR fe_c BGCOLOR be_c
    SKIP(0.1)
    ver                      COLON 12                        FGCOLOR fe_c
    brw_SUMARIZA   AT ROW  8 COL 14
    brw_ACUMULADOS AT ROW  8 COL 14
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
   MENU-ITEM Ctapsp                 LABEL "&Cuentas por C¢digo".

DEFINE SUB-MENU Procesos
   MENU-ITEM Ingresos               LABEL "&Ingresos/Actualizaciones".
   
DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTCTAPS"  "(INPUT 0)"}
{TRIGMENU.I "Ctapsp"       "Listados"      "RLCTAPSP"}

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
  RUN CAMBIAR_BROWSES.
END.

ON CHOOSE OF btn_clase IN FRAME frm-entidad
DO:
   RUN ACTCLPSP.P ( INPUT 1, OUTPUT codigo_salir ).
   IF codigo_salir = 1
   THEN DO:
      FIND Clase_de_ctapsp WHERE ROWID(Clase_de_ctapsp) = act_clpsp NO-LOCK.
      Ctapsp.cdg_subclase = Clase_de_ctapsp.cdg_subclase.
      DISPLAY Ctapsp.cdg_subclase
              WITH FRAME frm-entidad.
   END.
END.              

ON RETURN OF este_ejercicio IN FRAME frm-entidad
DO:
   ASSIGN este_ejercicio.
   OPEN QUERY qry_acumulados
        FOR EACH Acumulado_ctapsp OF Ctapsp 
                 WHERE Acumulado_ctapsp.ano_fiscal = este_ejercicio NO-LOCK.

END.           

{TGBELEGR.I "Ctapsp" "entidades_validas" "Entidad" "cdg_entidad" "dsc_entidad" "SELECENT.P"}

/*--------------------- Tratamiendo del browse de Cuentas -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_sumariza
&SCOPED-DEFINE ACT_REGBROWSE    act_sumapsp
&SCOPED-DEFINE ULT_REGBROWSE    ult_sumapsp
&SCOPED-DEFINE TABLA-BRW        Sumariza_psp
&SCOPED-DEFINE TABLA-MASTER     Ctapsp
&SCOPED-DEFINE ACTREGIS         ACTCNTSU
&SCOPED-DEFINE QRY_BROWSE       qry_sumariza 
&SCOPED-DEFINE QRY_CONDICION    Sumariza_psp OF Ctapsp, FIRST Cuenta OF Sumariza_psp
&SCOPED-DEFINE MENSAJE-VACIO    NO hay cuentas que sumaricen en esta controladora
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar esta cuenta?

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

FIND Parametro "AÑOFISCL" NO-LOCK.
este_ejercicio = Parametro.valor_n. 

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


     IF ROWID(Ctapsp) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "CPSP000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Ctapsp.nombre_cps = "" OR 
        INPUT FRAME frm-entidad Ctapsp.nombre_cps = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "CPSP001").
        RETURN.
     END.            
     IF CAN-FIND(FIRST Ctapsp 
                       WHERE Ctapsp.cdg_ctapsp = INPUT FRAME frm-entidad Ctapsp.cdg_ctapsp  
                         AND ROWID(Ctapsp) <> act_ctapsp )
     THEN DO:
        RUN PONMENSJ.P (INPUT "CPSP002").
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

PROCEDURE SUMAR_TOTALES:

   DEFINE VARIABLE saldo AS DECIMAL INITIAL 0.

   FOR EACH Acumulado_ctapsp OF Ctapsp EXCLUSIVE-LOCK:
       Acumulado_ctapsp.saldo_periodo = 
          Acumulado_ctapsp.tot_debitos - Acumulado_ctapsp.tot_creditos.
       saldo = saldo + Acumulado_ctapsp.saldo_periodo.
       Acumulado_ctapsp.saldo_total = saldo.
   END.

END.       

PROCEDURE VALIDAR_BAJA:

  hay_error = YES.

  
/*  hay_error = NO.*/
  
END PROCEDURE.

PROCEDURE ELIMINAR_REGISTRO:

   FIND CURRENT Ctapsp EXCLUSIVE-LOCK.
   DELETE Ctapsp.

END PROCEDURE.  

PROCEDURE CAMBIAR_BROWSES:

  IF ver <> 0
  THEN DO:
  
     ASSIGN FRAME frm-entidad ver.

     IF brw_sumariza:VISIBLE IN FRAME frm-entidad THEN brw_sumariza:VISIBLE IN FRAME frm-entidad = NO. 
     IF brw_acumulados:VISIBLE IN FRAME frm-entidad THEN brw_acumulados:VISIBLE IN FRAME frm-entidad = NO.
          
     CASE ver:


        WHEN 1 
        THEN DO:
          brw_acumulados:VISIBLE IN FRAME frm-entidad = YES.
          OPEN QUERY qry_acumulados 
               FOR EACH Acumulado_ctapsp OF Ctapsp 
                        WHERE Acumulado_ctapsp.ano_fiscal = este_ejercicio NO-LOCK.
          ENABLE brw_acumulados WITH FRAME frm-entidad.
          APPLY "ENTRY" TO brw_acumulados.          
        END.            

        WHEN 2 
        THEN DO:
          brw_sumariza:VISIBLE IN FRAME frm-entidad = YES.
          OPEN QUERY qry_sumariza 
               FOR EACH Sumariza_psp OF Ctapsp NO-LOCK,
                        FIRST Cuenta OF Sumariza_psp NO-LOCK.
          ENABLE brw_sumariza WITH FRAME frm-entidad.
          APPLY "ENTRY" TO brw_sumariza.
        END.  

    
      END CASE.   
   END.
   ELSE DO:
      BELL.
      MESSAGE " No se ha identificado la Cuenta Controladora" 
              VIEW-AS ALERT-BOX ERROR BUTTONS OK
              TITLE "Se ha detectado un error".
      RETURN.        
   END.           

END PROCEDURE.


&ENDIF

/*=================================================================================*/
/*                           F I N   D E   S E C C I O N                           */
/*=================================================================================*/
