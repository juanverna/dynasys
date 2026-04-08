/*=================================================================================================*/
/*                      PROCESO DE BONIFICACIONES ESPECIALES                                       */
/*=================================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE TEMP-TABLE T-Fac_header-bon           NO-UNDO LIKE Fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE TEMP-TABLE T-Fac_header_impuesto      NO-UNDO LIKE Fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.

DEFINE VARIABLE x-coeficiente AS DECIMAL.

DEFINE BUFFER B-Fac_header-bon FOR Fac_header-bon.

/*-------------------------------------------------------------------------------------------------*/
/*                                   PROCESO                                                       */
/*-------------------------------------------------------------------------------------------------*/

RUN ponempresa.p ("R").

DEFINE STREAM seguir.
OUTPUT STREAM seguir TO "c:\sic-temp\seguimiento.txt" PAGE-SIZE 0.

DO TRANSACTION:

    FOR EACH Fac_header-bon 
        WHERE Fac_header-bon.cdg_bonificacion >= 90, 
            FIRST Fac_header OF Fac_header-bon 
                   WHERE Fac_header.cdg_empresa = "F" 
                     AND NOT Fac_header.proc_estad EXCLUSIVE-LOCK:
    
        x-coeficiente = Fac_header-bon.porcentaje / 100.

        PUT STREAM seguir "============================================================" SKIP
                          Fac_header.tip_comprob " " 
                          Fac_header.prf_comprob " " 
                          Fac_header.nro_comprob " "
                          Fac_header.imp_neto " "
                          Fac_header.imp_iva " "
                          Fac_header.imp_total " " SKIP .

        CREATE T-Fac_header.
        BUFFER-COPY Fac_header TO T-Fac_header
            ASSIGN T-Fac_header.nro_factura = NEXT-VALUE(proxima_transaccion)
                   T-Fac_header.cdg_empresa = "R".
    
        PUT STREAM seguir SPACE(7) "---------------Detalle de factura-------------------" SKIP.

        FOR EACH Fac_detalle OF Fac_header:
            CREATE T-Fac_detalle.
            BUFFER-COPY Fac_detalle TO T-Fac_detalle
                ASSIGN T-Fac_detalle.nro_factura = T-Fac_header.nro_factura
                       T-Fac_detalle.precio = Fac_detalle.precio * x-coeficiente .

            PUT STREAM seguir SPACE(7) Fac_detalle.nro_linea  " " T-Fac_detalle.precio " " Fac_detalle.precio " " T-Fac_detalle.cantidad SKIP.  
        END.
    
        PUT STREAM seguir SPACE(7) "---------------Detalle de bonificaciones-------------" SKIP.

        FOR EACH Fac_detalle-bon OF Fac_header:
            CREATE T-Fac_detalle-bon.
            BUFFER-COPY Fac_detalle-bon TO T-Fac_detalle-bon
                ASSIGN T-Fac_detalle-bon.nro_factura = T-Fac_header.nro_factura.

            PUT STREAM seguir SPACE(7) T-Fac_detalle-bon.cdg_bonificacion " " T-Fac_detalle-bon.porcentaje " " T-Fac_detalle-bon.importe SKIP.
        END.
    
        PUT STREAM seguir SPACE(7) "--------------Encabezado de bonificaciones------------" SKIP.

        FOR EACH B-Fac_header-bon OF Fac_header WHERE B-Fac_header-bon.cdg_bonificacion < 90:
            CREATE T-Fac_header-bon.
            BUFFER-COPY B-Fac_header-bon TO T-Fac_header-bon
                ASSIGN T-Fac_header-bon.nro_factura = T-Fac_header.nro_factura.

            PUT STREAM seguir SPACE(7) T-Fac_header-bon.cdg_bonificacion " " T-Fac_header-bon.porcentaje " " T-Fac_header-bon.importe SKIP.
        END.


        RUN emitir_comprobante_cliente.p ( 
                                  INPUT TABLE T-Fac_header,
                                  INPUT TABLE T-Fac_detalle,
                                  INPUT TABLE T-Registrable-factura,
                                  INPUT TABLE T-Sub_header_vta,
                                  INPUT TABLE T-Sub_detalle_vta,
                                  INPUT TABLE T-Fac_header-bon,
                                  INPUT TABLE T-Fac_detalle-bon,
                                  INPUT TABLE T-Fac_header_impuesto,
                                  INPUT TABLE T-Fac_detalle_impuesto).
                                  
        Fac_header.proc_estad = YES.
    
        RUN borrar_tablas_temporales.

    END.

END.

OUTPUT STREAM seguir CLOSE.
/*-------------------------------------------------------------------------------------------------*/
/*                                   PROCEDIMIENTOS INTERNOS                                       */
/*-------------------------------------------------------------------------------------------------*/

PROCEDURE borrar_tablas_temporales :

   EMPTY TEMP-TABLE T-Fac_header.
   EMPTY TEMP-TABLE T-Fac_detalle.
   EMPTY TEMP-TABLE T-Fac_header-bon.
   EMPTY TEMP-TABLE T-Fac_detalle-bon.
   EMPTY TEMP-TABLE T-Sub_detalle_vta.
   EMPTY TEMP-TABLE T-Sub_header_vta.
   EMPTY TEMP-TABLE T-Fac_header_impuesto.
   EMPTY TEMP-TABLE T-Fac_detalle_impuesto.
       
END PROCEDURE.


