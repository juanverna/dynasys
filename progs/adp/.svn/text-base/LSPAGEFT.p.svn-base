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

&GLOBAL-DEFINE NTBILL 9
DEFINE VARIABLE billete    AS DECIMAL EXTENT {&NTBILL} 
                INITIAL [100.0,50.0,20.0,10.0,5.0,1.0,0.50,0.25,0.10].
DEFINE VARIABLE cambio     AS INTEGER EXTENT {&NTBILL} FORMAT "ZZ9".
DEFINE VARIABLE cambio_t   AS INTEGER EXTENT {&NTBILL} FORMAT "ZZ9".                
DEFINE VARIABLE remanente  AS DECIMAL.
DEFINE VARIABLE total_a_pagar AS DECIMAL.
DEFINE VARIABLE total_empleado LIKE Rcb_header.a_pagar.
DEFINE VARIABLE k_bill      AS INTEGER.
DEFINE VARIABLE ry          AS CHARACTER.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(18)"
  "Pagos en efectivo a emitir" AT 30
  "Pagina:" AT 68 PAGE-NUMBER FORMAT ">>9" AT 76
  SKIP
  fecha_lis               
  titulo_det AT 30
  hora_lis AT 68
  SKIP(1)
  "------------------------------------------------------------------------------" SKIP
  "Legajo  Apellido y Nombre          A pagar 100  50  20  10   5   1 050 025 010" SKIP
  "------------------------------------------------------------------------------"
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado-emp
  Empleado.nro_legajo
  Empleado.nombre  FORMAT "X(23)"
  total_empleado
  cambio
  WITH WIDTH 80 DOWN CENTERED FRAME frm-listado-emp USE-TEXT STREAM-IO NO-BOX
       NO-LABEL.

DEFINE FRAME frm-total-emp
  SPACE(8)
  "TOTALES" SPACE(17)
  total_a_pagar 
  cambio_t
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
  
  IF disp_out = "A" THEN OUTPUT TO VALUE( dire_tmp + "lspageft.txt" ) PAGED.
                    ELSE OUTPUT TO VALUE(port) PAGED. 

  FIND Parametro "UNFPAGSJ" NO-LOCK.
  unif_pago = Parametro.valor_n.

  FIND Parametro "RUBROEFT" NO-LOCK.
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
 
  {OPQRYPAG.I "E"}

  total_a_pagar = 0.
  cambio_t = 0.
  GET FIRST qry_empleados.
  DO WHILE AVAILABLE Empleado:
     
     VIEW FRAME frm-titulo.
     VIEW FRAME frm-footer.

     RUN CLSALEMP ( INPUT ROWID(Empleado), 
                    INPUT has_fecha,
                    INPUT emit_pago,
                    OUTPUT total_empleado).

     total_a_pagar = total_a_pagar + total_empleado.
     
     IF emit_list
     THEN DO:
        cambio = 0.
        remanente = total_empleado.
        DO k_bill = 1 TO {&NTBILL} WHILE remanente <> 0:
           cambio [ k_bill ] = TRUNC(remanente / billete [ k_bill ] , 0 ).
           remanente = remanente - cambio [ k_bill ] * billete [ k_bill ].
           cambio_t [ k_bill ] = cambio_t [ k_bill ] + cambio [ k_bill ].
        END.   
        DISPLAY Empleado.nro_legajo
                Empleado.nombre
                total_empleado
                cambio
                WITH FRAME frm-listado-emp.
        DOWN  WITH FRAME frm-listado-emp.
     END.   

     IF emit_pago AND total_empleado <> 0
     THEN DO:
        RUN EMITIR_PAGO.
     END.
     GET NEXT qry_empleados.

  END.
  
  IF emit_list
  THEN DO:
     UNDERLINE   Empleado.nro_legajo
                 Empleado.nombre
                 total_empleado
                 cambio
                 WITH FRAME frm-listado-emp.
     DISPLAY     total_a_pagar
                 cambio_t
                 WITH FRAME frm-total-emp.
     DOWN  WITH FRAME frm-total-emp.        
     HIDE FRAME frm-footer.
  END.   

  IF unif_pago = 0 AND emit_pago
  THEN DO:
     ASSIGN Caj_header.importe   = total_a_pagar
            Caj_detalle.importe  = Caj_header.importe.
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
            Caj_detalle.observacion      = "SyJ - " + Empleado.nombre + " " + STRING(Empleado.nro_legajo,"999999").
            
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
