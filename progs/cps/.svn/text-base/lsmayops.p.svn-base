/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VPERSINM.I}
{VRSHARED.I }

DEFINE INPUT PARAMETER que_obra     LIKE Obra.nro_obra.
DEFINE INPUT PARAMETER des_fecha    LIKE Aps_detalle.fecha.
DEFINE INPUT PARAMETER has_fecha    LIKE Aps_detalle.fecha.
DEFINE INPUT PARAMETER des_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER has_ctapsp   LIKE Ctapsp.cdg_ctapsp.
DEFINE INPUT PARAMETER listar_hora  AS LOGICAL.
DEFINE INPUT PARAMETER lin_pagina   AS INTEGER.
DEFINE INPUT PARAMETER ult_pagina   AS INTEGER.
DEFINE INPUT PARAMETER todas_cuent  AS LOGICAL.

DEFINE VARIABLE que_empresa  LIKE Empresa.nombre.
DEFINE VARIABLE chr_obra     AS CHARACTER FORMAT "X(70)".

DEFINE VARIABLE fecha_lis    AS CHARACTER.
DEFINE VARIABLE hora_lis     AS CHARACTER.

DEFINE VARIABLE fecha_fr     AS CHARACTER.
DEFINE VARIABLE hora_fr      AS CHARACTER.
DEFINE VARIABLE transpor     AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes      AS DATE.

DEFINE VARIABLE nro_pagina   AS INTEGER FORMAT "999".

DEFINE VARIABLE saldo        LIKE Aps_detalle.debito LABEL "Saldo".
DEFINE VARIABLE saldo_acreed LIKE Aps_detalle.debito.
DEFINE VARIABLE saldo_deudor LIKE Aps_detalle.debito.
DEFINE VARIABLE acm_debitos  LIKE Aps_detalle.debito LABEL "Acum.debitos".
DEFINE VARIABLE acm_creditos LIKE Aps_detalle.credito LABEL "Acum.creditos".

{WGLISTAR.I}

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Libro Mayor Presupuestado de Obras" AT 72 
  "Página:" AT 162 PAGE-NUMBER FORMAT "ZZZ9" AT 169
  SKIP  
  fecha_lis   
  "del" AT 72
  des_fecha
  "al" 
  has_fecha 
  hora_lis AT 162
  chr_obra AT 72
  SKIP(1)
  "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha    Asiento Nro.   Imputación Contable                           Entidad        Debitos       Creditos          Saldo             O B S E R V A C I O N E S            " SKIP
  "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------" SKIP
  WITH WIDTH 200 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE NO-BOX.

DEFINE FRAME frm-encabezado
  SPACE(24)
  saldo
  "Saldo inicial"
  WITH WIDTH 132 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  Aps_detalle.fecha         
  Aps_header.tip_comprob   
  Aps_header.nro_comprob   
  Aps_detalle.nro_linea
  Ctapsp.cdg_ctapsp
  Ctapsp.nombre
  Entidad.cdg_entidad COLUMN-LABEL "Entidad"
  Aps_detalle.debito
  Aps_detalle.credito
  saldo
  Aps_detalle.leyen_detalle
  WITH WIDTH 200 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                          B L O Q U E   P R I N C I P A L                        */
/*=================================================================================*/

{SETIMPRE.I}

FIND Empresa WHERE ROWID(Empresa) = act_empresa NO-LOCK.
que_empresa = Empresa.nombre.
RUN LISTAR.  

/*=================================================================================*/
/*                          P R O C E D I M I E N T O S                            */
/*=================================================================================*/

PROCEDURE LISTAR:

  IF listar_hora
  THEN DO:
     fecha_lis = STRING(TODAY).
     hora_lis = STRING(TIME,"HH:MM:SS").
  END.
  ELSE DO:   
     fecha_lis = " ".
     hora_lis = " ".
  END.

  ASSIGN
      acm_debitos = 0 
      acm_creditos = 0
      saldo = 0.

  PAUSE 0.
  mensaje = "    Procesando ...".        
  DISPLAY mensaje WITH FRAME frm-espere.
  
  OUTPUT TO VALUE (dire_tmp + "lsmayops.txt") PAGED PAGE-SIZE VALUE(lin_pagina).
 
  RUN PONE_CODIGO ( INPUT "SET17CPI,CARTA,SET8LPI" ).
  
  FIND Obra WHERE Obra.nro_obra = que_obra NO-LOCK.
  chr_obra = "Obra:" + Obra.cdg_obra + " - " + Obra.dsc_obra.
  FOR EACH  Aps_detalle OF Obra
      WHERE Aps_detalle.fecha <= has_fecha,
            Ctapsp OF Aps_detalle,
            Aps_header OF Aps_detalle
            BREAK BY(Aps_detalle.fecha):
        
      VIEW FRAME frm-titulo.

      FIND Entidad OF Aps_detalle NO-LOCK.
      saldo = saldo + Aps_detalle.debito - Aps_detalle.credito.

      DISPLAY   Aps_detalle.fecha WHEN FIRST-OF(Aps_detalle.fecha)
                Aps_header.tip_comprob   
                Aps_header.nro_comprob   
                Aps_detalle.nro_linea
                Ctapsp.cdg_ctapsp
                Ctapsp.nombre
                Entidad.cdg_entidad
                Aps_detalle.debito  WHEN Aps_detalle.debito <> 0
                Aps_detalle.credito WHEN Aps_detalle.credito <> 0
                saldo
                Aps_detalle.leyen_detalle    
                WITH FRAME frm-movimiento.
      DOWN WITH FRAME frm-movimiento.

      acm_creditos = acm_creditos + Aps_detalle.credito.
      acm_debitos  = acm_debitos  + Aps_detalle.debito.

  END.   

  UNDERLINE
          Aps_header.tip_comprob   
          Aps_header.nro_comprob   
          Aps_detalle.nro_linea
          Ctapsp.cdg_ctapsp
          Ctapsp.nombre
          Entidad.cdg_entidad
          Aps_detalle.debito
          Aps_detalle.credito
          saldo
          WITH FRAME frm-movimiento.

  DISPLAY 
          acm_creditos @ Aps_detalle.credito
          acm_debitos  @ Aps_detalle.debito
          saldo
          WITH FRAME frm-movimiento.

  DOWN 2 WITH FRAME frm-movimiento.
  
  OUTPUT CLOSE.
  PAUSE 0.
  HIDE FRAME frm-espere.

END PROCEDURE.  

PROCEDURE CALCULAR_SALDO:

   DEFINE INPUT  PARAMETER hasta_fecha   AS DATE.
   DEFINE OUTPUT PARAMETER tot_debitogr  AS DECIMAL.
   DEFINE OUTPUT PARAMETER tot_creditogr AS DECIMAL.

   tot_debitogr = 0.
   tot_creditogr = 0.

   FOR EACH Aps_detalle OF Obra 
       WHERE Aps_detalle.fecha_mayor < hasta_fecha 
          BY Aps_detalle.fecha_mayor:

       tot_debitogr  = tot_debitogr + Aps_detalle.debito.
       tot_creditogr = tot_creditogr + Aps_detalle.credito.

   END.

END.

{CODIMPRE.I}
 
