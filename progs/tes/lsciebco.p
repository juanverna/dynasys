/*====================================================================================*/
/*                  CIERRE DE CUENTAS CORRIENTES Cuenta_bancariaES                          */
/*====================================================================================*/

DEFINE INPUT PARAMETER has_fecha   AS DATE.

{VPERSINM.I}
{VRSHARED.I}
{RANGOBCO.I}
{dfvarimp.i}

DEFINE VARIABLE que_fecha   AS DATE.
DEFINE VARIABLE saldo       AS DECIMAL FORMAT "-ZZZZZZ9.99" LABEL "Deuda Total".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"                
  "Cierre de Saldos Bancarios al" AT 30
  has_fecha
  "Pagina:" AT 69 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis
  hora_lis AT 69
  SKIP(1)
  WITH WIDTH 80 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Cuenta_bancaria.cdg_cuenta_ban COLUMN-LABEL "Codigo"
  Cuenta_bancaria.denominacion_cta 
  saldo
  que_fecha
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.
/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN PROCESAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE PROCESAR:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  PAUSE 0.
  mensaje = "    Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  {dirprinfile.i &LIN-PAG=72}

  /*
  OUTPUT TO VALUE(dire_tmp + "lsciebco.txt") PAGED.
  */
  
  {OPQRYBCO.I}
  
  GET FIRST qry_cuenta.
  DO WHILE AVAILABLE Cuenta_bancaria:

     VIEW FRAME frm-titulo.
     RUN CIERRBCO.P ( INPUT ROWID(Cuenta_bancaria), 
                      INPUT has_fecha, 
                      OUTPUT saldo,
                      OUTPUT que_fecha).
     DISPLAY Cuenta_bancaria.cdg_cuenta_ban 
             Cuenta_bancaria.denominacion_cta
             saldo
             que_fecha
             WITH FRAME frm-listado.
     GET NEXT qry_cuenta.

  END.   

  UNDERLINE Cuenta_bancaria.cdg_cuenta_ban 
            Cuenta_bancaria.denominacion_cta
            saldo
            que_fecha
            WITH FRAME frm-listado.

  DOWN WITH FRAME frm-listado.

  UNDERLINE Cuenta_bancaria.cdg_cuenta_ban 
            Cuenta_bancaria.denominacion_cta
            saldo
            que_fecha
            WITH FRAME frm-listado.
            
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

{CODIMPRE.I}
