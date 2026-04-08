&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12
&ANALYZE-RESUME
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Method-Library 
/*--------------------------------------------------------------------------
    Library     : 
    Purpose     :

    Syntax      :

    Description :

    Author(s)   :
    Created     :
    Notes       :
  ------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Method-Library
   Allow: 
   Frames: 0
   Add Fields to: Neither
   Other Settings: INCLUDE-ONLY
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW Method-Library ASSIGN
         HEIGHT             = 2
         WIDTH              = 40.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME
 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB Method-Library 
/* ************************* Included-Libraries *********************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME



&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Method-Library 


/* ***************************  Main Block  *************************** */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&IF DEFINED(EXCLUDE-armar_nombre) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE armar_nombre Method-Library 
PROCEDURE armar_nombre :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE OUTPUT PARAMETER nombre_archivo AS CHARACTER.

  DEFINE VARIABLE quien_llama AS CHARACTER.
  DEFINE VARIABLE j-llama     AS INTEGER.

  /*{showstack.i}*/

  quien_llama = "".
  DO j-llama = 1 TO 9 WHILE SUBSTRING(quien_llama,2,1) <> "-": 
     quien_llama = PROGRAM-NAME(j-llama).
  END.
  quien_llama = SUBSTRING(quien_llama,1,INDEX(quien_llama,".") - 1).

          /*  MESSAGE "Tal Cual:" quien_llama VIEW-AS ALERT-BOX MESSAGE. */

  IF INDEX(quien_llama,".") <> 0
  THEN DO:
       quien_llama = ENTRY(1,quien_llama,"."). /* Separamos la extension del archivo */ 
              
         /*   MESSAGE "Sin Punto:" quien_llama VIEW-AS ALERT-BOX MESSAGE. */

  END.

  IF NUM-ENTRIES(quien_llama,"\") <> 0
  THEN DO:
         quien_llama = ENTRY(NUM-ENTRIES(quien_llama,"\"),quien_llama,"\"). /* Separamos la barra */ 

         /*   MESSAGE "Sin Barra:" quien_llama VIEW-AS ALERT-BOX MESSAGE. */

  END.

  nombre_archivo = quien_llama + ".txt" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-lst-imprimir) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE lst-imprimir Method-Library 
PROCEDURE lst-imprimir :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE p_Printed      AS LOGICAL.
  DEFINE VARIABLE nombre_archivo AS CHARACTER.

  DEFINE VARIABLE v-font AS INTEGER INITIAL 22.
  DEFINE VARIABLE v-flag AS INTEGER INITIAL 0.
  DEFINE VARIABLE v-lins AS INTEGER INITIAL 72.

  {parlocales.i}

  RUN armar_nombre ( OUTPUT nombre_archivo ).

  /*
  RUN getparametro.p (  INPUT  "DIRECTMP",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).
  */
  v-valor_c = SESSION:TEMP-DIRECTORY.
  
  FIND Ctl_reporte 
       WHERE Ctl_reporte.nom_reporte = nombre_archivo NO-LOCK NO-ERROR.
       
  IF AVAILABLE Ctl_reporte
  THEN DO:
       ASSIGN 
           v-font = Ctl_reporte.numero_font
           v-flag = Ctl_reporte.modo_impresion
           v-lins = Ctl_reporte.lineas_pp.
  END.
  
  nombre_archivo = v-valor_c + nombre_archivo.

  RUN _osprint.p ( INPUT  CURRENT-WINDOW:HANDLE, /* HANDLE de la WINDOW    */
                   INPUT  nombre_archivo ,       /* Archivo a imprimir     */
                   INPUT  v-font,                /* FONT a utilizar        */
                   INPUT  v-flag,                /* Print Flags 2=Apaisado */
                   INPUT  v-lins,                /* Lineas por Pagina      */
                   INPUT  0,                     /* 0= Todo, <>0 seleccion */
                   OUTPUT p_Printed ).           /* Se imprimió o no       */

  IF p_Printed 
     THEN MESSAGE "El archivo ha sido enviado a impresión"
                   VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje del Sistema".

     ELSE MESSAGE "El archivo NO ha sido impreso"
                   VIEW-AS ALERT-BOX MESSAGE TITLE "Mensaje del Sistema".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-lst-mostrar) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE lst-mostrar Method-Library 
PROCEDURE lst-mostrar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE VARIABLE nombre_archivo AS CHARACTER.

  RUN armar_nombre ( OUTPUT nombre_archivo ).

  FIND Ctl_reporte 
       WHERE Ctl_reporte.nom_reporte = nombre_archivo NO-LOCK NO-ERROR.
       
  IF AVAILABLE Ctl_reporte
  THEN DO:
       RUN VERESULT.W ( INPUT  nombre_archivo,  /* Archivo */
                        INPUT  Ctl_reporte.numero_font ).                /* FONT a utilizar por default */               
  END.
  ELSE DO:
       RUN VERESULT.W ( INPUT  nombre_archivo,  /* Archivo */
                        INPUT  22                      ).                /* FONT a utilizar por default */               
  END.
  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

