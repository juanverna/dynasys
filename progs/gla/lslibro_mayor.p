/*=================================================================================*/
/*                   IMPRIME EL MAYOR PARA UN RANGO DE CUENTAS                     */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha         LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha         LIKE Asn_detalle.fecha.
DEFINE INPUT PARAMETER des_cuenta        LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER has_cuenta        LIKE Cuenta.cdg_cuenta.
DEFINE INPUT PARAMETER listar_hora       AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina        AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina        AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent       AS LOGICAL.
DEFINE INPUT PARAMETER v-cdg_moneda      LIKE Moneda.cdg_moneda.
DEFINE INPUT PARAMETER p-reexpresion     AS LOGICAL.

/*=================================================================================*/
/*                                     VARIABLES                                   */
/*=================================================================================*/

{VRSHARED.I }
{dfvarimp.i}

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo        LIKE Asn_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_acreed LIKE Asn_detalle.debito.
DEFINE VARIABLE saldo_deudor LIKE Asn_detalle.debito.
DEFINE VARIABLE acm_debitos  LIKE Asn_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Asn_detalle.credito LABEL "Acum.creditos".
DEFINE VARIABLE tit_moneda   AS CHARACTER FORMAT "X(50)".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Libro Mayor Por Cuenta Contable" AT 52 
  "Página:" AT 135 PAGE-NUMBER FORMAT "ZZZ9" AT 142
  SKIP  
  fecha_lis   
  "del" AT 52
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 135
  SKIP
  tit_moneda AT 52
  SKIP(1)
  "-------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Cuenta                                                                                                                                           " SKIP
  "        Fecha    Asiento Nro.   Entidad  Obra Nro.           Debitos          Creditos             Saldo     O B S E R V A C I O N E S           " SKIP
  "-------------------------------------------------------------------------------------------------------------------------------------------------" SKIP 
  WITH WIDTH 160 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-encabezado
  Cuenta.cdg_cuenta
  Cuenta.nombre
  SPACE(7)
  acm_debitos  
  acm_creditos
  saldo
  "Saldo inicial"
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  SPACE(8)
  Asn_detalle.fecha         
  Asn_header.tip_comprob   
  Asn_header.nro_comprob   
  Asn_detalle.nro_linea
  Entidad.cdg_entidad COLUMN-LABEL "Entidad"
  Obra.cdg_obra COLUMN-LABEL "Obra Nro."
  Asn_detalle.debito
  Asn_detalle.credito
  saldo
  Asn_detalle.leyen_detalle
  WITH WIDTH 190 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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

  {dirprinfile.i}

  FIND Moneda WHERE Moneda.cdg_moneda = v-cdg_moneda NO-LOCK.
  IF p-reexpresion 
     THEN tit_moneda = "REEXPRESADO EN " + Moneda.descripcion.
     ELSE tit_moneda = "MONEDA ORIGINAL " + Moneda.descripcion.

  FOR EACH Cuenta 
      WHERE Cuenta.cdg_cuenta <= has_cuenta
        AND Cuenta.cdg_cuenta >= des_cuenta
        AND (CAN-FIND(FIRST Asn_detalle OF Cuenta 
                            WHERE Asn_detalle.fecha_mayor >= des_fecha 
                              AND Asn_detalle.fecha_mayor <= has_fecha
                              AND Asn_detalle.cdg_empresa = Empresa.cdg_empresa
                              AND Asn_detalle.nro_moneda = Moneda.nro_moneda
                              AND Asn_detalle.reexpresion = p-reexpresion)
                      OR todas_cuent):                              
        
      VIEW FRAME frm-titulo.

      RUN calculasaldo_cuenta.p ( INPUT Cuenta.cdg_cuenta,
                                  INPUT Empresa.cdg_empresa,
                                  INPUT Moneda.cdg_moneda,
                                  INPUT p-reexpresion,
                                  INPUT des_fecha - 1,
                                  OUTPUT acm_debitos, 
                                  OUTPUT acm_creditos).
      saldo = acm_debitos  - acm_creditos.

      DISPLAY  Cuenta.cdg_cuenta
               Cuenta.nombre
               acm_debitos  
               acm_creditos
               saldo
               WITH FRAME frm-encabezado.

       FOR EACH Asn_detalle OF Cuenta
          WHERE Asn_detalle.cdg_empresa = Empresa.cdg_empresa
            AND Asn_detalle.fecha >= des_fecha 
            AND Asn_detalle.fecha <= has_fecha
            AND Asn_detalle.nro_moneda = Moneda.nro_moneda
            AND Asn_detalle.reexpresion = p-reexpresion,
            FIRST Entidad OF Asn_detalle NO-LOCK,
          FIRST Asn_header OF Asn_detalle
                BREAK BY(Asn_detalle.fecha):
 
          FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.
          saldo = saldo + Asn_detalle.debito - Asn_detalle.credito.

          DISPLAY   Asn_detalle.fecha      WHEN FIRST-OF(Asn_detalle.fecha)
                    Asn_header.tip_comprob   
                    Asn_header.nro_comprob   
                    Asn_detalle.nro_linea
                    Obra.cdg_obra          WHEN AVAILABLE Obra
                    Entidad.cdg_entidad
                    Asn_detalle.debito     WHEN Asn_detalle.debito <> 0
                    Asn_detalle.credito    WHEN Asn_detalle.credito <> 0
                    saldo
                    Asn_detalle.leyen_detalle    
                    WITH FRAME frm-movimiento.
          DOWN WITH FRAME frm-movimiento.

          acm_creditos = acm_creditos + Asn_detalle.credito.
          acm_debitos  = acm_debitos  + Asn_detalle.debito.

      END.   

      UNDERLINE
              Asn_header.tip_comprob   
              Asn_header.nro_comprob   
              Asn_detalle.nro_linea
              Obra.cdg_obra
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
      
  END.
  
  OUTPUT CLOSE.
  
  RUN veresult.w ( INPUT arch_salida,
                   INPUT 22 ).
  
END.  

