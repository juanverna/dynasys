/*=================================================================================*/
/*                  EMISION DE LISTADO DEL SUBDIARIO DE FACTURACION                */
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

{tmpexcel.i} /* Definicion de la tabla temporal para exportar datos a Excel */

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE r-acumula  AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumula  AS DECIMAL EXTENT 32.
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE v-frmnum   AS CHARACTER INITIAL "ZZZZZZZ9.99-".
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(292)".
DEFINE VARIABLE columnas   AS CHARACTER FORMAT "X(183)".
DEFINE VARIABLE lista_impuestos AS CHARACTER FORMAT "X(160)".
DEFINE VARIABLE que_comprobante AS CHARACTER FORMAT "X(16)".

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Subdiario de Facturas, Notas de Crédito y Débito" AT 100
   "Página:" AT 232 PAGE-NUMBER FORMAT ">>>>9" AT 243
   SKIP
   fecha_lis
   "Período" AT 100
   des_fecha " - " has_fecha
   hora_lis AT 232
   SKIP(2)
   header_tt1 SKIP
   header_tt2 SKIP
   header_sry 
   WITH WIDTH 300 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sry 
   WITH FRAME f-subraya WIDTH 300 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Fac_header.fecha
   que_comprobante
   Fac_header.nombre FORMAT "X(25)"
   Fac_header.cuit FORMAT "X(11)"
   columnas
   Cuenta.cdg_cuenta
   WITH FRAME frm-listado DOWN WIDTH 320 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.

RUN veresult.w ( INPUT arch_salida, INPUT 22).


/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:
 
  que_empresa = Empresa.nombre.
  
                    /* se arma el titulo con las fechas */

  header_tt1 = "Fecha     Identificacion    Razon                                  ".
  header_tt2 = "Operacion del Comprobante   Social                    C.U.I.T.     ".
  header_sry = "--------- ----------------- ------------------------- -----------  ".

  ntcols = 0.

  RUN agregar_columna ( INPUT "Importe", INPUT "Gravado", INPUT-OUTPUT ntcols ).
  RUN agregar_columna ( INPUT "Importe No", INPUT "Gravado", INPUT-OUTPUT ntcols ).
  RUN agregar_columna ( INPUT "Gravado", INPUT "C.y Orden", INPUT-OUTPUT ntcols ).
  RUN agregar_columna ( INPUT "NO Gravado", INPUT "C.y Orden", INPUT-OUTPUT ntcols ).
  RUN agregar_columna ( INPUT "Neto", INPUT "Total", INPUT-OUTPUT ntcols ).

  lista_impuestos = "".
  FOR EACH Impuesto NO-LOCK
      WHERE Impuesto.nivel = 0 :
      RUN agregar_columna ( INPUT Impuesto.nombre, INPUT STRING(Impuesto.tasa,">>.99") + "%", INPUT-OUTPUT ntcols ).
      lista_impuestos = lista_impuestos + "," + STRING(Impuesto.cdg_impuesto).
  END.
  lista_impuestos = SUBSTRING(lista_impuestos,2).

  RUN agregar_columna ( INPUT "Percepciones", INPUT "Ing.Brutos", INPUT-OUTPUT ntcols ).
  RUN agregar_columna ( INPUT "Total", INPUT "Facturado", INPUT-OUTPUT ntcols ).

  header_tt1 = header_tt1 + " Cuenta    ".
  header_tt2 = header_tt2 + " Contable  ".
  header_sry = header_sry + " ----------".

  {dirprinfile.i}

  IF lis_fecha
  THEN DO:
       fecha_lis = STRING(TODAY,"99/99/99").
       hora_lis = STRING(TIME,"HH:MM:SS").
  END.
  ELSE DO:
       fecha_lis = "".
       hora_lis = "".
  END.

  FOR EACH Fac_header
      WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
        AND Fac_header.fecha <= has_fecha
        AND Fac_header.fecha >= des_fecha
        AND CAN-DO(lista_tipos,Fac_header.tip_comprob)
        AND Fac_header.prf_comprob <= has_ptovta 
        AND Fac_header.prf_comprob >= des_ptovta,
      Tipocomprobante OF Fac_header,
      FIRST Cliente OF Fac_header, FIRST Familia_cliente OF Cliente, FIRST Cuenta OF Familia_cliente
            BY Fac_header.fecha
            BY Fac_header.tip_comprob
            BY Fac_header.prf_comprob
            BY Fac_header.nro_comprob:

      VIEW FRAME frm-titulo.

      que_comprobante = Fac_header.tip_comprob + " " +
                        STRING(Fac_header.prf_comprob,"9999") + " " + 
                        STRING(Fac_header.nro_comprob,"99999999").                               

      IF NOT Fac_header.anulado
      THEN DO:

          IF Tipocomprobante.debita
             THEN signo =  1.
             ELSE signo = -1.

          FOR EACH Fac_detalle OF Fac_header:

              OPEN QUERY q_cuenta
                  FOR EACH Vigencia_cyorden 
                     WHERE Vigencia_cyorden.nro_articulo = Fac_detalle.nro_articulo
                       AND Vigencia_cyorden.rige_desde <= Fac_header.fecha
                       AND Vigencia_cyorden.rige_hasta >= Fac_header.fecha,
                           FIRST Proveedor OF Vigencia_cyorden WHERE Proveedor.cyorden_sino.
              GET FIRST q_cuenta.

              ncol = IF NOT AVAILABLE Vigencia_cyorden THEN 1 ELSE 3.
              IF NOT CAN-FIND(FIRST Fac_detalle_impuesto OF Fac_detalle) THEN ncol = ncol + 1.

              r-acumula [ ncol ] = r-acumula [ ncol ] + Fac_detalle.subtotal_neto * Fac_header.cambio * signo.
              r-acumula [    5 ] = r-acumula [    5 ] + Fac_detalle.subtotal_neto * Fac_header.cambio * signo.
         
              FOR EACH Fac_detalle_impuesto OF Fac_detalle,
                    Impuesto OF Fac_detalle_impuesto :

                  IF Impuesto.nivel = 0 
                     THEN ncol = 5 + LOOKUP(STRING(Impuesto.cdg_impuesto),lista_impuestos).
                     ELSE ncol = ntcols - 1 . 

                     r-acumula [ ncol ] = r-acumula [ ncol ] + Fac_detalle_impuesto.importe *  Fac_header.cambio * signo. 

              END.

          END.

          r-acumula [ ntcols ] = 0.

          DO j = 5 TO ntcols - 1 :
             r-acumula [ ntcols ] =  r-acumula [ ntcols ] + r-acumula [ j ].
          END.

          columnas = "".
          DO j = 1 TO ntcols:
             columnas = columnas + STRING(r-acumula [ j ],v-frmnum) + " ".
             g-acumula [ j ] = g-acumula [ j ] + r-acumula [ j ].
             r-acumula [ j ] = 0.
          END.

          DISPLAY Fac_header.fecha
                  que_comprobante
                  Fac_header.nombre
                  Fac_header.cuit
                  columnas
                  Cuenta.cdg_cuenta
                  WITH FRAME frm-listado.
      END.
      ELSE DO:
          DISPLAY Fac_header.fecha
                  que_comprobante
                  "ANULADA" @ Fac_header.nombre
                  "-------------" @ Fac_header.cuit
                  WITH FRAME frm-listado.

      END.

      DOWN WITH FRAME frm-listado.
   
   END.

   columnas = "".
   DO j = 1 TO ntcols:
       columnas = columnas + STRING(g-acumula [ j ],v-frmnum) + " ".
   END.
   
   DISPLAY  header_sry
             WITH frame f-subraya.
   DOWN WITH FRAME f-subraya.

   DISPLAY   columnas
             WITH FRAME frm-listado.

   DOWN WITH FRAME frm-listado.

   OUTPUT CLOSE.

END PROCEDURE.

PROCEDURE agregar_columna:

    DEFINE INPUT PARAMETER p-renglon1 AS CHARACTER.
    DEFINE INPUT PARAMETER p-renglon2 AS CHARACTER.
    DEFINE INPUT-OUTPUT PARAMETER p-ntcols AS INTEGER.

    header_tt1 = header_tt1 + " " + SUBSTRING(p-renglon1,1,12) + FILL(" ",12 - LENGTH(p-renglon1)).
    header_tt2 = header_tt2 + " " + SUBSTRING(p-renglon2,1,12) + FILL(" ",12 - LENGTH(p-renglon2)).
    header_sry = header_sry + " " + FILL("-",12).

    p-ntcols = p-ntcols + 1.

END PROCEDURE.
