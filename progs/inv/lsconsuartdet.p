/*=================================================================================*/
/*          EMITE EL LISTADO DE REQUISICIONES POR ARTICULO                         */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_codart  LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER has_codart  LIKE Articulo.cdg_articulo. 
DEFINE INPUT PARAMETER des_nomart  LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER has_nomart  LIKE Articulo.descripcion.
DEFINE INPUT PARAMETER ver_por     AS   INTEGER.
DEFINE INPUT PARAMETER des_codent  LIKE Entidad.cdg_entidad.
DEFINE INPUT PARAMETER has_codent  LIKE Entidad.cdg_entidad.
DEFINE INPUT PARAMETER des_fecha   AS   DATE.
DEFINE INPUT PARAMETER has_fecha   AS   DATE.

{VRSHARED.I}
{VPERSINM.I}
{WGLISTAR.I}
{dfvarimp.i }

DEFINE SHARED VARIABLE nro_entidad AS INTEGER.
DEFINE VARIABLE nom_sector  LIKE Area.denominacion.
DEFINE VARIABLE tot_un      LIKE Cct_stock.cantidad.
DEFINE VARIABLE tot_gr      LIKE Cct_stock.granel.
/*DEFINE VARIABLE tot_br      LIKE Valeinv_dt.subtotal_bruto.*/
/*DEFINE VARIABLE tot_ne      LIKE Valeinv_dt.subtotal_neto. */
DEFINE VARIABLE tot         LIKE Valeinv_dt.subtotal. 

DEFINE VARIABLE precio_prom LIKE Valeinv_dt.costo.

/*DEFINE VARIABLE v-subtotal_bruto LIKE Valeinv_dt.subtotal_bruto.*/
/*DEFINE VARIABLE v-subtotal_neto  LIKE Valeinv_dt.subtotal_neto.*/
DEFINE VARIABLE v-subtotal  LIKE Valeinv_dt.subtotal.

DEFINE VARIABLE v-cantidad       LIKE Valeinv_dt.cantidad.
DEFINE VARIABLE v-granel         LIKE Valeinv_dt.granel.
DEFINE VARIABLE v-signo          AS   DECIMAL.

DEFINE VARIABLE tot_gen_un       LIKE tot_un.
DEFINE VARIABLE tot_gen_gr       LIKE tot_gr.
DEFINE VARIABLE tot_gen          LIKE tot.


DEFINE FRAME frm-titulo HEADER
  que_empresa FORMAT "X(25)"
  "Detalle de Consumos por Artículo" AT 30
  "Página:" AT 73 PAGE-NUMBER FORMAT ">9" AT 80
  SKIP
  fecha_lis
  "Período" AT 55
  des_fecha " - " has_fecha
  hora_lis AT 101
  SKIP(1)
  WITH WIDTH 120 FRAME frm-titulo PAGE-TOP USE-TEXT STREAM-IO.

FORM
    Articulo.cdg_articulo   COLUMN-LABEL "Código!Artículo"
    Articulo.descripcion    COLUMN-LABEL "Descripción!Artículo"
    Articulo.a_granel       COLUMN-LABEL "Gra!nel" FORMAT "Si/"
    Valeinv_hd.tip_comprob  COLUMN-LABEL "Tip!Comp"
    Valeinv_hd.prf_comprob  COLUMN-LABEL "Pto!Vta"
    Valeinv_hd.nro_comprob  COLUMN-LABEL "Número!Comprobante"
    Valeinv_hd.fecha        COLUMN-LABEL "Fecha de!Consumo"
    v-cantidad              COLUMN-LABEL "Cantidad!Consumida"
    Articulo.cdg_umed       COLUMN-LABEL "Uni!dad" 
    Valeinv_dt.costo        COLUMN-LABEL "Costo Unit.!Consumo"
    v-granel                COLUMN-LABEL "Cantidad!Consumida"
    v-subtotal              COLUMN-LABEL "Valuación!Consumo"
   WITH WIDTH 160 FRAME frm-detl USE-TEXT STREAM-IO DOWN.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN LISTAR.
RETURN.

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  FIND FIRST Entidad WHERE Entidad.nro_entidad = nro_entidad no-error.
  PAUSE 0.
  mensaje = "Procesando ...".
  DISPLAY mensaje WITH FRAME frm-espere.
  que_empresa = Empresa.nombre.

  {dirprinfile.i}

  IF ver_por = 1
  THEN DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.cdg_articulo >= des_codart
                         AND Articulo.cdg_articulo <= has_codart
                         AND Articulo.stock_sino
                          BY Articulo.cdg_articulo.
  END.
  ELSE DO:
     OPEN QUERY qry_Articulos
     FOR EACH Articulo WHERE Articulo.descripcion >= des_nomart
                         AND Articulo.descripcion <= has_nomart
                         AND Articulo.stock_sino
                          BY Articulo.descripcion.
  END.

  GET FIRST qry_articulos.
  DO WHILE AVAILABLE Articulo:

     VIEW FRAME frm-titulo.

     tot_un = 0.
     tot_gr = 0.
/*     tot_br = 0.*/
/*     tot_ne = 0.*/
    tot = 0.

     FOR EACH Valeinv_dt OF Articulo, 
              FIRST Valeinv_hd OF Valeinv_dt 
                    WHERE Valeinv_hd.cdg_empresa = Empresa.cdg_empresa 
                      AND Valeinv_hd.fecha <= has_fecha 
                      AND Valeinv_hd.fecha >= des_fecha 
                      AND Valeinv_hd.estado <> "A"
                      /*
                      AND (Valeinv_hd.nro_entidad = Entidad.nro_entidad OR NOT AVAILABLE Entidad)
                      */
                      
                      AND CAN-FIND(FIRST Entidad  WHERE Valeinv_hd.nro_entidad = Entidad.nro_entidad 
                                                    AND Entidad.cdg_entidad >= des_codent 
                                                    AND Entidad.cdg_entidad <= has_codent  )
                      AND (Valeinv_hd.tip_comprob = "VS" OR Valeinv_hd.tip_comprob = "VI")
              BREAK BY Articulo.cdg_articulo BY Valeinv_hd.fecha 
                    BY Valeinv_hd.tip_comprob BY Valeinv_hd.prf_comprob
                    BY Valeinv_hd.nro_comprob:

          VIEW FRAME frm-titulo.

          IF LOOKUP(Valeinv_hd.tip_comprob,"VS") <> 0
             THEN v-signo = 1.
             ELSE v-signo = -1.

          ASSIGN
/*                v-subtotal_bruto = v-signo * Valeinv_dt.subtotal_bruto*/
/*                v-subtotal_neto  = v-signo * Valeinv_dt.subtotal_neto*/
                v-subtotal  = v-signo * Valeinv_dt.subtotal

                v-cantidad       = v-signo * Valeinv_dt.cantidad
                v-granel         = v-signo * Valeinv_dt.granel

                tot_un = tot_un + v-cantidad
                tot_gr = tot_gr + v-granel
/*                tot_br = tot_br + v-subtotal_bruto*/
/*                tot_ne = tot_ne + v-subtotal_neto.*/
                tot = tot + v-subtotal.

          DISPLAY Articulo.cdg_articulo    WHEN FIRST(Articulo.cdg_articulo)
                  Articulo.descripcion     WHEN FIRST(Articulo.cdg_articulo)
                  Articulo.a_granel        WHEN FIRST(Articulo.cdg_articulo)
                  Valeinv_hd.tip_comprob   WHEN FIRST-OF(Valeinv_hd.nro_comprob)
                  Valeinv_hd.prf_comprob   WHEN FIRST-OF(Valeinv_hd.nro_comprob)
                  Valeinv_hd.nro_comprob   WHEN FIRST-OF(Valeinv_hd.nro_comprob)
                  Valeinv_hd.fecha         WHEN FIRST-OF(Valeinv_hd.nro_comprob)
                  v-cantidad
                  Articulo.cdg_umed
                  Valeinv_dt.costo
                  v-granel
/*                  v-subtotal_bruto*/
/*                  v-subtotal_neto*/
                  v-subtotal

                  WITH CENTERED FRAME frm-detl STREAM-IO USE-TEXT.

          DOWN WITH FRAME frm-detl.
/**/  

/**/
          IF LAST(Articulo.cdg_articulo)
          THEN DO:

/*               precio_prom = IF Articulo.a_granel THEN tot_ne / tot_gr ELSE tot_ne / tot_un.*/
               precio_prom = IF Articulo.a_granel THEN tot / tot_gr ELSE tot / tot_un.

               tot_gen_un = tot_gen_un + tot_un.
               tot_gen_gr = tot_gen_gr + tot_gr.
               tot_gen = tot_gen + tot.
                     
               UNDERLINE v-cantidad
                         Articulo.cdg_umed
                         Valeinv_dt.costo
                         v-granel
                         v-subtotal
                         WITH FRAME frm-detl.

               DISPLAY tot_un @ v-cantidad
                       tot_gr @ v-granel
                       precio_prom @ Valeinv_dt.costo
/*                       tot_br @ v-subtotal_bruto*/
/*                       tot_ne @ v-subtotal_neto*/
                       tot @ v-subtotal

                       Articulo.cdg_umed
                       WITH CENTERED FRAME frm-detl DOWN USE-TEXT STREAM-IO.
               DOWN WITH FRAME frm-detl.
               DOWN WITH FRAME frm-detl.

               ASSIGN
                    tot_un = 0
                    tot_gr = 0
/*                    tot_br = 0*/
/*                    tot_ne = 0.*/
                    tot = 0.

          END.            
     
     END.

     GET NEXT qry_articulos.

  END.                

  DOWN WITH FRAME frm-detl.
  UNDERLINE v-cantidad
            Articulo.cdg_umed
            Valeinv_dt.costo
            v-granel
            v-subtotal
            WITH FRAME frm-detl.
            
  DISPLAY "Totales generales:" @ Articulo.descripcion
          tot_gen_un @ v-cantidad
          tot_gen_gr @ v-granel
          /*precio_prom @ Valeinv_dt.costo*/
          tot_gen @ v-subtotal
          WITH CENTERED FRAME frm-detl DOWN USE-TEXT STREAM-IO.

  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 8 ).


END PROCEDURE.

