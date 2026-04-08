/*=================================================================================*/
/*       REGISTRA EL CAMBIO DE ESTADO DE UNA RENDICION DE GASTOS                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-nro_rendgastos LIKE Rendgastos_hd.nro_rendgastos.
DEFINE INPUT PARAMETER p-cdg_estado     LIKE Rendgastos_hd.cdg_estado.
DEFINE INPUT PARAMETER p-observacion    AS CHARACTER.

{findempresa.i}

DO TRANSACTION:
    CREATE Hst_rendgastos.
    ASSIGN Hst_rendgastos.cdg_estado         = p-cdg_estado
           Hst_rendgastos.fch_cambio         = TODAY
           Hst_rendgastos.hor_cambio         = TIME
           Hst_rendgastos.hms_cambio         = STRING(Hst_rendgastos.hor_cambio,"HH:MM:SS")
           Hst_rendgastos.nro_rendgastos     = p-nro_rendgastos
           Hst_rendgastos.nro_usuario        = Usuario.nro_usuario
           Hst_rendgastos.observacion        = p-observacion.

    RUN pcname1.p ( OUTPUT Hst_rendgastos.pc_name ).
END.
