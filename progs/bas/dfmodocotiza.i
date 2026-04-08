/* ======================================================================================= */
/*                                                                                         */
/*    DEFINE LA FORMA EN LA QUE DEBE CONSIDERARSE LA RELACION DE CAMBIO. SI LA VARIABLE SE */
/*    ENCUENTRA EN "DIVIDIR", LAS COTIZACIONES CARGADAS EN EL SISTEMA SE TOMAN COMO EL     */
/*    VALOR POR EL QUE HAY QUE DIVIDIR UN IMPORTE EN UNA MONEDA PARA EXPRESARLO EN LA      */
/*    MONEDA DE REFERENCIA. EN CASO CONTRARIO SE DEBE MULTIPLICAR EL IMPORTE. EL SIGUIENTE */
/*    CUADRO MUESTRA LOS VALORES DE LA TABLA DE COTIZACIONES PARA LAS CUATRO POSIBLES      */
/*    CONBINACIONES DE VARIABLE Y DEFINICIONES DE MONEDA DE REFERENCIA TOMANDO SOLAMENTE   */
/*    EL DOLAR Y EL PESO, SUPONIENDO UN VALOR PIZARRA DEL DOLAR DE 2.5.                    */
/*                                                                                         */
/*                             MONEDA DE REFERENCIA                                        */
/*                             PESO            DOLAR                                       */
/*                                                                                         */
/*           MULTIPLICAR       1.000           2.500                                       */
/*                                                                                         */
/*           DIVIDIR           1.000           0.400                                       */
/*                                                                                         */
/*                                                                                         */
/*    EN EL PRIMER CASO, PARA DOS MONEDAS CUALESQUIERA, SIEMPRE SE CUMPLE QUE:             */ 
/*                                                                                         */
/*      importe_moneda_uno * cambio_moneda_uno = importe_moneda_dos * cambio_moneda_dos    */
/*                                                                                         */
/*    EN EL SEGUNDO CASO SIEMPRE SE CUMPLE QUE:                                            */ 
/*                                                                                         */
/*      importe_moneda_uno     importe_moneda_dos                                          */
/*      ------------------  =  ------------------                                          */
/*      cambio_moneda_uno      cambio_moneda_dos                                           */
/*                                                                                         */
/*                                                                                         */
/* ======================================================================================= */
                                                                                           
DEFINE VARIABLE v-modo_cotiza      AS CHARACTER.
DEFINE VARIABLE v-dividir          AS CHARACTER INITIAL "DIVIDIR".
DEFINE VARIABLE v-multiplicar      AS CHARACTER INITIAL "MULTIPLICAR".
    
