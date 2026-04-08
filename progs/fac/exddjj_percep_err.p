/*=================================================================================*/
/*       GENERA LA INTERFACE DE PERCEPCIONES PARA LA PROVINCIA DE ENTRE RIOS      */
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

DEFINE VARIABLE ticom       AS CHARACTER.
DEFINE VARIABLE archivo     AS CHARACTER.
DEFINE VARIABLE t-percibido AS DECIMAL.

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
  
  RUN getparametro.p (  INPUT  "DIROTPCP",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).
  archivo = v-observacion + "\" + "ime1" + STRING(MONTH(has_fecha),"99") + STRING(YEAR(has_fecha) - 2000,"99") + ".txt".

  OUTPUT TO VALUE(archivo) PAGE-SIZE 0.

  PUT STRING(MONTH(has_fecha),"99") + "-" + STRING(YEAR(has_fecha),"9999") FORMAT "X(7)" ";" 
      "000" ";"
      Empresa.cuit ";" 
      "04" ";"
      "prn"
      SKIP.

  t-percibido = 0.
  FOR EACH Fac_header_impuesto WHERE Fac_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto NO-LOCK,
      FIRST Fac_header NO-LOCK OF Fac_header_impuesto
            WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
              AND Fac_header.fecha <= has_fecha
              AND Fac_header.fecha >= des_fecha
              AND NOT Fac_header.anulado,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Cliente NO-LOCK OF Fac_header
            BREAK BY Cliente.cdg_cliente BY Fac_header.fecha:

      t-percibido = t-percibido + Fac_header_impuesto.importe.

      IF LAST-OF(Cliente.cdg_cliente)
      THEN DO:
          PUT 
              SUBSTRING(Cliente.cuit,1,2) + "-" +  
              SUBSTRING(Cliente.cuit,3,8) + "-" +
              SUBSTRING(Cliente.cuit,9,9) FORMAT "X(13)" ";"
              Cliente.nom_cliente FORMAT "X(38)" ";"
              t-percibido FORMAT "9999999999.99" 
              SKIP.
          t-percibido = 0.
      END.
            
   END.
   
   OUTPUT CLOSE.

   RUN veresult.w ( INPUT archivo,
                    INPUT 22).

END PROCEDURE.

