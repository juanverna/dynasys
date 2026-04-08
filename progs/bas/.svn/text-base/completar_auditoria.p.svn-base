/*=================================================================================================*/
/*                     COMPLETA LOS DATOS DE AUDITORÍA DE TRANSACCIONES                            */
/*=================================================================================================*/

 DEFINE OUTPUT PARAMETER p-nro_usuario LIKE Usuario.nro_usuario.
 DEFINE OUTPUT PARAMETER p-fecha_grab  AS DATE.
 DEFINE OUTPUT PARAMETER p-hora_grab   AS INTEGER.
 DEFINE OUTPUT PARAMETER p-pc_name     AS CHARACTER.

/*=================================================================================================*/
/*                                 BLOQUE PRINCIPAL                                                */
/*=================================================================================================*/

 {findempresa.i}
 p-nro_usuario = Usuario.nro_usuario.
 RUN pcname1.p ( OUTPUT p-pc_name ).

 ASSIGN p-fecha_grab      = TODAY
        p-hora_grab       = TIME.


