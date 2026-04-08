/*=================================================================================*/
/*                 EXPORTACION A EXCEL DEL SUBDIARIO DE FACTURACION                */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE. 
DEFINE INPUT PARAMETER has_fecha    AS DATE. 
DEFINE INPUT PARAMETER des_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE r-acumula       AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumula       AS DECIMAL EXTENT 32.
DEFINE VARIABLE j               AS INTEGER.
DEFINE VARIABLE signo           AS INTEGER.

DEFINE VARIABLE ntcols          AS INTEGER INITIAL 32.
DEFINE VARIABLE ntcols_excel    AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol            AS INTEGER.
DEFINE VARIABLE col0_impor      AS INTEGER.
DEFINE VARIABLE c-fila          AS INTEGER.
DEFINE VARIABLE ldes            AS INTEGER.
DEFINE VARIABLE ult_column      AS INTEGER.
DEFINE VARIABLE v-frmnum        AS CHARACTER INITIAL "->>>>>>>9.99".
DEFINE VARIABLE header_tt1      AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE header_tt2      AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE header_sry      AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE columnas        AS CHARACTER FORMAT "X(242)".
DEFINE VARIABLE lista_impuestos AS CHARACTER FORMAT "X(160)".
DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)".

{fnexcel.i} /* Definicion de funciones para exportar a excel */

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

/*RUN veresult.w ( INPUT arch_salida, INPUT 22).*/


/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
  que_empresa = Empresa.nombre.
  
  ntcols_excel = 0.

  RUN agregar_columna ( INPUT "Fecha", INPUT "Operacion", "fechoper", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Ti-", INPUT "po", "tipo", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Le-", INPUT "tra", "letra", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Centro", INPUT "Emisor", "centro", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Numero", INPUT "Comprobante", "numcomprob", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Razón", INPUT "Social", "nomcliente", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "", INPUT "C.U.I.T.", "cuit", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Condicion", INPUT "IVA", "CondIva", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Con-", INPUT "cepto", "concepto", INPUT-OUTPUT ntcols_excel ).

  col0_impor = ntcols_excel. /* Los importes arrancan en la columna col0_impor + 1 */
  
  RUN agregar_columna ( INPUT "Importe", INPUT "Gravado", "Grav", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Importe No", INPUT "Gravado", "NoGrav", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Gravado", INPUT "C.y Orden", "GravCyO", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "NO Gravado", INPUT "C.y Orden", "NoGravCyO", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Gravado", INPUT "Rnd.Cuenta", "GravRnd", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "NO Gravado", INPUT "Rnd.Cuenta", "NoGravRnd", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Ventas", INPUT "Exentas", "Exentas", INPUT-OUTPUT ntcols_excel ).

  RUN agregar_columna ( INPUT "Neto", INPUT "Total", "TotalNeto", INPUT-OUTPUT ntcols_excel ).

  lista_impuestos = "".
  FOR EACH Impuesto NO-LOCK BY Impuesto.cdg_impuesto:
      RUN agregar_columna ( INPUT Impuesto.nombre, INPUT STRING(Impuesto.tasa,">>.99") + "%", Impuesto.nombre, INPUT-OUTPUT ntcols_excel ).
      lista_impuestos = lista_impuestos + "," + STRING(Impuesto.cdg_impuesto).
  END.
  lista_impuestos = SUBSTRING(lista_impuestos,2).

  RUN agregar_columna ( INPUT "Total", INPUT "Facturado", "TotalComprob", INPUT-OUTPUT ntcols_excel ).
  RUN agregar_columna ( INPUT "Imputacion", INPUT "Contable", "cuenta", INPUT-OUTPUT ntcols_excel ).

  ntcols = 8 + NUM-ENTRIES(lista_impuestos,",") + 1. /* 8 de neto mas impuestos mas la columna de total */

  fecha_lis = STRING(TODAY,"99/99/99").
  hora_lis = STRING(TIME,"HH:MM:SS").
  c-fila = 4.

  FOR EACH Fac_header
      WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
        AND Fac_header.fecha <= has_fecha
        AND Fac_header.fecha >= des_fecha
        AND CAN-DO(lista_tipos,Fac_header.tip_comprob)
        AND Fac_header.prf_comprob <= has_ptovta 
        AND Fac_header.prf_comprob >= des_ptovta,
      Tipocomprobante OF Fac_header,
      Imputacion OF Fac_header,
      Condicion_impos OF Fac_header,
      FIRST Cliente OF Fac_header, FIRST Familia_cliente OF Cliente, FIRST Cuenta OF Familia_cliente
            BY Fac_header.fecha
            BY Fac_header.tip_comprob
            BY Fac_header.prf_comprob
            BY Fac_header.nro_comprob:

      IF NOT Fac_header.anulado
      THEN DO:

          IF Tipocomprobante.debita
             THEN signo =  1.
             ELSE signo = -1.

          FOR EACH Fac_detalle OF Fac_header, Articulo OF Fac_detalle:

              IF Fac_header.cdg_condiva <> 10 /* NO es exento el cliente, acumulamos como siempre */
              THEN DO:
                  RUN acumular_simple.
              END.
              ELSE DO: /* Vemos si el articulo es exento. En caso contrario, acumulamos como siempre */

                  FIND Familia_impositiva OF Articulo NO-LOCK.
                  IF Familia_impositiva.cdg_familimpos = "2"
                      THEN RUN acumular_exento.    
                      ELSE RUN acumular_simple.    
              END.


          END.

          ax(STRING(Fac_header.fecha,"99/99/9999"),c-fila,1,1,"Valor").
          ax(SUBSTRING(Fac_header.tip_comprob,1,1),c-fila,2,1,"Valor").
          ax(SUBSTRING(Fac_header.tip_comprob,2,1),c-fila,3,1,"Valor").
          ax(STRING(Fac_header.prf_comprob),c-fila,4,1,"Valor").
          ax(STRING(Fac_header.nro_comprob),c-fila,5,1,"Valor").
          ax(Fac_header.nombre,c-fila,6,1,"Valor").
          ax(Fac_header.cuit,c-fila,7,1,"Valor").
          ax(Condicion_impos.descripcion,c-fila,8,1,"Valor").
          ax(Imputacion.dsc_imputacion,c-fila,9,1,"Valor").

          r-acumula [ ntcols ] = 0.
          DO j = 8 TO ntcols - 1 :
             g-acumula [ j ] = g-acumula [ j ] + r-acumula [ j ].
             r-acumula [ ntcols ] =  r-acumula [ ntcols ] + r-acumula [ j ].
          END.

          DO j = 1 TO ntcols:
             ax(TRIM(STRING(r-acumula [ j ],v-frmnum)),c-fila, j + col0_impor,1,"Valor").
             r-acumula [ j ] = 0.
          END.

          ax(STRING(Cuenta.cdg_cuenta),c-fila,ntcols_excel,1,"Valor").

      END.
      ELSE DO:
          ax(STRING(Fac_header.fecha),c-fila,1,1,"Valor").
          ax(que_comprobante,c-fila,2,1,"Valor").
          ax("ANULADA",c-fila,3,1,"Valor").
          ax("--------------",c-fila,4,1,"Valor").

      END.

      c-fila = c-fila + 1.
            
   END.

   RUN exportaexcel.p ( INPUT "subdventas.xlt", INPUT TABLE ttReprt).

END PROCEDURE.

PROCEDURE agregar_columna:

    DEFINE INPUT PARAMETER p-renglon1 AS CHARACTER.
    DEFINE INPUT PARAMETER p-renglon2 AS CHARACTER.
    DEFINE INPUT PARAMETER p-renglon3 AS CHARACTER.

    DEFINE INPUT-OUTPUT PARAMETER p-ntcols AS INTEGER.

    p-ntcols = p-ntcols + 1.

    ax(p-renglon1,1,p-ntcols,1,"Valor").
    ax(p-renglon2,2,p-ntcols,1,"Valor").
    ax(p-renglon3,3,p-ntcols,1,"Valor").


END PROCEDURE.

PROCEDURE acumular_simple:

    OPEN QUERY q_cuenta
      FOR EACH Vigencia_cyorden 
         WHERE Vigencia_cyorden.nro_articulo = Fac_detalle.nro_articulo
           AND Vigencia_cyorden.rige_desde <= Fac_header.fecha
           AND Vigencia_cyorden.rige_hasta >= Fac_header.fecha,
               FIRST Proveedor OF Vigencia_cyorden WHERE Proveedor.cyorden_sino.
    GET FIRST q_cuenta.
    
    IF Fac_header.cdg_comprobante = "RNCUENTA"
      THEN ncol = 5.
      ELSE ncol = IF NOT AVAILABLE Vigencia_cyorden THEN 1 ELSE 3.
    
    IF NOT CAN-FIND(FIRST Fac_detalle_impuesto OF Fac_detalle) THEN ncol = ncol + 1.
    
    IF Articulo.sumaneto > 0
    THEN DO:
        r-acumula [ ncol ] = r-acumula [ ncol ] + Fac_detalle.subtotal_neto * signo * Fac_header.cambio.
        r-acumula [    8 ] = r-acumula [    8 ] + Fac_detalle.subtotal_neto * signo * Fac_header.cambio.
    END.
    
    FOR EACH Fac_detalle_impuesto OF Fac_detalle,
        Impuesto OF Fac_detalle_impuesto :
    
         ncol = 8 + LOOKUP(STRING(Impuesto.cdg_impuesto),lista_impuestos,",").
         r-acumula [ ncol ] = r-acumula [ ncol ] + Fac_detalle_impuesto.importe * signo * Fac_header.cambio. 
    
    END.

END PROCEDURE.

PROCEDURE acumular_exento:

    IF Articulo.sumaneto > 0
    THEN DO:
        r-acumula [ 7 ] = r-acumula [ 7 ] + Fac_detalle.subtotal_neto * signo * Fac_header.cambio.
        r-acumula [ 8 ] = r-acumula [ 8 ] + Fac_detalle.subtotal_neto * signo * Fac_header.cambio.
    END.

END PROCEDURE.
