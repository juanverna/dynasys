/*=================================================================================*/
/*               GENERA LA INTERFACE DE SUCURSALES PARA DESPACHO                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta  AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha  AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha  AS DATE. 
DEFINE INPUT PARAMETER p-archivo    AS CHARACTER. 

DEFINE TEMP-TABLE T-Rec_header      LIKE Rec_header.
DEFINE TEMP-TABLE T-Rec_detalle     LIKE Rec_detalle.

{VRSHARED.I }
  
DEFINE STREAM Errores.

DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL LABEL "Emitir remito".
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir" INITIAL YES.

DEFINE VARIABLE archivo             AS CHARACTER.
DEFINE VARIABLE direc_tmp           AS CHARACTER INITIAL ".\".
DEFINE VARIABLE ant_remyfact        AS INTEGER.
DEFINE VARIABLE ncopias_ra          AS INTEGER.
DEFINE VARIABLE ncopias_rb          AS INTEGER.
DEFINE VARIABLE ncopias_rc          AS INTEGER.

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS RECIBOS A IMPORTAR               */
/*=================================================================================*/

     /*------------------------------------------------------------*/ 
     /* Se asegura de que esten desenganchados los remitos de las  */ 
     /* facturas y pone en cero la cantidad de copias de remitos   */
     /*------------------------------------------------------------*/ 

DO TRANSACTION:

    FIND Parametro "NCOPIARA" EXCLUSIVE-LOCK.
    ncopias_ra = Parametro.valor_n.
    Parametro.valor_n = 0.
    RELEASE Parametro.

    FIND Parametro "NCOPIARB" EXCLUSIVE-LOCK.
    ncopias_rb = Parametro.valor_n.
    Parametro.valor_n = 0.
    RELEASE Parametro.

    FIND Parametro "NCOPIARC" EXCLUSIVE-LOCK.
    ncopias_rc = Parametro.valor_n.
    Parametro.valor_n = 0.
    RELEASE Parametro.

END.

     /*---------------------------------------------*/ 
     /* Importa la interface en tablas temporarias  */ 
     /*---------------------------------------------*/ 

FIND Parametro "DIRECTMP" NO-LOCK NO-ERROR.
IF AVAILABLE Parametro THEN direc_tmp = Parametro.valor_c.

archivo = direc_tmp + "\" + p-archivo + 
          STRING(YEAR(p-has_fecha),"9999") + 
          STRING(MONTH(p-has_fecha),"99") + 
          STRING(DAY(p-has_fecha),"99") + "CXCXXX.TXT".
          
INPUT FROM VALUE(REPLACE(archivo,"XXX","REH")). 
REPEAT:
    CREATE T-Rec_header.
    IMPORT DELIMITER "|" T-Rec_header.
END.
INPUT CLOSE.

INPUT FROM VALUE(REPLACE(archivo,"XXX","RED")). 
REPEAT:
    CREATE T-Rec_detalle.
    IMPORT DELIMITER "|" T-Rec_detalle.
END.
INPUT CLOSE.

     /*-----------------------------------------------------------------*/ 
     /* Baja los datos a las tablas permanentes y emite los documentos  */ 
     /*-----------------------------------------------------------------*/ 

OUTPUT STREAM Errores TO VALUE(REPLACE(archivo,".TXT",".LOG")). 

FOR EACH T-Rec_header:

    FIND Rec_header WHERE Rec_header.tip_comprob  = T-Rec_header.tip_comprob
                      AND Rec_header.prf_comprob  = T-Rec_header.prf_comprob
                      AND Rec_header.nro_comprob  = T-Rec_header.nro_comprob NO-ERROR.

    IF AVAILABLE Rec_header
    THEN DO:
         EXPORT STREAM Errores 
                "Ya Existe"
                T-Rec_header.tip_comprob
                T-Rec_header.prf_comprob
                T-Rec_header.nro_comprob.

    END.
    ELSE DO:
        RUN BAJAR_T-Rec_header.
        RUN BAJAR_T-Rec_detalle.
        act_Rec_head = ROWID(Rec_header).
        RUN EMIRECIB.P.
    END.
    
END.    

     /*-----------------------------------------------------------------*/ 
     /* Restaura la relacion entre remitos y facturas y la cantidad de  */ 
     /* copias impresas de cada remito                                  */
     /*-----------------------------------------------------------------*/ 

DO TRANSACTION:

    FIND Parametro "NCOPIARA" EXCLUSIVE-LOCK.
    Parametro.valor_n = ncopias_ra.
    RELEASE Parametro.

    FIND Parametro "NCOPIARB" EXCLUSIVE-LOCK.
    Parametro.valor_n = ncopias_rb.
    RELEASE Parametro.

    FIND Parametro "NCOPIARC" EXCLUSIVE-LOCK.
    Parametro.valor_n = ncopias_rc.
    RELEASE Parametro.

END.

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS REMITOS A IMPORTAR               */
/*=================================================================================*/

PROCEDURE BAJAR_T-Rec_header:

    /*

              Tabla de Ctl DESACTIVADA.

    CREATE Ctl-despacho.
    ASSIGN Ctl-despacho.nro_factura     = NEXT-VALUE(proxima_transaccion)
           Ctl-despacho.nro_factura-suc = T-Rec_header.nro_factura.
     
    CREATE Rec_header.
    BUFFER-COPY T-Rec_header TO Rec_header ASSIGN Rec_header.nro_factura = Ctl-despacho.nro_factura.
    
    */

    CREATE Rec_header.
    BUFFER-COPY T-Rec_header TO Rec_header.

END PROCEDURE.

PROCEDURE BAJAR_T-Rec_detalle:

    FOR EACH T-Rec_detalle OF T-Rec_header:
        CREATE Rec_detalle.
/*      BUFFER-COPY T-Rec_detalle TO Rec_detalle ASSIGN Rec_detalle.nro_factura = Ctl-despacho.nro_factura. */
        BUFFER-COPY T-Rec_detalle TO Rec_detalle.
    END.

END PROCEDURE.

