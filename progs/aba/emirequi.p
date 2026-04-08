/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_requisicion AS ROWID.

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE saldo_remito        AS DECIMAL.
DEFINE VARIABLE aux_nro_vencimiento AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

DEFINE VARIABLE que_rutina          AS CHARACTER.
DEFINE BUFFER B-Rqs_detalle FOR Rqs_detalle.

DEFINE SHARED TEMP-TABLE T-Rqs_header LIKE Rqs_header.

/*=================================================================================*/
/*     RECUPERACION DEL COMPROBANTE Y CREACION DEL PRIMER REGISTRO HISTORICO       */
/*=================================================================================*/

FIND FIRST T-Rqs_header.

T-Rqs_header.cdg_estado = "IN".

FOR EACH Rqs_detalle OF T-Rqs_header EXCLUSIVE-LOCK:

    Rqs_detalle.cdg_estado = "IN".

    CREATE Hst_requisicion.
    ASSIGN Hst_requisicion.cdg_estado         = "IN"
           Hst_requisicion.fch_cambio         = TODAY
           Hst_requisicion.hor_cambio         = TIME
           Hst_requisicion.hms_cambio         = STRING(Hst_requisicion.hor_cambio,"HH:MM:SS")
           Hst_requisicion.nro_linea          = Rqs_detalle.nro_linea
           Hst_requisicion.nro_requisicion    = Rqs_detalle.nro_requisicion
           Hst_requisicion.nro_usuario        = T-Rqs_header.nro_usuario.
END.

/*=================================================================================*/
/*                           IMPRESION DEL COMPROBANTE                             */
/*=================================================================================*/

   RUN getparametro.p (  INPUT  "NCOPIARQ",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).
   ncopias = v-valor_n.

   RUN getparametro.p (  INPUT  "NFREQUIS",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   que_rutina = "PRRQS" + STRING(v-valor_n, "999") + ".P".

   RUN getparametro.p (  INPUT  "FACTHOJA",
                         OUTPUT v-valor_c,
                         OUTPUT v-valor_d,
                         OUTPUT v-valor_l,
                         OUTPUT v-valor_n,
                         OUTPUT v-observacion ).

   DO j = 1 TO ncopias:
      IF v-valor_l
      THEN DO:
         MESSAGE "Por Favor, coloque formulario en la impresora para"
                 + " imprimir copia de Requisici¢n Nro.:" + STRING(j,"9")
                 VIEW-AS ALERT-BOX MESSAGE TITLE "Pausa de impresi¢n".
      END.
      RUN VALUE(que_rutina) (INPUT ROWID(T-Rqs_header)).
   END.

