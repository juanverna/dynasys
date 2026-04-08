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

DEFINE VARIABLE modo_debug AS LOGICAL INITIAL NO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */



/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&IF DEFINED(EXCLUDE-fnFechaLogin) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnFechaLogin Method-Library 
FUNCTION fnFechaLogin RETURNS CHARACTER
  ( INPUT p-connect-time AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-fnStringFecha) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fnStringFecha Method-Library 
FUNCTION fnStringFecha RETURNS CHARACTER
  ( INPUT p-fecha AS DATE , INPUT p-hora AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-GetAccion) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD GetAccion Method-Library 
FUNCTION GetAccion RETURNS CHARACTER
  ( INPUT a  AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-GetItem) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD GetItem Method-Library 
FUNCTION GetItem RETURNS CHARACTER
  (   INPUT p-NodeInfo AS CHARACTER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF


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
         HEIGHT             = 27.67
         WIDTH              = 65.
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

&IF DEFINED(EXCLUDE-buscar_proceso_iniciado) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE buscar_proceso_iniciado Method-Library 
PROCEDURE buscar_proceso_iniciado :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER  p-proceso     AS CHARACTER.
  DEFINE OUTPUT PARAMETER p-hay_proceso AS LOGICAL.

  p-hay_proceso = NO.
  
  FOR EACH Logmenu WHERE Logmenu.accion = p-proceso
                   AND Logmenu.fch_hasta = ? NO-LOCK  WHILE NOT p-hay_proceso:


/* EACH sic.Logusuario OF sic.Usuario WHERE ~{&KEY-PHRASE} NO-LOCK
    BY Logusuario.fch_desde DESCENDING
       BY Logusuario.hms_desde DESCENDING */
 
      FIND Usuario OF Logmenu NO-LOCK.

      FIND LAST  Logusuario OF Usuario 
          USE-INDEX historia_usuario  NO-LOCK NO-ERROR.
    
      IF AVAILABLE Logusuario AND 
          ( Logmenu.fch_desde > logusuario.fch_desde or
          (Logmenu.fch_desde = logusuario.fch_desde AND Logmenu.hor_desde   > Logusuario.hor_desde) 
       ) 
      THEN DO:
          IF modo_debug
              THEN MESSAGE "Encontre Logmenu con proceso " Logmenu.accion "de fecha" Logmenu.fch_desde
                       "y usuario" Usuario.cdg_usuario ". Proceso a buscar conexion física"
                       VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "buscar_proceso_iniciado".
      
          FOR EACH _Connect 
              WHERE _Connect._Connect-Name = Usuario.cdg_usuario NO-LOCK:

              IF modo_debug
                  THEN MESSAGE "Encontre conexion fisica. Traduzco fecha como" fnFechaLogin(_Connect._Connect-Time) SKIP
                           "La conexion logica tiene stringfecha" fnStringFecha(Logmenu.fch_desde,Logmenu.hor_desde) SKIP "Sirve??" fnFechaLogin(_Connect._Connect-Time) <= fnStringFecha(Logmenu.fch_desde,Logmenu.hor_desde)
                           VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "buscar_proceso_iniciado".

              IF fnFechaLogin(_Connect._Connect-Time) <= fnStringFecha(Logmenu.fch_desde,Logmenu.hor_desde)
              THEN DO:
                  MESSAGE Usuario.cdg_usuario "(" Usuario.nombre ") está utilizando " Logmenu.accion "desde el" 
                      Logmenu.fch_desde "a las" Logmenu.hms_desde "en una sesión de fecha" 
                      _Connect._Connect-Time "en el puesto de trabajo" _Connect._Connect-Device
                      VIEW-AS ALERT-BOX WARNING TITLE "ENCONTRADO PROCESO CONCURRENTE".
                  p-hay_proceso = YES.
              END.
          END.
      END.
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-cargar_menu) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE cargar_menu Method-Library 
PROCEDURE cargar_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER lista_funciones AS CHARACTER.

  DEFINE VARIABLE a               AS CHARACTER NO-UNDO.
  DEFINE VARIABLE i               AS INTEGER.
  DEFINE VARIABLE j-funcion       AS INTEGER.
  DEFINE VARIABLE tiene_permiso   AS LOGICAL NO-UNDO.
/*
  chChTreeview:TreeView4GL:TreeRefresh = FALSE.  /* Desactivamos el refresh de pantalla */
 
  {findempresa.i}
   
  a = "". /* Borramos el STRING que contiene el arbol y lo armamos en base al contenido de la tabla */

  FOR EACH Menu 
      WHERE Treemenu.cdg_empresa =  Empresa.cdg_empresa
        AND Treemenu.cdg_padre = p-que_padre NO-LOCK BY Treemenu.cdg_item:
  
      IF lista_funciones = "*"
      THEN DO:
           tiene_permiso = YES.
      END.
      ELSE DO:
           tiene_permiso = NO.
           DO j-funcion = 1 TO NUM-ENTRIES(lista_funciones,",") WHILE NOT tiene_permiso:
              tiene_permiso = CAN-DO(Treemenu.permitidos,ENTRY(j-funcion,lista_funciones,",")).
           END.
      END.

      IF tiene_permiso
      THEN DO:
           a = a  + "~n0~t" + Treemenu.titulo + "~t7~t4~t~tAccion=|" + Treemenu.cdg_item.
           run cargar_hijos.p ( INPUT-OUTPUT a, INPUT Treemenu.cdg_item, INPUT lista_funciones, INPUT 1).
      END.

  END.

  
  a = substring(a, 2). /* Eliminamos el primer caracter especial "~n" */
  chChTreeview:TreeView4GL:clear(). /* Borramos el contenido del arbol */
  chChTreeview:TreeView4GL:addnodes(A). /* Asignamos el nuevo contenido */
  chChTreeview:TreeView4GL:TreeRefresh = TRUE.  /* Activamos el refresh de pantalla para visualizar el arbol */
   
  APPLY "ENTRY" to ChTreeview.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-egresa_menu) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE egresa_menu Method-Library 
PROCEDURE egresa_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   DEFINE INPUT PARAMETER rid AS ROWID.
    
   DO TRANSACTION:
    
       FIND Logmenu WHERE ROWID(Logmenu) = rid EXCLUSIVE-LOCK.
       ASSIGN Logmenu.fch_hasta = TODAY
              Logmenu.hor_hasta = TIME
              Logmenu.hms_hasta = STRING(Logmenu.hor_hasta,"HH:MM:SS").
       RELEASE Logmenu.
       
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-ejecutar) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ejecutar Method-Library 
PROCEDURE ejecutar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

    DEFINE INPUT PARAMETER p-accion         AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER p-modo           AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER p-comprobante    AS CHARACTER NO-UNDO.

    /*-------------------------------------------------------------------------*/
    /*                              VARIABLES                                  */
    /*-------------------------------------------------------------------------*/

    DEFINE VARIABLE i-modo                  AS INTEGER   NO-UNDO.
                                            
    DEFINE VARIABLE h-tranxn                AS ROWID     NO-UNDO.
    DEFINE VARIABLE rid_logmenu             AS ROWID     NO-UNDO.
    DEFINE VARIABLE correr_ok               AS LOGICAL   NO-UNDO.
    DEFINE VARIABLE i-estado                AS INTEGER   NO-UNDO.
  
    /*-------------------------------------------------------------------------*/
    /*                              PROCESOS                                   */
    /*-------------------------------------------------------------------------*/

    FIND Usuario WHERE Usuario.cdg_usuario = USERID("sic") NO-LOCK.

         
         IF p-modo <> "X" /* si es de la forma "w-pirulo.w:j" */
         THEN DO:
              i-modo = INTEGER(p-modo).
         END.
         ELSE DO:
              i-modo = ?. /* no hay modo */
         END.     

         IF SEARCH(p-accion) <> ? /* Si esta definida la accion, la ejecutamos */
         THEN DO:
             
             RUN verificar_puedo_ejecutar ( INPUT p-accion, OUTPUT correr_ok ).
             IF correr_ok
             THEN DO:
                 IF Usuario.seguimiento THEN RUN ingresa_menu ( INPUT p-accion, INPUT-OUTPUT rid_logmenu ).
                 IF p-modo = "X"
                 THEN DO:
                     i-estado = {&WINDOW-NAME}:WINDOW-STATE.
                     {&WINDOW-NAME}:HIDDEN = YES.
                     RUN VALUE(p-accion). 
                     {&WINDOW-NAME}:HIDDEN = NO.
                     {&WINDOW-NAME}:WINDOW-STATE = i-estado.
                     {&WINDOW-NAME}:MOVE-TO-TOP().
                 END.
                 ELSE DO:
             
                     IF p-comprobante = ""
                     THEN DO:
                         i-estado = {&WINDOW-NAME}:WINDOW-STATE.             
                         {&WINDOW-NAME}:HIDDEN = YES.
                         RUN VALUE(p-accion) ( INPUT-OUTPUT h-tranxn, INPUT i-modo ).
                         {&WINDOW-NAME}:HIDDEN = NO.
                         {&WINDOW-NAME}:WINDOW-STATE = i-estado.
                         {&WINDOW-NAME}:MOVE-TO-TOP().
                     END.
                     ELSE DO:
                         i-estado = {&WINDOW-NAME}:WINDOW-STATE.
                         {&WINDOW-NAME}:HIDDEN = YES.
                         RUN VALUE(p-accion) ( INPUT-OUTPUT h-tranxn, INPUT i-modo, INPUT p-comprobante ).
                         {&WINDOW-NAME}:HIDDEN = NO.
                         {&WINDOW-NAME}:WINDOW-STATE = i-estado.
                         {&WINDOW-NAME}:MOVE-TO-TOP().
                     END.
                 END.
                 IF Usuario.seguimiento THEN RUN egresa_menu ( INPUT rid_logmenu ).

             END.
             ELSE DO:
                 MESSAGE "Existen procesos concurrentes a " p-accion VIEW-AS ALERT-BOX ERROR TITLE "No puede ejecutarse la opción".
             END.     
             
         END.
         ELSE DO:
             MESSAGE "No se halló " p-accion VIEW-AS ALERT-BOX ERROR TITLE "No puede ejecutarse la opción".
         END.     
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-ingresa_menu) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ingresa_menu Method-Library 
PROCEDURE ingresa_menu :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   DEFINE INPUT  PARAMETER p-accion AS CHARACTER.
   DEFINE INPUT-OUTPUT PARAMETER rid      AS ROWID.

   {findempresa.i}

   DO TRANSACTION:
    
       CREATE Logmenu.
       ASSIGN Logmenu.fch_desde = TODAY
              Logmenu.hor_desde = TIME
              Logmenu.hms_desde = STRING(Logmenu.hor_desde,"HH:MM:SS")
              Logmenu.nro_usuario = Usuario.nro_usuario
              Logmenu.cdg_empresa = Empresa.cdg_empresa
              Logmenu.accion      = p-accion
              Logmenu.cdg_item    = IF AVAILABLE Treemenu THEN Treemenu.cdg_item ELSE "".

       rid = ROWID(Logmenu).
       RELEASE Logmenu.
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-verificar_puedo_ejecutar) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE verificar_puedo_ejecutar Method-Library 
PROCEDURE verificar_puedo_ejecutar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  DEFINE INPUT PARAMETER p-programa AS CHARACTER.
  DEFINE OUTPUT PARAMETER lOk       AS LOGICAL.

  DEFINE VARIABLE hay_proceso       AS LOGICAL.
  DEFINE VARIABLE hay_cierre        AS LOGICAL.
  DEFINE VARIABLE j-programa        AS INTEGER.

  {findempresa.i}

  /* Verifico si soy un cierre */

  hay_proceso = NO.
  FOR EACH Exclusion_procesos NO-LOCK
      WHERE Exclusion_procesos.nom_proceso = p-programa WHILE NOT hay_proceso:

      IF modo_debug
          THEN MESSAGE "SOY CIERRE Y VERIFICO LISTA DE PROCESOS" Exclusion_procesos.nom_programa
                        VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "VERIFICAR_PUEDO_EJECUTAR".

      /* Buscamos si hay algun usuario ejecutando el cierre */

      RUN buscar_proceso_iniciado ( INPUT Exclusion_procesos.nom_programa ,
                                    OUTPUT hay_proceso ).


  END.

  IF hay_proceso
  THEN DO:
      lOk = NO.
      RETURN.
  END.

  /* Verifico si soy un proceso */

  hay_cierre = NO.  
  FOR EACH Exclusion_procesos NO-LOCK
      WHERE Exclusion_procesos.nom_programa = p-programa WHILE NOT hay_cierre:

      IF modo_debug
          THEN MESSAGE "SOY PROCESO Y VERIFICO CIERRE" Exclusion_procesos.nom_proceso
                       VIEW-AS ALERT-BOX INFO BUTTONS OK TITLE "VERIFICAR_PUEDO_EJECUTAR".

      /* Buscamos si hay algun usuario ejecutando el cierre */

      RUN buscar_proceso_iniciado ( INPUT Exclusion_procesos.nom_proceso ,
                                    OUTPUT hay_cierre ).


  END.

  lOk = NOT hay_cierre.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

/* ************************  Function Implementations ***************** */

&IF DEFINED(EXCLUDE-fnFechaLogin) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnFechaLogin Method-Library 
FUNCTION fnFechaLogin RETURNS CHARACTER
  ( INPUT p-connect-time AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-connect-time AS CHARACTER.
  DEFINE VARIABLE x-connect-time AS CHARACTER.
  DEFINE VARIABLE v-dia  AS INTEGER.
  DEFINE VARIABLE v-mes  AS INTEGER.
  DEFINE VARIABLE v-ano  AS INTEGER.
  DEFINE VARIABLE v-fecha AS DATE.
  DEFINE VARIABLE s-momento AS CHARACTER.

/* Jueves 16 Jun 2005 13:33:34 */

  x-connect-time = REPLACE(p-connect-time,"  "," ").
  IF ENTRY(3,x-connect-time, " ") = ""
      THEN v-connect-time =       ENTRY(4,x-connect-time, " ") + 
                            " " + ENTRY(2,x-connect-time, " ") +
                            " " + ENTRY(6,x-connect-time, " ") + 
                            " " + ENTRY(5,x-connect-time, " ").
      ELSE v-connect-time =   ENTRY(3,x-connect-time, " ") + 
                        " " + ENTRY(2,x-connect-time, " ") +
                        " " + ENTRY(5,x-connect-time, " ") + 
                        " " + ENTRY(4,x-connect-time, " ").

  v-dia = INTEGER(ENTRY(1,v-connect-time, " ")).
  v-ano = INTEGER(ENTRY(3,v-connect-time, " ")).

  CASE ENTRY(2,v-connect-time, " "):
      WHEN "Ene" THEN v-mes = 1.
      WHEN "Feb" THEN v-mes = 2.
      WHEN "Mar" THEN v-mes = 3.
      WHEN "Abr" THEN v-mes = 4.
      WHEN "May" THEN v-mes = 5.
      WHEN "Jun" THEN v-mes = 6.
      WHEN "Jul" THEN v-mes = 7.
      WHEN "Ago" THEN v-mes = 8.
      WHEN "Sep" THEN v-mes = 9.
      WHEN "Oct" THEN v-mes = 10.
      WHEN "Nov" THEN v-mes = 11.
      WHEN "Dic" THEN v-mes = 12.
  END CASE.

  RETURN STRING(v-ano,"9999") + STRING(v-mes,"99") + STRING(v-dia,"99") + 
      ENTRY(4,v-connect-time, " ").

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-fnStringFecha) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fnStringFecha Method-Library 
FUNCTION fnStringFecha RETURNS CHARACTER
  ( INPUT p-fecha AS DATE , INPUT p-hora AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VARIABLE v-dia  AS INTEGER.
  DEFINE VARIABLE v-mes  AS INTEGER.
  DEFINE VARIABLE v-ano  AS INTEGER.

  v-dia = DAY(p-fecha).
  v-mes = MONTH(p-fecha).
  v-ano = YEAR(p-fecha).

  RETURN STRING(v-ano,"9999") + STRING(v-mes,"99") + STRING(v-dia,"99") + STRING(p-hora,"HH:MM:SS").

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-GetAccion) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION GetAccion Method-Library 
FUNCTION GetAccion RETURNS CHARACTER
  ( INPUT a  AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VARIABLE v-accion AS CHARACTER NO-UNDO.
    DEFINE VARIABLE p        AS INTEGER   NO-UNDO.
  

    /* ------------------------------------------------------------------------------------------- */
    /* Tomamos lo que está a la izquierda de "|", que es de la forma "Accion=w-pirulo.w[,modo:I]"  */
    /* ------------------------------------------------------------------------------------------- */
    
    p = INDEX(a,"Accion").
    v-accion = ENTRY(1,SUBSTRING(a,p),"|"). 

    /* ------------------------------------------------------------------------------------------- */
    /* Tomamos lo que está a la derecha de "=", que es el nombre del programa y el modo (opcional) */
    /* ------------------------------------------------------------------------------------------- */
    
    v-accion = ENTRY(2,v-accion,"="). 

    RETURN v-accion.   /* Function return value. */


END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

&IF DEFINED(EXCLUDE-GetItem) = 0 &THEN

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION GetItem Method-Library 
FUNCTION GetItem RETURNS CHARACTER
  (   INPUT p-NodeInfo AS CHARACTER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
 
  DEFINE VARIABLE v-item AS CHARACTER.
  DEFINE VARIABLE p      AS INTEGER.

  p = INDEX(p-NodeInfo,"Accion").
  IF p <> 0 /* Si existe el string Accion en la información del nodo ....*/
  THEN DO:
       v-item = ENTRY(2,SUBSTRING(p-NodeInfo,p),"|"). /* Tomamos lo que está a la derecha de "|", que es el codigo de item */
  END.
  ELSE DO:
       v-item = "".
  END.

  RETURN v-item.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ENDIF

