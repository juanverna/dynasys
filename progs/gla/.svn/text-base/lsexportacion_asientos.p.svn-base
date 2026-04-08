/*=================================================================================*/
/*                   EXPORTA LOS ASIENTOS A UN ARCHIVO ASCII                       */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        LIKE Asn_header.fecha.
DEFINE INPUT PARAMETER has_fecha        LIKE Asn_header.fecha.
DEFINE INPUT PARAMETER que_modulo       LIKE Modulo-SIC.cdg_sigla-sic.
DEFINE INPUT PARAMETER arch_salida      AS CHARACTER.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

DEFINE VARIABLE v-cdg_obra     LIKE Obra.cdg_obra.
DEFINE VARIABLE tipo_registro  AS CHARACTER FORMAT "X(2)".

DEFINE STREAM Exportacion.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  OUTPUT STREAM Exportacion TO VALUE(arch_salida) PAGE-SIZE 0.

  FOR EACH Asn_header
      WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
        AND Asn_header.fecha >= des_fecha
        AND Asn_header.fecha <= has_fecha
        AND Asn_header.cdg_sigla-sic = que_modulo,
        EACH Asn_detalle OF Asn_header,
               FIRST Cuenta OF Asn_detalle,
               FIRST Entidad OF Asn_detalle,
               FIRST Moneda OF Asn_detalle
               BREAK BY Asn_header.cdg_empresa
                     BY Asn_header.tip_comprob
                     BY Asn_header.prf_comprob
                     BY Asn_header.nro_comprob
                     BY Asn_detalle.nro_linea:

      IF FIRST-OF(Asn_header.nro_comprob)
      THEN DO:
          tipo_registro = "HD".
          PUT STREAM Exportacion
               tipo_registro " "
               Asn_header.fecha " "
               Asn_header.tip_comprob " "
               Asn_header.prf_comprob " " 
               Asn_header.nro_comprob " "
               Asn_header.leyenda
               SKIP.
      END.

      FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.      
      v-cdg_obra = IF AVAILABLE Obra
                      THEN Obra.cdg_obra
                      ELSE "" .
      tipo_registro = "DT".      
      PUT STREAM Exportacion
          tipo_registro  " "
          Asn_detalle.nro_linea " "
          Moneda.cdg_moneda   " "
          Asn_detalle.reexpresion " "
          Cuenta.cdg_cuenta " "
          Cuenta.nombre_cta " "
          Entidad.cdg_entidad " "
          v-cdg_obra " "
          Asn_detalle.debito FORMAT "->>>>>>>>>>>9.99" " "
          Asn_detalle.credito FORMAT "->>>>>>>>>>>9.99" " "
          Asn_detalle.leyen_detalle
          SKIP.

  END.

  OUTPUT STREAM Exportacion CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END.  

