/*=========================================================================================*/
/*    CALCULA EL SALDO DE CUENTA CORRIENTE DE UN GRUPO FAMILIAR A UNA FECHA DADA           */
/*=========================================================================================*/
/*
    RUN ver_saldo_grupo.p ( INPUT Grupofam.cdg_grupofam,
                            INPUT Rec_header.fecha,
                            OUTPUT saldo_cc_anterior ).
*/

DEFINE INPUT PARAMETER  p-que_grupo LIKE Grupofam.cdg_grupofam.
DEFINE INPUT PARAMETER  p-que_fecha LIKE Rec_header.fecha.
DEFINE OUTPUT PARAMETER p-saldo     AS DECIMAL.






