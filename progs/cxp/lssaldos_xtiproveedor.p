/*=================================================================================*/
/*             LISTADO DE SALDOS ANALITICOS CON O SIN MOVIMIENTOS                  */
/*=================================================================================*/

DEFINE INPUT PARAMETER que_moneda      LIKE Moneda.descripcion. 
DEFINE INPUT PARAMETER incluir_cero    AS LOGICAL.

/*=================================================================================*/
/*                                  VARIABLES                                      */
/*=================================================================================*/

{VRSHARED.I}
{dfvarimp.i}
{WGLISTAR.I}

DEFINE VARIABLE saldo                  AS DECIMAL FORMAT "->,>>>,>>9.99" LABEL "S a l d o".
DEFINE VARIABLE total_tipo             AS DECIMAL FORMAT "->,>>>,>>9.99".
DEFINE VARIABLE total_general          AS DECIMAL FORMAT "->,>>>,>>9.99".

DEFINE VARIABLE det_titulo             AS CHARACTER FORMAT "X(45)".
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.

DEFINE QUERY qry_proveedor FOR Proveedor.

/*=================================================================================*/
/*                                  FRAMES                                         */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Saldos totales por Tipo de Proveedor" AT 40
  "Página:" AT 84 PAGE-NUMBER FORMAT ">>9" AT 92
  SKIP
  fecha_lis
  det_titulo AT 40 NO-LABEL
  hora_lis AT 84
  SKIP
  "Importes en" AT 40
  desc_moneda NO-LABEL
  SKIP(1)
  WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Proveedor.cdg_proveedor
  SPACE(8)
  Proveedor.nombre
  SPACE(27)
  saldo 
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}

que_empresa = Empresa.nombre.
FIND Moneda WHERE Moneda.cdg_moneda = que_moneda NO-LOCK.

RUN LISTAR.

/*=================================================================================*/
/*                      P R O C E D I M I E N T O S                                */
/*=================================================================================*/

PROCEDURE LISTAR:

  desc_moneda = Moneda.descripcion.

  {dirprinfile.i}

  det_titulo = "Analítico".

  total_general = 0.
  total_tipo = 0.
  FOR EACH Proveedor BREAK BY Proveedor.cdg_tiprove BY Proveedor.cdg_proveedor:

     VIEW FRAME frm-titulo.

     RUN procesar_proveedor.

     IF incluir_cero OR saldo <> 0
     THEN DO:

          DISPLAY Proveedor.cdg_proveedor
                  Proveedor.nombre
                  saldo
                  WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.

     END.

     IF LAST-OF(Proveedor.cdg_proveedor)
     THEN DO:
         
          FIND Tipo_proveedor OF Proveedor NO-LOCK.
          UNDERLINE
                  Proveedor.cdg_proveedor
                  Proveedor.nombre
                  saldo
                  WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.
         
          DISPLAY "Total " + Tipo_proveedor.dsc_tiprove @ Proveedor.nombre
                  total_tipo @ saldo
                  WITH FRAME frm-listado.
          DOWN 2 WITH FRAME frm-listado.
          total_general = total_general + total_tipo.
          total_tipo = 0.

     END.

  END.

  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre
            saldo
            WITH FRAME frm-listado.
  DISPLAY "Total General" @ Proveedor.nombre
         total_general @ saldo
         WITH FRAME frm-listado.
  DOWN WITH FRAME frm-listado.

  UNDERLINE Proveedor.cdg_proveedor
            Proveedor.nombre
            saldo
            WITH FRAME frm-listado.

  DISPLAY " " @ Proveedor.cdg_proveedor 
          WITH FRAME frm-listado.
  
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END PROCEDURE.  

PROCEDURE procesar_proveedor:

    saldo = 0.
    FOR EACH Cta_cte_prv OF Proveedor 
        WHERE Cta_cte_prv.nro_moneda = Moneda.nro_moneda
          AND Cta_cte_prv.credito <> Cta_cte_prv.debito
          AND Cta_cte_prv.cdg_empresa = Empresa.cdg_empresa:
  
          saldo = saldo + Cta_cte_prv.credito - Cta_cte_prv.debito.
  
    END.

END PROCEDURE.

