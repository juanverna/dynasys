/*------------------------------------------------------------------------------------*/
/* Listados Varios de la tabla Empleado                                                */
/*                                                                                    */
/* Definiciones Globales:                                                             */
/* ----------------------                                                             */
/*                                                                                    */
/* TITULO    : Titulo del Listado                                                     */
/* CAMPOS    : Lista de campos a mostrar                                              */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

DEFINE INPUT PARAMETER disp_out  AS CHARACTER.

{VRSHARED.I}
{VPERSINM.I}

{DFVRNEMP.I }
{DFVARSEL.I }

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
  titulo_lst AT 40
  "Pagina:" AT 120 PAGE-NUMBER FORMAT ">9" AT 128
  SKIP  
  fecha_lis       
  titulo_det AT 40  
  hora_lis AT 120
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

  FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                      AND Empleado.nro_legajo <= has_legajo
                      AND Empleado.{&POR-TABLA} >= des_tabla
                      AND Empleado.{&POR-TABLA} <= has_tabla
                      AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                          BREAK BY Empleado.{&POR-TABLA} BY Empleado.nro_legajo:

     VIEW FRAME frm-titulo.

     IF FIRST-OF(Empleado.{&POR-TABLA})
        THEN FIND {&TABLA-EXTERNA} WHERE {&TABLA-EXTERNA}.{&CDG_EXTERNA} = Empleado.{&POR-TABLA} NO-LOCK.

     DISPLAY {&CAMPOS-DSP}
          WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.          


  END.
  
  UNDERLINE {&CAMPOS}
       WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

  RUN veresult.w ( INPUT dire_tmp + "{&ARCHIVO-SALIDA}.txt" , INPUT 8).

END PROCEDURE.  

{CODIMPRE.I}
