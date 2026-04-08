/*importante en el ntcols + 1 pongo los no-grabados en el ntcols + 2 el total.*/
/*=================================================================================*/
/*                       EMISION DE LISTADO DE IVA VENTAS                          */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha    AS DATE. 
DEFINE INPUT PARAMETER has_fecha    AS DATE. 
DEFINE INPUT PARAMETER des_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER has_ptovta   AS INTEGER.
DEFINE INPUT PARAMETER lista_tipos  AS CHARACTER.
DEFINE INPUT PARAMETER lis_fecha    AS LOGICAL.
DEFINE INPUT PARAMETER TOTCOND      AS LOGICAL.

/*=================================================================================*/
/*                                VARIABLES                                        */
/*=================================================================================*/

{VRSHARED.I}
{VPERSINM.I}
{dfvarimp.i}

DEFINE BUFFER bsub_header_vta for sub_header_vta.
DEFINE VARIABLE r-acumula  AS DECIMAL EXTENT 32.  
DEFINE VARIABLE g-acumula  AS DECIMAL EXTENT 32.  
DEFINE VARIABLE j          AS INTEGER.
DEFINE VARIABLE signo      AS INTEGER.

DEFINE VARIABLE ntcols     AS INTEGER INITIAL 32.
DEFINE VARIABLE ncol       AS INTEGER.
DEFINE VARIABLE nt_items   AS INTEGER.
DEFINE VARIABLE ldes       AS INTEGER.
DEFINE VARIABLE ult_column AS INTEGER.
DEFINE VARIABLE header_tt1 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_tt2 AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE header_sry AS CHARACTER FORMAT "X(192)".
DEFINE VARIABLE columnas   AS CHARACTER FORMAT "X(124)".
DEFINE VARIABLE ant_fecha  AS DATE.

DEFINE VARIABLE v-con_neto      LIKE Fac_header.imp_neto FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE v-con_ng        LIKE Fac_header.imp_neto COLUMN-LABEL "No Grab." FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE v-con_iva       LIKE Fac_header.imp_iva FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE v-con_facturado LIKE Fac_header.imp_total FORMAT "ZZZZZZ9.99-".

DEFINE VARIABLE v-tot_neto      LIKE Fac_header.imp_neto FORMAT "ZZZZZZ9.99-".  
DEFINE VARIABLE v-tot_iva       LIKE Fac_header.imp_iva FORMAT "ZZZZZZ9.99-".
DEFINE VARIABLE v-tot_ng        LIKE Fac_header.imp_iva COLUMN-LABEL "No Grab." FORMAT "ZZZZZZ9.99-". 
DEFINE VARIABLE v-tot_facturado LIKE Fac_header.imp_total FORMAT "ZZZZZZ9.99-".

DEFINE TEMP-TABLE tt NO-UNDO
           FIELD cdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento
           FIELD cdg_condiva LIKE condicion_impos.cdg_condiva
           FIELD tip_comprob LIKE fac_header.tip_comprob
           FIELD descripcion LIKE Condicion_impos.descripcion
           FIELD v-con_neto LIKE  Fac_header.imp_neto  
           FIELD v-con_iva LIKE  Fac_header.imp_iva   
           FIELD v-con_ng LIKE  Fac_header.imp_neto COLUMN-LABEL "No Grab."  
           FIELD v-con_facturado LIKE Fac_header.imp_total   
           INDEX i1 cdg_tipo_evento tip_comprob cdg_condiva.

DEFINE VAR acdg_tipo_evento LIKE tipo_evento.cdg_tipo_evento NO-UNDO.

DEFINE FRAME frm-titulo HEADER
   space(6) que_empresa
   "Subdiario de Iva Ventas" AT 55
   "Página:" AT 99 PAGE-NUMBER FORMAT "9999" AT 106
   SKIP
   space(6) fecha_lis
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
   space(6) Sub_header_vta.fecha
   Sub_header_vta.tip_comprob
   Sub_header_vta.prf_comprob
   Sub_header_vta.nro_comprob
   Sub_header_vta.nombre FORMAT "X(25)"
   Sub_header_vta.cuit
   columnas
   WITH FRAME a DOWN WIDTH 256 USE-TEXT STREAM-IO NO-LABEL NO-UNDERLINE.

FORM
   SPACE(10)
   tt.cdg_tipo_evento 
   tt.tip_comprob
   tt.descripcion COLUMN-LABEL "Totales por condicion"
   tt.v-con_neto FORMAT "ZZZZZZ9.99-"
   tt.v-con_iva FORMAT "ZZZZZZ9.99-"
   tt.v-con_ng FORMAT "ZZZZZZ9.99-"
   tt.v-con_facturado FORMAT "ZZZZZZ9.99-"
   WITH FRAME b DOWN WIDTH 256 USE-TEXT STREAM-IO.

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

  header_tt1 = "                                                                         ".
  header_tt2 = "       FECHA   TD  PVTA   Numero Razon social                C.U.I.T.    ".
  header_sry = "      -------- --  ---- -------- ------------------------- ------------- ".

  FOR EACH Columna_reporte NO-LOCK
      WHERE Columna_reporte.cdg_reporte = "IVA" 
        AND Columna_reporte.cdg_empresa = Empresa.cdg_empresa
         BY Columna_reporte.nro_columna:
     header_tt1 = header_tt1 + " " + Columna_reporte.titulo1 + FILL(" ",12 - LENGTH(Columna_reporte.titulo1)).
     header_tt2 = header_tt2 + " " + Columna_reporte.titulo2 + FILL(" ",12 - LENGTH(Columna_reporte.titulo2)).
     header_sry = header_sry + " " + "------------".
     ntcols = Columna_reporte.nro_columna.
  END.

  header_tt1 = header_tt1 + " " + "No Gravado " + " " + "Total      ".
  header_tt2 = header_tt2 + " " + "           " + " " + "Facturado  ".
  header_sry = header_sry + " " + "-----------" + " " + "-----------".

 {dirprinfile.i &LIN-PAG = 112 }
 /* {dirprinfile.i}*/

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
                   BY Sub_header_vta.fecha
                   BY Sub_header_vta.tip_comprob
                   BY Sub_header_vta.prf_comprob
                   BY Sub_header_vta.nro_comprob.

  GET FIRST q-subdiario.
  DO WHILE AVAILABLE Sub_header_vta:

  
      VIEW FRAME frm-titulo.

      IF NOT Sub_header_vta.anulado
      THEN DO:

          FIND Tipocomprobante OF Sub_header_vta NO-LOCK.

          IF Tipocomprobante.debita
             THEN signo =  1.
             ELSE signo = -1.

          FOR EACH Sub_detalle_vta 
              WHERE Sub_detalle_vta.cdg_empresa = Sub_header_vta.cdg_empresa
                AND Sub_detalle_vta.tip_comprob = Sub_header_vta.tip_comprob
                AND Sub_detalle_vta.prf_comprob = Sub_header_vta.prf_comprob
                AND Sub_detalle_vta.nro_comprob = Sub_header_vta.nro_comprob,
                    Cuenta OF Sub_detalle_vta,
                   FIRST Columna_cuenta OF Cuenta 
                         WHERE Columna_cuenta.cdg_reporte = "IVA"
                           AND Columna_cuenta.cdg_empresa = Empresa.cdg_empresa:

             r-acumula [ Columna_cuenta.nro_columna ] =
                               r-acumula [ Columna_cuenta.nro_columna ] +
                               truncate(Sub_detalle_vta.valor * Sub_header_vta.cambio * signo,2).

          END.
          

          columnas = "".
          r-acumula [ ntcols + 1 ] = 0.
          DO j = 1 TO ntcols:
             columnas = columnas + STRING(r-acumula [ j ],"ZZZZZZ9.99-") + " ".
             g-acumula [ j ] = g-acumula [ j ] + r-acumula [ j ].
             r-acumula [ ntcols + 1 ] =  r-acumula [ ntcols + 1 ] + r-acumula [ j ].
             r-acumula [ j ] = 0.
          END.
          r-acumula [ ntcols + 1 ] = Sub_header_vta.imp_total * signo - r-acumula [ ntcols + 1 ] .
          r-acumula [ ntcols + 2 ] = Sub_header_vta.imp_total * signo.
          g-acumula [ ntcols + 1 ] = r-acumula [ ntcols + 1 ] + g-acumula [ ntcols + 1 ].
          columnas = columnas + STRING(r-acumula [ ntcols + 1 ],"ZZZZZZ9.99-") + " " + STRING(r-acumula [ ntcols + 2 ],"ZZZZZZ9.99-").
       

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
     
      ant_fecha = Sub_header_vta.fecha.
      GET NEXT q-subdiario.
            
  END.
   
  columnas = "".
  DO j = 1 TO ntcols + 1:
      columnas = columnas + STRING(g-acumula [ j ],"ZZZZZZ9.99-") + " ".
      g-acumula [ ntcols + 2 ] =  g-acumula [ ntcols + 2 ] + g-acumula [ j ].
  END.
   
  columnas = columnas + STRING(g-acumula [ ntcols + 2 ],"ZZZZZZ9.99-").
   
  DISPLAY  header_sry
             WITH frame f-subraya.
  DOWN WITH FRAME f-subraya.

  DISPLAY   columnas
             WITH FRAME a.

  DOWN WITH FRAME a.
        
  IF totcond THEN DO: /*se imprime los totales por condicion impositiva*/

  FOR EACH bSub_header_vta NO-LOCK
             WHERE bSub_header_vta.cdg_empresa = Empresa.cdg_empresa
               AND bSub_header_vta.fecha <= has_fecha
               AND bSub_header_vta.fecha >= des_fecha
               AND CAN-DO(lista_tipos,bSub_header_vta.tip_comprob)
               AND bSub_header_vta.prf_comprob <= has_ptovta 
               AND bSub_header_vta.prf_comprob >= des_ptovta ,
               Fac_header NO-LOCK OF bsub_header_vta,
               FIRST Condicion_impos OF Fac_header NO-LOCK,
               FIRST Tipocomprobante OF Fac_header NO-LOCK
               BY bSub_header_vta.tip_comprob
               BY Condicion_impos.cdg_condiva:
          FOR EACH fac_detalle OF fac_header, articulo OF fac_detalle WHERE articulo.nro_tipo_evento <> 0:
              LEAVE.
          END.
          IF NOT AVAILABLE fac_detalle THEN
              acdg_tipo_evento = "--".
          ELSE DO: 
              FIND tipo_evento WHERE tipo_evento.nro_tipo_evento = articulo.nro_tipo_evento NO-LOCK.
              acdg_tipo_evento = tipo_evento.cdg_tipo_evento. 
          END.

   .
    
          FIND tt WHERE 
              tt.cdg_tipo_evento = acdg_tipo_evento AND
              tt.cdg_condiva = condicion_impos.cdg_condiva AND
              tt.tip_comprob = fac_header.tip_comprob NO-ERROR.
          IF NOT AVAILABLE tt THEN DO:
              CREATE tt.
              ASSIGN tt.cdg_tipo_evento = acdg_tipo_evento 
              tt.cdg_condiva = condicion_impos.cdg_condiva
              tt.tip_comprob = fac_header.tip_comprob 
              tt.descripcion = Condicion_impos.descripcion.
          END.
          ASSIGN tt.v-con_neto      = tt.v-con_neto      + truncate(Tipocomprobante.signo * Fac_header.imp_neto , 2 )
                 tt.v-con_iva       = tt.v-con_iva       + TRUNCATE(Tipocomprobante.signo * Fac_header.imp_iva , 2 )
                 tt.v-con_facturado = tt.v-con_facturado + truncate(Tipocomprobante.signo * Fac_header.imp_total , 2 )
                 tt.v-con_ng        = tt.v-con_facturado - tt.v-con_neto - tt.v-con_iva. 
                 
      END.
      FOR EACH tt
          BREAK BY  tt.cdg_tipo_evento
          BY tt.tip_comprob
          BY tt.cdg_condiva:

          IF last-of(tt.cdg_tipo_evento) OR LAST-OF(tt.tip_comprob) OR LAST-OF(tt.cdg_condiva)
          THEN DO:
              
              DISPLAY tt.cdg_tipo_evento
                      tt.tip_comprob
                      tt.descripcion
                      tt.v-con_neto
                      tt.v-con_iva
                      tt.v-con_ng
                      tt.v-con_facturado
                      WITH FRAME b.
              DOWN WITH FRAME b.
    
              ASSIGN v-tot_neto      = v-tot_neto      + tt.v-con_neto     
                     v-tot_iva       = v-tot_iva       + tt.v-con_iva      
                     v-tot_ng       = v-tot_ng         + tt.v-con_ng      
                     v-tot_facturado = v-tot_facturado + tt.v-con_facturado.
          END.
      END.
       
      UNDERLINE tt.descripcion
              tt.v-con_neto
              tt.v-con_iva
              tt.v-con_ng
              tt.v-con_facturado
              WITH FRAME b.
      DOWN WITH FRAME b.
    
      DISPLAY "TOTAL" @ tt.descripcion
                v-tot_neto      @ tt.v-con_neto
                v-tot_iva       @ tt.v-con_iva
                v-tot_ng        @ tt.v-con_ng
                v-tot_facturado @ tt.v-con_facturado
              WITH FRAME b.
      DOWN WITH FRAME b.


  END.

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida, 
                    INPUT 22 ).

END PROCEDURE.

