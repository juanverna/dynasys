/*=========================================================================================================*/
/*      DEFINICION DE FRAMES PERTINENTES A LOS PROCESOS DE GENERACION DE ASIENTOS DESDE LOS MODULOS        */
/*=========================================================================================================*/

DEFINE VARIABLE titulo_lis              AS CHARACTER FORMAT "X(40)" INITIAL "{1}".
DEFINE VARIABLE titulo_resumen          AS CHARACTER INITIAL "{2}".
DEFINE VARIABLE titulo_operativo        AS CHARACTER FORMAT "x(50)" INITIAL "    "  NO-UNDO.

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  titulo_lis AT 81 
  "Página:" AT 152 PAGE-NUMBER FORMAT ">>>9" AT 163
  SKIP  
  fecha_lis   
  titulo_det AT 81
  hora_lis AT 152
  SKIP
  "F.Ctble:" AT 81
  fecha_contable
  "Gen.:" gen_asiento  
  SKIP
  titulo_moneda AT 81
  titulo_operativo AT 81
  SKIP(1)

  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha    Asiento    Comprobante                          Código      Código               Tasa             Importe           Importe Observaciones                     " SKIP
  "           Imputación Contable                           Entidad     Obra                 Cambio           Débitos          Créditos Del Movimiento                    " SKIP
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 300 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-encabezado
  T-Asn_header.fecha         
  T-Asn_header.tip_comprob   
  T-Asn_header.nro_comprob
  T-Asn_header.estado
  T-Asn_header.leyenda
  Moneda.abrevia
  WITH WIDTH 300 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  SPACE(8)
  T-Asn_detalle.nro_linea     FORMAT  ">>>9"
  Cuenta.cdg_cuenta
  Cuenta.nombre
  Entidad.cdg_entidad
  Obra.cdg_obra
  Moneda.abrevia
  T-Asn_detalle.reexpresion FORMAT "Si/No"
  T-Asn_detalle.cambio
  T-Asn_detalle.debito        FORMAT "->,>>>,>>>,>>9.99"
  T-Asn_detalle.credito       FORMAT "->,>>>,>>>,>>9.99"
  T-Asn_detalle.leyen_detalle FORMAT "X(35)"
  WITH WIDTH 300 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=========================================================================================================*/
/*                   FUNCIONES QUE SE UTILIZAN EN LOS PROCESOS DE FORMATEO DE DATOS                        */
/*=========================================================================================================*/

{fncomprobante.i}
