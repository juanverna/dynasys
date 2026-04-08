/*====================================================================================*/
/*                        ESTADISTICAS POR VENTAS                                     */
/*                  Ranking de Clientes sin detalle de articulos                      */
/*====================================================================================*/

DEFINE INPUT PARAMETER des_codigo  LIKE Cliente.cdg_cliente.
DEFINE INPUT PARAMETER has_codigo  LIKE Cliente.cdg_cliente.

DEFINE INPUT PARAMETER des_fecha   AS DATE LABEL "Desde Fecha".
DEFINE INPUT PARAMETER has_fecha   AS DATE LABEL "Hasta Fecha" INITIAL TODAY.

DEFINE INPUT PARAMETER p-cdg_moneda     AS CHARACTER.
DEFINE INPUT PARAMETER p-ver_cotizacion AS INTEGER.
DEFINE INPUT PARAMETER p-fecha          AS DATE.
DEFINE INPUT PARAMETER p-empresa      LIKE empresa.cdg_empresa NO-UNDO.
DEFINE OUTPUT PARAMETER xfile AS CHAR NO-UNDO.
/*====================================================================================*/
/*                  VARIABLES, FRAMES Y TABLAS TEMPORALES                             */
/*====================================================================================*/

DEFINE VARIABLE v-cod_mon      AS CHARACTER.
DEFINE VARIABLE X-IMPORTE      AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE X-FEC_COTIZA   AS DATE.
DEFINE VARIABLE X-FEC_COTIZAR   AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE v-fecha_cotiza AS DATE.    
DEFINE VARIABLE v-desc_mon AS CHARACTER FORMAT "X(20)".


DEFINE VARIABLE signo     AS INTEGER.

DEFINE TEMP-TABLE Rank_cliente
   FIELD nro_cliente         LIKE Cliente.nro_cliente
   FIELD nom_cliente         LIKE cliente.nom_cliente
   FIELD direccion           LIKE cliente.direccion
   FIELD importe             LIKE Fac_detalle.subtotal_neto
   INDEX por_cliente         IS PRIMARY nro_cliente ASCENDING
   INDEX por_importe importe DESCENDING.

DEFINE TEMP-TABLE Parametros NO-UNDO
    FIELD des_cliente  LIKE Cliente.cdg_cliente
    FIELD has_cliente  LIKE Cliente.cdg_cliente
    FIELD des_fecha   AS DATE LABEL "Desde Fecha"
    FIELD has_fecha   AS DATE LABEL "Hasta Fecha" 
    FIELD cdg_moneda     AS CHARACTER
    FIELD moneda LIKE moneda.descripcion
    FIELD ver_cotizacion LIKE p-ver_cotizacion
    FIELD p-fecha          AS DATE
    FIELD empresa      LIKE empresa.nombre.
    
DEFINE DATASET dset FOR parametros, rank_cliente.


/*=================================================================================*/
/*                                BLOQUE PRINCIAPL                                 */
/*=================================================================================*/
FIND empresa WHERE empresa.cdg_empresa = p-empresa NO-LOCK.
FIND moneda WHERE moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
CREATE parametros.
        assign parametros.des_cliente = des_codigo
               parametros.has_cliente = has_codigo
               parametros.cdg_moneda = p-cdg_moneda
               parametros.moneda = moneda.descripcion
               parametros.des_fecha = des_fecha
               parametros.has_fecha = has_fecha
               parametros.p-fecha = p-fecha
               parametros.ver_cotizacion = p-ver_cotizacion
               parametros.empresa = empresa.nombre.
RELEASE parametros.

  FOR EACH Fac_header
         WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa 
           AND Fac_header.fecha <= has_fecha
           AND Fac_header.fecha >= des_fecha
           AND NOT Fac_header.anulado,
      FIRST Cliente OF Fac_header 
          WHERE Cliente.cdg_cliente >= des_codigo
            AND Cliente.cdg_cliente <= has_codigo,
      FIRST Tipocomprobante OF Fac_header,
      FIRST Imputacion OF Fac_header:
                     
      FIND FIRST Rank_cliente WHERE Rank_cliente.nro_cliente = Cliente.nro_cliente NO-ERROR.
      IF NOT AVAILABLE Rank_cliente
      THEN DO:
          CREATE Rank_cliente.
          ASSIGN Rank_cliente.nro_cliente = Cliente.nro_cliente
                 Rank_cliente.nom_cliente = Cliente.nom_cliente
                 .
      END.

   IF Tipocomprobante.debita
          THEN signo = 1.
          ELSE signo = -1.

            FIND LAST moneda WHERE moneda.nro_moneda = Fac_header.nro_moneda NO-LOCK NO-ERROR. 
            IF AVAILABLE moneda THEN v-cod_mon = moneda.cdg_moneda.                            
            FIND LAST moneda WHERE moneda.cdg_moneda = p-cdg_moneda NO-LOCK NO-ERROR.
            IF AVAILABLE moneda THEN  ASSIGN v-desc_mon = moneda.descripcion.
            
            IF p-ver_cotizacion = 1 THEN
               v-fecha_cotiza = p-fecha.     

            ELSE
                ASSIGN v-fecha_cotiza = Fac_header.fecha
                     X-FEC_COTIZAR = 'Correspondiente a cada Transacción'.

            RUN reexpresar_importe.p ( INPUT v-cod_mon, INPUT p-cdg_moneda, INPUT v-fecha_cotiza, INPUT Fac_header.imp_total, OUTPUT X-IMPORTE, OUTPUT X-FEC_COTIZA ).

            IF p-ver_cotizacion = 1 THEN
            X-FEC_COTIZAR= string(X-FEC_COTIZA,"99-99-9999").


      Rank_cliente.importe = Rank_cliente.importe + signo *  X-IMPORTE.

  END. 
/*grabacion XML*/
xfile = SUBST('&1/cr-' + userid("sic") + ".xml" , SESSION:TEMP-DIRECTORY).
xfile = REPLACE(xfile,"/","\").
DATASET dset:WRITE-XML ("FILE", xfile, FALSE,
                                     ?,"",YES,YES).
                                    
/*A fin de tener las definiciones solamente grabo la estructura y con eso desarrollo el reporte*/

/*dataset dset:WRITE-XMLSCHEMA("FILE",replace( SUBST('&1/cr-ventastotalxcliente.xsd', SESSION:TEMP-DIRECTORY),"/","\"),
                                     yes,?,no). */





