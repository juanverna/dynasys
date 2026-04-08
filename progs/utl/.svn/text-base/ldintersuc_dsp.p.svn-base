/*=================================================================================*/
/*               GENERA LA INTERFACE DE SUCURSALES PARA DESPACHO                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER p-pto_venta  AS CHARACTER.
DEFINE INPUT PARAMETER p-des_fecha  AS DATE. 
DEFINE INPUT PARAMETER p-has_fecha  AS DATE. 
DEFINE INPUT PARAMETER p-archivo    AS CHARACTER. 

DEFINE TEMP-TABLE T-Rem_header      LIKE Rem_header.
DEFINE TEMP-TABLE T-Rem_detalle     LIKE Rem_detalle.
DEFINE TEMP-TABLE T-Rem_header-bon  LIKE Rem_header-bon.
DEFINE TEMP-TABLE T-Rem_detalle-bon LIKE Rem_detalle-bon.
DEFINE TEMP-TABLE T-Remito-factura  LIKE Remito-factura.

{VRSHARED.I }
  
DEFINE STREAM Errores.

DEFINE NEW SHARED VARIABLE emitir_remito  AS LOGICAL LABEL "Emitir remito".
DEFINE NEW SHARED VARIABLE emitir_factura AS LOGICAL LABEL "Emitir" INITIAL YES.

DEFINE VARIABLE archivo             AS CHARACTER.
DEFINE VARIABLE direc_tmp           AS CHARACTER INITIAL ".\".
DEFINE VARIABLE ant_remyfact        AS INTEGER.
DEFINE VARIABLE ncopias             AS INTEGER.

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS REMITOS A IMPORTAR               */
/*=================================================================================*/

     /*------------------------------------------------------------*/ 
     /* Se asegura de que esten desenganchados los remitos de las  */ 
     /* facturas y pone en cero la cantidad de copias de remitos   */
     /*------------------------------------------------------------*/ 

DO TRANSACTION:

    FIND Parametro "REMIFACT" EXCLUSIVE-LOCK.
    ant_remyfact = Parametro.valor_n.
    Parametro.valor_n = 0.
    RELEASE Parametro.

    FIND Parametro "NCOPIARM" EXCLUSIVE-LOCK.
    ncopias = Parametro.valor_n.
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
          STRING(DAY(p-has_fecha),"99") + "DSPXXX.TXT".
          
INPUT FROM VALUE(REPLACE(archivo,"XXX","RMH")). 
REPEAT:
    CREATE T-Rem_header.
    IMPORT DELIMITER "|" T-Rem_header.
END.
INPUT CLOSE.

INPUT FROM VALUE(REPLACE(archivo,"XXX","RMD")). 
REPEAT:
    CREATE T-Rem_detalle.
    IMPORT DELIMITER "|" T-Rem_detalle.
END.
INPUT CLOSE.

INPUT FROM VALUE(REPLACE(archivo,"XXX","BOH")). 
REPEAT:
    CREATE T-Rem_header-bon.
    IMPORT DELIMITER "|" T-Rem_header-bon.
END.
INPUT CLOSE.

INPUT FROM VALUE(REPLACE(archivo,"XXX","BOD")). 
REPEAT:
    CREATE T-Rem_detalle-bon.
    IMPORT DELIMITER "|" T-Rem_detalle-bon.
END.
INPUT CLOSE.

INPUT FROM VALUE(REPLACE(archivo,"XXX","RYF")). 
REPEAT:
    CREATE T-Remito-factura.
    IMPORT DELIMITER "|" T-Remito-factura.
END.
INPUT CLOSE.

     /*-----------------------------------------------------------------*/ 
     /* Baja los datos a las tablas permanentes y emite los documentos  */ 
     /*-----------------------------------------------------------------*/ 

OUTPUT STREAM Errores TO VALUE(REPLACE(archivo,".TXT",".LOG")). 

FOR EACH T-Rem_header:

    FIND Rem_header WHERE Rem_header.tip_comprob  = T-Rem_header.tip_comprob
                      AND Rem_header.prf_comprob  = T-Rem_header.prf_comprob
                      AND Rem_header.nro_comprob  = T-Rem_header.nro_comprob NO-ERROR.

    IF AVAILABLE Rem_header
    THEN DO:
         EXPORT STREAM Errores 
                "Ya Existe"
                T-Rem_header.tip_comprob
                T-Rem_header.prf_comprob
                T-Rem_header.nro_comprob.

    END.
    ELSE DO:
        RUN BAJAR_T-Rem_header.
        RUN BAJAR_T-Rem_detalle.
        RUN BAJAR_T-Rem_header-bon.
        RUN BAJAR_T-Rem_detalle-bon.
        RUN BAJAR_T-Remito-factura.
        act_rem_head = ROWID(Rem_header).
        RUN EMIREMIT.P.
    END.
    
END.    

     /*-----------------------------------------------------------------*/ 
     /* Restaura la relacion entre remitos y facturas y la cantidad de  */ 
     /* copias impresas de cada remito                                  */
     /*-----------------------------------------------------------------*/ 

DO TRANSACTION:

    FIND Parametro "REMIFACT" EXCLUSIVE-LOCK.
    Parametro.valor_n = ant_remyfact.
    RELEASE Parametro.

    FIND Parametro "NCOPIARM" EXCLUSIVE-LOCK.
    Parametro.valor_n = ncopias.
    RELEASE Parametro.

END.

/*=================================================================================*/
/*           AVERIGUA LOS NUMEROS INTERNOS DE LOS REMITOS A IMPORTAR               */
/*=================================================================================*/

PROCEDURE BAJAR_T-Rem_header:

    /*

              Tabla de Ctl DESACTIVADA.

    CREATE Ctl-despacho.
    ASSIGN Ctl-despacho.nro_remito     = NEXT-VALUE(proxima_transaccion)
           Ctl-despacho.nro_remito-suc = T-Rem_header.nro_remito.
     
    CREATE Rem_header.
    BUFFER-COPY T-Rem_header TO Rem_header ASSIGN Rem_header.nro_remito = Ctl-despacho.nro_remito.
    
    */

    CREATE Rem_header.
    BUFFER-COPY T-Rem_header TO Rem_header.

END PROCEDURE.

PROCEDURE BAJAR_T-Rem_detalle:

    FOR EACH T-Rem_detalle OF T-Rem_header:
        CREATE Rem_detalle.
/*      BUFFER-COPY T-Rem_detalle TO Rem_detalle ASSIGN Rem_detalle.nro_remito = Ctl-despacho.nro_remito. */
        BUFFER-COPY T-Rem_detalle TO Rem_detalle.
    END.

END PROCEDURE.

PROCEDURE BAJAR_T-Rem_header-bon:

    FOR EACH T-Rem_header-bon OF T-Rem_header:
        CREATE Rem_header-bon.
/*      BUFFER-COPY T-Rem_header-bon TO Rem_header-bon ASSIGN Rem_header-bon.nro_remito = Ctl-despacho.nro_remito.*/
        BUFFER-COPY T-Rem_header-bon TO Rem_header-bon.
    END.

END PROCEDURE.

PROCEDURE BAJAR_T-Rem_detalle-bon:

    FOR EACH T-Rem_detalle-bon OF T-Rem_header:
        CREATE Rem_detalle-bon.
/*      BUFFER-COPY T-Rem_detalle-bon TO Rem_detalle-bon ASSIGN Rem_detalle-bon.nro_remito = Ctl-despacho.nro_remito.*/
        BUFFER-COPY T-Rem_detalle-bon TO Rem_detalle-bon.
    END.

END PROCEDURE.

PROCEDURE BAJAR_T-Remito-factura:

    FOR EACH T-Remito-factura OF T-Rem_header:
        CREATE Remito-factura.
/*      BUFFER-COPY T-Remito-factura TO Remito-factura ASSIGN Remito-factura.nro_remito = Ctl-despacho.nro_remito.*/
        BUFFER-COPY T-Remito-factura TO Remito-factura.
    END.

END PROCEDURE.

