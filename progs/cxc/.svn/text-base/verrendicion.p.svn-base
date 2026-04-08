/*==========================================================================================*/
/*       DADA UNA RENDICION DE COBRANZA, MUESTRA EL MOVIMIENTO DE TESORERÍA ASOCIADO        */
/*==========================================================================================*/

DEFINE INPUT PARAMETER p-nro_rendicion LIKE Rendicion_hd.nro_rendicion.

DEFINE TEMP-TABLE T-Caj_header       LIKE Caj_header      .
DEFINE TEMP-TABLE T-Caj_detalle      LIKE Caj_detalle     .
DEFINE TEMP-TABLE T-Caja-imputacion  LIKE Caja-imputacion .
DEFINE TEMP-TABLE T-Cheque           LIKE Cheque          .
DEFINE TEMP-TABLE T-Valor            LIKE Valor           .

FIND Rendicion_hd WHERE Rendicion_hd.nro_rendicion = p-nro_rendicion NO-LOCK.

RUN traer_movimiento_caja.p ( INPUT Rendicion_hd.nro_transaccion,
                              OUTPUT TABLE T-Caj_header,
                              OUTPUT TABLE T-Caj_detalle,
                              OUTPUT TABLE T-Caja-imputacion,
                              OUTPUT TABLE T-Cheque,
                              OUTPUT TABLE T-Valor).    
    
    
RUN d-valores_movimiento.w ( INPUT-OUTPUT TABLE T-Caj_header,
                             INPUT-OUTPUT TABLE T-Caj_detalle,
                             INPUT-OUTPUT TABLE T-Caja-imputacion,
                             INPUT-OUTPUT TABLE T-Cheque,
                             INPUT-OUTPUT TABLE T-Valor,
                             INPUT 2).
