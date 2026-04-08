/*=================================================================================*/
/*         EMITE EL LISTADO MAYOR DE MOVIMIENTOS POR CUENTA Y OBRA CONTABLE        */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_cuenta     LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta     LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER des_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha      LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_obra       LIKE Obra.cdg_obra.
DEFINE INPUT PARAMETER has_obra       LIKE Obra.cdg_obra.
DEFINE INPUT PARAMETER p-cdg_moneda   LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion  AS LOGICAL.
DEFINE INPUT PARAMETER listar_hora    AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina     AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina     AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent    AS LOGICAL.


/*=================================================================================*/
/*                       VARIABLES, FRAMES, Y SUBMENUES                            */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I}
{dfvarimp.i}

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_acreed LIKE Asn_detalle.debito.
DEFINE VARIABLE saldo_deudor LIKE Asn_detalle.debito.
DEFINE VARIABLE acm_debitos  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tot_debitos  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE tot_creditos LIKE Asn_detalle.credito LABEL "Acum.creditos".

DEFINE VARIABLE tit_cuenta   AS CHARACTER FORMAT "X(50)".
DEFINE VARIABLE tit_moneda   AS CHARACTER FORMAT "X(50)".

DEFINE BUFFER B-Asn_detalle FOR Asn_detalle.

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Mayor de Cuentas con apertura por Obra Contable" AT 52 
  "Página:" AT 166 PAGE-NUMBER FORMAT "ZZZ9" AT 174
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 166
  tit_cuenta AT 52
  SKIP
  tit_moneda AT 52
  SKIP(1)
  WITH WIDTH 250 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-movimiento
  Obra.cdg_obra             COLUMN-LABEL "Código!Obra"
  Obra.dsc_obra             COLUMN-LABEL "Denominación!Obra"
  Asn_detalle.fecha         COLUMN-LABEL "Fecha!Asiento"
  Asn_header.tip_comprob    COLUMN-LABEL "Ti-!po"
  Asn_header.nro_comprob    COLUMN-LABEL "Número!Asiento"
  Asn_detalle.nro_linea     COLUMN-LABEL "Número!Línea"
  Entidad.cdg_entidad       COLUMN-LABEL "Código!Entidad"
  Asn_detalle.debito        COLUMN-LABEL "Importe!Débito"
  Asn_detalle.credito       COLUMN-LABEL "Importe!Crédito"
  saldo                     COLUMN-LABEL "Saldo!Acumulado" 
  Asn_detalle.leyen_detalle COLUMN-LABEL "Leyenda!Movimiento"
  WITH WIDTH 250 DOWN CENTERED USE-TEXT STREAM-IO NO-BOX.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

que_empresa = Empresa.nombre.

FIND Moneda WHERE Moneda.cdg_moneda = p-cdg_moneda NO-LOCK.
IF p-reexpresion 
   THEN tit_moneda = "REEXPRESADO EN " + Moneda.descripcion.
   ELSE tit_moneda = "MONEDA ORIGINAL " + Moneda.descripcion.

RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  {dirprinfile.i}
  
  FOR EACH Cuenta NO-LOCK
      WHERE Cuenta.cdg_cuenta <= has_cuenta
        AND Cuenta.cdg_cuenta >= des_cuenta
            BREAK BY Cuenta.cdg_cuenta:

      tit_cuenta = TRIM(Cuenta.cdg_cuenta) + "-" + Cuenta.nombre_cta.

      ASSIGN tot_creditos = 0
             tot_debitos  = 0.

      VIEW FRAME frm-titulo.

      FOR EACH  Asn_detalle OF Cuenta           
          WHERE Asn_detalle.cdg_empresa = Empresa.cdg_empresa 
            AND Asn_detalle.fecha <= has_fecha
            AND Asn_detalle.fecha >= des_fecha   
            AND Asn_detalle.nro_moneda = Moneda.nro_moneda 
            AND Asn_detalle.reexpresion = p-reexpresion,
                FIRST Obra OF Asn_detalle
                        WHERE Obra.cdg_obra <= has_obra
                          AND Obra.cdg_obra >= des_obra,
                Entidad OF Asn_detalle,
                Asn_header OF Asn_detalle
                BREAK BY(Obra.cdg_obra)
                      BY(Asn_detalle.fecha):                              

          IF FIRST-OF(Obra.cdg_obra)
          THEN DO:

              RUN calcular_saldo ( OUTPUT acm_debitos, OUTPUT acm_creditos).
              saldo = acm_debitos - acm_creditos.

              DISPLAY   des_fecha - 1  @ Asn_detalle.fecha
                        acm_debitos    @ Asn_detalle.debito
                        acm_creditos   @ Asn_detalle.credito
                        saldo
                        "Saldo Inicial " @ Obra.dsc_obra    
                        WITH FRAME frm-movimiento.
              DOWN WITH FRAME frm-movimiento.

          END.

          saldo = saldo + Asn_detalle.debito - Asn_detalle.credito.
          DISPLAY   Obra.cdg_obra     WHEN FIRST-OF(Obra.cdg_obra)
                    Obra.dsc_obra     WHEN FIRST-OF(Obra.cdg_obra)
                    Asn_detalle.fecha WHEN FIRST-OF(Asn_detalle.fecha)
                    Asn_header.tip_comprob   
                    Asn_header.nro_comprob   
                    Asn_detalle.nro_linea
                    Entidad.cdg_entidad
                    Asn_detalle.debito  WHEN Asn_detalle.debito <> 0
                    Asn_detalle.credito WHEN Asn_detalle.credito <> 0
                    saldo
                    Asn_detalle.leyen_detalle    
                    WITH FRAME frm-movimiento.
          DOWN WITH FRAME frm-movimiento.
      
          acm_creditos = acm_creditos + Asn_detalle.credito.
          acm_debitos  = acm_debitos  + Asn_detalle.debito.

          IF LAST-OF(Obra.cdg_obra)
          THEN DO:

              UNDERLINE
                      Asn_detalle.fecha
                      Asn_header.tip_comprob   
                      Asn_header.nro_comprob   
                      Asn_detalle.nro_linea
                      Obra.cdg_obra
                      Obra.dsc_obra
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

              DOWN 2 WITH FRAME frm-movimiento.

              tot_debitos = tot_debitos + acm_debitos.
              tot_creditos = tot_creditos + acm_creditos.

          END.
    
      END. /* De los movimientos de una cuenta */

      UNDERLINE
              Asn_detalle.fecha
              Asn_header.tip_comprob   
              Asn_header.nro_comprob   
              Asn_detalle.nro_linea
              Obra.cdg_obra
              Obra.dsc_obra
              Entidad.cdg_entidad
              Asn_detalle.debito
              Asn_detalle.credito
              saldo
              Asn_detalle.leyen_detalle    
              WITH FRAME frm-movimiento.
    
      saldo = tot_debitos - tot_creditos.

      DISPLAY 
              tot_creditos @ Asn_detalle.credito
              tot_debitos  @ Asn_detalle.debito
              saldo
              WITH FRAME frm-movimiento.
    
      IF NOT LAST (Cuenta.cdg_cuenta) THEN PAGE.
     /* DOWN 2 WITH FRAME frm-movimiento.*/

  END. /* De recorrer las cuentas. */

  OUTPUT CLOSE.

  RUN veresult.w ( INPUT arch_salida , INPUT 22 ).

END PROCEDURE.  

PROCEDURE calcular_saldo:

   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   DEFINE VARIABLE x-comienzo_ejercicio   LIKE Asn_detalle.fecha.

   tot_debitogr = 0.
   tot_creditogr = 0.

   RUN comienzo_ejercicio.p ( INPUT des_fecha, OUTPUT x-comienzo_ejercicio ).

   FOR EACH B-Asn_detalle OF Cuenta
       WHERE B-Asn_detalle.fecha_mayor < des_fecha 
         AND B-Asn_detalle.fecha >= x-comienzo_ejercicio
         AND B-Asn_detalle.cdg_empresa = Empresa.cdg_empresa
         AND B-Asn_detalle.nro_cuenta = Cuenta.nro_cuenta
         AND B-Asn_detalle.nro_obra = Obra.nro_obra
         AND B-Asn_detalle.nro_moneda = Moneda.nro_moneda
         AND B-Asn_detalle.reexpresion = p-reexpresion:

       tot_debitogr  = tot_debitogr + B-Asn_detalle.debito.
       tot_creditogr = tot_creditogr + B-Asn_detalle.credito.

   END.
  /*MESSAGE "Antas del veresult.w" VIEW-AS ALERT-BOX.
  RUN veresult.w ( INPUT "caca.txt",
                   INPUT 22 ).
  MESSAGE "Despues del veresult.w" VIEW-AS ALERT-BOX.*/
END.

 
