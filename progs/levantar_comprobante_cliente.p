/*=================================================================================*/
/*                    EMISION DE FACTURAS/DEVOLUCIONES A CLIENTES                  */
/*=================================================================================*/

DEFINE TEMP-TABLE T-Fac_header               NO-UNDO LIKE Fac_header.
DEFINE TEMP-TABLE T-Fac_detalle              NO-UNDO LIKE Fac_detalle.
DEFINE TEMP-TABLE T-Registrable-factura      NO-UNDO LIKE Registrable-factura.
DEFINE TEMP-TABLE T-Sub_header_vta           NO-UNDO LIKE Sub_header_vta.
DEFINE TEMP-TABLE T-Sub_detalle_vta          NO-UNDO LIKE Sub_detalle_vta.
DEFINE temp-table T-Fac_header-bon           NO-UNDO like fac_header-bon.
DEFINE TEMP-TABLE T-Fac_detalle-bon          NO-UNDO LIKE Fac_detalle-bon.
DEFINE temp-table T-Fac_header_impuesto      NO-UNDO like fac_header_impuesto.
DEFINE TEMP-TABLE T-Fac_detalle_impuesto     NO-UNDO LIKE Fac_detalle_impuesto.
DEFINE TEMP-TABLE T-Asn_header               NO-UNDO LIKE Asn_header.
DEFINE TEMP-TABLE T-Asn_detalle              NO-UNDO LIKE Asn_detalle.
DEFINE TEMP-TABLE T-Asn_totales              NO-UNDO LIKE Asn_totales.
                                                                                                   
/*=================================================================================*/
/*                        DEFINICION DE PARAMETROS                                 */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_header.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_detalle.
DEFINE OUTPUT PARAMETER TABLE FOR T-Registrable-factura.
DEFINE OUTPUT PARAMETER TABLE FOR T-Sub_header_vta.
DEFINE OUTPUT PARAMETER TABLE FOR T-Sub_detalle_vta.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_header-bon.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_detalle-bon.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_header_impuesto.
DEFINE OUTPUT PARAMETER TABLE FOR T-Fac_detalle_impuesto.
DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_header.   
DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_detalle.  
DEFINE OUTPUT PARAMETER TABLE FOR T-Asn_totales.  

/*=================================================================================*/
/*                          VARIABLES Y BUFFERS                                    */
/*=================================================================================*/

   FIND Fac_header WHERE ROWID(Fac_header) = rid_factura NO-LOCK.
   BUFFER-COPY Fac_header TO T-Fac_header
       ASSIGN T-Fac_header.nro_factura = 0.

   FOR EACH Fac_detalle OF Fac_header NO-LOCK:
       CREATE T-Fac_detalle.
       BUFFER-COPY Fac_detalle TO T-Fac_detalle
           ASSIGN T-Fac_detalle.nro_factura = 0.
   END.    

   FOR EACH Fac_header-bon  OF Fac_header NO-LOCK:
       CREATE T-Fac_header-bon.
       BUFFER-COPY Fac_header-bon TO T-Fac_header-bon
           ASSIGN T-Fac_header-bon.nro_factura = 0.
   END.
    
   FOR EACH Fac_detalle-bon  OF Fac_header NO-LOCK:
       CREATE T-Fac_detalle-bon.
       BUFFER-COPY Fac_detalle-bon TO T-Fac_detalle-bon
           ASSIGN T-Fac_header-bon.nro_factura = 0.
   END.

   FIND Sub_header_vta 
        WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
          AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
          AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
          AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob
              NO-LOCK NO-ERROR.
   IF AVAILABLE Sub_header_vta
   THEN DO:
        CREATE T-Sub_header_vta.
        BUFFER-COPY Sub_header_vta TO T-Sub_header_vta.           
     
        FOR EACH Sub_detalle_vta 
             WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
               AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
               AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
               AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob
                   NO-LOCK.
     
            CREATE T-Sub_detalle_vta.
            BUFFER-COPY Sub_detalle_vta TO T-Sub_detalle_vta.           
     
        END.
   END.

   RUN leer_asiento_comprobante.p ( INPUT "Fac_header",
                                    INPUT Fac_header.nro_factura,
                                    OUTPUT TABLE T-Asn_header,
                                    OUTPUT TABLE T-Asn_detalle,
                                    OUTPUT TABLE T-Asn_totales ).
