/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_asiento  AS ROWID.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/

{VRSHARED.I }

DEFINE VARIABLE que_empresa   LIKE Empresa.nombre.
DEFINE VARIABLE que_modo    LIKE Moneda.descripcion.

DEFINE VARIABLE nro_pagina    AS INTEGER FORMAT "9999".

DEFINE VARIABLE fecha_lis     AS CHARACTER.
DEFINE VARIABLE hora_lis      AS CHARACTER.

DEFINE VARIABLE fecha_fr      AS CHARACTER.
DEFINE VARIABLE hora_fr       AS CHARACTER.
DEFINE VARIABLE transpor      AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes       AS DATE.

DEFINE VARIABLE acm_creditos  LIKE Amp_header.tot_creditos LABEL "Acum.creditos".
DEFINE VARIABLE acm_debitos   LIKE Amp_header.tot_debitos  LABEL "Acum.debitos".
DEFINE VARIABLE lis_credito   LIKE Amp_header.tot_creditos LABEL "Acum.creditos".
DEFINE VARIABLE lis_debito    LIKE Amp_header.tot_debitos  LABEL "Acum.debitos".

DEFINE SHARED TEMP-TABLE T-Amp_header LIKE Amp_header.

DEFINE FRAME frm-titulo HEADER
  que_empresa
  "Asiento Modelo" AT 52 
  "Pagina:" AT 116 nro_pagina AT 123
  SKIP  
  fecha_lis   
  "Modo importes " AT 52
  que_modo
  hora_lis AT 116
  SKIP(1)
  "Transporte de pagina " AT 19
  nro_pagina - 1 
  acm_debitos AT 65
  acm_creditos AT 80
  WITH WIDTH 150 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE.

DEFINE FRAME frm-corte HEADER
  "Transporte a pagina " AT 19
  nro_pagina + 1 
  acm_debitos AT 65
  acm_creditos AT 80
  WITH WIDTH 150 PAGE-BOTTOM STREAM-IO NO-LABEL NO-UNDERLINE.

DEFINE FRAME frm-encabezado
  T-Amp_header.fecha         
  T-Amp_header.tip_comprob   
  T-Amp_header.nro_comprob
  T-Amp_header.leyenda
  WITH WIDTH 150 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  SPACE(8)
  Amp_detalle.nro_linea
  Obra.cdg_obra
  Ctapsp.cdg_ctapsp
  Ctapsp.nombre
  lis_debito
  lis_credito
  Amp_detalle.leyen_detalle
  WITH WIDTH 160 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/

{SETIMPRE.I}
        
FIND FIRST T-Amp_header.

CASE T-Amp_header.modo_importes:
  WHEN "L" THEN que_modo = "Libres".
  WHEN "P" THEN que_modo = "Proporcionales".
  WHEN "F" THEN que_modo = "Fijos".  
END CASE.  

OUTPUT TO VALUE( DIRE_TMP + "prasiemp.txt") PAGED PAGE-SIZE 72.

RUN PONE_CODIGO( INPUT "SET72LPP,CARTA,HORIZONT").

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DO WITH FRAME frm-movimiento:

      VIEW FRAME frm-titulo.

      DISPLAY   T-Amp_header.fecha
                T-Amp_header.tip_comprob   
                T-Amp_header.nro_comprob
                T-Amp_header.leyenda
                WITH FRAME frm-encabezado.      
           
      FOR EACH Amp_detalle OF T-Amp_header,
          EACH Ctapsp OF Amp_detalle:
          
          FIND Obra OF Amp_detalle NO-LOCK NO-ERROR.
          nro_pagina = 1 + PAGE-NUMBER.

          /*
          IF importe_pesos
          THEN DO:
          */
             lis_debito  = Amp_detalle.debito.
             lis_credito = Amp_detalle.credito.
          /*
          END.
          ELSE DO:
             lis_debito  = Amp_detalle.debito_div.
             lis_credito = Amp_detalle.credito_div.
          END.          
          */
          
          DISPLAY Amp_detalle.nro_linea
                  Obra.cdg_obra    WHEN AVAILABLE Obra
                  Ctapsp.cdg_ctapsp
                  Ctapsp.nombre
                  lis_debito       WHEN lis_debito <> 0
                  lis_credito      WHEN lis_credito <> 0
                  Amp_detalle.leyen_detalle    
                  WITH FRAME frm-movimiento.
          DOWN WITH FRAME frm-movimiento.

      END. /* Del FOR EACH de detalle */   

      UNDERLINE
              lis_debito
              lis_credito
              WITH FRAME frm-movimiento.

      /*
      IF importe_pesos
      THEN DO:
      */
         lis_debito  = T-Amp_header.tot_debitos.
         lis_credito = T-Amp_header.tot_creditos.
      /*
      END.
      ELSE DO:
         lis_debito  = T-Amp_header.tot_debitos_div.
         lis_credito = T-Amp_header.tot_creditos_div.
      END.          
      */
      
      acm_creditos = acm_creditos + lis_credito.
      acm_debitos  = acm_debitos  + lis_debito.
      
      DISPLAY 
              lis_debito
              lis_credito
              WITH FRAME frm-movimiento.
      DOWN WITH FRAME frm-movimiento.
      
  
     UNDERLINE
              lis_debito
              lis_credito
              WITH FRAME frm-movimiento.
     DISPLAY 
              acm_creditos @ lis_debito
              acm_debitos  @ lis_credito
              WITH FRAME frm-movimiento.
     DOWN WITH FRAME frm-movimiento.

     OUTPUT CLOSE.

END.

RUN PRINFILE.P ( INPUT DIRE_TMP + "prasiemp.txt", INPUT port).

{CODIMPRE.I}