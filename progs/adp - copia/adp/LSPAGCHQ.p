/*------------------------------------------------------------------------------------*/
/* Toma datos de rango para listado de pagos                                          */
/*                                                                                    */
/*------------------------------------------------------------------------------------*/

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
  "Pagos con Cheque a emitir" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  titulo_det AT 30
  hora_lis AT 68
  SKIP(1)
  "------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre          A pagar    Banco     Nro.Cheque" SKIP
  "------------------------------------------------------------------"
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(23)"
  total_empleado
  Cheque.cdg_cuenta_ban 
  Cheque.nro_cuenta_ban 
  Cheque.numero_cheque
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-total-emp
  SPACE(8)
  "TOTALES" SPACE(17)
  total_a_pagar 
  WITH WIDTH 132 DOWN CENTERED FRAME frm-total-emp USE-TEXT STREAM-IO NO-BOX
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
  
  IF disp_out = "A" THEN OUTPUT TO VALUE( dire_tmp + "lspagchq.txt" ) PAGED.
                    ELSE OUTPUT TO VALUE(port) PAGED. 

  FIND Parametro "RUBROCHQ" NO-LOCK.
  FIND Rubro WHERE Rubro.cdg_rubro = Parametro.valor_n.

  FIND Parametro "CTAPAGSJ" NO-LOCK.
  FIND Cuenta WHERE Cuenta.cdg_cuenta = Parametro.valor_c.

  FIND Parametro "CBCOPGSJ" NO-LOCK.
  FIND Cuenta_bancaria WHERE Cuenta_bancaria.cdg_cuenta_ban = Parametro.valor_c.
  
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

  END.              

  /*{&SETEAR-IMPRESORA}*/
 
  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nro_legajo >= des_legajo
                         AND Empleado.nro_legajo <= has_legajo
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "C"
                          BY Empleado.nro_legajo.
  END.
  ELSE DO:
     OPEN QUERY qry_empleados
     FOR EACH Empleado WHERE Empleado.nombre >= des_nombre
                         AND Empleado.nombre <= has_nombre
                         AND LOOKUP(Empleado.cdg_estado,sel_codigos) <> 0
                         AND Empleado.cdg_forma = "C"
                          BY Empleado.nombre.
  END.

  total_a_pagar = 0.
  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado:
     
     VIEW FRAME frm-titulo.
     VIEW FRAME frm-footer.

     RUN CLSALEMP ( INPUT ROWID(Empleado), 
                    INPUT has_fecha,
                    INPUT emit_pago,
                    OUTPUT total_empleado).

     total_a_pagar = total_a_pagar + total_empleado.
     
     IF emit_pago AND total_empleado <> 0
     THEN DO:
        RUN EMITIR_PAGO.
     END.
     
     IF emit_list
     THEN DO:
        DISPLAY Empleado.nro_legajo
                Empleado.nombre
                total_empleado
                Cheque.cdg_cuenta_ban WHEN AVAILABLE Cheque
                Cheque.nro_cuenta_ban WHEN AVAILABLE Cheque
                Cheque.numero_cheque  WHEN AVAILABLE Cheque              
                WITH FRAME frm-listado-emp.
        DOWN  WITH FRAME frm-listado-emp.
     END.        
     
     GET NEXT qry_empleados.

  END.
  
  IF emit_list
  THEN DO:
     UNDERLINE   Empleado.nro_legajo
                 Empleado.nombre
                 total_empleado
                 Cheque.cdg_cuenta_ban 
                 Cheque.nro_cuenta_ban 
                 Cheque.numero_cheque
                 WITH FRAME frm-listado-emp.
     DISPLAY     total_a_pagar
                 WITH FRAME frm-total-emp.
     DOWN  WITH FRAME frm-total-emp.        
     HIDE FRAME frm-footer.
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

  CREATE Caj_detalle.
  ASSIGN Caj_header.ultima_linea      = Caj_header.ultima_linea + 1
         Caj_detalle.nro_transaccion  = Caj_header.nro_transaccion
         Caj_detalle.nro_linea        = Caj_header.ultima_linea
         Caj_detalle.tipo_mov         = Caj_header.tipo_mov
         Caj_detalle.cdg_rubro        = Rubro.cdg_rubro
         Caj_detalle.importe          = total_empleado
         Caj_detalle.observacion      = "SyJ - " + Empleado.nombre + " " + STRING(Empleado.nro_legajo,"999999").
         
  CREATE Cta_cte_emp.
  ASSIGN Cta_cte_emp.credito        = total_empleado   
         Cta_cte_emp.estado         = 2
         Cta_cte_emp.fecha_emision  = fecha_pago
         Cta_cte_emp.nro_comprob    = Caj_header.nro_comprob
         Cta_cte_emp.nro_empleado   = Empleado.nro_empleado
         Cta_cte_emp.tip_comprob    = "CJ"
         Cta_cte_emp.nro_documento  = Caj_header.nro_transaccion.

  RELEASE Parametro.
  RELEASE Caj_detalle.
  IF unif_pago = 2 THEN RELEASE Caj_header.

END PROCEDURE.

PROCEDURE ASIGNAR_CHEQUE:

  CREATE Cheque.
  ASSIGN Cheque.nro_cheque      = NEXT-VALUE(proximo_cheque)
         Caj_detalle.nro_cheque = Cheque.nro_cheque
         Cheque.fecha_emision   = TODAY
         Cheque.dias_clearing   = 2
         Cheque.estado          = "00"
         Cheque.nro_transaccion = Caj_header.nro_transaccion
         Cheque.cdg_cuenta_ban  = Cuenta_bancaria.cdg_cuenta_ban
         Cheque.nro_proveedor   = Caj_header.nro_proveedor
         Cheque.fecha_salida    = Caj_header.fecha
         Cheque.fecha_emision   = Caj_header.fecha
         Cheque.fecha_acredita  = Caj_header.fecha
         Cheque.cdg_caja        = Caj_header.cdg_caja
         Cheque.fecha_deposito  = MAXIMUM(Cheque.fecha_emision, Caj_header.fecha)
         Cheque.importe         = Caj_detalle.importe
         Cheque.observacion     = "SyJ - " + Empleado.nombre + " " + STRING(Empleado.nro_legajo,"999999").

  FIND FIRST Chequera OF Cuenta_bancaria 
       WHERE Chequera.ultimo_cheque < Chequera.hasta_cheque EXCLUSIVE-LOCK NO-WAIT NO-ERROR.
        
  IF NOT AVAILABLE Chequera
  THEN IF LOCKED Chequera
       THEN DO:
          RUN PONMENSJ.P (INPUT "CAJA015").
          RETURN.
       END.
       ELSE DO:
          RUN PONMENSJ.P (INPUT "CAJA016").
          RETURN.
       END.

  IF Chequera.ultimo_cheque = 0
     THEN Cheque.numero_cheque = Chequera.desde_cheque.
     ELSE Cheque.numero_cheque = Chequera.ultimo_cheque + 1.

  Chequera.ultimo_cheque = Cheque.numero_cheque.    

END PROCEDURE.


{CODIMPRE.I}
