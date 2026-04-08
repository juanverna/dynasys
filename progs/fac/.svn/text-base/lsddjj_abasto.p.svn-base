/*==========================================================================================================*/
/*                               LISTADO DE DD JJ ABASTO POR MUNICIPIO                                      */
/*==========================================================================================================*/

DEFINE INPUT PARAMETER   des_codigo     LIKE Municipio.cdg_municipio.
DEFINE INPUT PARAMETER   has_codigo     LIKE Municipio.cdg_municipio.
DEFINE INPUT PARAMETER   des_fecha      AS DATE.
DEFINE INPUT PARAMETER   has_fecha      AS DATE.
DEFINE INPUT PARAMETER   det_sino       AS LOGICAL.

/*==========================================================================================================*/
/*                                          VARIABLES                                                       */
/*==========================================================================================================*/

{VRSHARED.I}
{VPERSINM.I}

DEFINE VARIABLE v-importe_abasto   AS DECIMAL FORMAT "->>,>>>,>>9.99" COLUMN-LABEL "Importe!Abasto".
DEFINE VARIABLE que_comprobante    AS CHARACTER FORMAT "X(16)" COLUMN-LABEL "Identificación!del Comprobante".
DEFINE VARIABLE v-total_grupoabasto AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-total_municipio  AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE que_municipio      AS CHARACTER FORMAT "X(40)".
DEFINE VARIABLE cero_sino          AS LOGICAL INITIAL NO.

{WGLISTAR.I}
{dfvarimp.i}

DEFINE FRAME frm-titulo HEADER
  que_empresa 
  "Declaración Jurada de Abasto" AT 89
  "Página:" AT 173 PAGE-NUMBER FORMAT ">>>9" AT 181
  SKIP
  fecha_lis
  "del" AT 89
  des_fecha
  "al"
  has_fecha
  hora_lis AT 173
  SKIP
  que_municipio AT 89
  SKIP(1)
  WITH WIDTH 230 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-listado
  Articulo.cdg_articulo
  Articulo.descripcion
  Cliente.cdg_cliente
  Cliente.nom_cliente
  que_comprobante
  Fac_detalle.cantidad
  Fac_detalle.granel
  Fac_detalle.subtotal_neto
  Tasa_abasto.valor_tasa
  v-importe_abasto
  WITH WIDTH 230 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

RUN listar.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

PROCEDURE listar:

  {findempresa.i}
  {dirprinfile.i}
  
  que_empresa = Empresa.nombre.

  FOR EACH Fac_header NO-LOCK
      WHERE Fac_header.cdg_empresa = Empresa.cdg_empresa
        AND Fac_header.fecha <= has_fecha
        AND Fac_header.fecha >= des_fecha
        /*AND Fac_header.modo_abasto <> ""*/,
      FIRST Cliente OF Fac_header,
      FIRST Domicilio OF Fac_header
           WHERE Domicilio.cdg_municipio <= has_codigo
             AND Domicilio.cdg_municipio >= des_codigo,
      EACH Fac_detalle OF Fac_header, FIRST Articulo OF Fac_detalle, 
        FIRST Tasa_abasto WHERE Tasa_abasto.cdg_grupoabasto = Articulo.cdg_grupoabasto
                            AND Tasa_abasto.cdg_municipio = Domicilio.cdg_municipio
                            AND Tasa_abasto.rige_desde <= Fac_header.fecha
                            AND Tasa_abasto.rige_hasta >= Fac_header.fecha
                                BREAK BY Domicilio.cdg_municipio 
                                      BY Articulo.cdg_grupoabasto 
                                      BY Articulo.cdg_articulo 
                                      BY Fac_header.fecha:

      VIEW FRAME frm-titulo.

      IF FIRST-OF(Domicilio.cdg_municipio)
      THEN DO:
          FIND Municipio OF Domicilio NO-LOCK.
          que_municipio = Municipio.cdg_municipio + " - " + Municipio.dsc_municipio.
      END.

      v-importe_abasto = Fac_detalle.cantidad * Tasa_abasto.valor_tasa.
      que_comprobante  = Fac_header.tip_comprob + " " +
                         STRING(Fac_header.prf_comprob,"9999") + " " +
                         STRING(Fac_header.nro_comprob,"99999999").
      
      DISPLAY 
          Articulo.cdg_articulo WHEN FIRST-OF(Articulo.cdg_articulo)
          Articulo.descripcion  WHEN FIRST-OF(Articulo.cdg_articulo)
          Cliente.cdg_cliente
          Cliente.nom_cliente
          que_comprobante
          Fac_detalle.cantidad
          Fac_detalle.granel
          Fac_detalle.subtotal_neto
          Tasa_abasto.valor_tasa
          v-importe_abasto 
          WITH FRAME frm-listado.
      DOWN WITH FRAME frm-listado.

      v-total_municipio = v-total_municipio + v-importe_abasto.

      v-total_grupoabasto = v-total_grupoabasto + v-importe_abasto.

      IF LAST-OF(Articulo.cdg_grupoabasto)
      THEN DO:
          UNDERLINE v-importe_abasto
                    WITH FRAME frm-listado.
          DISPLAY v-total_grupoabasto @ v-importe_abasto
                    WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.

          v-total_grupoabasto = 0.
      END.
            
      DOWN WITH FRAME frm-listado.


      IF LAST-OF(Domicilio.cdg_municipio)
      THEN DO:
          UNDERLINE v-importe_abasto 
                    WITH FRAME frm-listado.
          DISPLAY v-total_municipio @ v-importe_abasto
                    WITH FRAME frm-listado.
          DOWN WITH FRAME frm-listado.

          v-total_municipio = 0.
          PAGE.
      END.

 END.

 OUTPUT CLOSE.

 RUN veresult.w ( INPUT arch_salida,
                  INPUT 22 ).

END PROCEDURE.


