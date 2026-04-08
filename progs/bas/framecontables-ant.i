/*=========================================================================================================*/
/*      DEFINICION DE FRAMES PERTINENTES A LOS PROCESOS DE GENERACION DE ASIENTOS DESDE LOS MODULOS        */
/*=========================================================================================================*/

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "{1}" AT 61 
  "Página:" AT 130 PAGE-NUMBER FORMAT ">>>9" AT 137
  SKIP  
  fecha_lis   
  titulo_det AT 61
  hora_lis AT 130
  SKIP
  "F.Ctble:" AT 61
  fecha_contable
  "Gen.:" gen_asiento  
  SKIP
  titulo_moneda AT 61
  SKIP(1)
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha    Asiento    Comprobante                          Código      Código               Tasa             Importe           Importe Observaciones                     " SKIP
  "           Imputación Contable                           Entidad     Obra                 Cambio           Débitos          Créditos Del Movimiento                    " SKIP
  "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)

  WITH WIDTH 232 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-titulo-res HEADER
  que_empresa
  "{2}" AT 43 
  "Página:" AT 107 PAGE-NUMBER FORMAT ">>>9" AT 116
  SKIP  
  fecha_lis   
  titulo_det AT 43
  hora_lis AT 107
  SKIP
  "Fecha Contable:" AT 43
  fecha_contable
  " Gen.:" gen_asiento
  SKIP
  titulo_moneda AT 43
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------" SKIP
  "Código   Descripción                         Código     Código       Débitos      Créditos       Débitos      Créditos" SKIP
  "Cuenta   Cuenta Contable                     Entidad    Obra         Totales       Totales    Pendientes    Pendientes" SKIP
  "----------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 232 FRAME frm-titulo-res TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-encabezado
  T-Asn_header.fecha         
  T-Asn_header.tip_comprob   
  T-Asn_header.nro_comprob
  T-Asn_header.estado
  T-Asn_header.leyenda
  Moneda.abrevia
  WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  SPACE(8)
  T-Asn_detalle.nro_linea
  /*
  T-Asn_detalle.nro_cuenta
  T-Asn_detalle.nro_entidad
  */

  Cuenta.cdg_cuenta
  Cuenta.nombre
  Entidad.cdg_entidad
  Obra.cdg_obra
  Moneda.abrevia
  /*
  T-Asn_detalle.reexpresion FORMAT "Si/No"
  */
  T-Asn_detalle.cambio
  T-Asn_detalle.debito
  T-Asn_detalle.credito
  T-Asn_detalle.leyen_detalle FORMAT "X(35)"
  WITH WIDTH 260 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento-res
  Cuenta.cdg_cuenta
  Cuenta.nombre
  Entidad.cdg_entidad
  Obra.cdg_obra
  lst_d_tot
  lst_c_tot
  lst_d_pen
  lst_c_pen
  WITH WIDTH 132 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.
