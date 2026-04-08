/*=============================================================================================================================*/
/*                               GENERACION DE INTERFACE DE ACUERDO A LA RESOLUCIÓN RG 1361                                    */
/*=============================================================================================================================*/

DEFINE INPUT PARAMETER des_fecha AS DATE.
DEFINE INPUT PARAMETER has_fecha AS DATE.

/*{VRSHARED.I "NEW"}*/
{WGLISTAR.I}

DEFINE VARIABLE org_formato  AS CHARACTER.
org_formato = SESSION:NUMERIC-FORMAT.
SESSION:NUMERIC-FORMAT = "American".

DEFINE STREAM Venta.

DEFINE VARIABLE neto      LIKE Sub_detalle_vta.valor.
DEFINE VARIABLE sig       AS INTEGER.
DEFINE VARIABLE xalic     LIKE Impuesto.tasa.
DEFINE VARIABLE cuit      LIKE Fac_header.cuit.
DEFINE VARIABLE nombre    LIKE Fac_header.nombre.
DEFINE VARIABLE totall    LIKE Fac_header.imp_total.

DEFINE TEMP-TABLE Ventas
   FIELD tipo       AS CHARACTER FORMAT "X(1)" INITIAL "1"
   FIELD fecha      AS INTEGER FORMAT "99999999"
   FIELD tcomp      AS INTEGER FORMAT "99"
   FIELD contr      AS CHARACTER FORMAT "X(1)" INITIAL " "
   FIELD pvta       AS INTEGER FORMAT "9999"
   FIELD numero     AS INTEGER FORMAT "99999999"
   FIELD numeroh    AS INTEGER FORMAT "99999999"
   FIELD documv     AS INTEGER FORMAT "99"   
   FIELD ndocuv     AS CHARACTER FORMAT "X(15)"
   FIELD nombrv     AS CHARACTER FORMAT "X(30)"
   FIELD imp_to     AS INTEGER FORMAT "999999999999999"
   FIELD imp_nog    AS INTEGER FORMAT "999999999999999"
   FIELD imp_neg    AS INTEGER FORMAT "999999999999999"
   FIELD alicuo     AS INTEGER FORMAT "999999"
   FIELD impue      AS INTEGER FORMAT "999999999999999"
   FIELD impueni    AS INTEGER FORMAT "999999999999999"
   FIELD imp_ex     AS INTEGER FORMAT "999999999999999"
   FIELD imp_pc     AS INTEGER FORMAT "999999999999999"
   FIELD imp_ib     AS INTEGER FORMAT "999999999999999"
   FIELD imp_im     AS INTEGER FORMAT "999999999999999"
   FIELD imp_ii     AS INTEGER FORMAT "999999999999999"
   FIELD tipo_r     AS INTEGER FORMAT "99"
   FIELD moneda     AS CHARACTER FORMAT "X(3)"
   FIELD cambio     AS INTEGER FORMAT "999999"
   FIELD calic      AS INTEGER FORMAT "9"
   FIELD operac     AS CHARACTER FORMAT "X(1)" INITIAL " "
   FIELD cai        AS CHARACTER FORMAT "X(30)"
   FIELD vto_cai    AS INTEGER FORMAT "99999999"
   FIELD fec_cai    AS INTEGER FORMAT "99999999"   
   FIELD relleno    AS CHARACTER FORMAT "X(50)" 
                    INITIAL "00000000000000000000000000000000000000000000000000"
   INDEX Ventas IS PRIMARY fecha tcomp pvta numero ASCENDING.

DEFINE TEMP-TABLE T-Ventas
   FIELD tipo       AS CHARACTER FORMAT "X(1)" INITIAL "2"
   FIELD periodo    AS INTEGER FORMAT "999999"
   FIELD relle1     AS CHARACTER FORMAT "X(17)"
   FIELD ccomp      AS INTEGER FORMAT "9999"
   FIELD relle2     AS CHARACTER FORMAT "X(18)"
   FIELD ndocuv     AS CHARACTER FORMAT "X(15)"
   FIELD relle3     AS CHARACTER FORMAT "X(45)"
   FIELD imp_to     AS INTEGER FORMAT "999999999999999"
   FIELD imp_nog    AS INTEGER FORMAT "999999999999999"
   FIELD imp_neg    AS INTEGER FORMAT "999999999999999"
   FIELD relle4     AS CHARACTER FORMAT "X(6)"
   FIELD impue      AS INTEGER FORMAT "999999999999999"
   FIELD impueni    AS INTEGER FORMAT "999999999999999"   
   FIELD imp_ex     AS INTEGER FORMAT "999999999999999"
   FIELD imp_pc     AS INTEGER FORMAT "999999999999999"
   FIELD imp_ib     AS INTEGER FORMAT "999999999999999"
   FIELD imp_im     AS INTEGER FORMAT "999999999999999"
   FIELD imp_ii     AS INTEGER FORMAT "999999999999999"
   FIELD relle5     AS CHARACTER FORMAT "X(113)".

DEFINE VARIABLE xx        LIKE Ventas.imp_to.

mensaje = "Procesando ...".
DISPLAY mensaje WITH FRAME frm-espere.


OUTPUT TO VALUE("c:\sic-temp\ventas.txt").

RUN exportar_ventas.
  
OUTPUT STREAM Venta CLOSE. 

SESSION:NUMERIC-FORMAT = org_formato.

PAUSE 0.
HIDE FRAME frm-espere.

message "Exportación exitosa" view-as alert-box.


/*===========================================================================================*/
/*                               P R O C E D I M I E N T O S                                 */
/*===========================================================================================*/

PROCEDURE exportar_ventas:

{findempresa.i}
CREATE T-Ventas.
ASSIGN T-Ventas.periodo  = YEAR(has_fecha) * 100 + MONTH(has_fecha)
       T-Ventas.ndocuv   = Empresa.cuit.


FOR EACH Sub_header_vta WHERE Sub_header_vta.fecha >= des_fecha 
                          AND Sub_header_vta.fecha <= has_fecha
                          AND Sub_header_vta.cdg_empresa = Empresa.cdg_empresa,
                          FIRST Tipocomprobante OF Sub_header_vta WHERE NOT Tipocomprobante.es_interno:
     
    sig = IF Tipocomprobante.debita THEN 1 ELSE -1 .
    /*FIND Comprobante OF Sub_header_vta NO-ERROR.
     IF NOT AVAILABLE Comprobante 
     then FIND Comprobante WHERE Comprobante.codigo = 39.*/
     
     FIND Fac_header WHERE Sub_header_vta.tip_comprob   = Fac_header.tip_comprob
                       AND Sub_header_vta.prf_comprob   = Fac_header.prf_comprob
                       AND Sub_header_vta.nro_comprob   = Fac_header.nro_comprob NO-ERROR.
     
     FIND Cliente OF Fac_header.
     FIND Condicion_impos OF Fac_header NO-LOCK.
     cuit    = Fac_header.cuit.
     nombre  = Fac_header.nombre.
     totall  = Fac_header.imp_total.
     
     neto = Fac_header.imp_neto * 100.              

     FIND Parametro 
         WHERE Parametro.cdg_parametro = "CLAUTIM" + Condicion_impos.tipo_factura
           AND Parametro.cdg_empresa = Empresa.cdg_empresa.

     DEFINE VARIABLE iday AS INTEGER.
     DEFINE VARIABLE imon AS INTEGER.
     DEFINE VARIABLE iyr AS INTEGER.
     DEF VAR FEC_C AS CHARACTER FORMAT "X(10)".
     FEC_C = substring(valor_c,40,10).

     imon = INTEGER(SUBSTR(fec_c,4,2)).
     iday = INTEGER(SUBSTR(fec_c,1,2)).
     iyr = INTEGER(SUBSTR(fec_c,9,2)) + 2000.
     
     CREATE Ventas.
     ASSIGN Ventas.fecha   = YEAR(Sub_header_vta.fecha) * 10000 + MONTH(Sub_header_vta.fecha) * 100 + DAY(Sub_header_vta.fecha)
            Ventas.tcomp   = 39 /*Comprobante.codigo*/ 
            Ventas.pvta    = Sub_header_vta.prf_comprob 
            Ventas.numero  = Sub_header_vta.nro_comprob
            Ventas.numeroh = Sub_header_vta.nro_comprob                                                                        
            Ventas.documv  = 80   
            Ventas.ndocuv  = cuit
            Ventas.nombrv  = nombre
            Ventas.imp_to  = INT(totall * 100)
            Ventas.tipo_r  = INTEGER(Condicion_impos.codigo)
            Ventas.moneda  = "PES"
            Ventas.cambio  = 1000000
            Ventas.cai     = substring(Parametro.valor_c,11,15)
            Ventas.vto_cai = iyr * 10000 + imon * 100 + iday.


     xalic = 0.
     IF Sub_header_vta.tip_comprob MATCHES "*E*"
     THEN Ventas.operac = "E".
     
     FOR EACH Fac_header_impuesto OF Fac_header, FIRST Impuesto OF Fac_header_impuesto:

     
            CASE SUBSTRING(Impuesto.texto,1,2):       
	        WHEN "IV" 
	              THEN DO:
                       Ventas.calic = Ventas.calic + 1. 
                       xalic        = xalic + (Impuesto.tasa * 100).
	                   Ventas.impue  = Ventas.impue + Sub_detalle_vta.valor * 100.
	                   Ventas.alicuo = Ventas.alicuo + INT((Sub_detalle_vta.valor * 10000 / neto) * 100).  	                   
  	                   IF xalic = 0
  	                   THEN DO:
                               Ventas.calic = Ventas.calic + 1. 
                               xalic         = xalic + (Impuesto.tasa * 100).
                           END.
                           
                      END.
                WHEN "PE" THEN Ventas.imp_pc  = Ventas.imp_pc  + Sub_detalle_vta.valor * 100.                
                WHEN "IB" THEN Ventas.imp_ib  = Ventas.imp_ib  + Sub_detalle_vta.valor * 100.
                WHEN "IM" THEN Ventas.imp_im  = Ventas.imp_im  + Sub_detalle_vta.valor * 100.
                WHEN "II" THEN Ventas.imp_ii  = Ventas.imp_ii  + Sub_detalle_vta.valor * 100.
                WHEN "RN" THEN Ventas.impueni = Ventas.impueni + Sub_detalle_vta.valor * 100.
                
            END CASE.                
     END.

     xx = 0.
     IF abs(xalic - Ventas.alicuo) > 100
     then do:                          
          message xalic ventas.alicuo view-as alert-box.
          xx             = neto  - (Ventas.impue / xalic).    
          neto           = neto - xx.
          Ventas.alicuo  = xalic * 100.
     end.

     ASSIGN Ventas.imp_neg = INT(neto).
     
     IF xx > 0 AND Ventas.alicuo = 0
     THEN DO:
          Ventas.imp_ex = xx.
          Ventas.operac = "E".
     END.     
     ELSE Ventas.imp_nog = xx.

     ASSIGN T-Ventas.ccomp    = T-Ventas.ccomp + 1
            T-Ventas.imp_to   = T-Ventas.imp_to  + (sig * Ventas.imp_to)
            T-Ventas.imp_nog  = T-Ventas.imp_nog + (sig * Ventas.imp_nog)
            T-Ventas.imp_neg  = T-Ventas.imp_neg + (sig * Ventas.imp_neg)
            T-Ventas.impue    = T-Ventas.impue   + (sig * Ventas.impue)
            T-Ventas.impueni  = T-Ventas.impueni + (sig * Ventas.impueni)            
            T-Ventas.imp_ex   = T-Ventas.imp_ex  + (sig * Ventas.imp_ex)
            T-Ventas.imp_pc   = T-Ventas.imp_pc  + (sig * Ventas.imp_pc)
            T-Ventas.imp_ib   = T-Ventas.imp_ib  + (sig * Ventas.imp_ib)
            T-Ventas.imp_im   = T-Ventas.imp_im  + (sig * Ventas.imp_im)
            T-Ventas.imp_ii   = T-Ventas.imp_ii  + (sig * Ventas.imp_ii).

END.    

FOR EACH Ventas:
    PUT    
        Ventas.tipo        FORMAT "X(1)" 
        Ventas.fecha       FORMAT "99999999"
        Ventas.tcomp       FORMAT "99"
        Ventas.contr       FORMAT "X(1)" 
        Ventas.pvta        FORMAT "9999"
        Ventas.numero      FORMAT "99999999"
        Ventas.numeroh     FORMAT "99999999"
        Ventas.documv      FORMAT "99"   
        Ventas.ndocuv      FORMAT "X(15)"
        Ventas.nombrv      FORMAT "X(30)"
        Ventas.imp_to      FORMAT "999999999999999"
        Ventas.imp_nog     FORMAT "999999999999999"
        Ventas.imp_neg     FORMAT "999999999999999"
        Ventas.alicuo      FORMAT "999999"
        Ventas.impue       FORMAT "999999999999999"
        Ventas.impueni     FORMAT "999999999999999"
        Ventas.imp_ex      FORMAT "999999999999999"
        Ventas.imp_pc      FORMAT "999999999999999"
        Ventas.imp_ib      FORMAT "999999999999999"
        Ventas.imp_im      FORMAT "999999999999999"
        Ventas.imp_ii      FORMAT "999999999999999"
        Ventas.tipo_r      FORMAT "99"
        Ventas.moneda      FORMAT "X(3)"
        Ventas.cambio      FORMAT "9999999999"
        Ventas.calic       FORMAT "9"
        Ventas.operac      FORMAT "X(1)"
        Ventas.cai         FORMAT "X(30)"
        Ventas.vto_cai     FORMAT "99999999"
        Ventas.relleno     FORMAT "X(50)" 
        SKIP.
END.    

PUT    
    T-Ventas.tipo      FORMAT "X(1)" 
    T-Ventas.periodo   FORMAT "999999"
    T-Ventas.relle1    FORMAT "X(17)" 
    T-Ventas.ccomp     FORMAT "9999"
    T-Ventas.relle2    FORMAT "X(18)" 
    T-Ventas.ndocuv    FORMAT "X(15)" 
    T-Ventas.relle3    FORMAT "X(18)" 
    T-Ventas.imp_to    FORMAT "999999999999999"
    T-Ventas.imp_nog   FORMAT "999999999999999"
    T-Ventas.imp_neg   FORMAT "999999999999999"
    T-Ventas.relle4    FORMAT "X(6)" 
    T-Ventas.impue     FORMAT "999999999999999"
    T-Ventas.impueni   FORMAT "999999999999999"
    T-Ventas.imp_ex    FORMAT "999999999999999"
    T-Ventas.imp_pc    FORMAT "999999999999999"
    T-Ventas.imp_ib    FORMAT "999999999999999"
    T-Ventas.imp_im    FORMAT "999999999999999"
    T-Ventas.imp_ii    FORMAT "999999999999999"
    T-Ventas.relle5    FORMAT "X(113)" 
    SKIP.
OUTPUT CLOSE.
END PROCEDURE.

