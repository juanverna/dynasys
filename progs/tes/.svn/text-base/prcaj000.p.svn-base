
/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_recibo      AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE subtotal    AS DECIMAL FORMAT "-ZZZ,ZZ9.99".
DEFINE VARIABLE prfac       AS CHARACTER.
DEFINE VARIABLE blancos     AS CHARACTER.
DEFINE VARIABLE nreng       AS INTEGER.
DEFINE VARIABLE nmax_det    AS INTEGER INITIAL 10.
DEFINE VARIABLE linea0      AS INTEGER.
DEFINE VARIABLE cliobsdc    AS INTEGER.
DEFINE VARIABLE ccoobsdc    AS INTEGER.
DEFINE VARIABLE v-valores   AS DECIMAL.
DEFINE VARIABLE dtl_rubro   AS CHARACTER.

FORM
    "====================================================================================="
    SKIP
    Empresa.nombre
    "COMPROBANTE DE CAJA NRO:"  TO 70
    Caj_header.nro_comprob AT 71
    SKIP
    Empresa.direccion
    "Fecha:" TO 70
    Caj_header.fecha       AT 71
    SKIP
    Empresa.localidad 
    SKIP
    "====================================================================================="
    SKIP
    "Importe...............:" AT 15
    Caj_header.importe 
    Caj_header.observacion NO-LABELS
    SKIP
    "Imputacion............:" AT 15
    Cuenta.cdg_cuenta 
    Cuenta.nombre_cta NO-LABEL
    SKIP
    "-------------------------------------------------------------------------------------"
    SKIP
    "          D E T A L L E   D E   V A L O R E S   D E L    M O V I M I E N T O         "
    SKIP
    "-------------------------------------------------------------------------------------"
    WITH FRAME frm-encabezado USE-TEXT STREAM-IO WIDTH 132 NO-LABELS.

FORM
    SPACE(15)
    Caj_header.observacion VIEW-AS EDITOR SIZE 65 BY 3 AT 15
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 132 NO-LABELS.

FORM
    Caj_detalle.nro_linea COLUMN-LABEL "# "
    Rubro.cdg_rubro
    Rubro.nombre
    SPACE(3)
    Caj_detalle.importe
    dtl_rubro FORMAT "X(25)"
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 132 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

FIND Caj_header WHERE ROWID(Caj_header) = act_recibo EXCLUSIVE-LOCK.
FIND Empresa OF Caj_header NO-LOCK.
FIND Cuenta OF Caj_header NO-LOCK.

v-valores = 0.

OUTPUT TO PRINTER PAGE-SIZE 36.

PUT CONTROL CHR(18).
PUT CONTROL "~033C$".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Empresa.nombre
    Empresa.direccion
    Empresa.localidad 
    Caj_header.nro_comprob
    Caj_header.fecha
    Caj_header.importe 
    Caj_header.observacion
    Cuenta.cdg_cuenta
    Cuenta.nombre_cta
    WITH FRAME frm-encabezado.

/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

linea0 = LINE-COUNTER.

OPEN QUERY qry_valores
     FOR EACH Caj_detalle OF Caj_header.

GET FIRST qry_valores    NO-LOCK.

FOR EACH Caj_detalle OF Caj_header:

     v-valores = v-valores + Caj_detalle.importe.
     FIND Rubro OF Caj_detalle NO-ERROR.
     CASE Rubro.tipo:
        WHEN "D"
          THEN DO:
               dtl_rubro = "".
          END.
        WHEN "C"
          THEN DO:
               dtl_rubro = STRING(Caj_detalle.divisas) + " * " +
                           STRING(Caj_detalle.cambio,"ZZZ9.9999").
          END.
        WHEN "V"
          THEN DO:
               FIND Valor OF Caj_detalle NO-LOCK.
               FIND Banco OF Valor NO-LOCK.
               dtl_rubro = Banco.abrevia + " " +
                           STRING(Valor.numero_cheque,"99999999") + " " +
                           STRING(Valor.fecha_emision).
          END.
        WHEN "P"
          THEN DO:
               FIND Cheque OF Caj_detalle NO-LOCK.
               FIND Cuenta_bancaria OF Cheque NO-LOCK.
               FIND Banco OF Cuenta_bancaria NO-LOCK.
               dtl_rubro = Banco.abrevia + " " +
                           STRING(Cheque.numero_cheque,"99999999") + " " +
                           STRING(Cheque.fecha_emision).
          END.
     END CASE.

  DISPLAY  Rubro.cdg_rubro
           Rubro.nombre
           Caj_detalle.importe
           dtl_rubro          
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  DOWN WITH FRAME frm-detalle.
  GET NEXT qry_valores    NO-LOCK.

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

UNDERLINE  Caj_detalle.importe
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

DISPLAY  v-valores @ Caj_detalle.importe
         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/
/*
DISPLAY
    Caj_header.observacion
    WITH FRAME frm-pie.
*/
/*---------------------------------------------------------------------------------*/
/*                                       FIN                                       */
/*---------------------------------------------------------------------------------*/

OUTPUT CLOSE.


