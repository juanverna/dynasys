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

DEFINE VARIABLE directorio AS CHARACTER.
DEFINE VARIABLE n-renglon  AS INTEGER.

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

  n-renglon = 0.

  FOR EACH Fac_header_impuesto WHERE Fac_header_impuesto.cdg_impuesto = Impuesto.cdg_impuesto NO-LOCK,
      FIRST Fac_header NO-LOCK OF Fac_header_impuesto
            WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
              AND Fac_header.fecha <= has_fecha
              AND Fac_header.fecha >= des_fecha
              AND NOT Fac_header.anulado,
      FIRST Tipocomprobante OF Fac_header NO-LOCK,
      FIRST Cliente NO-LOCK OF Fac_header
            BREAK BY Cliente.cdg_cliente BY Fac_header.fecha:

      n-renglon = n-renglon + 1.

      CASE Fac_header.tip_comprob:
          WHEN "FA" THEN ticom = "001".
          WHEN "FB" THEN ticom = "001".
          WHEN "FE" THEN ticom = "005".
          WHEN "DA" THEN ticom = "002".
          WHEN "DB" THEN ticom = "002".
          WHEN "DE" THEN ticom = "006".
          WHEN "CA" THEN ticom = "102".
          WHEN "CB" THEN ticom = "102".
          WHEN "CE" THEN ticom = "106".
          OTHERWISE ticom = "???".
      END CASE.

      PUT n-renglon                                                FORMAT "99999"
          ","                                                      FORMAT "X(1)"
          ticom                                                    FORMAT "999"
          ","                                                      FORMAT "X(1)"
          SUBSTRING(Fac_header.tip_comprob,2,1)                    FORMAT "X(1)" /* Letra del comprobante */
          ","                                                      FORMAT "X(1)"
          Fac_header.prf_comprob                                   FORMAT "9999"
          Fac_header.nro_comprob                                   FORMAT "99999999"
          ","                                                      FORMAT "X(1)"
          Fac_header.cuit                                          FORMAT "X(11)"
          ","                                                      FORMAT "X(1)"
          Fac_header.fecha                                         FORMAT "99/99/9999"
          ","                                                      FORMAT "X(1)"
          Fac_header_impuesto.monto_imponible * Fac_header.cambio  FORMAT "999999999.99"
          ","                                                      FORMAT "X(1)"
          Fac_header_impuesto.tasa                                 FORMAT "999.99"
          ","                                                      FORMAT "X(1)"
          Fac_header_impuesto.importe * Fac_header.cambio          FORMAT "999999999.99"
          SKIP.
            
   END.
   
   OUTPUT CLOSE.

  RUN getparametro.p (  INPUT  "DIROTPCP",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).
  
  directorio = v-observacion.



  OS-COPY VALUE(arch_salida) VALUE(directorio + "\" + "ims1" + STRING(MONTH(has_fecha),"99") + STRING(YEAR(has_fecha) - 2000,"99") + ".per").
  

   RUN veresult.w ( INPUT arch_salida,
                     INPUT 22).

END PROCEDURE.

