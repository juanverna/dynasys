/*=================================================================================*/
/*                      EMITE LISTADO DE SUBDIAIRO DE INVENTARIO                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE. 
DEFINE INPUT PARAMETER has_fecha    AS DATE. 
DEFINE INPUT PARAMETER des_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.
DEFINE INPUT PARAMETER gen_asiento  AS LOGICAL LABEL "Generar Asiento" INITIAL NO
                                    FORMAT "Si/No".
DEFINE INPUT PARAMETER ver_movim        AS LOGICAL LABEL "Listar Movimientos" INITIAL YES.
DEFINE INPUT PARAMETER ver_resum        AS LOGICAL LABEL "Listar Resumen" INITIAL YES.
DEFINE INPUT PARAMETER fecha_contable   LIKE Asn_header.fecha    LABEL "Fecha Contable".

{VRSHARED.I}
{VPERSINM.I}
{WGLISTAR.I}
{dfvarimp.i }

DEFINE VARIABLE columna    AS DECIMAL EXTENT 5 FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE r-acumula  AS DECIMAL EXTENT 5.
DEFINE VARIABLE g-acumula  AS DECIMAL EXTENT 5.
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE que_nombre LIKE Deposito.nombre FORMAT "X(25)".

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(192)".

FORM HEADER
   que_empresa
   "Subdiario de Inventario" AT 55
   "Pagina:" AT 123 PAGE-NUMBER FORMAT ">9" AT 130
   SKIP
   fecha_lis
   "Periodo" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 123
   SKIP(2)
   header_tt1 SKIP
   header_tt2 SKIP
   header_sry SKIP
   WITH FRAME a CENTERED TOP-ONLY.

FORM
   Sub_header_inv.fecha
   Sub_header_inv.tip_comprob
   Sub_header_inv.prf_comprob
   Sub_header_inv.nro_comprob
   que_nombre
   columna
   WITH FRAME a DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.

                    /* se arma el titulo con las fechas */

  header_tt1 = "                                                                  ".
  header_tt2 = " Fecha      Documento      Razon social                  CUIT     ".
  header_sry = "-------- -- ---- --------- ------------------------- -------------".

  FOR EACH Columna_reporte WHERE Columna_reporte.cdg_reporte_sbd = "COM":
     header_tt1 = header_tt1 + " " + Columna_reporte.titulo1 + 
                                     FILL(" ",11 - LENGTH(Columna_reporte.titulo1)).
     header_tt2 = header_tt2 + " " + Columna_reporte.titulo2 + 
                                     FILL(" ",11 - LENGTH(Columna_reporte.titulo2)).
     header_sry = header_sry + " " + "-----------".
  END.

  header_tt1 = header_tt1 + " " + "Total      ".
  header_tt2 = header_tt2 + " " + "Facturado  ".
  header_sry = header_sry + " " + "-----------".

  {dirprinfile.i}

   FOR EACH Sub_header_inv
        WHERE Sub_header_inv.cdg_empresa = Empresa.cdg_empresa
          AND Sub_header_inv.fecha <= has_fecha
          AND Sub_header_inv.fecha >= des_fecha
          AND LOOKUP(Sub_header_inv.tip_comprob,lista_tipos) <> 0
          AND Sub_header_inv.prf_comprob <= has_ptovta 
          AND Sub_header_inv.prf_comprob >= des_ptovta 
          AND NOT Sub_header_inv.anulado EXCLUSIVE-LOCK
              BREAK BY Sub_header_inv.fecha:


      IF NOT Sub_header_inv.anulado
      THEN DO:

           FIND Valeinv_hd WHERE Sub_header_inv.cdg_empresa   = Valeinv_hd.cdg_empresa
                             AND Sub_header_inv.tip_comprob   = Valeinv_hd.tip_comprob
                             AND Sub_header_inv.prf_comprob   = Valeinv_hd.prf_comprob
                             AND Sub_header_inv.nro_comprob   = Valeinv_hd.nro_comprob NO-LOCK.

           IF LOOKUP(Sub_header_inv.tip_comprob,str_debitan_inv) <> 0
              THEN signo =  1.
              ELSE signo = -1.

           FOR EACH Sub_detalle_inv WHERE Sub_detalle_inv.cdg_empresa = Sub_header_inv.cdg_empresa
                                      AND Sub_detalle_inv.tip_comprob = Sub_header_inv.tip_comprob
                                      AND Sub_detalle_inv.prf_comprob = Sub_header_inv.prf_comprob
                                      AND Sub_detalle_inv.nro_comprob = Sub_header_inv.nro_comprob NO-LOCK,
                                      Cuenta OF Sub_detalle_inv NO-LOCK, 
                                      FIRST Columna_cuenta OF Cuenta 
                                           WHERE Columna_cuenta.cdg_reporte_sbd = "INV" NO-LOCK:

              r-acumula [ Columna_cuenta.nro_columna ] =
                     r-acumula [ Columna_cuenta.nro_columna ] +
                                 Sub_detalle_inv.valor * signo.

           END.

           columna [ 5 ] = 0.
           DO j = 1 TO 4:
              columna [ j ]   = r-acumula [ j ].
              g-acumula [ j ] = g-acumula [ j ] + r-acumula [ j ].
              r-acumula [ j ] = 0.
              columna [ 5 ]   = columna [ 5 ] + columna [ j ].
           END.

           ASSIGN que_nombre = "".

       END.
       ELSE DO:
             ASSIGN que_nombre = "ANULADA".
       END.

       DISPLAY Sub_header_inv.fecha WHEN FIRST-OF(Sub_header_inv.fecha)
               Sub_header_inv.tip_comprob
               Sub_header_inv.prf_comprob
               Sub_header_inv.nro_comprob
               que_nombre
               columna
               WITH FRAME a.

       DOWN WITH FRAME a.

       RELEASE Valeinv_hd.

   END.

   columna [ 5 ] = 0.
   DO j = 1 TO 4:
      columna [ j ]   =  g-acumula [ j ].
      columna [ 5 ]   =  columna [ 5 ] + columna [ j ].
   END.
   UNDERLINE Sub_header_inv.fecha
             Sub_header_inv.tip_comprob
             Sub_header_inv.prf_comprob
             Sub_header_inv.nro_comprob
             que_nombre
             columna [ 1 ]
             columna [ 2 ]
             columna [ 3 ]
             columna [ 4 ]
             columna [ 5 ]
             WITH frame a.
   DISPLAY columna  WITH FRAME a.

   DOWN WITH FRAME a.

   OUTPUT CLOSE.
   PAUSE 0.
   HIDE FRAME frm-espere.
   RUN veresult.w ( INPUT arch_salida,
                    INPUT 8 ).

END PROCEDURE.

