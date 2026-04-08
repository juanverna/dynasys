/*=================================================================================*/
/*                           IMPRESION DE ORDENES DE PAGO                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

/*
{VRSHARED.I}
{VPERSINM.I}
*/
{valoresrecibo.I}

DEFINE VARIABLE subtotal    AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE a_confirmar AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE tit_detalle AS CHARACTER.
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 13.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE jlinea      AS INTEGER.
DEFINE VARIABLE n_hoja      AS INTEGER INITIAL 1.
DEFINE VARIABLE t_hoja      AS INTEGER INITIAL 1.
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

DEFINE QUERY qry_aplicacion FOR Rec_detalle,Cta_cte.
DEFINE QUERY qry_valores    FOR Caj_detalle.

FUNCTION nomcampo RETURNS CHARACTER (INPUT prefijo AS CHARACTER, INPUT k AS INTEGER).
    RETURN prefijo + STRING(k,"99"). 
END FUNCTION.   

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

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
    v-valores = 0.

OUTPUT TO "../prl/rca146.txt".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

IF Rec_header.estado <> rec_recibo_en_firme THEN a_confirmar = "Orden a confirmar".
                                            ELSE a_confirmar = "".

PUT "H01," + STRING(Rec_header.nro_comprob,"999999") FORMAT "X(10)" SKIP.
PUT "H02," + STRING(Rec_header.fecha,"99/99/9999") FORMAT "X(14)" SKIP.
PUT "H03," + STRING(n_hoja,"99") FORMAT "X(06)" SKIP.
PUT "H05," + "(" + Cliente.cdg_cliente + ") " + Cliente.nom_cliente FORMAT "X(50)" SKIP.
PUT "H06," + a_confirmar FORMAT "X(20)" SKIP.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

FIND Caj_header
     WHERE Caj_header.nro_transaccion = Rec_header.nro_transaccion NO-LOCK.

OPEN QUERY qry_aplicacion
     FOR EACH Rec_detalle OF Rec_header,
          FIRST Cta_cte WHERE Cta_cte.cdg_empresa = Rec_header.cdg_empresa
                              AND Cta_cte.tip_comprob = Rec_detalle.tip_cancela
                              AND Cta_cte.prf_comprob = Rec_detalle.prf_cancela
                              AND Cta_cte.nro_comprob = Rec_detalle.nro_cancela
                              AND Cta_cte.nro_vencimiento = Rec_detalle.nro_vencimiento
                              AND Cta_cte.nro_cliente   = Cliente.nro_cliente.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.
GET FIRST qry_aplicacion NO-LOCK.

linea0 = 1.
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

  IF AVAILABLE Rec_detalle
  THEN DO:
  
        PUT nomcampo( INPUT "DO", INPUT linea0 ) + ","
                    Cta_cte.tip_comprob + " " + 
                    STRING(Cta_cte.prf_comprob,"9999") + " " +
                    STRING(Cta_cte.nro_comprob,"99999999") + "   " +
                    STRING(Cta_cte.fecha_vencimiento,"99/99/99") FORMAT "X(34)" SKIP.

        PUT nomcampo( INPUT "IM", INPUT linea0 ) + ","
                    STRING(Cta_cte.credito,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

        PUT nomcampo( INPUT "CA", INPUT linea0 ) + ","
                    STRING(Rec_detalle.importe,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
                     
  END.
  ELSE DO:
        PUT nomcampo( INPUT "DO", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
        PUT nomcampo( INPUT "IM", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
        PUT nomcampo( INPUT "CA", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
  END.

  IF AVAILABLE Caj_detalle
  THEN DO:
  
        PUT nomcampo( INPUT "CO", INPUT linea0 ) + "," + 
                     Rubro.abrevia FORMAT "X(12)" SKIP.

        PUT nomcampo( INPUT "DE", INPUT linea0 ) + "," + 
                     dtl_rubro FORMAT "X(55)" SKIP.

        PUT nomcampo( INPUT "CJ", INPUT linea0 ) + "," 
                     STRING(Caj_detalle.importe,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
                     
  END.
  ELSE DO:
        PUT nomcampo( INPUT "CO", INPUT linea0 ) + "," FORMAT "X(12)" SKIP.
        PUT nomcampo( INPUT "DE", INPUT linea0 ) + "," FORMAT "X(55)" SKIP.
        PUT nomcampo( INPUT "CJ", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
  END.

  IF linea0 = nmax_det
  THEN DO:
        PUT "F01," FORMAT "X(18)" SKIP.
        PUT "F02," FORMAT "X(18)" SKIP.
        PUT "F03,Continua en hoja Nro. " +  STRING(n_hoja + 1,"99") FORMAT "X(40)" SKIP.
        PUT "F04," + Usuario.nombre FORMAT "X(25)" SKIP.
        PUT "!PAGE!" SKIP.
        OUTPUT CLOSE.
        OS-COMMAND SILENT ".\prl\proform .\prl\ordpago.prn < .\prl\propg005.txt > .\prl\propg005.lst".
        OS-COMMAND SILENT "copy .\prl\propg005.lst prn /b".

        linea0 = 0.
        n_hoja = n_hoja + 1.

        OUTPUT TO "./prl/propg005.txt".
        PUT "H01," + STRING(Rec_header.nro_comprob,"999999") FORMAT "X(10)" SKIP.
        PUT "H02," + STRING(Rec_header.fecha,"99/99/9999") FORMAT "X(14)" SKIP.
        PUT "H03," + STRING(n_hoja,"99") FORMAT "X(06)" SKIP.
        PUT "H05," + "(" + Cliente.cdg_cliente + ") " + Cliente.nom_cliente FORMAT "X(50)" SKIP.
        PUT "H06," + a_confirmar FORMAT "X(20)" SKIP.
  END.
  
  GET NEXT qry_valores    NO-LOCK.
  GET NEXT qry_aplicacion NO-LOCK.
  linea0 = linea0 + 1.
END.

nreng = linea0.
DO linea0 = nreng TO nmax_det:
    PUT nomcampo( INPUT "DO", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
    PUT nomcampo( INPUT "VE", INPUT linea0 ) + "," FORMAT "X(22)" SKIP.
    PUT nomcampo( INPUT "IM", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
    PUT nomcampo( INPUT "CA", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
    PUT nomcampo( INPUT "CO", INPUT linea0 ) + "," FORMAT "X(12)" SKIP.
    PUT nomcampo( INPUT "DE", INPUT linea0 ) + "," FORMAT "X(55)" SKIP.
    PUT nomcampo( INPUT "CJ", INPUT linea0 ) + "," FORMAT "X(18)" SKIP.
END.

PUT "F01," + STRING(Rec_header.imp_total,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.
PUT "F02," + STRING(Caj_header.importe,"Z,ZZZ,ZZ9.99-") FORMAT "X(18)" SKIP.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

PUT "F03," + Rec_header.leyenda FORMAT "X(120)" SKIP.
PUT "F04," + Usuario.nombre FORMAT "X(25)" SKIP.

/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

PUT "!PAGE!" SKIP.
OUTPUT CLOSE.

OS-COMMAND {&MUDO}  "..\prl\proform ..\prl\rca146.prn < ..\prl\rca146.txt > ..\prl\rca146.lst".
OS-COMMAND {&MUDO}  "copy ..\prl\rca146.lst prn /b".

PROCEDURE SALTO_HOJA:
/*
        UNDERLINE  Cta_cte.tip_comprob
                   Cta_cte.prf_comprob
                   Cta_cte.nro_comprob
                   Cta_cte.nro_vencimiento
                   Cta_cte.fecha_vencimiento
                   Rec_detalle.importe
                   Cta_cte.credito
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
            Cliente.nombre
            Cliente.cdg_Cliente
            WITH FRAME frm-encabezado.
        
        PUT CONTROL CHR(15).
        
        DISPLAY
            ry1
            tit_detalle
            ry2
            WITH FRAME frm-titulos.

*/
END PROCEDURE.
