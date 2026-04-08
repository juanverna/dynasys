/*=================================================================================*/
/*   EMITE UN LISTADO TOTALIZADO POR CLIENTE DE LAS PERCEPCIONES DE UN PERIODO     */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_impuesto    LIKE Impuesto.cdg_impuesto. 
DEFINE INPUT PARAMETER des_fecha       AS DATE. 
DEFINE INPUT PARAMETER has_fecha       AS DATE. 
DEFINE INPUT PARAMETER gen_interface   AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE x-monto    LIKE Fac_header_impuesto.monto_imponible.
DEFINE VARIABLE x-impuesto LIKE Fac_header_impuesto.importe.
DEFINE VARIABLE t-monto    AS DECIMAL.
DEFINE VARIABLE t-impuesto AS DECIMAL.
DEFINE VARIABLE g-monto    AS DECIMAL.
DEFINE VARIABLE g-impuesto AS DECIMAL.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE tit_percepcion AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)".

DEFINE FRAME frm-titulo HEADER
    que_empresa
    "DDJJ " AT 55
    tit_percepcion
    "Página:" AT 99 PAGE-NUMBER FORMAT ">>>9" AT 109
    SKIP
    fecha_lis
    "Período" AT 55
    des_fecha " - " has_fecha
    hora_lis AT 99
    SKIP(2)
    WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM
    Cliente.cdg_cliente
    Cliente.nom_cliente
    Cliente.ing_brutos
    Cliente.cuit
    que_comprobante
    Fac_header.fecha
    x-monto
    x-impuesto
    WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
  que_empresa = Empresa.nombre.
  FIND Impuesto WHERE Impuesto.cdg_impuesto = que_impuesto.
  tit_percepcion = Impuesto.nombre.
  
  {dirprinfile.i}

  fecha_lis = STRING(TODAY,"99/99/99").
  hora_lis = STRING(TIME,"HH:MM:SS").

  FOR EACH Fac_header_impuesto WHERE Fac_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto NO-LOCK,
      FIRST Fac_header NO-LOCK OF Fac_header_impuesto
            WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
              AND Fac_header.fecha <= has_fecha
              AND Fac_header.fecha >= des_fecha
              AND NOT Fac_header.anulado,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Cliente NO-LOCK OF Fac_header
            BREAK BY Cliente.cdg_cliente BY Fac_header.fecha:

      VIEW FRAME frm-titulo.

      que_comprobante = Fac_header.tip_comprob + " " +
                        STRING(Fac_header.prf_comprob,"9999") + " " + 
                        STRING(Fac_header.nro_comprob,"99999999").
      IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = ( -1 ).
      x-monto   = Fac_header_impuesto.monto_imponible * signo.
      x-impuesto = Fac_header_impuesto.importe * signo.


      DISPLAY   Cliente.cdg_cliente
                Cliente.nom_cliente
                Cliente.ing_brutos
                Cliente.cuit
                que_comprobante
                Fac_header.fecha
                Fac_header_impuesto.monto_imponible
                Fac_header_impuesto.importe
                WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.

      t-monto = t-monto + x-monto.
      t-impuesto = t-impuesto + x-impuesto.
     
      IF LAST-OF(Cliente.cdg_cliente)
      THEN DO:
          UNDERLINE x-monto
                    x-impuesto
                    WITH FRAME frm-listado.
          DISPLAY   t-monto @ x-monto
                    t-impuesto @ x-impuesto
                    WITH FRAME frm-listado. 
          g-monto = g-monto + t-monto.
          g-impuesto = g-impuesto + t-impuesto.

          t-monto = 0.
          t-impuesto = 0.
      END.
            
   END.

   UNDERLINE x-monto
             x-impuesto
             WITH FRAME frm-listado.
   DISPLAY   g-monto @ x-monto
             g-impuesto @ x-impuesto
             WITH FRAME frm-listado. 
   
   OUTPUT CLOSE.

   RUN veresult.w ( INPUT arch_salida,
                     INPUT 22).

END PROCEDURE.

