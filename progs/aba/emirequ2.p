/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE INPUT PARAMETER que-rqs    AS ROWID.

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rqs_detalle FOR Rqs_detalle.


/*=================================================================================*/
/*     RECUPERACION DEL COMPROBANTE Y CREACION DEL PRIMER REGISTRO HISTORICO       */
/*=================================================================================*/

FIND FIRST Rqs_header WHERE ROWID(Rqs_header) = que-rqs.

Rqs_header.cdg_estado = "IN".

FOR EACH Rqs_detalle OF Rqs_header EXCLUSIVE-LOCK:

    Rqs_detalle.cdg_estado = "IN".

    CREATE Hst_requisicion.
    ASSIGN Hst_requisicion.cdg_estado         = "IN"
           Hst_requisicion.fch_cambio         = TODAY
           Hst_requisicion.hor_cambio         = TIME
           Hst_requisicion.hms_cambio         = STRING(Hst_requisicion.hor_cambio,"HH:MM:SS")
           Hst_requisicion.nro_linea          = Rqs_detalle.nro_linea
           Hst_requisicion.nro_requisicion    = Rqs_detalle.nro_requisicion
           Hst_requisicion.nro_usuario        = Rqs_header.nro_usuario.
END.

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

FIND Parametro "NCOPIARQ" NO-LOCK NO-ERROR.
ncopias = Parametro.valor_n.

FIND Parametro "NFREQUIS" NO-LOCK NO-ERROR.
que_rutina = "PRRQS" + STRING(Parametro.valor_n, "999") + ".P".

FIND Parametro "FACTHOJA" NO-LOCK NO-ERROR.
DO j = 1 TO ncopias:
   IF Parametro.valor_l
   THEN DO:
      MESSAGE "Por Favor, coloque formulario en la impresora para"
              + " imprimir copia de Requisici¢n Nro.:" + STRING(j,"9")
              VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresi¢n".
   END.
   RUN VALUE(que_rutina) (INPUT ROWID(Rqs_header)).
END.

