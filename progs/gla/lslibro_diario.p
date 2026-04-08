/*=================================================================================*/
/*                   IMPRIME EL DIARIO PARA UN RANGO DE FECHAS                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        LIKE Asn_header.fecha.
DEFINE INPUT PARAMETER has_fecha        LIKE Asn_header.fecha.
DEFINE INPUT PARAMETER v-cdg_moneda     LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresar     AS LOGICAL.
DEFINE INPUT PARAMETER listar_hora      AS LOGICAL.
DEFINE INPUT PARAMETER p-acm_debitos    AS DECIMAL.
DEFINE INPUT PARAMETER ult_pagina       AS INTEGER.
DEFINE INPUT PARAMETER renumerar        AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }
{dfvarimp.i}
{WGLISTAR.I}

DEFINE VARIABLE numero_pagina  AS INTEGER FORMAT "ZZZZZ9".
DEFINE VARIABLE tit_moneda     AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE ry             AS CHARACTER.
DEFINE VARIABLE j              AS INTEGER.

DEFINE VARIABLE v-acm_debitos  AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEFINE VARIABLE v-acm_creditos AS DECIMAL FORMAT "->>,>>>,>>9.99".

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Libro Diario" AT 58 
  "Página:" AT 140 (PAGE-NUMBER + ult_pagina) FORMAT "ZZZZZ9" AT 149
  SKIP  
  fecha_lis   
  "del" AT 58
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 140
  SKIP
  tit_moneda AT 58 
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha    Asiento Nro.                                                                                                                                     " SKIP
  "            Cuenta                                       Entidad  Obra Nro.       Debitos       Creditos O B S E R V A C I O N E S                        " SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  "                                    Transporte de pagina " PAGE-NUMBER + ULT_PAGINA - 1 FORMAT "ZZZZZ9" 
  v-acm_debitos AT 76 v-acm_creditos SKIP(1)
  WITH WIDTH 160 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-footer HEADER
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "                                    Transporte a pagina  " PAGE-NUMBER + ULT_PAGINA + 1 FORMAT "ZZZZZ9"
  v-acm_debitos AT 76 v-acm_creditos SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP(1)
  WITH WIDTH 160 PAGE-BOTTOM STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-encabezado
  Asn_header.fecha
  Asn_header.tip_comprob
  Asn_header.prf_comprob  
  Asn_header.nro_comprob
  Asn_header.leyenda
  WITH WIDTH 260 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  SPACE(8)
  Asn_detalle.nro_linea
  Cuenta.cdg_cuenta
  Cuenta.nombre_cta
  Entidad.cdg_entidad COLUMN-LABEL "Entidad"
  Obra.cdg_obra COLUMN-LABEL "Obra Nro."
  Asn_detalle.debito
  Asn_detalle.credito
  Asn_detalle.leyen_detalle
  WITH WIDTH 250 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-tachar
  ry  FORMAT "X(154)" SKIP
  WITH WIDTH 250 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{findempresa.i}
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

   ry = FILL("-",154).

  {dirprinfile.i}

  IF NOT listar_hora
    THEN ASSIGN fecha_lis = ""
                hora_lis  = "".

  FIND Moneda WHERE Moneda.cdg_moneda = v-cdg_moneda NO-LOCK.
  IF p-reexpresar 
     THEN tit_moneda = "REEXPRESADO EN " + Moneda.descripcion.
     ELSE tit_moneda = "MONEDA ORIGINAL " + Moneda.descripcion.

  v-acm_debitos  = p-acm_debitos.
  v-acm_creditos = v-acm_debitos.

  FOR EACH Asn_header
      WHERE Asn_header.cdg_empresa = Empresa.cdg_empresa
        AND Asn_header.fecha >= des_fecha
        AND Asn_header.fecha <= has_fecha, 
        EACH Asn_detalle OF Asn_header 
             WHERE Asn_detalle.nro_moneda = Moneda.nro_moneda
               AND Asn_detalle.reexpresion = p-reexpresar,
               FIRST Cuenta OF Asn_detalle,
               FIRST Entidad OF Asn_detalle
               BREAK BY Asn_header.cdg_empresa
                     BY Asn_header.tip_comprob
                     BY Asn_header.prf_comprob
                     BY Asn_header.nro_comprob
                     BY Asn_detalle.nro_linea:

      VIEW FRAME frm-titulo.
      VIEW FRAME frm-footer.

      FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.

      IF FIRST-OF(Asn_header.nro_comprob)
      THEN DO:
           DISPLAY
                Asn_header.fecha
                Asn_header.tip_comprob
                Asn_header.prf_comprob  
                Asn_header.nro_comprob
                Asn_header.leyenda
                WITH FRAME frm-encabezado.
          DOWN WITH FRAME frm-encabezado.      
      END.
      
      DISPLAY 
            Asn_detalle.nro_linea
            Cuenta.cdg_cuenta
            Cuenta.nombre_cta
            Entidad.cdg_entidad
            Obra.cdg_obra WHEN AVAILABLE Obra
            Asn_detalle.debito WHEN Asn_detalle.debito <> 0
            Asn_detalle.credito WHEN Asn_detalle.credito <> 0
            Asn_detalle.leyen_detalle
            WITH FRAME frm-movimiento.
            
      DOWN WITH FRAME frm-movimiento.      

      v-acm_debitos  = v-acm_debitos  + Asn_detalle.debito.
      v-acm_creditos = v-acm_creditos + Asn_detalle.credito.

      IF LAST-OF(Asn_header.nro_comprob)
      THEN DO:
           FIND Asn_totales 
                WHERE Asn_totales.nro_asiento = Asn_header.nro_asiento
                  AND Asn_totales.nro_moneda  = Moneda.nro_moneda
                  AND Asn_totales.reexpresion = p-reexpresar NO-LOCK.

           UNDERLINE
                    Asn_detalle.debito
                    Asn_detalle.credito
                    WITH FRAME frm-movimiento.

           DOWN WITH FRAME frm-movimiento.      

           DISPLAY
                Asn_totales.tot_debitos  @ Asn_detalle.debito
                Asn_totales.tot_creditos @ Asn_detalle.credito
                WITH FRAME frm-movimiento.
            
           DOWN WITH FRAME frm-movimiento.      

      END.

  END.

  DO j = LINE-COUNTER to PAGE-SIZE:
  
     DISPLAY ry
             WITH FRAME frm-tachar.
     DOWN WITH FRAME frm-tachar.

  END.
  
  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).

END.  

