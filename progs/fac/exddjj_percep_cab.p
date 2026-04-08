/*=================================================================================*/
/*              GENERA LA INTERFACE DE PERCEPCIONES PARA LA C.A.B.A.               */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_impuesto    LIKE Impuesto.cdg_impuesto. 
DEFINE INPUT PARAMETER des_fecha       AS DATE. 
DEFINE INPUT PARAMETER has_fecha       AS DATE. 
DEFINE INPUT PARAMETER gen_interface   AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

/*{VRSHARED.I}
{VPERSINM.I}*/
{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE signo      AS CHARACTER.
DEFINE VARIABLE archivo AS CHARACTER.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
  {findempresa.i}
  que_empresa = Empresa.nombre.
  FIND Impuesto WHERE Impuesto.cdg_impuesto = que_impuesto.
  
  {dirprinfile.i &LIN-PAG=0}

  FOR EACH Fac_header_impuesto WHERE Fac_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto NO-LOCK,
      FIRST Fac_header NO-LOCK OF Fac_header_impuesto
            WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
              AND Fac_header.fecha <= has_fecha
              AND Fac_header.fecha >= des_fecha
              AND NOT Fac_header.anulado,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Cliente NO-LOCK OF Fac_header
            BREAK BY Cliente.cdg_cliente BY Fac_header.fecha:

      IF Tipocomprobante.debita
          THEN signo = "+".
          ELSE signo = "-".


      PUT "015843"                FORMAT "X(6)" /* Nro. agente de precepcion */
          YEAR(Fac_header.fecha)  FORMAT "9999"
          MONTH(Fac_header.fecha) FORMAT "99"
          DAY(Fac_header.fecha)   FORMAT "99"
          "P"                     FORMAT "X(1)" /* Regimen de la presentacion */
          "003"                   FORMAT "X(3)" /* Codigo del regimen */
          "            "          FORMAT "X(12)" /* Nro de ingresos brutos, no se informa */
          Fac_header.cuit         FORMAT "X(11)"
          signo                   FORMAT "X(1)"
          Fac_header_impuesto.importe * Fac_header.cambio FORMAT "999999999999.99"
          SKIP.
            
   END.
   
   OUTPUT CLOSE.

   RUN getparametro.p (  INPUT  "DIROTPCP",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).
  
OS-COPY VALUE(arch_salida) VALUE(v-observacion + "\" + "imc1" + STRING(MONTH(has_fecha),"99") + STRING(YEAR(has_fecha) - 2000,"99") + ".per").




   RUN veresult.w ( INPUT arch_salida,
                     INPUT 22).

END PROCEDURE.

