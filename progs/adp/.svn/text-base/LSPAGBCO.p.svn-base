/*==========================================================================================*/
/*                       EMITE EL LISTADO DE PAGOS EN BANCOS                                */
/*==========================================================================================*/

DEFINE INPUT PARAMETER emit_list  AS LOGICAL.
DEFINE INPUT PARAMETER emit_pago  AS LOGICAL.
DEFINE INPUT PARAMETER fecha_pago AS DATE.
DEFINE INPUT PARAMETER has_fecha  AS DATE.  
DEFINE INPUT PARAMETER disp_out   AS CHARACTER.

{DFVRNEMP.I}
 
{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE unif_pago  AS INTEGER.
DEFINE VARIABLE banco_ant  LIKE Banco.cdg_banco.

DEFINE SHARED VARIABLE sel_codigos AS CHARACTER FORMAT "X(60)".
DEFINE SHARED VARIABLE sel_nombres AS CHARACTER FORMAT "X(60)".

DEFINE VARIABLE todos       AS LOGICAL.     
DEFINE VARIABLE j           AS INTEGER.     
DEFINE VARIABLE fecha_lis   AS DATE.     
DEFINE VARIABLE hora_lis    AS CHARACTER.
DEFINE VARIABLE titulo_lst  AS CHARACTER FORMAT "X(30)" INITIAL "Planilla de Cambio".
DEFINE VARIABLE titulo_det  AS CHARACTER FORMAT "X(30)".
DEFINE VARIABLE que_empresa LIKE Empresa.nombre.

DEFINE VARIABLE total_a_pagar AS DECIMAL.
DEFINE VARIABLE total_banco   AS DECIMAL.
DEFINE VARIABLE total_empleado LIKE Rcb_header.a_pagar.
DEFINE VARIABLE ry          AS CHARACTER.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "Pagos en Cta. Bancaria por Banco" AT 30
  "Pagina:" AT 74 PAGE-NUMBER FORMAT ">>9" AT 82
  SKIP
  fecha_lis               
  titulo_det AT 30
  hora_lis AT 76
  SKIP(1)
  "------------------------------------------------------------------------------------" SKIP
  "Banco                         Legajo Apellido y Nombre         A pagar  Nro.Cuenta" SKIP
  "------------------------------------------------------------------------------------"
  WITH WIDTH 96 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Banco.cdg_banco
  Banco.nombre FORMAT "X(25)"
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(23)"
  total_empleado
  Empleado.cuenta_nro
  WITH WIDTH 96 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-footer HEADER
  ry SKIP
  WITH WIDTH 132 FRAME frm-footer PAGE-BOTTOM STREAM-IO.


/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.

/*=================================================================================*/
/*                           P R O C E D I M I E N T O S                           */
/*=================================================================================*/

PROCEDURE LISTAR:
       
  IF NUM-ENTRIES(sel_nombres) = 0 THEN todos = YES.
                                  ELSE todos = NO.
         
  RUN CVNOMCOD.P ( INPUT sel_nombres, OUTPUT sel_codigos ).

  titulo_det = ( IF todos THEN "Todos los estados" ELSE "Estados:" + sel_codigos ).
  titulo_det = titulo_det + " - Pagar:" + STRING(emit_pago,"Si/No").

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  IF disp_out = "A" THEN OUTPUT TO VALUE( dire_tmp + "lspagbco.txt" ) PAGED.
                    ELSE OUTPUT TO VALUE(port) PAGED. 

  FIND Parametro "UNFPAGSJ" NO-LOCK.
  unif_pago = Parametro.valor_n.

  FIND Parametro "RUBROACB" NO-LOCK.
  FIND Rubro WHERE Rubro.cdg_rubro = Parametro.valor_n.

  FIND Parametro "CTAPAGSJ" NO-LOCK.
  FIND Cuenta WHERE Cuenta.cdg_Cuenta = Parametro.valor_c.
  
  FIND Parametro "DFNCAJSJ" NO-LOCK NO-ERROR.
  FIND Caja WHERE Caja.cdg_caja = Parametro.valor_n NO-LOCK.
  act_caja = ROWID(Caja).

  IF emit_pago AND NOT unif_pago = 2
  THEN DO:
     CREATE Caj_header.
     ASSIGN Caj_header.fecha           = fecha_pago
            Caj_header.hora            = TIME
            Caj_header.tip_comprob     = "CJ"
            Caj_header.ultima_linea    = 0
            Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
            Caj_header.importe         = total_a_pagar
            Caj_header.cdg_caja        = Caja.cdg_caja
            Caj_header.estado          = "E"
            Caj_header.nro_cuenta      = Cuenta.nro_cuenta
            Caj_header.nro_proveedor   = 0
            Caj_header.observacion     = "SyJ - al " + STRING(has_fecha)
            Caj_header.origen          = "A"
            Caj_header.tipo_mov        = "E".
            
     FIND Parametro WHERE cdg_parametro = "PROXNCAJ" EXCLUSIVE-LOCK.
     ASSIGN Caj_header.nro_comprob = Parametro.valor_n
            Parametro.valor_n      = Parametro.valor_n + 1.
     RELEASE Parametro.

     IF unif_pago = 0
     THEN DO:
        CREATE Caj_detalle.
        ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
               Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
               Caj_detalle.nro_linea        = Caj_header.ultima_linea
               Caj_detalle.tipo_mov         = Caj_header.tipo_mov
               Caj_detalle.cdg_rubro        = Rubro.cdg_rubro
               Caj_detalle.importe          = Caj_header.importe
               Caj_detalle.observacion      = "SyJ - al " + STRING(has_fecha).
     END.          
  END.              

  /*{&SETEAR-IMPRESORA}*/
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "A",
                       FIRST Banco WHERE Banco.cdg_banco = Empleado.cdg_banco
                          BY Empleado.cdg_banco BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "A",
                       FIRST Banco WHERE Banco.cdg_banco = Empleado.cdg_banco
                          BY Empleado.cdg_banco BY Empleado.nombre.
  END.

  total_a_pagar = 0.       
  total_banco = 0.  
  banco_ant = ?.
  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado:
     
     VIEW FRAME frm-titulo.
     VIEW FRAME frm-footer.

     IF emit_list
     THEN DO:

        IF Banco.cdg_banco <> banco_ant AND banco_ant <> ?
        THEN DO:
           UNDERLINE  Banco.cdg_banco
                      Banco.nombre
                      Empleado.nro_legajo
                      Empleado.nombre
                      total_empleado
                      Empleado.cuenta_nro
                      WITH FRAME frm-listado-emp.
           DISPLAY    "Subtotal" @ Banco.nombre 
                      total_banco @ total_empleado
                      WITH FRAME frm-listado-emp.
           DOWN 2 WITH FRAME frm-listado-emp.        
           total_banco = 0.
        END.
        
     END.   

     RUN CLSALEMP ( INPUT ROWID(Empleado), 
                    INPUT has_fecha,
                    INPUT emit_pago,
                    OUTPUT total_empleado).
                    
     total_a_pagar = total_a_pagar + total_empleado.
     total_banco   = total_banco   + total_empleado.
          
     IF emit_list
     THEN DO:

        DISPLAY Banco.cdg_banco WHEN Banco.cdg_banco <> banco_ant
                Banco.nombre    WHEN Banco.cdg_banco <> banco_ant
                Empleado.nro_legajo
                Empleado.nombre
                total_empleado
                Empleado.cuenta_nro
                WITH FRAME frm-listado-emp.
        DOWN  WITH FRAME frm-listado-emp.
     END.   

     IF emit_pago AND total_empleado <> 0
     THEN DO:
        RUN EMITIR_PAGO.
     END.

     banco_ant = Banco.cdg_banco.
     GET NEXT qry_empleados.

  END.
  
  IF emit_list
  THEN DO:

     UNDERLINE  Banco.cdg_banco
                Banco.nombre
                Empleado.nro_legajo
                Empleado.nombre
                total_empleado
                Empleado.cuenta_nro
                WITH FRAME frm-listado-emp.
     DISPLAY    "Subtotal" @ Banco.nombre 
                 total_banco @ total_empleado
                 WITH FRAME frm-listado-emp.
     DOWN  WITH FRAME frm-listado-emp.        

     UNDERLINE  Banco.cdg_banco
                Banco.nombre
                Empleado.nro_legajo
                Empleado.nombre
                total_empleado
                Empleado.cuenta_nro
                WITH FRAME frm-listado-emp.
     DISPLAY    "TOTAL" @ Banco.nombre 
                 total_a_pagar @ total_empleado
                 WITH FRAME frm-listado-emp.
     DOWN  WITH FRAME frm-listado-emp.        
     HIDE FRAME frm-footer.

  END.   

  IF NOT unif_pago = 2 AND emit_pago
  THEN DO:
     ASSIGN Caj_header.importe   = total_a_pagar.
     IF unif_pago = 0 THEN Caj_detalle.importe  = Caj_header.importe.
     RELEASE Parametro.
     RELEASE Caj_header.
     RELEASE Caj_detalle.
  END.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

PROCEDURE EMITIR_PAGO:

  IF unif_pago = 2
  THEN DO:
     CREATE Caj_header.
     ASSIGN Caj_header.fecha           = fecha_pago
            Caj_header.hora            = TIME
            Caj_header.tip_comprob     = "CJ"
            Caj_header.ultima_linea    = 0
            Caj_header.nro_transaccion = NEXT-VALUE(proxima_txncaja)
            Caj_header.importe         = total_empleado
            Caj_header.cdg_caja        = Caja.cdg_caja
            Caj_header.estado          = "E"
            Caj_header.nro_cuenta      = Cuenta.nro_cuenta
            Caj_header.nro_proveedor   = Empleado.nro_empleado
            Caj_header.observacion     = "SyJ - " + Empleado.nombre + " " + STRING(Empleado.nro_legajo,"999999")
            Caj_header.origen          = "A"
            Caj_header.tipo_mov        = "E".
            
     FIND Parametro WHERE cdg_parametro = "PROXNCAJ" EXCLUSIVE-LOCK.
     ASSIGN Caj_header.nro_comprob = Parametro.valor_n
            Parametro.valor_n      = Parametro.valor_n + 1.
     RELEASE Parametro.
     
  END.    

  IF NOT unif_pago = 0
  THEN DO:     
     CREATE Caj_detalle.
     ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
            Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
            Caj_detalle.nro_linea        = Caj_header.ultima_linea
            Caj_detalle.tipo_mov         = Caj_header.tipo_mov
            Caj_detalle.cdg_rubro        = Rubro.cdg_rubro
            Caj_detalle.importe          = total_empleado
            Caj_detalle.observacion      = "SyJ - " + 
                                           SUBSTRING(Empleado.nombre,1,12) + 
                                           " " + 
                                           STRING(Empleado.nro_legajo,"999999") +
                                           " " +
                                           Banco.abrevia +
                                           " " +
                                           Empleado.cuenta_nro.
            
  END.            

  CREATE Cta_cte_emp.
  ASSIGN Cta_cte_emp.credito        = total_empleado   
         Cta_cte_emp.estado         = 2
         Cta_cte_emp.fecha_emision  = fecha_pago
         Cta_cte_emp.nro_comprob    = Caj_header.nro_comprob
         Cta_cte_emp.nro_empleado   = Empleado.nro_empleado
         Cta_cte_emp.tip_comprob    = "CJ"
         Cta_cte_emp.nro_documento  = Caj_header.nro_transaccion.

  IF NOT unif_pago = 0
  THEN DO:
     RELEASE Parametro.
     RELEASE Caj_detalle.
     IF unif_pago = 2 THEN RELEASE Caj_header.
  END.            

END PROCEDURE.

{CODIMPRE.I}
