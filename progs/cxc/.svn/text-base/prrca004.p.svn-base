/*=================================================================================*/
/*                           IMPRESION DE RECIBOS DE PAGO                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{valoresrecibo.I}

DEFINE VARIABLE subtotal    AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE a_confirmar AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE tit_detalle AS CHARACTER.
DEFINE VARIABLE ry1         AS CHARACTER.
DEFINE VARIABLE ry2         AS CHARACTER.
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 8.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE n_hoja      AS INTEGER INITIAL 1.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE v-bruto     LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-desc      LIKE Rec_header.imp_neto.
DEFINE VARIABLE v-valores   LIKE Rec_header.imp_neto.
DEFINE VARIABLE prciva      LIKE Impuesto.tasa.
DEFINE VARIABLE prcnoi      LIKE Impuesto.tasa.
DEFINE VARIABLE importe_iva LIKE Sub_detalle_prv.valor.
DEFINE VARIABLE importe_noi LIKE Sub_detalle_prv.valor.
DEFINE VARIABLE dtl_rubro   AS CHARACTER.
DEFINE VARIABLE salida      AS CHARACTER.

DEFINE QUERY qry_aplicacion FOR Rec_detalle,Cta_cte.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FORM
    "Establecimientos San Ignacio S.A."
    "RECIBO DE PAGO:"  TO 70
    Rec_header.nro_comprob AT 71
    a_confirmar
    SKIP
    "Ruta Nacional 11 Km. 447 - TE 0342 4950900"
    "Fecha:" TO 70
    Rec_header.fecha       AT 71
    SKIP
    "(3017) Sauce Viejo - Pcia. de Santa Fe" 
    "Hoja:" TO 70
    n_hoja FORMAT "9" AT 71
    SKIP
    "====================================================================================="
    SKIP
    "NOMBRE: ["
    Cliente.cdg_cliente
    "]"
    Cliente.nom_cliente
    SKIP
    "====================================================================================="
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    "                        APLICACION DE PAGO                                            VALORES ENTREGADOS"
    SKIP
    ry1 FORMAT "X(147)"
    SKIP
    tit_detalle FORMAT "X(147)"
    SKIP
    ry2 FORMAT "X(147)"
    SKIP
    WITH FRAME frm-titulos NO-LABELS USE-TEXT STREAM-IO WIDTH 160.

FORM
    Rec_header.leyenda VIEW-AS FILL-IN SIZE 150 BY 1 AT 5
    SKIP(2)
    Usuario.nombre 
    SKIP    
    "------------------------               -----------------------------              ----------------------            -------------------" SKIP
    "     Confecciono                                 Autorizo                              Por Tesoreria                  Recibio Conforme"
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    Cta_cte.tip_comprob
    Cta_cte.prf_comprob
    Cta_cte.nro_comprob
    Cta_cte.nro_vencimiento
    Cta_cte.fecha_vencimiento
    Cta_cte.debito
    Rec_detalle.importe
    blancos FORMAT "X(4)"
    Rubro.abrevia
    dtl_rubro FORMAT "X(55)"
    SPACE(5)
    Caj_detalle.importe
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 160 NO-LABELS.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/
/*
FIND Parametro "CLIOBSOP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN cliobsdc = Parametro.valor_n.

FIND Parametro "CCOOBSOP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN ccoobsdc = Parametro.valor_n.

Rec_header.leyenda:WIDTH = ccoobsdc.
Rec_header.leyenda:HEIGHT = cliobsdc.
*/

FIND Rec_header WHERE ROWID(Rec_header) = act_recibo EXCLUSIVE-LOCK.
FIND Condicion_impos   OF Rec_header NO-LOCK.
/*FIND Provincia OF Rec_header NO-LOCK.*/
FIND Cliente OF Rec_header NO-LOCK.
FIND FIRST Domicilio OF Cliente NO-LOCK.

FIND Usuario OF Rec_header NO-LOCK.

FIND Impuesto 1 NO-LOCK.
prciva = Impuesto.tasa.

ASSIGN
    v-desc  = 0
    v-bruto = 0
    v-valores = 0
    ry1 = FILL("-",145)
    ry2 = FILL("-",145)
    tit_detalle = "   DOCUMENTO            VENCE        IMPORTE        PAGO      CONCEPTO                                                                   IMPORTE".

/*OUTPUT TO PRINTER PAGE-SIZE 36.*/
salida = "c:\sic-temp\recibo.txt".

OUTPUT TO VALUE(salida).

PUT CONTROL CHR(18).
PUT CONTROL "~033C$".
PUT CONTROL CHR(27) + CHR(67) + CHR(0) + CHR(36). /* Hoja de 6 pulgadas */

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

IF Rec_header.estado <> rec_recibo_en_firme THEN a_confirmar = "Orden a confirmar".
                                             ELSE a_confirmar = "".


DISPLAY
    Rec_header.nro_comprob                        
    a_confirmar
    Rec_header.fecha
    n_hoja
    Cliente.nom_cliente
    Cliente.cdg_Cliente
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

PUT CONTROL CHR(15).

DISPLAY
    ry1
    tit_detalle
    ry2
    WITH FRAME frm-titulos.

linea0 = LINE-COUNTER.

FIND Caj_header
     WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK.

OPEN QUERY qry_aplicacion
     FOR EACH Rec_detalle OF Rec_header,
          FIRST Cta_cte WHERE Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                              AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                              AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                              AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.
GET FIRST qry_aplicacion NO-LOCK.

DO WHILE AVAILABLE Rec_detalle OR AVAILABLE Caj_detalle:

  IF AVAILABLE Caj_detalle
  THEN DO:
     v-valores = v-valores + Caj_detalle.importe.
     FIND Rubro OF Caj_detalle NO-LOCK.
     RUN dtlmovcaja.p ( INPUT ROWID(Caj_detalle), OUTPUT dtl_rubro ).
  END.

  IF AVAILABLE Rec_detalle
  THEN DO:
     v-bruto = v-bruto + Rec_detalle.importe.
     v-desc  = v-desc  + Rec_detalle.descuento.
  END.

  DISPLAY  Cta_cte.tip_comprob        WHEN AVAILABLE Rec_detalle
           Cta_cte.prf_comprob        WHEN AVAILABLE Rec_detalle
           Cta_cte.nro_comprob        WHEN AVAILABLE Rec_detalle
           Cta_cte.nro_vencimiento    WHEN AVAILABLE Rec_detalle
           Cta_cte.fecha_vencimiento  WHEN AVAILABLE Rec_detalle
           Cta_cte.debito             WHEN AVAILABLE Rec_detalle
           Rec_detalle.importe            WHEN AVAILABLE Rec_detalle
           Caj_detalle.importe            WHEN AVAILABLE Caj_detalle
           Rubro.abrevia                  WHEN AVAILABLE Caj_detalle
           dtl_rubro                      WHEN AVAILABLE Caj_detalle
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  DOWN WITH FRAME frm-detalle.

  IF LINE-COUNTER = 25
  THEN DO:
        UNDERLINE  Cta_cte.tip_comprob
                   Cta_cte.prf_comprob
                   Cta_cte.nro_comprob
                   Cta_cte.nro_vencimiento
                   Cta_cte.fecha_vencimiento
                   Rec_detalle.importe
                   Cta_cte.debito
                   Rubro.abrevia
                   blancos
                   Caj_detalle.importe
                   dtl_rubro
                   WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

        DISPLAY
            "Continua en pagina siguiente" @ Rec_header.leyenda
            WITH FRAME frm-pie.

        PAGE.

        PUT CONTROL CHR(18).
        PUT CONTROL "~033C$".
        
        IF Rec_header.estado <> rec_recibo_en_firme THEN a_confirmar = "Orden a confirmar".
                                                    ELSE a_confirmar = "".
        
        n_hoja = n_hoja + 1.
        DISPLAY
            Rec_header.nro_comprob
            a_confirmar
            Rec_header.fecha
            n_hoja
            Cliente.nom_cliente
            Cliente.cdg_Cliente
            WITH FRAME frm-encabezado.
        
        PUT CONTROL CHR(15).
        
        DISPLAY
            ry1
            tit_detalle
            ry2
            WITH FRAME frm-titulos.

  END.
  
  GET NEXT qry_valores    NO-LOCK.
  GET NEXT qry_aplicacion NO-LOCK.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

UNDERLINE  Cta_cte.tip_comprob
           Cta_cte.prf_comprob
           Cta_cte.nro_comprob
           Cta_cte.nro_vencimiento
           Cta_cte.fecha_vencimiento
           Rec_detalle.importe
           Cta_cte.debito
           Rubro.abrevia
           blancos
           Caj_detalle.importe
           dtl_rubro
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

DISPLAY  Rec_header.imp_total  @ Rec_detalle.importe
         Caj_header.importe    @ Caj_detalle.importe
         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/


DISPLAY
    Rec_header.leyenda
    Usuario.nombre
    WITH FRAME frm-pie.

/*
FOR EACH X_Calculo OF Rec_header NO-LOCK:

    DISPLAY X_Calculo.concepto X_Calculo.importe
            WITH FRAME dd NO-LABEL DOWN USE-TEXT.
    DOWN WITH FRAME dd.
    
END.            
*/

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.

RUN veresult.w ( INPUT salida, INPUT 22).
