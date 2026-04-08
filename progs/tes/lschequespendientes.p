/*==================================================================================*/
/* IMPRIME UN LISTADO DE TODOS LOS CHEQUES PENDIENTES SELECCIONADOS PARA IMPRRESION */
/*==================================================================================*/

DEFINE INPUT PARAMETER que_cuenta  LIKE Cuenta_bancaria.cdg_cuenta_ban.
DEFINE INPUT PARAMETER des_ncheque LIKE Cheque.numero_cheque.
DEFINE INPUT PARAMETER has_ncheque LIKE Cheque.numero_cheque.

/*==================================================================================*/
/*                              VARIABLES                                           */
/*==================================================================================*/

{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE nom_cuenta  LIKE Cuenta_bancaria.denominacion.

DEFINE VARIABLE hubo_cheque    AS LOGICAL.

DEFINE VARIABLE fecha_fr  AS CHARACTER.
DEFINE VARIABLE hora_fr   AS CHARACTER.

DEFINE VARIABLE lest      AS INTEGER.
DEFINE VARIABLE Total     AS DECIMAL.

{WGLISTAR.I}

/*==================================================================================*/
/*                              VARIABLES                                           */
/*==================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Cheques pendientes de impresión" AT 39
  "Página:" AT 101 PAGE-NUMBER FORMAT ">9" AT 108
  SKIP  
  fecha_lis   
  "Cuenta:" AT 39
  nom_cuenta
  hora_lis AT 101
  SKIP  
  "Del" AT 39
  des_ncheque
  "al" 
  has_ncheque 
  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.
 
DEFINE FRAME frm-listado
       Cheque.numero_cheque COLUMN-LABEL "Número!Cheque"
       Cheque.orden COLUMN-LABEL "Orden del!Cheque" FORMAT "X(56)"
       Cheque.fecha_salida COLUMN-LABEL "Fecha!Salida"
       Cheque.fecha_emision COLUMN-LABEL "Fecha!Emisión"
       Cheque.importe COLUMN-LABEL "Importe!Cheque"
       Total
       WITH WIDTH 132 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
  
RUN LISTAR.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/


PROCEDURE LISTAR:

  FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = que_cuenta NO-LOCK.
  nom_cuenta = Cuenta_bancaria.denominacion.

  {dirprinfile.i &LIN-PAG=72}
 
  FOR EACH  Cheque NO-LOCK OF Cuenta_bancaria
      WHERE Cheque.numero_cheque  >= des_ncheque 
        AND Cheque.numero_cheque  <= has_ncheque
      BY( Cheque.numero_cheque )
      WITH FRAME frm-listado:
      
      VIEW FRAME frm-titulo.

      Total=Total + Cheque.importe.
      DISPLAY   Cheque.numero_cheque
                Cheque.orden 
                Cheque.fecha_salida
                Cheque.fecha_emision
                Cheque.importe
                Total
              WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.
              
  END.
  
  UNDERLINE   Cheque.numero_cheque
              Cheque.orden 
              Cheque.fecha_salida
              Cheque.fecha_emision
              Cheque.importe
              Total
              WITH FRAME frm-listado STREAM-IO.  

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END.  

