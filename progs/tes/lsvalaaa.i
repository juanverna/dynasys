/*=================================================================================*/
/*                      F R A M E S   Y   P A R A M E T R O S                      */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER st_encartera   AS LOGICAL.
DEFINE INPUT PARAMETER st_depositados AS LOGICAL.
DEFINE INPUT PARAMETER st_acreditados AS LOGICAL.
DEFINE INPUT PARAMETER st_rechazados  AS LOGICAL.
DEFINE INPUT PARAMETER st_levantados  AS LOGICAL.
DEFINE INPUT PARAMETER st_cedidos     AS LOGICAL.

{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE hubo_cheque    AS LOGICAL.

DEFINE VARIABLE estados_pedidos  AS CHARACTER LABEL "Estados" FORMAT "X(20)".
DEFINE VARIABLE estados_posibles AS CHARACTER INITIAL "00,01,02,03,04".

DEFINE VARIABLE fecha_fr  AS CHARACTER.
DEFINE VARIABLE hora_fr   AS CHARACTER.

DEFINE VARIABLE lest      AS INTEGER.
DEFINE VARIABLE Total AS DECIMAL.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "{&TITULO-LS}" AT 29
  "Pagina:" AT 82 PAGE-NUMBER FORMAT ">9" AT 89
  SKIP  
  fecha_lis   
  "del" AT 29
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 82
  SKIP
  "Estados solicitados:" AT 29
  estados_pedidos
  SKIP(1)
  WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
       {&CORTE-POR}
       {&CAMPOS-LS} Total
       Proveedor.cdg_proveedor
       Proveedor.nombre
       WITH WIDTH 120 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

nom_funcion = "{&NOM-FUNCION}".
nom_menu = "CAJA".

{SETIMPRE.I}

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
  
  {ARMAESTD.I}

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i} 

  /*
  OUTPUT TO VALUE(dire_tmp + "ls{&ID-PROG}.txt") PAGED PAGE-SIZE 36.  
  */
 
  hubo_cheque = NO.
  FOR EACH  Valor NO-LOCK
      WHERE {&CORTE-POR}  >= des_fecha 
        AND {&CORTE-POR}  <= has_fecha
      BREAK BY( {&CORTE-POR} )
      WITH FRAME frm-listado:
      
      VIEW FRAME frm-titulo.
      
      IF LOOKUP(STRING(Valor.estado,"99"),estados_pedidos) <> 0
      THEN DO:
         FIND Proveedor OF Valor NO-LOCK NO-ERROR.   
         Total=Total + valor.importe.
         DISPLAY {&CORTE-POR}  WHEN FIRST-OF( {&CORTE-POR} ) OR NOT hubo_cheque
                 {&CAMPOS-LS} Total
                 Proveedor.cdg_proveedor          WHEN AVAILABLE Proveedor
                 Proveedor.nombre FORMAT "X(20)"  WHEN AVAILABLE Proveedor
                 WITH FRAME frm-listado.
         DOWN WITH FRAME frm-listado.
         hubo_cheque = YES.
      END.
            
  END.
  
  UNDERLINE   {&CORTE-POR}
              {&CAMPOS-LS} Total
              Proveedor.cdg_proveedor
              Proveedor.nombre       
              WITH FRAME frm-listado STREAM-IO.  

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
     
END PROCEDURE.  

{CODIMPRE.I}
