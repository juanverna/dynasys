/*=================================================================================*/
/*           LISTADO DE DERECHOS PENDIENTES POR FECHA DE VENCIMIENTO               */
/*=================================================================================*/

DEFINE INPUT PARAMETER v-lista_empresas  AS CHARACTER.
DEFINE INPUT PARAMETER des_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo        LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER des_fecha         AS DATE.
DEFINE INPUT PARAMETER has_fecha         AS DATE.

/*=================================================================================*/
/*                                    VARIABLES                                    */
/*=================================================================================*/

{dfvarimp.i}
{parlocales.i}

DEFINE VARIABLE v-cdg_cliente          LIKE Cliente.cdg_cliente.
DEFINE VARIABLE v-nom_cliente          LIKE Cliente.nom_cliente.
DEFINE VARIABLE que_cancelado          AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE que_recibo             AS CHARACTER FORMAT "X(16)".
DEFINE VARIABLE v-total_caja           AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-total_recibo         AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-total_difcambio      AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-total_aplicado       AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE por_cod                AS INTEGER INITIAL 1.
DEFINE VARIABLE por_nom                AS INTEGER INITIAL 0.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE primera_fecha          AS LOGICAL.
DEFINE VARIABLE primer_recibo          AS LOGICAL.
DEFINE VARIABLE ant_fecha              LIKE Rec_header.fecha.
DEFINE VARIABLE ant_comprob            LIKE que_recibo.
DEFINE VARIABLE que_sector             LIKE Area.cdg_area.

DEFINE BUFFER Moneda_detalle FOR Moneda.
DEFINE BUFFER Moneda_caja    FOR Moneda.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

DEFINE FRAME frm-titulo HEADER
    que_empresa 
    "Cancelación de cuentas corrientes" AT 53
    "Página:" AT 152 PAGE-NUMBER FORMAT ">>9" AT 160
    SKIP
    fecha_lis
    "del" AT 53
    des_fecha
    "al"
    has_fecha
    hora_lis AT 152
    SKIP
    v-cdg_cliente  AT 53
    v-nom_cliente 
    SKIP(1)
    WITH WIDTH 200 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
    Rec_header.fecha               COLUMN-LABEL "Fecha!Emisión"
    que_recibo                     COLUMN-LABEL "Identificación!del Recibo" 
    que_cancelado                  COLUMN-LABEL "Comprobante!Cancelado"  FORMAT "X(20)"
    Rec_detalle.importe            COLUMN-LABEL "Importe!Cancelado" FORMAT "->,>>>,>>>,>>9.99"
    Moneda_detalle.abrevia         COLUMN-LABEL "Moneda!Comprb"     FORMAT " X(5)"
    Rec_detalle.cambio             COLUMN-LABEL "Cambio!Comprobte"  FORMAT ">>>>9.9999"
    Rec_detalle.new_cambio         COLUMN-LABEL "Cambio!Recibo"     FORMAT ">>>>9.9999"
    Rec_detalle.imp_pesos          COLUMN-LABEL "Equivale!Pesos"    FORMAT "->,>>>,>>>,>>9.99"
    Rec_detalle.difcambio          COLUMN-LABEL "Diferencia!Cambio" FORMAT "->,>>>,>>>,>>9.99" 
    Rubro.abrevia                  COLUMN-LABEL "Medio!Pago"        FORMAT "X(5)"
    Moneda_caja.abrevia            COLUMN-LABEL "Moneda!Pago"       FORMAT " X(5)"
    Caj_detalle.importe            COLUMN-LABEL "Importe!Percibido" FORMAT "->,>>>,>>>,>>9.99"
    WITH WIDTH 350 DOWN CENTERED FRAME frm-listado USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR_TODO.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  {findsector.i}
  que_sector = Area.cdg_area.

  {dirprinfile.i}

  RUN LISTAR.
  OUTPUT CLOSE.
  RUN veresult.w ( INPUT arch_salida, INPUT 22 ).

END PROCEDURE.

PROCEDURE LISTAR:

  ant_comprob = ?.
  ant_fecha = ?.
  primera_fecha = YES.
  primer_recibo = YES.
  v-total_recibo = 0.
  v-total_aplicado = 0.

  FOR EACH Cliente 
      WHERE Cliente.cdg_cliente >= des_codigo 
        AND Cliente.cdg_cliente <= has_codigo
        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK, 
      EACH Rec_header OF Cliente
            WHERE CAN-DO(v-lista_empresas,Rec_header.cdg_empresa)
              AND Rec_header.fecha >= des_fecha
              AND Rec_header.fecha  <= has_fecha
              AND Rec_header.tip_comprob BEGINS "R"
              AND CAN-DO (Usuario.lista_empresas,Rec_header.cdg_empresa)
              AND NOT Rec_header.anulado NO-LOCK
                 BREAK BY Cliente.cdg_cliente
                       BY Rec_header.cdg_empresa
                       BY Rec_header.fecha 
                       BY Rec_header.tip_comprob
                       BY Rec_header.prf_comprob
                       BY Rec_header.nro_comprob: 

      VIEW FRAME frm-titulo.
  
      IF FIRST-OF(Cliente.cdg_cliente)
      THEN DO:
          ASSIGN v-cdg_cliente = Cliente.cdg_cliente     
                 v-nom_cliente = Cliente.nom_cliente.     
      END.

      que_recibo = Rec_header.tip_comprob + " " + 
                   STRING(Rec_header.prf_comprob,"9999") + " " + 
                   STRING(Rec_header.nro_comprob,"99999999").                               
             
      DISPLAY Rec_header.fecha          
              que_recibo                
              WITH FRAME frm-listado.

      ASSIGN v-total_recibo    = 0
             v-total_caja      = 0
             v-total_difcambio = 0.

      OPEN QUERY q-detalle
            FOR EACH Rec_detalle OF Rec_header NO-LOCK, 
                FIRST Moneda_detalle OF Rec_detalle NO-LOCK
                      BY Rec_detalle.es_difcambio. /* BY Hace que la dif. de cambio salga última */
      GET FIRST q-detalle.

      OPEN QUERY q-valores
            FOR EACH Caj_detalle 
                WHERE Caj_detalle.nro_transaccion = Rec_header.nro_transaccion NO-LOCK,
            FIRST Rubro OF Caj_detalle NO-LOCK, FIRST Moneda_caja OF Rubro NO-LOCK.
      GET FIRST q-valores.

      DO WHILE AVAILABLE Rec_detalle OR AVAILABLE Caj_detalle:
            
          IF AVAILABLE Rec_detalle
          THEN DO:
              que_cancelado =  Rec_detalle.tip_cancela + " " +
                               STRING(Rec_detalle.prf_cancela,"9999") + " " + 
                               STRING(Rec_detalle.nro_cancela,"99999999") + " " + 
                               STRING(Rec_detalle.nro_vencimiento,"999").                               
              ASSIGN v-total_recibo    = v-total_recibo + Rec_detalle.imp_pesos.
              IF NOT Rec_detalle.es_difcambio
                  THEN v-total_difcambio = v-total_difcambio + Rec_detalle.difcambio.  
              DISPLAY que_cancelado
                      Rec_detalle.importe   WHEN NOT Rec_detalle.es_difcambio
                      Rec_detalle.imp_pesos WHEN NOT Rec_detalle.es_difcambio      
                      Rec_detalle.difcambio /*WHEN Rec_detalle.es_difcambio*/
                      Moneda_detalle.abrevia 
                      WITH FRAME frm-listado.
              IF Rec_detalle.clausula_dolar
              THEN DO:
                  DISPLAY Rec_detalle.cambio_dolar     @ Rec_detalle.cambio    
                          Rec_detalle.new_cambio_dolar @ Rec_detalle.new_cambio
                          WITH FRAME frm-listado.
              END.
              ELSE DO:
                  IF NOT Rec_detalle.es_difcambio 
                      THEN DISPLAY Rec_detalle.cambio  
                                   Rec_detalle.new_cambio 
                                   WITH FRAME frm-listado.
              END.
          END.

          IF AVAILABLE Caj_detalle
          THEN DO:

              DISPLAY Rubro.abrevia
                      Caj_detalle.importe
                      Moneda_caja.abrevia
                      WITH FRAME frm-listado.
              v-total_caja = v-total_caja + Caj_detalle.importe.

          END.

          DOWN WITH FRAME frm-listado.

          GET NEXT q-detalle.
          GET NEXT q-valores.

      END.
    
      UNDERLINE 
          Rec_detalle.imp_pesos          
          Rec_detalle.difcambio
          Caj_detalle.importe            
          Rubro.abrevia
          Moneda_caja.abrevia
          WITH FRAME frm-listado.

      DOWN WITH FRAME frm-listado.
      
      DISPLAY v-total_recibo     @ Rec_detalle.imp_pesos
              v-total_difcambio  @ Rec_detalle.difcambio
              v-total_caja       @ Caj_detalle.importe  
            WITH FRAME frm-listado.
      DOWN 2 WITH FRAME frm-listado.

      IF LAST-OF(Cliente.cdg_cliente)
      THEN DO:
          v-total_aplicado = 0.
          que_recibo = "Pendiente".
          FOR EACH Cta_cte OF Cliente 
              WHERE CAN-DO(v-lista_empresas,Cta_cte.cdg_empresa)
                AND Cta_cte.fecha_emision >= des_fecha
                AND Cta_cte.fecha_emision <= has_fecha
                AND CAN-DO (Usuario.lista_empresas,Cta_cte.cdg_empresa) 
                AND Cta_cte.debito <> Cta_cte.credito NO-LOCK,
                    FIRST Moneda_detalle OF Cta_cte NO-LOCK:

              que_cancelado =  Cta_cte.tip_comprob + " " +
                               STRING(Cta_cte.prf_comprob,"9999") + " " + 
                               STRING(Cta_cte.nro_comprob,"99999999") + " " + 
                               STRING(Cta_cte.nro_vencimiento,"999").                               
              DISPLAY que_recibo
                      que_cancelado
                      (Cta_cte.debito - Cta_cte.credito) @ Rec_detalle.importe   
                      (Cta_cte.debito - Cta_cte.credito) * Cta_cte.cambio @ Rec_detalle.imp_pesos 
                      Cta_cte.cambio @ Rec_detalle.cambio
                      Moneda_detalle.abrevia 
                      WITH FRAME frm-listado.
              DOWN WITH FRAME frm-listado.

              v-total_aplicado = v-total_aplicado + (Cta_cte.debito - Cta_cte.credito) * Cta_cte.cambio.
              que_recibo = "".

          END.

          UNDERLINE Rec_detalle.imp_pesos 
                  WITH FRAME frm-listado.
          DISPLAY v-total_aplicado @ Rec_detalle.imp_pesos 
                  WITH FRAME frm-listado.

          DOWN WITH FRAME frm-listado.

          IF NOT LAST(Cliente.cdg_cliente) 
              THEN PAGE.
      END.

  END.

END PROCEDURE.

