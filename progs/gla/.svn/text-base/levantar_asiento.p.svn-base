/*==================================================================================================================*/
/*                            INTERFACE PARA LEVANTAR ASIENTOS EXTERNOS                                             */
/*==================================================================================================================*/

DEFINE INPUT PARAMETER p-archivo AS CHARACTER.

/*==================================================================================================================*/
/*                                              VARIABLES                                                           */
/*==================================================================================================================*/


DEFINE VARIABLE v-anulado           LIKE Asn_header.anulado. 
DEFINE VARIABLE v-cambio            LIKE Asn_header.cambio. 
DEFINE VARIABLE v-cambio_dolar      LIKE Asn_header.cambio_dolar. 
DEFINE VARIABLE v-cdg_empresa       LIKE Asn_header.cdg_empresa. 
DEFINE VARIABLE v-estadoasiento     LIKE Asn_header.cdg_estadoasiento. 
DEFINE VARIABLE v-cdg_librocontable LIKE Asn_header.cdg_librocontable. 
DEFINE VARIABLE v-cdg_sigla-sic     LIKE Asn_header.cdg_sigla-sic. 
DEFINE VARIABLE v-estado            LIKE Asn_header.estado. 
DEFINE VARIABLE v-fecha             LIKE Asn_header.fecha. 
DEFINE VARIABLE v-fecha_grab        LIKE Asn_header.fecha_grab. 
DEFINE VARIABLE v-hora_grab         LIKE Asn_header.hora_grab. 
DEFINE VARIABLE v-leyenda           LIKE Asn_header.leyenda. 
DEFINE VARIABLE v-nro_asiento       LIKE Asn_header.nro_asiento. 
DEFINE VARIABLE v-nro_comprob       LIKE Asn_header.nro_comprob. 
DEFINE VARIABLE v-nro_entidad       LIKE Asn_header.nro_entidad. 
DEFINE VARIABLE v-nro_idcabecera    LIKE Asn_header.nro_idcabecera. 
DEFINE VARIABLE v-nro_moneda        LIKE Asn_header.nro_moneda. 
DEFINE VARIABLE v-nro_secuencia     LIKE Asn_header.nro_secuencia. 
DEFINE VARIABLE v-nro_usuario       LIKE Asn_header.nro_usuario. 
DEFINE VARIABLE v-num_sucursal      LIKE Asn_header.num_sucursal. 
DEFINE VARIABLE v-observacion       LIKE Asn_header.observacion. 
DEFINE VARIABLE v-origen            LIKE Asn_header.origen. 
DEFINE VARIABLE v-pc_name           LIKE Asn_header.pc_name. 
DEFINE VARIABLE v-posteo            LIKE Asn_header.posteo. 
DEFINE VARIABLE v-presupuestado     LIKE Asn_header.presupuestado. 
DEFINE VARIABLE v-prf_comprob       LIKE Asn_header.prf_comprob. 
DEFINE VARIABLE v-reexpresa_saldos  LIKE Asn_header.reexpresa_saldos. 
DEFINE VARIABLE v-tabla_comprobante LIKE Asn_header.tabla_comprobante. 
DEFINE VARIABLE v-tip_comprob       LIKE Asn_header.tip_comprob. 
DEFINE VARIABLE v-ultima_linea      LIKE Asn_header.ultima_linea.


DEFINE TEMP-TABLE T-Asn_header  LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle LIKE Asn_detalle.


DEFINE STREAM Asientos.

/*==================================================================================================================*/
/*                                              VARIABLES                                                           */
/*==================================================================================================================*/

INPUT STREAM Asientos FROM VALUE(p-archivo).
