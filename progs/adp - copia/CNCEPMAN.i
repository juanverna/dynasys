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
DEFINE VARIABLE aux_total AS DECIMAL.

DEFINE VARIABLE ver AS INTEGER LABEL "Ver ==>"
       VIEW-AS RADIO-SET  
       RADIO-BUTTONS  "&Ninguno", 0, 
                      "&Convenios", 1, 
                      "&Liquidaciones", 2, 
                      "E&mpleados" , 3,
                      "&Imputaciones", 4.

DEFINE QUERY qry_convenios     FOR Concepto_Convenio, Convenio.
DEFINE BROWSE brw_convenios QUERY qry_convenios
       DISPLAY Convenio.cdg_convenio
               Convenio.descripcion
       WITH 4 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Convenios para los que se liquida el concepto".

DEFINE QUERY qry_liquidaciones FOR Concepto_Liquidacion, Tipo_de_liquidac.
DEFINE BROWSE brw_liquidaciones QUERY qry_liquidaciones
       DISPLAY Tipo_de_liquidac.cdg_liquid
               Tipo_de_liquidac.descripcion
       WITH 4 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Liquidaciones en las que se incluye el concepto".

DEFINE QUERY qry_empleados     FOR Concepto_Empleado, Empleado.
DEFINE BROWSE brw_empleados QUERY qry_empleados
       DISPLAY Empleado.nro_legajo
               Empleado.nombre
       WITH 14 DOWN NO-UNDERLINE FONT 9 FGCOLOR b-fg_c BGCOLOR b-bg_c SEPARATORS
            TITLE "Empleados para los que se liquida el concepto".

DEFINE QUERY qry_imputacion FOR Concepto-cuenta, Entidad, Cuenta.
DEFINE BROWSE brw_imputacion QUERY qry_imputacion 
       DISPLAY Entidad.cdg_entidad COLUMN-LABEL "Código!Entidad"
               Entidad.dsc_entidad COLUMN-LABEL "Nombre!Entidad"
               Cuenta.cdg_cuenta COLUMN-LABEL "Código!Cuenta"
               Cuenta.nombre_cta COLUMN-LABEL "Nombre!Cuenta"
       WITH   9 DOWN NO-UNDERLINE FONT 4 FGCOLOR b-fg_c BGCOLOR b-bg_c
            SEPARATORS TITLE "Imputacion contable del Concepto por C.Costo".

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
    Concepto.cdg_concepto  AT ROW 2.75 COL 12 COLON-ALIGNED
          LABEL "Código"
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Concepto.unidad  AT ROW 2.75 COL 28 COLON-ALIGNED
          LABEL "Unidad"
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Concepto.abreviatura AT ROW 2.75 COL 42 COLON-ALIGNED
          LABEL "Abrev."
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    ver               AT ROW  2.75 COL 60
    Concepto.descripcion    AT ROW 3.75 COL 12 COLON-ALIGNED
          LABEL "Descripción" 
          VIEW-AS FILL-IN 
          SIZE 39 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Concepto.cdg_sumador  AT ROW 4.75 COL 12 COLON-ALIGNED
          LABEL "Sumador"
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Sumador.dsc_sumador  AT ROW 4.75 COL 22 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c 
    Concepto.cdg_totalizador AT ROW 5.75 COL 12 COLON-ALIGNED
          LABEL "Totalizador"  
          VIEW-AS FILL-IN 
          SIZE 9 BY .75
          BGCOLOR be_c FGCOLOR fe_c 
    Totalizador.dsc_totalizador  AT ROW 5.75 COL 22 COLON-ALIGNED
          NO-LABEL
          VIEW-AS FILL-IN 
          SIZE 29 BY .75
          BGCOLOR bg_c FGCOLOR fg_c     
    Concepto.formula   AT ROW 6.75 COL 12 COLON-ALIGNED
          NO-LABEL
          VIEW-AS EDITOR 
          SIZE 65 BY 4
          BGCOLOR be_c FGCOLOR fe_c 
    Concepto.haber_retenc AT ROW 11.75 COL 14 NO-LABEL
          FGCOLOR fe_c 
    Concepto.obligatorio  AT ROW 11.75 COL 50
          VIEW-AS TOGGLE-BOX
          SIZE 12.0 BY .63
          FGCOLOR fe_c 
    Concepto.salario_fliar  AT ROW 12.75 COL 50
          VIEW-AS TOGGLE-BOX
          SIZE 12.0 BY .63
          FGCOLOR fe_c 
    Concepto.temporario AT ROW 13.75 COL 50
          VIEW-AS TOGGLE-BOX
          SIZE 12.0 BY .63
          FGCOLOR fe_c 
    brw_empleados     AT ROW  2 COL 2
    brw_convenios     AT ROW  10 COL 2
    brw_liquidaciones AT ROW  10 COL 2
    brw_imputacion    AT ROW  10 COL 2
    SKIP(0.2)

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
   MENU-ITEM Ingresos               LABEL "&Ingresos/Modificaciones".

DEFINE SUB-MENU Listados
   MENU-ITEM PorCod                 LABEL "Conceptos por &C¢digo".

DEFINE MENU  Principal MENUBAR
   SUB-MENU  Archivo                LABEL "&Archivo"
   SUB-MENU  Procesos               LABEL "&Procesos"
   SUB-MENU  Listados               LABEL "&Listados".

{TRIGMENU.I "Ingresos"     "Procesos"      "ACTCNCEP"  "(INPUT 0)"}
{TRIGMENU.I "PorCod"       "Listados"      "LSCONCEP"}

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
  IF NOT AVAILABLE Concepto
  THEN DO:
       BELL.
       MESSAGE " No se ha identificado el concepto" 
                VIEW-AS ALERT-BOX ERROR BUTTONS OK
                TITLE "Se ha detectado un error".
       RETURN NO-APPLY.        
  END.           
  ELSE DO:
  
     ASSIGN ver.

     {&ESCONDER-BROWSES} 

     CASE ver:
        WHEN 1 
        THEN DO:
          brw_convenios:VISIBLE = YES.
          OPEN QUERY qry_convenios FOR EACH Concepto_convenio OF Concepto,
                                       EACH Convenio OF Concepto_convenio.
          ENABLE brw_convenios WITH FRAME frm-entidad.       
        END.  

        WHEN 2 
        THEN DO:
          brw_liquidaciones:VISIBLE = YES.
          OPEN QUERY qry_liquidaciones FOR EACH Concepto_liquidacion OF Concepto,
                                       EACH Tipo_de_liquidac OF Concepto_liquidacion.
          ENABLE brw_liquidaciones WITH FRAME frm-entidad.       
        END.            

        WHEN 3 
        THEN DO:
          brw_empleados:VISIBLE = YES.
          OPEN QUERY qry_empleados FOR EACH Concepto_Empleado OF Concepto,
                                       EACH Empleado OF Concepto_Empleado.
          ENABLE brw_empleados WITH FRAME frm-entidad.       
        END.            
    
        WHEN 4 
        THEN DO:
          brw_imputacion:VISIBLE = YES.
          OPEN QUERY qry_imputacion FOR EACH Concepto-cuenta OF Concepto,
                                       FIRST Entidad OF Concepto-cuenta,
                                       FIRST Cuenta OF Concepto-cuenta.
          ENABLE brw_imputacion WITH FRAME frm-entidad.       
        END.            

      END CASE.   

   END.

END.

ON VALUE-CHANGED OF Concepto.obligatorio IN FRAME frm-entidad
DO:
  
   ASSIGN Concepto.obligatorio.
   IF Concepto.obligatorio
      THEN como_fue = ver:DISABLE("Empleados").
      ELSE como_fue = ver:ENABLE("Empleados").   

END.   

ON VALUE-CHANGED OF Concepto.temporario IN FRAME frm-entidad
DO:
  
   ASSIGN Concepto.temporario.
   IF Concepto.temporario
   THEN DO:
      Concepto.obligatorio = NO.
      DISPLAY Concepto.obligatorio WITH FRAME frm-entidad.
      DISABLE Concepto.obligatorio WITH FRAME frm-entidad.
      como_fue = ver:ENABLE("Empleados").
   END.   
   ELSE DO:
      ENABLE Concepto.obligatorio WITH FRAME frm-entidad.
      APPLY "VALUE-CHANGED" TO Concepto.obligatorio IN FRAME frm-entidad.
   END.   

END.   

/*--------------------- Tratamiendo del browse de convenios -------------*/

&SCOPED-DEFINE VER              1
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_convenios
&SCOPED-DEFINE ACT_REGBROWSE    act_cnc_convenio
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnc_convenio
&SCOPED-DEFINE TABLA-BRW        Concepto_Convenio
&SCOPED-DEFINE TABLA-MASTER     Concepto
&SCOPED-DEFINE ACTREGIS         ACTCNCNV
&SCOPED-DEFINE QRY_BROWSE       qry_convenios
&SCOPED-DEFINE QRY_CONDICION    Concepto_convenio OF Concepto, ~
                                EACH Convenio OF Concepto_convenio
&SCOPED-DEFINE MENSAJE-VACIO    NO hay convenios asociados al concepto
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este convenio?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de liquidaciones -------------*/

&SCOPED-DEFINE VER              2
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_liquidaciones
&SCOPED-DEFINE ACT_REGBROWSE    act_cnc_liquid
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnc_liquid
&SCOPED-DEFINE TABLA-BRW        Concepto_Liquidacion
&SCOPED-DEFINE TABLA-MASTER     Concepto
&SCOPED-DEFINE ACTREGIS         ACTCNLIQ
&SCOPED-DEFINE QRY_BROWSE       qry_liquidaciones
&SCOPED-DEFINE QRY_CONDICION    Concepto_liquidacion OF Concepto, ~
                                EACH Tipo_de_liquidac OF Concepto_liquidacion
&SCOPED-DEFINE MENSAJE-VACIO    NO hay liquidaciones asociadas al concepto
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar esta liquidacion?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de empleados -------------*/

&SCOPED-DEFINE VER              3
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_empleados
&SCOPED-DEFINE ACT_REGBROWSE    act_cnc_empleado
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnc_empleado
&SCOPED-DEFINE TABLA-BRW        Concepto_Empleado
&SCOPED-DEFINE TABLA-MASTER     Concepto
&SCOPED-DEFINE ACTREGIS         ACTCNMPL
&SCOPED-DEFINE QRY_BROWSE       qry_empleados
&SCOPED-DEFINE QRY_CONDICION    Concepto_Empleado OF Concepto, ~
                                EACH Empleado OF Concepto_Empleado
&SCOPED-DEFINE MENSAJE-VACIO    NO hay empleados asociados al concepto
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar este empleado?

{TRGBROWS.I}

/*--------------------- Tratamiendo del browse de convenios -------------*/

&SCOPED-DEFINE VER              4
&SCOPED-DEFINE MULTI-BROWSE     YES
&SCOPED-DEFINE BROWSE           brw_imputacion
&SCOPED-DEFINE ACT_REGBROWSE    act_cnc_cuenta
&SCOPED-DEFINE ULT_REGBROWSE    ult_cnc_cuenta
&SCOPED-DEFINE TABLA-BRW        Concepto-cuenta
&SCOPED-DEFINE TABLA-MASTER     Concepto
&SCOPED-DEFINE ACTREGIS         ACTCNCTA
&SCOPED-DEFINE QRY_BROWSE       qry_imputacion
&SCOPED-DEFINE QRY_CONDICION    Concepto-cuenta OF Concepto, ~
                                FIRST Entidad OF Concepto-cuenta, ~
                                FIRST Cuenta OF Concepto-cuenta
&SCOPED-DEFINE MENSAJE-VACIO    NO hay imputaciones asociados al concepto
&SCOPED-DEFINE MENSAJE-BAJA     Realmente desea desasignar esta imputacion?

{TRGBROWS.I}


/*============================= H E L P S =======================================*/

&SCOPED-DEFINE ENTIDAD          Concepto

{HLPTOTAL.I "cdg_totalizador" "frm-entidad" "YES" "YES"}  /* Totalizador     */
{HLPSUMAD.I "cdg_sumador" "frm-entidad" "YES" "YES"    }  /* Sumador         */

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

     IF ROWID(Concepto) = ?
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE000").
        RETURN.
     END.

     IF INPUT FRAME frm-entidad Concepto.descripcion = "" OR 
        INPUT FRAME frm-entidad Concepto.descripcion = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE001").
        RETURN.
     END.            

     IF CAN-FIND(FIRST Concepto 
                       WHERE Concepto.cdg_concepto = INPUT FRAME frm-entidad Concepto.cdg_concepto  
                         AND ROWID(Concepto) <> act_Concepto )
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE002").
        RETURN.
     END.            

     IF INPUT FRAME frm-entidad Concepto.abreviatura = "" OR 
        INPUT FRAME frm-entidad Concepto.abreviatura = ?  
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE003").
        RETURN.
     END.            

     IF INPUT FRAME frm-entidad Concepto.obligatorio AND 
        INPUT FRAME frm-entidad Concepto.temporario
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE005").
        RETURN.
     END.            

     RUN VRSINTAX.P ( INPUT FRAME frm-entidad Concepto.formula,
                      OUTPUT rc_sintax, 
                      OUTPUT palabra, 
                      OUTPUT caracter).
     IF rc_sintax <> 0 
     THEN DO:
        RUN PONMENSJ.P (INPUT "CNCE006").
        RETURN.
     END.            

{IFNOTEXS.I "Sumador"  "cdg_sumador"  "frm-entidad" "Concepto" "cdg_sumador"  "CNCE004" }
{IFNOTEXS.I "Totalizador"  "cdg_totalizador"  "frm-entidad" "Concepto" "cdg_totalizador"  "CNCE007" }


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

