&ANALYZE-SUSPEND _VERSION-NUMBER AB_v9r12 GUI ADM2
&ANALYZE-RESUME
/* Connected Databases 
          sic-d            PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
{adecomm/appserv.i}
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS dTables 
/*------------------------------------------------------------------------

  File:  

  Description: from DATA.W - Template For SmartData objects in the ADM

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Modified:     February 24, 1999
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartDataObject
&Scoped-define DB-AWARE yes

&Scoped-define ADM-SUPPORTED-LINKS Data-Source,Data-Target,Navigation-Target,Update-Target,Commit-Target,Filter-Target


/* Db-Required definitions. */
&IF DEFINED(DB-REQUIRED) = 0 &THEN
    &GLOBAL-DEFINE DB-REQUIRED TRUE
&ENDIF
&GLOBAL-DEFINE DB-REQUIRED-START   &IF {&DB-REQUIRED} &THEN
&GLOBAL-DEFINE DB-REQUIRED-END     &ENDIF

&Scoped-define QUERY-NAME Query-Main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Empleado

/* Definitions for QUERY Query-Main                                     */
&Scoped-Define ENABLED-FIELDS  actividad_dgi calle carac_servicios cdg_afjp cdg_aseguradora cdg_banco~
 cdg_categoria cdg_convenio cdg_empresa cdg_especializacion cdg_estado~
 cdg_est_civil cdg_forma cdg_franco cdg_postal cdg_prepaga cdg_provincia~
 cdg_seccion cdg_sexo cuenta_nro depto estado_pendiente expedido_por~
 fecha_baja fecha_desde-afjp fecha_ingreso fecha_nac grupo_sanguineo~
 id_plan-os jubilacion localidad lugar_nac nacionalid nombre nom_madre~
 nom_padre noretener nro_cuil nro_empleado nro_entidad nro_legajo numero~
 numero_doc obra_social observacion piso rebaja sindicato telefono tipo_doc~
 total_U78 ult_familiar ult_liquidacion zona
&Scoped-define ENABLED-FIELDS-IN-Empleado actividad_dgi calle ~
carac_servicios cdg_afjp cdg_aseguradora cdg_banco cdg_categoria ~
cdg_convenio cdg_empresa cdg_especializacion cdg_estado cdg_est_civil ~
cdg_forma cdg_franco cdg_postal cdg_prepaga cdg_provincia cdg_seccion ~
cdg_sexo cuenta_nro depto estado_pendiente expedido_por fecha_baja ~
fecha_desde-afjp fecha_ingreso fecha_nac grupo_sanguineo id_plan-os ~
jubilacion localidad lugar_nac nacionalid nombre nom_madre nom_padre ~
noretener nro_cuil nro_empleado nro_entidad nro_legajo numero numero_doc ~
obra_social observacion piso rebaja sindicato telefono tipo_doc total_U78 ~
ult_familiar ult_liquidacion zona 
&Scoped-Define DATA-FIELDS  actividad_dgi calle carac_servicios cdg_afjp cdg_aseguradora cdg_banco~
 cdg_categoria cdg_convenio cdg_empresa cdg_especializacion cdg_estado~
 cdg_est_civil cdg_forma cdg_franco cdg_postal cdg_prepaga cdg_provincia~
 cdg_seccion cdg_sexo cuenta_nro depto estado_pendiente expedido_por~
 fecha_baja fecha_desde-afjp fecha_ingreso fecha_nac grupo_sanguineo~
 id_plan-os jubilacion localidad lugar_nac nacionalid nombre nom_madre~
 nom_padre noretener nro_cuil nro_empleado nro_entidad nro_legajo numero~
 numero_doc obra_social observacion piso rebaja sindicato telefono tipo_doc~
 total_U78 ult_familiar ult_liquidacion zona
&Scoped-define DATA-FIELDS-IN-Empleado actividad_dgi calle carac_servicios ~
cdg_afjp cdg_aseguradora cdg_banco cdg_categoria cdg_convenio cdg_empresa ~
cdg_especializacion cdg_estado cdg_est_civil cdg_forma cdg_franco ~
cdg_postal cdg_prepaga cdg_provincia cdg_seccion cdg_sexo cuenta_nro depto ~
estado_pendiente expedido_por fecha_baja fecha_desde-afjp fecha_ingreso ~
fecha_nac grupo_sanguineo id_plan-os jubilacion localidad lugar_nac ~
nacionalid nombre nom_madre nom_padre noretener nro_cuil nro_empleado ~
nro_entidad nro_legajo numero numero_doc obra_social observacion piso ~
rebaja sindicato telefono tipo_doc total_U78 ult_familiar ult_liquidacion ~
zona 
&Scoped-Define MANDATORY-FIELDS 
&Scoped-Define APPLICATION-SERVICE 
&Scoped-Define ASSIGN-LIST 
&Scoped-Define DATA-FIELD-DEFS "dEmpleado.i"
{&DB-REQUIRED-START}
&Scoped-define OPEN-QUERY-Query-Main OPEN QUERY Query-Main FOR EACH Empleado NO-LOCK INDEXED-REPOSITION.
{&DB-REQUIRED-END}
&Scoped-define TABLES-IN-QUERY-Query-Main Empleado
&Scoped-define FIRST-TABLE-IN-QUERY-Query-Main Empleado


/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

{&DB-REQUIRED-START}

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY Query-Main FOR 
      Empleado SCROLLING.
&ANALYZE-RESUME
{&DB-REQUIRED-END}


/* ************************  Frame Definitions  *********************** */


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartDataObject
   Allow: Query
   Frames: 0
   Add Fields to: Neither
   Other Settings: PERSISTENT-ONLY COMPILE APPSERVER DB-AWARE
 */

/* This procedure should always be RUN PERSISTENT.  Report the error,  */
/* then cleanup and return.                                            */
IF NOT THIS-PROCEDURE:PERSISTENT THEN DO:
  MESSAGE "{&FILE-NAME} should only be RUN PERSISTENT.":U
          VIEW-AS ALERT-BOX ERROR BUTTONS OK.
  RETURN.
END.

&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
/* DESIGN Window definition (used by the UIB) 
  CREATE WINDOW dTables ASSIGN
         HEIGHT             = 1.62
         WIDTH              = 46.57.
/* END WINDOW DEFINITION */
                                                                        */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB dTables 
/* ************************* Included-Libraries *********************** */

{src/adm2/data.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW dTables
  VISIBLE,,RUN-PERSISTENT                                               */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK QUERY Query-Main
/* Query rebuild information for SmartDataObject Query-Main
     _TblList          = "sic-d.Empleado"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sic-d.Empleado.actividad_dgi
"actividad_dgi" "actividad_dgi" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[2]   > sic-d.Empleado.calle
"calle" "calle" ? ? "character" ? ? ? ? ? ? yes ? no 25 yes
     _FldNameList[3]   > sic-d.Empleado.carac_servicios
"carac_servicios" "carac_servicios" ? ? "character" ? ? ? ? ? ? yes ? no 10 yes
     _FldNameList[4]   > sic-d.Empleado.cdg_afjp
"cdg_afjp" "cdg_afjp" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[5]   > sic-d.Empleado.cdg_aseguradora
"cdg_aseguradora" "cdg_aseguradora" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[6]   > sic-d.Empleado.cdg_banco
"cdg_banco" "cdg_banco" ? ? "integer" ? ? ? ? ? ? yes ? no 5.57 yes
     _FldNameList[7]   > sic-d.Empleado.cdg_categoria
"cdg_categoria" "cdg_categoria" ? ? "integer" ? ? ? ? ? ? yes ? no 3.29 yes
     _FldNameList[8]   > sic-d.Empleado.cdg_convenio
"cdg_convenio" "cdg_convenio" ? ? "integer" ? ? ? ? ? ? yes ? no 4.86 yes
     _FldNameList[9]   > sic-d.Empleado.cdg_empresa
"cdg_empresa" "cdg_empresa" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[10]   > sic-d.Empleado.cdg_especializacion
"cdg_especializacion" "cdg_especializacion" ? ? "character" ? ? ? ? ? ? yes ? no 6 yes
     _FldNameList[11]   > sic-d.Empleado.cdg_estado
"cdg_estado" "cdg_estado" ? ? "character" ? ? ? ? ? ? yes ? no 6.14 yes
     _FldNameList[12]   > sic-d.Empleado.cdg_est_civil
"cdg_est_civil" "cdg_est_civil" ? ? "character" ? ? ? ? ? ? yes ? no 5.29 yes
     _FldNameList[13]   > sic-d.Empleado.cdg_forma
"cdg_forma" "cdg_forma" ? ? "character" ? ? ? ? ? ? yes ? no 9.43 yes
     _FldNameList[14]   > sic-d.Empleado.cdg_franco
"cdg_franco" "cdg_franco" ? ? "character" ? ? ? ? ? ? yes ? no 6.29 yes
     _FldNameList[15]   > sic-d.Empleado.cdg_postal
"cdg_postal" "cdg_postal" ? ? "character" ? ? ? ? ? ? yes ? no 5 yes
     _FldNameList[16]   > sic-d.Empleado.cdg_prepaga
"cdg_prepaga" "cdg_prepaga" ? ? "integer" ? ? ? ? ? ? yes ? no 6.72 yes
     _FldNameList[17]   > sic-d.Empleado.cdg_provincia
"cdg_provincia" "cdg_provincia" ? ? "character" ? ? ? ? ? ? yes ? no 4.29 yes
     _FldNameList[18]   > sic-d.Empleado.cdg_seccion
"cdg_seccion" "cdg_seccion" ? ? "character" ? ? ? ? ? ? yes ? no 10 yes
     _FldNameList[19]   > sic-d.Empleado.cdg_sexo
"cdg_sexo" "cdg_sexo" ? ? "character" ? ? ? ? ? ? yes ? no 4.43 yes
     _FldNameList[20]   > sic-d.Empleado.cuenta_nro
"cuenta_nro" "cuenta_nro" ? ? "character" ? ? ? ? ? ? yes ? no 12 yes
     _FldNameList[21]   > sic-d.Empleado.depto
"depto" "depto" ? ? "character" ? ? ? ? ? ? yes ? no 5.72 yes
     _FldNameList[22]   > sic-d.Empleado.estado_pendiente
"estado_pendiente" "estado_pendiente" ? ? "logical" ? ? ? ? ? ? yes ? no 5 yes
     _FldNameList[23]   > sic-d.Empleado.expedido_por
"expedido_por" "expedido_por" ? ? "character" ? ? ? ? ? ? yes ? no 3.72 yes
     _FldNameList[24]   > sic-d.Empleado.fecha_baja
"fecha_baja" "fecha_baja" ? ? "date" ? ? ? ? ? ? yes ? no 9.72 yes
     _FldNameList[25]   > sic-d.Empleado.fecha_desde-afjp
"fecha_desde-afjp" "fecha_desde-afjp" ? ? "date" ? ? ? ? ? ? yes ? no 7.72 yes
     _FldNameList[26]   > sic-d.Empleado.fecha_ingreso
"fecha_ingreso" "fecha_ingreso" ? ? "date" ? ? ? ? ? ? yes ? no 9.72 yes
     _FldNameList[27]   > sic-d.Empleado.fecha_nac
"fecha_nac" "fecha_nac" ? ? "date" ? ? ? ? ? ? yes ? no 9.72 yes
     _FldNameList[28]   > sic-d.Empleado.grupo_sanguineo
"grupo_sanguineo" "grupo_sanguineo" ? ? "character" ? ? ? ? ? ? yes ? no 5.29 yes
     _FldNameList[29]   > sic-d.Empleado.id_plan-os
"id_plan-os" "id_plan-os" ? ? "character" ? ? ? ? ? ? yes ? no 7.57 yes
     _FldNameList[30]   > sic-d.Empleado.jubilacion
"jubilacion" "jubilacion" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[31]   > sic-d.Empleado.localidad
"localidad" "localidad" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes
     _FldNameList[32]   > sic-d.Empleado.lugar_nac
"lugar_nac" "lugar_nac" ? ? "character" ? ? ? ? ? ? yes ? no 20 yes
     _FldNameList[33]   > sic-d.Empleado.nacionalid
"nacionalid" "nacionalid" ? ? "character" ? ? ? ? ? ? yes ? no 2.86 yes
     _FldNameList[34]   > sic-d.Empleado.nombre
"nombre" "nombre" ? ? "character" ? ? ? ? ? ? yes ? no 35 yes
     _FldNameList[35]   > sic-d.Empleado.nom_madre
"nom_madre" "nom_madre" ? ? "character" ? ? ? ? ? ? yes ? no 30 yes
     _FldNameList[36]   > sic-d.Empleado.nom_padre
"nom_padre" "nom_padre" ? ? "character" ? ? ? ? ? ? yes ? no 30 yes
     _FldNameList[37]   > sic-d.Empleado.noretener
"noretener" "noretener" ? ? "logical" ? ? ? ? ? ? yes ? no 13.43 yes
     _FldNameList[38]   > sic-d.Empleado.nro_cuil
"nro_cuil" "nro_cuil" ? ? "character" ? ? ? ? ? ? yes ? no 13 yes
     _FldNameList[39]   > sic-d.Empleado.nro_empleado
"nro_empleado" "nro_empleado" ? ? "integer" ? ? ? ? ? ? yes ? no 6 yes
     _FldNameList[40]   > sic-d.Empleado.nro_entidad
"nro_entidad" "nro_entidad" ? ? "integer" ? ? ? ? ? ? yes ? no 10.57 yes
     _FldNameList[41]   > sic-d.Empleado.nro_legajo
"nro_legajo" "nro_legajo" ? ? "integer" ? ? ? ? ? ? yes ? no 8.57 yes
     _FldNameList[42]   > sic-d.Empleado.numero
"numero" "numero" ? ? "integer" ? ? ? ? ? ? yes ? no 5 yes
     _FldNameList[43]   > sic-d.Empleado.numero_doc
"numero_doc" "numero_doc" ? ? "integer" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[44]   > sic-d.Empleado.obra_social
"obra_social" "obra_social" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[45]   > sic-d.Empleado.observacion
"observacion" "observacion" ? ? "character" ? ? ? ? ? ? yes ? no 400 yes
     _FldNameList[46]   > sic-d.Empleado.piso
"piso" "piso" ? ? "character" ? ? ? ? ? ? yes ? no 3.86 yes
     _FldNameList[47]   > sic-d.Empleado.rebaja
"rebaja" "rebaja" ? ? "decimal" ? ? ? ? ? ? yes ? no 6.43 yes
     _FldNameList[48]   > sic-d.Empleado.sindicato
"sindicato" "sindicato" ? ? "character" ? ? ? ? ? ? yes ? no 8 yes
     _FldNameList[49]   > sic-d.Empleado.telefono
"telefono" "telefono" ? ? "character" ? ? ? ? ? ? yes ? no 15 yes
     _FldNameList[50]   > sic-d.Empleado.tipo_doc
"tipo_doc" "tipo_doc" ? ? "character" ? ? ? ? ? ? yes ? no 4 yes
     _FldNameList[51]   > sic-d.Empleado.total_U78
"total_U78" "total_U78" ? ? "decimal" ? ? ? ? ? ? yes ? no 7.43 yes
     _FldNameList[52]   > sic-d.Empleado.ult_familiar
"ult_familiar" "ult_familiar" ? ? "integer" ? ? ? ? ? ? yes ? no 8.43 yes
     _FldNameList[53]   > sic-d.Empleado.ult_liquidacion
"ult_liquidacion" "ult_liquidacion" ? ? "integer" ? ? ? ? ? ? yes ? no 6.57 yes
     _FldNameList[54]   > sic-d.Empleado.zona
"zona" "zona" ? ? "character" ? ? ? ? ? ? yes ? no 4.43 yes
     _Design-Parent    is WINDOW dTables @ ( 1.15 , 2.57 )
*/  /* QUERY Query-Main */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK dTables 


/* ***************************  Main Block  *************************** */

  &IF DEFINED(UIB_IS_RUNNING) <> 0 &THEN          
    RUN initializeObject.
  &ENDIF

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI dTables  _DEFAULT-DISABLE
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
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

