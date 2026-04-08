/*=================================================================================*/
/*                                    PARAMETROS                                   */
/*=================================================================================*/

DEFINE INPUT PARAMETER act_asiento    AS ROWID.
DEFINE INPUT PARAMETER p-reexpresion  AS LOGICAL.
DEFINE INPUT PARAMETER p-que_moneda   LIKE Moneda.nro_moneda.

/*=================================================================================*/
/*                           VARIABLES, FRAMES, Y SUBMENUES                        */
/*=================================================================================*/
/*
{VRSHARED.I }
*/
{parlocales.i}
{dfvarimp.i}

DEFINE VARIABLE nro_pagina    AS INTEGER FORMAT "9999".
DEFINE VARIABLE nro_asiento   LIKE Asn_header.nro_comprob.

DEFINE VARIABLE transpor      AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE pri_mes       AS DATE.

DEFINE VARIABLE m-creditos    LIKE Asn_totales.tot_creditos LABEL "Acum.creditos".
DEFINE VARIABLE m-debitos     LIKE Asn_totales.tot_debitos  LABEL "Acum.debitos".
DEFINE VARIABLE lis_credito   LIKE Asn_totales.tot_creditos LABEL "Acum.creditos".
DEFINE VARIABLE lis_debito    LIKE Asn_totales.tot_debitos  LABEL "Acum.debitos".

DEFINE FRAME frm-movimiento
  Asn_detalle.nro_linea              FORMAT ">>>>9"
  Cuenta.cdg_cuenta                  FORMAT "X(12)"
  Cuenta.nombre                      FORMAT "X(45)"
  Entidad.cdg_entidad                FORMAT "X(6)"
  Obra.cdg_obra                      FORMAT "X(6)"
  Moneda.abrevia                     FORMAT "X(6)"
  Asn_detalle.debito                 FORMAT "->>>,>>>,>>>,>>9.99"
  Asn_detalle.credito                FORMAT "->>>,>>>,>>>,>>9.99"
  Asn_detalle.cambio                 FORMAT ">>>,>>9.9999"
  Asn_detalle.leyen_detalle          FORMAT "X(35)"
  WITH WIDTH 260 DOWN CENTERED USE-TEXT STREAM-IO.

/*=================================================================================*/
/*                                    IMPRESION                                    */
/*=================================================================================*/
        
FIND Asn_header WHERE ROWID(Asn_header) = act_asiento NO-LOCK.
FIND Empresa OF Asn_header NO-LOCK.
que_empresa = Empresa.nombre.

{dirprinfile.i}

/*---------------------------------------------------------------------------------*/
/*                                    ENCABEZADO                                   */
/*---------------------------------------------------------------------------------*/

DO WITH FRAME frm-movimiento:

      DEFINE FRAME frm-titulo HEADER
          que_empresa
          "Asiento Contable: " AT 69 
          Asn_header.tip_comprob   FORMAT "X(2)"
          Asn_header.nro_comprob   FORMAT ">>>>>>>9"
          "Fecha:" Asn_header.fecha
          "Página:" AT 191 PAGE-NUMBER FORMAT ">>9" AT 198
          SKIP  
          fecha_lis   
          "Leyenda:" AT 69 Asn_header.leyenda FORMAT "X(50)"
          hora_lis FORMAT "X(8)" AT 191 

          SKIP(1)
          WITH WIDTH 250 PAGE-TOP STREAM-IO NO-LABEL NO-UNDERLINE.

      VIEW FRAME frm-titulo.

      ASSIGN
         m-debitos = 0
         m-creditos = 0.
         
      FOR EACH Asn_detalle OF Asn_header 
          WHERE Asn_detalle.reexpresion = p-reexpresion
            AND ( Asn_detalle.nro_moneda = p-que_moneda OR NOT p-reexpresion ),
          EACH Cuenta OF Asn_detalle,
          FIRST Entidad OF Asn_detalle, FIRST Moneda OF Asn_detalle
                BREAK BY Moneda.cdg_moneda:
          
          FIND Obra OF Asn_detalle NO-LOCK NO-ERROR.
          
          DISPLAY Asn_detalle.nro_linea
                  Cuenta.cdg_cuenta
                  Cuenta.nombre
                  Entidad.cdg_entidad
                  Obra.cdg_obra              WHEN AVAILABLE Obra
                  Moneda.abrevia
                  Asn_detalle.debito         WHEN Asn_detalle.debito  <> 0
                  Asn_detalle.credito        WHEN Asn_detalle.credito <> 0
                  Asn_detalle.cambio         WHEN NOT Moneda.es_local
                  Asn_detalle.leyen_detalle    
                  WITH FRAME frm-movimiento.
          DOWN WITH FRAME frm-movimiento.

          m-debitos  = m-debitos  + Asn_detalle.debito.
          m-creditos = m-creditos + Asn_detalle.credito.
          
          IF LAST-OF(Moneda.cdg_moneda)
          THEN DO:

               UNDERLINE 
                    Asn_detalle.debito     
                    Asn_detalle.credito    
                    WITH FRAME frm-movimiento.
               DOWN WITH FRAME frm-movimiento.
               DISPLAY 
                    m-debitos  @ Asn_detalle.debito     
                    m-creditos @ Asn_detalle.credito    
                    WITH FRAME frm-movimiento.
               DOWN 2 WITH FRAME frm-movimiento.

               ASSIGN
                   m-debitos = 0
                   m-creditos = 0.

          END.

      END. /* Del FOR EACH de detalle */   

      UNDERLINE
                  Asn_detalle.nro_linea
                  Cuenta.cdg_cuenta
                  Cuenta.nombre
                  Entidad.cdg_entidad
                  Obra.cdg_obra    
                  Moneda.abrevia
                  Asn_detalle.debito         
                  Asn_detalle.credito        
                  Asn_detalle.cambio        
                  Asn_detalle.leyen_detalle    
                  WITH FRAME frm-movimiento.
      DOWN WITH FRAME frm-movimiento.
      /*
      DISPLAY
                  Asn_header.tot_debitos  @ Asn_detalle.debito         
                  Asn_header.tot_creditos @ Asn_detalle.credito        
                  WITH FRAME frm-movimiento.
      DOWN WITH FRAME frm-movimiento.
      */
      
     OUTPUT CLOSE.

END.

RUN VERESULT.W ( INPUT arch_salida, 
                 INPUT 22).


