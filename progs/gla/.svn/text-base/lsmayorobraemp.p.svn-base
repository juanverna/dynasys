/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

DEFINE INPUT PARAMETER lista_empresas AS CHARACTER.
DEFINE INPUT PARAMETER des_obra       LIKE Obra.cdg_obra.
DEFINE INPUT PARAMETER has_obra       LIKE Obra.cdg_obra.
DEFINE INPUT PARAMETER des_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta     LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta     LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER listar_hora    AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina     AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina     AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent    AS LOGICAL.

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_acreed LIKE Asn_detalle.debito.
DEFINE VARIABLE saldo_deudor LIKE Asn_detalle.debito.
DEFINE VARIABLE acm_debitos  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Asn_detalle.credito LABEL "Acum.creditos".

DEFINE VARIABLE tit_obra     AS CHARACTER FORMAT "X(50)".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Libro Mayor de Obras Contables" AT 52 
  "Página:" AT 172 PAGE-NUMBER FORMAT "ZZZ9" AT 180
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 172
  tit_obra AT 52
  SKIP(1)
  WITH WIDTH 250 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Asn_detalle.fecha         COLUMN-LABEL "Fecha!Asiento"
  Asn_header.tip_comprob    COLUMN-LABEL "Ti-!po"
  Asn_header.nro_comprob    COLUMN-LABEL "Número!Asiento"
  Asn_detalle.nro_linea     COLUMN-LABEL "Número!Línea"
  Cuenta.cdg_cuenta         COLUMN-LABEL "Código!Cuenta"
  Cuenta.nombre             COLUMN-LABEL "Denominación!Cuenta"
  Entidad.cdg_entidad       COLUMN-LABEL "Código!Entidad"
  Asn_detalle.debito        COLUMN-LABEL "Importe!Débito"
  Asn_detalle.credito       COLUMN-LABEL "Importe!Crédito"
  saldo                     COLUMN-LABEL "Saldo!Acumulado" 
  Asn_detalle.leyen_detalle COLUMN-LABEL "Leyenda!Movimiento"
  WITH WIDTH 250 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = lista_empresas.
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  {dirprinfile.i}
  
  FOR EACH Obra NO-LOCK
      WHERE Obra.cdg_obra <= has_obra
        AND Obra.cdg_obra >= des_obra
            BREAK BY Obra.cdg_obra:

      tit_obra = TRIM(Obra.cdg_obra) + "-" + Obra.dsc_obra.

      VIEW FRAME frm-titulo.

      RUN calcular_saldo ( OUTPUT acm_debitos, OUTPUT acm_creditos).
      saldo = acm_debitos - acm_creditos.

      FOR EACH  Asn_detalle OF Obra
          WHERE LOOKUP(Asn_detalle.cdg_empresa,lista_empresas) <> 0
            AND Asn_detalle.fecha <= has_fecha
            AND Asn_detalle.fecha >= des_fecha,
                Cuenta OF Asn_detalle,
                Asn_header OF Asn_detalle
                BREAK BY(Asn_detalle.fecha):                              
    
          IF FIRST(Asn_detalle.fecha)
          THEN DO:
                DISPLAY   des_fecha - 1  @ Asn_detalle.fecha
                          acm_debitos    @ Asn_detalle.debito
                          acm_creditos   @ Asn_detalle.credito
                          saldo
                          "Saldo Inicial " @ Cuenta.nombre    
                          WITH FRAME frm-movimiento.
                DOWN WITH FRAME frm-movimiento.
          END.
    
          IF Cuenta.cdg_cuenta <= has_cuenta
             AND Cuenta.cdg_cuenta >= des_cuenta
          THEN DO:   
                FIND Entidad OF Asn_detalle NO-LOCK.
                saldo = saldo + Asn_detalle.debito - Asn_detalle.credito.
                DISPLAY   Asn_detalle.fecha WHEN FIRST-OF(Asn_detalle.fecha)
                          Asn_header.tip_comprob   
                          Asn_header.nro_comprob   
                          Asn_detalle.nro_linea
                          Cuenta.cdg_cuenta
                          Cuenta.nombre
                          Entidad.cdg_entidad
                          Asn_detalle.debito  WHEN Asn_detalle.debito <> 0
                          Asn_detalle.credito WHEN Asn_detalle.credito <> 0
                          saldo
                          Asn_detalle.leyen_detalle    
                          WITH FRAME frm-movimiento.
                DOWN WITH FRAME frm-movimiento.
          
                acm_creditos = acm_creditos + Asn_detalle.credito.
                acm_debitos  = acm_debitos  + Asn_detalle.debito.
          END.
    
      END. /* De los movimientos de una obra */
    
      UNDERLINE
              Asn_detalle.fecha
              Asn_header.tip_comprob   
              Asn_header.nro_comprob   
              Asn_detalle.nro_linea
              Cuenta.cdg_cuenta
              Cuenta.nombre
              Entidad.cdg_entidad
              Asn_detalle.debito
              Asn_detalle.credito
              saldo
              Asn_detalle.leyen_detalle    
              WITH FRAME frm-movimiento.
    
      DISPLAY 
              acm_creditos @ Asn_detalle.credito
              acm_debitos  @ Asn_detalle.debito
              saldo
              WITH FRAME frm-movimiento.
    
      IF NOT LAST (Obra.cdg_obra) THEN PAGE.
     /* DOWN 2 WITH FRAME frm-movimiento.*/

  END. /* De recorrer las obras. */

  OUTPUT CLOSE.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Asn_detalle OF Obra 
       WHERE Asn_detalle.fecha_mayor < des_fecha 
         AND LOOKUP(Asn_detalle.cdg_empresa,lista_empresas) <> 0
          BY Asn_detalle.fecha_mayor:

       tot_debitogr  = tot_debitogr + Asn_detalle.debito.
       tot_creditogr = tot_creditogr + Asn_detalle.credito.

   END.

END.

 
