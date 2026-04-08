/*=================================================================================*/
/*       GENERA LA INTERFACE DE PERCEPCIONES PARA LA PROVINCIA DE BUENOS AIRES     */
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

DEFINE VARIABLE ticom      AS CHARACTER.
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

      PUT "30547242331"           FORMAT "X(11)" /* Cuit de la empresa */
          "07"                    FORMAT "X(2)" /* Codigo del regimen */
          DAY(Fac_header.fecha)   FORMAT "99"
          MONTH(Fac_header.fecha) FORMAT "99"          
          YEAR(Fac_header.fecha)  FORMAT "9999"
          Fac_header.prf_comprob  FORMAT "9999"
          Fac_header.nro_comprob  FORMAT "99999999"
          "VENTAS     "                FORMAT "X(11)"
          Fac_header_impuesto.monto_imponible * Fac_header.cambio * 100 FORMAT "99999999999"
          Fac_header_impuesto.importe * Fac_header.cambio * 100 FORMAT "9999999999"
          Fac_header.cuit         FORMAT "X(11)"
          SUBSTRING(Fac_header.tip_comprob,2,1)  FORMAT "X(1)" /* Letra del comprobante */
          SUBSTRING(Fac_header.tip_comprob,1,1)  FORMAT "X(1)" /* Tipo del comprobante  */
          "                                                      " FORMAT "X(54)"
          SKIP.
            
   END.
   
   OUTPUT CLOSE.

   RUN getparametro.p (  INPUT  "DIROTPCP",
                      OUTPUT v-valor_c,
                      OUTPUT v-valor_d,
                      OUTPUT v-valor_l,
                      OUTPUT v-valor_n,
                      OUTPUT v-observacion ).

   OS-COPY VALUE(arch_salida) VALUE(v-observacion + "\" + "imb1" + STRING(MONTH(has_fecha),"99") + STRING(YEAR(has_fecha) - 2000,"99") + ".per").

   RUN veresult.w ( INPUT arch_salida,
                    INPUT 22).

END PROCEDURE.

