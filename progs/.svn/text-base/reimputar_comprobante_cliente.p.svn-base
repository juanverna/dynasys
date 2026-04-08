/* ============================================================================================= */
/*             REGENERA LA IMPUTACION CONTABLE DE UNA FACTURA                                    */
/* ============================================================================================= */

DEFINE INPUT PARAMETER rid_factura          AS ROWID.

/* ============================================================================================= */
/*                                        VARIABLES                                              */
/* ============================================================================================= */

DEFINE VARIABLE aux_nro_asiento             AS INTEGER.
DEFINE VARIABLE x-asn_tip_comprob           LIKE Asn_header.tip_comprob.
DEFINE VARIABLE x-asn_prf_comprob           LIKE Asn_header.prf_comprob.
DEFINE VARIABLE x-asn_nro_comprob           LIKE Asn_header.nro_comprob.

/* ============================================================================================= */
/*                                      TABLAS TEMPORALES                                        */
/* ============================================================================================= */

DEFINE TEMP-TABLE T-Fac_header              NO-UNDO LIKE Fac_header          .
DEFINE TEMP-TABLE T-Fac_detalle             NO-UNDO LIKE Fac_detalle         .
DEFINE TEMP-TABLE T-Registrable-factura     NO-UNDO LIKE Registrable-factura .
DEFINE TEMP-TABLE T-Sub_header_vta          NO-UNDO LIKE Sub_header_vta      .
DEFINE TEMP-TABLE T-Sub_detalle_vta         NO-UNDO LIKE Sub_detalle_vta     .
DEFINE TEMP-TABLE T-Fac_header-bon          NO-UNDO LIKE Fac_header-bon      .
DEFINE TEMP-TABLE T-Fac_detalle-bon         NO-UNDO LIKE Fac_detalle-bon     .
DEFINE TEMP-TABLE T-Fac_header_impuesto     NO-UNDO LIKE Fac_header_impuesto .
DEFINE TEMP-TABLE T-Fac_detalle_impuesto    NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Asn_header              NO-UNDO LIKE Asn_header          .
DEFINE TEMP-TABLE T-Asn_detalle             NO-UNDO LIKE Asn_detalle         .
DEFINE TEMP-TABLE T-Asn_totales             NO-UNDO LIKE Asn_totales         .

/* ============================================================================================= */
/*             REGENERA LA IMPUTACION CONTABLE DE UNA FACTURA                                    */
/* ============================================================================================= */


DO TRANSACTION:

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.
    FIND Cliente OF Fac_header NO-LOCK.

    EMPTY TEMP-TABLE T-Fac_header.
    EMPTY TEMP-TABLE T-Fac_detalle.
    EMPTY TEMP-TABLE T-Registrable-factura.
    EMPTY TEMP-TABLE T-Sub_header_vta.
    EMPTY TEMP-TABLE T-Sub_detalle_vta.
    EMPTY TEMP-TABLE T-Fac_header-bon.
    EMPTY TEMP-TABLE T-Fac_detalle-bon.
    EMPTY TEMP-TABLE T-Fac_header_impuesto.
    EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
    EMPTY TEMP-TABLE T-Asn_header.
    EMPTY TEMP-TABLE T-Asn_detalle.
    EMPTY TEMP-TABLE T-Asn_totales.

    RUN levantar_comprobante_cliente.p ( 
                              INPUT ROWID(Fac_header), 
                              OUTPUT TABLE T-Fac_header,
                              OUTPUT TABLE T-Fac_detalle,
                              OUTPUT TABLE T-Registrable-factura,
                              OUTPUT TABLE T-Sub_header_vta,
                              OUTPUT TABLE T-Sub_detalle_vta,
                              OUTPUT TABLE T-Fac_header-bon,
                              OUTPUT TABLE T-Fac_detalle-bon,
                              OUTPUT TABLE T-Fac_header_impuesto,
                              OUTPUT TABLE T-Fac_detalle_impuesto,
                              OUTPUT TABLE T-Asn_header,
                              OUTPUT TABLE T-Asn_detalle,
                              OUTPUT TABLE T-Asn_totales).

    RUN calcular_comprobante_cliente.p (
                             INPUT-OUTPUT TABLE T-Fac_header,
                             INPUT-OUTPUT TABLE T-Fac_detalle,
                             INPUT-OUTPUT TABLE T-Sub_header_vta,
                             INPUT-OUTPUT TABLE T-Sub_detalle_vta,
                             INPUT-OUTPUT TABLE T-Fac_header-bon,
                             INPUT-OUTPUT TABLE T-Fac_detalle-bon,
                             INPUT-OUTPUT TABLE T-Fac_header_impuesto,
                             INPUT-OUTPUT TABLE T-Fac_detalle_impuesto
/*,
                             INPUT-OUTPUT TABLE T-Asn_header,
                             INPUT-OUTPUT TABLE T-Asn_detalle,
                             INPUT-OUTPUT TABLE T-Asn_totales */ ).

    FIND FIRST T-Fac_header.

    /* --------------------------------------------------------------- */

    FOR EACH Sub_header_vta OF Fac_header:
        DELETE Sub_header_vta.
    END.

    FOR EACH T-Sub_header_vta:
       CREATE Sub_header_vta.
       BUFFER-COPY T-Sub_header_vta TO Sub_header_vta.
    END.

    /* --------------------------------------------------------------- */

    FOR EACH Sub_detalle_vta OF Fac_header:
        DELETE Sub_detalle_vta.
    END.

    FOR EACH T-Sub_detalle_vta:
       CREATE Sub_detalle_vta.
       BUFFER-COPY T-Sub_detalle_vta TO Sub_detalle_vta.
    END.

   /* ---------------------------------------------------------------------------*/
  /*
    FIND FIRST T-Asn_header.

    FIND FIRST Asn_header
        WHERE Asn_header.tabla_comprobante = "Fac_header" 
          AND Asn_header.nro_idcabecera    = Fac_header.nro_factura
              EXCLUSIVE-LOCK.

    ASSIGN  x-asn_tip_comprob = Asn_header.tip_comprob
            x-asn_prf_comprob = Asn_header.prf_comprob
            x-asn_nro_comprob = Asn_header.nro_comprob
            aux_nro_asiento   = Asn_header.nro_asiento.

    FOR EACH Asn_detalle OF Asn_header EXCLUSIVE-LOCK:
        DELETE Asn_detalle.
    END.

    FOR EACH Asn_totales OF Asn_header EXCLUSIVE-LOCK:
        DELETE Asn_totales.
    END.

    DELETE Asn_header.
    CREATE Asn_header.

    BUFFER-COPY T-Asn_header TO Asn_header
        ASSIGN Asn_header.nro_asiento       = aux_nro_asiento
               Asn_header.tip_comprob       = x-asn_tip_comprob
               Asn_header.prf_comprob       = x-asn_prf_comprob
               Asn_header.nro_comprob       = x-asn_nro_comprob
               Asn_header.tabla_comprobante = "Fac_header" 
               Asn_header.nro_idcabecera    = Fac_header.nro_factura.

    FOR EACH T-Asn_detalle WHERE T-Asn_detalle.nro_asiento = 0:
        CREATE Asn_detalle.
        BUFFER-COPY T-Asn_detalle TO Asn_detalle 
            ASSIGN Asn_detalle.nro_asiento = Asn_header.nro_asiento.
    END.

    FOR EACH T-Asn_totales WHERE T-Asn_totales.nro_asiento = 0:
        CREATE Asn_totales.
        BUFFER-COPY T-Asn_totales TO Asn_totales 
            ASSIGN Asn_totales.nro_asiento = Asn_header.nro_asiento.
   END.
*/
END.
