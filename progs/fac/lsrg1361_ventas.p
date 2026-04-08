/*===========================================================================================*/
/*                   GENERACION DE INTERFACE DE ACUERDO A LA RESOLUCIÓN RG 1361              */
/*===========================================================================================*/

DEFINE INPUT PARAMETER des_fecha AS DATE.
DEFINE INPUT PARAMETER has_fecha AS DATE.

/*===========================================================================================*/
/*                                    TABLAS TEMPORALES                                      */
/*===========================================================================================*/

DEFINE TEMP-TABLE T-Ventas
   FIELD clave-1    AS CHARACTER FORMAT 'X(12)' INITIAL '000000000000'
   FIELD clave-2    AS CHARACTER FORMAT 'X(12)' INITIAL '000000000000'
   FIELD tipo       AS CHARACTER FORMAT 'X(1)' INITIAL '1'
   FIELD fecha      AS INTEGER FORMAT '99999999'
   FIELD tcomp      AS INTEGER FORMAT '99'
   FIELD contr      AS CHARACTER FORMAT 'X(1)' INITIAL ' '
   FIELD pvta       AS INTEGER FORMAT '9999'
   FIELD numero     AS INTEGER FORMAT '99999999'
   FIELD numeroh    AS INTEGER FORMAT '99999999'
   FIELD documv     AS INTEGER FORMAT '99'   
   FIELD ndocuv     AS CHARACTER FORMAT 'X(11)'
   FIELD nombrv     AS CHARACTER FORMAT 'X(30)'
   FIELD imp_to     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_nog    AS DECIMAL FORMAT '999999999999999'
   FIELD imp_neg    AS DECIMAL FORMAT '999999999999999'
   FIELD alicuo     AS DECIMAL FORMAT '999999'
   FIELD impue      AS DECIMAL FORMAT '999999999999999'
   FIELD impueni    AS DECIMAL FORMAT '999999999999999'
   FIELD imp_ex     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_pc     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_ib     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_im     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_ii     AS DECIMAL FORMAT '999999999999999'
   FIELD tipo_r     AS INTEGER FORMAT '99'
   FIELD moneda     AS CHARACTER FORMAT 'X(3)'
   FIELD cambio     AS INTEGER FORMAT '999999'
   FIELD calic      AS INTEGER FORMAT '9'
   FIELD operac     AS CHARACTER FORMAT 'X(1)' INITIAL ' '
   FIELD cai        AS CHARACTER FORMAT 'X(30)'
   FIELD vto_cai    AS INTEGER FORMAT '99999999'
   FIELD fec_cai    AS INTEGER FORMAT '99999999'   
   FIELD relleno    AS CHARACTER FORMAT 'X(50)' 
                    INITIAL '00000000000000000000000000000000000000000000000000'
   INDEX T-Ventas IS PRIMARY fecha tcomp pvta numero ASCENDING.

DEFINE TEMP-TABLE T-Total_ventas
   FIELD clave-1    AS CHARACTER FORMAT 'X(12)' INITIAL '000000000000'
   FIELD clave-2    AS CHARACTER FORMAT 'X(12)' INITIAL '000000000000'
   FIELD tipo       AS CHARACTER FORMAT 'X(1)' INITIAL '2'
   FIELD periodo    AS INTEGER FORMAT '999999'
   FIELD relle1     AS CHARACTER FORMAT 'X(17)'
   FIELD ccomp      AS INTEGER FORMAT '9999'
   FIELD relle2     AS CHARACTER FORMAT 'X(18)'
   FIELD ndocuv     AS CHARACTER FORMAT 'X(15)'
   FIELD relle3     AS CHARACTER FORMAT 'X(45)'
   FIELD imp_to     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_nog    AS DECIMAL FORMAT '999999999999999'
   FIELD imp_neg    AS DECIMAL FORMAT '999999999999999'
   FIELD relle4     AS CHARACTER FORMAT 'X(6)'
   FIELD impue      AS DECIMAL FORMAT '999999999999999'
   FIELD impueni    AS DECIMAL FORMAT '999999999999999'   
   FIELD imp_ex     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_pc     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_ib     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_im     AS DECIMAL FORMAT '999999999999999'
   FIELD imp_ii     AS DECIMAL FORMAT '999999999999999'
   FIELD relle5     AS CHARACTER FORMAT 'X(113)'.

DEFINE TEMP-TABLE Comprobante
   FIELD codigo       AS INTEGER FORMAT '99'
   FIELD descripcion  AS CHARACTER FORMAT 'X(35)'
   FIELD tip_comprob  AS CHARACTER FORMAT 'X(2)'
   INDEX por_comprob IS PRIMARY UNIQUE tip_comprob ASCENDING.

/*=============================================================================================*/
/*                                     VARIABLES                                               */
/*=============================================================================================*/

/*{VRSHARED.I 'NEW'}*/
{WGLISTAR.I}

DEFINE VARIABLE org_formato  AS CHARACTER.

DEFINE STREAM Venta.

DEFINE VARIABLE neto      LIKE Sub_detalle_vta.valor.
DEFINE VARIABLE sig       AS INTEGER.
DEFINE VARIABLE xalic     LIKE Impuesto.tasa.
DEFINE VARIABLE cuit      LIKE Fac_header.cuit.
DEFINE VARIABLE nombre    LIKE Fac_header.nombre.
DEFINE VARIABLE totall    LIKE Fac_header.imp_total.


DEFINE VARIABLE xx        LIKE T-Ventas.imp_to.

/*===========================================================================================*/
/*                                     BLOQUE PRINCIPAL                                      */
/*===========================================================================================*/

org_formato = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT = 'American'.

RUN crear_comprobante (39, 'Otros Comprobante A (liquidaciones)', '').
RUN crear_comprobante (3, 'Credito A', 'CA').
RUN crear_comprobante (8, 'Credito B', 'CB').
RUN crear_comprobante (13, 'Credito C', 'CC').
RUN crear_comprobante (21, 'Credito E', 'CE').
RUN crear_comprobante (2, 'Debito A', 'DA').
RUN crear_comprobante (7, 'Debito B', 'DB').
RUN crear_comprobante (12, 'Debito C', 'DC').
RUN crear_comprobante (20, 'Debito E', 'DE').
RUN crear_comprobante (1, 'Factura A', 'FA').
RUN crear_comprobante (6, 'Factura B', 'FB').
RUN crear_comprobante (11, 'Factura C', 'FC').
RUN crear_comprobante (19, 'Factura E', 'FE').
RUN crear_comprobante (4, 'Recibo A', 'RA').
RUN crear_comprobante (9, 'Recibo B', 'RB').


OUTPUT TO VALUE('c:\sic-temp\rg1361ventas.txt').

RUN exportar_ventas.
  
OUTPUT CLOSE. 

SESSION:NUMERIC-FORMAT = org_formato.

message 'Exportación exitosa' view-as alert-box.

RUN veresult.w ( INPUT 'c:\sic-temp\rg1361ventas.txt', INPUT 22 ).

/*===========================================================================================*/
/*                               P R O C E D I M I E N T O S                                 */
/*===========================================================================================*/

PROCEDURE exportar_ventas:

    {findempresa.i}
    
    CREATE T-Total_ventas.
    ASSIGN T-Total_ventas.periodo  = YEAR(has_fecha) * 100 + MONTH(has_fecha)
           T-Total_ventas.ndocuv   = Empresa.cuit.
    
    FOR EACH Sub_header_vta WHERE Sub_header_vta.fecha >= des_fecha 
                              AND Sub_header_vta.fecha <= has_fecha
                              AND Sub_header_vta.cdg_empresa = Empresa.cdg_empresa,
                                  FIRST Tipocomprobante OF Sub_header_vta WHERE NOT Tipocomprobante.es_interno AND Tipocomprobante.debita:
         
         sig = IF Tipocomprobante.debita THEN 1 ELSE -1 .

         FIND Comprobante OF Sub_header_vta NO-ERROR.
         IF NOT AVAILABLE Comprobante 
            THEN FIND Comprobante WHERE Comprobante.codigo = 39.
         
         FIND Fac_header WHERE Sub_header_vta.cdg_empresa = Fac_header.cdg_empresa
                           AND Sub_header_vta.tip_comprob = Fac_header.tip_comprob
                           AND Sub_header_vta.prf_comprob = Fac_header.prf_comprob
                           AND Sub_header_vta.nro_comprob = Fac_header.nro_comprob /*NO-ERROR*/.
         
         FIND Cliente OF Fac_header.
         FIND Condicion_impos OF Fac_header NO-LOCK.
    
         FIND FIRST Vigencia_cai 
              WHERE Vigencia_cai.cdg_empresa = Sub_header_vta.cdg_empresa
                AND Vigencia_cai.tip_comprob = Sub_header_vta.tip_comprob
                AND Vigencia_cai.prf_comprob = Sub_header_vta.prf_comprob
                AND Vigencia_cai.rige_hasta  >= Sub_header_vta.fecha
                    NO-LOCK NO-ERROR.
         
                  /*------------------------------------------*/
                  /*       OJO CUIDADO OJO!!!!!!!!            */
                  /*------------------------------------------*/

                    IF NOT AVAILABLE Vigencia_cai 
                    THEN DO:
                        CREATE Vigencia_cai.
                        ASSIGN Vigencia_cai.cdg_empresa = Sub_header_vta.cdg_empresa
                               Vigencia_cai.tip_comprob = Sub_header_vta.tip_comprob
                               Vigencia_cai.prf_comprob = Sub_header_vta.prf_comprob
                               Vigencia_cai.rige_hasta  = DATE('31/12/2005')
                               Vigencia_cai.cai         = '123456789'.

                    END.

                  /*------------------------------------------*/
                  /*------------------------------------------*/

         neto = Fac_header.imp_neto * 100.

         CREATE T-Ventas.
         ASSIGN T-Ventas.clave-1 = STRING(INTEGER(Cliente.cdg_cliente),'999999999999')
                T-Ventas.clave-2 = '000000000000'
                T-Ventas.fecha   = YEAR(Sub_header_vta.fecha) * 10000 + MONTH(Sub_header_vta.fecha) * 100 + DAY(Sub_header_vta.fecha)
                T-Ventas.tcomp   = Comprobante.codigo 
                T-Ventas.pvta    = Sub_header_vta.prf_comprob 
                T-Ventas.numero  = Sub_header_vta.nro_comprob
                T-Ventas.numeroh = Sub_header_vta.nro_comprob                                                                        
                T-Ventas.documv  = 80   
                T-Ventas.ndocuv  = Fac_header.cuit
                T-Ventas.nombrv  = Fac_header.nombre
                T-Ventas.imp_to  = INTEGER(Fac_header.imp_total * 100)
                T-Ventas.tipo_r  = INTEGER(Condicion_impos.codigo)
                T-Ventas.moneda  = 'PES'
                T-Ventas.cambio  = 1000000
                T-Ventas.cai     = Vigencia_cai.cai
                T-Ventas.vto_cai = YEAR(Vigencia_cai.rige_hasta) * 10000 + MONTH(Vigencia_cai.rige_hasta) * 100 + DAY(Vigencia_cai.rige_hasta).
                                   /*----*/

         xalic = 0.
         IF Sub_header_vta.tip_comprob MATCHES '*E*'
            THEN T-Ventas.operac = 'E'.
         
         FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto:
    
                CASE Impuesto.tipo_impuesto:       
        	        WHEN 'IV' 
    	              THEN DO:
                           T-Ventas.calic = T-Ventas.calic + 1. 
                           xalic        = xalic + (Impuesto.tasa * 100).
    	                   T-Ventas.impue  = T-Ventas.impue + Fac_header_impuesto.importe * 100.
    	                   T-Ventas.alicuo = T-Ventas.alicuo + INT((Fac_header_impuesto.importe * 10000 / neto) * 100).  	                   
      	                   IF xalic = 0
      	                   THEN DO:
                                   T-Ventas.calic = T-Ventas.calic + 1. 
                                   xalic         = xalic + (Impuesto.tasa * 100).
                           END.
                               
                      END.
                    WHEN 'PE' THEN T-Ventas.imp_pc  = T-Ventas.imp_pc  + Fac_header_impuesto.importe * 100.                
                    WHEN 'IB' THEN T-Ventas.imp_ib  = T-Ventas.imp_ib  + Fac_header_impuesto.importe * 100.
                    WHEN 'IM' THEN T-Ventas.imp_im  = T-Ventas.imp_im  + Fac_header_impuesto.importe * 100.
                    WHEN 'II' THEN T-Ventas.imp_ii  = T-Ventas.imp_ii  + Fac_header_impuesto.importe * 100.
                    WHEN 'RN' THEN T-Ventas.impueni = T-Ventas.impueni + Fac_header_impuesto.importe * 100.
                    
                END CASE.                
         END.

         xx = 0.
         IF abs(xalic - T-Ventas.alicuo) > 100
         then do:                          
              message xalic T-Ventas.alicuo view-as alert-box.
              xx             = neto  - (T-Ventas.impue / xalic).    
              neto           = neto - xx.
              T-Ventas.alicuo  = xalic * 100.
         end.
    
         ASSIGN T-Ventas.imp_neg = INTEGER(neto).
         
         IF xx > 0 AND T-Ventas.alicuo = 0
         THEN DO:
              T-Ventas.imp_ex = xx.
              T-Ventas.operac = 'E'.
         END.     
         ELSE T-Ventas.imp_nog = xx.

         ASSIGN T-Total_ventas.ccomp    = T-Total_ventas.ccomp + 1.
                T-Total_ventas.imp_to   = T-Total_ventas.imp_to  + (sig * T-Ventas.imp_to).
                T-Total_ventas.imp_nog  = T-Total_ventas.imp_nog + (sig * T-Ventas.imp_nog).
                T-Total_ventas.imp_neg  = T-Total_ventas.imp_neg + (sig * T-Ventas.imp_neg).
                T-Total_ventas.impue    = T-Total_ventas.impue   + (sig * T-Ventas.impue).
                T-Total_ventas.impueni  = T-Total_ventas.impueni + (sig * T-Ventas.impueni).            
                T-Total_ventas.imp_ex   = T-Total_ventas.imp_ex  + (sig * T-Ventas.imp_ex).
                T-Total_ventas.imp_pc   = T-Total_ventas.imp_pc  + (sig * T-Ventas.imp_pc).
                T-Total_ventas.imp_ib   = T-Total_ventas.imp_ib  + (sig * T-Ventas.imp_ib).
                T-Total_ventas.imp_im   = T-Total_ventas.imp_im  + (sig * T-Ventas.imp_im).
                T-Total_ventas.imp_ii   = T-Total_ventas.imp_ii  + (sig * T-Ventas.imp_ii).

    END.    
    
    FOR EACH T-Ventas:
        PUT    
            T-Ventas.clave-1     FORMAT '"X(12)"'
            SPACE(1)
            T-Ventas.clave-2     FORMAT '"X(12)"'
            SPACE(1)
            SPACE(1)
            T-Ventas.tipo        FORMAT '"X(1)"' 
            SPACE(1)
            T-Ventas.fecha       FORMAT '99999999'
            SPACE(1)
            T-Ventas.tcomp       FORMAT '99'
            SPACE(1)
            T-Ventas.contr       FORMAT '"X(1)"' 
            SPACE(1)
            T-Ventas.pvta        FORMAT '9999'
            SPACE(1)
            T-Ventas.numero      FORMAT '99999999'
            SPACE(1)
            T-Ventas.numeroh     FORMAT '99999999'
            SPACE(1)
            T-Ventas.documv      FORMAT '99'   
            SPACE(1)
            T-Ventas.ndocuv      FORMAT 'X(11)'
            SPACE(1)
            T-Ventas.nombrv      FORMAT '"X(30)"'
            SPACE(1)
            T-Ventas.imp_to      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_nog     FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_neg     FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.alicuo      FORMAT '9999.99'
            SPACE(1)
            T-Ventas.impue       FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.impueni     FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_ex      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_pc      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_ib      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_im      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.imp_ii      FORMAT '9999999999999.99'
            SPACE(1)
            T-Ventas.tipo_r      FORMAT '99'
            SPACE(1)
            T-Ventas.moneda      FORMAT '"X(3)"'
            SPACE(1)
            T-Ventas.cambio      FORMAT '9999999999'
            SPACE(1)
            T-Ventas.calic       FORMAT '9'
            SPACE(1)
            T-Ventas.operac      FORMAT '"X(1)"'
            SPACE(1)
            T-Ventas.cai         FORMAT '"X(30)"'
            SPACE(1)
            T-Ventas.vto_cai     FORMAT '99999999'
            SPACE(1)
            T-Ventas.relleno     FORMAT '"X(50)"'
            SKIP.
    END.    

/*
    PUT 
        '"000000000000" '        FORMAT 'X(15)'
        SPACE(1)
        '"000000000000" '        FORMAT 'X(15)'
        SPACE(1)
        '"'                      FORMAT 'X(1)'
        SPACE(1)
        T-Total_ventas.tipo      FORMAT 'X(1)' 
        SPACE(1)
        T-Total_ventas.periodo   FORMAT '999999'
        SPACE(1)
        T-Total_ventas.relle1    FORMAT 'X(17)' 
        SPACE(1)
        T-Total_ventas.ccomp     FORMAT '9999'
        SPACE(1)
        T-Total_ventas.relle2    FORMAT 'X(18)' 
        SPACE(1)
        T-Total_ventas.ndocuv    FORMAT 'X(15)' 
        SPACE(1)
        T-Total_ventas.relle3    FORMAT 'X(18)' 
        SPACE(1)
        T-Total_ventas.imp_to    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_nog   FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_neg   FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.relle4    FORMAT 'X(6)' 
        SPACE(1)
        T-Total_ventas.impue     FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.impueni   FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_ex    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_pc    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_ib    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_im    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.imp_ii    FORMAT '999999999999999'
        SPACE(1)
        T-Total_ventas.relle5    FORMAT 'X(113)' 

        '"'                      FORMAT 'X(1)'
        SKIP.
*/
END PROCEDURE.

PROCEDURE crear_comprobante:

    DEFINE INPUT PARAMETER p-codigo      LIKE Comprobante.codigo.
    DEFINE INPUT PARAMETER p-descripcion LIKE Comprobante.descripcion.
    DEFINE INPUT PARAMETER p-tip_comprob LIKE Comprobante.tip_comprob.

    CREATE Comprobante.
    ASSIGN Comprobante.codigo      = p-codigo
           Comprobante.descripcion = p-descripcion
           Comprobante.tip_comprob = p-tip_comprob.

END PROCEDURE.
