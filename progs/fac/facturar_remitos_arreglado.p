/*==================================================================================================*/
/*                  PRODUCE LA FACTURACION DE UNA SERIE DE REMITOS EN UNA SOLA FACTURA              */
/*==================================================================================================*/
/*
  NOTA: En la asignacion del nùmero interno de factura, se hace mencion a CURRENT-VALUE() + 1 en
  lugar de NEXT-VALUE. Es para no adelantar la secuencia ya que lo hace el procedimiento que sigue
  que es emitir_comprobante_cliente y entonces quedan los remitos con una referencia invalida a las 
  facturas
*/

DEFINE TEMP-TABLE T-Rem_header               NO-UNDO LIKE Rem_header.
DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.

/*==================================================================================================*/
/*                                          PARAMETROS                                              */
/*==================================================================================================*/

DEFINE INPUT PARAMETER TABLE FOR T-Rem_header.
DEFINE INPUT PARAMETER p-cdg_concepto LIKE Fac_header.cdg_imputacion. 
DEFINE INPUT PARAMETER p-punto_venta  LIKE Fac_header.prf_comprob. 
DEFINE INPUT PARAMETER p-fecha_factura LIKE Fac_header.fecha. 
DEFINE OUTPUT PARAMETER lista_errores AS CHARACTER.

/*==================================================================================================*/
/*                                          VARIABLES                                               */
/*==================================================================================================*/

{vrshared.i "new"}

/*
DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL INITIAL NO.
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL INITIAL YES.
*/

DEFINE BUFFER Comprobante_destino FOR Tipocomprobante.

DEFINE VARIABLE hay_varios_remitos AS LOGICAL.
DEFINE VARIABLE v-pto_venta AS INTEGER.

DEFINE VARIABLE rid-1       AS ROWID.
DEFINE VARIABLE rid-2       AS ROWID.

/*==================================================================================================*/
/*                                        BLOQUE  PRINCIPAL                                         */
/*==================================================================================================*/

RUN proceso.

/*==================================================================================================*/
/*                                      PROCEDIMIENTOS INTERNOS                                     */
/*==================================================================================================*/

PROCEDURE proceso:

    {findempresa.i}

    /* --------------------------------------------------- */
    /* Verifica la consistencia de todos los remitos se-   */
    /* leccionados para facturar. Si no hay error, la lis- */
    /* ta de errores viene vacia                           */
    /* --------------------------------------------------- */

    RUN verificar_consistencia ( OUTPUT lista_errores ).

    IF lista_errores <> "" THEN RETURN.
    
    /* --------------------------------------------------- */
    /* Del primer remito sabe si son envios o devoluciones */
    /* y levanta todos los datos de la operación. Antes    */
    /* accede al ultimo remito de la tabla para saber si   */
    /* son uno o mas de uno. En el primer caso no agrupa   */
    /* articulos de igual codigo para generar la factura.  */
    /* En el segundo caso si lo hace.                      */
    /* --------------------------------------------------- */

   FIND LAST T-Rem_header NO-LOCK.
   rid-2 = ROWID(T-Rem_header).

   FIND FIRST T-Rem_header NO-ERROR.
   rid-1 = ROWID(T-Rem_header).

   hay_varios_remitos = rid-2 <> rid-1.

   FIND Cliente OF T-Rem_header NO-LOCK.
   FIND Condicion_venta WHERE Condicion_venta.cdg_cndventa = Cliente.dfl_cndventa NO-LOCK.
   FIND Domicilio OF T-Rem_header NO-LOCK.
   FIND Condicion_impos OF T-Rem_header NO-LOCK.
   FIND Tipocomprobante OF T-Rem_header NO-LOCK. 
   CREATE T-Fac_header.
   BUFFER-COPY T-Rem_header TO T-Fac_header 
        ASSIGN T-Fac_header.origen               = "R"
               T-Fac_header.estado               = "P"
               T-Fac_header.cta_cte              = YES /* OJO !!!!!! */
               
               T-Fac_header.direccion_leg        = Cliente.direccion
               T-Fac_header.cdg_provincia_leg    = Cliente.cdg_provincia
               T-Fac_header.localidad_leg        = Cliente.localidad
               T-Fac_header.cdg_postal_leg       = Cliente.cdg_postal
               T-Fac_header.nro_deposito         = T-Rem_header.nro_deposito
               T-Fac_header.tip_comprob          = IF Tipocomprobante.debita THEN "F*" ELSE "C*"
               T-Fac_header.prf_comprob          = p-punto_venta
               T-Fac_header.nro_factura          = CURRENT-VALUE(proxima_transaccion) + 1 /* Ver nota en encabezado */ 
               T-Fac_header.fecha                = p-fecha_factura
               T-Fac_header.fecha_iva            = T-Fac_header.fecha
               T-Fac_header.fecha_precios        = T-Rem_header.fecha
               T-Fac_header.cdg_imputacion       = p-cdg_concepto
               T-Fac_header.impreso              = ""
               T-Fac_header.nro_usuario          = usuario.nro_usuario
               T-Fac_header.nro_cndventa         = Condicion_venta.nro_cndventa
               T-Fac_header.proc_estad           = NO
               T-Fac_header.ultima_linea         = 0.

   FIND Imputacion OF T-Fac_header NO-LOCK.
   CASE Cliente.paga_abasto:
        WHEN "N" THEN T-Fac_header.modo_abasto    = "N".
        WHEN "D" THEN T-Fac_header.modo_abasto    = Imputacion.modo_abasto.
        WHEN "S" THEN T-Fac_header.modo_abasto    = "S".
   END CASE.

   FIND FIRST Relacion_comprobante 
       WHERE Relacion_comprobante.cdg_comproborigen = T-Rem_header.cdg_comprobante
         AND Relacion_comprobante.cdg_empresa       = T-Rem_header.cdg_empresa
             NO-LOCK NO-ERROR.

   IF AVAILABLE Relacion_comprobante 
   THEN DO:
       FIND Comprobante_destino 
            WHERE Comprobante_destino.cdg_comprobante = Relacion_comprobante.cdg_comprobdestino
              AND Comprobante_destino.cdg_empresa     = Relacion_comprobante.cdg_empresa
                  NO-LOCK.
       ASSIGN T-Fac_header.cdg_comprobante = Comprobante_destino.cdg_comprobante
              T-Fac_header.tip_comprob     = Comprobante_destino.tip_comprob.  

   END.
   ELSE DO:
       MESSAGE "No se encuentra el comprobante de destino para el origen " Tipocomprobante.cdg_comprobante
               "Empresa" T-Fac_header.cdg_empresa 
           VIEW-AS ALERT-BOX ERROR TITLE "ERROR DE IMPLEMENTACION:FACTURAR_REMITOS.P".
   END.

   /*-------------------------- ANTES 08/10/05 ----------------------------------------
   CASE T-Fac_header.cdg_empresa:

       WHEN "F" 
       THEN DO:
           CASE Tipocomprobante.cdg_comprobante:
               WHEN "REMITCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "FACTUCLI"
                                           T-Fac_header.tip_comprob     = "F*". 
               WHEN "NDEVOCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "CREDICLI"
                                           T-Fac_header.tip_comprob     = "C*". 
               WHEN "AJUSTCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "DEBITCLI"
                                           T-Fac_header.tip_comprob     = "D*". 
            END CASE.
       END.

       WHEN "R"
       THEN DO:
           CASE Tipocomprobante.cdg_comprobante:
               WHEN "REMITCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "DOCUMCLI"
                                           T-Fac_header.tip_comprob     = "F*". 
               WHEN "NDEVOCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "CREDICLI"
                                           T-Fac_header.tip_comprob     = "C*". 
               WHEN "AJUSTCLI" THEN ASSIGN T-Fac_header.cdg_comprobante = "DEBITCLI"
                                           T-Fac_header.tip_comprob     = "D*". 
           END CASE.
       END.
   END CASE.
   ------------------------------------------------------------------------------------*/

   FIND Provincia OF Domicilio NO-LOCK.
   ASSIGN  T-Fac_header.nro_domicilio = Domicilio.nro_domicilio
           T-Fac_header.direccion     = Domicilio.direccion
           T-Fac_header.cdg_provincia = Domicilio.cdg_provincia
           T-Fac_header.localidad     = Domicilio.localidad
           T-Fac_header.cdg_postal    = Domicilio.cdg_postal
           T-Fac_header.cdg_zonag     = Domicilio.cdg_zonag.
                 
   FIND Vendedor OF T-Fac_header NO-LOCK.
   FIND Obra WHERE Obra.cdg_obra = Vendedor.cdg_vendedor NO-LOCK.
   ASSIGN T-Fac_header.nro_entidad = Cliente.nro_entidad
          T-Fac_header.nro_obra    = Obra.nro_obra.             

    /* --------------------------------------------------- */
    /* Procesamos todos los remitos y asignamos los arti-  */
    /* culos a la factura. Se asigna precio del remito.    */
    /* Luego, si los remitos tienen un origen que no debe  */
    /* respetar los precios que vienen en el mismo, pisamos*/
    /* esa asignacion levantando de la lista de precios    */
    /* --------------------------------------------------- */

   FOR EACH T-Rem_header:

       /* NO LEVANTAR LAS BONIFICACIONES AUTOMATICAMENTE CR 12/07/05
       /*************************/
       FOR EACH Cliente-bonificacion OF Cliente 
                 WHERE Cliente-bonificacion.cdg_empresa = Empresa.cdg_empresa
                   AND Cliente-bonificacion.desde_fecha <= T-Rem_header.fecha 
                   AND Cliente-bonificacion.hasta_fecha >= T-Rem_header.fecha 
                      NO-LOCK:
       FIND Rem_header-bon WHERE Rem_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                           AND Rem_header-bon.importe          = 0
                           AND Rem_header-bon.nro_remito       = T-Rem_header.nro_remito
                           AND Rem_header-bon.porcentaje       = Cliente-bonificacion.porcentaje NO-LOCK NO-ERROR.
                   
                IF NOT AVAILABLE Rem_header-bon THEN DO:
        
                           CREATE Rem_header-bon.
                           ASSIGN Rem_header-bon.cdg_bonificacion = Cliente-bonificacion.cdg_bonificacion
                                  Rem_header-bon.importe          = 0
                                  Rem_header-bon.nro_remito       = T-Rem_header.nro_remito
                                  Rem_header-bon.porcentaje       = Cliente-bonificacion.porcentaje.
               
               END.
       END.

       /******************************/
       */

       RUN agregar_remito_a_factura. /* Agrega las lineas de remito a las de factura. */
   END.
   
    /* --------------------------------------------------- */
    /* Para conocer el origen de los remitos nos alcanza   */
    /* el primero ya que la interfaz no permite seleccio-  */
    /* nar agrupadamente remitos de distinto origen. Con-  */
    /* sultamos el parametro dependiente del origen para   */
    /* saber si el mismo respeta precios. Si el parametro  */
    /* no existe, entonces, no se asignan los precios.     */
    /* --------------------------------------------------- */

   FIND FIRST T-Rem_header.
   RUN getparametro.p (  INPUT  "ORGREM-" + T-Rem_header.origen,
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   IF v-valor_l = ? OR v-valor_l
       THEN RUN asignar_precios ( OUTPUT lista_errores ).

   
IF lista_errores = ""
      THEN RUN emitir_comprobante_cliente.p ( 
                             INPUT TABLE T-Fac_header,
                             INPUT TABLE T-Fac_detalle,
                             INPUT TABLE T-Registrable-factura,
                             INPUT TABLE T-Sub_header_vta,
                             INPUT TABLE T-Sub_detalle_vta,
                             INPUT TABLE T-Fac_header-bon,
                             INPUT TABLE T-Fac_detalle-bon,
                             INPUT TABLE T-Fac_header_impuesto,
                             INPUT TABLE T-Fac_detalle_impuesto).

END PROCEDURE.

PROCEDURE agregar_remito_a_factura:

    FIND Rem_header WHERE Rem_header.nro_remito = T-Rem_header.nro_remito EXCLUSIVE-LOCK.

    FOR EACH Rem_detalle OF Rem_header NO-LOCK:

       FIND FIRST T-Fac_detalle OF T-Fac_header 
           WHERE T-Fac_detalle.nro_articulo = Rem_detalle.nro_articulo EXCLUSIVE-LOCK NO-ERROR.

       IF NOT AVAILABLE T-Fac_detalle OR NOT hay_varios_remitos
       THEN DO:
           T-Fac_header.ultima_linea  = T-Fac_header.ultima_linea + 1.
           CREATE T-Fac_detalle.
           BUFFER-COPY Rem_detalle TO T-Fac_detalle
                ASSIGN T-Fac_detalle.cantidad     = 0
                       T-Fac_detalle.granel       = 0
                       T-Fac_detalle.nro_entidad  = T-Fac_header.nro_entidad
                       T-Fac_detalle.nro_obra     = T-Fac_header.nro_obra
                       T-Fac_detalle.nro_factura  = T-Fac_header.nro_factura
                       T-Fac_detalle.nro_linea    = T-Fac_header.ultima_linea.

       END.

       ASSIGN T-Fac_detalle.cantidad     = T-Fac_detalle.cantidad + Rem_detalle.cantidad
              T-Fac_detalle.granel       = T-Fac_detalle.granel   + Rem_detalle.granel
              T-Fac_detalle.precio       = Rem_detalle.precio.

       FOR EACH Rem_detalle-bon OF Rem_detalle NO-LOCK:

            CREATE T-Fac_detalle-bon.
            BUFFER-COPY Rem_detalle-bon TO T-Fac_detalle-bon
                ASSIGN T-Fac_detalle-bon.importe          = 0
                       T-Fac_detalle-bon.nro_factura      = T-Fac_header.nro_factura
                       T-Fac_detalle-bon.nro_linea        = T-Fac_detalle.nro_linea.

       END.        
       /*
       CREATE Remito-factura.
       ASSIGN Remito-factura.a_granel        = Rem_detalle.a_granel
              Remito-factura.cantidad        = Rem_detalle.cantidad 
              Remito-factura.granel          = T-Fac_detalle.granel
              Remito-factura.nro_factura     = T-Fac_detalle.nro_factura
              Remito-factura.nro_linea-fac   = T-Fac_detalle.nro_linea
              Remito-factura.nro_linea-rem   = Rem_detalle.nro_linea
              Remito-factura.nro_remito      = Rem_detalle.nro_remito
              Remito-factura.precio          = T-Fac_detalle.precio.
       RELEASE Remito-factura.
       */
   END.
   
   FOR EACH Rem_header-bon OF Rem_header NO-LOCK:

       FIND FIRST T-Fac_header-bon OF T-Fac_header 
            WHERE T-Fac_header-bon.cdg_bonificacion = Rem_header-bon.cdg_bonificacion NO-ERROR.
       IF NOT AVAILABLE T-Fac_header-bon
       THEN DO:
           CREATE T-Fac_header-bon.
           BUFFER-COPY Rem_header-bon TO T-Fac_header-bon       
                ASSIGN T-Fac_header-bon.importe          = 0
                       T-Fac_header-bon.nro_factura      = T-Fac_header.nro_factura.
       
       END.

   END.

   ASSIGN Rem_header.nro_factura = T-Fac_header.nro_factura
          Rem_header.estado      = "P".

   RELEASE Rem_header.

END PROCEDURE.

PROCEDURE verificar_consistencia:

   DEFINE OUTPUT PARAMETER p-lista_errores AS CHARACTER.
   
   p-lista_errores = "".


END PROCEDURE.

PROCEDURE asignar_precios:

   DEFINE OUTPUT PARAMETER p-lista_errores AS CHARACTER.

   p-lista_errores = "".
 
   FOR EACH T-Fac_detalle OF T-Fac_header, Articulo OF T-Fac_detalle:

       FIND LAST Articulo_precio OF Articulo 
                 WHERE Articulo_precio.cdg_lista   = T-Fac_header.cdg_lista 
                   AND Articulo_precio.cdg_empresa = T-Fac_header.cdg_empresa
                   AND Articulo_precio.fch_desde  <= T-Fac_header.fecha_precios
                       NO-LOCK NO-ERROR.
/*        MESSAGE Articulo_precio.cdg_lista Articulo_precio.fch_desde VIEW-AS ALERT-BOX. /*smh*/  */
/*        MESSAGE t-fac_header.cdg_lista T-Fac_header.fecha_precios VIEW-AS ALERT-BOX.            */

/*        IF AVAILABLE Articulo_precio                                   */
/*           THEN T-Fac_detalle.precio = Articulo_precio.precio.         */
/*           ELSE IF LOOKUP("PEDI012",lista_errores) = 0                 */
/*                   THEN p-lista_errores = p-lista_errores + "PEDI012". */

   END.

END PROCEDURE.
