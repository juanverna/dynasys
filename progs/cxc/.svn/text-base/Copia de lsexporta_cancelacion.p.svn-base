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
DEFINE VARIABLE c_orden                AS INTEGER INITIAL 0.
DEFINE VARIABLE ntcols                 AS INTEGER INITIAL 32.
DEFINE VARIABLE ntcols_excel           AS INTEGER INITIAL 0.
DEFINE VARIABLE ncol                   AS INTEGER.
DEFINE VARIABLE col0_impor             AS INTEGER.
DEFINE VARIABLE c-fila                 AS INTEGER INITIAL 0.
DEFINE VARIABLE c-fila_medios          AS INTEGER INITIAL 0.
DEFINE VARIABLE desc_moneda            LIKE Moneda.descripcion.
DEFINE VARIABLE primera_fecha          AS LOGICAL.
DEFINE VARIABLE primer_recibo          AS LOGICAL.
DEFINE VARIABLE ant_fecha              LIKE Rec_header.fecha.
DEFINE VARIABLE ant_comprob            LIKE que_recibo.
DEFINE VARIABLE que_sector             LIKE Area.cdg_area.

DEFINE VARIABLE ipcTemplate            AS CHARACTER INITIAL "Cancelacion_pagos.xlt".

DEFINE VARIABLE chExcelApplication      AS COM-HANDLE.
DEFINE VARIABLE chWorkbook              AS COM-HANDLE.
DEFINE VARIABLE chWorksheet             AS COM-HANDLE.

DEFINE VARIABLE ppass AS CHARACTER NO-UNDO initial "".

DEFINE VARIABLE cDirctr AS CHARACTER NO-UNDO.
/*get-key-value section "Instalacion" key "Directorio" value cDirctr. */

DEFINE VARIABLE cColmn AS CHARACTER NO-UNDO.
DEFINE VARIABLE iFil   AS INTEGER NO-UNDO.

{fnexcel.i}

DEFINE STREAM Seguimiento.

DEFINE BUFFER Moneda_detalle FOR Moneda.
DEFINE BUFFER Moneda_caja    FOR Moneda.

/*=================================================================================*/
/*                                    FRAMES                                       */
/*=================================================================================*/

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

SESSION:NUMERIC-FORMAT = "AMERICAN".

RUN LISTAR_TODO.

/*RUN exportaexcel.p ( INPUT "Cancelacion_pagos.xlt" ,INPUT TABLE ttReprt ).*/

/* launch Excel so it is visible to the user */
chExcelApplication:Visible = TRUE.

SESSION:NUMERIC-FORMAT = "AMERICAN".

RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR_TODO:

  {findempresa.i}
  que_empresa = Empresa.nombre.

  {findsector.i}
  que_sector = Area.cdg_area.

  RUN getparametro_o.p ( INPUT "DIRINPLA", OUTPUT v-observacion).
  IF v-observacion <> ?
      THEN cDirctr = v-observacion.
      ELSE cDirctr = "c:\sic-temp\".

  IF SUBSTRING(cDirctr,LENGTH(cDirctr),1) <> "\"
      THEN cDirctr = cDirctr + "\".

  IF SEARCH(cDirctr + ipcTemplate) = ?
  THEN DO: 
      MESSAGE cDirctr + ipcTemplate
          VIEW-AS ALERT-BOX ERROR TITLE "Template no encontrado".
      RETURN.
  END.

  ASSIGN ant_comprob = ?
         ant_fecha = ?
         primera_fecha = YES
         primer_recibo = YES
         v-total_recibo = 0
         v-total_aplicado = 0
         c-fila = 9.

  RUN agregar_columna ( INPUT "FechaFactura",    INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Tipo",            INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "NroFactura",      INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Vencimiento",     INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Mora",            INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpPesos",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Cambiocomp",      INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Cambiorecb",      INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpDolares",      INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Emision",         INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Recibo",          INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "FechaCheque",     INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImporteCheque",   INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Efectivo",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Canje",           INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpBonos",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRetiva",       INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRetgan",       INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRetibrCAP",    INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRetibrBAS",    INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRetsus",       INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpRedondeo",     INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "TotalCobrado",    INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "TotalDifcambio",  INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "PorcDesfasaje",   INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "DBCambio",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "PorcAjuste",      INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "CRCambio",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "CambioCheque",    INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "NDebito",         INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "NCredito",        INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "ImpTotalFactura", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "SaldoFactura",    INPUT-OUTPUT ntcols_excel ).




  OUTPUT STREAM Seguimiento TO "c:\sic-temp\seguimientoxks.txt" PAGE-SIZE 0.

  /* create a new Excel Application object */
  CREATE "Excel.Application" chExcelApplication.

  /* launch Excel so it is visible to the user */
  chExcelApplication:Visible = FALSE.

  /* create a new Workbook */
  chWorkbook = chExcelApplication:Workbooks:Add(cDirctr + ipcTemplate).

  FOR EACH Cliente 
      WHERE Cliente.cdg_cliente >= des_codigo 
        AND Cliente.cdg_cliente <= has_codigo /* 
        AND LOOKUP(que_sector, Cliente.lista_sectores) <> 0 NO-LOCK */, 
      EACH Rec_header OF Cliente
            WHERE /* CAN-DO(v-lista_empresas,Rec_header.cdg_empresa)
              AND */ Rec_header.fecha >= des_fecha
              AND Rec_header.fecha  <= has_fecha
              AND Rec_header.tip_comprob BEGINS "R"
           /* AND CAN-DO (Usuario.lista_empresas,Rec_header.cdg_empresa) */
              AND NOT Rec_header.anulado NO-LOCK
                 BREAK BY Cliente.cdg_cliente
                       BY Rec_header.cdg_empresa
                       BY Rec_header.fecha 
                       BY Rec_header.tip_comprob
                       BY Rec_header.prf_comprob
                       BY Rec_header.nro_comprob: 

      IF FIRST-OF(Cliente.cdg_cliente)
      THEN DO:
          RUN insertar_hoja_cliente.
          ASSIGN primera_fecha = YES
                 primer_recibo = YES
                 v-total_recibo = 0
                 v-total_aplicado = 0
                 c-fila = 8.
      END.

      OPEN QUERY q-detalle
            FOR EACH Rec_detalle OF Rec_header NO-LOCK, 
                FIRST Moneda_detalle OF Rec_detalle NO-LOCK,
                      FIRST Cta_cte 
                            WHERE Cta_cte.cdg_empresa     = Rec_header.cdg_empresa
                              AND Cta_cte.tip_comprob     = Rec_detalle.tip_cancela
                              AND Cta_cte.prf_comprob     = Rec_detalle.prf_cancela
                              AND Cta_cte.nro_comprob     = Rec_detalle.nro_cancela
                              AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                                  BY Rec_detalle.es_difcambio. /* BY Hace que si hay dif. de cambio salga última */
      GET FIRST q-detalle.
      DO WHILE AVAILABLE Rec_detalle:
            
         c-fila = c-fila + 1.

        /*RUN agregar_columna ( INPUT "FECHA", INPUT "", INPUT "FechaFactura", INPUT-OUTPUT ntcols_excel ).*/
          chWorkSheet:Range(axcol(c-fila,Nom2Num("FechaFactura"))):Value = STRING(Cta_cte.fecha_emision,"99/99/9999").
        /*RUN agregar_columna ( INPUT "TIPO", INPUT "", INPUT "Tipo", INPUT-OUTPUT ntcols_excel ).*/
          chWorkSheet:Range(axcol(c-fila,Nom2Num("Tipo"))):Value = Cta_cte.tip_comprob.
        /*RUN agregar_columna ( INPUT "N  FACT. ANTERIOR AL 31/08/05", INPUT "", INPUT "NroAnterior", INPUT-OUTPUT ntcols_excel ).*/
        /*RUN agregar_columna ( INPUT "N", INPUT "", INPUT "NroFactura", INPUT-OUTPUT ntcols_excel ).*/
          chWorkSheet:Range(axcol(c-fila,Nom2Num("NroFactura"))):Value = STRING(Cta_cte.nro_comprob,">>>>>>>>9").
        /*RUN agregar_columna ( INPUT "VTO", INPUT "", INPUT "Vencimiento", INPUT-OUTPUT ntcols_excel ).*/
          chWorkSheet:Range(axcol(c-fila,Nom2Num("Vencimiento"))):Value = STRING(Cta_cte.fecha_vencimiento,"99/99/9999").
        /*RUN agregar_columna ( INPUT "MORA", INPUT "", INPUT "Mora", INPUT-OUTPUT ntcols_excel ).*/
          chWorkSheet:Range(axcol(c-fila,Nom2Num("Mora"))):Value = STRING(Rec_header.fecha - Cta_cte.fecha_vencimiento,"->>>9").
        /*RUN agregar_columna ( INPUT "$", INPUT "", INPUT "ImpPesos", INPUT-OUTPUT ntcols_excel ).*/

        /*RUN agregar_columna ( INPUT "T.CBIO  FC", INPUT "", INPUT "Cambiocomp", INPUT-OUTPUT ntcols_excel ).*/
          IF Moneda_detalle.es_local
          THEN DO:
              IF Rec_detalle.es_difcambio
              THEN DO:
                  FIND Tipocomprobante OF Cta_cte NO-LOCK.
                  IF Tipocomprobante.debita
                      THEN chWorkSheet:Range(axcol(c-fila,Nom2Num("DBCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
                      ELSE chWorkSheet:Range(axcol(c-fila,Nom2Num("CRCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
              END.
              ELSE DO:
                  IF Rec_detalle.clausula_dolar
                  THEN DO:
                      chWorkSheet:Range(axcol(c-fila,Nom2Num("Cambiocomp"))):Value = STRING(Rec_detalle.cambio_dolar,"->>>>>>>>>9.99").
                      chWorkSheet:Range(axcol(c-fila,Nom2Num("Cambiorecb"))):Value = STRING(Rec_detalle.new_cambio_dolar,"->>>>>>>>>9.99").
                      chWorkSheet:Range(axcol(c-fila,Nom2Num("PorcAjuste"))):Value = STRING(Rec_detalle.prc_difcambio,"->>>>>>>>>9.99").
                      chWorkSheet:Range(axcol(c-fila,Nom2Num("Porcdesfasaje"))):Value = STRING(Rec_detalle.prc_mincambio,"->>>>>>>>>9.99").
                      IF Rec_detalle.difcambio > 0
                           THEN chWorkSheet:Range(axcol(c-fila,Nom2Num("DBCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
                           ELSE chWorkSheet:Range(axcol(c-fila,Nom2Num("CRCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
                  END.
                  ELSE DO:
                      chWorkSheet:Range(axcol(c-fila,Nom2Num("ImpPesos"))):Value = STRING(Rec_detalle.importe,"->>>>>>>>>9.99").
                  END.
              END.
          END.
          ELSE DO:
              chWorkSheet:Range(axcol(c-fila,Nom2Num("Cambiocomp"))):Value = STRING(Rec_detalle.cambio,"->>>>>>>>>9.99").
              chWorkSheet:Range(axcol(c-fila,Nom2Num("Cambiorecb"))):Value = STRING(Rec_detalle.new_cambio,"->>>>>>>>>9.99").
              chWorkSheet:Range(axcol(c-fila,Nom2Num("ImpDolares"))):Value = STRING(Rec_detalle.importe,"->>>>>>>>>9.99").
              chWorkSheet:Range(axcol(c-fila,Nom2Num("ImpPesos"))):Value = STRING(Rec_detalle.imp_pesos,"->>>>>>>>>9.99").
              chWorkSheet:Range(axcol(c-fila,Nom2Num("PorcAjuste"))):Value = STRING(Rec_detalle.prc_difcambio,"->>>>>>>>>9.99").
              chWorkSheet:Range(axcol(c-fila,Nom2Num("Porcdesfasaje"))):Value = STRING(Rec_detalle.prc_mincambio,"->>>>>>>>>9.99").
              IF Rec_detalle.difcambio > 0
                   THEN chWorkSheet:Range(axcol(c-fila,Nom2Num("DBCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
                   ELSE chWorkSheet:Range(axcol(c-fila,Nom2Num("CRCambio"))):Value = STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99").
          END.
          
          GET NEXT q-detalle.

      END. 

      /* */
      chWorkSheet:Range(axcol(c-fila,Nom2Num("Emision"))):Value = STRING(Rec_header.fecha,"99/99/9999").
      chWorkSheet:Range(axcol(c-fila,Nom2Num("Recibo"))):Value = STRING(Rec_header.nro_comprob,"99999999").
      chWorkSheet:Range(axcol(c-fila,Nom2Num("Porcdesfasaje"))):Value = STRING(Rec_header.imp_pesos + Rec_header.imp_difcambio,"->>>>>>>>>9.99").

      /*--------------------------------------------------------------------------------------------------
      ax(STRING(Rec_header.fecha,"99/99/9999"),c-fila,Nom2Num("Emision"),1,"Valor").
      ax(que_recibo,c-fila,Nom2Num("Recibo"),1,"Valor").                          
      
      ASSIGN v-total_recibo    = 0
             v-total_caja      = 0
             v-total_difcambio = 0.

      c-fila = 0.
      OPEN QUERY q-detalle
            FOR EACH Rec_detalle OF Rec_header NO-LOCK, 
                FIRST Moneda_detalle OF Rec_detalle NO-LOCK
                      BY Rec_detalle.es_difcambio. /* BY Hace que la dif. de cambio salga última */
      GET FIRST q-detalle.

      c-fila_medios = 0.
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

              ax(que_cancelado,c-fila + c-fila,Nom2Num("Factura"),1,"Valor").
              ax(Moneda_detalle.abrevia,c-fila + c-fila,Nom2Num("Monecomp"),1,"Valor").
              
              IF NOT Rec_detalle.es_difcambio
              THEN DO:
                  ax(STRING(Rec_detalle.importe,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Importe"),1,"Valor").
                  ax(STRING(Rec_detalle.imp_pesos,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Equivalepesos"),1,"Valor").
              END.
              
              ax(STRING(Rec_detalle.difcambio,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Difcambio"),1,"Valor").
                      
              IF Rec_detalle.clausula_dolar
              THEN DO:
                  ax(STRING(Rec_detalle.cambio_dolar,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Cambiocomp"),1,"Valor").
                  ax(STRING(Rec_detalle.new_cambio_dolar,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Cambiorecb"),1,"Valor").
                          
              END.
              ELSE DO:
                  ax(STRING(Rec_detalle.cambio,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Cambiocomp"),1,"Valor").
                  ax(STRING(Rec_detalle.new_cambio,"->>>>>>>>>9.99"),c-fila + c-fila,Nom2Num("Cambiorecb"),1,"Valor").
              END.

              c-fila = c-fila + 1.

          END.

          IF AVAILABLE Caj_detalle
          THEN DO:

              ax(Rubro.abrevia, c-fila + c-fila_medios,Nom2Num("Mediopago"),1,"Valor").
              ax(STRING(Caj_detalle.importe,"->>>>>>>>>9.99"),c-fila + c-fila_medios,Nom2Num("Percibido"),1,"Valor").
              ax(Moneda_caja.abrevia,c-fila + c-fila_medios,Nom2Num("Monepago"),1,"Valor").
                      
              v-total_caja = v-total_caja + Caj_detalle.importe.

              c-fila_medios = c-fila_medios + 1.

          END.

          DOWN WITH FRAME frm-listado.

          GET NEXT q-detalle.
          GET NEXT q-valores.

      END. /*  */

      c-fila = c-fila + MAXIMUM(c-fila,c-fila_medios) + 1.
    
      ax(STRING(v-total_recibo,"->>>>>>>>>9.99"),c-fila,Nom2Num("Equivalepesos"),1,"Valor"). /* @ Rec_detalle.imp_pesos*/
      ax(STRING(v-total_difcambio,"->>>>>>>>>9.99"),c-fila,Nom2Num("Difcambio"),1,"Valor"). /*  @ Rec_detalle.difcambio */
      ax(STRING(v-total_caja,"->>>>>>>>>9.99"),c-fila,Nom2Num("Percibido"),1,"Valor"). /* @ Caj_detalle.importe  */
      -------------------------------------------------------------------------*/
      c-fila = c-fila + 1. 
      /*
  END.
  */
/*
  v-total_aplicado = 0.
  que_recibo = "Pendiente".
  ax(que_recibo,c-fila,Nom2Num("Recibo"),1,"Valor").
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

      ax(que_cancelado,c-fila,Nom2Num("Factura"),1,"Valor").
      ax(STRING((Cta_cte.debito - Cta_cte.credito),"->>>>>>>>>9.99"),c-fila,Nom2Num("Importe"),1,"Valor"). /* @ Rec_detalle.importe   */
      ax(STRING((Cta_cte.debito - Cta_cte.credito) * Cta_cte.cambio,"->>>>>>>>>9.99"),c-fila,Nom2Num("Equivalepesos"),1,"Valor"). /* @ Rec_detalle.imp_pesos */
      ax(STRING(Cta_cte.cambio,"->>>>>>>>>9.99"),c-fila,Nom2Num("Cambiocomp"),1,"Valor"). /* @ Rec_detalle.cambio */
      ax(Moneda_detalle.abrevia,c-fila,Nom2Num("Monepago"),1,"Valor"). 

      c-fila = c-fila + 1.

      v-total_aplicado = v-total_aplicado + (Cta_cte.debito - Cta_cte.credito) * Cta_cte.cambio.
      que_recibo = "".

  END.

  ax(STRING(v-total_aplicado,"->>>>>>>>>9.99"),c-fila,Nom2Num("Equivalepesos"),1,"Valor"). /* @ Rec_detalle.imp_pesos */

  c-fila = c-fila + 1.*/

  END.

END PROCEDURE.

PROCEDURE agregar_columna:

    DEFINE INPUT PARAMETER p-renglon AS CHARACTER.
    DEFINE INPUT-OUTPUT PARAMETER p-ntcols AS INTEGER.

    p-ntcols = p-ntcols + 1.

    CREATE ttDefcolumnas.
    ASSIGN ttDefcolumnas.ttnumero_columna = p-ntcols
           ttDefcolumnas.ttnombre_columna = p-renglon.

END PROCEDURE.

PROCEDURE insertar_hoja_cliente:

      /* Agrega una hoja */
    /*chExcelApplication:Sheets("Modelo"):Select.*/
    /*chExcelApplication:Sheets("Modelo"):Copy(1,).*/
      chExcelApplication:Sheets:ADD. /*[ <anytype>-Var = ] <com-handle>: Add ( 
	  <anytype>-Before,
	  <anytype>-After,
	  <anytype>-Count,
	  <anytype>-Type ).
      /* ("xlChart",2,2).*/           */

      /* Le cambia de nombre */
      chExcelApplication:Sheets(1):Name = Cliente.nom_cliente.

      /* Selecciona el modelo */
      chWorkSheet = chExcelApplication:Sheets:Item("Modelo").
      chExcelApplication:Sheets("Modelo"):Select.

      /* Selecciona las celdas a copiar */
      chWorkSheet:Columns("A:AG"):Select.
    /*chExcelApplication:Selection.Copy
      chExcelApplication:Sheets(Cliente.nom_cliente).Select
      chWorkSheet:Range("A1").Select
      chWorkSheet:ActiveSheet.Paste*/

    /*chWorkSheet:Range("A1:AC8"):Select().*/

      /* Copia las celdas */
      chExcelApplication:Selection:Copy.

      /* Selecciona la hoja recien creada */
      chWorkSheet = chExcelApplication:Sheets:Item(Cliente.nom_cliente).
      chExcelApplication:Sheets(Cliente.nom_cliente):Select.

      /* Se para en la primera celda del rango */
      chWorkSheet:Range("A1"):Select().

      /* Pega la seleccion */
      chWorkSheet:Paste.

      /* Selecciona la hoja del cliente */
      chWorkSheet = chExcelApplication:Sheets:Item(Cliente.nom_cliente).
      chExcelApplication:Sheets(Cliente.nom_cliente):Select.

      /* Selecciona A9 para deseleccionar Se para en la primera celda del rango */
      chWorkSheet:Range("A9"):Select().

      /* Pone el nombre de la seleccion en D5 */
      chWorkSheet:Range("D5"):Value = Cliente.nom_cliente.

      /* Pone la condicion de venta en D8*/
      FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.
      chWorkSheet:Range("G5"):Value = Condicion_venta.descripcion.
    
END PROCEDURE.

/*RUN agregar_columna ( INPUT "Fecha", INPUT "Emisión", INPUT "Emision", INPUT-OUTPUT ntcols_excel ).            
  RUN agregar_columna ( INPUT "Identificación", INPUT "del Recibo", INPUT "Recibo", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Comprobante", INPUT "Cancelado", INPUT "Factura", INPUT-OUTPUT ntcols_excel ).    
  RUN agregar_columna ( INPUT "Importe", INPUT "Cancelado", INPUT "Importe", INPUT-OUTPUT ntcols_excel ).        
  RUN agregar_columna ( INPUT "Moneda", INPUT "Comprb", INPUT "Monecomp", INPUT-OUTPUT ntcols_excel ).            
  RUN agregar_columna ( INPUT "Cambio", INPUT "Comprobte", INPUT "Cambiocomp", INPUT-OUTPUT ntcols_excel ).         
  RUN agregar_columna ( INPUT "Cambio", INPUT "Recibo", INPUT "Cambiorecb", INPUT-OUTPUT ntcols_excel ).            
  RUN agregar_columna ( INPUT "Equivale", INPUT "Pesos", INPUT "Equivalepesos", INPUT-OUTPUT ntcols_excel ).           
  RUN agregar_columna ( INPUT "Diferencia", INPUT "Cambio", INPUT "Difcambio", INPUT-OUTPUT ntcols_excel ).        
  RUN agregar_columna ( INPUT "Medio", INPUT "Pago", INPUT "Mediopago", INPUT-OUTPUT ntcols_excel ).               
  RUN agregar_columna ( INPUT "Moneda", INPUT "Pago", INPUT "Monepago", INPUT-OUTPUT ntcols_excel ).              
  RUN agregar_columna ( INPUT "Importe", INPUT "Percibido", INPUT "Percibido", INPUT-OUTPUT ntcols_excel ).        */
