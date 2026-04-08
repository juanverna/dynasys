/*=================================================================================*/
/*                        EMITE EL LISTADO DE IVA COMPRAS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE.
DEFINE INPUT PARAMETER has_fecha    AS DATE.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}
{WGLISTAR.I}

DEFINE VARIABLE columna    AS DECIMAL EXTENT 32 FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE r-acumula  AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumula  AS DECIMAL EXTENT 32.
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE que_nombre LIKE Fac_header_prv.nombre FORMAT "X(25)".
DEFINE VARIABLE que_cuit   LIKE Fac_header_prv.cuit.

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas   AS CHARACTER FORMAT "X(124)".

/*=================================================================================*/
/*                                     FRAMES                                      */
/*=================================================================================*/

FORM HEADER
   que_empresa
   "Subdiario de I.V.A. Compras" AT 55
   "Página:" AT 123 (PAGE-NUMBER) FORMAT ">>>9" AT 130
   SKIP
   fecha_lis
   "Periodo" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 123
   SKIP(2)
   header_tt1 SKIP
   header_tt2 SKIP
   header_sry SKIP
   WITH FRAME frm-titulo CENTERED TOP-ONLY PAGE-TOP WIDTH 256 STREAM-IO.

FORM
   Sub_header_prv.fecha
   Sub_header_prv.tip_comprob
   Sub_header_prv.prf_comprob
   Sub_header_prv.nro_comprob
   que_nombre
   que_cuit
   SPACE(3)
   columnas
   WITH FRAME frm-movimiento DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM 
   header_sry 
   WITH FRAME f-subraya WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  que_empresa = Empresa.nombre.

                    /* se arma el titulo con las fechas     */

  header_tt1 = "Fecha    Ti Pre- Número    Razón                     C.U.I.T.       ".
  header_tt2 = "Compbte  po fijo Comprobte Social                    Proveedor      ".
  header_sry = "-------- -- ---- --------- ------------------------- -------------  ".

                    /* Pone columna de operaciones exhentas */

  FOR EACH Columna_reporte NO-LOCK
      WHERE Columna_reporte.cdg_reporte = "COM" 
        AND Columna_reporte.cdg_empresa = Empresa.cdg_empresa
         BY Columna_reporte.nro_columna:
     header_tt1 = header_tt1 + " " + Columna_reporte.titulo1 + FILL(" ",11 - LENGTH(Columna_reporte.titulo1)).
     header_tt2 = header_tt2 + " " + Columna_reporte.titulo2 + FILL(" ",11 - LENGTH(Columna_reporte.titulo2)).
     header_sry = header_sry + " " + "-----------".
     ntcols = Columna_reporte.nro_columna.
  END.

  ntcols = ntcols + 1.
  header_tt1 = header_tt1 + " " + "Importes" + FILL(" ",11 - LENGTH("Importes")).
  header_tt2 = header_tt2 + " " + "Exentos"     + FILL(" ",11 - LENGTH("Exentos")).
  header_sry = header_sry + " " + "-----------".

  header_tt1 = header_tt1 + " " + "Total      ".
  header_tt2 = header_tt2 + " " + "Facturado  ".
  header_sry = header_sry + " " + "-----------".

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
  
  FOR EACH Sub_header_prv
       WHERE Sub_header_prv.cdg_empresa = Empresa.cdg_empresa
         AND Sub_header_prv.fecha <= has_fecha
         AND Sub_header_prv.fecha >= des_fecha
         AND CAN-DO(lista_tipos,Sub_header_prv.tip_comprob)
         BREAK BY Sub_header_prv.fecha:

      VIEW FRAME frm-titulo.

      FIND Fac_header_prv WHERE Sub_header_prv.cdg_empresa   = Fac_header_prv.cdg_empresa
                            AND Sub_header_prv.tip_comprob   = Fac_header_prv.tip_comprob
                            AND Sub_header_prv.prf_comprob   = Fac_header_prv.prf_comprob
                            AND Sub_header_prv.nro_comprob   = Fac_header_prv.nro_comprob
                            AND Sub_header_prv.nro_proveedor = Fac_header_prv.nro_proveedor NO-ERROR.
      IF NOT AVAILABLE Fac_header_prv
      THEN DO:
                                            
           FIND Opg_header WHERE Sub_header_prv.cdg_empresa   = Opg_header.cdg_empresa
                             AND Sub_header_prv.tip_comprob   = Opg_header.tip_comprob
                             AND Sub_header_prv.prf_comprob   = Opg_header.prf_comprob
                             AND Sub_header_prv.nro_proveedor = Opg_header.nro_proveedor
                             AND Sub_header_prv.nro_comprob   = Opg_header.nro_comprob.
      END.
         
      IF NOT Sub_header_prv.anulado
      THEN DO:

          FIND Tipocomprobante OF Sub_header_prv NO-LOCK.

          IF Tipocomprobante.debita
             THEN signo = -1.
             ELSE signo =  1.

          FOR EACH Sub_detalle_prv 
                WHERE Sub_detalle_prv.cdg_empresa = Sub_header_prv.cdg_empresa
                  AND Sub_detalle_prv.tip_comprob = Sub_header_prv.tip_comprob
                  AND Sub_detalle_prv.prf_comprob = Sub_header_prv.prf_comprob
                  AND Sub_detalle_prv.nro_comprob = Sub_header_prv.nro_comprob
                  AND Sub_detalle_prv.nro_proveedor = Sub_header_prv.nro_proveedor NO-LOCK,
                  Cuenta OF Sub_detalle_prv NO-LOCK, 
                  FIRST Columna_cuenta OF Cuenta 
                        WHERE Columna_cuenta.cdg_reporte_sbd = "COM" 
                          AND Columna_cuenta.cdg_empresa = Sub_header_prv.cdg_empresa
                              NO-LOCK:

              IF Sub_detalle_prv.num_subcolumna = 0 
                 THEN j = Columna_cuenta.nro_columna.
                 ELSE j = ntcols.
                      
              r-acumula [ j ] = r-acumula [ j ] + Sub_detalle_prv.valor * Sub_header_prv.cambio * signo.

          END.

          columnas = "".
          r-acumula [ ntcols + 1 ] = 0.
          DO j = 1 TO ntcols:
             columnas = columnas + STRING(r-acumula [ j ],"ZZZZZZ9.99-") + " ".
             g-acumula [ j ] = g-acumula [ j ] + r-acumula [ j ].
             r-acumula [ ntcols + 1 ] =  r-acumula [ ntcols + 1 ] + r-acumula [ j ].
             r-acumula [ j ] = 0.
          END.
          columnas = columnas + STRING(r-acumula [ ntcols + 1 ],"ZZZZZZ9.99-").

          IF AVAILABLE Fac_header_prv
             THEN ASSIGN que_nombre = Fac_header_prv.nombre
                         que_cuit   = Fac_header_prv.cuit.
             ELSE ASSIGN que_nombre = Opg_header.nombre
                         que_cuit   = Opg_header.cuit.

       END.
       ELSE DO:
             ASSIGN que_nombre = "ANULADA"
                    que_cuit   = "".
       END.

       DISPLAY Sub_header_prv.fecha WHEN FIRST-OF(Sub_header_prv.fecha)
               Sub_header_prv.tip_comprob
               Sub_header_prv.prf_comprob
               Sub_header_prv.nro_comprob
               que_nombre
               que_cuit
               columnas
               WITH FRAME frm-movimiento.

       DOWN WITH FRAME frm-movimiento.

       RELEASE Fac_header_prv.
       RELEASE Opg_header.

   END.

   columnas = "".
   DO j = 1 TO ntcols:
       columnas = columnas + STRING(g-acumula [ j ],"ZZZZZZ9.99-") + " ".
       g-acumula [ ntcols + 1 ] =  g-acumula [ ntcols + 1 ] + g-acumula [ j ].
   END.
   columnas = columnas + STRING(g-acumula [ ntcols + 1 ],"ZZZZZZ9.99-").
   
   DISPLAY  header_sry
             WITH frame f-subraya.
   DOWN WITH FRAME f-subraya.

   DISPLAY   columnas
             WITH FRAME frm-movimiento.

   DOWN WITH FRAME frm-movimiento.

   OUTPUT CLOSE.

END PROCEDURE.


