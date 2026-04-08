/*=================================================================================*/
/*           LISTADO DE DERECHOS PENDIENTES POR FECHA DE VENCIMIENTO               */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas  AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER que_moneda        LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER des_fecha         AS DATE.
DEFINE INPUT PARAMETER has_fecha         AS DATE.
DEFINE INPUT PARAMETER tipo_opcion       AS INTEGER.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{WGLISTAR.I}
{dfvarimp.i}
{nommeses.i}

DEFINE VARIABLE total_fecha           AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_aplicado        AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE total_general         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE sin_aplicar           AS CHARACTER INITIAL "---- SIN APLICAR ----".
DEFINE VARIABLE tit_periodo           AS CHARACTER FORMAT "X(60)".
DEFINE VARIABLE que_cuenta            AS CHARACTER FORMAT "X(11)" COLUMN-LABEL "NRO. CUENTA".
DEFINE VARIABLE j                     AS INTEGER.
DEFINE VARIABLE tit_opcion            AS CHARACTER  NO-UNDO.

DEFINE VARIABLE x-importe             LIKE Rec_header.imp_total.

DEFINE TEMP-TABLE Resumen
  FIELD  que_recibo        AS CHARACTER FORMAT "X(13)"   COLUMN-LABEL "Número de Recibo" 
  FIELD  fecha             AS DATE                       COLUMN-LABEL "Fecha Rec"
  FIELD  cdg_cliente       LIKE CLiente.cdg_cliente      COLUMN-LABEL "Nro.Cuenta"
  FIELD  num_sucursal      LIKE Domicilio.nro_domicilio  COLUMN-LABEL "Sucursal"
  FIELD  nom_cliente       LIKE Cliente.nom_cliente      COLUMN-LABEL "Razón Social"
  FIELD  cuit              LIKE Cliente.cuit             COLUMN-LABEL "C.U.I.T."
  FIELD  que_cancelado     AS CHARACTER FORMAT "X(16)"   COLUMN-LABEL "Aplicado a"
  FIELD  importe           LIKE Rec_header.imp_total     COLUMN-LABEL "Importe"
  FIELD  total_recibo      LIKE Rec_header.imp_total     COLUMN-LABEL "Total Recibo".

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "SUBDIARIO DE COBRANZAS MENSUAL EN CUENTAS CORRIENTES" AT 53
  "HOJA NRO." AT 122 PAGE-NUMBER FORMAT ">>9" AT 132
  SKIP
  fecha_lis
  tit_periodo AT 55
  tit_opcion  AT 55 FORMAT "X(100)"
  SKIP(1)
  WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-mov
  Resumen.que_recibo        COLUMN-LABEL " NRO. RECIBO! " 
  Resumen.fecha             COLUMN-LABEL "FECHA REC.! "
  que_cuenta                COLUMN-LABEL "NRO. CUENTA! "
  Resumen.nom_cliente       COLUMN-LABEL "          R A Z O N  S O C I A L! "
  Resumen.cuit              COLUMN-LABEL "C. U. I. T.! "
  Resumen.que_cancelado     COLUMN-LABEL "APLICADO A! "  FORMAT "X(20)"
  Resumen.importe           COLUMN-LABEL "I M P O R T E! "
  WITH WIDTH 150 DOWN CENTERED FRAME frm-listado-mov USE-TEXT STREAM-IO NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.
     
  {findempresa.i}
  que_empresa = CAPS(Empresa.nombre).

  CASE tipo_opcion:
      WHEN 1 THEN
          ASSIGN tit_opcion = "Solo Movimientos que son de Cuenta Corriente.".
      WHEN 2 THEN
          ASSIGN tit_opcion = "Solo Movimientos que NO son de Cuenta Corriente.".
      WHEN 3 THEN
          ASSIGN tit_opcion = "              Ambos Movimientos.".
  END CASE.
  tit_periodo = "Corresponde al mes de ".
  DO j = 1 TO LENGTH(nom_mes [ MONTH(has_fecha) ]):
      tit_periodo = tit_periodo + SUBSTRING(nom_mes [ MONTH(has_fecha) ],j,1) + " ".
  END.
  tit_periodo = CAPS(tit_periodo + " de " + STRING(YEAR(has_fecha),"9999")).

  {dirprinfile.i}

  RUN LISTAR.
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END PROCEDURE.

PROCEDURE LISTAR:
DEFINE VARIABLE sin_aplicacion AS LOGICAL    NO-UNDO.
DEFINE VARIABLE grabo  AS LOGICAL    NO-UNDO.

  total_aplicado  = 0.
  total_fecha   = 0.
  total_general = 0.

  
  FOR EACH Rec_header NO-LOCK
      WHERE CAN-DO(v-lista_empresas,Rec_header.cdg_empresa)
      AND Rec_header.fecha >= des_fecha
      AND Rec_header.fecha  <= has_fecha
      AND NOT Rec_header.anulado,
              FIRST Cliente OF Rec_header NO-LOCK
              WHERE Cliente.cdg_cliente >= des_codigo AND Cliente.cdg_cliente <= has_codigo,
              FIRST Moneda OF Rec_header 
              BY Rec_header.cdg_empresa
              BY Rec_header.fecha 
              BY Rec_header.tip_comprob
              BY Rec_header.prf_comprob
              BY Rec_header.nro_comprob :

      grabo = NO.
      FIND FIRST Tipocomprobante OF Rec_header NO-LOCK NO-ERROR.
      CASE tipo_opcion:
          WHEN 1 THEN
              IF Tipocomprobante.afecta_cc = YES AND
                 Cliente.tiene_ctacte      = YES THEN
                 grabo = YES.
          WHEN 2 THEN
              IF Tipocomprobante.afecta_cc = NO  OR
                 Cliente.tiene_ctacte      = NO THEN
                 grabo = YES.
          WHEN 3 THEN
           grabo  = YES.
      END CASE.

      IF grabo = YES THEN
      DO:                    
        
        sin_aplicacion = YES.
        FOR EACH Aplicacion_pagos OF Rec_header :
            CREATE Resumen.
            ASSIGN Resumen.que_recibo    =  /*Rec_header.tip_comprob + " " + */
                                            STRING(Rec_header.prf_comprob,"9999") + "-" + 
                                            STRING(Rec_header.nro_comprob,"99999999")
                   Resumen.fecha         = Rec_header.fecha
                   Resumen.total_recibo  = Rec_header.imp_pesos + Rec_header.imp_difcambio /*Rec_header.imp_total*/
                   Resumen.cdg_cliente   = Cliente.cdg_cliente
                   Resumen.nom_cliente   = Cliente.nom_cliente
                   Resumen.cuit          = Cliente.cuit
                   Resumen.que_cancelado = Aplicacion_pagos.tip_cancela + " " +
                                      STRING(Aplicacion_pagos.prf_cancela,"9999") + " " + 
                                      STRING(Aplicacion_pagos.nro_cancela,"99999999") + " " + 
                                      STRING(Aplicacion_pagos.nro_vencimiento,"999").

             FIND Fac_header 
                 WHERE Fac_header.cdg_empresa = Rec_header.cdg_empresa
                   AND Fac_header.tip_comprob = Aplicacion_pagos.tip_cancela
                   AND Fac_header.prf_comprob = Aplicacion_pagos.prf_cancela
                   AND Fac_header.nro_comprob = Aplicacion_pagos.nro_cancela
                       NO-LOCK.
             RUN reexpresar_moneda_local.p ( INPUT Fac_header.nro_moneda,
                                             INPUT Fac_header.fecha,
                                             INPUT Aplicacion_pagos.importe,
                                             OUTPUT x-importe).

             Resumen.importe = x-importe.
             Resumen.num_sucursal = Fac_header.nro_domicilio.
             sin_aplicacion = NO.
        END.
        IF sin_aplicacion THEN
        DO:                           
            CREATE Resumen.
            ASSIGN Resumen.que_recibo    =  /*Rec_header.tip_comprob + " " + */
                                            STRING(Rec_header.prf_comprob,"9999") + "-" + 
                                            STRING(Rec_header.nro_comprob,"99999999")
                   Resumen.fecha         = Rec_header.fecha
                   Resumen.total_recibo  = Rec_header.imp_pesos + Rec_header.imp_difcambio /*Rec_header.imp_total*/
                   Resumen.cdg_cliente   = Cliente.cdg_cliente
                   Resumen.nom_cliente   = Cliente.nom_cliente
                   Resumen.cuit          = Cliente.cuit    
                   Resumen.que_cancelado = sin_aplicar.
             Resumen.importe = Rec_header.imp_pesos + Rec_header.imp_difcambio .
        END.
      END.
  END.

  FOR EACH Resumen
      BREAK BY Resumen.fecha 
            BY Resumen.que_recibo:
         
        VIEW FRAME frm-titulo.

        total_aplicado = total_aplicado + Resumen.importe.
        que_cuenta = Resumen.cdg_cliente + "-" + STRING(Resumen.num_sucursal,"9999").

        DISPLAY 
            Resumen.fecha          WHEN FIRST-OF(Resumen.fecha)
            Resumen.que_recibo     WHEN FIRST-OF(Resumen.que_recibo)
            que_cuenta             WHEN FIRST-OF(Resumen.que_recibo)
            Resumen.nom_cliente    WHEN FIRST-OF(Resumen.que_recibo)
            Resumen.cuit           WHEN FIRST-OF(Resumen.que_recibo)
            Resumen.que_cancelado
            Resumen.importe
            WITH FRAME frm-listado-mov.
        DOWN WITH FRAME frm-listado-mov.

        IF LAST-OF(Resumen.que_recibo)
        THEN DO:
            IF total_aplicado <> Resumen.total_recibo
            THEN DO:
                DISPLAY sin_aplicar @ Resumen.que_cancelado
                        Resumen.total_recibo - total_aplicado @ Resumen.importe
                        WITH FRAME frm-listado-mov.
                DOWN WITH FRAME frm-listado-mov.
                total_aplicado = Resumen.total_recibo.
                 
            END.

            UNDERLINE 
                Resumen.importe
                WITH FRAME frm-listado-mov.
            DISPLAY 
                "            TOTAL RECIBO" @ Resumen.nom_cliente
                total_aplicado @ Resumen.importe
                WITH FRAME frm-listado-mov.
            DOWN 2 WITH FRAME frm-listado-mov.
            total_fecha = total_fecha + total_aplicado.
            total_aplicado = 0.
        END.

        IF LAST-OF(Resumen.fecha)
        THEN DO:
            UNDERLINE 
                Resumen.importe
                WITH FRAME frm-listado-mov.
            DISPLAY 
                "      TOTAL DEL DIA" @ Resumen.nom_cliente
                total_fecha @ Resumen.importe
                WITH FRAME frm-listado-mov.
            DOWN 2 WITH FRAME frm-listado-mov.
            total_general = total_general + total_fecha.
            total_fecha = 0.
        END.

  END.

  UNDERLINE 
          Resumen.importe
          WITH FRAME frm-listado-mov.
  DISPLAY "   TOTAL DEL MES" @ Resumen.nom_cliente
          total_general @ Resumen.importe
          WITH FRAME frm-listado-mov.
  DOWN 2 WITH FRAME frm-listado-mov.
  
  UNDERLINE 
          Resumen.importe
          WITH FRAME frm-listado-mov.
  DISPLAY "TOTAL GENERAL" @ Resumen.nom_cliente
          total_general @ Resumen.importe
          WITH FRAME frm-listado-mov.
  DOWN WITH FRAME frm-listado-mov.

END PROCEDURE.

