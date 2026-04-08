/*=================================================================================*/
/*                                                                                 */
/*  GENERA TODAS LAS O/COMPRA DE TODAS LAS COTIZACIONES ADJUDICADAS Y PENDIENTES   */
/*  PARA UN GRUPO DE PROVEEDORES DADO POR EL RANGO DEL CODIGO.                     */
/*                                                                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_proveedor  LIKE Proveedor.cdg_proveedor.
DEFINE INPUT PARAMETER has_proveedor  LIKE Proveedor.cdg_proveedor.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE cotiza_dolar         AS DECIMAL.
DEFINE VARIABLE codigo_dolar         LIKE Moneda.cdg_moneda.
DEFINE VARIABLE tiene_permiso        AS LOGICAL.

DEFINE VARIABLE que_empresa LIKE Empresa.nombre.
DEFINE VARIABLE fecha_lis  AS DATE.
DEFINE VARIABLE hora_lis   AS CHARACTER.

{WGLISTAR.I}

FORM HEADER
   que_empresa FORMAT "X(25)"
   "Generacion masiva de O/Compra" AT 55
   "Página:" AT 123 PAGE-NUMBER FORMAT ">9" AT 130
   SKIP
   fecha_lis
   "Rango Proveedores:" AT 55
   des_proveedor " - " has_proveedor
   hora_lis AT 123
   SKIP(2)
   WITH FRAME frm-listado CENTERED TOP-ONLY.

FORM
   Proveedor.cdg_proveedor
   Proveedor.nombre
   Ocm_header.nro_comprob
   Ocm_header.fecha
   Ocm_header.imp_total
   WITH FRAME frm-listado DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  fecha_lis = TODAY.
  hora_lis = STRING(TIME,"HH:MM:SS").
  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

  OUTPUT TO VALUE(DIRE_TMP + "lsgenocom.txt") PAGED PAGE-SIZE 72.
  RUN PONE_CODIGO ( INPUT "HORIZONT,SET17CPI,CARTA").

  RUN INICIAR_VARIABLES.

  DO TRANSACTION:

    FOR EACH Concurso_cotiza WHERE Concurso_cotiza.st_item = "A",
                             FIRST Proveedor OF Concurso_cotiza
                                   WHERE Proveedor.cdg_proveedor >= des_proveedor
                                     AND Proveedor.cdg_proveedor <= has_proveedor,
                             FIRST Concurso_item WHERE Concurso_item.nro_concurso = Concurso_cotiza.nro_concurso EXCLUSIVE-LOCK        
                                         BREAK BY Proveedor.cdg_proveedor:

        IF FIRST-OF(Proveedor.cdg_proveedor)
        THEN DO:
             RUN CREAR_ENCABEZADO.
        END.     
    
        RUN CREAR_DETALLE.
        Concurso_cotiza.st_item = "B".
        Concurso_item.cantidad_adj = Concurso_item.cantidad_adj + Concurso_cotiza.cantidad.

        IF LAST-OF(Proveedor.cdg_proveedor)
        THEN DO:
             DISPLAY 
                    Proveedor.cdg_proveedor
                    Proveedor.nombre
                    Ocm_header.nro_comprob
                    Ocm_header.fecha
                    Ocm_header.imp_total
                    WITH FRAME frm-listado.
             DOWN WITH FRAME frm-listado.       
        END.     


      END. /* Del FOR EACH de detalle de ITEMS */

  END. /* De la transaccion */
  
   OUTPUT CLOSE.
   PAUSE 0.
   HIDE FRAME frm-espere.

END PROCEDURE.  

{CODIMPRE.I}

PROCEDURE CREAR_ENCABEZADO:

    FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Proveedor.dfl_cndventa NO-LOCK.

    CREATE Ocm_header.
    ASSIGN Ocm_header.cambio               = Moneda.cambio
           Ocm_header.cambio_dolar         = cotiza_dolar
           Ocm_header.nro_deposito         = Deposito.nro_deposito
           Ocm_header.cdg_estado           = "OB"
           Ocm_header.cdg_imputacion       = Imputacion.cdg_imputacion
           Ocm_header.cdg_lista            = 1
           Ocm_header.estado               = ""
           Ocm_header.fecha                = TODAY
           Ocm_header.imp_neto             = 0
           Ocm_header.imp_total            = 0
           Ocm_header.nro_cndventa         = Condicion_venta.nro_cndventa
           Ocm_header.nro_comprador        = 1
           Ocm_header.nro_domicilio        = 1
           Ocm_header.nro_moneda           = Moneda.nro_moneda
           Ocm_header.nro_ocompra          = NEXT-VALUE(proxima_transaccion)
           Ocm_header.nro_proveedor        = Proveedor.nro_proveedor
           Ocm_header.nro_usuario          = Usuario.nro_usuario
           Ocm_header.origen               = "A"
           Ocm_header.tip_comprob          = "OC"
           Ocm_header.ultima_linea         = 0
           Ocm_header.version              = 0.

   FIND Parametro "PROXNOCM" EXCLUSIVE-LOCK.
   Ocm_header.nro_comprob = Parametro.valor_n.
   Parametro.valor_n = Parametro.valor_n + 1.
   RELEASE Parametro.

END PROCEDURE.

PROCEDURE CREAR_DETALLE:

/* FIND Articulo OF Concurso_cotiza NO-LOCK. */

   Ocm_header.ultima_linea = Ocm_header.ultima_linea + 1.

   CREATE Ocm_detalle.
   ASSIGN Ocm_detalle.nro_ocompra         = Ocm_header.nro_ocompra 
          Ocm_detalle.nro_linea           = Ocm_header.ultima_linea
          Ocm_detalle.nro_articulo        = Concurso_cotiza.nro_articulo
          Ocm_detalle.a_granel            = NO /* Articulo.a_granel */
          Ocm_detalle.precio              = Concurso_cotiza.precio
          Ocm_detalle.fecha_temprana      = Ocm_header.fecha   
          Ocm_detalle.fecha_tardia        = Ocm_header.fecha
          Ocm_detalle.cantidad            = Concurso_cotiza.cantidad
          Ocm_detalle.cdg_estado          = "OB".

   Ocm_detalle.ultima_entrega = Ocm_detalle.ultima_entrega + 1.
   CREATE Ocm_detalle_entr.
   ASSIGN Ocm_detalle_entr.nro_ocompra    = Ocm_detalle.nro_ocompra
          Ocm_detalle_entr.nro_linea      = Ocm_detalle.nro_linea
          Ocm_detalle_entr.nro_entrega    = Ocm_detalle.ultima_entrega
          Ocm_detalle_entr.a_granel       = Ocm_detalle.a_granel
          Ocm_detalle_entr.fecha_temprana = Ocm_detalle.fecha_temprana
          Ocm_detalle_entr.fecha_tardia   = Ocm_detalle.fecha_tardia
          Ocm_detalle_entr.cantidad       = Ocm_detalle.cantidad.

   Ocm_header.imp_total = Ocm_header.imp_total + Ocm_detalle.precio * Ocm_detalle.cantidad.

   RUN REGISTRAR_NOVEDADES.

END PROCEDURE.

PROCEDURE REGISTRAR_NOVEDADES:

   FOR EACH Concurso-requisicion 
       WHERE Concurso-requisicion.nro_concurso = Concurso_item.nro_concurso
         AND Concurso-requisicion.nro_articulo = Concurso_item.nro_articulo,
       FIRST Rqs_detalle OF Concurso-requisicion NO-LOCK,
       FIRST Rqs_header OF Rqs_detalle NO-LOCK:

       RUN CMBERQOB.p ( INPUT ROWID(Rqs_header), 
                        INPUT ROWID(Rqs_detalle), 
                        INPUT "", 
                        OUTPUT tiene_permiso ).

   END. 

END PROCEDURE.

PROCEDURE INICIAR_VARIABLES:

   FIND Usuario WHERE Usuario.cdg_usuario = USERID("SIC") NO-LOCK.

   FIND Parametro "CDGDOLAR" NO-LOCK.
   codigo_dolar = Parametro.valor_c.
   FIND Moneda WHERE Moneda.cdg_moneda = codigo_dolar NO-LOCK.
   cotiza_dolar = Moneda.cambio.

   FIND Parametro "DFMONEDA" NO-LOCK NO-ERROR.
   FIND Moneda WHERE Moneda.cdg_moneda = Parametro.valor_c NO-LOCK.
   act_moneda = ROWID(Moneda).

   FIND Parametro "DFDEPOSI" NO-LOCK NO-ERROR.
   FIND Deposito WHERE Deposito.nro_deposito = Parametro.valor_n NO-LOCK.
   act_deposito = ROWID(Deposito).

   FIND Parametro "DFCNRMPV" NO-LOCK NO-ERROR.
   FIND Imputacion WHERE Imputacion.cdg_imputacion = Parametro.valor_n NO-LOCK.
   FIND Cuenta OF Imputacion NO-LOCK.
   act_concepto = ROWID(Imputacion).
   act_cuenta = ROWID(Cuenta).

END PROCEDURE.
