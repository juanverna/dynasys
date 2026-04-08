/*=================================================================================*/
/*                      F R A M E S   Y   P A R A M E T R O S                      */
/*=================================================================================*/

{VRSHARED.I }
{dfvarimp.i}

DEFINE INPUT PARAMETER des_fecha LIKE Caj_header.fecha.
DEFINE INPUT PARAMETER has_fecha LIKE Caj_header.fecha.

DEFINE VARIABLE hubo_cheque    AS LOGICAL.

DEFINE VARIABLE fecha_fr  AS CHARACTER.
DEFINE VARIABLE hora_fr   AS CHARACTER.

DEFINE VARIABLE lest      AS INTEGER.
DEFINE VARIABLE Total     AS DECIMAL FORMAT "->>,>>>,>>9.99".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "{&TITULO-LS}" AT 43
  "Pagina:" AT 111 PAGE-NUMBER FORMAT ">9" AT 118
  SKIP  
  fecha_lis   
  "del" AT 43
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 111
  SKIP(1)
  WITH WIDTH 160 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.
 
DEFINE FRAME frm-listado
       {&CORTE-POR}
       {&CAMPOS-LS} Total
       /*
       Caj_header.tip_comprob
       Caj_header.nro_comprob
       */
       Proveedor.cdg_proveedor
       Proveedor.nombre
       WITH WIDTH 160 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

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

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i &LIN-PAG=72}

  /*
  OUTPUT TO VALUE(dire_tmp + "ls{&ID-PROG}.txt") PAGED PAGE-SIZE 36.  
  */
 
  FOR EACH  Cheque NO-LOCK
      WHERE {&CORTE-POR}  >= des_fecha 
        AND {&CORTE-POR}  <= has_fecha, 
      Cuenta_bancaria OF Cheque NO-LOCK 
          WHERE Cuenta_bancaria.cdg_empresa = Empresa.cdg_empresa
      BREAK BY( {&CORTE-POR} )
      WITH FRAME frm-listado:
      
      VIEW FRAME frm-titulo.

      IF Cheque.estado <> "A" THEN Total=Total + Cheque.importe.
      FIND Proveedor OF Cheque NO-LOCK NO-ERROR.   
      FIND Caj_detalle OF Cheque NO-LOCK NO-ERROR.
      DISPLAY {&CORTE-POR}  WHEN FIRST-OF( {&CORTE-POR} ) 
              {&CAMPOS-LS} 
              Total WHEN Cheque.estado <> "A"
              /*
              Caj_header.tip_comprob  WHEN AVAILABLE Caj_header
              Caj_header.nro_comprob  WHEN AVAILABLE Caj_header
              */
              Proveedor.cdg_proveedor WHEN AVAILABLE Proveedor
              Proveedor.nombre        WHEN AVAILABLE Proveedor
              WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.
              
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

PROCEDURE PONER_SESION:

  CURRENT-WINDOW:TITLE   = titulo_w.
  STATUS INPUT "Ingrese datos o presione Esc para salir del programa.".

END PROCEDURE.

{CODIMPRE.I}
