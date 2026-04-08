/*=================================================================================*/
/*                       FACTURACION POR IMPRESORA FISCAL                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER rid_factura AS ROWID.

/*=================================================================================*/
/*                               VARIABLES                                         */
/*=================================================================================*/

DEFINE VARIABLE X                       AS INTEGER.
DEFINE VARIABLE err-os                  AS INTEGER.
DEFINE VARIABLE resto                   AS INTEGER.
DEFINE VARIABLE v-iva                   AS DECIMAL FORMAT ">9.99".
DEFINE VARIABLE v-leyenda1              AS CHARACTER FORMAT "X(49)".
DEFINE VARIABLE v-leyenda2              AS CHARACTER FORMAT "X(49)".
DEFINE VARIABLE v-leyendas              AS CHARACTER FORMAT "X(49)".
DEFINE VARIABLE v-num_estab             AS CHARACTER FORMAT "X(63)".
DEFINE VARIABLE v-vencimientos          AS CHARACTER FORMAT "X(63)".
DEFINE VARIABLE v-direccion             AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-descuento             AS DECIMAL FORMAT ">>>9.99". 
DEFINE VARIABLE v-descuento_iva         AS DECIMAL FORMAT ">9.99".
DEFINE VARIABLE v-desc                  AS DECIMAL FORMAT ">9.99".
DEFINE VARIABLE v-localidad             AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-codigo_postal         AS CHARACTER FORMAT "X(7)".
DEFINE VARIABLE v-cliente               AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-comprobante           AS INTEGER FORMAT "99999999".
DEFINE VARIABLE Contador                AS INTEGER FORMAT "999999999".
DEFINE VARIABLE prciva                  LIKE Impuesto.tasa FORMAT ">9.99".
DEFINE VARIABLE importe_iva             LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi             LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-formapago             AS CHARACTER FORMAT "X(20)".
DEFINE VARIABLE v-imptotal              AS DECIMAL FORMAT ">>>>>>>>>9.99".
DEFINE VARIABLE coeficiente_detalle     AS DECIMAL.
DEFINE VARIABLE coeficiente_general     AS DECIMAL.
DEFINE VARIABLE v-cdg_articulo          AS CHARACTER FORMAT "X(10)".
DEFINE VARIABLE v-desc_articulo         AS CHARACTER FORMAT "X(44)".
DEFINE VARIABLE v-fdcant                AS INTEGER FORMAT ">>>9.99".
DEFINE VARIABLE v-fdprecio              AS DECIMAL FORMAT ">>>>>>9.99".
DEFINE VARIABLE v-condimpos             AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-pc_name               AS CHARACTER FORMAT "X(44)".
DEFINE VARIABLE v-valor_c               AS CHARACTER.
DEFINE VARIABLE v-valor_d               AS DECIMAL.
DEFINE VARIABLE v-valor_l               AS LOGICAL.
DEFINE VARIABLE v-valor_n               AS INTEGER.
DEFINE VARIABLE v-observacion           AS CHARACTER.
DEFINE VARIABLE v-leyenda_cc            AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE Contador-art            AS INTEGER.
DEFINE VARIABLE v-hora                  AS INTEGER.

DEFINE VARIABLE dir_salida              AS CHARACTER.
DEFINE VARIABLE linea                   AS CHARACTER.
DEFINE VARIABLE v-hms                   AS CHARACTER.
DEFINE VARIABLE v-hms1                  AS CHARACTER.
DEFINE VARIABLE v-control               AS CHARACTER FORMAT "X(18)".
DEFINE VARIABLE v-salida                AS CHARACTER.
DEFINE VARIABLE v-factura               AS CHARACTER.
DEFINE VARIABLE v-remito                AS CHARACTER.

DEFINE STREAM Factura.
DEFINE STREAM Remito.

/*=========================================================================================*/
/*                           B L O Q U E   P R I N C I P A L                               */
/*=========================================================================================*/

 DO TRANSACTION: 

    FIND Fac_header WHERE ROWID(Fac_header) = rid_factura EXCLUSIVE-LOCK.

    v-control = Fac_header.tip_comprob + "-" + STRING(Fac_header.prf_comprob,"9999") + "-" + STRING(Fac_header.nro_comprob,"99999999").

    v-vencimientos = "".
    FOR EACH Cta_cte 
        WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa
          AND Cta_cte.tip_comprob = Fac_header.tip_comprob
          AND Cta_cte.prf_comprob = Fac_header.prf_comprob
          AND Cta_cte.nro_comprob = Fac_header.nro_comprob
              NO-LOCK:
        v-vencimientos = v-vencimientos + " " + 
                         STRING(Cta_cte.fecha_vencimiento) + " " + 
                         TRIM(STRING(Cta_cte.debito,">>>>>>9.99")).
    END.
    v-vencimientos = "Vencimientos:" + v-vencimientos.

    FIND FIRST Punto-venta WHERE Punto-venta.cdg_empresa = Fac_header.cdg_empresa
                           AND Punto-venta.cdg_puntovta = Fac_header.prf_comprob
                           NO-LOCK.
    v-comprobante   = Fac_header.nro_comprob.
    v-leyenda_cc    = Fac_header.leyenda_cc.

    v-num_estab     = TRIM(Punto-venta.direccion) + " " + 
                      Punto-venta.localidad.             

    IF Fac_header.leyenda <> ""
    THEN DO:
        RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                        INPUT  49,
                        OUTPUT v-leyendas,
                        INPUT  "|").

        v-leyenda1 = ENTRY(1,v-leyendas,"|").
        IF NUM-ENTRIES(v-leyendas,"|") > 1 
            THEN v-leyenda2 = ENTRY(2,v-leyendas,"|").
            ELSE v-leyenda2 = "-".

    END.
    ELSE DO:
        v-leyenda1 = FILL(" ",49).
        v-leyenda2 = FILL(" ",49).
    END.

    FIND Empresa OF Fac_header NO-LOCK.
    FIND Condicion_impos OF Fac_header NO-LOCK.
    
    /*
    CASE Condicion_impos.cdg_condiva:         /*     I / N / M / T / E /C  */
        WHEN 01 THEN v-condimpos = "I".
        WHEN 04 THEN v-condimpos = "C".
        WHEN 07 THEN v-condimpos = "M".
        WHEN 10 THEN v-condimpos = "E".
    END CASE.
    */
    
    v-condimpos = Condicion_impos.codigo_migracion. 

    FIND Condicion_venta OF Fac_header NO-LOCK.     
    FIND Cliente OF Fac_header NO-LOCK NO-ERROR.
    v-cliente = Cliente.nom_cliente. 
    FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
    FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.
    FIND Fac_header_impuesto OF Fac_header
         WHERE Fac_header_impuesto.cdg_impuesto = 1
         NO-LOCK NO-ERROR.
    IF AVAILABLE Fac_header_impuesto
        THEN prciva = Fac_header_impuesto.tasa.           
        ELSE prciva = 0.


    RUN getparametro.p (  INPUT  "DIRSALCF",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
    dir_salida = v-valor_c + "\cf" + STRING(Fac_header.prf_comprob,"9999").

    OUTPUT TO VALUE(dir_salida + "\archivo.xxx") PAGE-SIZE 0.
    
    PUT "[DATOS EMPRESA]"                                             SKIP.
    PUT "PUERTO   =".
    
    RUN getparametro.p (  INPUT  "NROPUECF",
                          OUTPUT v-valor_c,
                          OUTPUT v-valor_d,
                          OUTPUT v-valor_l,
                          OUTPUT v-valor_n,
                          OUTPUT v-observacion ).
        
    PUT STRING(v-valor_n)                                             SKIP.
    PUT "CABEZA1  =".                      
    PUT v-num_estab                                                   SKIP.
    PUT "CABEZA2  =Tel:".
    PUT Punto-venta.telefono.
    PUT " Rotativas - ventas@fercolor.com.ar "                        SKIP.
    PUT "IVA.INC  =N                                                " SKIP.
    PUT "[]                                                         " SKIP.
    PUT SKIP(1). 
    PUT "[CABEZA]                                                   " SKIP. 
    PUT "CODIGO   =". 
    PUT Cliente.cdg_cliente                                           SKIP. 
    PUT "NOMBRE   =".
    PUT v-cliente                                                     SKIP.
    PUT "DNI_CUIT =                                                 " SKIP.
    PUT "DNI      =                                                 " SKIP.
    PUT "CUIT     =".
    PUT  Cliente.cuit                                                 SKIP.
    PUT "CAT.IMPOS=".
    PUT v-condimpos                                                   SKIP.
    PUT "DIRECCION=".

    FIND FIRST Domicilio OF Fac_header NO-LOCK NO-ERROR.
    IF AVAILABLE Domicilio 
    THEN DO:
        PUT  Domicilio.direccion                                          SKIP.
        PUT "LOCALIDAD=".
        PUT  Domicilio.localidad                                          SKIP.
    END.
    ELSE DO:
        PUT SKIP.
        PUT "LOCALIDAD=".
        PUT SKIP.
    END.

    PUT "VENDEDOR =".
    PUT Vendedor.cdg_vendedor                                         SKIP.
    PUT "TELEFONO =".
    PUT Cliente.telefonos                                             SKIP.
    PUT "DOCUMENTO=".
    CASE SUBSTRING(Fac_header.tip_comprob,1,1):
        WHEN "F" THEN PUT "FA" SKIP.
        WHEN "C" THEN PUT "NC" SKIP.
        WHEN "D" THEN PUT "ND" SKIP.
    END CASE.
    PUT "NRO.DOC  =".
    PUT  v-comprobante                                                SKIP.

    IF SUBSTRING(Fac_header.tip_comprob,1,1) = "C"
    THEN DO:
        IF v-leyenda_cc <> ""
        THEN DO: 
            PUT "FAC.REL  =".
            PUT v-leyenda_cc SKIP.
        END.
        ELSE DO:
            PUT "FAC.REL  =<<< SIN ASIGNAR >>>" SKIP.
        END.
    END.
    ELSE DO:
        PUT "FAC.REL  =" SKIP.
    END.
        
    coeficiente_general = 1.
    FOR EACH Fac_header-bon OF Fac_header WHERE Fac_header-bon.cdg_bonificacion < 90 NO-LOCK :
        coeficiente_general = coeficiente_general * ( 1 - Fac_header-bon.porcentaje / 100 ).
    END.

    FIND FIRST Fac_header-bon OF Fac_header WHERE Fac_header-bon.cdg_bonificacion >= 90 NO-LOCK NO-ERROR.
    IF AVAILABLE Fac_header-bon 
    THEN DO:
         PUT "%DESC    =".
         PUT Fac_header-bon.porcentaje SKIP.
         PUT "IMP.DESC =".
         PUT STRING(Fac_header-bon.importe, "ZZZZ9.99") SKIP.
    END.
    ELSE DO:
         PUT "%DESC    =0" SKIP.
         PUT "IMP.DESC =0.00" SKIP.
    END.
    
    PUT "IVA.DESC =".
    PUT prciva SKIP. 
    PUT "F.PAGO1  =".
    v-formapago = Condicion_venta.descripcion.
    PUT v-formapago.
    v-imptotal = Fac_header.imp_total.
    PUT v-imptotal SKIP.
    PUT "F.PAGO2  = ...                                             " SKIP.
    PUT "F.PAGO3  =                                                 " SKIP.
    PUT "F.PAGO4  =                                                 " SKIP.
    PUT "MENSAJE1 =" .
    PUT v-leyenda1 SKIP.
    PUT "MENSAJE2 =" .
    PUT v-leyenda2 SKIP.
    PUT "MENSAJE3 = Ctrl." v-control " " v-vencimientos               SKIP.
    PUT "[]                                                         " SKIP.
    PUT SKIP(1).   
    PUT "[CUERPO]                                                   " SKIP.
    
    Contador = 0.

    IF NOT cliente.condensado_sino 
    THEN DO:

        FOR EACH Fac_detalle OF Fac_header NO-LOCK, 
                         Articulo OF Fac_detalle, 
                         Partida OF Fac_detalle 
                         BREAK BY Fac_detalle.nro_linea :

            coeficiente_detalle = coeficiente_general.
            FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK :
                coeficiente_detalle = coeficiente_detalle * ( 1 - Fac_detalle-bon.porcentaje / 100 ).
            END.

            Contador = Contador + 1.
        
            PUT STRING(Contador) FORMAT "X(9)".
            PUT "=".

            v-cdg_articulo = Articulo.cdg_articulo.
            v-desc_articulo = Partida.descripcion.
            v-fdcant = Fac_detalle.cantidad.
            v-fdprecio = Fac_detalle.precio * coeficiente_detalle.

            PUT v-cdg_articulo  FORMAT "X(10)".
            PUT v-desc_articulo FORMAT "X(44)".
            PUT v-fdcant        FORMAT ">>>9.99".
            PUT v-fdprecio      FORMAT ">>>>>>9.99".

            PUT prciva SKIP.
        
            IF LAST-OF(Fac_detalle.nro_linea) 
                THEN resto = 17 - Contador.
        
        END.  
    END.

    Contador-art = 0.
    
    IF cliente.condensado_sino 
    THEN DO:
        FOR EACH Fac_detalle OF Fac_header NO-LOCK, 
                         Articulo OF Fac_detalle  
                         BREAK BY Fac_detalle.nro_articulo 
                               BY Fac_detalle.precio:
            v-fdcant = v-fdcant + Fac_detalle.cantidad.
                                    
            IF LAST-OF(Fac_detalle.precio) 
            THEN DO:
            
                Contador = Contador + 1.
                        
                PUT STRING(Contador) FORMAT "X(9)".
                PUT "=".

                coeficiente_detalle = coeficiente_general.
                FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK :
                    coeficiente_detalle = coeficiente_detalle * ( 1 - Fac_detalle-bon.porcentaje / 100 ).
                END.

                v-cdg_articulo = Articulo.cdg_articulo.
                v-desc_articulo = Articulo.descripcion.
                v-fdprecio = Fac_detalle.precio * coeficiente_detalle.

                PUT v-cdg_articulo  FORMAT "X(10)".
                PUT v-desc_articulo FORMAT "X(44)".
                PUT v-fdcant        FORMAT ">>>9.99".
                PUT v-fdprecio      FORMAT ">>>>>>9.99".
                PUT prciva SKIP.     

                v-fdcant = 0.
                     
            END.

            resto = 17 - Contador.

        END.  
   END.

    DO X = 1 TO resto:                  /* esto es para completar las lineas vacias */
        Contador = Contador + 1.
        PUT string(Contador) FORMAT "X(9)".
        PUT "=" SKIP.
    END.

    PUT "[]" SKIP.
    OUTPUT CLOSE.

/*      RUN veresult.w ( INPUT dir_salida + "\archivo.xxx",INPUT 22 ).*/
    v-hora = TIME.

/*         v-hms  = CHR(MONTH(TODAY) + 64 ) + CHR(DAY(TODAY) + 64) + REPLACE(STRING(v-hora,"HH:MM:SS"),":","").      */
/*         v-hms1 = CHR(MONTH(TODAY) + 64 ) + CHR(DAY(TODAY) + 64) + REPLACE(STRING(v-hora + 1,"HH:MM:SS"),":","").  */

    v-hms  = STRING(DAY(TODAY),"99") + REPLACE(STRING(v-hora,"HH:MM:SS"),":","").
    v-hms1 = STRING(DAY(TODAY),"99") + REPLACE(STRING(v-hora + 1,"HH:MM:SS"),":","").
    
    v-salida = dir_salida + "\archivo.xxx".
    v-factura = dir_salida + "\" + v-hms + ".fac".

    OS-RENAME VALUE(v-salida) VALUE(v-factura).        
    err-os = OS-ERROR.
    IF err-os <> 0
       THEN MESSAGE "No pudo hacerse rename de archivo FACTURA. Código de Razón:" err-os
        VIEW-AS ALERT-BOX ERROR TITLE "Error de Sistema Operativo".

    IF SUBSTRING(Fac_header.tip_comprob,1,1) = "F"
    THEN DO:

        v-remito = dir_salida + "\" + v-hms1 + ".rem".

        INPUT STREAM Factura FROM VALUE(v-factura).
        OUTPUT STREAM Remito TO VALUE(v-remito).
        REPEAT:
            IMPORT STREAM Factura UNFORMATTED linea.
            linea = REPLACE(linea,"DOCUMENTO=FA","DOCUMENTO=RE").
            PUT STREAM Remito UNFORMATTED linea SKIP.
        END.
        INPUT STREAM Factura CLOSE.
        OUTPUT STREAM Remito CLOSE.

        v-factura = REPLACE(v-remito,".rem",".fac").
        OS-RENAME VALUE(v-remito) VALUE(v-factura).
        err-os = OS-ERROR.
        IF err-os <> 0
           THEN MESSAGE "No pudo hacerse rename de archivo REMITO. Código de Razón:" err-os
            VIEW-AS ALERT-BOX ERROR TITLE "Error de Sistema Operativo".

    END.

END.
 
