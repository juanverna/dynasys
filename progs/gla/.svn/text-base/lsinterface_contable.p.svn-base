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

DEFINE VARIABLE cant_asientos  AS INTEGER.

DEFINE STREAM Exportacion.

{parlocales.i}

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  cant_asientos = 0.

  OUTPUT STREAM Exportacion TO VALUE(arch_salida) PAGE-SIZE 0.

  FOR EACH Asn_header
      WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
        AND Asn_header.fecha >= des_fecha
        AND Asn_header.fecha <= has_fecha
        AND Asn_header.cdg_sigla-sic = que_modulo
              BREAK BY Asn_header.cdg_empresa
                    BY Asn_header.tip_comprob
                    BY Asn_header.prf_comprob
                    BY Asn_header.nro_comprob:

      cant_asientos = cant_asientos + 1.

      RUN registro_encabezado.

      FOR EACH Asn_detalle OF Asn_header WHERE Asn_detalle.reexpresion,
           FIRST Cuenta OF Asn_detalle,
           FIRST Entidad OF Asn_detalle,
           FIRST Moneda OF Asn_detalle WHERE Moneda.es_local
           BREAK BY Asn_header.cdg_empresa
                 BY Asn_header.tip_comprob
                 BY Asn_header.prf_comprob
                 BY Asn_header.nro_comprob
                 BY Asn_detalle.nro_linea:


          RUN registro_detalle.
      END.

      RUN registro_separador.

  END.

  RUN registro_control.

  OUTPUT STREAM Exportacion CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.  

PROCEDURE registro_encabezado:

    tipo_registro = "1".      
    EXPORT STREAM Exportacion
        0 "" 11
        Asn_header.fecha
        Asn_header.fecha
        Asn_header.leyenda
        SKIP.


END PROCEDURE.

PROCEDURE registro_detalle:

    DEFINE VARIABLE v-signo AS CHARACTER FORMAT "X(1)".
    DEFINE VARIABLE v-importe LIKE Asn_detalle.debito FORMAT ">>>>>>>>>>>9.99".

    FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.      
    v-cdg_obra = IF AVAILABLE Obra
                    THEN Obra.cdg_obra
                    ELSE "" .
    
    IF Asn_detalle.debito <> 0 
    THEN DO:
        v-signo = "D".
        v-importe = Asn_detalle.debito.
    END.
    ELSE DO:
        v-signo = "H".
        v-importe = Asn_detalle.credito.
    END.

    EXPORT STREAM Exportacion
        Cuenta.cdg_cuenta
        v-signo
        v-importe
        Asn_detalle.leyen_detalle
        1 /* Cotizacion */
        v-importe
        Entidad.cdg_entidad
        0 /* Tipo de gasto */
        
        SKIP.

END PROCEDURE.

PROCEDURE registro_control:

    RUN getparametro.p (  INPUT  "PARAM" + que_modulo,
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).

    EXPORT STREAM Exportacion
        cant_asientos
        TODAY
        v-valor_n
        v-valor_c
        0.

END PROCEDURE.

PROCEDURE registro_separador:

    EXPORT STREAM Exportacion "#".
    EXPORT STREAM Exportacion "#".

END PROCEDURE.
