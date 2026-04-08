/*====================================================================================*/
/*                   LISTADOS DE EMPLEADOS POR UNA TABLA EXTERNA                     */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codtabla LIKE {&TABLA-EXTERNA}.{&CDG_EXTERNA}.
DEFINE INPUT PARAMETER has_codtabla LIKE {&TABLA-EXTERNA}.{&CDG_EXTERNA}.
DEFINE INPUT PARAMETER disp_out  AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

{DFVRNEMP.I }
{DFVARSEL.I }

DEFINE VARIABLE ant_tabla   LIKE {&TABLA-EXTERNA}.{&CDG_EXTERNA}.
DEFINE VARIABLE todos       AS LOGICAL.     
DEFINE VARIABLE j           AS INTEGER.     
DEFINE VARIABLE fecha_lis   AS DATE.     
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(40)" INITIAL "{&TITULO}".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  titulo_lst AT {&POS_TIT}
  "Pagina:" AT {&POS_PAG} PAGE-NUMBER FORMAT ">9" AT {&POS_NPAG}
  SKIP  
  fecha_lis       
  hora_lis AT {&POS_PAG}
  SKIP(1)
  WITH WIDTH {&ANCHO-LST} FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       {&CAMPOS}
       WITH WIDTH {&ANCHO-LST} DOWN FRAME frm-listado USE-TEXT STREAM-IO .

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE LISTAR:
       
  FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
  que_empresa = Empresa.nombre.

  IF NUM-ENTRIES(sel_nombres) = 0 THEN todos = YES.
                                  ELSE todos = NO.
         
  RUN CVNOMCOD.P ( INPUT sel_nombres, OUTPUT sel_codigos ).

  titulo_det = ( IF todos THEN "Todos los estados" ELSE "Estados:" + sel_codigos ).

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO VALUE(dire_tmp + "{&ARCHIVO-SALIDA}.txt") PAGE-SIZE {&LIN-PAGINA}.

  {&SETEAR-IMPRESORA}

  IF ver_por = 1
     THEN OPEN QUERY qry_empleados
            FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                                AND Empleado.nro_legajo <= has_legajo
                                AND Empleado.{&POR-TABLA} >= des_codtabla
                                AND Empleado.{&POR-TABLA} <= has_codtabla
                                AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                                BY Empleado.{&POR-TABLA} BY Empleado.nro_legajo.
     ELSE OPEN QUERY qry_empleados
            FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                                AND Empleado.nombre <= has_nombre
                                AND Empleado.{&POR-TABLA} >= des_codtabla
                                AND Empleado.{&POR-TABLA} <= has_codtabla
                                AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                                BY Empleado.{&POR-TABLA} BY Empleado.nombre.


  ant_tabla = ?.
  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado WITH FRAME frm-listado:

     VIEW FRAME frm-titulo.

     IF Empleado.{&POR-TABLA} <> ant_tabla
     THEN DO:
          IF ant_tabla <> ? THEN DOWN 1 WITH FRAME frm-listado.
          FIND {&TABLA-EXTERNA} WHERE {&TABLA-EXTERNA}.{&CDG_EXTERNA} = Empleado.{&POR-TABLA} NO-LOCK.
     END.
     
     DISPLAY {&CAMPOS-DSP}
          WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.          

     ant_tabla = {&TABLA-EXTERNA}.{&CDG_EXTERNA}.

     GET NEXT qry_empleados.

  END.
  
  UNDERLINE {&CAMPOS}
       WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

  /*
  RUN veresult.w ( INPUT dire_tmp + "{&ARCHIVO-SALIDA}.txt" , INPUT 8).*
  */
  
END PROCEDURE.  

{CODIMPRE.I}
