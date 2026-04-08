/*=================================================================================*/
/*       LISTA ASIENTOS DE CAJA Y GENERA LOS ASIENTOS PARA CONTABILIDAD            */
/*=================================================================================*/

DEFINE INPUT PARAMETER des_fecha        AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER has_fecha        AS DATE FORMAT "99/99/9999".
DEFINE INPUT PARAMETER ver_movim        AS LOGICAL.
DEFINE INPUT PARAMETER ver_resum        AS LOGICAL.
DEFINE INPUT PARAMETER gen_asiento      AS LOGICAL.
DEFINE INPUT PARAMETER fecha_contable   LIKE Asn_header.fecha.

{vrshared.i}
{dfvarimp.i }

DEFINE NEW SHARED VARIABLE a-tip_comprob LIKE Asn_header.tip_comprob NO-UNDO.
DEFINE NEW SHARED VARIABLE a-nro_comprob LIKE Asn_header.nro_comprob NO-UNDO.

DEFINE VARIABLE que_asiento      AS CHARACTER FORMAT "X(12)".
DEFINE VARIABLE titulo_det       AS CHARACTER FORMAT "X(35)".
DEFINE VARIABLE que_leyenda      AS CHARACTER.
DEFINE VARIABLE tgn_debitos_tot  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_tot AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE tgn_debitos_pen  AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Ingresos".
DEFINE VARIABLE tgn_creditos_pen AS DECIMAL FORMAT ">,>>>,>>9.99" LABEL "Egresos".
DEFINE VARIABLE lst_c_tot        AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_tot        AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Debitos".
DEFINE VARIABLE lst_c_pen        AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Creditos".
DEFINE VARIABLE lst_d_pen        AS DECIMAL FORMAT "->,>>>,>>9.99" COLUMN-LABEL "Debitos".

{WGLISTAR.I}

DEFINE BUFFER B-Cuenta FOR Cuenta.

DEFINE WORK-TABLE Acumulado
   FIELD nro_cuenta   LIKE Cuenta.nro_cuenta
   FIELD codigo_dbcr  AS INTEGER
   FIELD debitos      AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD creditos     AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD debitos_pen  AS DECIMAL FORMAT "->,>>>,>>9.99"
   FIELD creditos_pen AS DECIMAL FORMAT "->,>>>,>>9.99".
   
DEFINE FRAME frm-titulo HEADER
  que_empresa
  "<< Detalle de Asientos de Caja >>" AT 44 
  "Página:" AT 102 PAGE-NUMBER FORMAT ">>>>9" AT 109
  SKIP  
  fecha_lis   
  titulo_det AT 44
  hora_lis AT 102       
  SKIP
  "Fecha Contable:" AT 44
  fecha_contable
  " Gen.:" gen_asiento  
  SKIP(1)
  "-----------------------------------------------------------------------------------------------------------------" SKIP
  "Fecha   Comprobante     Observaciones                                                                            " SKIP
  "      Imputacion contable                              Débitos      Créditos Observaciones                       " SKIP
  "-----------------------------------------------------------------------------------------------------------------"  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo TOP-ONLY PAGE-TOP STREAM-IO.

DEFINE FRAME frm-titulo-res HEADER
  que_empresa
  "Asiento Resumen de Caja:" AT 39 
  que_asiento
  "Página:" AT 89 PAGE-NUMBER FORMAT ">>>>9" AT 96
  SKIP  
  fecha_lis   
  titulo_det AT 39
  hora_lis AT 89
  SKIP
  "Fecha Contable:" AT 39
  fecha_contable
  " Gen.:" gen_asiento
  SKIP(1)
  "----------------------------------------------------------------------------------------------------" SKIP
  "                                                         Totales                    Pendiente       " SKIP
  "  Imputacion contable                              Débitos      Créditos       Débitos      Créditos" SKIP
  "----------------------------------------------------------------------------------------------------"  SKIP(1)
  WITH WIDTH 132 FRAME frm-titulo-res TOP-ONLY PAGE-TOP STREAM-IO.
  
DEFINE FRAME frm-encabezado
  Caj_header.fecha         
  Caj_header.tip_comprob   
  Caj_header.nro_comprob            
  SPACE(1)
  Caj_header.contable FORMAT "**/--"
  Caj_header.observacion
  WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento
  Caj_detalle.nro_linea
  Cuenta.cdg_cuenta
  Cuenta.nombre
  lst_d_tot
  lst_c_tot
  Caj_detalle.observacion
  WITH WIDTH 196 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

DEFINE FRAME frm-movimiento-res
  Cuenta.cdg_cuenta
  Cuenta.nombre
  lst_d_tot
  lst_c_tot
  lst_d_pen
  lst_c_pen
  WITH WIDTH 132 DOWN CENTERED USE-TEXT STREAM-IO NO-LABEL NO-BOX NO-UNDERLINE.

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

   titulo_det = "Período: " + STRING(des_fecha) + " al " + STRING(has_fecha).

   {dirprinfile.i &LIN-PAG=72}
 
   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.

   FIND FIRST Acumulado NO-ERROR.
   IF AVAILABLE Acumulado
   THEN DO:
      FOR EACH Acumulado:
          DELETE Acumulado.
      END.    
   END.

   FOR EACH  Caj_header
       WHERE Caj_header.fecha >= des_fecha 
         AND Caj_header.fecha <= has_fecha
         AND Caj_header.cdg_empresa = Empresa.cdg_empresa
         AND Caj_header.estado <> "A" EXCLUSIVE-LOCK
    BREAK BY Caj_header.fecha WITH FRAME frm-listado:
        
       IF ver_movim THEN VIEW FRAME frm-titulo.
          
       RUN ACUMULAR_ENCABEZADO.
            
       IF ver_movim
       THEN DO:
          DISPLAY
              Caj_header.fecha    WHEN FIRST-OF(Caj_header.fecha)     
              Caj_header.tip_comprob   
              Caj_header.nro_comprob
              Caj_header.contable
              Caj_header.observacion           
              WITH FRAME frm-encabezado.
          DOWN WITH FRAME frm-encabezado.    
       END.
       
       IF Caj_header.tipo_mov = "E"
       THEN DO: 
          tgn_debitos_tot = tgn_debitos_tot + Caj_header.importe.
          IF ver_movim
          THEN DO:
            FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = 
                                           Caj_header.nro_transaccion, FIRST Cuenta OF Caja-imputacion:
                DISPLAY
                   Cuenta.cdg_cuenta
                   Cuenta.nombre
                   Caja-imputacion.valor @ lst_d_tot
                   Caja-imputacion.observacion @ Caj_detalle.observacion
                   WITH FRAME frm-movimiento.
                DOWN WITH FRAME frm-movimiento.   

             END.
          END.  
       END.     

       FOR EACH Caj_detalle OF Caj_header,
            EACH Rubro OF Caj_detalle, Cuenta OF Rubro:
                     
           RUN ACUMULAR_DETALLE.          

           IF Caj_header.tipo_mov = "E"
           THEN DO:
               tgn_creditos_tot = tgn_creditos_tot + Caj_detalle.importe.           
               IF ver_movim
               THEN DO:
                  DISPLAY
                     Cuenta.cdg_cuenta
                     Cuenta.nombre
                     Caj_detalle.importe @ lst_c_tot
                     Caj_detalle.observacion
                     WITH FRAME frm-movimiento.
               END.      
           END.
           ELSE DO:
               tgn_debitos_tot = tgn_debitos_tot + Caj_detalle.importe.
               IF ver_movim
               THEN DO:
                  DISPLAY
                     Cuenta.cdg_cuenta
                     Cuenta.nombre
                     Caj_detalle.importe @ lst_d_tot
                     Caj_detalle.observacion
                     WITH FRAME frm-movimiento.
               END.
           END.
           DOWN WITH FRAME frm-movimiento.                  
         
        END. /* De los detalles de movimiento de caja */
           
        IF Caj_header.tipo_mov = "I"
        THEN DO: 
           tgn_creditos_tot = tgn_creditos_tot + Caj_header.importe.           
           IF ver_movim
           THEN DO:
                FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = 
                                               Caj_header.nro_transaccion, FIRST Cuenta OF Caja-imputacion:
                    DISPLAY
                       Cuenta.cdg_cuenta
                       Cuenta.nombre
                       Caja-imputacion.valor @ lst_c_tot
                       Caja-imputacion.observacion @ Caj_detalle.observacion
                       WITH FRAME frm-movimiento.
                    DOWN WITH FRAME frm-movimiento.   
    
                 END.
           END.   
        END.     

        IF ver_movim THEN DOWN 1 WITH FRAME frm-movimiento.   

        IF gen_asiento THEN Caj_header.contable = YES.

   END. /* De los movimientos de caja */

   IF ver_movim
   THEN DO:
      UNDERLINE
          lst_d_tot
          lst_c_tot
          WITH FRAME frm-movimiento.
      DISPLAY
          tgn_debitos_tot  @ lst_d_tot
          tgn_creditos_tot @ lst_c_tot
          WITH FRAME frm-movimiento.
      DOWN WITH FRAME frm-movimiento.   
      HIDE FRAME frm-titulo.
      PAGE.
   END.
   
   tgn_debitos_tot = 0.
   tgn_creditos_tot = 0.
   tgn_debitos_pen = 0.
   tgn_creditos_pen = 0.

   FOR EACH Acumulado:

       IF Acumulado.debitos > Acumulado.creditos
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos = Acumulado.debitos - Acumulado.creditos
                 Acumulado.creditos = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos = Acumulado.creditos - Acumulado.debitos
                 Acumulado.debitos = 0.
       END.

       IF Acumulado.debitos_pen > Acumulado.creditos_pen
       THEN DO:
          ASSIGN Acumulado.codigo_dbcr = 1
                 Acumulado.debitos_pen = Acumulado.debitos_pen - Acumulado.creditos_pen
                 Acumulado.creditos_pen = 0.
       END.
       ELSE DO:          
          ASSIGN Acumulado.codigo_dbcr = 2
                 Acumulado.creditos_pen = Acumulado.creditos_pen - Acumulado.debitos_pen
                 Acumulado.debitos_pen = 0.
       END.

       tgn_debitos_tot   = tgn_debitos_tot + Acumulado.debitos.
       tgn_creditos_tot  = tgn_creditos_tot  + Acumulado.creditos.

       tgn_debitos_pen   = tgn_debitos_pen   + Acumulado.debitos_pen.
       tgn_creditos_pen  = tgn_creditos_pen  + Acumulado.creditos_pen.

   END.

   CLEAR FRAME frm-movimiento-res ALL NO-PAUSE.
   
   IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
   THEN DO:       
      que_leyenda = "Resumen " + titulo_det.
      RUN CREASNHD.P ( INPUT fecha_contable, INPUT que_leyenda, INPUT "CAJ" ).
      FIND Asn_header WHERE ROWID(Asn_header) = act_asn_head EXCLUSIVE-LOCK.
      que_asiento = Asn_header.tip_comprob + " " + STRING(Asn_header.nro_comprob,"999999").
   END.   
   ELSE DO:
      que_asiento = "No Generado".
   END.   

   FOR EACH Acumulado , Cuenta OF Acumulado BY Acumulado.codigo_dbcr:

       lst_d_tot = Acumulado.debitos.
       lst_c_tot = Acumulado.creditos.
       lst_d_pen = Acumulado.debitos_pen.
       lst_c_pen = Acumulado.creditos_pen.
              
       IF ver_resum
       THEN DO:
          VIEW FRAME frm-titulo-res.
          DISPLAY
             Cuenta.cdg_cuenta
             Cuenta.nombre
             lst_d_tot  WHEN lst_d_tot <> 0
             lst_c_tot  WHEN lst_c_tot <> 0
             lst_d_pen  WHEN lst_d_pen <> 0
             lst_c_pen  WHEN lst_c_pen <> 0

             WITH FRAME frm-movimiento-res.
          DOWN WITH FRAME frm-movimiento-res.
       END.
       IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
          THEN IF Acumulado.codigo_dbcr = 1 
                  THEN RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                        INPUT entidad_logon,
                                        INPUT 0 /*Obra.nro_obra*/,
                                        INPUT lst_d_pen, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0,                                         
                                        INPUT que_leyenda ).
                  ELSE RUN CREASNDT.P ( INPUT Cuenta.cdg_cuenta, 
                                        INPUT entidad_logon,
                                        INPUT 0 /*Obra.nro_obra*/,
                                        INPUT 0, 
                                        INPUT lst_c_pen, 
                                        INPUT 0, 
                                        INPUT 0, 
                                        INPUT 0,                                         
                                        INPUT que_leyenda ).

   END.

   IF ver_resum
   THEN DO:
      UNDERLINE lst_d_tot 
                lst_c_tot 
                lst_d_pen 
                lst_c_pen 
                WITH FRAME frm-movimiento-res.
      DISPLAY tgn_debitos_tot   @ lst_d_tot
              tgn_creditos_tot  @ lst_c_tot
              tgn_debitos_pen   @ lst_d_pen
              tgn_creditos_pen  @ lst_c_pen
              WITH FRAME frm-movimiento-res.
   END.


   IF gen_asiento AND (tgn_debitos_pen <> 0 OR tgn_creditos_pen <> 0)
   THEN DO:       
      RUN EMIASIEN.P.
   END.   

   OUTPUT CLOSE.
   RUN veresult.w ( INPUT arch_salida,
                    INPUT 22 ).

    
END PROCEDURE.  

PROCEDURE ACUMULAR_ENCABEZADO:

   FOR EACH Caja-imputacion WHERE Caja-imputacion.nro_transaccion = Caj_header.nro_transaccion:

        FIND FIRST Acumulado 
             WHERE Acumulado.nro_cuenta = Caja-imputacion.nro_cuenta NO-ERROR.
        IF NOT AVAILABLE Acumulado
        THEN DO:
           CREATE Acumulado.
           ASSIGN Acumulado.nro_cuenta = Caja-imputacion.nro_cuenta.
        END.
     
        IF Caj_header.tipo_mov = "E"
           THEN Acumulado.debitos  = Acumulado.debitos  + Caja-imputacion.valor.
           ELSE Acumulado.creditos = Acumulado.creditos + Caja-imputacion.valor.
     
        IF NOT Caj_header.contable 
        THEN DO:
     
           IF Caj_header.tipo_mov = "E"
              THEN Acumulado.debitos_pen  = Acumulado.debitos_pen  + Caja-imputacion.valor.
              ELSE Acumulado.creditos_pen = Acumulado.creditos_pen + Caja-imputacion.valor.
     
        END.

   END.
       
END PROCEDURE.       

PROCEDURE ACUMULAR_DETALLE:

   FIND FIRST Acumulado 
        WHERE Acumulado.nro_cuenta  = Cuenta.nro_cuenta NO-ERROR.
   IF NOT AVAILABLE Acumulado
   THEN DO:
        CREATE Acumulado.
        ASSIGN Acumulado.nro_cuenta  = Cuenta.nro_cuenta.
   END.
                
              /* Si es un egreso, la cuenta   */
              /* del detalle debe acreditarse */

   IF Caj_detalle.tipo_mov = "E"
      THEN Acumulado.creditos = Acumulado.creditos + Caj_detalle.importe.
      ELSE Acumulado.debitos  = Acumulado.debitos  + Caj_detalle.importe.
         
   IF NOT Caj_header.contable 
   THEN DO:

        IF Caj_detalle.tipo_mov = "E"
           THEN Acumulado.creditos_pen = Acumulado.creditos_pen + Caj_detalle.importe.
           ELSE Acumulado.debitos_pen  = Acumulado.debitos_pen  + Caj_detalle.importe.

   END.
       
END PROCEDURE. 
