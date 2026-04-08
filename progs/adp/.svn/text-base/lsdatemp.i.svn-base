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
  WITH WIDTH 131 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

DEFINE FRAME frm-listado
       {&CAMPOS}
       WITH WIDTH 131 DOWN FRAME frm-listado USE-TEXT STREAM-IO .

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
  
  IF disp_out = "A" THEN OUTPUT TO VALUE(dire_tmp + "{&ARCHIVO-SALIDA}.txt") PAGED.
                    ELSE OUTPUT TO VALUE(port) PAGED. 

  {&SETEAR-IMPRESORA}
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                          BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                          BY Empleado.nombre.
  END.

  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado:
     VIEW FRAME frm-titulo.
     DISPLAY {&CAMPOS}
          WITH FRAME frm-listado.
     DOWN WITH FRAME frm-listado.          
     GET NEXT qry_empleados.
  END.
  
  UNDERLINE {&CAMPOS}
       WITH FRAME frm-listado.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.


END PROCEDURE.  

{CODIMPRE.I}
