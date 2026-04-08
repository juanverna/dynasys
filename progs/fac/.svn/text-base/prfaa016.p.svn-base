/*=================================================================================*/
/*                        IMPRESION DE FACTURAS DE TIPO A                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_factura      AS ROWID.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

DEFINE VARIABLE subtotal            AS DECIMAL FORMAT "-ZZZZZ9.99".
DEFINE VARIABLE v-tomo              AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE j-tomo              AS INTEGER.
DEFINE VARIABLE v-bonifs            AS CHARACTER FORMAT "X(21)" .
DEFINE VARIABLE titulo-detalle      AS CHARACTER FORMAT "X(150)".
DEFINE VARIABLE blancos             AS CHARACTER.
DEFINE VARIABLE v-letra             AS CHARACTER FORMAT "X(1)".
DEFINE VARIABLE v-comprobante       AS CHARACTER FORMAT "X(12)" INITIAL "FACTURA".
DEFINE VARIABLE que_articulo        AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_descripcion     AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE que_cantidad        AS CHARACTER FORMAT "X(8)".
DEFINE VARIABLE que_unidad          AS CHARACTER FORMAT "X(5)".
DEFINE VARIABLE que_precio          AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE que_subtotal        AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE nreng               AS INTEGER.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE nt_lineas           AS INTEGER.
DEFINE VARIABLE total_chars         AS INTEGER.
DEFINE VARIABLE ancho_linea         AS INTEGER INITIAL 40.
DEFINE VARIABLE nmax_det            AS INTEGER INITIAL 26.
DEFINE VARIABLE linea0              AS INTEGER.
DEFINE VARIABLE cliobsdc            AS INTEGER.
DEFINE VARIABLE ccoobsdc            AS INTEGER.
DEFINE VARIABLE v-bruto             LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-desc              LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-neto              LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prciva              LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE prcnoi              LIKE Impuesto.tasa FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_iva         LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE importe_noi         LIKE Fac_header.imp_neto FORMAT "Z,ZZZ,ZZ9.99-".
DEFINE VARIABLE v-reng_leyenda      AS INTEGER INITIAL 5.  /* Cantidad de lineas de leyenda */
DEFINE VARIABLE v-leng_leyenda      AS INTEGER INITIAL 90. /* Ancho en chars de la leyenda  */
DEFINE VARIABLE v-leng_detallada    AS INTEGER INITIAL 59. /* Ancho en chars de la leyenda  */
DEFINE VARIABLE v-detallada         AS CHARACTER.
DEFINE VARIABLE v-linea_leyenda     AS CHARACTER EXTENT 10 FORMAT "X(90)".
DEFINE VARIABLE v-monto_letras      AS CHARACTER EXTENT 10 FORMAT "X(90)".
DEFINE VARIABLE v-leng_monto        AS INTEGER INITIAL 90. /* Ancho en chars de la leyenda  */

{VRSHARED.I}
{VPERSINM.I}

DEFINE BUFFER Prov_legal FOR Provincia.

/*=================================================================================*/
/*                                     FRAMES                                      */
/*=================================================================================*/


FORM
    SKIP(1)
    v-letra AT 41
    SKIP(2)
    /*v-comprobante          AT 56*/
    SKIP(2)
    Fac_header.fecha       AT 52
    SKIP(6)
    Fac_header.nombre      AT 12
    "ENTREGAR EN:"         AT 57
    SKIP
    Cliente.cdg_cliente    AT 1
    Cliente.direccion      AT 12
    Fac_header.direccion   AT 57
    SKIP
    Cliente.cdg_postal     AT 12
    Cliente.localidad      
    Fac_header.cdg_postal  AT 57 FORMAT "X(4)"
    Fac_header.localidad
    SKIP
    Provincia.nombre       AT 12
    Prov_legal.nombre      AT 57
    SKIP
    Condicion_impos.texto  AT 12
    Fac_header.cuit        AT 57 FORMAT "X(15)"
    SKIP(1)
    Rem_header.prf_comprob AT 60 FORMAT "9999"
    Rem_header.nro_comprob FORMAT "99999999" 
    SKIP(1)
    Condicion_venta.descripcion  AT 1 
    Cta_cte.fecha_vencimiento
    Fac_header.nro_ocm  AT 60
    SKIP(1)
    /*
    Ped_header.tip_comprob AT 19 FORMAT "X(2)"
    Ped_header.nro_comprob FORMAT ">>>>9"
    
    */
    WITH FRAME frm-encabezado NO-LABELS USE-TEXT STREAM-IO WIDTH 132.

FORM
    SKIP(1)
    "SON" AT 1 
    Moneda.descripcion
    SKIP
    v-monto_letras [ 1 ] AT 1
    SKIP
    v-monto_letras [ 2 ] AT 1
    "Total Bruto" AT 95
    Fac_header.imp_bruto AT 132  FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP
    v-linea_leyenda [ 1 ] AT 1
    /*
    "Descuento" AT 95
    v-desc AT 132  FORMAT "Z,ZZZ,ZZ9.99-"
    */
    SKIP
    v-linea_leyenda [ 2 ] AT 1
    "Total Neto" AT 95
    Fac_header.imp_neto AT 132  FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP
    v-linea_leyenda [ 3 ] AT 1
    prciva AT 95 FORMAT "IVA % 99.99"
    importe_iva AT 132  FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP
    v-linea_leyenda [ 4 ] AT 1
    prcnoi AT 95 FORMAT "Percep BSAS % 99.99"
    importe_noi AT 132  FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP
    v-linea_leyenda [ 5 ] AT 1
    SKIP
    v-linea_leyenda [ 6 ] AT 1
    SKIP
    v-linea_leyenda [ 7 ] AT 1
    SKIP
    v-comprobante AT 1
    Fac_header.tip_comprob
    Fac_header.prf_comprob FORMAT "9999"
    Fac_header.nro_comprob FORMAT "99999999"

    Fac_header.imp_total AT 132 FORMAT "Z,ZZZ,ZZ9.99-"
    SKIP(2)
    WITH FRAME frm-pie SIDE-LABELS USE-TEXT STREAM-IO WIDTH 160 NO-LABELS.

FORM
    Fac_detalle.cantidad AT 1
    Unidad.abrevia      AT 18
    Articulo.cdg_articulo AT 25
    Articulo.descripcion  FORMAT "X(59)" AT 38
    Fac_detalle.precio    AT 100 FORMAT "Z,ZZZ,ZZ9.99" 
    Fac_detalle.subtotal_bruto AT 132
    WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN WIDTH 160 NO-UNDERLINE NO-LABELS. 

FORM
    titulo-detalle
    SKIP(1)
    WITH FRAME frm-titdetalle USE-TEXT STREAM-IO DOWN WIDTH 160 NO-UNDERLINE NO-LABELS. 
    
FORM
    blancos
    WITH FRAME frm-blanco USE-TEXT STREAM-IO DOWN WIDTH 131 NO-LABELS.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

FIND Fac_header WHERE ROWID(Fac_header) = act_factura EXCLUSIVE-LOCK.
FIND Condicion_impos OF Fac_header NO-LOCK.
FIND Condicion_venta OF Fac_header NO-LOCK.
FIND Provincia OF Fac_header NO-LOCK.
FIND Cliente   OF Fac_header NO-LOCK.
FIND Prov_legal OF Cliente NO-LOCK.
FIND Vendedor OF Fac_header NO-LOCK NO-ERROR.
FIND Domicilio OF Fac_header NO-LOCK NO-ERROR.
FIND Moneda OF Fac_header NO-LOCK.

FIND Rem_header WHERE Rem_header.nro_remito = Fac_header.nro_remito NO-LOCK NO-ERROR.
IF AVAILABLE Rem_header 
THEN DO:
    FIND Ped_header WHERE Ped_header.nro_pedido = Rem_header.nro_pedido NO-LOCK NO-ERROR.
END.

FOR EACH Fac_header_impuesto OF Fac_header, Impuesto OF Fac_header_impuesto:
    IF Impuesto.es_iva
        THEN ASSIGN prciva = Fac_header_impuesto.tasa
                    importe_iva = Fac_header_impuesto.importe.
        ELSE ASSIGN prcnoi = Fac_header_impuesto.tasa
                    importe_noi = Fac_header_impuesto.importe.
END.

FIND FIRST Cta_cte 
     WHERE Cta_cte.cdg_empresa = Fac_header.cdg_empresa 
       AND Cta_cte.tip_comprob = Fac_header.tip_comprob 
       AND Cta_cte.prf_comprob = Fac_header.prf_comprob
       AND Cta_cte.nro_comprob = Fac_header.nro_comprob
           NO-ERROR.
       
v-desc  = Fac_header.imp_bruto - Fac_header.imp_neto.
v-bruto = Fac_header.imp_bruto.
v-neto  = Fac_header.imp_neto.

v-letra = SUBSTRING(Fac_header.tip_comprob,2,1). 

IF Fac_header.leyenda <> ""
THEN DO:
    RUN RENGLONS.P (INPUT  Fac_header.leyenda, 
                    INPUT  v-leng_leyenda,
                    OUTPUT v-detallada,
                    INPUT  "|").

    DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
        v-linea_leyenda [ j ] = ENTRY(j,v-detallada, "|").
    END.

END.
ELSE DO:
    v-linea_leyenda = "".
END.

RUN RENGLONS.P (INPUT  Fac_header.monto_letras, 
                INPUT  v-leng_monto,
                OUTPUT v-detallada,
                INPUT  "|").

DO j = 1 TO NUM-ENTRIES(v-detallada,"|"):
    v-monto_letras [ j ] = ENTRY(j,v-detallada, "|").
END.

OUTPUT TO PRINTER PAGE-SIZE 72.

PUT CONTROL CHR(18).
PUT CONTROL "~033CH".

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Cliente.cdg_postal     
    Cliente.localidad      
    Cliente.direccion
    Prov_legal.nombre      
    Fac_header.fecha
    Cliente.cdg_cliente  WHEN AVAILABLE Cliente  
    Fac_header.nombre      
    Fac_header.direccion   
    Fac_header.cdg_postal  
    Fac_header.localidad
    Provincia.nombre       
    Fac_header.cuit        
    Rem_header.prf_comprob WHEN AVAILABLE Rem_header
    Rem_header.nro_comprob WHEN AVAILABLE Rem_header
    Fac_header.nro_ocm  
    Condicion_impos.texto  
    Condicion_venta.descripcion  
    Cta_cte.fecha_vencimiento WHEN AVAILABLE Cta_cte
    Fac_header.nro_ocm  
    Ped_header.tip_comprob WHEN AVAILABLE Ped_header
    Ped_header.nro_comprob WHEN AVAILABLE Ped_header
    Rem_header.prf_comprob WHEN AVAILABLE Rem_header
    Rem_header.nro_comprob WHEN AVAILABLE Rem_header
    WITH FRAME frm-encabezado.


/*---------------------------------------------------------------------------------*/
/*                                      DETALLE                                    */
/*---------------------------------------------------------------------------------*/

PUT CONTROL CHR(15).
/*
DISPLAY
    titulo-detalle
    WITH FRAME frm-titdetalle.
*/    

linea0 = LINE-COUNTER.

FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle NO-LOCK,
                                    Unidad OF Articulo NO-LOCK:

  v-bonifs = "  ".
  FOR EACH Fac_detalle-bon OF Fac_detalle NO-LOCK:
      v-bonifs = v-bonifs + STRING(Fac_detalle-bon.porcentaje,"ZZ9.99") + " ".
  END.    

  FIND FIRST Aliart-cliente OF Articulo 
      WHERE Aliart-cliente.nro_cliente = Cliente.nro_cliente NO-LOCK NO-ERROR.

  IF AVAILABLE Aliart-cliente
  THEN DO:
      DISPLAY Aliart-cliente.cdg_aliascli @ Articulo.cdg_articulo 
              Aliart-cliente.dsc_aliascli @ Articulo.descripcion
              WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  END.
  ELSE DO:
      DISPLAY Articulo.cdg_articulo
              Articulo.descripcion
              WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
  END.

  DISPLAY
        Fac_detalle.cantidad
        Unidad.abrevia
        WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
  
  IF Fac_detalle.detallada <> ""
  THEN DO:

      DO j-tomo = 1 TO NUM-ENTRIES(Fac_detalle.detallada,CHR(10)):

          v-tomo = ENTRY(j-tomo,Fac_detalle.detallada,CHR(10)).

          IF LENGTH(v-tomo) <> 0
          THEN DO:

              RUN RENGLONS.P (INPUT  v-tomo, 
                              INPUT  v-leng_detallada,
                              OUTPUT v-detallada,
                              INPUT  "|").

              nt_lineas =  NUM-ENTRIES(v-detallada,"|").
              DO j = 1 to nt_lineas:

                DOWN WITH FRAME frm-detalle.

                DISPLAY  ENTRY(j,v-detallada, "|") @ Articulo.descripcion
                         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

              END.

          END.
          ELSE DO:

              DOWN WITH FRAME frm-detalle.

              DISPLAY " " @ Articulo.descripcion
                         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

          END.

      END.

  END.

  DISPLAY  Fac_detalle.precio
           Fac_detalle.subtotal_bruto
           WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.

  DOWN WITH FRAME frm-detalle.
  /*
  DISPLAY " " @ Articulo.descripcion
         WITH FRAME frm-detalle USE-TEXT STREAM-IO DOWN.
  DOWN WITH FRAME frm-detalle.
  */

END.

DO nreng = LINE-COUNTER - linea0 TO nmax_det:
   DISPLAY blancos WITH FRAME frm-blanco.
   DOWN WITH FRAME frm-blanco.
END.

/*---------------------------------------------------------------------------------*/
/*                                       PIE                                       */
/*---------------------------------------------------------------------------------*/

DISPLAY
    Moneda.descripcion
    v-monto_letras [ 1 ] 
    v-monto_letras [ 2 ] 
    v-linea_leyenda [ 1 ] 
    v-linea_leyenda [ 2 ] 
    v-linea_leyenda [ 3 ] 
    v-linea_leyenda [ 4 ] 
    v-linea_leyenda [ 5 ] 
    v-linea_leyenda [ 6 ] 
    v-linea_leyenda [ 7 ] 
    Fac_header.imp_neto
    Fac_header.imp_bruto
    /*v-desc*/
    prciva
    importe_iva
    prcnoi
    importe_noi
    Fac_header.imp_total
    Fac_header.tip_comprob
    Fac_header.prf_comprob
    Fac_header.nro_comprob
    v-comprobante
    WITH FRAME frm-pie.

/*=================================================================================*/
/*                                       FIN                                       */
/*=================================================================================*/

OUTPUT CLOSE.

/*
DOS SILENT VALUE("COPY " + dire_tmp + "PRFAA501.TXT" + "  lpt1") /* view-as alert-box message.*/.
*/
