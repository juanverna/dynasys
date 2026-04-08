&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI ADM1
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS D-Dialog 
/*********************************************************************
* Copyright (C) 2000 by Progress Software Corporation ("PSC"),       *
* 14 Oak Park, Bedford, MA 01730, and other contributors as listed   *
* below.  All Rights Reserved.                                       *
*                                                                    *
* The Initial Developer of the Original Code is PSC.  The Original   *
* Code is Progress IDE code released to open source December 1, 2000.*
*                                                                    *
* The contents of this file are subject to the Possenet Public       *
* License Version 1.0 (the "License"); you may not use this file     *
* except in compliance with the License.  A copy of the License is   *
* available as of the date of this notice at                         *
* http://www.possenet.org/license.html                               *
*                                                                    *
* Software distributed under the License is distributed on an "AS IS"*
* basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. You*
* should refer to the License for the specific language governing    *
* rights and limitations under the License.                          *
*                                                                    *
* Contributors:                                                      *
*                                                                    *
*********************************************************************/
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrdlg.w - ADM SmartDialog Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

{VRSHARED.I "new"}
    DEFINE VARIABLE que_empresa     LIKE Empresa.nombre.
    DEFINE VARIABLE que_parametro   LIKE Parametro.cdg_parametro.
    DEFINE VARIABLE credebfc        LIKE Parametro.valor_l INITIAL NO.
    DEFINE VARIABLE tipos_validos   AS CHARACTER LABEL "Tipos de formulario".

    DEFINE VARIABLE mensaje         AS CHARACTER FORMAT "X(40)".


    DEFINE VARIABLE j               AS INTEGER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDialog
&Scoped-define DB-AWARE no

&Scoped-define ADM-CONTAINER DIALOG-BOX

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME D-Dialog

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_ok v-pto_venta Btn_Cancel tip_forma ~
has_forma des_forma 
&Scoped-Define DISPLAYED-OBJECTS v-pto_venta tip_forma has_forma des_forma 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_ok AUTO-GO 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE tip_forma AS CHARACTER FORMAT "X(256)":U 
     LABEL "Tipo Formulario" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "FA","FB","FC","CA","CB","CC","DA","DB","DC" 
     DROP-DOWN-LIST
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE des_forma AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Desde" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE has_forma AS INTEGER FORMAT "99999999":U INITIAL 0 
     LABEL "Hasta" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE v-pto_venta AS INTEGER FORMAT "9999":U INITIAL 0 
     LABEL "Punto de Venta" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME D-Dialog
     Btn_ok AT ROW 1.52 COL 49
     v-pto_venta AT ROW 1.71 COL 20 COLON-ALIGNED WIDGET-ID 2
     Btn_Cancel AT ROW 2.76 COL 49
     tip_forma AT ROW 2.91 COL 20 COLON-ALIGNED WIDGET-ID 10
     has_forma AT ROW 4.1 COL 20 COLON-ALIGNED WIDGET-ID 6
     des_forma AT ROW 5.29 COL 20 COLON-ALIGNED WIDGET-ID 8
     SPACE(33.79) SKIP(0.51)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Retroceder anulacion de Formularios"
         DEFAULT-BUTTON Btn_ok CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDialog
   Allow: Basic,Browse,DB-Fields,Query,Smart
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB D-Dialog 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX D-Dialog
   FRAME-NAME                                                           */
ASSIGN 
       FRAME D-Dialog:SCROLLABLE       = FALSE
       FRAME D-Dialog:HIDDEN           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK DIALOG-BOX D-Dialog
/* Query rebuild information for DIALOG-BOX D-Dialog
     _Options          = "SHARE-LOCK"
     _Query            is NOT OPENED
*/  /* DIALOG-BOX D-Dialog */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME D-Dialog
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL D-Dialog D-Dialog
ON WINDOW-CLOSE OF FRAME D-Dialog /* Retroceder anulacion de Formularios */
DO:  
  /* Add Trigger to equate WINDOW-CLOSE to END-ERROR. */
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_ok D-Dialog
ON CHOOSE OF Btn_ok IN FRAME D-Dialog /* OK */
DO:

     ASSIGN tip_forma v-pto_venta des_forma has_forma.
{findempresa.I}
     FIND Punto-venta 
          WHERE Punto-venta.cdg_puntovta = v-pto_venta
            AND Punto-venta.cdg_empresa  = Empresa.cdg_empresa
                NO-LOCK NO-ERROR.
     IF NOT AVAILABLE Punto-venta THEN DO:
          MESSAGE "No existe el punto de venta indicado!!!" VIEW-AS ALERT-BOX ERROR.
          RETURN NO-APPLY.
     END.

     FOR EACH Fac_header 
        WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
          AND Fac_header.tip_comprob = tip_forma
          AND Fac_header.prf_comprob = v-pto_venta
          AND Fac_header.nro_comprob >= des_forma
          AND Fac_header.nro_comprob <= has_forma:
    
          FOR EACH Fac_detalle OF Fac_header:
              DELETE Fac_detalle.
          END.
         
          FOR EACH Sub_header_vta
              WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
                AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
                AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob:
             
              DELETE Sub_header_vta.
             
          END.    
     
          FOR EACH Sub_detalle_vta
              WHERE Sub_detalle_vta.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_detalle_vta.tip_comprob = Fac_header.tip_comprob
                AND Sub_detalle_vta.prf_comprob = Fac_header.prf_comprob
                AND Sub_detalle_vta.nro_comprob = Fac_header.nro_comprob:
              
              DELETE Sub_detalle_vta.
             
          END.    
     


          FOR EACH Sub_header_inv
              WHERE Sub_header_inv.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_header_inv.tip_comprob = Fac_header.tip_comprob
                AND Sub_header_inv.prf_comprob = Fac_header.prf_comprob
                AND Sub_header_inv.nro_comprob = Fac_header.nro_comprob:
             
              DELETE Sub_header_inv.
             
          END.    
     
          FOR EACH Sub_detalle_inv
              WHERE Sub_detalle_inv.cdg_empresa = Fac_header.cdg_empresa
                AND Sub_detalle_inv.tip_comprob = Fac_header.tip_comprob
                AND Sub_detalle_inv.prf_comprob = Fac_header.prf_comprob
                AND Sub_detalle_inv.nro_comprob = Fac_header.nro_comprob:
              
              DELETE Sub_detalle_inv.
             
          END.    
          FOR EACH Cta_cte
                WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
                  AND Cta_cte.tip_comprob = Fac_header.tip_comprob
                  AND Cta_cte.prf_comprob = Fac_header.prf_comprob
                  AND Cta_cte.nro_comprob = Fac_header.nro_comprob:
            
              DELETE Cta_cte.
            
          END. 

          FOR EACH cct_stock 
                WHERE cct_stock.cdg_empresa = Fac_header.cdg_empresa
                  AND cct_stock.tip_comprob = Fac_header.tip_comprob 
                  AND cct_stock.prf_comprob = Fac_header.prf_comprob 
                  AND cct_stock.nro_comprob = Fac_header.nro_comprob:
              
                DELETE cct_stock.
            
          END.

          DELETE Fac_header.
     
     END.      

     CASE tip_forma:
          WHEN "FA" THEN que_parametro = "PFAA".
          WHEN "FB" THEN que_parametro = "PFAB".
          WHEN "FC" THEN que_parametro = "PFAC".
          WHEN "CA" THEN que_parametro = "PCRA".
          WHEN "CB" THEN que_parametro = "PCRB".
          WHEN "CC" THEN que_parametro = "PCRC".
          WHEN "DA" THEN que_parametro = "PDBA".
          WHEN "DC" THEN que_parametro = "PDBC".
          WHEN "DB" THEN que_parametro = "PDBB".
     END CASE.

     que_parametro = que_parametro + STRING(v-pto_venta,"9999").
     FIND Parametro
          WHERE Parametro.cdg_parametro = que_parametro
            AND Parametro.cdg_empresa   = Empresa.cdg_empresa
                EXCLUSIVE-LOCK.

     Parametro.valor_n = des_forma.

     RELEASE Parametro.
     PAUSE 0.
     HIDE FRAME frm-espere.
     DISPLAY tip_forma des_forma has_forma
            WITH FRAME frm-rango.
  


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK D-Dialog 


/* ***************************  Main Block  *************************** */

{src/adm/template/dialogmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects D-Dialog  _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available D-Dialog  _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI D-Dialog  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME D-Dialog.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI D-Dialog  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY v-pto_venta tip_forma has_forma des_forma 
      WITH FRAME D-Dialog.
  ENABLE Btn_ok v-pto_venta Btn_Cancel tip_forma has_forma des_forma 
      WITH FRAME D-Dialog.
  VIEW FRAME D-Dialog.
  {&OPEN-BROWSERS-IN-QUERY-D-Dialog}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize D-Dialog 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .
   RUN getparametro.p (  INPUT  "CREDEBFC",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   credebfc = v-valor_l.
  /* Code placed here will execute AFTER standard behavior.    */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records D-Dialog  _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartDialog, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed D-Dialog 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

