/*=================================================================================*/
/*                   EMISION DE LISTADO DE CONVENIO MULTILATERAL                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE. 
DEFINE INPUT PARAMETER has_fecha    AS DATE. 
DEFINE INPUT PARAMETER des_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.

/*=================================================================================*/
/*                                      VARIABLES                                  */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE VARIABLE r-acumula           AS DECIMAL EXTENT 32.
DEFINE VARIABLE p-acumula           AS DECIMAL EXTENT 32.
DEFINE VARIABLE g-acumula           AS DECIMAL EXTENT 32.
DEFINE VARIABLE j                   AS INTEGER.
DEFINE VARIABLE signo               AS INTEGER.

DEFINE VARIABLE ntcols              AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol                AS INTEGER.
DEFINE VARIABLE nt_items            AS INTEGER.
DEFINE VARIABLE ldes                AS INTEGER.
DEFINE VARIABLE ult_column          AS INTEGER.
DEFINE VARIABLE header_tt1          AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2          AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry          AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas            AS CHARACTER FORMAT "X(124)".
DEFINE VARIABLE ant_fecha           AS DATE.
DEFINE VARIABLE ant_provincia       LIKE Sub_header_vta.cdg_provincia.

DEFINE FRAME frm-titulo HEADER
   que_empresa
   "Convenio Multilateral" AT 55
   "Página:" AT 99 PAGE-NUMBER FORMAT ">>>9" AT 109
   SKIP
   fecha_lis
   "Período" AT 55
   des_fecha " - " has_fecha
   hora_lis AT 99
   SKIP(2)
   header_tt1 SKIP
   header_tt2 SKIP
   header_sry 
   WITH WIDTH 256 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

FORM 
   header_sry 
   WITH FRAME f-subraya WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   Sub_header_vta.fecha
   Sub_header_vta.tip_comprob
   Sub_header_vta.prf_comprob
   Sub_header_vta.nro_comprob
   Sub_header_vta.nombre FORMAT "X(25)"
   Sub_header_vta.cuit
   columnas
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
 
  que_empresa = Empresa.nombre.
  
                    /* se arma el titulo con las fechas */

  header_tt1 = "                                                                    ".
  header_tt2 = " FECHA   TD PVTA    Numero Razon social                C.U.I.T.     ".
  header_sry = "-------- -- ---- --------- ------------------------- -------------  ".

  FOR EACH Columna_reporte NO-LOCK
      WHERE Columna_reporte.cdg_reporte = "CMV" 
        AND Columna_reporte.cdg_empresa = Empresa.cdg_empresa
         BY Columna_reporte.nro_columna:
     header_tt1 = header_tt1 + " " + Columna_reporte.titulo1 + FILL(" ",15 - LENGTH(Columna_reporte.titulo1)).
     header_tt2 = header_tt2 + " " + Columna_reporte.titulo2 + FILL(" ",15 - LENGTH(Columna_reporte.titulo2)).
     header_sry = header_sry + " " + "---------------".
     ntcols = Columna_reporte.nro_columna.
  END.

  header_tt1 = header_tt1 + " " + "Total Neto    ".
  header_tt2 = header_tt2 + " " + "Facturado     ".
  header_sry = header_sry + " " + "---------------".

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

  RUN getparametro.p (  INPUT  "CREDEBFC",
                        OUTPUT v-valor_c,
                        OUTPUT v-valor_d,
                        OUTPUT v-valor_l,
                        OUTPUT v-valor_n,
                        OUTPUT v-observacion ).

  IF v-valor_l
  THEN OPEN QUERY q-subdiario
        FOR EACH Sub_header_vta
             WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa
               AND Sub_header_vta.fecha <= has_fecha
               AND Sub_header_vta.fecha >= des_fecha
               AND CAN-DO(lista_tipos,Sub_header_vta.tip_comprob)
               AND Sub_header_vta.prf_comprob <= has_ptovta 
               AND Sub_header_vta.prf_comprob >= des_ptovta 
               AND NOT Sub_header_vta.anulado
                   BY Sub_header_vta.cdg_provincia
                   BY Sub_header_vta.fecha
                   BY Sub_header_vta.prf_comprob
                   BY Sub_header_vta.nro_comprob.
  ELSE OPEN QUERY q-subdiario
        FOR EACH Sub_header_vta
             WHERE Sub_header_vta.cdg_empresa = Empresa.cdg_empresa
               AND Sub_header_vta.fecha <= has_fecha
               AND Sub_header_vta.fecha >= des_fecha
               AND CAN-DO(lista_tipos,Sub_header_vta.tip_comprob)
               AND Sub_header_vta.prf_comprob <= has_ptovta 
               AND Sub_header_vta.prf_comprob >= des_ptovta 
               AND NOT Sub_header_vta.anulado
                   BY Sub_header_vta.cdg_provincia
                   BY Sub_header_vta.fecha
                   BY Sub_header_vta.tip_comprob
                   BY Sub_header_vta.prf_comprob
                   BY Sub_header_vta.nro_comprob.

  ant_provincia = ?.
  GET FIRST q-subdiario.
  DO WHILE AVAILABLE Sub_header_vta:

      VIEW FRAME frm-titulo.

      IF ant_provincia <> Sub_header_vta.cdg_provincia AND ant_provincia <> ?
      THEN DO:
                   
            FIND Provincia WHERE Provincia.cdg_provincia = ant_provincia NO-LOCK.
            DISPLAY  header_sry
                      WITH frame f-subraya.
            DOWN WITH FRAME f-subraya.
            columnas = "".
            p-acumula [ ntcols + 1 ] = 0.
            DO j = 1 TO ntcols:
               columnas = columnas + STRING(p-acumula [ j ],"ZZZZZZZZZZZ9.99-") + " ".
               g-acumula [ j ] = g-acumula [ j ] + p-acumula [ j ].
               p-acumula [ ntcols + 1 ] =  p-acumula [ ntcols + 1 ] + p-acumula [ j ].
               p-acumula [ j ] = 0.
            END.                                                   
            columnas = columnas + STRING(p-acumula [ ntcols + 1 ],"ZZZZZZZZZZZ9.99-").
            DISPLAY "Total" @ Sub_header_vta.nro_comprob
                    Provincia.nombre @ Sub_header_vta.nombre
                    columnas
                    WITH FRAME a.
            DOWN 2 WITH FRAME a.

      END.

      IF NOT Sub_header_vta.anulado
      THEN DO:

          IF LOOKUP(Sub_header_vta.tip_comprob,str_debitan) <> 0
             THEN signo =  1.
             ELSE signo = -1.

          FOR EACH Sub_detalle_vta 
              WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
                AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
                AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
                AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob
                AND Sub_detalle_vta.tipo = 1,
                    Cuenta OF Sub_detalle_vta,
                   FIRST Columna_cuenta OF Cuenta 
                         WHERE Columna_cuenta.cdg_reporte = "CMV"
                           AND Columna_cuenta.cdg_empresa = Empresa.cdg_empresa:

             r-acumula [ Columna_cuenta.nro_columna ] =
                               r-acumula [ Columna_cuenta.nro_columna ] +
                               Sub_detalle_vta.valor * signo.

          END.

          columnas = "".
          r-acumula [ ntcols + 1 ] = 0.
          DO j = 1 TO ntcols:
             columnas = columnas + STRING(r-acumula [ j ],"ZZZZZZZZZZ9.99-") + " ".
             p-acumula [ j ] = p-acumula [ j ] + r-acumula [ j ].
             r-acumula [ ntcols + 1 ] =  r-acumula [ ntcols + 1 ] + r-acumula [ j ].
             r-acumula [ j ] = 0.
          END.
          columnas = columnas + STRING(r-acumula [ ntcols + 1 ],"ZZZZZZZZZZ9.99-").

          DISPLAY Sub_header_vta.fecha WHEN Sub_header_vta.fecha <> ant_fecha
                  Sub_header_vta.tip_comprob
                  Sub_header_vta.prf_comprob
                  Sub_header_vta.nro_comprob
                  Sub_header_vta.nombre
                  Sub_header_vta.cuit
                  columnas
                  WITH FRAME a.
      END.
      ELSE DO:
          DISPLAY Sub_header_vta.fecha WHEN Sub_header_vta.fecha <> ant_fecha
                  Sub_header_vta.tip_comprob
                  Sub_header_vta.prf_comprob
                  Sub_header_vta.nro_comprob
                  "ANULADA" @ Sub_header_vta.nombre
                  "-------------" @ Sub_header_vta.cuit
                  WITH FRAME a.

      END.

      DOWN WITH FRAME a.
     
      ant_provincia = Sub_header_vta.cdg_provincia.
      ant_fecha     = Sub_header_vta.fecha.

      GET NEXT q-subdiario.
            
   END.  /* De recorrer el subdiario */

          /* Cierra última provincia */
   IF ant_provincia = ?
   THEN DO:
       PUT "************************************************"  SKIP.
       PUT "         NO HAY  MOVIMIENTOS A LISTAR           "  SKIP.
       PUT "************************************************"  SKIP.
   END.
   ELSE DO:
       FIND Provincia WHERE Provincia.cdg_provincia = ant_provincia NO-LOCK.
       DISPLAY  header_sry
                 WITH frame f-subraya.
       DOWN WITH FRAME f-subraya.
       columnas = "".
       p-acumula [ ntcols + 1 ] = 0.
       DO j = 1 TO ntcols:
          columnas = columnas + STRING(p-acumula [ j ],"ZZZZZZZZZZ9.99-") + " ".
          g-acumula [ j ] = g-acumula [ j ] + p-acumula [ j ].
          p-acumula [ ntcols + 1 ] =  p-acumula [ ntcols + 1 ] + p-acumula [ j ].
          p-acumula [ j ] = 0.
       END.
       columnas = columnas + STRING(p-acumula [ ntcols + 1 ],"ZZZZZZZZZZ9.99-").
       DISPLAY "Total" @ Sub_header_vta.nro_comprob
               Provincia.nombre @ Sub_header_vta.nombre
               columnas
               WITH FRAME a.
       DOWN 2 WITH FRAME a.
    
              /* Cierra total general */
       
       columnas = "".
       DO j = 1 TO ntcols:
           columnas = columnas + STRING(g-acumula [ j ],"ZZZZZZZZZZ9.99-") + " ".
           g-acumula [ ntcols + 1 ] =  g-acumula [ ntcols + 1 ] + g-acumula [ j ].
       END.
       columnas = columnas + STRING(g-acumula [ ntcols + 1 ],"ZZZZZZZZZZ9.99-").
       
       DISPLAY  header_sry
                 WITH frame f-subraya.
       DOWN WITH FRAME f-subraya.
    
       DISPLAY   columnas
                 WITH FRAME a.
    
       DOWN WITH FRAME a.
   END.

   OUTPUT CLOSE.

END PROCEDURE.

